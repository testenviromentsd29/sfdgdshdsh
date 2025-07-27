


local Keys = {
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
local ESX = nil
local reached = false
local HasAlreadyEnteredMarker, hasPaid, CurrentActionData = false, false, {}
local lastZone, CurrentAction, CurrentActionMsg
local missionVehicle = nil
local missionVehicleServer = nil
local missionVehicleModel = nil
local jobrunning = false
local garbagebag
local pickedUp = false
local askedToJoin = nil
local jobBlips = {}
local blip 


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	ESX.PlayerData = ESX.GetPlayerData()
	Wait(2000)

	RequestModel(Config.Ped.model)
	while not HasModelLoaded(Config.Ped.model) do Wait(500) end

	-- local ped = CreatePed(1, Config.Ped.model, Config.GetJobsLocation, Config.Ped.heading, false, true)
	-- SetBlockingOfNonTemporaryEvents(ped, true)
	-- SetPedDiesWhenInjured(ped, false)
	-- SetPedCanPlayAmbientAnims(ped, true)
	-- SetPedCanRagdollFromPlayerImpact(ped, false)
	-- SetEntityInvincible(ped, true)
	-- FreezeEntityPosition(ped, true)
	-- TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true);

	JobFunctions()
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if job.name ~= ESX.PlayerData.job.name then
		ClearAllBlipRoutes()
		RemoveBlip(blip)
		reached = true
	end
	ESX.PlayerData.job = job
	Wait(2000)
	JobFunctions()
end)

RegisterNetEvent('cj_Jobs:setMissionVehicle')
AddEventHandler('cj_Jobs:setMissionVehicle', function(vehicle)
	if missionVehicle == nil then
		missionVehicle = askedToJoin
		missionVehicleServer = vehicle
	end
end)

RegisterNetEvent('cj_Jobs:resetMissionVehicle')
AddEventHandler('cj_Jobs:resetMissionVehicle', function()
	missionVehicle = nil
	missionVehicleServer = nil
end)

RegisterNetEvent('cj_Jobs:isNearMissionVehicle')
AddEventHandler('cj_Jobs:isNearMissionVehicle', function()
	if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(missionVehicle), true) < 100.0 then
		ESX.ShowNotification("Garbage collected! Go to the next location!")
	else
		ESX.ShowNotification("You need to be closer to your team's vehicle to get a reward")
		TriggerServerEvent('cj_Jobs:removeGarbage')
	end
end)

AddEventHandler('cj_Jobs:hasEnteredMarker', function(zone)
	if zone == 'vehicleSpawner' then
		CurrentAction     = 'vehicleSpawner'
		CurrentActionMsg  = 'press ~INPUT_PICKUP~ to get job vehicle'
		CurrentActionData = {zone = zone}
	elseif zone == 'vehicleDeleter' then
		CurrentAction     = 'vehicleDeleter'
		CurrentActionMsg  = 'press ~INPUT_PICKUP~ to return job vehicle'
		CurrentActionData = {zone = zone}
	-- elseif zone == 'payment' then
	-- 	CurrentAction     = 'payment'
	-- 	CurrentActionMsg  = 'press ~INPUT_PICKUP~ to get paid for your work'
	-- 	CurrentActionData = {zone = zone}
	end
end)


AddEventHandler('cj_Jobs:hasExitedMarker', function(zone)
	CurrentAction = nil
	currentLocation = nil
	ESX.UI.Menu.CloseAll()
end)

Citizen.CreateThread(function()
	Wait(1000)
	while ESX == nil or ESX.PlayerData.job == nil do
		Citizen.Wait(100)
	end

	local red = 255
	local green = 0
	local blue = 0

	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(PlayerPedId())
		local letSleep = true
		-- if #(coords - Config.GetJobsLocation) < Config.DrawDistance then
		-- 	DrawMarker(1, Config.GetJobsLocation, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5,1.5,1.0, red,green,blue, 100, false, true, 2, false, nil, nil, false)
		-- 	letSleep = false
		-- end
		if Config.Jobs[ESX.PlayerData.job.name] then
			for k,v in pairs(Config.Jobs[ESX.PlayerData.job.name]) do
				local distance = #(coords - v.pos)

				if distance < Config.DrawDistance then
					letSleep = false
					if k == "vehicleSpawner" then
						DrawMarker(39, v.pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5,1.5,1.5, red,green,blue, 100, false, true, 2, false, nil, nil, false)
					-- elseif k == "payment" then
					-- 	DrawMarker(29, v.pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5,1.5,1.5, red,green,blue, 100, false, true, 2, false, nil, nil, false)
					elseif k == "vehicleDeleter" then
						DrawMarker(39, v.pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5,1.5,1.5, 200,20,50, 100, false, true, 2, false, nil, nil, false)
					else
						DrawMarker(Config.MarkerType, v.pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					end
				end
			end
		end
		
		if red == 255 and green ~= 255 and blue == 0 then
			green = green + 3
		elseif red <= 255 and red > 0 and green == 255 and blue == 0 then
			red = red - 3
		elseif red == 0 and green == 255 and blue >=0 and blue < 255 then
			blue = blue + 3
		elseif red == 0 and green <= 255 and green > 0 and blue == 255 then
			green = green - 3
		elseif red >= 0 and red < 255 and green == 0 and blue == 255 then
			red = red + 3
		elseif red == 255 and green == 0 and blue <= 255 and blue > 0 then
			blue = blue - 3
		end
		local color = 255 + (blue << 8) + (green << 16) + (red << 24)
		if jobBlips and jobBlips[1] then
			SetBlipColour(jobBlips[1],color)
		end
		if letSleep then
			Citizen.Wait(750)
		end
	end
end)

Citizen.CreateThread(function()
	Wait(1000)
	while ESX == nil or ESX.PlayerData.job == nil do
		Citizen.Wait(100)
	end

	while true do
		Citizen.Wait(500)

		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker = false
		local currentZone = true


		if Config.Jobs[ESX.PlayerData.job.name] then
			for k,v in pairs(Config.Jobs[ESX.PlayerData.job.name]) do
				local distance = #(coords - v.pos)
				if distance <  Config.Size.x then
					isInMarker  = true
					LastZone    =  currentZone
					currentZone = k
			
					if currentZone == "vehicleSpawner" and (not v.vehicles or #v.vehicles <= 0) then
						currentZone = true
					end
				end
			end
		end

		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('cj_Jobs:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			currentZone = nil
			TriggerEvent('cj_Jobs:hasExitedMarker', LastZone)
		end

		if not isInMarker then
			Wait(1000)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'vehicleSpawner' then
					SpawnVehicle()
				elseif CurrentAction == 'vehicleDeleter' then
					DeleteVeh()
				-- elseif CurrentAction == 'payment' then
				-- 	AskForPayment()

				end
				CurrentAction = nil
			end
		else
			Citizen.Wait(1150)
		end
	end
end)

local keepGoing = true


function JobFunctions()
	for k,v in pairs(jobBlips) do
		RemoveBlip(v)
	end
	-- local blip2 = AddBlipForCoord(Config.PaymentBlip)
	-- SetBlipSprite (blip2, 408)
	-- SetBlipScale  (blip2, 1.0)
	-- SetBlipColour (blip2, 20)
	-- BeginTextCommandSetBlipName("STRING")
	-- AddTextComponentString("Job Payments")
	-- EndTextCommandSetBlipName(blip2)
	-- SetBlipAsShortRange(blip2, true)
	-- table.insert(jobBlips,blip2)
	-- local blip5 = AddBlipForCoord(Config.GetJobsLocation)
	-- SetBlipSprite (blip5, 408)
	-- SetBlipScale  (blip5, 1.0)
	-- SetBlipColour (blip5, 20)
	-- BeginTextCommandSetBlipName("STRING")
	-- AddTextComponentString("Job Center")
	-- EndTextCommandSetBlipName(blip5)
	-- SetBlipAsShortRange(blip5, true)
	-- SetBlipFlashes(blip2, true)
	-- table.insert(jobBlips,blip5)
	if Config.Jobs[ESX.PlayerData.job.name] then
		if Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.pos and #Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.pos > 0 then
			local blip = AddBlipForCoord(Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.pos)
			SetBlipSprite (blip, 477)
			SetBlipScale  (blip, 1.1)
			SetBlipColour (blip, 20)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Start work / get vehicle")
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip, true)
			table.insert(jobBlips,blip)
		end

		if Config.Jobs[ESX.PlayerData.job.name].vehicleDeleter.pos --[[ and #Config.Jobs[ESX.PlayerData.job.name].vehicleDeleter.pos.pos >  0]] then
			local blip3 = AddBlipForCoord(Config.Jobs[ESX.PlayerData.job.name].vehicleDeleter.pos)
			SetBlipSprite (blip3, 477)
			SetBlipScale  (blip3, 1.1)
			SetBlipColour (blip3, 1)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Return job vehicle")
			EndTextCommandSetBlipName(blip3)
			SetBlipAsShortRange(blip3, true)
			table.insert(jobBlips,blip3)
		end
		
		if Config.Jobs[ESX.PlayerData.job.name].jobBlip then
			local blip4 = AddBlipForCoord(Config.Jobs[ESX.PlayerData.job.name].jobBlip.pos)
			SetBlipSprite (blip4, Config.Jobs[ESX.PlayerData.job.name].jobBlip.sprite)
			SetBlipScale  (blip4, 1.1)
			SetBlipColour (blip4, Config.Jobs[ESX.PlayerData.job.name].jobBlip.color)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Jobs[ESX.PlayerData.job.name].jobBlip.name)
			EndTextCommandSetBlipName(blip4)
			SetBlipAsShortRange(blip4, true)
			table.insert(jobBlips,blip4)
		end
	end
	keepGoing = false
	Wait(5000)
	-- if ESX.PlayerData.job.name == "garbage" then
	-- 	CreateThread(function()
	-- 		keepGoing = true
	-- 		while keepGoing do
	-- 			if missionVehicle == nil then
	-- 				local vehicle2 = GetVehiclePedIsIn(PlayerPedId() ,false)
	-- 				-- missionVehicle = vehicle2
	-- 				-- TriggerServerEvent('cj_Jobs:getVehicle',missionVehicle)
	-- 				-- TriggerServerEvent('cj_Jobs:startJob')
	-- 				if GetEntityModel(vehicle2) == 1917016601 then
	-- 					if askedToJoin ~= vehicle2 then
	-- 						TriggerServerEvent("cj_Jobs:getOnTeam",NetworkGetNetworkIdFromEntity(vehicle2))
	-- 						askedToJoin = vehicle2
	-- 					end
	-- 				end
	-- 			end
	-- 			Wait(2000)
	-- 		end
	-- 	end)
	-- end

end

-- function AskForPayment()
-- 	if missionVehicle then
-- 		ESX.ShowNotification("You must return your job vehicle first!")
-- 	else
-- 		TriggerServerEvent('cj_Jobs:requestPayment')
-- 	end
-- end

function SpawnVehicle()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_gargbage_actions',
	{
		title		= 'Πάρε όχημα εργασίας',
		align		= 'bottom-right',
		elements	= Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.vehicles
	}, function(data, menu)
		menu.close()
		local coords = GetEntityCoords(PlayerPedId())
		if missionVehicle == nil then
			if Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.price then
				ESX.TriggerServerCallback("cj_Jobs:payForVehicle",function(result)
					if not result then
						return
					end
					Wait(1500)
					ESX.Game.SpawnVehicle(data.current.value,
					coords, Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.heading, function(vehicle)
						SetVehicleDirtLevel(vehicle, 0)
						SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
						SetVehicleDamageModifier(missionVehicle,0.2)
						missionVehicle = vehicle
						missionVehicleModel = GetEntityModel(vehicle)
						missionVehicleServer = NetworkGetNetworkIdFromEntity(missionVehicle)
						TriggerServerEvent('cj_Jobs:getVehicle',missionVehicleServer)
						TriggerServerEvent('cj_Jobs:startJob')
						if Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.message then
							ESX.ShowNotification(Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.message)
						end
						TriggerServerEvent('carlock:addRentedCar',ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)))
						TriggerEvent('esx_carlock:addCar',ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)))
					end)
				end,Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.price)
			else
				ESX.Game.SpawnVehicle(data.current.value,
					coords, Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.heading, function(vehicle)
					SetVehicleDirtLevel(vehicle, 0)
					SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
					SetVehicleDamageModifier(missionVehicle,0.2)
					missionVehicle = vehicle
					missionVehicleModel = GetEntityModel(vehicle)
					missionVehicleServer = NetworkGetNetworkIdFromEntity(missionVehicle)
					TriggerServerEvent('cj_Jobs:getVehicle',missionVehicleServer)
					TriggerServerEvent('cj_Jobs:startJob')
					if Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.message then
						ESX.ShowNotification(Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.message)
					end
					TriggerServerEvent('carlock:addRentedCar',ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)))
					TriggerEvent('esx_carlock:addCar',ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)))
				end)
			end
		else 
			ESX.ShowNotification("You already have a job vehicle! Return it first to get a new one!")
			Wait(1000)
			ESX.ShowNotification("You can get a new vehicle but you will lose your initial deposit!")
			SpawnVehicle2()
		end
	end,function(data,menu)
		menu.close()
	end)
end

function SpawnVehicle2()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_gargbage_actions22',
	{
		title		= 'Πάρε νέο όχημα εργασίας.Θα χάσεις την καταθεση ασφαλειας που εχεις δωσει',
		align		= 'bottom-right',
		elements	= Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.vehicles
	}, function(data, menu2)
		menu2.close()
		local coords = GetEntityCoords(PlayerPedId())
		if Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.price then
			ESX.TriggerServerCallback("cj_Jobs:payForVehicle",function(result)
				if not result then
					return
				end
				Wait(1500)
				ESX.Game.SpawnVehicle(data.current.value,
				coords, Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.heading, function(vehicle)
					SetVehicleDirtLevel(vehicle, 0)
					SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
					SetVehicleDamageModifier(missionVehicle,0.2)
					missionVehicle = vehicle
					missionVehicleModel = GetEntityModel(vehicle)
					missionVehicleServer = NetworkGetNetworkIdFromEntity(missionVehicle)
					TriggerServerEvent('cj_Jobs:getVehicle',missionVehicleServer)
					TriggerServerEvent('cj_Jobs:startJob')
					if Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.message then
						ESX.ShowNotification(Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.message)
					end
					TriggerServerEvent('carlock:addRentedCar',ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)))
					TriggerEvent('esx_carlock:addCar',ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)))

				end)
			end,Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.price)
		else
			ESX.Game.SpawnVehicle(data.current.value,
				coords, Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.heading, function(vehicle)
				SetVehicleDirtLevel(vehicle, 0)
				SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
				SetVehicleDamageModifier(missionVehicle,0.2)
				missionVehicle = vehicle
				missionVehicleModel = GetEntityModel(vehicle)
				missionVehicleServer = NetworkGetNetworkIdFromEntity(missionVehicle)
				TriggerServerEvent('cj_Jobs:getVehicle',missionVehicleServer)
				TriggerServerEvent('cj_Jobs:startJob')
				if Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.message then
					ESX.ShowNotification(Config.Jobs[ESX.PlayerData.job.name].vehicleSpawner.message)
				end
				TriggerServerEvent('carlock:addRentedCar',ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)))
				TriggerEvent('esx_carlock:addCar',ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)))
			end)
		end
		menu2.close()
	end,function(data,menu2)
		menu2.close()
	end)

end


function DisableControls()
	CreateThread(function()
		while not reached do
			Wait(0)
			DisableControlAction(1,23,true)
		end
	end)
end


function DeleteVeh()
	local vehicle2 = GetVehiclePedIsIn(PlayerPedId() ,false)
	if vehicle2 and vehicle2 == missionVehicle then
		SetEntityAsMissionEntity(missionVehicle, true, true)
		DeleteVehicle(missionVehicle)
		TriggerServerEvent('cj_Jobs:returnVehicle',missionVehicleServer)
		missionVehicle = nil
		missionVehicleServer = nil
		missionVehicleModel = nil
		reached = true
		ClearAllBlipRoutes()
		RemoveBlip(blip)
	elseif vehicle2 and missionVehicleModel and missionVehicle and GetEntityModel(vehicle2) == missionVehicleModel then
		SetEntityAsMissionEntity(vehicle2, true, true)
		DeleteVehicle(vehicle2)
		TriggerServerEvent('cj_Jobs:returnVehicle',missionVehicleServer)
		missionVehicle = nil
		missionVehicleServer = nil
		missionVehicleModel = nil
		reached = true
		ClearAllBlipRoutes()
		RemoveBlip(blip)
	end
end

RegisterNetEvent('cj_Jobs:setGPS')
AddEventHandler('cj_Jobs:setGPS', function(coords)
	ESX.ShowNotification("Check your GPS for your next work location!")
	reached = true
	Wait(200)
	if ESX.PlayerData.job.name == "garbage" then
		-- Garbage(coords)
	elseif ESX.PlayerData.job.name == "gardener" then
		Gardener(coords)
	elseif ESX.PlayerData.job.name == "postman" then
		Postman(coords)
	elseif ESX.PlayerData.job.name == "poolcleaner" then
		PoolCleaner(coords)
	elseif ESX.PlayerData.job.name == "deh" then
		Deh(coords)
	end
end)

function Garbage(coords)
	pickedUp = false
	if not HasAnimDictLoaded("anim@heists@narcotics@trash") then
		RequestAnimDict("anim@heists@narcotics@trash")
	end
	while not HasAnimDictLoaded("anim@heists@narcotics@trash") do
		Citizen.Wait(0)
	end
	-- SetNewWaypoint(coords[1], coords[2])
	blip = AddBlipForCoord(coords[1], coords[2],coords[3])
	SetBlipRoute(blip,true)
	SetBlipRouteColour(blip,24)
	SetBlipSprite(blip,8)
	reached = false
	while not reached do
		Citizen.Wait(0)
		-- if pickedUp then
		-- 	SetPlayerSprint(PlayerPedId(),false)
		-- end
		local mycoords = GetEntityCoords(PlayerPedId(), true)
		if GetDistanceBetweenCoords(coords[1], coords[2], coords[3],mycoords, true) < 100.0 then
			if not pickedUp then
				DrawMarker(0, coords[1], coords[2], coords[3]+2.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.0, 50, 250, 150, 100, true, true, 2, true, false, false, false)
			end
				--===============================================
			if pickedUp then
				local taillight_r = GetWorldPositionOfEntityBone(missionVehicle, GetEntityBoneIndexByName(missionVehicle, "taillight_r"))
				local taillight_l = GetWorldPositionOfEntityBone(missionVehicle, GetEntityBoneIndexByName(missionVehicle, "taillight_l"))
				local newposx = (taillight_r.x - taillight_l.x) / 2
				local newposy = (taillight_r.y - taillight_l.y) / 2
				local playerCoords = GetEntityCoords(PlayerPedId(), false)

				DrawMarker(21, taillight_r.x - newposx , taillight_r.y - newposy, taillight_r.z+1.0, 0, 0, 0, 180.0, 0, 0, 0.8, 0.8, 0.8, 0, 200, 50, 200, true, 0, 0, 0)
				dist = Vdist(playerCoords.x, playerCoords.y, playerCoords.z,taillight_r.x - newposx , taillight_r.y - newposy, taillight_r.z)
				if dist <= 2.0 then
					if IsControlPressed(0, Keys["E"]) then
						Citizen.Wait(5)
						TaskPlayAnim(PlayerPedId(-1), 'anim@heists@narcotics@trash', 'throw_b', 0.7, -1,-1,2,0,0, 0,0)
						Citizen.Wait(100)

						Citizen.Wait(1000)
						ClearPedTasksImmediately(PlayerPedId())
						DetachEntity(garbagebag,false,false)
						Wait(100)
						DeleteEntity(garbagebag)
						ESX.TriggerServerCallback("cj_Jobs:collectGarbage",function(result) end)
						-- TriggerServerEvent("cj_Jobs:collectGarbage")
						reached = true
					end
				end
			end

			if GetDistanceBetweenCoords(coords[1], coords[2], coords[3],mycoords, true) < 5.0 and not pickedUp then
				if IsControlPressed(0, Keys["E"]) then

					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(missionVehicle), true) < 30.0 then
						local playerPed = PlayerPedId()
						if IsPedSittingInAnyVehicle(playerPed) then
							ESX.ShowNotification("Get out of your vehicle to pick up the trash")
							Wait(1000)
						else
							pickedUp = true
							-- exports['progressBars']:startUI(7000, "Picking up trash..")
							TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)

							Wait(3000)
							ClearPedTasksImmediately(PlayerPedId())

							garbagebag = CreateObject(GetHashKey("prop_cs_street_binbag_01"), 0, 0, 0, true, true, true)
							AttachEntityToEntity(garbagebag, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
							
						end
					else
						ESX.ShowNotification("You need your mission vehicle nearby!")
					end


				end
			end
		end
	end
	ClearAllBlipRoutes()
	RemoveBlip(blip)
end


function Gardener(coords)
	local working =false
	-- SetNewWaypoint(coords[1], coords[2])
	blip = AddBlipForCoord(coords[1], coords[2],coords[3])
	SetBlipRoute(blip,true)
	SetBlipRouteColour(blip,24)
	SetBlipSprite(blip,8)
	reached = false
	while not reached do
		Citizen.Wait(0)
		-- if pickedUp then
		-- 	SetPlayerSprint(PlayerPedId(),false)
		-- end
		local mycoords = GetEntityCoords(PlayerPedId(), true)
		if GetDistanceBetweenCoords(coords[1], coords[2], coords[3],mycoords, true) < 100.0 then
			if not working then
				DrawMarker(0, coords[1], coords[2], coords[3]+2.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.0, 50, 250, 150, 100, true, true, 2, true, false, false, false)
			end
				--===============================================
			if GetDistanceBetweenCoords(coords[1], coords[2], coords[3],mycoords, true) < 10.0 and not working then
				if IsControlPressed(0, Keys["E"]) then

					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(missionVehicle), true) < 40.0 then
						local playerPed = PlayerPedId()
						if IsPedSittingInAnyVehicle(playerPed) then
							ESX.ShowNotification("Get out of your vehicle first!")
							Wait(1000)
						else
							working = true
							-- exports['progressBars']:startUI(7000, "Picking up trash..")
							local cSCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
							local vassouspawn = CreateObject(GetHashKey("prop_tool_broom"), cSCoords.x, cSCoords.y, cSCoords.z, 1, 1, 1)
							local netid = ObjToNet(vassouspawn)
							local vassour_net
							ESX.Streaming.RequestAnimDict("amb@world_human_janitor@male@idle_a", function()
								TaskPlayAnim(PlayerPedId(), "amb@world_human_janitor@male@idle_a", "idle_a", 8.0, -8.0, -1, 0, 0, false, false, false)
								AttachEntityToEntity(vassouspawn,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
								vassour_net = netid
							end)
							DisableControls()

							Wait(10000)
							ClearPedTasks(PlayerPedId())
							TaskPedSlideToCoord(PlayerPedId(),mycoords[1]+2,mycoords[2]+3,mycoords[3],100.0,3.0)
							Wait(3000)
							if not IsPedMale(PlayerPedId()) then
								ESX.Streaming.RequestAnimDict("amb@world_human_janitor@male@idle_a", function()
									TaskPlayAnim(PlayerPedId(), "amb@world_human_janitor@male@idle_a", "idle_a", 8.0, -8.0, -1, 0, 0, false, false, false)
								end)
								Wait(10000)
								disable_actions = false
								DetachEntity(NetToObj(vassour_net), 1, 1)
								DeleteEntity(NetToObj(vassour_net))
								vassour_net = nil
								ClearPedTasks(PlayerPedId())
							else
								disable_actions = false
								DetachEntity(NetToObj(vassour_net), 1, 1)
								DeleteEntity(NetToObj(vassour_net))
								vassour_net = nil
								ClearPedTasks(PlayerPedId())
								TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_LEAF_BLOWER", 0, true)
								-- 	object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(prop_leaf_blower_01), false, false, false)
								-- end
								Wait(10000)
								ClearPedTasks(PlayerPedId())
								local object = GetClosestObjectOfType(GetEntityCoords(PlayerPedId(), true), 15.0, GetHashKey("prop_leaf_blower_01"), false, false, false)
								-- while object ~= 0 do
								SetEntityAsMissionEntity(object)
								DeleteObject(object)
							end
							
							reached = true
							ESX.TriggerServerCallback("cj_Jobs:collect",function(result) end)
							
						end
					else
						ESX.ShowNotification("You need your mission vehicle nearby!")
						Wait(1000)
					end


				end
			end
		else
			Wait(500)
		end
	end
	ClearAllBlipRoutes()
	RemoveBlip(blip)
end

function Postman(coords)
	local working =false
	-- SetNewWaypoint(coords[1], coords[2])
	blip = AddBlipForCoord(coords[1], coords[2],coords[3])
	SetBlipRoute(blip,true)
	SetBlipRouteColour(blip,24)
	SetBlipSprite(blip,8)
	reached = false
	while not reached do
		Citizen.Wait(0)
		-- if pickedUp then
		-- 	SetPlayerSprint(PlayerPedId(),false)
		-- end
		local mycoords = GetEntityCoords(PlayerPedId(), true)
		if GetDistanceBetweenCoords(coords[1], coords[2], coords[3],mycoords, true) < 100.0 then
			if not working then
				DrawMarker(0, coords[1], coords[2], coords[3]+2.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.0, 50, 250, 150, 100, true, true, 2, true, false, false, false)
			end
				--===============================================
			if GetDistanceBetweenCoords(coords[1], coords[2], coords[3],mycoords, true) < 2.0 and not working then
				if IsControlPressed(0, Keys["E"]) then

					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(missionVehicle), true) < 40.0 then
						local playerPed = PlayerPedId()
						if IsPedSittingInAnyVehicle(playerPed) then
							ESX.ShowNotification("Get out of your vehicle first!")
							Wait(1000)
						else
							working = true
							-- exports['progressBars']:startUI(7000, "Picking up trash..")
							DisableControls()
							ExecuteCommand("e mechanic")
							FreezeEntityPosition(PlayerPedId(), true)
							Wait(5000)
							FreezeEntityPosition(PlayerPedId(), false)
							ExecuteCommand("e c")							
							reached = true
							ESX.TriggerServerCallback("cj_Jobs:collect",function(result) end)
							
						end
					else
						ESX.ShowNotification("You need your mission vehicle nearby!")
						Wait(1000)
					end


				end
			end
		else
			Wait(500)
		end
	end
	ClearAllBlipRoutes()
	RemoveBlip(blip)
end

function PoolCleaner(coords)
	local working =false
	-- SetNewWaypoint(coords[1], coords[2])
	blip = AddBlipForCoord(coords[1], coords[2],coords[3])
	SetBlipRoute(blip,true)
	SetBlipRouteColour(blip,24)
	SetBlipSprite(blip,8)
	reached = false
	while not reached do
		Citizen.Wait(0)
		-- if pickedUp then
		-- 	SetPlayerSprint(PlayerPedId(),false)
		-- end
		local mycoords = GetEntityCoords(PlayerPedId(), true)
		if GetDistanceBetweenCoords(coords[1], coords[2], coords[3],mycoords, true) < 100.0 then
			if not working then
				DrawMarker(0, coords[1], coords[2], coords[3]+2.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.0, 50, 250, 150, 100, true, true, 2, true, false, false, false)
			end
				--===============================================
			if GetDistanceBetweenCoords(coords[1], coords[2], coords[3],mycoords, true) < 10.0 and not working then
				if IsControlPressed(0, Keys["E"]) then

					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(missionVehicle), true) < 60.0 then
						local playerPed = PlayerPedId()
						if IsPedSittingInAnyVehicle(playerPed) then
							ESX.ShowNotification("Get out of your vehicle first!")
							Wait(1000)
						else
							working = true
							-- exports['progressBars']:startUI(7000, "Picking up trash..")
							local cSCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
							local vassouspawn = CreateObject(GetHashKey("prop_tool_broom"), cSCoords.x, cSCoords.y, cSCoords.z, 1, 1, 1)
							local netid = ObjToNet(vassouspawn)
							local vassour_net
							ESX.Streaming.RequestAnimDict("amb@world_human_janitor@male@idle_a", function()
								TaskPlayAnim(PlayerPedId(), "amb@world_human_janitor@male@idle_a", "idle_a", 8.0, -8.0, -1, 0, 0, false, false, false)
								AttachEntityToEntity(vassouspawn,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
								vassour_net = netid
							end)
							
							DisableControls()

							Wait(10000)
							ClearPedTasks(PlayerPedId())
							TaskPedSlideToCoord(PlayerPedId(),mycoords[1]+2,mycoords[2]+3,mycoords[3],100.0,3.0)
							Wait(3000)
							if not IsPedMale(PlayerPedId()) then
								ESX.Streaming.RequestAnimDict("amb@world_human_janitor@male@idle_a", function()
									TaskPlayAnim(PlayerPedId(), "amb@world_human_janitor@male@idle_a", "idle_a", 8.0, -8.0, -1, 0, 0, false, false, false)
								end)
								Wait(10000)
								disable_actions = false
								DetachEntity(NetToObj(vassour_net), 1, 1)
								DeleteEntity(NetToObj(vassour_net))
								vassour_net = nil
								ClearPedTasks(PlayerPedId())
							else
								disable_actions = false
								DetachEntity(NetToObj(vassour_net), 1, 1)
								DeleteEntity(NetToObj(vassour_net))
								vassour_net = nil
								ClearPedTasks(PlayerPedId())
								TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_LEAF_BLOWER", 0, true)
								-- 	object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(prop_leaf_blower_01), false, false, false)
								-- end
								Wait(10000)
								ClearPedTasks(PlayerPedId())
								local object = GetClosestObjectOfType(GetEntityCoords(PlayerPedId(), true), 15.0, GetHashKey("prop_leaf_blower_01"), false, false, false)
								-- while object ~= 0 do
								SetEntityAsMissionEntity(object)
								DeleteObject(object)
							end
							reached = true
							
							ESX.TriggerServerCallback("cj_Jobs:collect",function(result) end)
							
						end
					else
						ESX.ShowNotification("You need your mission vehicle nearby!")
						Wait(1000)
					end


				end
			end
		else
			Wait(500)
		end
	end
	ClearAllBlipRoutes()
	RemoveBlip(blip)
end

function Deh(coords)
	local working =false
	-- SetNewWaypoint(coords[1], coords[2])
	blip = AddBlipForCoord(coords[1], coords[2],coords[3])
	SetBlipRoute(blip,true)
	SetBlipRouteColour(blip,24)
	SetBlipSprite(blip,8)
	reached = false
	while not reached do
		Citizen.Wait(0)
		-- if pickedUp then
		-- 	SetPlayerSprint(PlayerPedId(),false)
		-- end
		local mycoords = GetEntityCoords(PlayerPedId(), true)
		if GetDistanceBetweenCoords(coords[1], coords[2], coords[3],mycoords, true) < 100.0 then
			if not working then
				DrawMarker(0, coords[1], coords[2], coords[3]+2.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.0, 50, 250, 150, 100, true, true, 2, true, false, false, false)
			end
				--===============================================
			if GetDistanceBetweenCoords(coords[1], coords[2], coords[3],mycoords, true) < 6.0 and not working then
				if IsControlPressed(0, Keys["E"]) then

					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(missionVehicle), true) < 60.0 then
						local playerPed = PlayerPedId()
						if IsPedSittingInAnyVehicle(playerPed) then
							ESX.ShowNotification("Get out of your vehicle first!")
							Wait(1000)
						else
							working = true
							TriggerEvent('vMenu:enableMenu', false)
							exports['progressBars']:startUI(10000, "Fixing the lamp..")
							TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_HAMMERING', 0, true)
							
							-- ExecuteCommand("e hammer")

							Wait(10000)
							ClearPedTasks(PlayerPedId())
							Wait(3000)
							
							disable_actions = false
							reached = true
							ESX.TriggerServerCallback("cj_Jobs:collect",function(result) end)
							TriggerEvent('vMenu:enableMenu', true)
						end
					else
						ESX.ShowNotification("You need your mission vehicle nearby!")
						Wait(1000)
					end
				end
			end
		else
			Wait(500)
		end
	end
	ClearAllBlipRoutes()
	RemoveBlip(blip)
end