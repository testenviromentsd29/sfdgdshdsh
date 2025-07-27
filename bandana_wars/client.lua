ESX = nil

local inZone = false
local onGoingEvent = false
local blipRadius = nil
local droppedBandanas = nil
local enterCooldown = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	CreateBlips()
end)

RegisterNetEvent('bandana_wars:start')
AddEventHandler('bandana_wars:start', function(id)
	ProcessEvent(id)
end)

RegisterNetEvent('bandana_wars:end')
AddEventHandler('bandana_wars:end', function()
	onGoingEvent = false
end)

RegisterNetEvent('bandana_wars:enteredZone')
AddEventHandler('bandana_wars:enteredZone', function(isEntering, _droppedBandanas)
	if isEntering then
		inZone = true
		droppedBandanas = _droppedBandanas

		ProcessBandanas()
		ProcessScoreboard()

		if DoesBlipExist(blipRadius) then
			SetBlipColour(blipRadius, 5)
		end

		ESX.ShowNotification('You entered the event')
	else
		inZone = false
		enterCooldown = GetGameTimer() + Config.EnterCooldown*1000

		if DoesBlipExist(blipRadius) then
			SetBlipColour(blipRadius, 1)
		end

		ESX.ShowNotification('You left the event')
	end
end)

RegisterNetEvent('bandana_wars:addBandana')
AddEventHandler('bandana_wars:addBandana', function(id)
	Wait(1000)

	if droppedBandanas then
		droppedBandanas[id] = true
	end
end)

RegisterNetEvent('bandana_wars:removeBandana')
AddEventHandler('bandana_wars:removeBandana', function(id)
	if droppedBandanas then
		droppedBandanas[id] = nil
	end
end)

RegisterNetEvent('bandana_wars:scoreboard')
AddEventHandler('bandana_wars:scoreboard', function(data)
	local scoreboard = {}
	
	for k,v in pairs(data) do
		table.insert(scoreboard, {points = v.points, label = v.label})
	end
	
	table.sort(scoreboard, function(a,b) return a.points > b.points end)

	local job = ESX.GetPlayerJob(GetPlayerServerId(PlayerId()))
	local points = data[job.name] and data[job.name].points or 0

	SendNUIMessage({action = 'showScore', scoreboard = scoreboard, points = points})
end)

RegisterNUICallback('quit', function()
	SetNuiFocus(false, false)
end)

function ProcessEvent(id)
	if onGoingEvent then
		return
	end

	onGoingEvent = true

	local coords = Config.Locations[id].coords
	local radius = Config.Locations[id].radius

	blipRadius = AddBlipForRadius(coords, radius)
	SetBlipColour(blipRadius, 1)
	SetBlipAlpha(blipRadius, 128)

	Citizen.CreateThread(function()
		while onGoingEvent do
			local distance = #(GetEntityCoords(PlayerPedId()) - coords)

			if distance < radius and distance > (radius - 10.0) then
				if not inZone then
					if enterCooldown < GetGameTimer() then
						TriggerServerEvent('bandana_wars:enteredZone', true)
					else
						local timeLeft = math.ceil((enterCooldown - GetGameTimer())/1000)
						ESX.ShowNotification('You need to wait '..timeLeft..' seconds before entering the event')
					end
				end
			elseif distance > radius then
				if inZone then
					TriggerServerEvent('bandana_wars:enteredZone', false)
				end
			end

			Wait(1500)
		end

		if DoesBlipExist(blip) then
			RemoveBlip(blip)
		end

		if DoesBlipExist(blipRadius) then
			RemoveBlip(blipRadius)
		end

		inZone = false
		blip = nil
		blipRadius = nil
		enterCooldown = 0
	end)

	Citizen.CreateThread(function()
		while onGoingEvent do
			local wait = 1500

			if not inZone and #(GetEntityCoords(PlayerPedId()) - coords) < (radius + 20.0) then
				wait = 0
				DontShootThisFrame()
			end

			Wait(wait)
		end
	end)

	Citizen.CreateThread(function()
		local npc = nil
		local drawTxtCoords = vector3(Config.Locations[id].npc_coords.x, Config.Locations[id].npc_coords.y, Config.Locations[id].npc_coords.z + 1.2)

		while onGoingEvent do
			local wait = 1500
			local distance = #(GetEntityCoords(PlayerPedId()) - Config.Locations[id].npc_coords)
			
			if inZone and distance < 50.0 then
				if not DoesEntityExist(npc) then
					npc = CreateStaticNPC(`u_m_m_aldinapoli`, Config.Locations[id].npc_coords, Config.Locations[id].npc_heading)
				end
				
				if distance < 15.0 then
					wait = 0
					ESX.Game.Utils.DrawText3D(drawTxtCoords, '~g~BANDANA NPC', 1.2, 4)
					
					if distance < 1.2 then
						ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to give the ~g~Bandanas')
						
						if IsControlJustReleased(0, 38) then
							TriggerServerEvent('bandana_wars:giveBandanas')
							Wait(1000)
						end
					end
				end
			else
				if DoesEntityExist(npc) then
					DeleteEntity(npc)
				end
			end
			
			Wait(wait)
		end

		if DoesEntityExist(npc) then
			DeleteEntity(npc)
		end
	end)
end

function ProcessBandanas()
	local objects = {}
	local isBusy = false
	local cooldown = 0
	
	Citizen.CreateThread(function()
		while inZone do
			local coords = GetEntityCoords(PlayerPedId())
			
			if cooldown < GetGameTimer() then
				cooldown = GetGameTimer() + 1500
				
				for k,v in pairs(droppedBandanas) do
					if not DoesEntityExist(objects[k]) then
						RequestModel(`white_bandana`)
						while not HasModelLoaded(`white_bandana`) do Wait(0) end
						
						local object = CreateObject(`white_bandana`, k.x, k.y, k.z, false, false)
						PlaceObjectOnGroundProperly(object)
						
						SetModelAsNoLongerNeeded(`white_bandana`)
						
						objects[k] = object
					end
				end
			end

			for k,v in pairs(droppedBandanas) do
				local distance = #(coords - k)

				if distance < 50.0 then
					DrawMarker(0, k.x, k.y, k.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.25, 0.25, 0.25, 0, 255, 0, 150, false, true, 2, false, false, false, false)

					if distance < 1.0 then
						ESX.ShowHelpNotification('Press ~INPUT_ENTER~ to get the bandana')
						
						if IsControlJustReleased(0, 23) and not isBusy and not IsEntityDead(PlayerPedId()) then
							isBusy = true
							
							RequestAnimDict('pickup_object')
							while not HasAnimDictLoaded('pickup_object') do Wait(0) end
							
							TaskPlayAnim(PlayerPedId(), 'pickup_object', 'pickup_low', 2.0, -8.0, -1, 0, 0, false, false, false)
							
							TriggerServerEvent('bandana_wars:getBandana', k)
							
							SetTimeout(1000, function() isBusy = false end)
						end
					end
				end
			end

			for k,v in pairs(objects) do
				if droppedBandanas[k] == nil and DoesEntityExist(v) then
					DeleteEntity(v)
				end
			end
			
			Wait(0)
		end

		for k,v in pairs(objects) do
			if DoesEntityExist(v) then
				DeleteEntity(v)
			end
		end

		droppedBandanas = nil
	end)
end

function ProcessScoreboard()
	Citizen.CreateThread(function()
		local showingScore = false
		SendNUIMessage({action = 'showHelp'})
		
		while inZone do
			if not showingScore and (IsControlPressed(0, 211) or IsDisabledControlPressed(0, 211)) then	--TAB
				showingScore = true
				ExecuteCommand('bw_scoreboard')
			elseif showingScore and (IsControlJustReleased(0, 211) or IsDisabledControlReleased(0, 211)) then	--TAB
				showingScore = false
				SendNUIMessage({action = 'hideScore'})
				
				Wait(2000)
			end
			
			Wait(0)
		end

		SendNUIMessage({action = 'hideHelp'})
		
		if showingScore then
			Wait(1000)
			SendNUIMessage({action = 'hideScore'})
		end
	end)
end

function DontShootThisFrame()
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

function CreateBlips()
	for k,v in pairs(Config.Locations) do
		local blip = AddBlipForCoord(v.npc_coords)
		SetBlipSprite(blip, v.blip.sprite)
		SetBlipScale(blip, v.blip.scale)
		SetBlipColour(blip, v.blip.color)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(v.label)
		EndTextCommandSetBlipName(blip)
	end
end

exports('InEvent', function()
	return inZone
end)