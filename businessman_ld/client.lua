ESX = nil

local cooldown = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)

RegisterCommand('businessman_ld', function(source, args)
	if cooldown then
		ESX.ShowNotification('Please wait before trying again')
		return
	end

	cooldown = true
	SetTimeout(5000, function() cooldown = nil end)

	ESX.TriggerServerCallback('businessman_ld:getLeaderboard', function(data)
		local myPoints = 0
		local leaderboard = {}
		local myIdentifier = ESX.GetPlayerData().identifier
		
		for k,v in pairs(data) do
			local newData, sum = CalculatePoints(v.data)
			table.insert(leaderboard, {identifier = k, name = v.name, data = newData, sum = sum})

			if myIdentifier == k then
				myPoints = sum
			end
		end
		
		table.sort(leaderboard, function(a,b) return a.sum > b.sum end)
		
		SetNuiFocus(true, true)
		SendNUIMessage({action = 'show', leaderboard = leaderboard, myPoints = myPoints})
	end)
end)

RegisterNUICallback('quit', function(data)
	SetNuiFocus(false, false)
end)

function CalculatePoints(data)
	local sum = 0
	local temp = {}
	
	for k,v in pairs(Config.PointTypes) do
		if data[k] then
			sum = sum + data[k]
			temp[k] = (temp[k] or 0) + data[k]
		else
			temp[k] = 0
		end
	end
	
	return temp, sum
end