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
local KilledByStaff = false

local FirstSpawn, PlayerLoaded = true, false
local actuallyDeadSent = false
needsSurgery, inSurgery, isSedatived = false, false, nil
--local bag
isActuallyDead = false
IsDead = false
local revivedFromMedkit = false
ESX = nil

local clTimer = nil
local canRespawn = false
local canPayRespawn = false

local currentBucket = 0
local currentBucketName = 'default'

local weaponCooldown = 0
local timesCalledNpc = 0

local tempGreenzoneTimer
local tempGreenzoneCoords

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
	
	Wait(100)
	
	--[[ESX.TriggerServerCallback('esx_ambulancejob:getTempGreenzone', function(seconds, coords)
		if seconds then
			Wait(1000)
			--ProcessTempGreenzone(seconds, coords)
		end
	end)]]
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	
	if ESX.PlayerData.job.name == 'ambulance' then
		radarCd = GetGameTimer() + 2*60000
	end
end)

AddEventHandler('buckets:onBucketChanged', function(bucketId, bucketName)
	currentBucket = bucketId
	currentBucketName = bucketName
end)

RegisterNetEvent('esx_ambulancejob:weaponCooldown')
AddEventHandler('esx_ambulancejob:weaponCooldown', function(seconds)
	if seconds > 0 then
		ProcessWeaponCooldown(seconds)
	else
		weaponCooldown = 0
	end
end)

AddEventHandler('playerSpawned', function()
	isSedatived = nil
	
	if FirstSpawn then
		exports.spawnmanager:setAutoSpawn(false) -- disable respawn
		FirstSpawn = false
		
		while not PlayerLoaded do
			Citizen.Wait(0)
		end
		
		ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(dead)
			TriggerEvent('closeInventoryHUD', 18000)
			
			if dead ~= nil and dead and Config.AntiCombatLog then
				IsDead = true
				clTimer = GetGameTimer() + 10000
				--FixCombatLogShit()
				TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)
				StartScreenEffect('DeathFailOut', 0, false)
				Citizen.Wait(1000)
				ESX.ShowNotification(_U('combatlog_message'))
				RemoveItemsAfterRPDeath()
				Wait(1000)
				IsDead = false
			else
				clTimer = 0
			end
		end)
	else
		while clTimer == nil or clTimer > GetGameTimer() do
			Wait(1000)
		end

		IsDead = false
		TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
	end
end)

--[[function FixCombatLogShit()
	Citizen.CreateThread(function()
		while clTimer > GetGameTimer() do
			if not IsEntityDead(PlayerPedId()) then
				SetEntityHealth(PlayerPedId(), 0)
				TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)
			end
			
			Wait(100)
		end
	end)
end]]

-- Create blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.Hospitals) do
		if v.Blip then
			local blip = AddBlipForCoord(v.Blip.coords)

			SetBlipSprite(blip, v.Blip.sprite)
			SetBlipScale(blip, v.Blip.scale)
			SetBlipColour(blip, v.Blip.color)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(_U('hospital'))
			EndTextCommandSetBlipName(blip)
		end
	end
end)


local pulse = 100
local blood = 100

-- Disable most inputs when dead
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsDead then
			DisableAllControlActions(0)
			
			EnableControlAction(0, Keys['G'], true)
			EnableControlAction(0, Keys['F'], true)
			EnableControlAction(0, Keys['`'], true)
			EnableControlAction(0, Keys['~'], true)
			EnableControlAction(0, Keys['E'], true)
			EnableControlAction(0, Keys['SHIFT'], true)
			
			DisableControlAction(0, Keys['N'], true)
			DisableControlAction(1, Keys['N'], true)
			DisableControlAction(2, Keys['N'], true)
		else
			blood = 100
			pulse = 100
			Citizen.Wait(500)
		end
		
		if needsSurgery then
			--Drunk
			RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
			while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
				Citizen.Wait(0)
			end
			ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.08)
			SetTimecycleModifier("spectator5")
			SetPedMotionBlur(GetPlayerPed(-1), true)
			SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
			SetPedIsDrunk(GetPlayerPed(-1), true)
		end
		
		if inSurgery then
			inSurgery = false
			DoScreenFadeOut(1000)
			Citizen.Wait(1000)
			DoScreenFadeIn(1000)
			ClearTimecycleModifier()
			ResetScenarioTypesEnabled()
			ResetPedMovementClipset(GetPlayerPed(-1), 0)
			SetPedIsDrunk(GetPlayerPed(-1), false)
			SetPedMotionBlur(GetPlayerPed(-1), false)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1500)
		
		if not IsEntityDead(PlayerPedId()) and not GlobalState.inCTF and not GlobalState.inTournament then
			for k,v in pairs(GetActivePlayers()) do
				if v ~= PlayerId() and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(GetPlayerPed(v))) < 5.0 and IsEntityDead(GetPlayerPed(v)) then
					while #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(GetPlayerPed(v))) < 5.0 and IsEntityDead(GetPlayerPed(v)) do
						Wait(0)
						DrawText3D(GetEntityCoords(GetPlayerPed(v)), '[G] Give First Aid')
						
						if IsControlJustReleased(0, Keys['G']) then
							if not IsEntityDead(PlayerPedId()) then
								if ESX.DoIHaveItem('first_aid_kit',1) then
									ClearPedTasksImmediately(PlayerPedId())
									
									Citizen.CreateThread(function()
										local endTimer = GetGameTimer() + 3000
										
										while endTimer > GetGameTimer() do
											DisableAllControlActions()
											EnableControlAction(0, 25, true)
											Wait(0)
										end
									end)
									
									ExecuteCommand('e cpr')
									TriggerServerEvent('esx_ambulancejob:giveFirstAid', GetPlayerServerId(v))
									Wait(3000)
									ExecuteCommand('e c')
								else
									ESX.ShowNotification('You need a First Aid Kit')
								end
							end
							
							Wait(1000)
						end
					end
				end
				
				Wait(150)
			end
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:giveFirstAidOld')
AddEventHandler('esx_ambulancejob:giveFirstAidOld', function(caller)
	local endTimer = GetGameTimer() + 20000
	
	Citizen.CreateThread(function()
		local acceptHelp
		
		while endTimer > GetGameTimer() and IsEntityDead(PlayerPedId()) do
			Wait(0)
			
			if pulse < 6 or blood < 21 then
				break
			end
			
			DrawText3D(GetEntityCoords(PlayerPedId()), '[~g~Y~w~] Accept help [~r~D~w~] Decline help\n~r~'..math.floor(endTimer-GetGameTimer()))
			
			if IsDisabledControlJustReleased(0, 246) then	--Y
				acceptHelp = true
				TriggerServerEvent('esx_ambulancejob:acceptFirstAid', caller, true)
				break
			elseif IsDisabledControlJustReleased(0, 35) then	--D
				acceptHelp = false
				TriggerServerEvent('esx_ambulancejob:acceptFirstAid', caller, false)
				break
			end
		end
		
		if acceptHelp == nil then
			TriggerServerEvent('esx_ambulancejob:acceptFirstAid', caller, false)
		end
	end)
end)

RegisterNetEvent('esx_ambulancejob:giveFirstAid')
AddEventHandler('esx_ambulancejob:giveFirstAid', function(caller)
	--Wait(1000) --Workaround for headshot
	
	--[[ if pulse < 6 or blood < 21 then
		TriggerServerEvent('esx_ambulancejob:acceptFirstAid', caller, false)
		return
	end ]]
	
	TriggerServerEvent('esx_ambulancejob:acceptFirstAid', caller, true)
end)

RegisterNetEvent('revivedFromMedkit')
AddEventHandler('revivedFromMedkit', function()
	revivedFromMedkit = true
end)

RegisterNetEvent('esx_ambulancejob:toggleSedative')
AddEventHandler('esx_ambulancejob:toggleSedative',function(sedative)
	isSedatived = sedative
	
	if isSedatived then
		Citizen.CreateThread(function()
			DoScreenFadeOut(1000)
			Citizen.Wait(1000)
			DoScreenFadeIn(1000)
			
			while isSedatived ~= nil do
				RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
				while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
					Citizen.Wait(0)
				end
				
				SetPlayerSprint(PlayerId(), false)
				SetTimecycleModifier("spectator5")
				SetPedMotionBlur(PlayerPedId(), true)
				SetPedMovementClipset(PlayerPedId(), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
				SetPedIsDrunk(PlayerPedId(), true)
				
				Wait(100)
			end
			
			ClearTimecycleModifier()
			ResetScenarioTypesEnabled()
			ResetPedMovementClipset(PlayerPedId(), 0)
			SetPedIsDrunk(PlayerPedId(), false)
			SetPedMotionBlur(PlayerPedId(), false)
		end)
	end
end)

RegisterNetEvent('esx_ambulancejob:updatePulseBlood')
AddEventHandler('esx_ambulancejob:updatePulseBlood',function(cBlood,cPulse)
	pulse = cPulse
	blood = cBlood
	
	if pulse < 6 or blood < 21 then
		if not actuallyDeadSent then
			
			TriggerServerEvent('esx_ambulancejob:setMeActuallyDead',true)
			actuallyDeadSent = true
		end
	else
		actuallyDeadSent = false
	end
end)

Citizen.CreateThread(function()
	while ESX == nil do
		Wait(1000)
	end
	
	while ESX.PlayerData == nil do
		Wait(1000)
	end
	
	Wait(5000)
	
	local subscription = ESX.PlayerData.subscription or ''
	
	if (subscription == "level1" or subscription == "level2" or subscription == "level3" or subscription == "level4") then
		while true do
			Citizen.Wait(1000)
			
			ResetPlayerStamina(PlayerId())
			
			if subscription == "level2" or subscription == "level3" or subscription == "level4" then
				SetRunSprintMultiplierForPlayer(PlayerId(), 1.2)
			end
		end
	end
end)

local autoReviveZones = {
	--{coords = vector3(1489.68, 3202.18, 40.45), radius = 200.0},
}
function OnPlayerDeath()
	IsDead = true
	canRespawn = false
	canPayRespawn = false
	revivedFromMedkit = false
	
	SetEntityHealth(PlayerPedId(),0)
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)
	
	local coords = GetEntityCoords(PlayerPedId())
	for k,v in pairs(autoReviveZones) do
		if #(coords - v.coords) < v.radius then
			TriggerEvent('esx_ambulancejob:revlve', true, 150)
			ESX.ShowNotification('You autorespawned!')
			return
		end
	end
	
	local isArmed = (GetSelectedPedWeapon(PlayerPedId()) ~= `WEAPON_UNARMED`)
	
	leDontZones = {
		[vector3(-1022.86, -998.41, 2.15)] = 150,
		[vector3(-2289.67, 210.79, 167.60)] = 75,
		[vector3(1254.63, -1653.02, 45.74)] = 150,
		[vector3(-855.55, -416.53, 35.64)] = 150,
		[vector3(-48.92, -181.01, 53.27)] = 150,
		[vector3(63.35, -1728.71, 28.64)] = 150,
	}
	
	local isOnDontDoItZone = false
	for k,v in pairs(leDontZones) do
		if #(GetEntityCoords(PlayerPedId()) - k) < v then
			isOnDontDoItZone = true
		end
	end

	local currentEvent = GlobalState.inEvent
	local eventsConfig = {}
	if GetResourceState('generalScript') == 'started' then
		eventsConfig = exports.generalScript:getEventsConfig()
	end
	
	if isArmed and not currentEvent then
		if ESX.PlayerData and ESX.PlayerData.job and ESX.PlayerData.job.name ~= "police" then
			TriggerServerEvent('esx_ambulancejob:weaponCooldown')
			ProcessWeaponCooldown(Config.WeaponCooldown)
		end
	end
	
	--[[if #(GetEntityCoords(PlayerPedId()) - vector3(4500.57, -627.31, 19.27)) > 500 and not GlobalState.inPUBG and not isOnRaid then
		--ProcessTempGreenzone()
	end]]
	
	if GlobalState.inMilitaryRaid or GlobalState.inCTF or GlobalState.inGungame or GlobalState.inTournament then
		return
	end
	
	Citizen.CreateThread(SelfReviveText)
	
	if not currentEvent or not eventsConfig[currentEvent] or not eventsConfig[currentEvent].respawnTime then
		StartDistressSignal()
		RespawnText()
		
		StartScreenEffect('DeathFailOut', 0, false) 
		ClearPedTasksImmediately(PlayerPedId())
	else
		Citizen.CreateThread(function()
			print('IN EVENT', currentEvent)
			
			local respawnTime = eventsConfig[currentEvent].respawnTime
			ESX.ShowNotification('Περίμενε '..respawnTime..' δευτερόλεπτα')
			Wait(respawnTime * 1000)
			
			------------------------------------------------------------------------------------
			
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
			Wait(500)

			if eventsConfig[currentEvent].removeStuff(revivedFromMedkit) then
				local done = false
				ESX.TriggerServerCallback('esx_ambulancejob:removeWeaponsItems', function(cb)
					done = true
				end, currentEvent)

				while not done do Wait(100) end

				Wait(1000)
			end
			
			if eventsConfig[currentEvent].respawnPosition(Config.RespawnPoints, revivedFromMedkit) then
				TriggerEvent('respawn_event:select', currentEvent)
			end

			--[[local respawnCoords = eventsConfig[currentEvent].respawnPosition(Config.RespawnPoints, revivedFromMedkit)
			
			SetEntityCoords(PlayerPedId(), eventsConfig[currentEvent].respawnPosition(Config.RespawnPoints, revivedFromMedkit))
			Wait(1000)
			TriggerEvent('esx_ambulancejob:revlve', true, 150)]]
		end)
	end
end

function ProcessWeaponCooldown(seconds)
	if weaponCooldown > 0 then
		return
	end
	
	weaponCooldown = GetGameTimer() + seconds*1000
	
	Citizen.CreateThread(function()
		while weaponCooldown > GetGameTimer() do
			if GetSelectedPedWeapon(PlayerPedId()) ~= `WEAPON_UNARMED` then
				SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
			end
			
			Wait(100)
		end
		
		weaponCooldown = 0
	end)
end

function totime(ms)
	local secs = ms / 1000

	local minutes = math.floor(secs / 60)
	local seconds = math.floor(secs % 60)

	local final = string.format('%02.f', minutes)..':'..string.format('%02.f', math.floor(seconds))
	return final
end

function DrawClassicText(x,y ,width,height,scale,text, r,g,b,a)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour( 0,0,0, 255 )
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(x - width/2, y - height/2 + 0.005)
end

function ProcessTempGreenzone(seconds, coords)
	local seconds = seconds or Config.TemporaryGreenzoneTimer
	tempGreenzoneTimer = GetGameTimer() + seconds*1000
	tempGreenzoneCoords = coords or GetEntityCoords(PlayerPedId())
	
	TriggerServerEvent('esx_ambulancejob:saveTempGreenzone', tempGreenzoneCoords)
	
	Citizen.CreateThread(function()
		while tempGreenzoneTimer > GetGameTimer() do
			DrawClassicText(0.58, 1.27, 1.0, 1.0, 0.4, "~g~Death Greenzone Time Remaining " .. totime(seconds-(GetGameTimer() - tempGreenzoneTimer)), 255, 1, 255, 255)

			if #(GetEntityCoords(PlayerPedId()) - tempGreenzoneCoords) < Config.TemporaryGreenzoneRadius then
				if GetSelectedPedWeapon(PlayerPedId()) ~= `WEAPON_UNARMED` then
					SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
					
					local minutesLeft = math.ceil((tempGreenzoneTimer - GetGameTimer())/60000)
					ESX.ShowNotification('You have a temporary cooldown at this area</br>Timeleft: '..minutesLeft..' minutes')
				end
			end
			
			Wait(0)
		end
		
		Wait(1000)
		--TriggerServerEvent('esx_ambulancejob:removeTempGreenzone')
	end)
end

RegisterNetEvent('esx_ambulancejob:resetAbuseCooldown')
AddEventHandler('esx_ambulancejob:resetAbuseCooldown', function()
	tempGreenzoneTimer = 0
end)

RegisterNetEvent('esx_ambulancejob:useItem')
AddEventHandler('esx_ambulancejob:useItem', function(itemName)
	ESX.UI.Menu.CloseAll()

	if itemName == 'medikit' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, 7000, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end
	
			TriggerEvent('esx_ambulancejob:heal', 'big', true)
			ESX.ShowNotification(_U('used_medikit'))
		end)

	elseif itemName == 'bandage' then
		--[[ local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end

			TriggerEvent('esx_ambulancejob:heal', 'small', true)
			ESX.ShowNotification(_U('used_bandage'))
		end) ]]


		local lib, anim = 'clothingshirt', 'try_shirt_positive_d' -- TODO better animations
		local playerPed = PlayerPedId()
		
		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 3.5, -8, -1, 49, 0, 0, 0, 0)
			
			TriggerEvent('mythic_progressbar:client:progress', {
				name = 'using_bandage',
				duration = 4000,
				label = 'Using Bandage...',
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = true,
				},
			}, function(cancelled)
				if not cancelled then
					TriggerEvent('esx_ambulancejob:heal', 'bandage', true)
					ESX.ShowNotification(_U('used_bandage'))
				end
			end)
		end)
	elseif itemName == 'bandage2' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end

			TriggerEvent('esx_ambulancejob:heal', 'smallBandage2', true)
			ESX.ShowNotification(_U('used_bandage2'))
		end)
	elseif itemName == 'pausipono' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end

			TriggerEvent('esx_ambulancejob:heal', 'small/2', true)
			ESX.ShowNotification(_U('used_pausipono'))
		end)
	end
end)

RegisterNetEvent('esx_ambulancejob:stopBleeding')
AddEventHandler('esx_ambulancejob:stopBleeding', function(item)
	local playerPed = PlayerPedId()
	if GetEntityHealth(playerPed) < 120 then
		StopScreenEffect('Rampage')
		SetEntityHealth(playerPed,150)
		TriggerServerEvent('esx_ambulancejob:stopBleed',item)
	end
end)

RegisterNetEvent('esx_ambulancejob:useDefibrillator')
AddEventHandler('esx_ambulancejob:useDefibrillator', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer == -1 or closestDistance > 1.0 then
		ESX.ShowNotification(_U('no_players'))
	else
		ESX.ShowNotification(_U('revive_inprogress'))

		local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

		for i=1, 15, 1 do
			Citizen.Wait(900)

			ESX.Streaming.RequestAnimDict(lib, function()
				TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
			end)
		end
		TriggerServerEvent('esx_ambulancejob:revlveWithDefibrillator', GetPlayerServerId(closestPlayer))
	end
end)

RegisterNetEvent('esx_ambulancejob:adrenaline')
AddEventHandler('esx_ambulancejob:adrenaline', function()
	isSedatived = nil
	local runFast = true
	
	CreateThread(function()
		Wait(40000)
		runFast = false
	end)
	CreateThread(function()
		while runFast do
			ResetPlayerStamina(PlayerId())
			Wait(0)
		end
	end)
	RestorePlayerStamina(GetPlayerPed(-1), 200)
	
end)

RegisterNetEvent('esx_ambulancejob:adrenalinelsd')
AddEventHandler('esx_ambulancejob:adrenalinelsd', function()
	local runFast = true
	CreateThread(function()
		Wait(4000)
		runFast = false
	end)
	CreateThread(function()
		while runFast do
			ResetPlayerStamina(PlayerId())
			Wait(0)
		end
	end)
	
end)

RegisterNetEvent('esx_ambulancejob:cannabisenergydrink')
AddEventHandler('esx_ambulancejob:cannabisenergydrink', function()
	local runFast = true
	CreateThread(function()
		Wait(20000)
		runFast = false
	end)
	CreateThread(function()
		while runFast do
			ResetPlayerStamina(PlayerId())
			Wait(0)
		end
	end)
	
end)

RegisterNetEvent('esx_ambulancejob:addTempGreenzone')
AddEventHandler('esx_ambulancejob:addTempGreenzone', function()
	Wait(1000)
	--ProcessTempGreenzone()
end)
MutedPlayers = {}
function StartDistressSignal()
	Citizen.CreateThread(function()
		Wait(1000)
		
		local isHeadshot
		if KilledByStaff == true then 
			return
		end
		TriggerEvent('medSystem:isHeadshot', function(answer)
			isHeadshot = answer
		end)
		
		while isHeadshot == nil do
			Wait(100)
		end
		
		if not isHeadshot then
			while IsDead do
				for k,v in pairs(GetActivePlayers()) do
					if not MutedPlayers[v] then
						local serverID = GetPlayerServerId(v)
						MutedPlayers[serverID] = true
					    MumbleSetVolumeOverrideByServerId(serverID, 0.0)
					end
				end
				Citizen.Wait(0)
				SetTextFont(4)
				SetTextProportional(1)
				SetTextScale(0.5, 0.5)
				--SetTextColour(255, 0, 0, 255)
				SetTextDropShadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				BeginTextCommandDisplayText('STRING')
				AddTextComponentSubstringPlayerName('Press ~y~F~s~ to send signal [NPC]\nPress ~g~H~s~ to call a [MEDIC]\nPress ~g~G~s~ To Pay '..Config.PayRespawn..'$')
				EndTextCommandDisplayText(0.440, 0.650)
				
				if IsControlJustPressed(0, Keys['F']) then --F Key
					local coords = GetEntityCoords(PlayerPedId())
					local zoneName = GetNameOfZone(coords.x, coords.y, coords.z)
					
					if Config.BlacklistedNpcZones[zoneName] == nil and not IsEntityInWater(PlayerPedId()) then
						SendDistressSignal(true)
						break
					else
						ESX.ShowNotification('You cant call a NPC from this zone')
					end
				elseif IsControlJustPressed(0, Keys['H']) or IsDisabledControlJustPressed(0, Keys['H']) then --H Key
					TriggerServerEvent('esx_ambulancejob:GetHelp')
					break
				elseif IsControlJustPressed(0, Keys['G']) or IsDisabledControlJustPressed(0, Keys['G']) then --G Key
					local data = exports['dialog']:Decision('Are you sure?', 'Are you sure you want to perform this action?')
					local answer = tonumber(data.value)
					if answer == 1 then
						ESX.TriggerServerCallback('esx_ambulancejob:PayRespawn', function(answer) 
							if answer then
								ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
									local coords = GetEntityCoords(PlayerPedId())
									
									local id = 1
									local dist = #(coords - Config.RespawnPoints[id].coords)
									
									for k,v in ipairs(Config.RespawnPoints) do
										if #(coords - v.coords) < dist then
											dist = #(v.coords - coords)
											id = k
										end
									end
									
									local formattedCoords = {
										x = Config.RespawnPoints[id].coords.x,
										y = Config.RespawnPoints[id].coords.y,
										z = Config.RespawnPoints[id].coords.z
									}
						
									ESX.SetPlayerData('lastPosition', formattedCoords)
									--[[ ESX.SetPlayerData('loadout', {}) ]]
									
									TriggerServerEvent('esx:updateLastPosition', formattedCoords)
									RespawnPed(PlayerPedId(), formattedCoords, Config.RespawnPoints[id].heading)
									DisableControlAction(0, 289)
									TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
									TriggerServerEvent('esx_ambulancejob:setMeActuallyDead',false)
									actuallyDeadSent = false
									blood = 100
									pulse = 100
									StopScreenEffect('DeathFailOut')
									StopAllScreenEffects()
									local timer = GetGameTimer() + 2000
									while GetGameTimer() < timer do
										DisableControlAction(0, 289)
										Wait(0)
									end
									
									TriggerEvent('esx_basicneeds:resetStatus')
								end)
							end
						end)
						break
					end
				end
			end
		end
	end)
end

function SelfReviveText()
	if KilledByStaff == true then 
		return
	end
	if ESX.DoIHaveItem('adrenaline',1) or ESX.DoIHaveItem('pr_adrenaline',1) then
		while IsDead do
			Citizen.Wait(0)
			SetTextFont(4)
			SetTextProportional(1)
			SetTextScale(0.5, 0.5)
			--SetTextColour(255, 0, 0, 255)
			SetTextDropShadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName('Press ~b~E~s~ to use ~b~Adrenaline~s~ / ~b~H~s~ to use ~b~Premium Adrenaline~s~')
			EndTextCommandDisplayText(0.440, 0.750)
			
			if IsControlJustPressed(0, Keys['E']) or IsDisabledControlJustPressed(0, Keys['E']) then
				TriggerServerEvent('esx_ambulancejob:selfrevive')
				break
			elseif  IsControlJustPressed(0, Keys['H']) or IsDisabledControlJustPressed(0, Keys['H']) then
				TriggerServerEvent('esx_ambulancejob:selfrevive2')
				break
			end
		end
	end
end

function RespawnText()
	local timeLeft = Config.AutoRespawnTimer
	local respawnTimer = Config.AutoRespawnTimer
	if ESX.PlayerData and ESX.PlayerData.subscription and ESX.PlayerData.subscription == "level2" then
		timeLeft = 50
		respawnTimer = 50
	elseif ESX.PlayerData and ESX.PlayerData.subscription and (ESX.PlayerData.subscription == "level3" or ESX.PlayerData.subscription == "level4") then
		timeLeft = 30
		respawnTimer = 30
	end 
	local timeTxt = (('%02d:%02d'):format(math.floor(timeLeft/60), math.floor(timeLeft%60)))
	
	Citizen.CreateThread(function()
		Wait(1000)
		
		TriggerEvent('medSystem:isHeadshot', function(isHeadshot)
			if isHeadshot and Config.AutoRespawnTimerHS < timeLeft then
				timeLeft = Config.AutoRespawnTimerHS
			end
		end)
		
		if exports.zones:IsInDangerZone() then
			timeLeft = 20
			respawnTimer = 20
		end
		
		while IsDead do
			Wait(1000)
			timeLeft = timeLeft - 1
			timeTxt = (('%02d:%02d'):format(math.floor(timeLeft/60), math.floor(timeLeft%60)))
			
			if (timeLeft + Config.AllowPayRespawnAfter) < respawnTimer then
				canPayRespawn = true
			end
			
			if timeLeft == 0 then
				canRespawn = true
				break
			end
		end
	end)
	
	Citizen.CreateThread(function()
		while IsDead do
			Citizen.Wait(30000)
			
			if IsDead then
				ClearPedTasksImmediately(GetPlayerPed(-1))
			end
		end
	end)
	
	Citizen.CreateThread(function()
		local isCriminal = false
		
		ESX.TriggerServerCallback('esx_ambulancejob:CheckCriminal', function(data) 
			if data then
				isCriminal = true
			end
		end)
		
		while IsDead do
			if canRespawn then
				SetTextFont(4)
				SetTextProportional(1)
				SetTextScale(0.5, 0.5)
				SetTextDropShadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				BeginTextCommandDisplayText('STRING')
				if isCriminal then
					AddTextComponentSubstringPlayerName('Press ~r~F8~s~ and type ~r~criminal_respawn~s~ to respawn (New Life Rule).')
				elseif ESX.PlayerData.job.name == 'police' then
					AddTextComponentSubstringPlayerName('Press ~r~F8~s~ and type ~r~police_respawn~s~ to respawn (New Life Rule).')
				else
					AddTextComponentSubstringPlayerName('Press ~r~F8~s~ and type ~r~respawn~s~ to respawn (New Life Rule).')
				end
				EndTextCommandDisplayText(0.430, 0.800)
			elseif canPayRespawn then
				SetTextFont(4)
				SetTextProportional(1)
				SetTextScale(0.5, 0.5)
				SetTextDropShadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				BeginTextCommandDisplayText('STRING')
				if isCriminal then
					AddTextComponentSubstringPlayerName('Press ~r~F8~s~ and type ~r~criminal_payrespawn~s~ and pay ~g~$'..Config.PayRespawnPrice..'~s~ to respawn (NLR) | ~r~'..timeTxt..'~s~')
				else
					AddTextComponentSubstringPlayerName('Press ~r~F8~s~ and type ~r~payrespawn~s~ and pay ~g~$'..Config.PayRespawnPrice..'~s~ to respawn (NLR) | ~r~'..timeTxt..'~s~')
				end
				EndTextCommandDisplayText(0.380, 0.800)
			else
				SetTextFont(4)
				SetTextProportional(1)
				SetTextScale(0.5, 0.5)
				SetTextDropShadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				BeginTextCommandDisplayText('STRING')
				AddTextComponentSubstringPlayerName('Respawn Available: ~r~'..timeTxt..'~s~')
				EndTextCommandDisplayText(0.440, 0.800)
			end
			
			Wait(0)
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		if needsSurgery then
			if math.floor(GetGameTimer()/1000 - surgeryTimer) >  15*60 then --seconds
				TriggerEvent('esx_ambulancejob:sendHelp')
			else
				
				ESX.ShowNotification('Go see a doctor, you need a surgery!')
			end
		end
		
		Wait(90000)	
	end
end)

RegisterNetEvent('esx_ambulancejob:sendHelp')
AddEventHandler('esx_ambulancejob:sendHelp',function()
	needsSurgery = false
	inSurgery = true
end)

function SendDistressSignal(sendToNPC)
	local coords = GetEntityCoords(PlayerPedId())

	local dontsendmecoords = {
		{coords = vector3(91.61, 3750.05, 43.88), radius = 250.0},
		{coords = vector3(2328.65, 2569.53, 46.68), radius = 250.0},
		{coords = vector3(2431.76, 4970.57, 42.35), radius = 250.0},
		{coords = vector3(-2055.85, 3239.27, 31.50), radius = 250.0},
		{coords = vector3(-1554.13, 2882.12, 31.12), radius = 300.0},
	}

	for i=1, #dontsendmecoords do
		if #(GetEntityCoords(PlayerPedId()) - dontsendmecoords[i].coords) < dontsendmecoords[i].radius then
			ESX.ShowNotification('Invalid Coords')
			return
		end
	end
	
	ESX.TriggerServerCallback('esx_ambulancejob:canCallMedicNpc', function(yes)
		if yes then
			ProcessNpcMedic()
		end
	end)
	
	--[[TriggerEvent("teleport:getPlayerInsideTP", function(tpCoords)
		local PlayerCoords = { x = coords.x, y = coords.y, z = coords.z }

		if (tpCoords ~= nil and sendToNPC) or not sendToNPC then
			ESX.ShowNotification('Distress signal has been sent to available units!')
			
			if tpCoords ~= nil then
				coords = tpCoords
				PlayerCoords = { x = coords.x, y = coords.y, z = coords.z }
			end
			
			TriggerServerEvent('esx_addons_gcphone:startCall', 'ambulance', "medical attention required: unconscious citizen! Postal: " .. exports["rp_general"]:getPostal(), PlayerCoords, {
				PlayerCoords = { x = coords.x, y = coords.y, z = coords.z },
			})
		elseif tpCoords == nil and sendToNPC then
			ESX.ShowNotification('Distress signal has been sent to the npc medics!')
			
			ProcessNpcMedic()
		end
	end)]]
end

function ProcessNpcMedic()
	timesCalledNpc = timesCalledNpc + 1
	
	local coords = GetEntityCoords(PlayerPedId())
	
	--[[local id = 1
	local dist = Config.MaxNpcDistance
	
	for k,v in ipairs(Config.RespawnPoints) do
		local tempDist = CalculateTravelDistanceBetweenPoints(coords.x, coords.y, coords.z, v.coords.x, v.coords.y, v.coords.z)
		
		if tempDist < dist and tempDist < Config.MaxNpcDistance then
			dist = tempDist
			id = k
		end
	end
	
	if dist > Config.MaxNpcDistance then
		SendDistressSignal(false)
		return
	end]]
	
	local npcCame = false
	local timeLeft = 5
	
	if timesCalledNpc % 3 == 0 then
		timeLeft = 300	--seconds
	end
	
	local timeTxt = (('%02d:%02d'):format(math.floor(timeLeft/60), math.floor(timeLeft%60)))
	
	CreateThread(function()
		while IsDead and not npcCame and not actuallyDeadSent do
			SetTextFont(4)
			SetTextProportional(1)
			SetTextScale(0.5, 0.5)
			SetTextDropShadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName('ETA: ~r~'..timeTxt)
			EndTextCommandDisplayText(0.440, 0.750)
			
			Wait(0)
		end
	end)
	
	CreateThread(function()
		while IsDead and not npcCame do
			Wait(1000)
			timeLeft = timeLeft - 1
			timeTxt = (('%02d:%02d'):format(math.floor(timeLeft/60), math.floor(timeLeft%60)))
			
			if timeLeft == 0 then
				npcCame = true
			end
			
			if actuallyDeadSent then
				break
			end
		end
		
		if actuallyDeadSent then
			ESX.ShowNotification('Unfortunately you are clinical dead')
			return
		end
		
		if IsDead and npcCame then
			RequestModel(`s_m_m_paramedic_01`)
			
			while not HasModelLoaded(`s_m_m_paramedic_01`) do
				Wait(10)
			end
			
			local coords = GetEntityCoords(PlayerPedId())
			local medicCoords = GenerateMedicCoords(coords)
			
			local medicNPC = CreatePed(5, `s_m_m_paramedic_01`, medicCoords.x, medicCoords.y, medicCoords.z, 0.0, true, true)
			SetBlockingOfNonTemporaryEvents(medicNPC, true)
			SetEntityInvincible(medicNPC, true)
			
			SetModelAsNoLongerNeeded(`s_m_m_paramedic_01`)
			
			coords = GetEntityCoords(PlayerPedId())
			TaskGoToCoordAnyMeans(medicNPC, coords.x, coords.y, coords.z, 5.0, 0, 0, 786603, 0xbf800000)
			
			local timeout = GetGameTimer() + 12000
			
			while #(GetEntityCoords(medicNPC) - coords) > 3.0 and timeout > GetGameTimer() do
				Wait(100)
			end
			
			if timeout > GetGameTimer() then
				ClearPedTasksImmediately(PlayerPedId())
				
				--[[RequestAnimDict('mini@cpr@char_a@cpr_str')
				while not HasAnimDictLoaded('mini@cpr@char_a@cpr_str') do Wait(10) end
				
				TaskPlayAnim(medicNPC, 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest', 1.0,-1.0, 8000, 1, 1, true, true, true)]]
				Wait(1000)
				
				if IsEntityDead(medicNPC) then
					DeleteEntity(medicNPC)
					ESX.ShowNotification('The medic is dead...')
					return
				end
				
				if pulse < 6 or blood < 21 then
					ESX.ShowNotification('Unfortunately you are dead')
				else
					ESX.TriggerServerCallback('esx_ambulancejob:payMedicNPC', function(hasPaid)
						if hasPaid then
							TriggerEvent('esx_ambulancejob:revlve', true)
						else
							ESX.ShowNotification('You need to have '..Config.CostMedicNPC..'$ in order to get revived')
						end
					end)
				end
				
				Wait(800)
				TriggerServerEvent('esx_ambulancejob:medicNPC', NetworkGetNetworkIdFromEntity(medicNPC))
			else
				ESX.ShowNotification('Unfortunately the medic cannot find you')
				TriggerServerEvent('esx_ambulancejob:medicNPC', NetworkGetNetworkIdFromEntity(medicNPC))
			end
			
			--ProcessTempGreenzone()
		end
	end)
end

function GenerateMedicCoords(coords)
	math.randomseed(GetGameTimer())
	
	local x = coords.x + math.random(-5, 5)
	local y = coords.y + math.random(-5, 5)
	local z = coords.z
	
	for height = coords.z - 10, coords.z + 20, 1.0 do
		local foundGround, tempZ = GetGroundZFor_3dCoord(x, y, height)
		
		if foundGround then
			z = tempZ
			break
		end
	end
	
	return vector3(x, y, z)
end

function DrawGenericTextThisFrame()
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function RemoveItemsAfterRPDeath()
	Citizen.CreateThread(function()
		--[[ DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end ]]

		ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
			local coords = GetEntityCoords(PlayerPedId())
			
			local id = 1
			local dist = #(coords - Config.RespawnPoints[id].coords)
			
			for k,v in ipairs(Config.RespawnPoints) do
				if #(coords - v.coords) < dist then
					dist = #(v.coords - coords)
					id = k
				end
			end
			
			local formattedCoords = {
				x = Config.RespawnPoints[id].coords.x,
				y = Config.RespawnPoints[id].coords.y,
				z = Config.RespawnPoints[id].coords.z
			}

			ESX.SetPlayerData('lastPosition', formattedCoords)
			--[[ ESX.SetPlayerData('loadout', {}) ]]
			
			TriggerServerEvent('esx:updateLastPosition', formattedCoords)
			RespawnPed(PlayerPedId(), formattedCoords, Config.RespawnPoints[id].heading)
			DisableControlAction(0, 289)
			TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
			TriggerServerEvent('esx_ambulancejob:setMeActuallyDead',false)
			actuallyDeadSent = false
			blood = 100
			pulse = 100
			StopScreenEffect('DeathFailOut')
			StopAllScreenEffects()
			local timer = GetGameTimer() + 2000
			while GetGameTimer() < timer do
				DisableControlAction(0, 289)
				Wait(0)
			end
			
			TriggerEvent('esx_basicneeds:resetStatus')
		end)
		StopScreenEffect('DeathFailOut')
		StopAllScreenEffects()
		needsSurgery = false
		inSurgery = true
        DoScreenFadeIn(800)
    Wait(500)
	--[[     Citizen.CreateThread(function()
        local time = 20 
        while (time ~= 0) do 
            Wait( 500 )
            time = time - 1
            TriggerEvent('closeInventory') 
        end
    end) ]]
	end)
end

function RemoveItemsAfterRPDeath2()

	Citizen.CreateThread(function()
		--[[ DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end ]]

		ESX.TriggerServerCallback('esx_ambulancejob:RemoveItemsAfterRPDeath2', function()
			

			--[[ ESX.SetPlayerData('loadout', {}) ]]

				--[[ DisableControlAction(0, 289)
 ]]
			--[[ StopScreenEffect('DeathFailOut')
			DoScreenFadeIn(800) ]]
			TriggerServerEvent('esx_ambulancejob:setMeActuallyDead',false)
			actuallyDeadSent = false
			blood = 100
			pulse = 100
			local timer = GetGameTimer() + 2000
			while GetGameTimer() < timer do
				DisableControlAction(0, 289)
				Wait(0)
			end
			TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
			StopScreenEffect('DeathFailOut')
			StopAllScreenEffects()
			needsSurgery = false
			inSurgery = true
			DoScreenFadeIn(800)
		end)
    Wait(500)

    --[[ Citizen.CreateThread(function()
        local time = 20 
        while (time ~= 0) do 
            Wait( 500 )
            time = time - 1
            TriggerEvent('closeInventory') 
        end
    end) ]]
	end)
end

function RespawnPed(ped, coords, heading)
	ClearPedSecondaryTask(ped)
	DetachEntity(ped, true, false)
	Wait(500)
	
	local wasDead = IsEntityDead(ped)
	
	if wasDead then
		SetEntityMaxHealth(ped, 200)
		SetPedMaxHealth(ped, 200)
		SetPlayerMaxArmour(PlayerId(), 100)
	end
	
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)

	ESX.UI.Menu.CloseAll()
end

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = 'Ambulance',
		number     = 'ambulance',
		base64Icon = 'data:image/png;base64,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'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	SetPedDropsWeaponsWhenDead(PlayerPedId(), false)
	SetFrontendActive(false)
	OnPlayerDeath()
end)
RegisterNetEvent("LMenu:slay")
AddEventHandler("LMenu:slay", function(slay)
    KilledByStaff = true
end)
RegisterNetEvent('esx_ambulancejob:revlve')
AddEventHandler('esx_ambulancejob:revlve', function(bystaff)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local que = 0
	KilledByStaff = false
    Citizen.CreateThread(function()
        DoScreenFadeOut(800)

        while not IsScreenFadedOut() do
            Citizen.Wait(50)
        end

        local formattedCoords = {
            x = ESX.Math.Round(coords.x, 1),
            y = ESX.Math.Round(coords.y, 1),
            z = ESX.Math.Round(coords.z, 1)
        }

        ESX.SetPlayerData('lastPosition', formattedCoords)

        TriggerServerEvent('esx:updateLastPosition', formattedCoords)
		--NetworkClearVoiceChannel()
        RespawnPed(playerPed, formattedCoords, 0.0)
        StopScreenEffect('DeathFailOut')
		StopAllScreenEffects()
        DoScreenFadeIn(800)
		SetTimeout(2000, function()
			for k,v in pairs(MutedPlayers) do
				MumbleSetVolumeOverrideByServerId(k, -1.0)
			end
	
			MutedPlayers = {}
		end)
    end)
	Wait(500)
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
	if not bystaff then
		needsSurgery = true
		SetEntityHealth(PlayerPedId(), 125)
	else
		needsSurgery = false
		inSurgery = true
		tempGreenzoneTimer = 0
		--TriggerServerEvent('esx_ambulancejob:removeTempGreenzone')
	end
	--[[ Citizen.CreateThread(function()
		needsSurgery = true
		Wait(30000)
		needsSurgery = false
		inSurgery = true
	end) ]]
	TriggerServerEvent('esx_ambulancejob:setMeActuallyDead',false)
	TriggerEvent('carry:Reset')

	actuallyDeadSent = false
	blood = 100
	pulse = 100
    --[[ Citizen.CreateThread(function()
        local time = 20 
        while (time ~= 0) do 
            Wait( 500 )
            time = time - 1
            TriggerEvent('closeInventory') 
        end
	end) ]]
	IsDead = false
end)

-- Load unloaded IPLs
if Config.LoadIpl then
	Citizen.CreateThread(function()
		RequestIpl('Coroner_Int_on') -- Morgue
	end)
end

if IsControlPressed(0, Keys['F9']) then ClearPedTasksImmediately(GetPlayerPed(-1)) end


RegisterNetEvent('esx_ambulancejob:DeathBagAndRespawn') 
AddEventHandler('esx_ambulancejob:DeathBagAndRespawn',function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    
    SetEntityVisible(playerPed,false)
    FreezeEntityPosition(playerPed,true)
	TriggerServerEvent ('esx_ambulancejob:createBag',coords.x, coords.y, coords.z)
	PlaceObjectOnGroundProperly(bag)
    --[[ ESX.Game.SpawnObject('xm_prop_body_bag', vector3(coords.x,coords.y,coords.z), function(object)
        RemoveItemsAfterRPDeath2()
        Citizen.Wait(2000)
        RemoveItemsAfterRPDeath()
        SetEntityVisible(playerPed,true)
        FreezeEntityPosition(playerPed,false)
        Wait(10000)
    end)]]
    RemoveItemsAfterRPDeath2()
    Citizen.Wait(2000)
    RemoveItemsAfterRPDeath()
    SetEntityVisible(playerPed,true)
    FreezeEntityPosition(playerPed,false)
    Wait(5000)
    TriggerServerEvent('esx_ambulancejob:deleteBag')   
end)

RegisterNetEvent('esx_ambulancejob:respawn')
AddEventHandler('esx_ambulancejob:respawn', function()
	local removedItems = false
	
	ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
		local coords = GetEntityCoords(PlayerPedId())
		local formattedCoords = {x = coords.x, y = coords.y, z = coords.z}
		
		ESX.SetPlayerData('lastPosition', formattedCoords)
		TriggerServerEvent('esx:updateLastPosition', formattedCoords)
		delayForCheckingCombatLog = true
		
		SwitchInPlayer(PlayerPedId())
		
		Citizen.CreateThread(function()
			while IsPlayerSwitchInProgress() do
				Wait(100)
			end
			
			FreezeEntityPosition(PlayerPedId(), false)
		end)

		exports['buckets']:changeBucket('default')
		
		RespawnPed(PlayerPedId(), formattedCoords, 0.0)
		TriggerServerEvent('esx_ambulancejob:setMeActuallyDead',false)
		actuallyDeadSent = false
		blood = 100
		pulse = 100
		StopScreenEffect('DeathFailOut')
		StopAllScreenEffects()
		
		CreateThread(function()
			local timer = GetGameTimer() + 2000
			
			while GetGameTimer() < timer do
				DisableControlAction(0, 289)
				Wait(0)
			end
		end)
		
		delayForCheckingCombatLog = false
		TriggerEvent('esx_basicneeds:resetStatus')
	
		needsSurgery = false
		inSurgery = true
		removedItems = true
	end)
	
	while not removedItems do 
		Wait(0)
	end
	
	IsDead = false
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
end)

RegisterNetEvent('esx_ambulancejob:CriminalRespawn')
AddEventHandler('esx_ambulancejob:CriminalRespawn', function(coords)
	local removedItems = false
	
	ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
		local formattedCoords = {x = coords.x, y = coords.y, z = coords.z}
		
		ESX.SetPlayerData('lastPosition', formattedCoords)
		TriggerServerEvent('esx:updateLastPosition', formattedCoords)
		delayForCheckingCombatLog = true
		
		SwitchInPlayer(PlayerPedId())
		
		Citizen.CreateThread(function()
			while IsPlayerSwitchInProgress() do
				Wait(100)
			end
			
			FreezeEntityPosition(PlayerPedId(), false)
		end)
		
		RespawnPed(PlayerPedId(), formattedCoords, 0.0)
		TriggerServerEvent('esx_ambulancejob:setMeActuallyDead',false)
		actuallyDeadSent = false
		blood = 100
		pulse = 100
		StopScreenEffect('DeathFailOut')
		StopAllScreenEffects()
		
		CreateThread(function()
			local timer = GetGameTimer() + 2000
			
			while GetGameTimer() < timer do
				DisableControlAction(0, 289)
				Wait(0)
			end
		end)
		
		delayForCheckingCombatLog = false
		TriggerEvent('esx_basicneeds:resetStatus')
	
		needsSurgery = false
		inSurgery = true
		removedItems = true
	end)
	
	while not removedItems do 
		Wait(0)
	end
	
	TriggerServerEvent('esx_ambulancejob:ResetBKT')
	IsDead = false
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
end)

RegisterNetEvent('esx_ambulancejob:createClientBag')
AddEventHandler('esx_ambulancejob:createClientBag',function(name,x,y,z,bool1,bool2,bool3)
	bag = CreateObject(name,x,y,z,bool1,bool2,bool3)
end)

RegisterNetEvent('esx_ambulancejob:deleteClientBag')
AddEventHandler('esx_ambulancejob:deleteClientBag',function()
	DeleteEntity(bag)
end)

function GetCriminalLoc()
	local job = ESX.GetPlayerData().job.name
	local loc = exports['teleport']:isExist(job)
	if not loc then
		loc = exports['esx_ligmastore']:isExist(job)
		if not loc then
			TriggerEvent('respawn:map')
			return true
		end
	end
	return loc
end

RegisterCommand("respawn", function(source, args, rawCommand)
	if IsDead then
		if canRespawn then
			local data = exports['dialog']:Decision('Are you sure?', 'Are you sure you want to perform this action?')
			local answer = tonumber(data.value)
			if answer == 1 then
				TriggerEvent('respawn:map')
			end
		else
			print('You are not clinical dead')
		end
	else 
		ESX.ShowNotification('You are not dead!')
	end
end, false)
RegisterCommand("tpcriminalhouse", function(source, args, rawCommand)
	if exports["zones"]:IsInGreenZone() then
		local result = GetCriminalLoc()

		if result ~= true then
			ESX.Game.Teleport(PlayerPedId(), result, function()
				
			end)
		end
	else 
		ESX.ShowNotification('You are not in a greenzone!')
	end
end, false)
RegisterCommand("criminal_respawn", function(source, args, rawCommand)
	if IsDead then
		if canRespawn then
			local result = GetCriminalLoc()

			if result ~= true then
				TriggerEvent('esx_ambulancejob:CriminalRespawn', result)
			end
		end
	else 
		ESX.ShowNotification('You are not dead!')
	end
end, false)

RegisterNetEvent('esx_ambulancejob:PoliceRespawn')
AddEventHandler('esx_ambulancejob:PoliceRespawn', function(coords)
	local removedItems = false
	
	ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
		local formattedCoords = {x = coords.x, y = coords.y, z = coords.z}
		
		ESX.SetPlayerData('lastPosition', formattedCoords)
		TriggerServerEvent('esx:updateLastPosition', formattedCoords)
		delayForCheckingCombatLog = true
		
		SwitchInPlayer(PlayerPedId())
		
		Citizen.CreateThread(function()
			while IsPlayerSwitchInProgress() do
				Wait(100)
			end
			
			FreezeEntityPosition(PlayerPedId(), false)
		end)
		
		RespawnPed(PlayerPedId(), formattedCoords, 0.0)
		TriggerServerEvent('esx_ambulancejob:setMeActuallyDead',false)
		actuallyDeadSent = false
		blood = 100
		pulse = 100
		StopScreenEffect('DeathFailOut')
		StopAllScreenEffects()
		
		CreateThread(function()
			local timer = GetGameTimer() + 2000
			
			while GetGameTimer() < timer do
				DisableControlAction(0, 289)
				Wait(0)
			end
		end)
		
		delayForCheckingCombatLog = false
		TriggerEvent('esx_basicneeds:resetStatus')
	
		needsSurgery = false
		inSurgery = true
		removedItems = true
	end)
	
	while not removedItems do 
		Wait(0)
	end
	
	TriggerServerEvent('esx_ambulancejob:ResetBKT')
	IsDead = false
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
end)

function GetPoliceLoc()
	local loc = exports['teleport']:isExist('police')
	if not loc then
		loc = exports['esx_ligmastore']:isExist('police')
		if not loc then
			TriggerEvent('respawn:map')
			return true
		end
	end
	return loc
end

RegisterCommand("police_respawn", function(source, args, rawCommand)
	if IsDead then
		if canRespawn and ESX.PlayerData.job.name == 'police' then
			local result = GetPoliceLoc()

			if result ~= true then
				TriggerEvent('esx_ambulancejob:PoliceRespawn', result)
			end
		end
	else 
		ESX.ShowNotification('You are not dead!')
	end
end, false)

RegisterCommand("criminal_payrespawn", function(source, args, rawCommand)
	if IsDead then
		if canPayRespawn then
			ESX.TriggerServerCallback('esx_ambulancejob:payRespawn', function(yes)
				if yes then
					local result = GetCriminalLoc()

					if result ~= true then
						TriggerEvent('esx_ambulancejob:CriminalRespawn', result)
					end
				else
					ESX.ShowNotification('You dont have enough money')
				end
			end)
		end
	else 
		ESX.ShowNotification('You are not dead!')
	end
end, false)

RegisterCommand("payrespawn", function(source, args, rawCommand)
	if IsDead then
		if canPayRespawn then
			ESX.TriggerServerCallback('esx_ambulancejob:payRespawn', function(yes)
				if yes then
					TriggerEvent('respawn:map')
				else
					ESX.ShowNotification('You dont have enough money')
				end
			end)
		else
			print('You are not clinical dead')
		end
	else 
		ESX.ShowNotification('You are not dead!')
	end
end, false)

RegisterCommand("reviveme", function(source, args, rawCommand)
	if IsDead then
		if pulse >= 20 and blood >= 20 then
			for k, v in pairs(ConfigHospital.Locations) do
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x, v.y, v.z, true) < 3.0 then
					TriggerEvent('esx_ambulancejob:revlve')
					
					break
				end
			end
		end
	end
end, false)

local lastTicalled166 = 0
local distressMinutes = 2 * 60 

function SendDistressSignalCommand(phoneNumber)
	local playerPed 		= PlayerPedId()
	local PedPosition		= GetEntityCoords(playerPed)
	
	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }

	ESX.ShowNotification("Βοήθεια εστάλη")
	
	if phoneNumber == '166' then
		TriggerServerEvent("doit_phone:emergencyApps",GetEntityCoords(playerPed),"ems")
		TriggerServerEvent('esx_addons_gcphone:startCall','ambulance',"Ένας πολίτης χρειάζεται άμεσα βοήθεια", PlayerCoords, {
			PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
		})
	elseif phoneNumber == '100' then
		TriggerServerEvent("doit_phone:emergencyApps",GetEntityCoords(playerPed),"police")
		TriggerServerEvent('esx_addons_gcphone:startCall','police',"Ένας πολίτης χρειάζεται άμεσα βοήθεια", PlayerCoords, {
			PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
		})
	end
end

function DrawText3D(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
	
    local scale = 250 / (GetGameplayCamFov() * dist)
	
    SetTextColour(255, 255, 255, 255)
	SetTextScale(0.0, 0.5 * scale)
	SetTextFont(0)
	SetTextDropshadow(0, 0, 0, 0, 55)
	SetTextDropShadow()
	SetTextCentre(true)
	
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	SetDrawOrigin(coords.x, coords.y, coords.z)
	EndTextCommandDisplayText(0.0, 0.0)
	
	ClearDrawOrigin()
end

RegisterCommand("166",function()
	local now = GetGameTimer()/1000
	if lastTicalled166 == 0 or (now - lastTicalled166) > distressMinutes then
		lastTicalled166 = GetGameTimer()/1000
		SendDistressSignalCommand('166')
	else
		ESX.ShowNotification("Πρέπει να περιμένεις για να ξανακαλέσεις για βοήθεια")
	end
end,false)

RegisterCommand("100",function()
	local now = GetGameTimer()/1000
	if lastTicalled166 == 0 or (now - lastTicalled166) > distressMinutes then
		lastTicalled166 = GetGameTimer()/1000
		--SendDistressSignalCommand('100')
		local targetCoords = GetEntityCoords(PlayerPedId())
		TriggerServerEvent("doit_phone:emergencyApps",targetCoords,"ambulance")
	else
		ESX.ShowNotification("Πρέπει να περιμένεις για να ξανακαλέσεις για βοήθεια")
	end
end,false)