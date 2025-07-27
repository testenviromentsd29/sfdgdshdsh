vehicles_for_sale_per_steam = {}
spawned_vehicles = {}
vehicle_obj_per_position = {}
vehicles_for_sale_per_plate = {}

currentArea = -1
selected_vehicle_position = -1
selected_vehicle_object = nil
selected_vehicle_entity = nil
isOnVehicleSell = false

function spawnLocalVehicles(location_index)
	for steam , vehicles in pairs(vehicles_for_sale_per_steam) do
		for plate,obj in pairs(vehicles or {}) do
			if vehicles and type(vehicles[plate].veh_data) == 'string' then
				vehicles[plate].veh_data = json.decode(vehicles[plate].veh_data)
			end
			
			if vehicles[plate].location == location_index and Config.Positions[location_index][tonumber(obj.position)] then
				local position_obj = Config.Positions[location_index][tonumber(obj.position)]
				vehicle_obj_per_position[location_index][tonumber(obj.position)] = obj
				vehicles_for_sale_per_plate[tostring(obj.plate)] = obj
				if ESX.Game.IsSpawnPointClear(position_obj.coords, 2.0) then
					ESX.Game.SpawnLocalVehicle(obj.veh_data.model, position_obj.coords, position_obj.heading, function(veh) 
						FreezeEntityPosition(veh, true)
						SetVehicleUndriveable(veh, true)
						ESX.Game.SetVehicleProperties(veh, obj.veh_data)
						SetVehicleNumberPlateText(veh, obj.plate)
						table.insert(spawned_vehicles,veh)
						SetEntityInvincible(veh,true)
					end)
				end
			end
		end
	end
end

function startTracing(location_index)
	CreateThread(function()
		while closeToVehicles do
			local vehicle = getVehicleInDirection()
			
			if vehicle ~= nil then
				local plate = GetVehicleNumberPlateText(vehicle)
				local tmp = ''
				
				for i = 1, #plate-1 do
					local c = plate:sub(i,i)
					tmp = tmp..c
				end
				plate = tmp
				
				if DoesEntityExist(vehicle) and vehicles_for_sale_per_plate[plate] then
					local x,y,z = table.unpack(GetEntityCoords(vehicle))
					DrawMarker(3,vector3(x,y,z+1.0) , 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.5, 0.7, 0.1, 0, 255, 0, (100), false, true, (2), true, false, false, false)
					ESX.Game.Utils.DrawText3D(vector3(x,y,z+1.5), "Press [~r~E~w~] to Check Vehicle", 1, 4)

					if IsControlJustPressed(0, Keys["E"]) and not isUiOpen then
						local position_index,position_obj = getPosition(location_index)
						
						if position_obj then
							local vehicle_obj = vehicle_obj_per_position[location_index][position_index]
							
							if vehicle_obj and GetEntityModel(vehicle) == vehicle_obj.veh_data.model then
								selected_vehicle_position = position_index
								selected_vehicle_object = vehicle_obj
								selected_vehicle_entity = vehicle
								local turbo = [[<table>
									<tr>
										<td><img style="width:50px;" src="./images/turbo.png"/></td>
										<td>
										<div id="title"><i class="fab fa-gripfire"></i> TURBO</div>
										<span id="turbo-inactive">INACTIVE</span>
										</td>
									</tr>
								</table>]]
								if IsToggleModOn(vehicle, 18) then
									turbo = [[<table>
										<tr>
											<td><img style="width:50px;" src="./images/turbo.png"/></td>
											<td>
											<div id="title"><i class="fab fa-gripfire"></i> TURBO</div>
											<span id="turbo-active">ACTIVE</span>
											</td>
										</tr>
									</table>]]
								end
								SetVehicleModKit(vehicle, 0)
								local numOfEngine = GetNumVehicleModData(vehicle,11)
								local currEngine = GetVehicleMod(vehicle,11)
								local engineHTML = "STOCK"
								
								if currEngine == numOfEngine and numOfEngine ~= -1 then
									engineHTML = "MAX LEVEL"
								elseif currEngine > -1 then
									engineHTML = "LEVEL "..currEngine+1
								end
								
								local numOfbrakes = GetNumVehicleModData(vehicle,12)
								local currbrakes = GetVehicleMod(vehicle,12)
								local brakesHTML = "STOCK"
								
								if currbrakes == numOfbrakes and numOfbrakes ~= -1 then
									brakesHTML = "MAX LEVEL"
								elseif currbrakes > -1 then
									brakesHTML = "LEVEL "..currbrakes+1
								end
								
								local numOftransmission = GetNumVehicleModData(vehicle,13)
								local currtransmission = GetVehicleMod(vehicle,13)
								local transmissionHTML = "STOCK"
								
								if currtransmission == numOftransmission and numOftransmission ~= -1 then
									transmissionHTML = "MAX LEVEL"
								elseif currtransmission > -1 then
									transmissionHTML = "LEVEL "..currtransmission+1
								end
								
								local numOfsuspension = GetNumVehicleModData(vehicle,15)
								local currsuspension = GetVehicleMod(vehicle,15)
								local suspensionHTML = "STOCK"
								
								if currsuspension == numOfsuspension and numOfsuspension ~= -1 then
									suspensionHTML = "MAX LEVEL"
								elseif currsuspension > -1 then
									suspensionHTML = "LEVEL "..currsuspension+1
								end
								
								local veh_name = GetDisplayNameFromVehicleModel(vehicle_obj.veh_data.model)
								
								local data = {
									action = "show",
									label = veh_name,
									plate = string.upper(GetVehicleNumberPlateText(vehicle)),
									owner = vehicle_obj.firstName.." "..vehicle_obj.lastName,
									price = vehicle_obj.price,
									price_type = vehicle_obj.price_type,
									fuel = math.floor(GetVehicleFuelLevel(vehicle)),
									turbo = turbo,
									engine = math.floor(GetVehicleEngineHealth(vehicle)/10),
									engineKit = engineHTML,
									brakeKit = brakesHTML,
									transmissionKit = transmissionHTML,
									suspensionKit = suspensionHTML,
								}
								
								SendNUIMessage(data)
								SetNuiFocus(true, true)
								isUiOpen = true
							end
						end
					end
				end
			end
			
			Wait(0)
		end
	end)
end

function startDrawing(location_index)
	CreateThread(function()
		while closeToVehicles do
			local shouldDisplay = (Config.AreaZones[location_index].setjob and Config.AreaZones[location_index].setjob == ESX.PlayerData.job.name or Config.AreaZones[location_index].setjob == nil)
			
			if shouldDisplay then
				for index = 1, #Config.Positions[location_index] do
					local position_obj = Config.Positions[location_index][index]
					
					if vehicle_obj_per_position[location_index][tonumber(index)] == nil then
						ESX.Game.Utils.DrawText3D(vector3(position_obj.coords.x, position_obj.coords.y, position_obj.coords.z + 2), Config.DrawText3D, 2, 4)
						DrawMarker(Config.MarkerType, position_obj.coords.x, position_obj.coords.y, position_obj.coords.z + 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColour.r, Config.MarkerColour.g, Config.MarkerColour.b, 100, false, true, 2, false, false, false, false)
						
						if IsControlJustPressed(0, Keys["E"]) then
							local position_index,position_obj = getPosition(location_index)
							if position_obj and vehicle_obj_per_position[location_index][tonumber(position_index)] == nil then
								startVehicleSell(location_index)
							end
						end
					end
				end
			else
				Wait(500)
			end
			
			Wait(0)
		end
	end)
end

function getVehicleInDirection()
    local inDirection  = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
    local rayHandle    = StartShapeTestRay(GetEntityCoords(PlayerPedId()), inDirection, 10, PlayerPedId(), 0)
    local numRayHandle, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)

    if hit == 1 and GetEntityType(entityHit) == 2 then
        return entityHit
    end

    return nil
end

function getPosition(location_index) -- vres to position pou sou eisai pio konta.. kai an einai eisai < 5 yards kane to return
    local coords = GetEntityCoords(PlayerPedId())
    local min = 9999
    local index_pos = -1
    local pos = nil
    local distance = 99999
    for i,position in pairs(Config.Positions[location_index]) do
        local dist = #(coords - position.coords)
        if dist < min then
            min = dist
            index_pos = i
            pos = position
            distance = dist
        end
    end
    if distance < 10 then
        return index_pos,pos
    else
        return nil
    end
end

function GetNumVehicleModData(vehicle, modType)
	SetVehicleModKit(vehicle, 0)

	if (modType == 'plateIndex') then
		return 5
	elseif (modType == 'color1') then
		return 0
	elseif (modType == 'color2') then
		return 0
	elseif (modType == 'wheelColor') then
		return 0
	elseif (modType == 'pearlescentColor') then
		return 0
	elseif (modType == 'tyreSmokeColor') then
		return 0
	elseif (modType == 'neonColor') then
		return 0
	elseif (modType == 'dashboardColor') then
		return 0
	elseif (modType == 'interiorColor') then
		return 0
	elseif (modType == 'paintType1' or modType == 'paintType2') then
		return 5
	elseif (modType == 'windowTint') then
		return GetNumVehicleWindowTints(vehicle) - 1
	elseif (modType == 'modXenon') then
		return 12
	elseif (modType == 'livery') then
		return GetVehicleLiveryCount(vehicle) - 1
	elseif (modType == 'extras') then
		local tempCount = -1
		for id = 0, 25, 1 do
			if (DoesExtraExist(vehicle, id)) then
				tempCount = tempCount + 1
			end
		end
		return tempCount
	elseif (type(modType) == 'number' and modType >= 17 and modType <= 22) then
		return 0
	elseif (type(modType) == 'number') then
		return GetNumVehicleMods(vehicle, modType) - 1
	end

	return -1
end


function startVehicleSell(location_index)
	isOnVehicleSell = true

	ESX.TriggerServerCallback('esx_vehicleseller:retrieveMyVehicles', function(rows) 
		local elements = {}
		for i,row in pairs(rows) do
			local veh_data = json.decode(row.vehicle)
			if IsModelInCdimage(veh_data.model) then

				local veh_name = GetDisplayNameFromVehicleModel(veh_data.model)
				local plate = row.plate
				table.insert(elements, { label = veh_name.." Plate: "..plate, model = veh_data.model, plate = plate } )

			end
		end
		if #elements > 0 then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'owned_vehicles',
			{
				title		= "Owned Vehicles",
				align		= 'bottom-right',
				elements    =  elements
				
			}, function(data, menu)
				local plate = data.current.plate
				local model = data.current.model

				if not Config.BlacklistModels[model] then
					local elements2 = {}

					table.insert(elements2,{label = "Sell for <font color='green'>money</font>", value = "clean"})
					
					if Config.AreaZones[location_index].setjob == nil then
						table.insert(elements2,{label = "Sell for <font color='red'>black money</font>", value = "black"})
						table.insert(elements2,{label = "Sell for <font color='yellow'>donate coins</font>", value = "dc"})
					end
					
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'price_type',
					{
						title		= "Enter Price",
						align		= 'bottom-right',
						elements    =  elements2
						
					}, function(data, menu)
						local price_type = data.current.value
						ESX.UI.Menu.Open(
						'dialog', GetCurrentResourceName(), 'price_veh_dialog',
						{
							title = "Enter Amount"
						},
						function(data, menu)
							local price = data.value
							
							if price ~= nil and tonumber(price) > 0 then
								price = tonumber(price)
								
								ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'days_dialog', {
									title = "Enter Days To Rent (Price per day: "..Config.PricePerDay.."$"
								}, function(data, menu)
									local days = data.value
									
									if days ~= nil and tonumber(days) > 0 then
										days = tonumber(days)
										
										if days <= Config.MaxDays then
											local position_index,position_obj = getPosition(location_index)
											TriggerServerEvent("esx_vehicleseller:sellvehicle",plate,price,price_type,days,position_index,location_index)
											isOnVehicleSell = false
											ESX.UI.Menu.CloseAll()
										else
											ESX.ShowNotification("Max days : "..Config.MaxDays)
										end
									else
										ESX.ShowNotification("Wrong Number")
									end
								end,
								function(data, menu)
									menu.close()
								end)
							else
								ESX.ShowNotification("Wrong Number")
							end
						end,
						function(data, menu)
							menu.close()
						end)
					end,
					function(data,menu)
						menu.close()
					end)
				else
					ESX.ShowNotification("You can't sell this vehicle")
				end
			end,
			function(data,menu)
				isOnVehicleSell = false
				menu.close()
			end)
		else
			ESX.ShowNotification("You don't own any vehicles")
			isOnVehicleSell = false
		end
	end)

	while isOnVehicleSell do
		Wait(0)
	end
end

function CreateBlips()
	for k,v in pairs(Config.AreaZones) do
		if Config.Blips[k] then
			local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite(blip, Config.Blips[k].sprite)
			SetBlipScale(blip, Config.Blips[k].scale)
			SetBlipColour(blip, Config.Blips[k].color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Blips[k].name)
			EndTextCommandSetBlipName(blip)
		end
	end
end

function DistanceCheck()
	CreateThread(function()
		while not gotVehicleData do
			Wait(100)
		end
		
		while true do
			for k,v in pairs(Config.AreaZones) do
				local inArea = IsInArea(k)
				
				if not closeToVehicles and inArea then
					currentArea = k
					closeToVehicles = true
					startTracing(k)
					startDrawing(k)
					spawnLocalVehicles(k)
				elseif not inArea and currentArea == k then
					currentArea = -1
					closeToVehicles = false
					
					for i,veh in pairs(spawned_vehicles) do
						if DoesEntityExist(veh) then
							DeleteEntity(veh)
						end
					end
				end
			end
			
			Wait(5000)
		end
	end)
end

function IsInArea(id)
	local coords = GetEntityCoords(PlayerPedId())
	local AM = vector2(coords.x - areaData[id].A.x, coords.y - areaData[id].A.y)
	local AM_AB = DotProduct(AM, areaData[id].AB)
	local AM_AC = DotProduct(AM, areaData[id].AC)
	
	if AM_AB < 0 or AM_AB > areaData[id].AB2 or AM_AC < 0 or AM_AC > areaData[id].AC2 then
		return false
	else
		return true
	end
end

function DotProduct(vec1,vec2)
	return (vec1.x*vec2.x) + (vec1.y*vec2.y)
end

function GenerateAreas()
	for k,v in pairs(Config.AreaZones) do
		areaData[k] = {coords = vector3(v.x, v.y, v.z), rot = v.rot, size = v.size}
		
		areaData[k].corners = {}
		
		local rot = math.rad(areaData[k].rot)
		local HalfAreaSize = areaData[k].size/2
		
		areaData[k].corners[1] = areaData[k].coords + vector3(math.cos(rot)*areaData[k].size - math.sin(rot)*HalfAreaSize, math.sin(rot)*areaData[k].size + math.cos(rot)*HalfAreaSize, 0.0)
		areaData[k].corners[2] = areaData[k].coords - vector3(math.cos(rot)*areaData[k].size - math.sin(rot)*HalfAreaSize, math.sin(rot)*areaData[k].size + math.cos(rot)*HalfAreaSize, 0.0)
		areaData[k].corners[3] = areaData[k].coords - vector3(math.cos(rot)*areaData[k].size + math.sin(rot)*HalfAreaSize, math.sin(rot)*areaData[k].size - math.cos(rot)*HalfAreaSize, 0.0)
		areaData[k].corners[4] = areaData[k].coords + vector3(math.cos(rot)*areaData[k].size + math.sin(rot)*HalfAreaSize, math.sin(rot)*areaData[k].size - math.cos(rot)*HalfAreaSize, 0.0)
		
		for a,b in pairs(areaData[k].corners) do
			areaData[k].corners[a] = vector3(areaData[k].corners[a].x, areaData[k].corners[a].y, areaData[k].corners[a].z)
		end
		
		areaData[k].AB = vector2(areaData[k].corners[1].x - areaData[k].corners[3].x,areaData[k].corners[1].y - areaData[k].corners[3].y)
		areaData[k].AC = vector2(areaData[k].corners[2].x - areaData[k].corners[3].x,areaData[k].corners[2].y - areaData[k].corners[3].y)
		areaData[k].AB2 = math.ceil(DotProduct(areaData[k].AB, areaData[k].AB))
		areaData[k].AC2 = math.ceil(DotProduct(areaData[k].AC, areaData[k].AC))
		
		areaData[k].A = areaData[k].corners[3]
		areaData[k].B = areaData[k].corners[1]
		areaData[k].C = areaData[k].corners[2]
		areaData[k].D = areaData[k].corners[4]
		
		--[[areaData[k].blip = AddBlipForArea(areaData[k].coords.x, areaData[k].coords.y, areaData[k].coords.z, areaData[k].size*2, areaData[k].size)
		SetBlipRotation(areaData[k].blip, areaData[k].rot)
		
		SetBlipColour(areaData[k].blip, 2)
		SetBlipAlpha(areaData[k].blip, 128)]]
	end
end