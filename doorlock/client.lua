ESX = nil

local cooldown = 0
local currentJob = ''
local dataLoaded = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Wait(100)
	end
	
	currentJob = ESX.GetPlayerData().job.name
	
	Wait(math.random(1000, 2000))
	
	ESX.TriggerServerCallback('esx_doorlock:getLockStatus', function(locked)
		for id,state in pairs(locked) do
			if SavedDoors[id] then
				SavedDoors[id].locked = state
			end
		end
		
		dataLoaded = true
		InitScript()
	end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	currentJob = job.name
end)

RegisterNetEvent('doorlock:add')
AddEventHandler('doorlock:add', function(id, data)
	if not dataLoaded then
		return
	end
	
	SavedDoors[id] = data
end)

RegisterNetEvent('doorlock:remove')
AddEventHandler('doorlock:remove', function(id)
	if not dataLoaded then
		return
	end

	if #(GetEntityCoords(PlayerPedId()) - SavedDoors[id].doors[1].objCoords) < 50.0 then
		for k,v in pairs(SavedDoors[id].doors) do
			local door = GetClosestObjectOfType(v.objCoords, 1.0, v.objName, false, false, false)
			
			if DoesEntityExist(door) then
				FreezeEntityPosition(door, false)
			end
		end
	end

	SavedDoors[id] = nil
end)

RegisterNetEvent('doorlock:updateState')
AddEventHandler('doorlock:updateState', function(id, state)
	if not dataLoaded then
		return
	end
	
	SavedDoors[id].locked = state
	
	if #(GetEntityCoords(PlayerPedId()) - SavedDoors[id].doors[1].objCoords) < 50.0 then
		for k,v in pairs(SavedDoors[id].doors) do
			local door = GetClosestObjectOfType(v.objCoords, 1.0, v.objName, false, false, false)
			
			if DoesEntityExist(door) then
				if state then
					FreezeEntityPosition(door, true)
				else
					FreezeEntityPosition(door, false)
				end
			end
		end
	end
end)

function InitScript()
	local doorsNear = {}
	
	Citizen.CreateThread(function()
		while true do
			for k,v in pairs(SavedDoors) do
				local coords = GetEntityCoords(PlayerPedId())
				local distance = #(coords - v.doors[1].objCoords)
				
				if distance < 50.0 then
					doorsNear[k] = true
					
					for x,y in pairs(v.doors) do
						local door = GetClosestObjectOfType(y.objCoords, 1.0, y.objName, false, false, false)
						
						if DoesEntityExist(door) then
							if v.locked then
								FreezeEntityPosition(door, true)
							else
								FreezeEntityPosition(door, false)
							end
						end
					end
				else
					doorsNear[k] = nil
				end
				
				--Wait(20)
			end
			
			Wait(1000)
		end
	end)
	
	Citizen.CreateThread(function()
		while true do
			local wait = 500
			local closestDoor = nil
			local cloestDistance = 9999.0
			
			for k,v in pairs(doorsNear) do
				if SavedDoors[k] then
					local coords = GetEntityCoords(PlayerPedId())
					local distance = #(coords - SavedDoors[k].doors[1].objCoords)
					
					if distance < SavedDoors[k].distance then
						wait = 0
						DrawText3Ds(SavedDoors[k].textCoords.x, SavedDoors[k].textCoords.y, SavedDoors[k].textCoords.z, SavedDoors[k].locked and 'Locked' or 'Unlocked')
						
						if distance < cloestDistance then
							closestDoor = k
							cloestDistance = distance
						end
					end
				end
			end
			
			if closestDoor then
				if IsControlJustReleased(0, 38) then
					if HasAccess(closestDoor) then
						if cooldown < GetGameTimer() then
							cooldown = GetGameTimer() + 500
							TriggerServerEvent('doorlock:updateState', closestDoor, SavedDoors[closestDoor].locked)
						end
					end
				end
			end
			
			Wait(wait)
		end
	end)
end

function HasAccess(id)
	for k,v in pairs(SavedDoors[id].authorizedJobs) do
		if currentJob == v then
			return true
		end
	end
	
	return false
end

RegisterCommand('doorlock', function(source, args)
	if ESX.GetPlayerData().group ~= 'superadmin' then
		return
	end
	
	local job = args[1]
	local distance = args[2]
	
	if job == nil or distance == nil then
		ESX.ShowNotification('Usage: doorlock [job] [distance]')
		return
	end
	
	local helpNotification = ''
	
	helpNotification = helpNotification..'~INPUT_PICKUP~ Select Door\n'
	helpNotification = helpNotification..'~INPUT_FRONTEND_PAUSE_ALTERNATE~ Cancel\n'
	
	while true do
		DisableControlAction(0, 200, true)
		
		ESX.ShowHelpNotification(helpNotification)
		
		local found, door = GetEntityPlayerIsFreeAimingAt(PlayerId())
		
		if DoesEntityExist(door) and GetEntityType(door) == 3 then
			DrawEntityBoundingBox(door, 255, 0, 255, 50)
			
			if IsControlJustReleased(0, 38) then
				local coords = GetEntityCoords(door)
				
				local info = {}
				
				info.textCoords = coords
				info.authorizedJobs = {[1] = job}
				info.locked = true
				info.size = 1
				info.distance = distance*1.0
				info.doors = {
					{
						objName = GetEntityModel(door),
						objCoords = coords
					}
				}
				
				TriggerServerEvent('doorlock:add', info)
				
				break
			end
		end
		
		if IsDisabledControlJustReleased(0, 200) then
			break
		end
		
		Wait(0)
	end
end)

RegisterCommand('deletedoorlock', function(source, args)
	if ESX.GetPlayerData().group ~= 'superadmin' then
		return
	end
	
	local helpNotification = ''
	
	helpNotification = helpNotification..'~INPUT_PICKUP~ Select Door\n'
	helpNotification = helpNotification..'~INPUT_FRONTEND_PAUSE_ALTERNATE~ Cancel\n'
	
	while true do
		DisableControlAction(0, 200, true)
		
		ESX.ShowHelpNotification(helpNotification)
		
		local _, door = GetEntityPlayerIsFreeAimingAt(PlayerId())
		
		if DoesEntityExist(door) and GetEntityType(door) == 3 then
			DrawEntityBoundingBox(door, 255, 0, 255, 50)
			
			if IsControlJustReleased(0, 38) then
				local found = false
				local model = GetEntityModel(door)
				local coords = GetEntityCoords(door)
				
				for k,v in pairs(SavedDoors) do
					for x,y in pairs(v.doors) do
						if #(y.objCoords - coords) < 3.0 and model == y.objName then
							found = true
							TriggerServerEvent('doorlock:remove', k)
							
							break
						end
					end
					
					if found then
						break
					end
				end
				
				break
			end
		end
		
		if IsDisabledControlJustReleased(0, 200) then
			break
		end
		
		Wait(0)
	end
end)

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 370
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry('STRING')
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	DrawRect(_x,_y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 30)
end

function DrawEntityBoundingBox(entity, r, g, b, a)
	local box = GetEntityBoundingBox(entity)
	DrawBoundingBox(box, r, g, b, a)
end

function GetEntityBoundingBox(entity)
	local pad = 0.001
	local min, max = GetModelDimensions(GetEntityModel(entity))
	
	local retval = {
		GetOffsetFromEntityInWorldCoords(entity, min.x - pad, min.y - pad, min.z - pad),
		GetOffsetFromEntityInWorldCoords(entity, max.x + pad, min.y - pad, min.z - pad),
		GetOffsetFromEntityInWorldCoords(entity, max.x + pad, max.y + pad, min.z - pad),
		GetOffsetFromEntityInWorldCoords(entity, min.x - pad, max.y + pad, min.z - pad),
		GetOffsetFromEntityInWorldCoords(entity, min.x - pad, min.y - pad, max.z + pad),
		GetOffsetFromEntityInWorldCoords(entity, max.x + pad, min.y - pad, max.z + pad),
		GetOffsetFromEntityInWorldCoords(entity, max.x + pad, max.y + pad, max.z + pad),
		GetOffsetFromEntityInWorldCoords(entity, min.x - pad, max.y + pad, max.z + pad)
	}
	
	return retval
end

function DrawBoundingBox(box, r, g, b, a)
	local polyMatrix = GetBoundingBoxPolyMatrix(box)
	local edgeMatrix = GetBoundingBoxEdgeMatrix(box)

	DrawPolyMatrix(polyMatrix, r, g, b, a)
	DrawEdgeMatrix(edgeMatrix, 255, 0, 255, 255)
end

function GetBoundingBoxPolyMatrix(box)
	local test = {
		{box[3], box[2], box[1]},
		{box[4], box[3], box[1]},
		{box[5], box[6], box[7]},
		{box[5], box[7], box[8]},
		{box[3], box[4], box[7]},
		{box[8], box[7], box[4]},
		{box[1], box[2], box[5]},
		{box[6], box[5], box[2]},
		{box[2], box[3], box[6]},
		{box[3], box[7], box[6]},
		{box[5], box[8], box[4]},
		{box[5], box[4], box[1]}
	}
	
	return test
end

function GetBoundingBoxEdgeMatrix(box)
	local test = {
		{box[1], box[2]},
		{box[2], box[3]},
		{box[3], box[4]},
		{box[4], box[1]},
		{box[5], box[6]},
		{box[6], box[7]},
		{box[7], box[8]},
		{box[8], box[5]},
		{box[1], box[5]},
		{box[2], box[6]},
		{box[3], box[7]},
		{box[4], box[8]}
	}
	
	return test
end

function DrawPolyMatrix(polyCollection, r, g, b, a)
	for k,poly in pairs(polyCollection) do
		local x1 = poly[1].x
		local y1 = poly[1].y
		local z1 = poly[1].z
		
		local x2 = poly[2].x
		local y2 = poly[2].y
		local z2 = poly[2].z
		
		local x3 = poly[3].x
		local y3 = poly[3].y
		local z3 = poly[3].z
		
		DrawPoly(x1, y1, z1, x2, y2, z2, x3, y3, z3, r, g, b, a)
	end
end

function DrawEdgeMatrix(linesCollection, r, g, b, a)
	for _,line in pairs(linesCollection) do
		local x1 = line[1].x
		local y1 = line[1].y
		local z1 = line[1].z
		
		local x2 = line[2].x
		local y2 = line[2].y
		local z2 = line[2].z
		
		DrawLine(x1, y1, z1, x2, y2, z2, r, g, b, a)
	end
end

_b = {}
RegisterCommand("debugnogozones", function ()
	for i=1,#_b do
		RemoveBlip(_b[i])
	end
	_b = {}
	for k,v in pairs(noGoZones) do
		local blip = AddBlipForRadius(v.coords, v.radius)
		SetBlipColour(blip, 1)
		SetBlipAlpha(blip, 128)
		table.insert(_b, blip)
	end
end)

_lastOutsideCoords = vector3(0.0,0.0,0.0)
Citizen.CreateThread(function()
	while true do
		Wait(0)
		_lastOutsideCoords = GetEntityCoords(PlayerPedId())
		if group == "user" then
			for k,v in pairs(noGoZones) do
				if #(GetEntityCoords(PlayerPedId())- v.coords) < v.radius then
					if noGoZones[k].allowedToGoIn ~= currentJob then
						while #(GetEntityCoords(PlayerPedId())-  v.coords) < v.radius do
							Wait(1000)
							DisableAllControlActions(0)
						
							
	
							local isDriver = false
							local vehicle = GetVehiclePedIsIn(PlayerPedId())
							if vehicle ~= 0 then
								local tmpPed = GetPedInVehicleSeat(vehicle, math.floor(-1))
								if tmpPed == PlayerPedId() then
									isDriver = true
								end
							end
							if not isDriver then
								TaskGoStraightToCoord(
									PlayerPedId(), 
									_lastOutsideCoords.x,
									_lastOutsideCoords.y, 
									_lastOutsideCoords.z, 
									1.0 --[[ number ]], 
									-1 --[[ integer ]], 
									10.0 --[[ number ]], 
									1.0 --[[ number ]]
								)
							else
								DoScreenFadeOut(1000)
								Citizen.Wait(1000)
								ClearPedTasksImmediately(PlayerPedId())
								SetEntityCoords(PlayerPedId(),_lastOutsideCoords, 0.0, 0.0, 0.0, false)
								
								SetEntityCoords(vehicle,_lastOutsideCoords, 0.0, 0.0, 0.0, false)
								Wait(20)
								
								if IsVehicleSeatFree(vehicle,math.floor(-1)) then
									SetPedIntoVehicle(PlayerPedId(),vehicle,math.floor(-1))
								end
								DoScreenFadeIn(1000)
							end
	
	
	
	
	
	
	
							
							if  #(GetEntityCoords(PlayerPedId())-  v.coords) < v.radius + 10 then
								Wait(5000)
							end
	
						end
						Wait(2000)
					end
					
				end
			end
		end
		
	end
end)



local times = {}
local oldCoords = {}
Citizen.CreateThread(function()
    while true do
        Wait(15000)
        times = {}
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local veh = GetGamePool("CVehicle")
        for i=1, #veh do
            if DoesEntityExist(veh[i]) and #(GetEntityCoords(veh[i]) - GetEntityCoords(PlayerPedId())) < 50 and GetPedInVehicleSeat(veh[i], math.floor(-1)) == 0 then
                local coords = GetEntityCoords(veh[i])
                if oldCoords[veh[i]] then
                    if #(coords - oldCoords[veh[i]]) > 0.001 and #(coords - oldCoords[veh[i]]) < 0.01 then
                        times[veh[i]] = (times[veh[i]] or 0) + 1
                        if times[veh[i]] > 50 then
                            local netId = NetworkGetNetworkIdFromEntity(veh[i])
                            TriggerServerEvent("doorlock:iaaa", netId)
                            Wait(1000)
                        end
                        Wait(200)
                    end
                end
                oldCoords[veh[i]] = coords
            else
                times[veh[i]] = nil
                oldCoords[veh[i]] = nil
            end
        end
    end
end)


RegisterNetEvent('doorlock:set')
AddEventHandler('doorlock:set', function()
	Citizen.CreateThread(function()
		local now = GetGameTimer() + 10000
		local coords = GetEntityCoords(PlayerPedId())
		while GetGameTimer() < now do
			SetEntityCoords(PlayerPedId(), coords)
			Wait(0)
		end
	end)
end)
