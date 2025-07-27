ESX = nil

local inZone = nil
local isBusy = false
local spawnedObjects = {}
local onGoingCapture = {}
local capturedFields = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	InitScript()
end)

RegisterNetEvent('drugs_v2:enteredZone')
AddEventHandler('drugs_v2:enteredZone', function(id, isEntering, _onGoingCapture, _capturedFields)
	if isEntering then
		inZone = id
		onGoingCapture = _onGoingCapture
		capturedFields = _capturedFields

		ProcessLocation(id)
	else
		inZone = nil

		onGoingCapture = {}
		capturedFields = {}
	end
end)

RegisterNetEvent('drugs_v2:startCapture')
AddEventHandler('drugs_v2:startCapture', function(id, data)
	if inZone then
		onGoingCapture[id] = data
	end
end)

RegisterNetEvent('drugs_v2:endCapture')
AddEventHandler('drugs_v2:endCapture', function(id, data)
	if inZone then
		onGoingCapture[id] = nil

		if data then
			capturedFields[id] = data
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		DeleteProps()
	end
end)

function InitScript()
	for k,v in pairs(Config.Locations) do
		if v.blip then
			local blip = AddBlipForCoord(v.coords)
			SetBlipSprite(blip, v.blip.sprite)
			SetBlipScale(blip, v.blip.scale)
			SetBlipColour(blip, v.blip.color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString(v.label)
			EndTextCommandSetBlipName(blip)
		end
		
		if v.blipRadius and v.radius > 0 then
			local blip = AddBlipForRadius(v.coords, v.radius)
			SetBlipHighDetail(blip, true)
			SetBlipColour(blip, v.blipRadius.color)
			SetBlipDisplay(blip, 4)
			SetBlipAlpha(blip, v.blipRadius.alpha)
		end
	end

	Citizen.CreateThread(function()
		while true do
			local coords = GetEntityCoords(PlayerPedId())

			for k,v in pairs(Config.Locations) do
				if #(coords - v.coords) < v.radius then
					if not inZone then
						TriggerServerEvent('drugs_v2:enteredZone', k, true)
						Wait(1000)

						break
					end
				else
					if (inZone or -1) == k then
						TriggerServerEvent('drugs_v2:enteredZone', k, false)
						Wait(1000)

						break
					end
				end
			end
			
			Wait(1500)
		end
	end)
end

function ProcessLocation(id)
	Citizen.CreateThread(function()
		local npc = CreateStaticNPC(Config.Locations[id].npc.model, Config.Locations[id].npc.coords, Config.Locations[id].npc.heading)
		local drawTxtCoords = vector3(Config.Locations[id].npc.coords.x, Config.Locations[id].npc.coords.y, Config.Locations[id].npc.coords.z + 1.2)

		while inZone do
			local wait = 500
			local distance = #(GetEntityCoords(PlayerPedId()) - Config.Locations[id].npc.coords)

			if distance < 15.0 then
				wait = 0
				ESX.Game.Utils.DrawText3D(drawTxtCoords, '~g~'..Config.Locations[id].label, 1.2, 4)

				if distance < 1.2 then
					ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to talk')
					
					if IsControlJustReleased(0, 38) then
						TriggerServerEvent('drugs_v2:talk', id)
						Wait(1000)
					end
				end
			end
			
			Wait(wait)
		end

		if DoesEntityExist(npc) then
			DeleteEntity(npc)
		end
	end)

	Citizen.CreateThread(function()
		SpawnProps(id)

		while inZone do
			local coords = GetEntityCoords(PlayerPedId())

			for k,v in pairs(spawnedObjects) do
				if #(coords - v.coords) < 1.2 then
					ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to gather')
					
					if IsControlJustReleased(0, 38) then
						StartGathering(id, k)
					end
				end
			end

			Wait(0)
		end

		DeleteProps()
	end)

	Citizen.CreateThread(function()
		while inZone do
			local txt = ''
			local wait = 250

			if onGoingCapture[id] then
				local seconds = onGoingCapture[id].timestamp - GlobalState.date.timestamp
				local timeTxt = seconds > 0 and (('%02d:%02d'):format(math.floor(seconds/60), math.floor(seconds%60))) or '00:00'

				txt = txt..'Timeleft: '..timeTxt..'\n'
			end

			if string.len(txt) > 0 then
				wait = 0
				DrawText2(0.01, 0.35, 0.75, '~HUD_COLOUR_GREEN~'..txt)
			end
			
			Wait(wait)
		end
	end)
end

function StartGathering(k, x)
	if not IsPedOnFoot(PlayerPedId()) or GetEntitySpeed(PlayerPedId()) > 2.0 then
		return
	end

	if isBusy then
		return
	end

	isBusy = true

	local timeout = GetGameTimer() + 3000
	
	if not IsLookingAtCoords(GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), spawnedObjects[x].coords, 30.0) then
		TaskTurnPedToFaceEntity(PlayerPedId(), spawnedObjects[x].object, -1)
		
		while not IsLookingAtCoords(GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), spawnedObjects[x].coords, 30.0) do
			Wait(100)
			
			if not GetIsTaskActive(PlayerPedId(), 225) or timeout < GetGameTimer() then
				isBusy = false
				ClearPedTasks(PlayerPedId())

				return
			end
		end

		ClearPedTasks(PlayerPedId())
	end

	ExecuteCommand('e mechanic3')

	TriggerEvent('mythic_progressbar:client:progress', {
		name = 'gathering',
		duration = Config.Locations[k].duration*1000,
		label = 'Gathering...',
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
	}, function(cancelled)
		if not cancelled then
			if DoesEntityExist(spawnedObjects[x].object) then
				DeleteEntity(spawnedObjects[x].object)
			end

			spawnedObjects[x] = nil
			TriggerServerEvent('drugs_v2:gather', k)

			if CountProps() == 0 then
				Wait(1000)
				SpawnProps(k)
			end
		end
		
		ExecuteCommand('e c')
		Wait(1000)
		isBusy = false
	end)
end

function SpawnProps(id)
	local k = id
	local v = Config.Locations[id]

	for i=1, v.dimensionsX do
		for j=1, v.dimensionsY do
			local coords = GetOffsetFromCoordsInWorldCoords(v.coords, v.heading, (i - 1) * v.distance, (j - 1) * v.distance, 0.0)
			local object = CreateObject2(v.prop, coords.x, coords.y, coords.z)

			if v.offset then
				coords = GetOffsetFromEntityInWorldCoords(object, v.offset.x, v.offset.y, v.offset.z)
				SetEntityCoordsNoOffset(object, coords)
			end

			spawnedObjects[k..i..j] = {object = object, coords = coords}
		end
	end
end

function GetOffsetFromCoordsInWorldCoords(entityCoords, heading, offsetX, offsetY, offsetZ)
    -- Convert heading to radians
    local headingRadians = math.rad(heading)

    -- Calculate the offset based on the entity's orientation
    local offsetXWorld = offsetX * math.cos(headingRadians) - offsetY * math.sin(headingRadians)
    local offsetYWorld = offsetX * math.sin(headingRadians) + offsetY * math.cos(headingRadians)
    
    -- Apply the offset to the entity's world coordinates
    local offsetCoords = vector3(entityCoords.x + offsetXWorld, entityCoords.y + offsetYWorld, entityCoords.z + offsetZ)
    
    return offsetCoords
end

function IsLookingAtCoords(entityCoords, entityHeading, targetCoords, maxAngle)
    -- Calculate vector from entity position to target position
    --local directionVector = vector3(targetCoords.x - entityCoords.x, targetCoords.y - entityCoords.y, targetCoords.z - entityCoords.z)
    local directionVector = vector3(targetCoords.x - entityCoords.x, targetCoords.y - entityCoords.y, 0.0)

    -- Calculate heading direction vector based on entity heading
    local headingVector = vector3(-math.sin(math.rad(entityHeading)), math.cos(math.rad(entityHeading)), 0.0)

    -- Calculate the dot product of the two vectors
    local dotProduct = directionVector.x * headingVector.x + directionVector.y * headingVector.y + directionVector.z * headingVector.z

    -- Calculate the magnitudes of the vectors
    local directionMagnitude = math.sqrt(directionVector.x * directionVector.x + directionVector.y * directionVector.y + directionVector.z * directionVector.z)
    local headingMagnitude = math.sqrt(headingVector.x * headingVector.x + headingVector.y * headingVector.y + headingVector.z * headingVector.z)

    -- Calculate the angle between the direction vector and heading vector (in radians)
    local angle = math.acos(dotProduct / (directionMagnitude * headingMagnitude))

    -- Convert angle to degrees
    angle = math.deg(angle)

    -- Check if the angle is within the acceptable range
    return angle <= maxAngle
end

function CountProps()
	local count = 0

	for k,v in pairs(spawnedObjects) do
		if DoesEntityExist(v.object) then
			count = count + 1
		end
	end

	return count
end

function DeleteProps()
	for k,v in pairs(spawnedObjects) do
		DeleteEntity(v.object)
	end

	spawnedObjects = {}
end

function CreateObject2(model, x, y, z)
	RequestModel(model)
	while not HasModelLoaded(model) do Wait(0) end
	
	local object = CreateObject(model, x, y, z, false, false, false)
	FreezeEntityPosition(object, true)
	PlaceObjectOnGroundProperly(object)
	
	SetModelAsNoLongerNeeded(model)
	
	return object
end

function DrawText2(x, y, scale, text)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(scale, scale)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry('STRING')
	AddTextComponentString(text)
	DrawText(x, y)
end

function CreateStaticNPC(model, coords, heading)
	RequestModel(model)
	while not HasModelLoaded(model) do Wait(0) end
	
	local npc = CreatePed(5, model, coords.x, coords.y, coords.z - 1.0, heading, false, true)
	SetPedDefaultComponentVariation(npc)
	SetEntityHeading(npc, heading)
	FreezeEntityPosition(npc, true)
	SetEntityInvincible(npc, true)
	SetBlockingOfNonTemporaryEvents(npc, true)
	
	SetModelAsNoLongerNeeded(model)
	
	return npc
end

exports('InZone', function()
	if inZone then
		return true
	end

	return false
end)