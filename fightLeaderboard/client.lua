ESX = nil
local PlayerData = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end
	
	Wait(2000)
	
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterCommand('fightleaderboard', function()
	ESX.TriggerServerCallback('fightLeaderboard:getLeaderboard', function(fightleaderboardPlayers, fightleaderboardTeams)
		SetNuiFocus(true, true)
		local playersTable, teamsTable = {}, {}

		for k,v in pairs(fightleaderboardPlayers) do
			local total = 0
			for l,m in pairs(v.points) do
				total = total + m
			end
			table.insert(playersTable, v)
			playersTable[#playersTable].total = total
		end

		for k,v in pairs(fightleaderboardTeams) do
			local total = v.points
			table.insert(teamsTable, v)
			teamsTable[#teamsTable].total = total
		end

		table.sort(playersTable, function(a,b) return a.total > b.total end)
		table.sort(teamsTable, function(a,b) return a.total > b.total end)

		SendNUIMessage(
			{action = 'show', leaderboardPlayers = playersTable, leaderboardTeams = teamsTable}
		)
	end)
end)

RegisterNUICallback("quit", function()
	SetNuiFocus(false, false)
end)