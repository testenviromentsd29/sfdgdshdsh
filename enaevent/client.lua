ESX = nil

local blip = nil
local blipRadius = nil
local inZone = false
local onGoingCapture = false
local droppedWeapons = nil
local GMEventKills = 0
local GMEventDeaths = 0
local GMEventHeadshots = 0
local showGMEventStatus = true
local eventStarted = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	InitScript()
	while GlobalState.EnaEventCoords == nil do
		Wait(1000)
	end
	Config.NPC.coords = GlobalState.EnaEventCoords
	Config.NPC.heading = GlobalState.EnaEventHeading
end)

RegisterCommand('gmeventstatus', function(source, args)
	showGMEventStatus = not showGMEventStatus
	ESX.ShowNotification('GMEvent Status: '..tostring(showGMEventStatus))
end)

RegisterCommand('tpgmevent', function(source, args)
	if exports.zones:IsInGreenZone() then
		local elements = {}

		table.insert(elements, {label = 'GMEvent 1', value = vector3(5135.88, -5566.49, 40.03)})
		table.insert(elements, {label = 'GMEvent 2', value = vector3(4976.36, -5538.41, 28.49)})
		table.insert(elements, {label = 'GMEvent 3', value = vector3(4809.14, -5727.73, 26.21) })

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'GMEvent_tp', {
			title    = 'GMEvent Teleport',
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





RegisterNetEvent('enaevent:prestartEvent')
AddEventHandler('enaevent:prestartEvent', function(minutes)
	Citizen.CreateThread(function()
		TriggerEvent('top_notifications:show', Config.NotificationData)
		Wait(5*60000)
		TriggerEvent('top_notifications:hide', Config.NotificationData.name)
	end)
end)

RegisterNetEvent('enaevent:startEvent')
AddEventHandler('enaevent:startEvent', function()
	eventStarted = true

	if DoesBlipExist(blipRadius) then
		SetBlipColour(blipRadius, 27)
	end
end)

RegisterNetEvent('enaevent:endEvent')
AddEventHandler('enaevent:endEvent', function()
	eventStarted = false
end)

RegisterNetEvent('enaevent:startCapture')
AddEventHandler('enaevent:startCapture', function(capturer)
	onGoingCapture = true
	
	Citizen.CreateThread(function()
		local opacity = 128
		
		while onGoingCapture do
			opacity = opacity == 128 and 200 or 128
			SetBlipFade(blipRadius, opacity, 500)
			
			Wait(1000)
		end
		
		SetBlipFade(blipRadius, 128, 0)
	end)
	
	if capturer == GetPlayerServerId(PlayerId()) then
		local barDuration = Config.CaptureTime * 1000
		local endTimer = GetGameTimer() + barDuration
		
		Citizen.CreateThread(function()
			while onGoingCapture and endTimer > GetGameTimer() do
				local currentTimer = endTimer - GetGameTimer()
				local currentTimerReversed = barDuration - currentTimer
				local currentPercent = currentTimerReversed / barDuration
				
				DrawRect(0.5, 0.9, 0.2, 0.03, 75, 75, 75, 200)
				DrawRect(0.5, 0.9, currentPercent/5, 0.03, 255, 0, 0, 255)
				
				Wait(0)
			end
			
			TriggerServerEvent('enaevent:endCapture')
		end)
	end
end)

RegisterNetEvent('enaevent:endCapture')
AddEventHandler('enaevent:endCapture', function()
	onGoingCapture = false
end)

RegisterNetEvent('enaevent:showRewards')
AddEventHandler('enaevent:showRewards', function(rewards)
	local elements = {}
	
	for k,v in pairs(rewards) do
		table.insert(elements, {label = '['..k..'] '..string.gsub(v, 'blueprint_', ''), value = k})
	end
	
	if #elements < 1 then
		return
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rewards', {
		title    = 'Rewards',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		menu.close()
		TriggerServerEvent('enaevent:getReward', data.current.value)
	end,
	function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('enaevent:enteredZone')
AddEventHandler('enaevent:enteredZone', function(isEntering, _droppedWeapons)
	if isEntering then
		if DoesBlipExist(blipRadius) then
			SetBlipColour(blipRadius, 5)
		end
		
		droppedWeapons = _droppedWeapons  and _droppedWeapons or {}
		GlobalState.inEvent = "enaevent"
		inZone = true
		ESX.ShowNotification('You entered the GMEvent')
		
		ProcessInZone()
	else
		if DoesBlipExist(blipRadius) then
			if GMEventStarted then
				SetBlipColour(blipRadius, 27)
			else
				SetBlipColour(blipRadius, 1)
			end
		end
		GlobalState.inEvent = nil
		inZone = false
		ESX.ShowNotification('You left the GMEvent')
	end
end)

RegisterNetEvent('enaevent:updateDroppedWeapon')
AddEventHandler('enaevent:updateDroppedWeapon', function(coords, data)
	if inZone then
		droppedWeapons[coords] = data
	end
end)

RegisterNetEvent('enaevent:updateDroppedWeapons')
AddEventHandler('enaevent:updateDroppedWeapons', function(data)
	if inZone then
		droppedWeapons = data
	end
end)

RegisterNetEvent('enaevent:addKill')
AddEventHandler('enaevent:addKill', function(isHeadshot)
	GMEventKills = GMEventKills + 1
	SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
	SetPedArmour(PlayerPedId(), GetPlayerMaxArmour(PlayerId()))
	if isHeadshot then
		GMEventHeadshots = GMEventHeadshots + 1
	end
end)

RegisterNetEvent('enaevent:addDeath')
AddEventHandler('enaevent:addDeath', function()
	GMEventDeaths = GMEventDeaths + 1

end)

RegisterNetEvent('enaevent:showLeaderboard')
AddEventHandler('enaevent:showLeaderboard', function(data)
	local scoreboard = {}
	
	for k,v in pairs(data) do
		table.insert(scoreboard, {kills = v.kills, name = v.name})
	end
	
	table.sort(scoreboard, function(a,b) return a.kills > b.kills end)
	
	local identifier = ESX.GetPlayerData().identifier
	local kills = data[identifier] and data[identifier].kills or 0
	
	SetNuiFocus(true, true)
	SendNUIMessage({action = 'show', type = 'leaderboard', scoreboard = scoreboard, kills = kills})
end)

RegisterNUICallback('quit', function(data)
	SetNuiFocus(false, false)
end)

function InitScript()
	blip = AddBlipForCoord(Config.Coords)
	SetBlipSprite(blip, 437)
	SetBlipDisplay(blip, 8)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, 39)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('GM Event')
	EndTextCommandSetBlipName(blip)
	
	blipRadius = AddBlipForRadius(Config.Coords, Config.Radius)
	SetBlipColour(blipRadius, 1)
	SetBlipAlpha(blipRadius, 128)

	if eventStarted then
		SetBlipColour(blipRadius, 27)
	end
	
	Citizen.CreateThread(function()
		while true do
			local wait = 1500
			
			if not inZone and #(GetEntityCoords(PlayerPedId()) - Config.Coords) < (Config.Radius + 50.0) then
				wait = 0
				DontShootThisFrame()
				
				local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

				if vehicle > 0 and GetEntitySpeed(vehicle) < 15.0 then
					DeleteEntity(vehicle)
				end
			end
			
			Wait(wait)
		end
	end)
	
	Citizen.CreateThread(function()
		while true do
			local coords = GetEntityCoords(PlayerPedId())
			local distance = #(coords - Config.Coords)
			
			if distance < Config.Radius and distance > (Config.Radius - 20.0) then
				if not inZone then
					if GetSelectedPedWeapon(PlayerPedId()) ~= `WEAPON_UNARMED` then
						TriggerServerEvent('enaevent:enteredZone', true)
						Wait(1000)
					else
						ESX.ShowNotification('You need a weapon to enter the GMEvent')
						Wait(3000)
					end
				end
			elseif distance > Config.Radius then
				if inZone then
					TriggerServerEvent('enaevent:enteredZone', false)
					Wait(5000)
				end
			end
			
			Wait(1500)
		end
	end)

	Citizen.CreateThread(function()
		while true do
			if inZone and showGMEventStatus then
				DrawText2(0.157, 0.800, 0.45, '~y~Kills:~w~ '..GMEventKills..'\n~y~Deaths:~w~ '..GMEventDeaths..'\n~y~Headshots:~w~ '..GMEventHeadshots..'\n~y~Players:~w~ '..GlobalState.enaEventPlayers)
			else
				Wait(2000)
			end
			
			Wait(0)
		end
	end)
end

function ProcessInZone()
	--[[ local npc = CreateStaticNPC(Config.NPC.model, Config.NPC.coords, Config.NPC.heading) ]]
	Citizen.CreateThread(function()
		while inZone do
			Wait(0)
			if IsControlJustPressed(0,37) or  IsDisabledControlJustPressed(0,37) then
				ExecuteCommand("gmleaderboard")
				Wait(2000)
			end
		end
	end)
	--[[ Citizen.CreateThread(function()
		while inZone do
			local wait = 500
			local coords = GetEntityCoords(PlayerPedId())
			
			if #(coords - Config.NPC.coords) < 1.2 then
				wait = 0
				ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to start capturing/get rewards')
				
				if IsControlJustReleased(0, 38) then
					TriggerServerEvent('enaevent:startCapture')
					Wait(1000)
				end
			end
			
			Wait(wait)
		end
		
		if DoesEntityExist(npc) then
			DeleteEntity(npc)
		end
	end) ]]
	
	
end

exports('IsOnGMEvent', function()
	return inZone
end)

exports('hasGMEventStarted', function()
	if GMEventStarted then
		return GMEventStarted
	else
		return false
	end
end)


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

exports('IsEventRunning', function()
	return eventStarted
end)