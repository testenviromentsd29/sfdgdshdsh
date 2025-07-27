ESX = nil

local npcs = {}
local blips = {}
local radiusBlips = {}
local onGoingCrates = {}
local crateObjects = {}
local crateParticles = {}
local inZone = {}
local isBusy = false

GlobalState.inCratedropV2 = nil

for k,v in pairs(Config.Crates) do
	onGoingCrates[k] = {phase = 0}
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	InitScript()
end)

function InitScript()
	for k,v in pairs(Config.Crates) do
		local blip = AddBlipForCoord(v.npc.coords)
		SetBlipSprite(blip, 478)
		SetBlipColour(blip, 39)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(v.label)
		EndTextCommandSetBlipName(blip)
	end
	
	Citizen.CreateThread(function()
		while true do
			local wait = 1500
			local coords = GetEntityCoords(PlayerPedId())
			
			for k,v in pairs(Config.Crates) do
				if #(coords - v.npc.coords) < 50.0 then
					if not DoesEntityExist(npcs[k]) then
						npcs[k] = CreateStaticNPC(k)
					end
					
					if #(coords - v.npc.coords) < 1.2 then
						wait = 0
						ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to start ~o~'..v.label)
						
						if IsControlJustReleased(0, 38) then
							TriggerServerEvent('cratedrop_v2:start', k)
							Wait(1000)
						end
					end
				else
					if DoesEntityExist(npcs[k]) then
						DeleteEntity(npcs[k])
					end
				end
			end
			
			Wait(wait)
		end
	end)
end

RegisterNetEvent('cratedrop_v2:sendData')
AddEventHandler('cratedrop_v2:sendData', function(data)
	onGoingCrates = data
	
	for crateId,v in pairs(onGoingCrates) do
		if v.phase > 0 then
			ProcessCrate(crateId, v.locId)
		end
	end
end)

RegisterNetEvent('cratedrop_v2:enteredZone')
AddEventHandler('cratedrop_v2:enteredZone', function(crateId, data, isEntering)
	if isEntering then
		inZone[crateId] = true
		GlobalState.inCratedropV2 = crateId
		onGoingCrates[crateId] = data
		
		ProcessScoreboard(crateId, data.timeDrop)
		
		if DoesBlipExist(radiusBlips[crateId]) then
			SetBlipColour(radiusBlips[crateId], 5)
		end
		
		if onGoingCrates[crateId].phase > 1 then
			if DoesParticleFxLoopedExist(crateParticles[crateId]) then
				StopParticleFxLooped(crateParticles[crateId], 0)
			end
			
			crateParticles[crateId] = CreateCrateParticle(crateId, onGoingCrates[crateId].locId)
		end
		
		if onGoingCrates[crateId].phase == 3 then
			if DoesEntityExist(crateObjects[crateId]) then
				DeleteEntity(crateObjects[crateId])
			end
			
			crateObjects[crateId] = CreateCrateObject(crateId, onGoingCrates[crateId].locId)
		end
		
		ESX.ShowNotification('You entered the '..crateId..' Crate')
	else
		inZone[crateId] = nil
		GlobalState.inCratedropV2 = nil
		
		if DoesBlipExist(radiusBlips[crateId]) then
			SetBlipColour(radiusBlips[crateId], 1)
		end
		
		if DoesParticleFxLoopedExist(crateParticles[crateId]) then
			StopParticleFxLooped(crateParticles[crateId], 0)
		end
		
		if DoesEntityExist(crateObjects[crateId]) then
			DeleteEntity(crateObjects[crateId])
		end
		
		ESX.ShowNotification('You left the '..crateId..' Crate')
	end
end)

RegisterNetEvent('cratedrop_v2:start')
AddEventHandler('cratedrop_v2:start', function(crateId, locId, timeDrop)
	onGoingCrates[crateId].phase = 1
	onGoingCrates[crateId].locId = locId
	onGoingCrates[crateId].timeDrop = timeDrop
	
	ProcessCrate(crateId, locId)
end)

RegisterNetEvent('cratedrop_v2:end')
AddEventHandler('cratedrop_v2:end', function(crateId)
	onGoingCrates[crateId] = {phase = 0}
end)

RegisterNetEvent('cratedrop_v2:startDrop')
AddEventHandler('cratedrop_v2:startDrop', function(crateId, locId)
	onGoingCrates[crateId].phase = 2
	onGoingCrates[crateId].locId = locId
	
	if not inZone[crateId] then
		return
	end
	
	local crateLoc = Config.Crates[crateId].locations[locId]
	
	crateParticles[crateId] = CreateCrateParticle(crateId, onGoingCrates[crateId].locId, 0.0, 0.0, 0.0)
	
	local crateModel = GetHashKey('prop_box_wood02a_pu')
	
	RequestModel(crateModel)
	while not HasModelLoaded(crateModel) do Wait(0) end
	
	local crate = CreateObject(crateModel, crateLoc.coords.x, crateLoc.coords.y, crateLoc.coords.z + 100.0, false, true)
	SetEntityCanBeDamaged(crate, false)
	SetEntityLodDist(crate, 200)
	ActivatePhysics(crate)
	SetDamping(crate, 2, 0.1)
	SetEntityVelocity(crate, 0.0, 0.0, -0.5)
	
	SetModelAsNoLongerNeeded(crateModel)
	
	local paraModel = GetHashKey('p_cargo_chute_s')
	
	RequestModel(paraModel)
	while not HasModelLoaded(paraModel) do Wait(0) end
	
	local parachute = CreateObject(paraModel, crateLoc.coords.x, crateLoc.coords.y, crateLoc.coords.z + 100.0, false, true)
	SetEntityLodDist(parachute, 200)
	SetEntityVelocity(parachute, 0.0, 0.0, -0.5)
	SetEntityCollision(parachute, false, true)
	
	SetModelAsNoLongerNeeded(paraModel)
	
	AttachEntityToEntity(parachute, crate, 0, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
	
	local timeout = GetGameTimer() + 12000
	
	while not HasObjectBeenBroken(crate) and timeout > GetGameTimer() do
		Wait(100)
	end
	
	if DoesEntityExist(parachute) then
		DeleteEntity(parachute)
	end
	
	Wait(1000)
	
	if DoesEntityExist(crate) then
		DeleteEntity(crate)
	end
	
	if DoesParticleFxLoopedExist(particle) then
		StopParticleFxLooped(particle, 0)
	end
end)

RegisterNetEvent('cratedrop_v2:endDrop')
AddEventHandler('cratedrop_v2:endDrop', function(crateId, locId)
	onGoingCrates[crateId].phase = 3
	onGoingCrates[crateId].locId = locId
	
	if not inZone[crateId] then
		return
	end
	
	crateObjects[crateId] = CreateCrateObject(crateId, onGoingCrates[crateId].locId)
end)

RegisterNetEvent('cratedrop_v2:scoreboard')
AddEventHandler('cratedrop_v2:scoreboard', function(data, identifier)
	local scoreboard = {}
	
	for k,v in pairs(data) do
		table.insert(scoreboard, {name = v.name, kills = v.kills, identifier = k})
	end
	
	table.sort(scoreboard, function(a,b) return a.kills > b.kills end)
	
	SendNUIMessage({
		action = 'show',
		scoreboard = scoreboard,
		kills = data[identifier] and data[identifier].kills or 0
	})
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k,v in pairs(npcs) do
			if DoesEntityExist(v) then
				DeleteEntity(v)
			end
		end
		
		for k,v in pairs(crateObjects) do
			if DoesEntityExist(v) then
				DeleteEntity(v)
			end
		end
	end
end)

function ProcessCrate(crateId, locId)
	local crateLoc = Config.Crates[crateId].locations[locId]
	
	blips[crateId] = AddBlipForCoord(crateLoc.coords)
	SetBlipSprite(blips[crateId], 94)
	SetBlipColour(blips[crateId], 5)
	SetBlipAsShortRange(blips[crateId], true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString(Config.Crates[crateId].label)
	EndTextCommandSetBlipName(blips[crateId])
	
	radiusBlips[crateId] = AddBlipForRadius(crateLoc.coords, crateLoc.radius)
	SetBlipColour(radiusBlips[crateId], 1)
	SetBlipDisplay(radiusBlips[crateId], 4)
	SetBlipAlpha(radiusBlips[crateId], 128)
	
	Citizen.CreateThread(function()
		while onGoingCrates[crateId].phase > 0 do
			local coords = GetEntityCoords(PlayerPedId())
			local distance = #(coords.xy - crateLoc.coords.xy)
			
			if not inZone[crateId] and distance < (crateLoc.radius + 50.0) then
				DisableControlAction(0, 24, true)	--INPUT_ATTACK
				DisableControlAction(0, 25, true)	--INPUT_AIM
				DisableControlAction(0, 69, true)	--INPUT_VEH_ATTACK
				DisableControlAction(0, 70, true)	--INPUT_VEH_ATTACK2
				DisableControlAction(0, 92, true)	--INPUT_VEH_PASSENGER_ATTACK
				DisableControlAction(0, 114, true)	--INPUT_VEH_FLY_ATTACK
				DisableControlAction(0, 140, true)	--INPUT_MELEE_ATTACK_LIGHT
				DisableControlAction(0, 141, true)	--INPUT_MELEE_ATTACK_HEAVY
				DisableControlAction(0, 142, true)	--INPUT_MELEE_ATTACK_ALTERNATE
				DisableControlAction(0, 257, true)	--INPUT_ATTACK2
				DisableControlAction(0, 263, true)	--INPUT_MELEE_ATTACK1
				DisableControlAction(0, 264, true)	--INPUT_MELEE_ATTACK2
				DisableControlAction(0, 331, true)	--INPUT_VEH_FLY_ATTACK2
				DisableControlAction(0, 346, true)	--INPUT_VEH_MELEE_LEFT
				DisableControlAction(0, 347, true)	--INPUT_VEH_MELEE_RIGHT
				
				DisablePlayerFiring(PlayerId(), true)

				exports['dpemotes']:ForceCloseMenu()
			else
				Wait(1500)
			end
			
			Wait(0)
		end
	end)
	
	Citizen.CreateThread(function()
		while onGoingCrates[crateId].phase > 0 do
			local wait = 1500
			local coords = GetEntityCoords(PlayerPedId())
			local distance = #(coords.xy - crateLoc.coords.xy)
			
			if distance < crateLoc.radius and distance > (crateLoc.radius - 10.0) then
				if not inZone[crateId] then
					if not IsEntityDead(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId(), false) then
						TriggerServerEvent('cratedrop_v2:enteredZone', crateId, true)
						Wait(1000)
					end
				end
			elseif distance > crateLoc.radius then
				if inZone[crateId] then
					TriggerServerEvent('cratedrop_v2:enteredZone', crateId, false)
					Wait(1000)
				end
			end
			
			if inZone[crateId] then
				wait = 250
				
				if onGoingCrates[crateId].phase == 3 and #(coords - crateLoc.coords) < 1.2 then
					wait = 0
					ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to open the crate')
					
					if IsControlJustReleased(0, 38) then
						OpenCrate(crateId, crateLoc.coords)
					end
				end
			end
			
			Wait(wait)
		end
		
		inZone[crateId] = nil
		GlobalState.inCratedropV2 = nil
		
		if DoesBlipExist(blips[crateId]) then
			RemoveBlip(blips[crateId])
		end
		
		if DoesBlipExist(radiusBlips[crateId]) then
			RemoveBlip(radiusBlips[crateId])
		end
		
		if DoesEntityExist(crateObjects[crateId]) then
			DeleteEntity(crateObjects[crateId])
		end
		
		if DoesParticleFxLoopedExist(crateParticles[crateId]) then
			StopParticleFxLooped(crateParticles[crateId], 0)
		end
	end)
end

function ProcessScoreboard(crateId, timeDrop)
	local timeLeft = 0
	local cooldown = 0
	local isShowing = false
	
	Citizen.CreateThread(function()
		while inZone[crateId] do
			if IsDisabledControlPressed(0, 37) then
				if not isShowing and cooldown < GetGameTimer() then
					isShowing = true
					cooldown = GetGameTimer() + 2000
					ExecuteCommand('cratescoreboard')
				end
			else
				if isShowing then
					isShowing = false
					SendNUIMessage({action = 'hide'})
				end
			end
			
			if timeDrop >= GlobalState.date.timestamp then
				timeLeft = timeDrop - GlobalState.date.timestamp
				timeLeft = timeLeft > 0 and (('%02d:%02d'):format(math.floor(timeLeft/60), math.floor(timeLeft%60))) or '00:00'
				
				--DrawText2(0.01, 0.35, 0.75, '~HUD_COLOUR_DEGEN_MAGENTA~ DROP: '..timeLeft)
				exports['eventTimer']:ShowTimer('DROP IN', timeLeft);
			end
			
			Wait(0)
		end
		
		if isShowing then
			SendNUIMessage({action = 'hide'})
		end
	end)
end

function OpenCrate(crateId, crateCoords)
	if IsEntityDead(PlayerPedId()) or IsPedInAnyVehicle(PlayerPedId(), false) then
		return
	end
	
	local canOpen = nil
	
	ESX.TriggerServerCallback('cratedrop_v2:canOpenCrate', function(cb) canOpen = cb end, crateId)
	while canOpen == nil do Wait(0) end
	
	if not canOpen then
		return
	end
	
	local openingCrate = true
	
	RequestAnimDict('amb@medic@standing@tendtodead@base')
	while not HasAnimDictLoaded('amb@medic@standing@tendtodead@base') do Wait(0) end
	
	TaskPlayAnim(PlayerPedId(), 'amb@medic@standing@tendtodead@base', 'base', 3.0, 3.0, -1, 1, 0, 0, 0, 0)
	
	TriggerEvent('mythic_progressbar:client:progress', {
		name = 'opening',
		duration = Config.CaptureTime*1000,
		label = 'Opening...',
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
	}, function(cancelled)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('cratedrop_v2:openCrate', crateId, cancelled)
		Wait(1000)
		openingCrate = false
	end)
	
	while openingCrate do
		if IsEntityDead(PlayerPedId()) or IsPedInAnyVehicle(PlayerPedId(), false) or #(GetEntityCoords(PlayerPedId()) - crateCoords) > 1.2 then
			TriggerEvent('mythic_progressbar:client:cancel')
			Wait(1000)
		end
		
		Wait(250)
	end
end

function CreateCrateObject(crateId, locId)
	local crateLoc = Config.Crates[crateId].locations[locId]
	
	local crateModel = GetHashKey('hei_prop_heist_ammo_box')
	
	RequestModel(crateModel)
	while not HasModelLoaded(crateModel) do Wait(0) end
	
	local object = CreateObject(crateModel, crateLoc.coords.x, crateLoc.coords.y, crateLoc.coords.z - 1.0, false, true)
	FreezeEntityPosition(object, true)
	SetEntityLodDist(object, 200)
	
	SetModelAsNoLongerNeeded(crateModel)
	
	return object
end

function CreateCrateParticle(crateId, locId)
	local crateLoc = Config.Crates[crateId].locations[locId]
	
	RequestNamedPtfxAsset('core')
	while not HasNamedPtfxAssetLoaded('core') do Wait(0) end
	
	SetPtfxAssetNextCall('core')
	
	local particle = StartParticleFxLoopedAtCoord('exp_grd_flare', crateLoc.coords.x, crateLoc.coords.y, crateLoc.coords.z - 0.995, 0.0, 0.0, 0.0, 2.0, false, false, false, false)
	SetParticleFxLoopedAlpha(particle, 0.8)
	SetParticleFxLoopedColour(particle, 0.0, 0.0, 0.0, 0)
	
	return particle
end

function CreateStaticNPC(id)
	RequestModel(Config.Crates[id].npc.model)
	while not HasModelLoaded(Config.Crates[id].npc.model) do Wait(0) end
	
	local npc = CreatePed(5, Config.Crates[id].npc.model, Config.Crates[id].npc.coords.x, Config.Crates[id].npc.coords.y, Config.Crates[id].npc.coords.z - 1.0, Config.Crates[id].npc.heading, false, true)
	SetPedDefaultComponentVariation(npc)
	SetEntityHeading(npc, Config.Crates[id].npc.heading)
	FreezeEntityPosition(npc, true)
	SetEntityInvincible(npc, true)
	SetBlockingOfNonTemporaryEvents(npc, true)
	
	SetModelAsNoLongerNeeded(Config.Crates[id].npc.model)
	
	return npc
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

RegisterNUICallback('init', function()
	TriggerServerEvent('cratedrop_v2:init')
end)