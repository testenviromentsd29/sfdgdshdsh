local ESX = nil
local PlayerData = {}

local battleground = {owner = 'none'}
local eventArea
local areaBlip = nil
local eventBlip = nil
local droppedWeapons = {}
local onGoingCapture = false
local wasInBattleground = false
local crateProp
local kills = 0

local currentBucket = math.floor(0)
local currentBucketName = "default"

AddEventHandler('buckets:onBucketChanged', function(bucketId, bucketName)
	currentBucket = bucketId
	currentBucketName = bucketName
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	PlayerData = ESX.GetPlayerData()

    ESX.TriggerServerCallback('battleground:getData', function(data)
		battleground = data
    end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer

	Wait(5000)
	if currentBucketName == Config.EventBucket then
        exports['buckets']:changeBucket('default')
	end
end)

AddEventHandler('playerSpawned', function()
    Wait(1000)
    if eventArea then
        if currentBucketName == Config.EventBucket then
            exports['buckets']:changeBucket('default')
        end
    end
end)

--[[ RegisterNetEvent('revivedFromMedkit')
AddEventHandler('revivedFromMedkit', function()
    Wait(2500)
    if eventArea and wasInBattleground then
        local coords = GetEntityCoords(PlayerPedId())
        local dist = GetDistanceBetweenCoords(coords, Config.Battlegrounds[eventArea].pos, true)
        if dist < Config.Battlegrounds[eventArea].radius then
            exports['buckets']:changeBucket(Config.EventBucket)
        end
    end
end) ]]

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent("battleground:startEvent")
AddEventHandler("battleground:startEvent", function(area)
    eventArea = area
    createBlips()
    createNpc()
    Citizen.CreateThread(startInZoneCheck)
    Citizen.CreateThread(startRadiusColour)

    StartBattleground()
end)

RegisterNetEvent("battleground:stopEvent")
AddEventHandler("battleground:stopEvent", function()
    eventArea = nil

    if currentBucketName == Config.EventBucket then
        exports['buckets']:changeBucket('default')
    end
    
    RemoveBlip(areaBlip)
    RemoveBlip(eventBlip)
    areaBlip = nil
    eventBlip = nil
    onGoingCapture = false
    kills = 0

    if crateProp and DoesEntityExist(crateProp) then
        DeleteEntity(crateProp)
    end
    crateProp = nil

    for k,v in pairs(droppedWeapons) do
        if DoesEntityExist(v.obj) then
            DeleteEntity(v.obj)
        end
    end
    droppedWeapons = {}
end)

RegisterNetEvent('battleground:startCapture')
AddEventHandler('battleground:startCapture', function(attacker, time)
	onGoingCapture = true
	
	local timeLeft = time or Config.CaptureTime
	
    SendNUIMessage({action = 'start_capture', time = math.floor(0)})

	SetTimeout(1000, function()
		while timeLeft > math.floor(0) and onGoingCapture do
			timeLeft = timeLeft - math.floor(1)
			
            SendNUIMessage({action = 'update_capture', percent = ESX.Math.Round(math.floor(100) - ((timeLeft/Config.CaptureTime) * math.floor(100)))})

			if timeLeft % math.floor(2) == math.floor(0) then
				SetBlipFade(areaBlip, math.floor(128), math.floor(255))
			else
				SetBlipFade(areaBlip, math.floor(200), math.floor(255))
			end
			
			if attacker == GetPlayerServerId(PlayerId()) then
				if currentBucketName ~= Config.EventBucket or IsEntityDead(PlayerPedId()) then
					TriggerServerEvent('battleground:endCapture', false)
					break
				end
				
				if timeLeft == math.floor(0) then
					TriggerServerEvent('battleground:endCapture', true)
				end
			end

            Wait(1000)
		end
	end)
	
    local hidden = true
	Citizen.CreateThread(function()
		while timeLeft > math.floor(0) and onGoingCapture do
			if currentBucketName == Config.EventBucket then
                if hidden then
                    hidden = false
				    SendNUIMessage({action = 'show_capture'})
                end
			else
                if not hidden then
                    hidden = true
                    SendNUIMessage({action = 'hide_capture'})
                end
			end
			
			Wait(1000)
		end
	end)
end)

RegisterNetEvent('battleground:endCapture')
AddEventHandler('battleground:endCapture', function(newowner)
	onGoingCapture = false
    SetBlipAlpha(areaBlip, math.floor(150))
    Wait(1000)
    SendNUIMessage({action = 'hide_capture'})

    if newowner then
        battleground.owner = newowner
    end
end)

RegisterNetEvent("battleground:dropCrate")
AddEventHandler("battleground:dropCrate", function(crate, login)
    local cratePos = Config.Battlegrounds[eventArea].crates[crate]
    local crateBlip = CreateCrateBlip(crate)
    if not login then
        TriggerEvent('InteractSound_CL:PlayOnOne','plane',0.8)

        RequestWeaponAsset(GetHashKey("weapon_flare")) -- flare won't spawn later in the script if we don't request it right now
        while not HasWeaponAssetLoaded(GetHashKey("weapon_flare")) do
            Wait(0)
        end

        ShootSingleBulletBetweenCoords(vector3(cratePos.x,cratePos.y,cratePos.z - 1.0), vector3(cratePos.x,cratePos.y,cratePos.z - 1.0) + vector3(0.0001, 0.0001, 0.0001), 0, false, GetHashKey("weapon_flare"), 0, true, false, -1.0) -- flare needs to be dropped with dropCoords like that, otherwise it remains static and won't remove itself later

        Wait(10000)

        local crateFallingProp
        ESX.Game.SpawnLocalObject("prop_drop_armscrate_01",vector3(cratePos.x,cratePos.y,cratePos.z+100.0), function(obj)
            ActivatePhysics(obj)
            SetDamping(obj, 2, 0.0145)
            SetEntityVelocity(obj, 0.0, 0.0, -0.1)
            crateFallingProp = obj
        end)

        local deleted = 0
        local total = 1
        local timer = 0
        while deleted ~= total and timer < 120 do
            Wait(100)
            if crateFallingProp and GetDistanceBetweenCoords(GetEntityCoords(crateFallingProp),vector3(cratePos.x,cratePos.y,cratePos.z),true) < 5.0 then
                DeleteObject(crateFallingProp)
                deleted = deleted + 1
                crateFallingProp = nil
            end
            timer = timer + 1
        end
        if deleted ~= total then
            if crateFallingProp then
                DeleteObject(crateFallingProp)
                crateFallingProp = nil
            end
        end
        RemoveWeaponAsset(GetHashKey("weapon_flare"))
    end

    ESX.Game.SpawnLocalObject("prop_drop_crate_01",vector3(cratePos.x,cratePos.y,cratePos.z), function(obj)
        PlaceObjectOnGroundProperly(obj)
        FreezeEntityPosition(obj, true)
        crateProp = obj

        StartCrate(crate, crateBlip)
    end)
end)

RegisterNetEvent("battleground:crateCollected")
AddEventHandler("battleground:crateCollected", function()
	if crateProp and DoesEntityExist(crateProp) then
        DeleteEntity(crateProp)
    end
    crateProp = nil
end)

RegisterNetEvent('battleground:killedPlayer')
AddEventHandler('battleground:killedPlayer', function()
    SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
    local maxArmour = GetPlayerMaxArmour(PlayerId())
    if maxArmour < 200 then
        SetPlayerMaxArmour(PlayerId(), 200)
    end

    AddArmourToPed(PlayerPedId(), 200)

    kills = kills + 1
    SendNUIMessage({action = 'showKills', kills = kills})
end)

RegisterNetEvent('battleground:updateKills')
AddEventHandler('battleground:updateKills', function(newkills)
    kills = newkills
    SendNUIMessage({action = 'showKills', kills = kills})
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	if currentBucketName == Config.EventBucket then
        wasInBattleground = true
        --local weapon = GetSelectedPedWeapon(PlayerPedId())
		--TriggerServerEvent('battleground:onPlayerDeath', weapon)
    else
        wasInBattleground = false
	end
end)

RegisterNetEvent('battleground:onPlayerDeath')
AddEventHandler('battleground:onPlayerDeath', function(coords, id, weaponName)
	if currentBucketName == Config.EventBucket then
		local coords = vector3((coords.x + 1.0), (coords.y + 1.0), coords.z)
		local weaponHash = GetHashKey(weaponName)
		
		WeaponAssetLoad(weaponHash)
		
		droppedWeapons[id] = {obj = CreateWeaponObject(weaponHash, math.floor(50), coords.x, coords.y, coords.z, true, 1.0, math.floor(0)), coords = coords}
		
		while not DoesEntityExist(droppedWeapons[id].obj) do
			Wait(100)
		end
		
		PlaceObjectOnGroundProperly(droppedWeapons[id].obj)
		coords = GetEntityCoords(droppedWeapons[id].obj)
		SetEntityCoords(droppedWeapons[id].obj, coords.x, coords.y, coords.z - 0.05)
		SetEntityRotation(droppedWeapons[id].obj, 90.0, 0.0, 0.0)
		
		RemoveWeaponAsset(weaponHash)
	end
end)

RegisterNetEvent('battleground:getDroppedWeapon')
AddEventHandler('battleground:getDroppedWeapon', function(id)
	if droppedWeapons[id] then
		if DoesEntityExist(droppedWeapons[id].obj) then
			DeleteEntity(droppedWeapons[id].obj)
		end
	end
	
	droppedWeapons[id] = nil
end)

function startInZoneCheck()
    CreateThread(function()
        while eventArea do
            local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.Battlegrounds[eventArea].pos, true)
            if currentBucketName == "default" and dist < (Config.Battlegrounds[eventArea].radius + 50.0) then
                --SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
                DisableControlAction(math.floor(0), math.floor(25), true)
                DisableControlAction(math.floor(0), math.floor(24), true)
                DisableControlAction(math.floor(0), math.floor(257), true)
                DisableControlAction(math.floor(0), math.floor(263), true)

                DisableControlAction(math.floor(0), math.floor(170), true)
				DisableControlAction(math.floor(1), math.floor(170), true)

				exports['dpemotes']:ForceCloseMenu()

				if IsPedInAnyVehicle(PlayerPedId()) then
					SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
				end

                if IsDisabledControlJustPressed(math.floor(0), math.floor(170)) or IsDisabledControlJustPressed(math.floor(1), math.floor(170)) then
                    SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
                end
            else
                Wait(1500)
            end
            
            Wait(0)
        end
    end)

    while eventArea do
        local coords = GetEntityCoords(PlayerPedId())
        local dist = GetDistanceBetweenCoords(coords, Config.Battlegrounds[eventArea].pos, true)

        if currentBucketName == "default" then
            if dist < Config.Battlegrounds[eventArea].radius and dist > (Config.Battlegrounds[eventArea].radius - 10.0) then
                if GetVehiclePedIsIn(PlayerPedId(), false) == math.floor(0) then
                    local _, weapon = GetCurrentPedWeapon(PlayerPedId(), false)
					if weapon ~= GetHashKey('WEAPON_UNARMED') then
						local canEnter
						ESX.TriggerServerCallback('battleground:canEnter', function(cb)
							canEnter = cb
						end)
						while canEnter == nil do Wait(100) end
						
						if canEnter then
							exports['buckets']:changeBucket(Config.EventBucket)
							ESX.ShowNotification('You entered the Battleground')
							SendNUIMessage({action = 'showKills', kills = kills})
						end
                    else
                        ESX.ShowNotification('Θα πρέπει να μπεις στην περιοχή κρατώντας όπλο')
                    end
                    Wait(3000)
                else
                    ESX.ShowNotification('You have to enter the area without a vehicle')
                end
            end
        elseif currentBucketName == Config.EventBucket then
            if dist > Config.Battlegrounds[eventArea].radius then
				TriggerServerEvent('battleground:leftZone')
                exports['buckets']:changeBucket('default')
                SendNUIMessage({action = 'hideKills'})
                Wait(3000)
            end
        end

        Wait(1000)
    end
end

function StartBattleground()
    while eventArea do
        local wait = 1000

        if currentBucketName == Config.EventBucket then
            for k,v in pairs(droppedWeapons) do
                local pedCoords = GetEntityCoords(PlayerPedId())
                local weaponCoords = v.coords
                local dist = GetDistanceBetweenCoords(pedCoords, weaponCoords, true)

                if dist <= 1.0 then
                    wait = math.floor(0)
                    ESX.Game.Utils.DrawText3D(vector3(weaponCoords.x, weaponCoords.y, weaponCoords.z + 0.05), 'Press [~g~E~w~] to pickup weapon', 0.4, math.floor(0))

                    if IsControlJustReleased(math.floor(0), math.floor(38)) then
                        ExecuteCommand('e jpickup')
                        Wait(math.random(math.floor(0),math.floor(500)))
                        TriggerServerEvent('battleground:getDroppedWeapon', k)
                        Wait(1000)
                    end
                end
            end

            local coords = GetEntityCoords(PlayerPedId())
            local dist = #(coords - Config.Battlegrounds[eventArea].pos)

            if dist <= 10.0 then
                wait = math.floor(0)

                if battleground.owner ~= PlayerData.job.name then
                    ESX.Game.Utils.DrawText3D(vector3(Config.Battlegrounds[eventArea].pos.x, Config.Battlegrounds[eventArea].pos.y, Config.Battlegrounds[eventArea].pos.z + 1.0), 'Press [~g~E~w~] to capture the area', 1.0, math.floor(0))

                    if dist <= 2.0 then
                        if IsControlJustReleased(math.floor(0), math.floor(38)) then
                            TriggerServerEvent('battleground:startCapture')
                        end
                    end
                else
                    ESX.Game.Utils.DrawText3D(vector3(Config.Battlegrounds[eventArea].pos.x, Config.Battlegrounds[eventArea].pos.y, Config.Battlegrounds[eventArea].pos.z + 1.0), 'Press [~g~E~w~] to get your rewards', 1.0, math.floor(0))

                    if dist <= 2.0 then
                        if IsControlJustReleased(math.floor(0), math.floor(38)) then
                            if PlayerData.job.grade_name == 'boss' then
                                RewardsMenu()
                            else
                                ESX.ShowNotification('Only the boss can take the rewards')
                            end
                        end
                    end
                end
            end
        end

        Wait(wait)
    end
end

function StartCrate(crate, crateBlip)
    local cratePos = Config.Battlegrounds[eventArea].crates[crate]
    while crateProp do
        local coords = GetEntityCoords(PlayerPedId())
        if #(coords - cratePos) < 1.5 then
            local success
            TriggerServerEvent("battleground:startCollecting")
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
                    success = true
				else
                    success = false
				end
			end)

            while success == nil do Wait(100) end

            if success then
                TriggerServerEvent("battleground:Collect")
                Wait(2000)
            else
                TriggerEvent('mythic_progressbar:client:cancel')
            end
        end
        Wait(1000)
    end

    RemoveBlip(crateBlip)
end

function RewardsMenu()
	local tempData
	
	ESX.TriggerServerCallback('battleground:getData', function(data) tempData = data end, false)
	while tempData == nil do Wait(0) end
	battleground = tempData
	
	local elements = {}
	
	for k,v in pairs(battleground.weapons) do
		table.insert(elements, {label = string.gsub(v, 'WEAPON_', ''), value = k})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rewards', {
		title    = 'Rewards',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		local id = data.current.value
		menu.close()
		
		ESX.TriggerServerCallback('battleground:getReward', function()
			RewardsMenu()
		end, id)
	end,
	function(data, menu)
		menu.close()
	end)
end

function startRadiusColour()
    while eventArea do
        if currentBucketName == Config.EventBucket then
            SetBlipColour(areaBlip, 5)
        else
            SetBlipColour(areaBlip, Config.areaColour)
        end
        Wait(1000)
    end
end

function CreateCrateBlip(crate)
    local cratePos = Config.Battlegrounds[eventArea].crates[crate]
    local Blip = AddBlipForCoord(cratePos.x, cratePos.y, cratePos.z)
    
    SetBlipSprite(Blip, 478)
    SetBlipScale  (Blip, 0.8)
    SetBlipColour (Blip, nil)

    SetBlipAsShortRange(Blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Battleground Crate')
    EndTextCommandSetBlipName(Blip)
    return Blip
end

function createBlips()
    areaBlip = AddBlipForRadius(Config.Battlegrounds[eventArea].pos, Config.Battlegrounds[eventArea].radius)

    SetBlipHighDetail(areaBlip, true)
    SetBlipAsShortRange(areaBlip, true)
    SetBlipDisplay(areaBlip, math.floor(4))
    SetBlipColour(areaBlip, Config.areaColour)
    SetBlipAlpha(areaBlip, math.floor(150))

    eventBlip = AddBlipForCoord(Config.Battlegrounds[eventArea].pos.x, Config.Battlegrounds[eventArea].pos.y, Config.Battlegrounds[eventArea].pos.z)
		
    SetBlipSprite(eventBlip, math.floor(439))
    SetBlipScale(eventBlip, 1.5)
    SetBlipColour(eventBlip, math.floor(46))

    SetBlipAsShortRange(eventBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Battleground")
    EndTextCommandSetBlipName(eventBlip)
end

function createNpc()
    RequestModel(Config.Battlegrounds[eventArea].model)
        
    while not HasModelLoaded(Config.Battlegrounds[eventArea].model) do
        Wait(10)
    end

    RequestAnimDict('mini@strip_club@idles@bouncer@base')

    while not HasAnimDictLoaded('mini@strip_club@idles@bouncer@base') do
        Wait(10)
    end
    
    local npc = CreatePed(5, Config.Battlegrounds[eventArea].model, Config.Battlegrounds[eventArea].pos.x, Config.Battlegrounds[eventArea].pos.y, Config.Battlegrounds[eventArea].pos.z - math.floor(1), Config.Battlegrounds[eventArea].heading, false, true)
    SetEntityHeading(npc, Config.Battlegrounds[eventArea].heading)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    
    TaskPlayAnim(npc, 'mini@strip_club@idles@bouncer@base', 'base', 8.0, 0.0, math.floor(-1), math.floor(1), math.floor(0), math.floor(0), math.floor(0), math.floor(0))
    
    SetModelAsNoLongerNeeded(Config.Battlegrounds[eventArea].model)
end

function WeaponAssetLoad(weaponHash)
	if not HasWeaponAssetLoaded(weaponHash) then
		RequestWeaponAsset(weaponHash)
		
		while not HasWeaponAssetLoaded(weaponHash) do
			Citizen.Wait(0)
		end
	end
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        if crateProp and DoesEntityExist(crateProp) then
            DeleteEntity(crateProp)
        end

        for k,v in pairs(droppedWeapons) do
			if DoesEntityExist(v.obj) then
				DeleteEntity(v.obj)
			end
		end
	end
end)

exports('IsOnBattleground', function()
    return currentBucketName == Config.EventBucket
end)

exports('isEventActive', function()
    return eventArea ~= nil
end)