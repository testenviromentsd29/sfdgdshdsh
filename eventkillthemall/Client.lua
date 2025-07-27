ESX = nil
PlayerData = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end

	while (PlayerData == nil or PlayerData.job == nil or ESX.GetPlayerData().job == nil) do
		PlayerData = ESX.GetPlayerData()
		Wait(0)
	end
end)

local eventStatus = -1
local currentBucket = 0
local currentBucketName = 'default'
--
local eventBlip = nil
local eventRadiusBlip = nil
--
local lastBucketChange = 0
local bucketCooldown = 3000

AddEventHandler('buckets:onBucketChanged', function(bucketId, bucketName)
	if eventStatus ~= -1 then
		if bucketName == Config.Bucket then
			if DoesBlipExist(eventBlip) then
				SetBlipColour(eventBlip, Config.Locations[eventStatus].Blips.colorIfEntered)
			end

			if DoesBlipExist(eventRadiusBlip) then
				SetBlipColour(eventRadiusBlip, Config.Locations[eventStatus].BlipRadius.colorIfEntered)
			end
		else
			if DoesBlipExist(eventBlip) then
				SetBlipColour(eventBlip, Config.Locations[eventStatus].Blips.color)
			end

			if DoesBlipExist(eventRadiusBlip) then
				SetBlipColour(eventRadiusBlip, Config.Locations[eventStatus].BlipRadius.color)
			end
		end
	end

	currentBucket = bucketId
	currentBucketName = bucketName

	dPrints('Bucket changed to: ' .. bucketName)
end)


RegisterNetEvent('eventkillthemall:startEvent', function(event_index)
	eventStatus = event_index

	CreateThread(function()
		createBlip()

		while eventStatus ~= -1 do
			local myCoords = GetEntityCoords(PlayerPedId())
			local eventLocation = Config.Locations[event_index]
			local dist = #(myCoords - eventLocation.Coords)
			local currentTime = GetGameTimer()

			local inMainRadius = dist <= eventLocation.Radius
			local inExtraRadius = dist > eventLocation.Radius and dist <= (eventLocation.Radius + eventLocation.Settings.extraRadius)

			if inMainRadius or inExtraRadius then
				if currentBucketName ~= Config.Bucket and (currentTime - lastBucketChange) >= bucketCooldown then
					exports['buckets']:changeBucket(Config.Bucket)
					lastBucketChange = currentTime
				end
			elseif not inMainRadius then
				if currentBucketName == Config.Bucket and (currentTime - lastBucketChange) >= bucketCooldown then
					exports['buckets']:changeBucket('default')
					lastBucketChange = currentTime
				end
			end

			Wait(0)
		end
	end)
end)

RegisterNetEvent('eventkillthemall:stopEvent', function()
	eventStatus = -1

	if currentBucketName == Config.Bucket then
		exports['buckets']:changeBucket('default')
	end

	if DoesBlipExist(eventBlip) then
		RemoveBlip(eventBlip)
	end

	if DoesBlipExist(eventRadiusBlip) then
		RemoveBlip(eventRadiusBlip)
	end
end)

AddEventHandler('onResourceStop', function(resourceName)
	if resourceName == GetCurrentResourceName() then
		if DoesBlipExist(eventBlip) then
			RemoveBlip(eventBlip)
		end

		if DoesBlipExist(eventRadiusBlip) then
			RemoveBlip(eventRadiusBlip)
		end

		if currentBucketName == Config.Bucket then
			exports['buckets']:changeBucket('default')
		end
	end
end)

function createBlip()
	if DoesBlipExist(eventBlip) then
		RemoveBlip(eventBlip)
	end

	eventBlip = AddBlipForCoord(Config.Locations[eventStatus].Coords)

	SetBlipSprite(eventBlip, Config.Locations[eventStatus].Blips.sprite)
	SetBlipColour(eventBlip, Config.Locations[eventStatus].Blips.color)
	SetBlipScale(eventBlip, Config.Locations[eventStatus].Blips.scale)
	SetBlipAsShortRange(eventBlip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString(Config.Locations[eventStatus].Blips.name)
	EndTextCommandSetBlipName(eventBlip)

	if Config.Locations[eventStatus].BlipRadius.enable then
		if DoesBlipExist(eventRadiusBlip) then
			RemoveBlip(eventRadiusBlip)
		end

		eventRadiusBlip = AddBlipForRadius(Config.Locations[eventStatus].Coords, Config.Locations[eventStatus].Radius)

		SetBlipColour(eventRadiusBlip, Config.Locations[eventStatus].BlipRadius.color)
		SetBlipAlpha(eventRadiusBlip, Config.Locations[eventStatus].BlipRadius.alpha)
	end
end

function dPrints(...)
	if Config.Debug then
		print('['..GetCurrentResourceName()..']: ', ...)
	end
end

exports('isInEvent', function()
	return currentBucketName == Config.Bucket and #(GetEntityCoords(PlayerPedId()) - Config.Locations[eventStatus].Coords) <= Config.Locations[eventStatus].Radius
end)

exports('getRespawnCoords', function()
	if eventStatus ~= -1 then
		return Config.Locations[eventStatus].RespawnCoords[math.random(1, #Config.Locations[eventStatus].RespawnCoords)]
	else
		return vector3(0.0, 0.0, 0.0) -- Default fallback
	end
end)