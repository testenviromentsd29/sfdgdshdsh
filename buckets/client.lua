ESX = nil

local currentBucket = 0
local currentBucketName = 'default'

_tmp = {bucket = currentBucket, name = currentBucketName}
GlobalState.bucketData = _tmp

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(100)
	end
end)

RegisterNetEvent('buckets:changeBucket')
AddEventHandler('buckets:changeBucket', function(bucketId, bucketName, firstSpawn)
	currentBucket = bucketId
	currentBucketName = bucketName
	
	if currentBucket == 0 then
		currentBucketName = 'default'
	end

	local tmp = {bucket = currentBucket, name = currentBucketName}
	GlobalState.bucketData = tmp
	
	print(currentBucket, currentBucketName)
	
	TriggerEvent('buckets:onBucketChanged', currentBucket, currentBucketName, firstSpawn)
end)

function changeBucket(zone, vehicle)
	local wait = true
	local netId
	
	if vehicle and GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
		netId = NetworkGetNetworkIdFromEntity(vehicle)
	end
	
	ESX.TriggerServerCallback('buckets:changeBucket', function(bucketId, bucketName)
		currentBucket = bucketId
		currentBucketName = bucketName
		
		wait = false
	end, zone, netId)
	
	while wait do
		Wait(25)
	end
	
	if currentBucket == 0 then
		currentBucketName = 'default'
	end

	local tmp = {bucket = currentBucket, name = currentBucketName}
	GlobalState.bucketData = tmp
	
	print(currentBucket, currentBucketName)
	
	TriggerEvent('buckets:onBucketChanged', currentBucket, currentBucketName)
end

exports('changeBucket', function(zone, vehicle)
	changeBucket(zone, vehicle)
end)

exports('getCurrentBucket', function()
	return {bucket = currentBucket, name = currentBucketName}
end)