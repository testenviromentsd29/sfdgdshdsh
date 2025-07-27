ESX = nil

local securityNpc = nil
local trolleys = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	Wait(2000)
	
	InitScript()
end)

function InitScript()
	local cooldown = 0
	
	Citizen.CreateThread(function()
		while true do
			local wait = 1500
			local coords = GetEntityCoords(PlayerPedId())
			
			if #(coords - Config.SecurityGuard.coords) < 30.0 then
				wait = 0
				
				if not DoesEntityExist(securityNpc) then
					securityNpc = CreateLocalNPC(Config.SecurityGuard.model, Config.SecurityGuard.coords, Config.SecurityGuard.heading)
					
					if GlobalState.centralBankStatus and GlobalState.centralBankStatus >= 2 then
						local destination = vector3(261.67, 222.91, 106.28)
						SetEntityCoordsNoOffset(securityNpc, destination)
						Wait(500)
						RequestAnim('random@arrests@busted')
						TaskPlayAnim(securityNpc, 'random@arrests@busted', 'idle_a', 2.0, -8.0, -1, 1, 0, false, false, false)
					end
				else
					if IsPlayerFreeAimingAtEntity(PlayerId(), securityNpc) and not GlobalState.centralBankStatus then
						if cooldown < GetGameTimer() then
							cooldown = GetGameTimer() + 5000
							TriggerServerEvent('centralbank_rage:start')
						end
					end
				end
				
				CheckDoors()
			else
				if DoesEntityExist(securityNpc) then
					DeleteEntity(securityNpc)
				end
			end
			
			Wait(wait)
		end
	end)
end

RegisterNetEvent('centralbank_rage:phase1')
AddEventHandler('centralbank_rage:phase1', function()
	if DoesEntityExist(securityNpc) then
		PlayPain(securityNpc, 7, 0.0, false)
		
		RequestAnim('mp_am_hold_up')
		TaskPlayAnim(securityNpc, 'mp_am_hold_up', 'handsup_base', 8.0, -8.0, -1, 2, 0, false, false, false)
		
		TriggerEvent('mythic_progressbar:client:progress', {
			name = 'scare_o_meter',
			duration = Config.ScareDuration*1000,
			label = 'Scare-O-Meter',
			useWhileDead = false,
			canCancel = false,
			controlDisables = {
				disableMovement = false,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = false,
			},
		}, function(cancelled)
			--
		end)
	end
	
	if ESX.GetPlayerData().job.name == 'police' then
		local blip = AddBlipForCoord(Config.SecurityGuard.coords)
		SetBlipSprite(blip, 161)
		SetBlipScale(blip, 1.5)
		SetBlipColour(blip, 3)
		PulseBlip(blip)
		
		Wait(240000)
		
		if DoesBlipExist(blip) then
			RemoveBlip(blip)
		end
	end
end)

RegisterNetEvent('centralbank_rage:phase2')
AddEventHandler('centralbank_rage:phase2', function()
	if DoesEntityExist(securityNpc) then
		local destination = vector3(261.67, 222.91, 106.28)
		
		FreezeEntityPosition(securityNpc, false)
		TaskGoToCoordAnyMeans(securityNpc, destination.x, destination.y, destination.z, 0.1, 0, 0, 786603, 0.1)
		Wait(5000)
		FreezeEntityPosition(securityNpc, true)
		SetEntityCoordsNoOffset(securityNpc, destination)
		
		RequestAnim('anim@mp_player_intmenu@key_fob@')
		TaskPlayAnim(securityNpc, 'anim@mp_player_intmenu@key_fob@', 'fob_click', 8.0, -8.0, -1, 2, 0, false, false, false)
		
		Wait(2000)
		RequestAnim('random@arrests@busted')
		TaskPlayAnim(securityNpc, 'random@arrests@busted', 'idle_a', 2.0, -8.0, -1, 1, 0, false, false, false)
	end
end)

RegisterNetEvent('centralbank_rage:phase3')
AddEventHandler('centralbank_rage:phase3', function(netIds)
	local _, guardGroup = AddRelationshipGroup('centralbank_rage')
	
	SetRelationshipBetweenGroups(5, guardGroup, GetHashKey('PLAYER'))
	SetRelationshipBetweenGroups(5, GetHashKey('PLAYER'), guardGroup)
	
	for k,v in pairs(netIds or {}) do
		if NetworkDoesNetworkIdExist(v) then
			local attacker = NetworkGetEntityFromNetworkId(v)
			
			if DoesEntityExist(attacker) then
				local owner = NetworkGetEntityOwner(attacker)
				
				if owner == PlayerId() then
					SetPedCanRagdoll(attacker, false)
					SetPedAccuracy(attacker, 70)
					SetPedArmour(attacker, 100)
					SetPedCanSwitchWeapon(attacker, true)
					SetPedDropsWeaponsWhenDead(attacker, false)
					SetPedFleeAttributes(attacker, 0, false)
					SetRagdollBlockingFlags(attacker, 1)
					SetPedDiesWhenInjured(attacker, false)
					SetPedSuffersCriticalHits(attacker, false)
					SetPedHearingRange(attacker, 250.0)
					SetPedCombatMovement(attacker, 1)
					SetPedKeepTask(attacker, true)
					SetPedRelationshipGroupHash(attacker, guardGroup)
					RegisterHatedTargetsAroundPed(attacker, 25.0)
					TaskCombatHatedTargetsAroundPed(attacker, 25.0, 0)
				end
			end
		end
	end
end)

RegisterNetEvent('centralbank_rage:phase4')
AddEventHandler('centralbank_rage:phase4', function()
	local door = GetClosestObjectOfType(Config.Doors[3].coords.x, Config.Doors[3].coords.y, Config.Doors[3].coords.z, 0.1, Config.Doors[3].model, false, false)
	
	if DoesEntityExist(door) then
		Citizen.CreateThread(function()
			while GetEntityHeading(door) > 1.0 do
				SetEntityHeading(door, GetEntityHeading(door) - 1.0)
				Wait(6)
			end
		end)
	end
	
	for k,v in pairs(Config.Trolleys) do
		RequestModel(v.model)
		while not HasModelLoaded(v.model) do Wait(0) end
		
		trolleys[k] = CreateObject(v.model, v.coords.x, v.coords.y, v.coords.z, false, false)
		FreezeEntityPosition(trolleys[k], true)
		
		SetModelAsNoLongerNeeded(v.model)
	end
	
	Citizen.CreateThread(function()
		local isLooting = false
		
		while GlobalState.centralBankStatus do
			local wait = 1500
			local coords = GetEntityCoords(PlayerPedId())
			
			for k,v in pairs(trolleys) do
				if #(coords - GetEntityCoords(v)) < 2.0 then
					wait = 0
					ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to loot the trolley')
					
					if IsControlJustReleased(0, 38) then
						if not isLooting then
							isLooting = true
							ExecuteCommand('e mechanic')
							
							TriggerEvent('mythic_progressbar:client:progress', {
								name = 'looting',
								duration = Config.LootDuration*1000,
								label = 'Looting',
								useWhileDead = false,
								canCancel = true,
								controlDisables = {
									disableMovement = true,
									disableCarMovement = true,
									disableMouse = false,
									disableCombat = true,
								},
							}, function(cancelled)
								if not cancelled and not IsEntityDead(PlayerPedId()) then
									TriggerServerEvent('centralbank_rage:lootTrolley', k)
								end
								
								isLooting = false
								ExecuteCommand('e c')
							end)
						end
					end
				end
			end
			
			Wait(wait)
		end
	end)
end)

RegisterNetEvent('centralbank_rage:lootTrolley')
AddEventHandler('centralbank_rage:lootTrolley', function(id)
	if DoesEntityExist(trolleys[id]) then
		DeleteEntity(trolleys[id])
	end
end)

RegisterNetEvent('centralbank_rage:end')
AddEventHandler('centralbank_rage:end', function()
	if DoesEntityExist(securityNpc) then
		DeleteEntity(securityNpc)
	end
	
	for k,v in pairs(trolleys) do
		if DoesEntityExist(v) then
			DeleteEntity(v)
		end
	end
	
	trolleys = {}
	
	if #(GetEntityCoords(PlayerPedId()) - Config.SecurityGuard.coords) < 30.0 then
		ESX.ShowNotification('You have '..Config.LockdownTime..' minute(s) to get out of the bank before lockdown')
	end
end)

function CheckDoors()
	local status = GlobalState.centralBankStatus and GlobalState.centralBankStatus or 0
	
	local door1 = GetClosestObjectOfType(Config.Doors[1].coords.x, Config.Doors[1].coords.y, Config.Doors[1].coords.z, 0.1, Config.Doors[1].model, false, false)
	
	if DoesEntityExist(door1) then
		if status > 1 then
			FreezeEntityPosition(door1, false)
		else
			FreezeEntityPosition(door1, true)
			SetEntityHeading(door1, Config.Doors[1].heading)
		end
	end
	
	local door2 = GetClosestObjectOfType(Config.Doors[2].coords.x, Config.Doors[2].coords.y, Config.Doors[2].coords.z, 0.1, Config.Doors[2].model, false, false)
	
	if DoesEntityExist(door2) then
		if status > 2 then
			FreezeEntityPosition(door2, false)
		else
			FreezeEntityPosition(door2, true)
			SetEntityHeading(door2, Config.Doors[2].heading)
		end
	end
	
	local door3 = GetClosestObjectOfType(Config.Doors[3].coords.x, Config.Doors[3].coords.y, Config.Doors[3].coords.z, 0.1, Config.Doors[3].model, false, false)
	
	if DoesEntityExist(door3) then
		if status < 4 then
			FreezeEntityPosition(door3, true)
			SetEntityHeading(door3, Config.Doors[3].heading)
		end
	end
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if DoesEntityExist(securityNpc) then
			DeleteEntity(securityNpc)
		end
		
		for k,v in pairs(trolleys) do
			if DoesEntityExist(v) then
				DeleteEntity(v)
			end
		end
	end
end)

function CreateLocalNPC(model, coords, heading)
	RequestModel(model)
	while not HasModelLoaded(model) do Wait(0) end
	
	local npc = CreatePed(5, model, coords.x, coords.y, coords.z - 1.0, heading, false, true)
	SetPedRandomComponentVariation(npc)
	SetEntityHeading(npc, heading)
	FreezeEntityPosition(npc, true)
	SetEntityInvincible(npc, true)
	SetPedCanRagdoll(npc, false)
	SetBlockingOfNonTemporaryEvents(npc, true)
	
	SetModelAsNoLongerNeeded(model)
	
	return npc
end

function RequestAnim(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do Wait(0) end
end