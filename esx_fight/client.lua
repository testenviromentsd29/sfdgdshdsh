ESX = nil

local PlayerData = {}

local fightId = nil
local fightData = nil
local fightBlip = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Wait(100)
	end
	
	while ESX.GetPlayerData().job2 == nil do
		Wait(100)
	end
	
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	PlayerData.job2 = job2
end)

RegisterNetEvent('esx_fight:requestFight')
AddEventHandler('esx_fight:requestFight', function(caller, cLabel)
	if fightId then
		return
	end
	
	if exports['dialog']:Decision('Fight Request', '', 'Do you want to accept a fight with: '..cLabel, 'YES', 'NO').action == 'submit' then
		TriggerServerEvent('esx_fight:answerFight', caller, true)
	else
		TriggerServerEvent('esx_fight:answerFight', caller, false, {})
	end
end)

RegisterNetEvent('esx_fight:startFight')
AddEventHandler('esx_fight:startFight', function(id, data, pId1, pId2)
	if fightId then
		return
	end
	
	local sid = GetPlayerServerId(PlayerId())
	
    if sid ~= pId1 and sid ~= pId2 then
        return
    end
	
    fightId = id
    fightData = data
	
	local teleportCoords
	
	if sid == pId1 then
		teleportCoords = Config.Maps[fightData.map].spawn1
	elseif sid == pId2 then
		teleportCoords = Config.Maps[fightData.map].spawn2
	end
    
	CreateThread(disableVoice)
    StartFighting(teleportCoords)
end)

RegisterNetEvent('esx_fight:endFight')
AddEventHandler('esx_fight:endFight', function(id)
	if fightId and fightId == id then
		fightId = nil
		
		if DoesBlipExist(fightBlip) then
			RemoveBlip(fightBlip)
		end
		
		fightBlip = nil
	end
end)

RegisterNetEvent('esx_fight:updateScoreboard')
AddEventHandler('esx_fight:updateScoreboard', function(id, amount, team)
	if fightId and fightId == id then
		fightData[team] = amount
	end
end)

function StartFighting(teleportCoords)
	local timeRemaining = Config.FightSeconds
	local lastCoords = GetEntityCoords(PlayerPedId())
	
	if teleportCoords then
		Citizen.CreateThread(function()
			FreezeEntityPosition(PlayerPedId(), true)
			SetEntityCoordsNoOffset(PlayerPedId(), teleportCoords)
			Wait(1500)
			FreezeEntityPosition(PlayerPedId(), false)
		end)
	end
	
	SendNUIMessage({
		action = 'sendInfo',
		job1 = "Team 1",
		count1 = 1,
		job2 = "Team 2",
		count2 = 1,
		timeRemaining = SecondsToClock(timeRemaining)
	})
	
	SendNUIMessage({action = 'showInfo'})
	
	if DoesBlipExist(fightBlip) then
		RemoveBlip(fightBlip)
	end
	
	fightBlip = AddBlipForRadius(fightData.coords, Config.FightRadius)
	SetBlipHighDetail(fightBlip, true)
	SetBlipColour(fightBlip, math.floor(1))
	SetBlipAlpha(fightBlip, math.floor(150))
	
	StartCountdown(Config.CountDownSeconds, fightData.coords)
	
	Citizen.CreateThread(function()
		while fightId and timeRemaining > math.floor(0) and not IsEntityDead(PlayerPedId()) do
			Wait(1000)
			
			timeRemaining = timeRemaining - math.floor(1)
			
			SendNUIMessage({
				action = 'sendInfo',
				job1 = "Team 1",
                count1 = 1,
                job2 = "Team 2",
                count2 = 1,
				timeRemaining = SecondsToClock(timeRemaining)
			})
			
			local coords = GetEntityCoords(PlayerPedId())
			
			if #(coords.xy - fightData.coords.xy) > Config.FightRadius then
				TriggerServerEvent('esx_fight:abandon')
				
				Wait(1000)
				fightId = nil
				
				if DoesBlipExist(fightBlip) then
					RemoveBlip(fightBlip)
				end
				
				fightBlip = nil
				ESX.ShowNotification('You abandoned the fight')
				
				break
			end
		end
		
		fightId = nil
		
		if DoesBlipExist(fightBlip) then
			RemoveBlip(fightBlip)
		end
		
		fightBlip = nil
		
		SendNUIMessage({action = 'hideInfo'})
		
		if teleportCoords then
			SetEntityCoords(PlayerPedId(), lastCoords)
		end
		
		Wait(1000)
		TriggerEvent('esx_ambulancejob:revlve', true, math.floor(150))
	end)
end

function StartCountdown(seconds, fightCoords)
	SendNUIMessage({action = 'showCountdown', seconds = seconds})
	
	Citizen.CreateThread(function()
		while seconds > math.floor(0) do
			local coords = GetEntityCoords(PlayerPedId())
			
			if #(coords.xy - fightCoords.xy) < Config.FightRadius then
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
				
				FreezeEntityPosition(PlayerPedId(), true)
			else
				Wait(250)
			end
			
			Wait(0)
		end
		
		FreezeEntityPosition(PlayerPedId(), false)
	end)
	
	while seconds > math.floor(0) do
		seconds = seconds - math.floor(1)
		SendNUIMessage({action = 'setCountdown', seconds = seconds})
		
		Wait(1000)
	end
	
	SendNUIMessage({action = 'hideCountdown'})
end

function SecondsToClock(seconds)
	return (('%02s:%02s'):format(math.floor(seconds/math.floor(60)), math.floor(seconds%math.floor(60))))
end

RegisterCommand('fight', function(source, args)
	if fightId then
		return
	end

	if GlobalState.inEvent == 'pubg' then
		return
	end
	
	local elements = {}
	
	for k,v in pairs(Config.Maps) do
		table.insert(elements, {label = k, value = k})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'select_map', {
		title    = 'Select Map',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		menu.close()
		
		local coords = GetEntityCoords(PlayerPedId())
		TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))
		
		local target = tonumber(exports['dialog']:Create('Fight', 'Enter Target ID').value) or math.floor(-1)
		local targetId = GetPlayerFromServerId(target)
		
		if targetId == math.floor(-1) or target == GetPlayerServerId(PlayerId()) then
			ESX.ShowNotification('Invalid target')
			return
		end
		
		if #(coords - GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(targetId)))) > 3.0 then
			ESX.ShowNotification('Target is not near you')
			return
		end
		
		TriggerServerEvent('esx_fight:requestFight', target, data.current.value)
	end,
	function(data, menu)
		menu.close()
	end)
end)

disableVoice = function()
	while isInFight() do
		Wait(0)
		--NetworkSetTalkerProximity(0.1);
	end
	TriggerEvent('mumble:ResetVoice')
end

isInFight = function()
	return not (fightId == nil)
end

exports('IsInFight', function()
	return not (fightId == nil)
end)