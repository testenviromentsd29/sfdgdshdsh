ESX = nil

local isViewing = false
local plateModel = "prop_fib_badge"
local animDict = "missfbi_s4mop"
local animName = "swipe_card"
local plate_net = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)

RegisterCommand('badge', function(source, args)
	local PlayerData = ESX.GetPlayerData()
	if not Config.ValidJobs[PlayerData.job.name] then
		return
	end
	
	local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
	
	if closestPlayer == -1 or closestPlayerDistance > 3.0 then
		local rpName = PlayerData.attributes['firstName']..' '..PlayerData.attributes['lastName']
		local label = PlayerData.job.label..': '..PlayerData.job.grade_label
		
		CreateThread(playAnim);
		TriggerEvent('badge:show', GetPlayerServerId(PlayerId()), rpName, PlayerData.job.name, label)
	else
		TriggerServerEvent('badge:show', GetPlayerServerId(closestPlayer))
	end
end)

RegisterNetEvent('badge:show')
AddEventHandler('badge:show', function(caller, name, job, label)
	local ped = GetPlayerPed(GetPlayerFromServerId(caller))
	if DoesEntityExist(ped) then
		local mugshot = RegisterPedheadshot(ped)
		
		while not IsPedheadshotReady(mugshot) do
			Wait(0)
		end
		
		local txdString = GetPedheadshotTxdString(mugshot)
		
		isViewing = true
		print(job)
		SendNUIMessage({
			action	= 'show',
			name	= name,
			job		= job,
			label	= label,
			mugshot	= txdString,
		})
		
		UnregisterPedheadshot(mugshot)
	end
end)

AddEventHandler('justpressed', function(label, key)
	if (key == 322 and isViewing) or (key == 177 and isViewing) then
		SendNUIMessage({action = 'hide'})
		isViewing = false
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		if isViewing then
			if IsControlJustPressed(0, 322) or IsControlJustPressed(0, 177) then
				SendNUIMessage({action = 'hide'})
			end
		else
			Wait(1000)
		end
	end
end)

playAnim = function()
	RequestModel(GetHashKey(plateModel))
	while not HasModelLoaded(GetHashKey(plateModel)) do
		Wait(100)
	end

	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Wait(100)
	end

	local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
	local platespawned = CreateObject(GetHashKey(plateModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
	Wait(1000)
	
	local netid = ObjToNet(platespawned)
	SetNetworkIdExistsOnAllMachines(netid, true)
	SetNetworkIdCanMigrate(netid, false)
	TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0)
	TaskPlayAnim(GetPlayerPed(PlayerId()), animDict, animName, 1.0, 1.0, -1, 50, 0, 0, 0, 0)
	Wait(800)
	AttachEntityToEntity(platespawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
	plate_net = netid
	Wait(3000)
	ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
	DetachEntity(NetToObj(plate_net), 1, 1)
	DeleteEntity(NetToObj(plate_net))
	plate_net = nil
end

RegisterNetEvent("badge:playAnim", playAnim)

--[[ Citizen.CreateThread(function()
	while true do
		N_0x4757f00bc6323cfe(-1553120962, 0.0) --undocumented damage modifier. 1st argument is hash, 2nd is modified (0.0-1.0)
		Wait(0)
	end
end) ]]