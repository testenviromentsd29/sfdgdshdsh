ESX = nil
local PlayerData = nil
local notifyCargoBlip
local notifyCargoRadarBlip
local destinationCargoBlip
local wasInRedzone = false
local cargoDriver = false
local currentLocation
local cargoRedzone = false
local redzoneBlip
local currentCargo

local currentBucket = math.floor(0)
local currentBucketName = "default"

AddEventHandler('buckets:onBucketChanged', function(bucketId, bucketName)
	currentBucket = bucketId
	currentBucketName = bucketName
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Wait(100)
	end
	
	PlayerData = ESX.GetPlayerData()

	Wait(2000)
	InitScript()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
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
    if cargoRedzone then
        if currentBucketName == Config.EventBucket then
            exports['buckets']:changeBucket('default')
        end
    end
end)

--[[ RegisterNetEvent('revivedFromMedkit')
AddEventHandler('revivedFromMedkit', function()
    Wait(2500)
    if cargoRedzone and wasInRedzone then
        local coords = GetEntityCoords(PlayerPedId())
        local dist = GetDistanceBetweenCoords(coords, Config.Cargos[currentCargo].Locations[currentLocation], true)
        if dist < Config.RedzoneRadius then
            exports['buckets']:changeBucket(Config.EventBucket)
        end
    end
end) ]]

AddEventHandler('esx:onPlayerDeath', function(data)
	if cargoRedzone and currentBucketName == Config.EventBucket then
        wasInRedzone = true
	else
		wasInRedzone = false
	end
end)

RegisterNetEvent('drugCargo:resetCargo', function()
	ResetCargo()
end)

RegisterNetEvent('drugCargo:onCargoStart', function(caller, netId)
	if caller and netId and caller == GetPlayerServerId(PlayerId()) then
		while not NetworkDoesNetworkIdExist(netId) do
			Wait(0)
		end

		local vehicle = NetworkGetEntityFromNetworkId(netId)

		if DoesEntityExist(vehicle) then
			SetVehicleCanLeakOil(vehicle, false)
			SetVehicleCanLeakPetrol(vehicle, false)
			SetEntityProofs(vehicle, true, true, true, true, true, true, 1, true)
		end
	end
end)

RegisterNetEvent('drugCargo:startCargo', function(cargo)
	while GlobalState.drugCargoCoords == nil do Wait(100) end

	currentCargo = cargo

	Citizen.CreateThread(notifyCargoLocation)
	
	while currentLocation == nil do Wait(100) end

	while currentCargo do
		local vehicle = GetVehiclePedIsIn(PlayerPedId())

		if vehicle and (GetPedInVehicleSeat(vehicle, math.floor(-1)) == PlayerPedId()) and (GetVehicleNumberPlateText(vehicle) == Config.CargoSpawn.plate) then
			if not cargoDriver then
				cargoDriver = true
				SetNewWaypoint(Config.Cargos[currentCargo].Locations[currentLocation].x, Config.Cargos[currentCargo].Locations[currentLocation].y)
				CreateDestinationBlip()
			end
		else
			if cargoDriver then
				cargoDriver = false
				SetWaypointOff()
				RemoveBlip(destinationCargoBlip)
				destinationCargoBlip = nil
			end
		end

		if cargoDriver then
			SetVehicleEngineHealth(vehicle, 1000.0)
		end

		Wait(1000)
	end
end)

RegisterNetEvent('drugCargo:nextLocation', function(location)
	while currentCargo == nil do Wait(100) end

	currentLocation = location

	local marker = Config.Marker
	while currentLocation and not cargoRedzone do
		local wait = math.floor(1000)

		if #(GetEntityCoords(PlayerPedId()) - Config.Cargos[currentCargo].Locations[currentLocation]) < 40.0 and cargoDriver then
			wait = math.floor(0)

			DrawMarker(marker.type, Config.Cargos[currentCargo].Locations[currentLocation].x, Config.Cargos[currentCargo].Locations[currentLocation].y, Config.Cargos[currentCargo].Locations[currentLocation].z - 1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, marker.size.x, marker.size.y, marker.size.z, marker.color.r, marker.color.g, marker.color.b, math.floor(100), false, true, math.floor(2), false, false, false, false)

			if #(GetEntityCoords(PlayerPedId()) - Config.Cargos[currentCargo].Locations[currentLocation]) < 2.0 then
				ESX.ShowHelpNotification('Press ~INPUT_PICKUP~ to deliver Cargo')
				if IsControlJustReleased(math.floor(0), math.floor(38)) then
					TriggerServerEvent('drugCargo:deliverCargo', true)
					break
				end
			end
		end

		Wait(wait)
	end
end)

RegisterNetEvent('drugCargo:startRedzone', function(time)
	cargoRedzone = true
	createRedzoneBlip()
	Citizen.CreateThread(startInZoneCheck)
	Citizen.CreateThread(startRadiusColour)
	Citizen.CreateThread(startCargoSmoke)
	StartRedzone(time)
end)

RegisterNetEvent('drugCargo:stopRedzone', function()
	cargoRedzone = false

	if redzoneBlip ~= nil and DoesBlipExist(redzoneBlip) then
		RemoveBlip(redzoneBlip)
		redzoneBlip = nil
	end

	if currentBucketName == Config.EventBucket then
        exports['buckets']:changeBucket('default')
	end
end)

function InitScript()
	if Config.StartCargo.blip.show then
		createBlip()
	end

	Citizen.CreateThread(NpcDist)

    while true do
        local wait = math.floor(1000)

		if #(GetEntityCoords(PlayerPedId()) - Config.StartCargo.pos) < 15.0 then
			wait = math.floor(0)

			ESX.Game.Utils.DrawText3D(vector3(Config.StartCargo.pos.x, Config.StartCargo.pos.y, Config.StartCargo.pos.z + 1.2), 'Press [~g~E~w~] to Start Cargo', 1.2, math.floor(4))

			if #(GetEntityCoords(PlayerPedId()) - Config.StartCargo.pos) < 2.0 then
				
				if IsControlJustReleased(math.floor(0), math.floor(38)) then
					StartCargo()
				end
			end
		end

        Wait(wait)
    end
end

function StartCargo()
	local cargo
	local elements = {}
	for k,v in ipairs(Config.Cargos) do
		table.insert(elements, {label = 'Cargo Cost: <font color="green"> $'..v.Cost..'</font>', value = k})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cargo_select', {
		title    = 'Select Cargo',
		align    = 'bottom-right',
		elements = elements,
	},
	function(data, menu)
		cargo = data.current.value
		menu.close()
	end,
	function(data, menu)
		cargo = 'cancel'
		menu.close()
	end)
	while cargo == nil do Wait(100) end

	if cargo == 'cancel' then return end

	TriggerServerEvent('drugCargo:payCargo', cargo)
end

function startInZoneCheck()
    CreateThread(function()
        while cargoRedzone do
            local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.Cargos[currentCargo].Locations[currentLocation], true)
            if currentBucketName == "default" and dist < (Config.RedzoneRadius + 50.0) then
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
	
	local function inZone()
		while GlobalState.drugCargoCoords == nil do
			Wait(100);
		end
		if #(GetEntityCoords(PlayerPedId()) - GlobalState.drugCargoCoords) < Config.RedzoneRadius then
			return true;
		else
			return false;
		end
	end

	local coords = GetEntityCoords(PlayerPedId())
	local dist = GetDistanceBetweenCoords(coords, Config.Cargos[currentCargo].Locations[currentLocation], true)

	if currentBucketName == "default" then
		if dist < Config.RedzoneRadius then
			local cargoVeh
			if cargoDriver then
				cargoVeh = GetVehiclePedIsIn(PlayerPedId())
			end
			exports['buckets']:changeBucket(Config.EventBucket, cargoVeh)
		end
	end

    while cargoRedzone do
        local coords = GetEntityCoords(PlayerPedId())
        local dist = GetDistanceBetweenCoords(coords, Config.Cargos[currentCargo].Locations[currentLocation], true)

        if currentBucketName == "default" then
            if dist < Config.RedzoneRadius and dist > (Config.RedzoneRadius - 10.0) then
                if GetVehiclePedIsIn(PlayerPedId(), false) == math.floor(0) then
                    local _, weapon = GetCurrentPedWeapon(PlayerPedId(), false)
					if weapon ~= GetHashKey('WEAPON_UNARMED') then
                        exports['buckets']:changeBucket(Config.EventBucket)
                        ESX.ShowNotification('You entered the Cargo Redzone')
                    else
                        ESX.ShowNotification('You have to enter the area holding a weapon')
                    end
                    Wait(3000)
                else
                    ESX.ShowNotification('You have to enter the area without a vehicle')
                end
            end
        elseif currentBucketName == Config.EventBucket then
            if dist > Config.RedzoneRadius then
                exports['buckets']:changeBucket('default')
                Wait(3000)
            end
        end

        Wait(1000)
    end
end

function StartRedzone(time)
	local timeLeft = time or Config.RedzoneDuration

	local timeToEnd = GetGameTimer()+timeLeft*math.floor(1000)
	local timeTxt = ''

	while timeLeft > math.floor(0) and cargoRedzone do 
		timeLeft = math.floor((timeToEnd-GetGameTimer())/math.floor(1000))
		local hours = math.floor(timeLeft/math.floor(3600))
		local minutesLeft = timeLeft-hours*math.floor(3600)
		if hours > 0 then
			timeTxt = (('%02s:%02s:%02s'):format(hours,math.floor(minutesLeft/60), math.floor(minutesLeft%60)))
		else
			timeTxt = (('%02s:%02s'):format(math.floor(minutesLeft/60), math.floor(minutesLeft%60)))
		end

		if currentBucketName == Config.EventBucket then
			SendNUIMessage({action = "showTime",time = timeTxt})
		else
			SendNUIMessage({action = "hideTime"})
		end

		Wait(1000)
	end
	SendNUIMessage({action = "hideTime"})
end

function notifyCargoLocation()
	local coords = GlobalState.drugCargoCoords

	notifyCargoBlip = AddBlipForCoord(coords.x,coords.y,coords.z)
	SetBlipSprite(notifyCargoBlip , math.floor(67))
	SetBlipScale(notifyCargoBlip , 1.0)
	SetBlipColour(notifyCargoBlip, math.floor(1))

	notifyCargoRadarBlip = AddBlipForCoord(coords.x,coords.y,coords.z)
	SetBlipSprite(notifyCargoRadarBlip , math.floor(161))
	SetBlipScale(notifyCargoRadarBlip , 2.0)
	SetBlipColour(notifyCargoRadarBlip, math.floor(1))
	PulseBlip(notifyCargoRadarBlip)

	while GlobalState.drugCargoCoords do
		coords = GlobalState.drugCargoCoords

		if DoesBlipExist(notifyCargoBlip) and DoesBlipExist(notifyCargoRadarBlip) then
			SetBlipCoords(notifyCargoBlip, coords.x, coords.y, coords.z)
			SetBlipCoords(notifyCargoRadarBlip, coords.x, coords.y, coords.z)
		end

		Wait(1000)
	end
end

function createRedzoneBlip()
    redzoneBlip = AddBlipForRadius(Config.Cargos[currentCargo].Locations[currentLocation], Config.RedzoneRadius)

    SetBlipHighDetail(redzoneBlip, true)
    SetBlipAsShortRange(redzoneBlip, true)
    SetBlipDisplay(redzoneBlip, math.floor(4))
    SetBlipColour(redzoneBlip, math.floor(1))
    SetBlipAlpha(redzoneBlip, math.floor(150))
end

function CreateDestinationBlip()
	destinationCargoBlip = AddBlipForCoord(Config.Cargos[currentCargo].Locations[currentLocation].x, Config.Cargos[currentCargo].Locations[currentLocation].y, Config.Cargos[currentCargo].Locations[currentLocation].z)
	SetBlipSprite(destinationCargoBlip, math.floor(162))
	SetBlipColour(destinationCargoBlip, math.floor(1))
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Drug Cargo Destination')
	EndTextCommandSetBlipName(destinationCargoBlip)
end

function startRadiusColour()
    while cargoRedzone do
        if currentBucketName == Config.EventBucket then
            SetBlipColour(redzoneBlip, math.floor(5))
        else
            SetBlipColour(redzoneBlip, math.floor(1))
        end
        Wait(1000)
    end
end

function startCargoSmoke()
	RequestNamedPtfxAsset("core")
	while not HasNamedPtfxAssetLoaded("core") do
		Wait(1)
	end
	local smoke
	while cargoRedzone do
		if smoke then
			StopParticleFxLooped(smoke, 0)
			smoke = nil
		end

		if currentBucketName == Config.EventBucket then
			local shootCoords = GlobalState.drugCargoCoords + vector3(0.0, 0.0, 1.8)
			SetPtfxAssetNextCall("core")
			smoke = StartParticleFxLoopedAtCoord("exp_grd_flare", shootCoords.x, shootCoords.y, shootCoords.z, 0.0, 0.0, 0.0, 2.0, false, false, false, false)
			Wait(15000)
		end
		Wait(1000)
    end

	StopParticleFxLooped(smoke, 0)
end

function ResetCargo()
	currentCargo = nil

	if notifyCargoBlip ~= nil and DoesBlipExist(notifyCargoBlip) then
		RemoveBlip(notifyCargoBlip)
		notifyCargoBlip = nil
	end

	if notifyCargoRadarBlip ~= nil and DoesBlipExist(notifyCargoRadarBlip) then
		RemoveBlip(notifyCargoRadarBlip)
		notifyCargoRadarBlip = nil
	end

	if destinationCargoBlip ~= nil and DoesBlipExist(destinationCargoBlip) then
		RemoveBlip(destinationCargoBlip)
		destinationCargoBlip = nil
	end

	if redzoneBlip ~= nil and DoesBlipExist(redzoneBlip) then
		RemoveBlip(redzoneBlip)
		redzoneBlip = nil
	end

	cargoDriver = false
	currentLocation = nil
	cargoRedzone = false
end

function createBlip()
    local blip = AddBlipForCoord(Config.StartCargo.pos)
    SetBlipSprite(blip, Config.StartCargo.blip.id)
    SetBlipScale(blip, Config.StartCargo.blip.scale)
    SetBlipColour(blip, Config.StartCargo.blip.color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.StartCargo.blip.name)
    EndTextCommandSetBlipName(blip)
end

function NpcDist()
	local npc
	while true do
		if #(GetEntityCoords(PlayerPedId()) - Config.StartCargo.pos) < 60.0 then
			if not npc then
				npc = createNpc()
			end
		else
			if DoesEntityExist(npc) then
				DeleteEntity(npc)
			end
			npc = nil
		end

		Wait(2000)
	end
end

function createNpc()
    RequestModel(Config.StartCargo.model)
        
    while not HasModelLoaded(Config.StartCargo.model) do
        Wait(10)
    end

    RequestAnimDict('mini@strip_club@idles@bouncer@base')

    while not HasAnimDictLoaded('mini@strip_club@idles@bouncer@base') do
        Wait(10)
    end
    
    local npc = CreatePed(5, Config.StartCargo.model, Config.StartCargo.pos.x, Config.StartCargo.pos.y, Config.StartCargo.pos.z - math.floor(1), Config.StartCargo.heading, false, true)
	SetPedDefaultComponentVariation(npc)
    SetEntityHeading(npc, Config.StartCargo.heading)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    
	TaskStartScenarioInPlace(npc, 'WORLD_HUMAN_SMOKING', 0, true)
    --TaskPlayAnim(npc, 'mini@strip_club@idles@bouncer@base', 'base', 8.0, 0.0, math.floor(-1), math.floor(1), math.floor(0), math.floor(0), math.floor(0), math.floor(0))
    
    SetModelAsNoLongerNeeded(Config.StartCargo.model)

	return npc
end

AddEventHandler('onResourceStop',function(resource)
    if resource == GetCurrentResourceName() then
		ResetCargo()
    end
end)

exports('IsOnDrugCargo', function()
	return currentBucketName == Config.EventBucket and cargoRedzone
end)