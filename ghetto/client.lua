ESX = nil

GlobalState.ghettoStarted = false

local ghetto = {owner = 'none'}
local droppedWeapons = {}

local inRedzone = false
local onGoingCapture = false
local isProcessingWeapons = false

local blip
local blipRadius

local eventKills = {}
local eventWinnerDay = {}
local eventWinnerWeek = {}
local disableTags = {}
local ghettoStarted = false
local currentIndex
local ghettoKills = 0
local ghettoDeaths = 0
local ghettoHeadshots = 0
local showGhettoStatus = true

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end
	
	Wait(2000)
	
	ESX.PlayerData = ESX.GetPlayerData()
	
	ESX.TriggerServerCallback('ghetto:getData', function(data, data2, data3, eventPreStarted, eventStarted, disTags, index)
		ghetto = data
		eventWinnerDay = data2
		eventWinnerWeek = data3
		disableTags = disTags
		currentIndex = index
		
		if eventPreStarted then
			TriggerEvent('ghetto:prestartEvent')
		elseif eventStarted then
			GlobalState.ghettoStarted = true
			ghettoStarted = true
			print('Ghetto started')
			TriggerEvent('ghetto:prestartEvent', 10)
		end
		
		SetupGhetto()
		ProcessTags()
		InitScript()
	end, true)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterCommand('ghettostatus', function(source, args)
	showGhettoStatus = not showGhettoStatus
	ESX.ShowNotification('Ghetto Status: '..tostring(showGhettoStatus))
end)

RegisterCommand('tpghetto', function(source, args)

	local IsHandcuffed = exports["esx_policejob"]:IsHandcuffed()
	if IsHandcuffed then
		ESX.ShowNotification('You cant do this at the moment')
		return
	end

	if exports.zones:IsInGreenZone() then
		local elements = {}

		table.insert(elements, {label = 'Ghetto 1', value = vector3(308.05, -1371.25, 31.92)})
		table.insert(elements, {label = 'Ghetto 2', value = vector3(144.60, -1388.57, 29.31)})
		table.insert(elements, {label = 'Ghetto 3', value = vector3(391.83, -1774.32, 29.25)})

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ghetto_tp', {
			title    = 'Ghetto Teleport',
			align    = 'center',
			elements = elements,
		},function(data, menu)
			menu.close()
			if exports.zones:IsInGreenZone() then
				ESX.Game.Teleport(PlayerPedId(), data.current.value)
			end
		end,function(data, menu)
			menu.close()
		end)
	else
		ESX.ShowNotification('You are not in a greenzone')
	end
end)

function IsInBlacklistedPosition()
	local coords = GetEntityCoords(PlayerPedId());

	for k,v in pairs(Config.TPBlacklistedPositions) do
		if #(v.xyz - coords) < v.w then
			return true
		end
	end

	return false
end

RegisterCommand('tpcayo', function(source, args)
	if not exports.zones:IsInGreenZone() then
		ESX.ShowNotification('You are not in a greenzone')
		return
	end
	if exports["esx_communityservice"]:IsOnCommunityService() then
		ESX.ShowNotification('You Are Currently On Community Service.')
		return
	end
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		ESX.ShowNotification('You can not teleport while in a vehicle')
		return
	end

	if exports['esx_communityservice']:IsOnCommunityService() then
		ESX.ShowNotification('You can not teleport while on community service')
		return
	end

	if exports['esx-qalle-jail']:IsInJail() then
		ESX.ShowNotification('You can not teleport while in jail')
		return
	end

	if IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) then
		ESX.ShowNotification('You can not teleport while in handcuffs')
		return
	end

	if IsInBlacklistedPosition() then
		ESX.ShowNotification('You can not teleport from this position')
		return
	end

	ESX.Game.Teleport(PlayerPedId(), vector3(4051.76, -4689.14, 4.20))
	FreezeEntityPosition(PlayerPedId(), true)
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			ESX.ShowHelpNotification("Press [E] to unfreeze")
			if IsControlJustPressed(0, 38) then
				break
			end
		end
		FreezeEntityPosition(PlayerPedId(), false)
	end)
end)

RegisterCommand('tpgarage', function(source, args)
	if not exports.zones:IsInGreenZone() then
		ESX.ShowNotification('You are not in a greenzone')
		return
	end
	if exports["esx_communityservice"]:IsOnCommunityService() then
		ESX.ShowNotification('You Are Currently On Community Service.')
		return
	end
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		ESX.ShowNotification('You can not teleport while in a vehicle')
		return
	end

	if exports['esx_communityservice']:IsOnCommunityService() then
		ESX.ShowNotification('You can not teleport while on community service')
		return
	end

	if exports['esx-qalle-jail']:IsInJail() then
		ESX.ShowNotification('You can not teleport while in jail')
		return
	end

	if IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) then
		ESX.ShowNotification('You can not teleport while in handcuffs')
		return
	end

	if IsInBlacklistedPosition() then
		ESX.ShowNotification('You can not teleport from this position')
		return
	end

	ESX.Game.Teleport(PlayerPedId(), vector3(1140.10, -493.20, 65.11))
	FreezeEntityPosition(PlayerPedId(), true)
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			ESX.ShowHelpNotification("Press [E] to unfreeze")
			if IsControlJustPressed(0, 38) then
				break
			end
		end
		FreezeEntityPosition(PlayerPedId(), false)
	end)
end)

RegisterCommand('tppolice', function(source, args)
	if ESX.PlayerData.job.name ~= 'police' then
		ESX.ShowNotification('You are not a police officer')
		return
	end
	if exports["esx_communityservice"]:IsOnCommunityService() then
		ESX.ShowNotification('You Are Currently On Community Service.')
		return
	end
	if not exports.zones:IsInGreenZone() then
		ESX.ShowNotification('You are not in a greenzone')
		return
	end

	if IsPedInAnyVehicle(PlayerPedId(), false) then
		ESX.ShowNotification('You can not teleport while in a vehicle')
		return
	end

	if exports['esx_communityservice']:IsOnCommunityService() then
		ESX.ShowNotification('You can not teleport while on community service')
		return
	end

	if exports['esx-qalle-jail']:IsInJail() then
		ESX.ShowNotification('You can not teleport while in jail')
		return
	end

	if IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) then
		ESX.ShowNotification('You can not teleport while in handcuffs')
		return
	end

	if IsInBlacklistedPosition() then
		ESX.ShowNotification('You can not teleport from this position')
		return
	end

	ESX.Game.Teleport(PlayerPedId(), vector3(2530.92, -365.34, 93.75))
	FreezeEntityPosition(PlayerPedId(), true)
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			ESX.ShowHelpNotification("Press [E] to unfreeze")
			if IsControlJustPressed(0, 38) then
				break
			end
		end
		FreezeEntityPosition(PlayerPedId(), false)
	end)
end)

RegisterCommand('tpcity', function(source, args)
	if not exports.zones:IsInGreenZone() then
		ESX.ShowNotification('You are not in a greenzone')
		return
	end
	if exports["esx_communityservice"]:IsOnCommunityService() then
		ESX.ShowNotification('You Are Currently On Community Service.')
		return
	end
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		ESX.ShowNotification('You can not teleport while in a vehicle')
		return
	end

	if exports['esx_communityservice']:IsOnCommunityService() then
		ESX.ShowNotification('You can not teleport while on community service')
		return
	end

	if exports['esx-qalle-jail']:IsInJail() then
		ESX.ShowNotification('You can not teleport while in jail')
		return
	end

	if IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) then
		ESX.ShowNotification('You can not teleport while in handcuffs')
		return
	end

	if IsInBlacklistedPosition() then
		ESX.ShowNotification('You can not teleport from this position')
		return
	end

	ESX.Game.Teleport(PlayerPedId(), vector3(196.80, -959.38, 30.09))
	FreezeEntityPosition(PlayerPedId(), true)
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			ESX.ShowHelpNotification("Press [E] to unfreeze")
			if IsControlJustPressed(0, 38) then
				break
			end
		end
		FreezeEntityPosition(PlayerPedId(), false)
	end)
end)

RegisterCommand('tpsandy', function(source, args)
	if not exports.zones:IsInGreenZone() then
		ESX.ShowNotification('You are not in a greenzone')
		return
	end
	if exports["esx_communityservice"]:IsOnCommunityService() then
		ESX.ShowNotification('You Are Currently On Community Service.')
		return
	end
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		ESX.ShowNotification('You can not teleport while in a vehicle')
		return
	end

	if exports['esx_communityservice']:IsOnCommunityService() then
		ESX.ShowNotification('You can not teleport while on community service')
		return
	end

	if exports['esx-qalle-jail']:IsInJail() then
		ESX.ShowNotification('You can not teleport while in jail')
		return
	end

	if IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) then
		ESX.ShowNotification('You can not teleport while in handcuffs')
		return
	end

	if IsInBlacklistedPosition() then
		ESX.ShowNotification('You can not teleport from this position')
		return
	end

	ESX.Game.Teleport(PlayerPedId(), vector3(1817.97, 3656.55, 34.07))
	FreezeEntityPosition(PlayerPedId(), true)
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			ESX.ShowHelpNotification("Press [E] to unfreeze")
			if IsControlJustPressed(0, 38) then
				break
			end
		end
		FreezeEntityPosition(PlayerPedId(), false)
	end)
end)

RegisterCommand('tppaleto', function(source, args)
	if not exports.zones:IsInGreenZone() then
		ESX.ShowNotification('You are not in a greenzone')
		return
	end
	if exports["esx_communityservice"]:IsOnCommunityService() then
		ESX.ShowNotification('You Are Currently On Community Service.')
		return
	end
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		ESX.ShowNotification('You can not teleport while in a vehicle')
		return
	end

	if exports['esx_communityservice']:IsOnCommunityService() then
		ESX.ShowNotification('You can not teleport while on community service')
		return
	end

	if exports['esx-qalle-jail']:IsInJail() then
		ESX.ShowNotification('You can not teleport while in jail')
		return
	end

	if IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) then
		ESX.ShowNotification('You can not teleport while in handcuffs')
		return
	end
	
	if IsInBlacklistedPosition() then
		ESX.ShowNotification('You can not teleport from this position')
		return
	end
	
	ESX.Game.Teleport(PlayerPedId(), vector3(142.64, 6571.24, 31.95))
	FreezeEntityPosition(PlayerPedId(), true)
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			ESX.ShowHelpNotification("Press [E] to unfreeze")
			if IsControlJustPressed(0, 38) then
				break
			end
		end
		FreezeEntityPosition(PlayerPedId(), false)
	end)
end)

RegisterCommand('tp5020', function(source, args)
	if not exports.zones:IsInGreenZone() then
		ESX.ShowNotification('You are not in a greenzone')
		return
	end
	if exports["esx_communityservice"]:IsOnCommunityService() then
		ESX.ShowNotification('You Are Currently On Community Service.')
		return
	end
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		ESX.ShowNotification('You can not teleport while in a vehicle')
		return
	end

	if exports['esx_communityservice']:IsOnCommunityService() then
		ESX.ShowNotification('You can not teleport while on community service')
		return
	end

	if exports['esx-qalle-jail']:IsInJail() then
		ESX.ShowNotification('You can not teleport while in jail')
		return
	end

	if IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) then
		ESX.ShowNotification('You can not teleport while in handcuffs')
		return
	end


	if IsInBlacklistedPosition() then
		ESX.ShowNotification('You can not teleport from this position')
		return
	end
	
	ESX.Game.Teleport(PlayerPedId(), vector3(-415.13, 1161.53, 325.86) )
	FreezeEntityPosition(PlayerPedId(), true)
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			ESX.ShowHelpNotification("Press [E] to unfreeze")
			if IsControlJustPressed(0, 38) then
				break
			end
		end
		FreezeEntityPosition(PlayerPedId(), false)
	end)
end)

RegisterCommand('tp5020v2', function(source, args)
	if not exports.zones:IsInGreenZone() then
		ESX.ShowNotification('You are not in a greenzone')
		return
	end
	if exports["esx_communityservice"]:IsOnCommunityService() then
		ESX.ShowNotification('You Are Currently On Community Service.')
		return
	end
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		ESX.ShowNotification('You can not teleport while in a vehicle')
		return
	end

	if exports['esx_communityservice']:IsOnCommunityService() then
		ESX.ShowNotification('You can not teleport while on community service')
		return
	end
	if IsEntityAttachedToAnyPed(PlayerPedId()) then	
		return
	end
	if exports['esx-qalle-jail']:IsInJail() then
		ESX.ShowNotification('You can not teleport while in jail')
		return
	end

	if IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) then
		ESX.ShowNotification('You can not teleport while in handcuffs')
		return
	end
	
	if IsInBlacklistedPosition() then
		ESX.ShowNotification('You can not teleport from this position')
		return
	end
	
	ESX.Game.Teleport(PlayerPedId(),vector3(-3388.13, -104.47, 2221.94) )
	FreezeEntityPosition(PlayerPedId(), true)
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			ESX.ShowHelpNotification("Press [E] to unfreeze")
			if IsControlJustPressed(0, 38) then
				break
			end
		end
		FreezeEntityPosition(PlayerPedId(), false)
	end)
	
end)

RegisterNetEvent('ghetto:showVips')
AddEventHandler('ghetto:showVips', function(vips)
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ghetto_vips', {
		title    = 'Ghetto Vips',
		align    = 'center',
		elements = vips,
	},function(data, menu)
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'christmas_vips_delete', {
			title    = 'Delete vip?',
			align    = 'center',
			elements = {
				{label = 'Yes', value = 'yes'},
				{label = 'No', value = 'no'},
			},
		},function(data2, menu2)
			if data2.current.value == 'yes' then
				TriggerServerEvent('ghetto:deleteVip', data.current.value)
			end
			menu2.close()
		end,function(data2, menu2)
			menu2.close()
		end)
	end,function(data, menu)
	   menu.close()
	end)
end)

RegisterNetEvent('ghetto:addKill')
AddEventHandler('ghetto:addKill', function(isHeadshot)
	ghettoKills = ghettoKills + 1
	
	if isHeadshot then
		ghettoHeadshots = ghettoHeadshots + 1
	end
end)

RegisterNetEvent('ghetto:addDeath')
AddEventHandler('ghetto:addDeath', function()
	ghettoDeaths = ghettoDeaths + 1
end)

RegisterNetEvent('ghetto:prestartEvent')
AddEventHandler('ghetto:prestartEvent', function(minutes)
	minutes = minutes or Config.NotifyTime
	
	Citizen.CreateThread(function()
		TriggerEvent('top_notifications:show', Config.NotificationData)
		Wait(minutes*60000)
		TriggerEvent('top_notifications:hide', Config.NotificationData.name)
	end)
end)

RegisterNetEvent('ghetto:eventWinnerDay')
AddEventHandler('ghetto:eventWinnerDay', function(data, started)
	GlobalState.ghettoStarted = started
	ghettoStarted = started
	eventWinnerDay = data
	TriggerEvent('top_notifications:hide', Config.NotificationData.name)
	
	if ghettoStarted then
		SetBlipColour(blipRadius, 27)
	else
		SetBlipColour(blipRadius, 1)
	end
end)

RegisterNetEvent('ghetto:updateTags')
AddEventHandler('ghetto:updateTags', function(identifier)
	if disableTags[identifier] then
		disableTags[identifier] = nil
	else
		disableTags[identifier] = true
	end
end)

function ProcessTags()
	local playerTags = {}
	
	Citizen.CreateThread(function()
		while true do
			Wait(1000)
			
			for k,v in pairs(GetActivePlayers()) do
				local sid = GetPlayerServerId(v)
				local targetPed = GetPlayerPed(v)
				
				local identifier = ESX.GetPlayerIdentifier(sid)

				if disableTags[identifier] and playerTags[sid] then
					playerTags[sid] = nil
				end
				
				if eventWinnerDay.identifier and eventWinnerDay.identifier == identifier and not disableTags[identifier] then
					playerTags[sid] = {title = 'Legend', ped = targetPed}
				end
				
				for k,v in pairs(eventWinnerWeek) do
					if k == identifier and not disableTags[identifier] then
						playerTags[sid] = {title = 'Epic', ped = targetPed}
						break
					end
				end
			end
		end
	end)
	
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			
			for sid,v in pairs(playerTags) do
				if DoesEntityExist(v.ped) then
					DrawText3D(GetEntityCoords(v.ped), v.title)
				end
			end
		end
	end)
end

function InitScript()
	--[[ Citizen.CreateThread(function()
		while true do
			local coords = GetEntityCoords(PlayerPedId())
			local redzoneDist = #(vector2(coords.x, coords.y) - vector2(Config.Coords.x, Config.Coords.y))

			if not inRedzone and redzoneDist < (Config.Radius + 50.0) then
				SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
			else
				Wait(1500)
			end
			
			Wait(0)
		end
	end) ]]

	Citizen.CreateThread(function()
		while true do
			local coords = GetEntityCoords(PlayerPedId())
			local redzoneDist = #(vector2(coords.x, coords.y) - vector2(Config.Coords[currentIndex].coords.x, Config.Coords[currentIndex].coords.y))

			if not inRedzone and redzoneDist < (Config.Coords[currentIndex].radius + 75.0) then
				--SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
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

				local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

				if vehicle > 0 and GetEntitySpeed(vehicle) < 15.0 then
					if not Config.IgnoreVehicleModels[GetEntityModel(vehicle)] then
						DeleteEntity(vehicle)
					end

					SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
				end

				if IsDisabledControlJustPressed(0, 170) or IsDisabledControlJustPressed(1, 170) then
					SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
				end
			else
				Wait(1500)
			end
			
			Wait(0)
		end
	end)
	
	Citizen.CreateThread(function()
		while true do
			local coords = GetEntityCoords(PlayerPedId())
			local redzoneDist = #(vector2(coords.x, coords.y) - vector2(Config.Coords[currentIndex].coords.x, Config.Coords[currentIndex].coords.y))
			
			if not inRedzone and redzoneDist < Config.Coords[currentIndex].radius and redzoneDist > (Config.Coords[currentIndex].radius - 10.0) then
				if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
					local _, weapon = GetCurrentPedWeapon(PlayerPedId(), false)
					if weapon ~= GetHashKey('WEAPON_UNARMED') then
						inRedzone = true
						--exports["time"]:startTimer(3, 'ENTER IN')
						TriggerServerEvent('ghetto:enteredZone', true)
						SetBlipColour(blipRadius, 5)
						--ProcessWeaponDrops()
						
						--[[SetEntityInvincible(PlayerPedId(), true)
						DisablePlayerFiring(PlayerId(), true)
						SetCanAttackFriendly(PlayerPedId(), false, false)
						NetworkSetFriendlyFireOption(false)
						
						SetTimeout(3000, function()
							SetEntityInvincible(PlayerPedId(), false)
							DisablePlayerFiring(PlayerId(), false)
							SetCanAttackFriendly(PlayerPedId(), true, true)
							NetworkSetFriendlyFireOption(true)
						end)]]
					else
						ESX.ShowNotification('Θα πρέπει να μπεις στην περιοχή κρατώντας όπλο')
					end
				else
					ESX.ShowNotification('Θα πρέπει να μπεις στην περιοχή χωρίς όχημα')
				end
				
				Wait(3000)
			elseif inRedzone and redzoneDist > Config.Coords[currentIndex].radius then
				if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
					exports["time"]:startTimer(5)
					
					if inRedzone and redzoneDist > Config.Coords[currentIndex].radius then
						inRedzone = false
						TriggerServerEvent('ghetto:enteredZone', false)
						
						if ghettoStarted then
							SetBlipColour(blipRadius, 27)
						else
							SetBlipColour(blipRadius, 1)
						end
					end
				else
					ESX.ShowNotification('Θα πρέπει να μπεις στην περιοχή χωρίς όχημα')
				end
				
				Wait(3000)
			end
			
			if #(coords - Config.Coords[currentIndex].coords) < 1.5 then
				if ESX.PlayerData.job.name ~= ghetto.owner then
					ESX.ShowHelpNotification('Press ~r~[E]~w~ to capture this area')
					
					if IsControlJustReleased(0, 38) then
						TriggerServerEvent('ghetto:startCapture')
						Wait(1000)
					end
				else
					ESX.ShowHelpNotification('Press ~r~[E]~w~ to get your rewards')
					
					if IsControlJustReleased(0, 38) then
						RewardsMenu()
					end
				end
			else
				Wait(1500)
			end
			
			Wait(0)
		end
	end)
	
	Citizen.CreateThread(function()
		while true do
			if inRedzone and showGhettoStatus then
				--DrawText2(0.157, 0.800, 0.45, '~y~Kills:~w~ '..ghettoKills..'\n~y~Deaths:~w~ '..ghettoDeaths..'\n~y~Headshots:~w~ '..ghettoHeadshots)
				DrawText2(0.157, 0.800, 0.45, '~y~Kills:~w~ '..ghettoKills..'\n~y~Deaths:~w~ '..ghettoDeaths..'\n~y~Headshots:~w~ '..ghettoHeadshots..'\n~y~Players:~w~ '..GlobalState.ghettoPlayers)
			else
				Wait(2000)
			end
			
			Wait(0)
		end
	end)
end

function ProcessWeaponDrops()
	if isProcessingWeapons then
		return
	end
	
	isProcessingWeapons = true
	
	Citizen.CreateThread(function()
		while inRedzone do
			if not IsEntityDead(PlayerPedId()) then
				local sleep = true
				
				for k,v in pairs(droppedWeapons) do
					if #(GetEntityCoords(PlayerPedId()) - v.coords) < 10.0 then
						sleep = false
						
						if #(GetEntityCoords(PlayerPedId()) - v.coords) < 1.0 then
							ESX.ShowHelpNotification('Press ~r~[E]~w~ to get the weapon')
							
							if IsControlJustReleased(0, 38) then
								ExecuteCommand('e pickup')
								TriggerServerEvent('ghetto:getDroppedWeapon', k)
								Wait(1000)
							end
						end
					end
				end
				
				if sleep then
					Wait(1000)
				end
			end
			
			Wait(0)
		end
		
		isProcessingWeapons = false
	end)
end

RegisterNetEvent('ghetto:startCapture')
AddEventHandler('ghetto:startCapture', function(attacker)
	onGoingCapture = attacker
	
	local timeLeft = Config.CaptureTime
	local timeTxt = 'Night :D'
	
	Citizen.CreateThread(function()
		while timeLeft > 0 and onGoingCapture do
			Wait(1000)
			timeLeft = timeLeft - 1
			timeTxt = (('%02s:%02s'):format(math.floor(timeLeft/60), math.floor(timeLeft%60)))
			
			if timeLeft % 2 == 0 then
				SetBlipFade(blipRadius, 128, 255)
			else
				SetBlipFade(blipRadius, 200, 255)
			end
			
			if attacker == GetPlayerServerId(PlayerId()) then
				if not inRedzone or IsEntityDead(PlayerPedId()) then
					TriggerServerEvent('ghetto:endCapture', false)
					timeLeft = -1
				end
				
				if timeLeft == 0 then
					TriggerServerEvent('ghetto:endCapture', true)
				end
			end
		end
	end)
	
	Citizen.CreateThread(function()
		while timeLeft > 0 and onGoingCapture do
			if inRedzone then
				DrawText2(0.425, 0.95, 0.6, '~r~Timeleft: ~w~'..timeTxt)
			else
				Wait(1500)
			end
			
			Wait(0)
		end
	end)
end)

RegisterNetEvent('ghetto:endCapture')
AddEventHandler('ghetto:endCapture', function(owner)
	ghetto.owner = owner
	
	if inRedzone then
		SetBlipColour(blipRadius, 5)
	else
		if ghettoStarted then
			SetBlipColour(blipRadius, 27)
		else
			SetBlipColour(blipRadius, 1)
		end
	end
	
	onGoingCapture = nil
end)

RegisterNetEvent('ghetto:showDailyKills')
AddEventHandler('ghetto:showDailyKills', function(data)
	local scoreboard = {}
	
	for k,v in pairs(data) do
		table.insert(scoreboard, {kills = v.kills, name = v.name})
	end
	
	table.sort(scoreboard, function(a,b) return a.kills > b.kills end)
	
	local identifier = ESX.GetPlayerData().identifier
	local kills = data[identifier] and data[identifier].kills or 0
	
	SetNuiFocus(true, true)
	SendNUIMessage({action = 'show', type = 'daily', scoreboard = scoreboard, kills = kills})
end)

RegisterNetEvent('ghetto:showWeeklyKills')
AddEventHandler('ghetto:showWeeklyKills', function(data)
	local scoreboard = {}
	
	for k,v in pairs(data) do
		table.insert(scoreboard, {kills = v.kills, name = v.name})
	end
	
	table.sort(scoreboard, function(a,b) return a.kills > b.kills end)
	
	local identifier = ESX.GetPlayerData().identifier
	local kills = data[identifier] and data[identifier].kills or 0
	
	SetNuiFocus(true, true)
	SendNUIMessage({action = 'show', type = 'weekly', scoreboard = scoreboard, kills = kills})
end)

RegisterNUICallback('quit', function(data)
	SetNuiFocus(false, false)
end)

--[[AddEventHandler('esx:onPlayerDeath', function(data)
	if inRedzone then
		local weapon = GetSelectedPedWeapon(PlayerPedId())
		TriggerServerEvent('ghetto:onPlayerDeath', weapon)
	end
end)]]

RegisterNetEvent('ghetto:onPlayerDeath')
AddEventHandler('ghetto:onPlayerDeath', function(coords, id, weaponName)
	if inRedzone then
		local coords = vector3((coords.x + 1.0), (coords.y + 1.0), coords.z)
		local weaponHash = GetHashKey(weaponName)
		
		WeaponAssetLoad(weaponHash)
		
		droppedWeapons[id] = {obj = CreateWeaponObject(weaponHash, 50, coords.x, coords.y, coords.z, true, 1.0, 0), coords = coords}
		
		while not DoesEntityExist(droppedWeapons[id].obj) do
			Wait(100)
		end
		
		PlaceObjectOnGroundProperly(droppedWeapons[id].obj)
		coords = GetEntityCoords(droppedWeapons[id].obj)
		SetEntityCoords(droppedWeapons[id].obj, coords.x, coords.y, coords.z - 0.05)
		SetEntityRotation(droppedWeapons[id].obj, 90.0, 0.0, 0.0)
		
		RemoveWeaponAsset(weaponHash)
	end
end)

RegisterNetEvent('ghetto:getDroppedWeapon')
AddEventHandler('ghetto:getDroppedWeapon', function(id)
	if droppedWeapons[id] then
		if DoesEntityExist(droppedWeapons[id].obj) then
			DeleteEntity(droppedWeapons[id].obj)
		end
	end
	
	droppedWeapons[id] = nil
end)

RegisterNetEvent('ghetto:showLeaderboard')
AddEventHandler('ghetto:showLeaderboard',function(scoreboard,mykills)
	SendNUIMessage({action = 'show', type = 'leaderboard', scoreboard = scoreboard, kills = mykills, runningperiod = Config.RunningPeriodText})
	SetNuiFocus(true,true)
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k,v in pairs(droppedWeapons) do
			if DoesEntityExist(v.obj) then
				DeleteEntity(v.obj)
			end
		end
	end
end)

function WeaponAssetLoad(weaponHash)
	if not HasWeaponAssetLoaded(weaponHash) then
		RequestWeaponAsset(weaponHash)
		
		while not HasWeaponAssetLoaded(weaponHash) do
			Citizen.Wait(0)
		end
	end
end

function RewardsMenu()
	local tempData
	
	ESX.TriggerServerCallback('ghetto:getData', function(data) tempData = data end, false)
	while tempData == nil do Wait(0) end
	ghetto = tempData
	
	local elements = {}
	
	for k,v in pairs(ghetto.weapons) do
		table.insert(elements, {label = string.gsub(v, 'WEAPON_', ''), value = k})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rewards', {
		title    = 'Rewards',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		local id = data.current.value
		menu.close()
		
		ESX.TriggerServerCallback('ghetto:getReward', function()
			RewardsMenu()
		end, id)
	end,
	function(data, menu)
		menu.close()
	end)
end

function SetupGhetto()
	CreateNPC(Config.NPC.model, Config.Coords[currentIndex].coords, Config.Coords[currentIndex].heading)
	
	blip = AddBlipForCoord(Config.Coords[currentIndex].coords)
	
	SetBlipHighDetail(blip, true)
	SetBlipSprite(blip, 437)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, 39)
	SetBlipAsShortRange(blip, true)
	
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Ghetto')
	EndTextCommandSetBlipName(blip)
	
	blipRadius = AddBlipForRadius(Config.Coords[currentIndex].coords, Config.Coords[currentIndex].radius)
	SetBlipHighDetail(blipRadius, true)
	
	if ghettoStarted then
		SetBlipColour(blipRadius, 27)
	else
		SetBlipColour(blipRadius, 1)
	end
	
	SetBlipAlpha(blipRadius, 128)
end

function CreateNPC(model, coords, heading)
	RequestModel(model)
	
	while not HasModelLoaded(model) do
		Wait(10)
	end
	
	RequestAnimDict('mini@strip_club@idles@bouncer@base')
	
	while not HasAnimDictLoaded('mini@strip_club@idles@bouncer@base') do
		Wait(10)
	end
	
	local npc = CreatePed(5, model, coords.x, coords.y, coords.z - 1.0, heading, false, true)
	SetPedDefaultComponentVariation(npc)
	SetEntityHeading(npc, heading)
	FreezeEntityPosition(npc, true)
	SetEntityInvincible(npc, true)
	SetBlockingOfNonTemporaryEvents(npc, true)
	
	TaskPlayAnim(npc, 'mini@strip_club@idles@bouncer@base', 'base', 8.0, 0.0, -1, 1, 0, 0, 0, 0)
	
	SetModelAsNoLongerNeeded(model)
	
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

function DrawText3D(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
	
    local scale = math.floor(400) / (GetGameplayCamFov() * dist)
	
    SetTextColour(math.floor(255), math.floor(255), math.floor(255), math.floor(255))
	SetTextScale(0.0, 0.3 * scale)
	SetTextFont(math.floor(7))
	SetTextDropshadow(math.floor(0), math.floor(0), math.floor(0), math.floor(0), math.floor(55))
	SetTextDropShadow()
	SetTextCentre(true)
	
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	SetDrawOrigin(coords.x, coords.y, coords.z + 1.0, math.floor(0))
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end

exports('IsOnGhetto', function()
	return inRedzone
end)

exports('getRespawnCoords', function()
	return Config.Coords[currentIndex].respawnCoords
end)

exports('IsOnGhettoRadius', function()
	local coords = GetEntityCoords(PlayerPedId())
	local redzoneDist = #(vector2(coords.x, coords.y) - vector2(Config.Coords[currentIndex].coords.x, Config.Coords[currentIndex].coords.y))
	return redzoneDist < Config.Coords[currentIndex].radius
end)

exports('hasGhettoStarted', function()
	if ghettoStarted then
		local hasvip
		ESX.TriggerServerCallback('ghetto:getGhettoVip', function(vip)
			hasvip = vip
		end)

		while hasvip == nil do Wait(0) end

		return not hasvip
	else
		return false
	end
end)