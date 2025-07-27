ESX = nil

local currentBucket = 0
local currentBucketName = 'default'

local isFreezed = false

local properties = {}
local dialogDesc = {}
local dialogDescGarage = {}

local blips = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	while GetResourceState('nProperties') ~= 'started' and GetResourceState('nProperties') ~= 'running' do
		Wait(250)
	end
	
	properties = exports['nProperties']:GetProperties()
	
	local temp = {}
	
	for k,v in pairs(properties) do
		if v.bucket and v.bucket ~= 'default' then
			if temp[v.bucket] == nil then
				temp[v.bucket] = {[1] = k}
			end
			
			temp[v.bucket][2] = k
		end
	end
	
	for k,v in pairs(temp) do
		local name, id, floor = k:match('([^_]+)_([^_]+)_([^_]+)')
		
		if dialogDesc[name..'_'..id] == nil then
			dialogDesc[name..'_'..id] = {}
		end
		
		dialogDesc[name..'_'..id][tonumber(floor)] = '['..v[1]..'-'..v[2]..']'
		
		if dialogDescGarage[name..'_'..id] == nil then
			dialogDescGarage[name..'_'..id] = {[1] = 999999999, [2] = -1}
		end
		
		if dialogDescGarage[name..'_'..id][1] > v[1] then
			dialogDescGarage[name..'_'..id][1] = v[1]
		end
		
		if dialogDescGarage[name..'_'..id][2] < v[2] then
			dialogDescGarage[name..'_'..id][2] = v[2]
		end
	end
	
	InitScript()
end)

AddEventHandler('buckets:onBucketChanged', function(bucketId, bucketName, firstSpawn)
	currentBucket = bucketId
	currentBucketName = bucketName
end)

function InitScript()
	--CreateBlips()
	
	Citizen.CreateThread(function()
		while true do
			local wait = 2500
			local coords = GetEntityCoords(PlayerPedId())
			
			for k,v in pairs(Config.Locations) do
				for i=1, #v do
					if #(coords - v[i].coords) < 20.0 and currentBucketName == v[i].bucket then
						wait = 0
						DrawMarker(0, v[i].coords, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 100, 255, 0, 100, false, false, 2, false, false, false, false)
						
						if #(coords - v[i].coords) < 1.0 and not isFreezed then
							ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to use the elevator')
							
							if IsControlJustReleased(0, 38) then
								local desc = 'Floor 0: Reception</br>'
								
								for k,v in ipairs(dialogDesc[k]) do
									desc = desc..'Floor '..k..': '..v..'</br>'
								end
								
								local value = tonumber(exports['dialog']:Create('Elevator', 'Enter floor number [0-'..(#v-1)..']', desc).value or -1)
								
								if value >= 0 and value <= (#v-1) then
									value = value + 1
									
									exports['buckets']:changeBucket(v[value].bucket)
									SetEntityCoordsNight(v[value].coords, v[value].heading)
								end
							end
						end
					end
				end
			end
			
			for k,v in pairs(Config.Garages) do
				if #(coords - v.coords) < 20.0 and currentBucketName == 'default' then
					wait = 0
					DrawMarker(36, v.coords, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, false, 2, true, false, false, false)
					
					if #(coords - v.coords) < 1.0 and not isFreezed then
						ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to enter the garage')
						
						if IsControlJustReleased(0, 38) then
							local desc = 'Enter House ID ['..dialogDescGarage[k][1]..' - '..dialogDescGarage[k][2]..']'
							local value = tonumber(exports['dialog']:Create('Garage', desc).value or -1)
							
							if value >= dialogDescGarage[k][1] and value <= dialogDescGarage[k][2] then
								exports['nProperties']:EnterGarage(value)
							else
								ESX.ShowNotification('Invalid House ID')
							end
						end
					end
				end
			end
			
			Wait(wait)
		end
	end)
end

function SetEntityCoordsNight(coords, heading)
	isFreezed = true
	
	SetEntityCoords(PlayerPedId(), coords)
	SetEntityHeading(PlayerPedId(), heading)
	
	SetEntityHasGravity(PlayerPedId(), false)
	FreezeEntityPosition(PlayerPedId(), true)
	
	Citizen.CreateThread(function()
		while isFreezed do
			ESX.ShowHelpNotification('Press ~r~[R]~w~ to unfreeze')
			
			SetEntityHasGravity(PlayerPedId(), false)
			FreezeEntityPosition(PlayerPedId(), true)
			
			if IsControlJustPressed(0, 45) then
				SetEntityHasGravity(PlayerPedId(), true)
				FreezeEntityPosition(PlayerPedId(), false)
				
				break
			end
			
			Wait(0)
		end
		
		Wait(500)
		isFreezed = false
	end)
end

RegisterCommand('hideapartments', function(source, args)
	local blipsOn = DoesBlipExist(blips['apartment_1']) and true or false
	
	if blipsOn then
		DeleteBlips()
		ESX.ShowNotification('Apartment Blips: OFF')
	else
		CreateBlips()
		ESX.ShowNotification('Apartment Blips: ON')
	end
end)

function CreateBlips()
	for k,v in pairs(Config.Blips) do
		local blip = AddBlipForCoord(Config.Locations[k][1].coords)
		SetBlipSprite(blip, v.blip)
		SetBlipScale(blip, v.scale)
		SetBlipColour(blip, v.color)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(v.name)
		EndTextCommandSetBlipName(blip)
		
		blips[k] = blip
	end
end

function DeleteBlips()
	for k,v in pairs(blips) do
		if DoesBlipExist(v) then
			RemoveBlip(v)
		end
	end
	
	blips = {}
end

exports('GetLocationEntrance', function(location)
	if Config.Locations[location] then
		return Config.Locations[location][1].coords
	end
	
	return nil
end)

exports('GetGarageEntrance', function(location)
	if Config.Garages[location] then
		return Config.Garages[location].coords, Config.Garages[location].heading
	end
	
	return nil, nil
end)