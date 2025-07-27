Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

gotVehicleData = false
closeToVehicles = false
isUiOpen = false
isTestDriving = false
areaData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	
	ESX.PlayerData = ESX.GetPlayerData()
	
	for k,v in pairs(Config.Positions) do
		vehicle_obj_per_position[k] = {}
	end
	
	Wait(500)
	CreateBlips()
	GenerateAreas()
	DistanceCheck()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx_vehicleseller:getVehs')
AddEventHandler('esx_vehicleseller:getVehs', function(data)
	vehicles_for_sale_per_steam = data
	gotVehicleData = true
end)

RegisterNetEvent('esx_vehicleseller:update')
AddEventHandler('esx_vehicleseller:update', function(action,arg1,arg2,arg3,arg4,arg5)
	if action == "add" then
		local steam = arg1
		local vehicle_obj = arg2
		
		if vehicles_for_sale_per_steam[steam] == nil then
			vehicles_for_sale_per_steam[steam] = {}
		end
		
		vehicles_for_sale_per_steam[steam][vehicle_obj.plate] = vehicle_obj
		vehicle_obj.veh_data = json.decode(vehicle_obj.veh_data)
		local position_obj = Config.Positions[tonumber(vehicle_obj.location)][tonumber(vehicle_obj.position)]
		vehicle_obj_per_position[tonumber(vehicle_obj.location)][tonumber(vehicle_obj.position)] = vehicle_obj
		vehicles_for_sale_per_plate[tostring(vehicle_obj.plate)] = vehicle_obj
		
		if ESX.Game.IsSpawnPointClear(position_obj.coords, 2.0) then
			ESX.Game.SpawnLocalVehicle(vehicle_obj.veh_data.model, position_obj.coords, position_obj.heading, function(veh) 
				FreezeEntityPosition(veh, true)
				SetVehicleUndriveable(veh, true)
				ESX.Game.SetVehicleProperties(veh, vehicle_obj.veh_data)
				SetVehicleNumberPlateText(veh, vehicle_obj.plate)
				SetEntityInvincible(veh,true)
				table.insert(spawned_vehicles,veh)
			end)
		end
	elseif action == "remove" then
		local owner = arg1
		local plate = arg2
		local veh_data = arg3
		
		local buyersteam = arg4
		local veh_obj = arg5
		local position_index = veh_obj.position
		local location_index = veh_obj.location
		local position_obj = Config.Positions[location_index][position_index]
		
		vehicle_obj_per_position[location_index][tonumber(position_index)] = nil
		vehicles_for_sale_per_steam[owner][plate] = nil
		
		if selected_vehicle_entity == nil then
			local vehicles_in_area = ESX.Game.GetVehiclesInArea(position_obj.coords, 500)
			
			for i,veh_entity in pairs(vehicles_in_area) do
				if string.gsub(GetVehicleNumberPlateText(veh_entity)," ","") == string.gsub(veh_obj.plate," ","") then
					selected_vehicle_entity = veh_entity
					break
				end
			end
		end
		
		if selected_vehicle_entity and DoesEntityExist(selected_vehicle_entity) then
			DeleteEntity(selected_vehicle_entity)
			selected_vehicle_entity = nil
			vehicles_for_sale_per_plate[tostring(plate)] = nil
			
			if buyersteam == ESX.PlayerData.identifier then
				local tmpveh
				
				ESX.Game.SpawnVehicle(veh_data.model, position_obj.coords, position_obj.heading, function(veh) 
					tmpveh = veh
				end)
				
				local start = GetGameTimer()/1000
				
				while tmpveh == nil or not DoesEntityExist(tmpveh) do
					if GetGameTimer()/1000 - start >= 5 then
						break
					end
					
					Wait(0)
				end
				
				ESX.Game.SetVehicleProperties(tmpveh, veh_data)
				SetPedIntoVehicle(PlayerPedId(), tmpveh, -1)
			end
		end
	end
end)

AddEventHandler("onResourceStop",function(resource)
	if resource == GetCurrentResourceName() then
		for i,veh in pairs(spawned_vehicles) do
			if DoesEntityExist(veh) then
				DeleteEntity(veh)
			end
		end
	end
end)

RegisterNUICallback("buy", function()
	SetNuiFocus(false, false)
	isUiOpen = false

	if selected_vehicle_object and selected_vehicle_position then
		local vehicle_obj = selected_vehicle_object
		local vehicle_pos = selected_vehicle_position
		local vehicle_entity = selected_vehicle_entity
		
		if DoesEntityExist(vehicle_entity) then
			local props = ESX.Game.GetVehicleProperties(vehicle_entity)
			props.model = vehicle_obj.veh_data.model
			local plate = props.plate
			props = json.encode(props)
			
			TriggerServerEvent("esx_vehicleseller:buyvehicle", props,plate)
		end
		
		selected_vehicle_position = nil
		selected_vehicle_object = nil
	end
end)

RegisterNUICallback("testdrive", function()
	SetNuiFocus(false, false)
	isUiOpen = false

	if selected_vehicle_object and selected_vehicle_position then
		local vehicle_obj = selected_vehicle_object
		local vehicle_pos = selected_vehicle_position
		local vehicle_entity = selected_vehicle_entity
		
		if DoesEntityExist(vehicle_entity) then
			local props = ESX.Game.GetVehicleProperties(vehicle_entity)
			props.model = vehicle_obj.veh_data.model
			local plate = props.plate
			props = json.encode(props)
			
			if not isTestDriving then
				TriggerServerEvent("esx_vehicleseller:testdrive", props,plate)
			end
		end
		
		selected_vehicle_position = nil
		selected_vehicle_object = nil
	end
end)

RegisterNUICallback("quit", function()
	SetNuiFocus(false, false)
	isUiOpen = false
end)

RegisterNetEvent('esx_vehicleseller:testdrive')
AddEventHandler('esx_vehicleseller:testdrive', function(props,coords)
	isTestDriving = true
	props = json.decode(props)
	
	local testdriveobj = Config.TestDrive
	local endTimer = GetGameTimer() + testdriveobj.seconds*1000
	local secondsLeft = math.ceil((endTimer - GetGameTimer())/1000)
	
	local blip = AddBlipForRadius(testdriveobj.coords, testdriveobj.range)
	SetBlipColour(blip, 8)
	SetBlipAlpha(blip, 128)
	
	SetEntityCoords(PlayerPedId(), testdriveobj.coords)
	Wait(500)
	
	ESX.Game.SpawnVehicle(props.model, testdriveobj.coords, testdriveobj.heading, function(vehicle)
		ESX.Game.SetVehicleProperties(vehicle, props)
		SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
		
		Citizen.CreateThread(function()
			while isTestDriving do
				local vehCoords = GetEntityCoords(PlayerPedId())
				ESX.Game.Utils.DrawText3D(vector3(vehCoords.x, vehCoords.y, vehCoords.z + 1.0), 'Timeleft: ~r~'..secondsLeft, 2, 4)
				Wait(0)
			end
		end)
		
		while endTimer > GetGameTimer() and DoesEntityExist(vehicle) and not IsEntityDead(PlayerPedId()) do
			secondsLeft = math.ceil((endTimer - GetGameTimer())/1000)
			
			if #(GetEntityCoords(PlayerPedId()) - testdriveobj.coords) > testdriveobj.range then
				SetPedCoordsKeepVehicle(PlayerPedId(), testdriveobj.coords)
			end
			
			if GetVehiclePedIsIn(PlayerPedId(), false) == 0 and DoesEntityExist(vehicle) then
				SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
			end
			
			Wait(1000)
		end
		
		if DoesEntityExist(vehicle) then
			DeleteEntity(vehicle)
		end
		
		if DoesBlipExist(blip) then
			RemoveBlip(blip)
		end
		
		ClearPedTasksImmediately(PlayerPedId())
		SetEntityCoords(PlayerPedId(), coords)
		
		isTestDriving = false
	end)
end)

RegisterNetEvent('esx_contract:getVehicle')
AddEventHandler('esx_contract:getVehicle', function()
	local coords = GetEntityCoords(PlayerPedId())
	local closestPlayer, playerDistance = ESX.Game.GetClosestPlayer()
	
	if closestPlayer ~= -1 and playerDistance <= 3.0 then
		local vehicle = ESX.Game.GetClosestVehicle(coords)
		
		if DoesEntityExist(vehicle) and #(coords - GetEntityCoords(vehicle)) <= 3 then
			local vehProps = ESX.Game.GetVehicleProperties(vehicle)
			local model = GetEntityModel(vehicle)
			if Config.BlacklistModels[model] then
				ESX.ShowNotification("You can't transfer this vehicle")
				return
			end
			ESX.ShowNotification('Δινεις το οχημα με πινακιδα '..vehProps.plate)
			
			local price = tonumber(exports['dialog']:Create('Ποσο θελεις να το πουλησεις?', 'Δινεις το οχημα με πινακιδα '..vehProps.plate).value) or -1
			local priceType = exports['dialog']:Create('Γραψε με πιο τυπου νομισματος θελεις να πληρωσεις?', 'bank</br>black_money</br>coins').value
			
			if price >= 0 and priceType and (priceType == 'bank' or priceType == 'black_money' or priceType == 'coins') and DoesEntityExist(vehicle) and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(vehicle)) <= 3 then
				TriggerServerEvent('esx_contract:getVehicle', GetPlayerServerId(closestPlayer), vehProps.plate, math.floor(price), priceType, NetworkGetNetworkIdFromEntity(vehicle))
			end
		else
			ESX.ShowNotification('Δεν υπαρχει αμαξι κοντα')
		end
	else
		ESX.ShowNotification('Κανενας κοντα')
	end
end)

RegisterNetEvent('esx_contract:askBuyer')
AddEventHandler('esx_contract:askBuyer', function(seller, plate, price, priceType)
	local title = 'Buy vehicle with plate: '..plate..' for '..ESX.Math.GroupDigits(price)..' '..priceType
	local sellerTxt = GetPlayerName(GetPlayerFromServerId(seller))..' ['..seller..']'

	ExecuteCommand('ids')
	
	if exports['dialog']:Decision(title, 'Seller: '..sellerTxt, '', 'YES', 'NO').action == 'submit' then
		TriggerServerEvent('used_car_dealer:sellVehicle', seller)
	end
end)

-------------------------------------------------------------------------------
RegisterNetEvent('esx_contract:getVehicleTRD')
AddEventHandler('esx_contract:getVehicleTRD', function()
	local coords = GetEntityCoords(PlayerPedId())
	local closestPlayer, playerDistance = ESX.Game.GetClosestPlayer()
	
	if closestPlayer ~= -1 and playerDistance <= 3.0 then
		local vehicle = ESX.Game.GetClosestVehicle(coords)
		
		if DoesEntityExist(vehicle) and #(coords - GetEntityCoords(vehicle)) <= 3 then
			local vehProps = ESX.Game.GetVehicleProperties(vehicle)
			
			if Config.BlacklistModels[GetEntityModel(vehicle)] then
				ESX.ShowNotification("You can't transfer this vehicle")
				return
			end
			
			local coords2 = GetEntityCoords(GetPlayerPed(closestPlayer))
			local vehicle2 = ESX.Game.GetClosestVehicle(coords2)
			
			if DoesEntityExist(vehicle2) and #(coords2 - GetEntityCoords(vehicle2)) <= 3 then
				local vehProps2 = ESX.Game.GetVehicleProperties(vehicle2)
				
				if Config.BlacklistModels[GetEntityModel(vehicle2)] then
					ESX.ShowNotification("You can't transfer this vehicle")
					return
				end
				
				if vehProps.plate == vehProps2.plate then
					ESX.ShowNotification("Same vehicles detected")
					return
				end
				
				if exports['dialog']:Decision('Θέλεις να κάνεις trade?', vehProps.plate..' for '..vehProps2.plate, '', 'ΝΑΙ', 'ΟΧΙ').action == 'submit' then
					TriggerServerEvent('esx_contract:getVehicleTRD', GetPlayerServerId(closestPlayer), vehProps.plate, vehProps2.plate)
				end
			end
		else
			ESX.ShowNotification('Δεν υπαρχει αμαξι κοντα')
		end
	else
		ESX.ShowNotification('Κανενας κοντα')
	end
end)

RegisterNetEvent('esx_contract:askBuyerTRD')
AddEventHandler('esx_contract:askBuyerTRD', function(seller, plate, plate2)
	local title = 'Trade vehicle with plate: '..plate2..' for vehicle with plate '..plate
	
	if exports['dialog']:Decision(title, 'Are you sure?', '', 'YES', 'NO').action == 'submit' then
		TriggerServerEvent('used_car_dealer:sellVehicleTRD', seller)
	end
end)