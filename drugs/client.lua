ESX = nil

local isBusy = false
local inRedzone = nil
local currentField = nil

local pickaxe = nil

local drugProps = {}
local spawnedProps = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	ESX.PlayerData = nil
	ESX.PlayerData = ESX.GetPlayerData()
	
	Wait(5000)
	
	InitScript()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function InitScript()
	SetupBlips()
	
	CreateThread(function()
		while true do
			local sleep = true
			local coords = GetEntityCoords(PlayerPedId())
			
			for k,v in pairs(Config.Locations) do
				if ESX.PlayerData and ESX.PlayerData.job and (Config.Locations[k].job == nil or Config.Locations[k].job == ESX.PlayerData.job.name) then
					if #(coords - v.coords) < (v.spawnRadius + 10.0) then
						sleep = false
						currentField = k
						
						if currentField ~= nil and spawnedProps < Config.MaxProps then
							local x, y, z = table.unpack(GenerateCoords())
							
							if v.modifyZ then
								z = z + v.modifyZ
							end
							
							ESX.Game.SpawnLocalObject(v.prop, vector3(x, y, z), function(obj)
								FreezeEntityPosition(obj, true)
								AddBlipForEntity(obj)
								
								table.insert(drugProps, obj)
								spawnedProps = spawnedProps + 1
							end)
						end
					end
				end
				Wait(250)
			end
			
			if sleep then
				if currentField ~= nil then
					currentField = nil
					DeleteProps()
				end
				
				Wait(1000)
			end
		end
	end)
	
	Citizen.CreateThread(function()
		while true do
			local sleep = true
			
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
			
			if currentField then
				for k,v in pairs(drugProps) do
					if #(coords - GetEntityCoords(v)) < 1.9 then
						sleep = false
						
						if IsPedOnFoot(playerPed) and not isBusy then
							ESX.ShowHelpNotification('Press ~r~[E]~w~ to start gathering ~p~'..Config.Locations[currentField].label)
							
							if IsControlJustReleased(0, 38) then
								GatherDrug(k)
							end
						end
					end
				end
			else
				Wait(2500)
			end
			
			if sleep then
				Wait(500)
			end
			
			Wait(0)
		end
	end)
end

function GatherDrug(id)
	isBusy = true
	SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
	
	if Config.Locations[currentField].scenario then
		TaskStartScenarioInPlace(PlayerPedId(), Config.Locations[currentField].scenario, 0, true)
	elseif Config.Locations[currentField].animationload then
		Citizen.CreateThread(function()
			load(Config.Locations[currentField].animationload)()
		end)
	else
		ExecuteCommand('e mechanic3')
	end

	local duration = Config.Locations[currentField].farmSeconds*1000
	
	if ESX.PlayerData.subscription then
		duration = math.floor(duration/2)
	end
	
	TriggerEvent('mythic_progressbar:client:progress', {
		name = 'gathering',
		duration = duration,
		label = 'Gathering...',
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
	}, function(cancelled)
		if not cancelled then
			DeleteObject(drugProps[id])
			
			if drugProps[id] then
				table.remove(drugProps, id)
			end
			
			spawnedProps = spawnedProps - 1
			
			TriggerServerEvent('drugs:pickedUpDrug', currentField)
		end
		
		isBusy = false
		ExecuteCommand('e c')
	end)
end

function SetupBlips()
	for k,v in pairs(Config.Locations) do
		if v.blip then
			local blip = AddBlipForCoord(v.coords)
			SetBlipSprite(blip, v.blip.sprite)
			SetBlipScale(blip, v.blip.scale)
			SetBlipColour(blip, v.blip.color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString(v.name)
			EndTextCommandSetBlipName(blip)
		end
		
		if v.blipRadius and v.redzoneRadius > 0 then
			local blip = AddBlipForRadius(v.coords, v.redzoneRadius)
			SetBlipHighDetail(blip, true)
			SetBlipColour(blip, v.blipRadius.color)
			SetBlipDisplay(blip, 4)
			SetBlipAlpha(blip, v.blipRadius.alpha)
		end
	end
end

function GenerateCoords()
	while true do
		local canSpawn = true
		math.randomseed(GetGameTimer())
		
		local x = Config.Locations[currentField].coords.x + math.random(-Config.Locations[currentField].spawnRadius, Config.Locations[currentField].spawnRadius)
		local y = Config.Locations[currentField].coords.y + math.random(-Config.Locations[currentField].spawnRadius, Config.Locations[currentField].spawnRadius)
		
		local coords = vector3(x, y, GetCoordZ(x, y))
		
		for k, v in pairs(drugProps) do
			if #(coords - GetEntityCoords(v)) < 5.0 then
				canSpawn = false
				
				break
			end
		end
		
		if canSpawn then
			return coords
		end
		
		Wait(100)
	end
end

function GetCoordZ(x, y)
	for height = Config.Locations[currentField].coords.z - 5, Config.Locations[currentField].coords.z + 5, 1.0 do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
		
		if foundGround then
			return z
		end
	end
	
	return Config.Locations[currentField].coords.z
end

function DeleteProps()
	for k,v in pairs(drugProps) do
		if DoesEntityExist(v) then
			DeleteObject(v)
		end
	end
	
	drugProps = {}
	spawnedProps = 0
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		DeleteProps()
	end
end)

exports('IsInDrugField', function()
	local coords = GetEntityCoords(PlayerPedId())
	for k,v in pairs(Config.Locations) do
		if v.redzoneRadius and v.redzoneRadius > 0 and v.blip then
			if #(coords - v.coords) < v.redzoneRadius then
				return true
			end
		end
	end

	return false
end)