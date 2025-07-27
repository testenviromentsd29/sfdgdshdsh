ESX = nil
local PlayerData = {}
local inCrateZone = nil
local timer = 0
local stopTimer = false
local isDead = false
local LastZone = nil

local activeCrates = {}
local currentCrate = nil
local crateProps = {}
local crateFallingProps = {}

local currentBucket = math.floor(0)
local currentBucketName = "default"

AddEventHandler('buckets:onBucketChanged', function(bucketId, bucketName)
	currentBucket = bucketId
	currentBucketName = bucketName
end)

-- Script things, Get ESX, Get Player's data etc
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

end)

-- Get Event
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	Wait(10000)
	if currentBucketName == Config.EventBucket then
        exports['buckets']:changeBucket('default')
	end
	TriggerServerEvent('CrateDrops:playerLoaded')
end)

-- Check if user changes his Job
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

AddEventHandler('playerSpawned', function()
    Wait(1000)
    if MyZones then
		local coords = GetEntityCoords(PlayerPedId())
		local inCrate = false
		for k,v in pairs(MyZones) do
			if  GetDistanceBetweenCoords(v.x,v.y,v.z, coords, true) < v.radius then
				inCrate = true
				break
			end
		end

		if not inCrate then
			Wait(4000)
			if currentBucketName == Config.EventBucket then
				exports['buckets']:changeBucket('default')
				for k,v in pairs(AreaBlips) do
					SetBlipColour(v, Config.Color)
				end
				
				SendNUIMessage({action = 'hideTime'})
			end
		else
			exports['buckets']:changeBucket(Config.EventBucket)
			for k,v in pairs(AreaBlips) do
				SetBlipColour(v, 5)
			end
		end
    end
end)

RegisterNetEvent('revivedFromMedkit')
AddEventHandler('revivedFromMedkit', function()
    Wait(2500)
    if MyZones then
        local coords = GetEntityCoords(PlayerPedId())
		local inCrate = false
		for k,v in pairs(MyZones) do
			if  GetDistanceBetweenCoords(v.x,v.y,v.z, coords, true) < v.radius then
				inCrate = true
				break
			end
		end
        if inCrate then
            exports['buckets']:changeBucket(Config.EventBucket)
			for k,v in pairs(AreaBlips) do
				SetBlipColour(v, 5)
			end
        end
    end
end)

local Blips = {} 
local AreaBlips = {} 

-- Receive the location of the event
local MyZones = nil
RegisterNetEvent("CrateDrops:PushLocToClient")
AddEventHandler("CrateDrops:PushLocToClient", function(zones, time)
	MyZones = zones
	for k,v in pairs(Blips) do
		RemoveBlip(v)
	end
	for k,v in pairs(AreaBlips) do
		RemoveBlip(v)
	end
	Blips = {} 
	AreaBlips = {} 
	CreateCircle()
	CreateBlip()
	activeCrates = {}
	crateFallingProps = {}
	crateProps = {}
	
	Citizen.CreateThread(function()
		TriggerEvent('top_notifications:show', Config.NotificationData)
		Wait(5*60000)
		TriggerEvent('top_notifications:hide', Config.NotificationData.name)
	end)


	local timeLeft = time or Config.TimeUntilPlaneArrives

    local timeToEnd = GetGameTimer()+timeLeft*math.floor(1000)
    local timeTxt = ''

    while timeLeft > math.floor(0) do
        timeLeft = math.floor((timeToEnd-GetGameTimer())/math.floor(1000))
        local hours = math.floor(timeLeft/math.floor(3600))
        local minutesLeft = timeLeft-hours*math.floor(3600)
        if hours > 0 then
            timeTxt = (('%02s:%02s:%02s'):format(hours,math.floor(minutesLeft/60), math.floor(minutesLeft%60)))
        else
            timeTxt = (('%02s:%02s'):format(math.floor(minutesLeft/60), math.floor(minutesLeft%60)))
        end
		
		if currentBucketName == Config.EventBucket then
			SendNUIMessage({action = 'showTime', time = timeTxt})
		end

        Wait(1000)
    end
	
	SendNUIMessage({action = 'hideTime'})
end)

RegisterNetEvent("CrateDrops:DropCrate")
AddEventHandler("CrateDrops:DropCrate", function(active, login)
	TriggerEvent('InteractSound_CL:PlayOnOne','plane',0.8)
	
	if MyZones then
		if not login then
			RequestWeaponAsset(GetHashKey("weapon_flare")) -- flare won't spawn later in the script if we don't request it right now
			while not HasWeaponAssetLoaded(GetHashKey("weapon_flare")) do
				Wait(0)
			end
			for k,v in pairs(MyZones) do
				ShootSingleBulletBetweenCoords(vector3(v.x,v.y,v.z), vector3(v.x,v.y,v.z) + vector3(0.0001, 0.0001, 0.0001), 0, false, GetHashKey("weapon_flare"), 0, true, false, -1.0) -- flare needs to be dropped with dropCoords like that, otherwise it remains static and won't remove itself later
			end
			Wait(15000)
			for k,v in pairs(MyZones) do
				ESX.Game.SpawnLocalObject("killua_pubg_airdrop_parachute",vector3(v.x,v.y,v.z+100.0), function(obj)
					ActivatePhysics(obj)
					SetDamping(obj, 2, 0.0145)
					SetEntityVelocity(obj, 0.0, 0.0, -0.1)      
					table.insert(crateFallingProps,obj)
				end)
			end
			local deleted = 0
			local total = #MyZones
			local timer = 0
			while deleted ~= total and timer < 120 do
				Wait(100)
				for k,v in pairs(MyZones) do
					if crateFallingProps[k] and GetDistanceBetweenCoords(GetEntityCoords(crateFallingProps[k]),vector3(v.x,v.y,v.z),true) < 5.0 then
						DeleteObject(crateFallingProps[k])
						deleted = deleted + 1
						crateFallingProps[k] = nil
					end
				end
				timer = timer + 1
			end
			if deleted ~= total then
				for k,v in pairs(MyZones) do
					if crateFallingProps[k] then
						DeleteObject(crateFallingProps[k])
						crateFallingProps[k] = nil
					end
				end
			end
			RemoveWeaponAsset(GetHashKey("weapon_flare"))
		end
		for k,v in pairs(MyZones) do
			ESX.Game.SpawnLocalObject("killua_pubg_airdrop",vector3(v.x,v.y,v.z), function(obj)
				PlaceObjectOnGroundProperly(obj)
				FreezeEntityPosition(obj, true)
				table.insert(crateProps,obj)
			end)
		end
		activeCrates = active
	end
end)

RegisterCommand('crate', function()
	local msg = 'Το crate πέφτει καθημερινά στις: 00:15, 01:15, 02:15, 03:15, 04:15, 05:15, 06:15, 07:15, 08:15, 09:15, 10:15, 11:15, 12:15, 13:15, 14:15, 15:15, 16:15, 17:15, 18:15, 19:15, 20:15, 21:15, 22:15, 23:15'
	TriggerEvent('chat:addMessage', {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 255, 0 , 0.6); border-radius: 3px;"> @{Crate Info}: {0}</div> ',
		args = { msg }
	})
end)

function CreateCircle()
	for k,v in pairs(MyZones) do
		local Circle = AddBlipForRadius(v.x, v.y, v.z, v.radius)

		SetBlipHighDetail(Circle, true)
		SetBlipColour(Circle, Config.Color)
		SetBlipAlpha (Circle, Config.Alpha)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(text)
		EndTextCommandSetBlipName(Circle)
		table.insert(AreaBlips, Circle)	
	end
end

function CreateBlip()
	for k,v in pairs(MyZones) do
		local Blip = AddBlipForCoord(v.x, v.y, v.z)
		
		SetBlipSprite(Blip, 478)
		SetBlipScale  (Blip, Config.Size)
		SetBlipColour (Blip, nil)

		SetBlipAsShortRange(Blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Name)
		EndTextCommandSetBlipName(Blip)
		table.insert(Blips, Blip)	
	end
end

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
	if inCrateZone then
		timer = 0
		inCrateZone = false
		TriggerEvent('mythic_progressbar:client:cancel')
	end
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

-- Check if user changes his Job
RegisterNetEvent('CrateDrops:ResetAll')
AddEventHandler('CrateDrops:ResetAll', function()
	for k,v in pairs(Blips) do
		RemoveBlip(v)
	end
	for k,v in pairs(AreaBlips) do
		RemoveBlip(v)
	end
	Blips = {} 
	AreaBlips = {}
	MyZones = nil
	if currentBucketName == Config.EventBucket then
        exports['buckets']:changeBucket('default')
		SendNUIMessage({action = 'hideTime'})
	end
end)

AddEventHandler('CrateDrops:hasEnteredMarker', function(zone)
	if zone == 'Crate' and not isDead and GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
		if timer == 0 and not inCrateZone then
			inCrateZone = true
			TriggerServerEvent("CrateDrops:startCollecting",currentCrate)
			TriggerEvent('mythic_progressbar:client:progress',{
				name = "open_crate",
				duration = (Config.CrateCollectTimer+1)*1000,
				label = 'Opening Crate...',
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = false,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "mini@repair",
					anim = "fixing_a_player",
					flags = 49,
				},
			   
			}, function(cancelled)
				if not cancelled then
					TriggerServerEvent("CrateDrops:Collect",currentCrate)
				else
					TriggerEvent('mythic_progressbar:client:cancel')
				end
			end)
		end
		-- if not isDead then
		-- 	timer = timer+1
		-- end
		-- if timer == Config.CrateCollectTimer then
		-- 	TriggerServerEvent("CrateDrops:Collect")
		-- end
	end
	-- print(CurrentAction)
end)


--[[ AddEventHandler('CrateDrops:hasExitedMarker', function(zone)
	if inCrateZone then
		inCrateZone = false
		timer = 0
		TriggerEvent('mythic_progressbar:client:cancel')
	end
	CurrentAction = nil
	currentLocation = nil
	ESX.UI.Menu.CloseAll()
end) ]]

AddEventHandler('CrateDrops:hasExitedMarker', function(zone)
	if inCrateZone then
		inCrateZone = false
		timer = 0
	end
	CurrentAction = nil
	currentLocation = nil
	ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent("CrateDrops:crateCollected")
AddEventHandler("CrateDrops:crateCollected", function(crate)
	print(crate)
	activeCrates[crate] = false
	RemoveBlip(AreaBlips[crate])
	RemoveBlip(Blips[crate])
	DeleteObject(crateProps[crate])
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(PlayerPedId())
		local letSleep = true

		if MyZones then
			for k,v in pairs(MyZones) do
				if activeCrates[k] and GetDistanceBetweenCoords(v.x,v.y,v.z, coords, true) < 70.0 then
					letSleep = false
					DrawMarker(1, v.x,v.y,v.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0,3.0,1.0, 240,20,80, 100, false, true, 2, false, nil, nil, false)
				end
			end
		end

		if letSleep then
			Citizen.Wait(2000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local wait = 2000
		if MyZones then
			local coords = GetEntityCoords(PlayerPedId())
			local inRedZone = false
			local inZone = false
			for k,v in pairs(MyZones) do
				if GetDistanceBetweenCoords(v.x,v.y,v.z, coords, false) < v.radius then
					inZone = true
					break
				end
				if GetDistanceBetweenCoords(v.x,v.y,v.z, coords, false) < v.radius + 50.0 and GetDistanceBetweenCoords(v.x,v.y,v.z, coords, false) > v.radius then
					inRedZone = true
					break
				end
			end

			if inRedZone then
				wait = 0

				--SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
				DisableControlAction(0, 25, true)
				DisableControlAction(0, 24, true)
				DisableControlAction(0, 257, true)
				DisableControlAction(0, 263, true)

				DisableControlAction(0, 170, true)
				DisableControlAction(1, 170, true)

				exports['dpemotes']:ForceCloseMenu()

				if IsPedInAnyVehicle(PlayerPedId()) then
					SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
				end

				if IsDisabledControlJustPressed(0, 170) or IsDisabledControlJustPressed(1, 170) then
					SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
				end
			end
		end
		
		Wait(wait)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker = false
		local temp = nil
		if MyZones then
			for k,v in pairs(MyZones) do
				if GetDistanceBetweenCoords(v.x,v.y,v.z, coords, true) < v.radius and GetDistanceBetweenCoords(v.x,v.y,v.z, coords, true) > v.radius - 10.0 and currentBucketName ~= Config.EventBucket then
					local _, weapon = GetCurrentPedWeapon(PlayerPedId(), false)
					if weapon ~= GetHashKey('WEAPON_UNARMED') then
						exports['buckets']:changeBucket(Config.EventBucket)
						for k,v in pairs(AreaBlips) do
							SetBlipColour(v, 5)
						end
					else
						ESX.ShowNotification('Θα πρέπει να μπεις στην περιοχή κρατώντας όπλο')
						Wait(3000)
					end
				elseif GetDistanceBetweenCoords(v.x,v.y,v.z, coords, true) > v.radius and currentBucketName == Config.EventBucket then
					exports['buckets']:changeBucket('default')
					for k,v in pairs(AreaBlips) do
						SetBlipColour(v, Config.Color)
					end
					
					SendNUIMessage({action = 'hideTime'})
				end

				if activeCrates[k] and GetDistanceBetweenCoords(v.x,v.y,v.z, coords, true) < 5.0 and currentBucketName == Config.EventBucket then
					isInMarker  = true
					LastZone    =  currentZone
					currentZone = 'Crate'
					temp = k
				end
			end
		end
		currentCrate = temp

		-- print(currentZone)
		if isInMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('CrateDrops:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			currentZone = nil
			TriggerEvent('CrateDrops:hasExitedMarker', LastZone)
		end

		if not isInMarker then
			Wait(2000)
		end
	end
end)

exports('IsOnCrate', function()
	if currentBucketName == Config.EventBucket then
		return true
	end
	
	return false
end)