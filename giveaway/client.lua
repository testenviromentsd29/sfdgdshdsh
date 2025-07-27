ESX = nil

local myIdentifier = ''


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	while ESX.GetPlayerData().identifier == nil do
		Wait(0)
	end

	myIdentifier = ESX.GetPlayerData().identifier
	
end)

function secondsToMinAndSecsLeftReadable(secs)
	local mins = math.floor(secs / 60)
	local secs = secs % 60
	return string.format("%02d:%02d", mins, secs)
	
end

RegisterCommand("giveaway", function ()
	ESX.TriggerServerCallback("giveaway:getmypoints", function(count, next) 
		SetNuiFocus(true,true)
		SendNUIMessage({action = "show", myentries = count, nextentry = secondsToMinAndSecsLeftReadable(next)})
	end)
end)


RegisterNUICallback("close", function (data,cb)
	SetNuiFocus(false,false)
end)