ESX = nil

local PlayerData = {}

local fightId = nil
local fightData = nil
local fightBlip = nil
local lastCoords = nil
local timeRemaining = 0

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

RegisterNetEvent('esx_jobfight:requestFight')
AddEventHandler('esx_jobfight:requestFight', function(caller, cLabel, cAllies, tAllies, rounds)
	if fightId then
		return
	end
	
	if exports['dialog']:Decision('Fight Request', 'Round(s): '..rounds, 'Do you want to accept a fight with: '..cLabel, 'YES', 'NO').action == 'submit' then
		local validTargets = {}
		
		local players = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 100.0)
		
		for k,v in pairs(players) do
			if not IsEntityDead(GetPlayerPed(v)) then
				local sid = GetPlayerServerId(v)
				
				local targetjob = ESX.GetPlayerJob(sid).name or 'unemployed'
				local targetjob2 = ESX.GetPlayerJob2(sid).name or 'unemployed'
				
				if cAllies[targetjob] or tAllies[targetjob] then
					validTargets[sid] = targetjob
				elseif cAllies[targetjob2] or tAllies[targetjob2] then
					validTargets[sid] = targetjob2
				end
			end
		end
		
		validTargets[GetPlayerServerId(PlayerId())] = PlayerData.job.name
		
		TriggerServerEvent('esx_jobfight:answerFight', caller, true, validTargets)
	else
		TriggerServerEvent('esx_jobfight:answerFight', caller, false, {})
	end
end)

RegisterNetEvent('esx_jobfight:startFight')
AddEventHandler('esx_jobfight:startFight', function(id, data, coords)
	if fightId then
		return
	end
	
	if data.cAllies[PlayerData.job.name] or data.cAllies[PlayerData.job2.name] or data.tAllies[PlayerData.job.name] or data.tAllies[PlayerData.job2.name] then
		if #(GetEntityCoords(PlayerPedId()).xy - coords.xy) > Config.FightRadius then
			return
		end
		--if exports['dialog']:Decision('Fight Request', 'Fight', 'Do you want to enter the fight with your team? ', 'YES', 'NO').action == 'submit' then
			lastCoords = GetEntityCoords(PlayerPedId())
			
			fightId = id
			fightData = data
			
			local teleportCoords
			
			if data.cAllies[PlayerData.job.name] or data.cAllies[PlayerData.job2.name] then
				teleportCoords = Config.Maps[fightData.map].spawn1
			elseif data.tAllies[PlayerData.job.name] or data.tAllies[PlayerData.job2.name] then
				teleportCoords = Config.Maps[fightData.map].spawn2
			end
		
			exports['buckets']:changeBucket('jobfight_'..id)
			StartFighting(teleportCoords)
	--[[ 	else
			TriggerServerEvent("esx_jobfight:abandon")
		end ]]
	end
end)

RegisterNetEvent('esx_jobfight:nextRound')
AddEventHandler('esx_jobfight:nextRound', function(id, cA, tA, cWins, tWins)
	if (fightId or -1) ~= id then
		return
	end

	fightData['cA'] = cA
	fightData['tA'] = tA

	fightData['cWins'] = cWins
	fightData['tWins'] = tWins

	timeRemaining = 0
	Wait(1200)

	local teleportCoords
	
	if fightData.cAllies[PlayerData.job.name] or fightData.cAllies[PlayerData.job2.name] then
		teleportCoords = Config.Maps[fightData.map].spawn1
	elseif fightData.tAllies[PlayerData.job.name] or fightData.tAllies[PlayerData.job2.name] then
		teleportCoords = Config.Maps[fightData.map].spawn2
	end

	StartFighting(teleportCoords)
end)

RegisterNetEvent('esx_jobfight:endFight')
AddEventHandler('esx_jobfight:endFight', function(id)
	if (fightId or -1) ~= id then
		return
	end

	fightId = nil
	
	if DoesBlipExist(fightBlip) then
		RemoveBlip(fightBlip)
	end
	
	fightBlip = nil

	SendNUIMessage({action = 'hideInfo'})
	
	if lastCoords then
		SetEntityCoords(PlayerPedId(), lastCoords)
	end
	
	Wait(1500)
	TriggerEvent('esx_ambulancejob:revlve', true, 150)
end)

RegisterNetEvent('esx_jobfight:updateScoreboard')
AddEventHandler('esx_jobfight:updateScoreboard', function(id, amount, team)
	if (fightId or -1) ~= id then
		return
	end

	fightData[team] = amount
end)

function StartFighting(teleportCoords)
	timeRemaining = Config.FightSeconds
	
	if teleportCoords then
		Citizen.CreateThread(function()
			FreezeEntityPosition(PlayerPedId(), true)
			SetEntityCoordsNoOffset(PlayerPedId(), teleportCoords)
			Wait(1500)
			FreezeEntityPosition(PlayerPedId(), false)
		end)
	end

	Citizen.CreateThread(function()
		Wait(1500)

		if IsEntityDead(PlayerPedId()) then
			TriggerEvent('esx_ambulancejob:revlve', true, 150)
		end
	end)
	
	SendNUIMessage({
		action = 'sendInfo',
		job1 = fightData.cLabel,
		count1 = fightData.cA,
		job2 = fightData.tLabel,
		count2 = fightData.tA,
		cWins = fightData.cWins or 0,
		tWins = fightData.tWins or 0,
		timeRemaining = SecondsToClock(timeRemaining)
	})
	
	SendNUIMessage({action = 'showInfo'})
	
	if DoesBlipExist(fightBlip) then
		RemoveBlip(fightBlip)
	end
	
	fightBlip = AddBlipForRadius(fightData.coords, Config.FightRadius)
	SetBlipHighDetail(fightBlip, true)
	SetBlipColour(fightBlip, 1)
	SetBlipAlpha(fightBlip, 150)
	
	StartCountdown(Config.CountDownSeconds, fightData.coords)
	
	Citizen.CreateThread(function()
		while fightId and timeRemaining > 0 do
			Wait(1000)
			
			if fightId then
				timeRemaining = timeRemaining - 1
				
				SendNUIMessage({
					action = 'sendInfo',
					job1 = fightData.cLabel,
					count1 = fightData.cA,
					job2 = fightData.tLabel,
					count2 = fightData.tA,
					cWins = fightData.cWins or 0,
					tWins = fightData.tWins or 0,
					timeRemaining = SecondsToClock(timeRemaining)
				})
				
				local coords = GetEntityCoords(PlayerPedId())
				
				if #(coords.xy - fightData.coords.xy) > Config.FightRadius then
					SetEntityHealth(PlayerPedId(), 0)
					SetEntityCoords(PlayerPedId(), teleportCoords)
				end
			end
		end
	end)
end

function StartCountdown(seconds, fightCoords)
	SendNUIMessage({action = 'showCountdown', seconds = seconds})
	
	local teamNames = {}
	
	if fightData.cAllies[PlayerData.job.name] or fightData.cAllies[PlayerData.job2.name] then
		teamNames = fightData.cAlliesNames
	elseif fightData.tAllies[PlayerData.job.name] or fightData.tAllies[PlayerData.job2.name] then
		teamNames = fightData.tAlliesNames
	end
	
	local imDown = (fightData.cAllies[PlayerData.job.name] or fightData.cAllies[PlayerData.job2.name]) and true or false
	
	local max_x = fightCoords.x + Config.FightRadius
	local min_x = fightCoords.x - Config.FightRadius
	
	local max_y = fightCoords.y + Config.FightRadius
	local min_y = fightCoords.y - Config.FightRadius
	
	--[[local b1 = AddBlipForCoord(max_x, fightCoords.y, fightCoords.z)
	local b2 = AddBlipForCoord(min_x, fightCoords.y, fightCoords.z)
	
	local b3 = AddBlipForCoord(fightCoords.x, fightCoords.y + 10.0, fightCoords.z)
	SetBlipColour(b3, 1)
	local b4 = AddBlipForCoord(fightCoords.x, fightCoords.y - 10.0, fightCoords.z)
	SetBlipColour(b4, 2)]]
	
	Citizen.CreateThread(function()
		while seconds > 0 do
			local elements = {}
			
			for k,v in pairs(teamNames) do
				local playerId = GetPlayerFromServerId(k)
				
				if playerId ~= -1 and GetEntityHealth(GetPlayerPed(playerId)) > 0 then
					table.insert(elements, {label = v})
				end
			end
			
			if #elements > 0 then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'team_members', {
					title    = 'Team',
					align    = 'bottom-right',
					elements = elements,
				},
				function(data, menu)
					--
				end,
				function(data, menu)
					menu.close()
				end)
			end
			
			Wait(1000)
		end
		
		ESX.UI.Menu.CloseAll()
	end)

	Citizen.CreateThread(function()
		while seconds > 0 do
			local coords = GetEntityCoords(PlayerPedId())
			
			if fightData.map == 'here' then
				if coords.y - min_y < Config.FightRadius and not imDown then	--UP
					FreezeEntityPosition(PlayerPedId(), true)
					
					local safeCoords = vector3(fightCoords.x, fightCoords.y + 10.0, fightCoords.z)
					
					for height = safeCoords.z - 100.0, safeCoords.z + 100.0, 1.0 do
						local foundGround, tempZ = GetGroundZFor_3dCoord(safeCoords.x, safeCoords.y, height, true)
						
						if tempZ > -10.0 then
							if foundGround then
								local foundWater, _ = GetWaterHeight(safeCoords.x, safeCoords.y, tempZ)
								
								if not foundWater then
									SetEntityCoords(PlayerPedId(), safeCoords.x, safeCoords.y, tempZ)
									FreezeEntityPosition(PlayerPedId(), false)
								end
							end
						end
					end
				elseif coords.y - min_y > Config.FightRadius and imDown then	--DOWN
					FreezeEntityPosition(PlayerPedId(), true)
					
					local safeCoords = vector3(fightCoords.x, fightCoords.y - 10.0, fightCoords.z)
					
					for height = safeCoords.z - 100.0, safeCoords.z + 100.0, 1.0 do
						local foundGround, tempZ = GetGroundZFor_3dCoord(safeCoords.x, safeCoords.y, height, true)
						
						if tempZ > -10.0 then
							if foundGround then
								local foundWater, _ = GetWaterHeight(safeCoords.x, safeCoords.y, tempZ)
								
								if not foundWater then
									SetEntityCoords(PlayerPedId(), safeCoords.x, safeCoords.y, tempZ)
									FreezeEntityPosition(PlayerPedId(), false)
								end
							end
						end
					end
				end
				
				for i=-5, 5, 1 do
					DrawLine(min_x, fightCoords.y, fightCoords.z + i, max_x, fightCoords.y, fightCoords.z + i, 255, 0, 0, 255)
				end
			end
			
			if #(coords.xy - fightCoords.xy) < Config.FightRadius then
				DisablePlayerFiring(PlayerId(), true)
				
				if fightData.map ~= 'here' then
					FreezeEntityPosition(PlayerPedId(), true)
				end
			else
				Wait(250)
			end
			
			Wait(0)
		end
		
		if fightData.map ~= 'here' then
			FreezeEntityPosition(PlayerPedId(), false)
		end
	end)
	
	while seconds > 0 do
		seconds = seconds - 1
		SendNUIMessage({action = 'setCountdown', seconds = seconds})
		
		Wait(1000)
	end
	
	SendNUIMessage({action = 'hideCountdown'})

	ESX.UI.Menu.CloseAll()
end

function SecondsToClock(seconds)
	return (('%02s:%02s'):format(math.floor(seconds/60), math.floor(seconds%60)))
end

RegisterCommand('jobfight', function(source, args)
	if fightId then
		return
	end
	
	local elements = {}
	
	for k,v in pairs(Config.Maps) do
		table.insert(elements, {label = k, value = k})
	end

	table.sort(elements, function(a, b) return a.label < b.label end)
	
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

		local rounds = tonumber(exports['dialog']:Create('Fight', 'Enter Rounds [1-3]').value) or -1

		if rounds < 1 or rounds > 3 then
			ESX.ShowNotification('Invalid rounds')
			return
		end
		
		local target = tonumber(exports['dialog']:Create('Fight', 'Enter Target ID').value) or -1
		local targetId = GetPlayerFromServerId(target)
		
		if targetId == -1 or target == GetPlayerServerId(PlayerId()) then
			ESX.ShowNotification('Invalid target')
			return
		end
		
		if #(coords - GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(targetId)))) > 3.0 then
			ESX.ShowNotification('Target is not near you')
			return
		end
		
		TriggerServerEvent('esx_jobfight:requestFight', target, data.current.value, rounds)
	end,
	function(data, menu)
		menu.close()
	end)
end)

exports('IsInFight', function()
	return not (fightId == nil)
end)