ESX = nil
local PlayerData = nil
local destinationBlip
local destinationBlipRadius
local notifyBoatBlip
local notifyBoatRadarBlip
local showCargoInfo = false
local cargoDriver = false
local showing = false;
local showing2 = false;
local gPhase = 0;

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

AddEventHandler('playerSpawned', function()
    Wait(1000)
    SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey("PLAYER"))
end)

RegisterNetEvent('cargo:resetCargo', function()
	ResetCargo()
end)

RegisterNetEvent('cargo:processCargo', function(cargo, phase, time)
	while GlobalState.boatCargoCoords == nil do 
		Wait(100) 
	end
	gPhase = phase;

	if phase == math.floor(1) or time ~= nil then
		Citizen.CreateThread(function()
			ChangeBoatOwner(cargo)
		end)
		Citizen.CreateThread(CheckCargoDistance)
	end

	ProcessCargo(cargo, phase, time)
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

	local answer
	ESX.TriggerServerCallback('cargo:payCargo', function(cb)
		answer = cb
	end, cargo)
	while answer == nil do Wait(100) end

	if not answer then
		return
	end

	spawnBoatGuards(cargo)
end

function ProcessCargo(cargo, phase, time)
	if phase == math.floor(1) then
		while GlobalState.boatCargoGuards == nil do 
			Wait(100) 
		end

		local timeLeft = time or Config.Cargos[cargo].TimeToKillGuards

		local timeToEnd = GetGameTimer()+timeLeft*math.floor(1000)
		local timeTxt = ''

		while timeLeft > math.floor(0) and (GlobalState.boatCargoGuards or 0) > math.floor(0) do
			timeLeft = math.floor((timeToEnd-GetGameTimer())/math.floor(1000))
			local hours = math.floor(timeLeft/math.floor(3600))
			local minutesLeft = timeLeft-hours*math.floor(3600)
			if hours > 0 then
				timeTxt = (('%02s:%02s:%02s'):format(hours,math.floor(minutesLeft/60), math.floor(minutesLeft%60)))
			else
				timeTxt = (('%02s:%02s'):format(math.floor(minutesLeft/60), math.floor(minutesLeft%60)))
			end

			if showCargoInfo then
				SendNUIMessage({action = "showTime",time = timeTxt.." <br>Press TAB to open scoreboard!"})
				SendNUIMessage({action = "showGuards",guards = GlobalState.boatCargoGuards})
			else
				--SendNUIMessage({action = "hideTime"})
				SendNUIMessage({action = "hideGuards"})
			end

			Wait(1000)
		end
		SendNUIMessage({action = "hideTime"})
		SendNUIMessage({action = "hideGuards"})
	else
		createDestinationBlip(cargo)

		Citizen.CreateThread(notifyBoatLocation)

		local marker = Config.Cargos[cargo].Destination.marker
		while GlobalState.boatCargoCoords do
			local wait = math.floor(1000)

			if #(GetEntityCoords(PlayerPedId()) - Config.Cargos[cargo].Destination.pos) < 40.0 and cargoDriver then
				wait = math.floor(0)

				DrawMarker(marker.type, Config.Cargos[cargo].Destination.pos.x, Config.Cargos[cargo].Destination.pos.y, Config.Cargos[cargo].Destination.pos.z - 10.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, marker.size.x, marker.size.y, marker.size.z, marker.color.r, marker.color.g, marker.color.b, math.floor(100), false, true, math.floor(2), false, false, false, false)

				if #(GetEntityCoords(PlayerPedId()) - Config.Cargos[cargo].Destination.pos) < 6.0 then
					ESX.ShowHelpNotification('Press ~INPUT_PICKUP~ to deliver Cargo')
					if IsControlJustReleased(math.floor(0), math.floor(38)) then
						TriggerServerEvent('cargo:endCargo', true)
						break
					end
				end
			end

			Wait(wait)
		end
	end
end

function ChangeBoatOwner(cargo)
	while GlobalState.boatCargoCoords do
		local vehicle = GetVehiclePedIsIn(PlayerPedId())

		if showCargoInfo and vehicle and (GetPedInVehicleSeat(vehicle, math.floor(-1)) == PlayerPedId()) and (GetVehicleNumberPlateText(vehicle) == Config.BoatSpawn.plate) then
			print('IS CARGO DRIVER')
			if not cargoDriver then
				cargoDriver = true
				SetBlipRoute(destinationBlip, true)
				SetNewWaypoint(Config.Cargos[cargo].Destination.pos.x, Config.Cargos[cargo].Destination.pos.y)
				print('SET WAYPOINT DESTINATION')
			end
		else
			if cargoDriver then
				cargoDriver = false
				SetBlipRoute(destinationBlip, false)
				SetWaypointOff()
			end
		end

		if cargoDriver then
			SetVehicleEngineHealth(vehicle, 1000.0)
		end
		Wait(2000)
	end

	print('CHANGE BOAT OWNER FINISHED')
end

function CheckCargoDistance()
	while GlobalState.boatCargoCoords do
		if #(GetEntityCoords(PlayerPedId()) - GlobalState.boatCargoCoords) < 100 then
			showCargoInfo = true
		else
			showCargoInfo = false
		end
		Wait(1000)
	end
end

function spawnBoatGuards(cargo)
	local cargoboat
	ESX.Game.SpawnVehicle(Config.BoatSpawn.model, Config.BoatSpawn.pos, Config.BoatSpawn.heading, function(vehicle)
		SetEntityInvincible(vehicle, true)
		SetVehicleNumberPlateText(vehicle, Config.BoatSpawn.plate)
		cargoboat = vehicle
	end)

	while cargoboat == nil do Wait(100) end

	Wait(2000)

	local guards = {}
	RequestModel(Config.Cargos[cargo].BoatGuards.model)
        
    while not HasModelLoaded(Config.Cargos[cargo].BoatGuards.model) do
        Wait(10)
    end

	AddRelationshipGroup('boatguard')
	SetRelationshipBetweenGroups(math.floor(0), GetHashKey("boatguard"), GetHashKey("boatguard"))
	SetRelationshipBetweenGroups(math.floor(5), GetHashKey("PLAYER"), GetHashKey("boatguard"))
	SetRelationshipBetweenGroups(math.floor(5), GetHashKey("boatguard"), GetHashKey("PLAYER"))

	for k,v in pairs(Config.Cargos[cargo].BoatGuards.positions) do
		local boatguardped = CreatePed(math.floor(1), Config.Cargos[cargo].BoatGuards.model, v.pos.x, v.pos.y, v.pos.z + 1.0, v.heading, true, true)
		while not DoesEntityExist(boatguardped) do Wait(100) end

		SetPedSuffersCriticalHits(boatguardped, false)
		SetEntityMaxHealth(boatguardped, math.floor(200))
		SetEntityHealth(boatguardped, math.floor(200))
		SetPedArmour(boatguardped, math.floor(0))     
		SetPedAsEnemy(boatguardped, true)
		SetCanAttackFriendly(boatguardped, false, true)
		SetPedCombatMovement(boatguardped, math.floor(2))
		SetPedCombatRange(boatguardped, math.floor(2))
		SetPedCombatAttributes(boatguardped, math.floor(5000), math.floor(1))
		SetPedCombatAttributes(boatguardped, math.floor(46), math.floor(1))
		SetPedRelationshipGroupHash(boatguardped, 'boatguard')
		GiveWeaponToPed(boatguardped, GetHashKey('WEAPON_CARBINERIFLE'), math.floor(9999), false, true)
		SetPedDropsWeaponsWhenDead(boatguardped, false)
		SetPedRandomComponentVariation(boatguardped, true)
		SetPedSeeingRange(boatguardped, 300.0)
		SetPedHearingRange(boatguardped, 300.0)
		SetPedAlertness(boatguardped, math.floor(3))
		TaskCombatHatedTargetsAroundPed(boatguardped, 120.0, math.floor(0))
		SetPedKeepTask(boatguardped, true)
		SetPedAccuracy(boatguardped, math.floor(math.random(30,80)))
		NetworkRegisterEntityAsNetworked(boatguardped)
		SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(boatguardped), true)
		table.insert(guards, NetworkGetNetworkIdFromEntity(boatguardped))
		Wait(100)
	end

	TriggerServerEvent('cargo:sendBoatGuards', NetworkGetNetworkIdFromEntity(cargoboat), guards)
end

function createDestinationBlip(cargo)
    destinationBlip = AddBlipForCoord(Config.Cargos[cargo].Destination.pos)
    SetBlipSprite(destinationBlip, Config.Cargos[cargo].Destination.blip.id)
    SetBlipScale(destinationBlip, Config.Cargos[cargo].Destination.blip.scale)
    SetBlipColour(destinationBlip, Config.Cargos[cargo].Destination.blip.color)
    SetBlipAsShortRange(destinationBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.StartCargo.blip.name)
    EndTextCommandSetBlipName(destinationBlip)

	destinationBlipRadius = AddBlipForRadius(Config.Cargos[cargo].Destination.pos, 200.0)
    SetBlipHighDetail(destinationBlipRadius, true)
    SetBlipAsShortRange(destinationBlipRadius, true)
    SetBlipDisplay(destinationBlipRadius, math.floor(4))
    SetBlipColour(destinationBlipRadius, math.floor(1))
    SetBlipAlpha(destinationBlipRadius, math.floor(150))
end

function notifyBoatLocation()
	local coords = GlobalState.boatCargoCoords

	notifyBoatBlip = AddBlipForCoord(coords.x,coords.y,coords.z)
	SetBlipSprite(notifyBoatBlip , math.floor(427))
	SetBlipScale(notifyBoatBlip , 1.0)
	SetBlipColour(notifyBoatBlip, math.floor(1))

	notifyBoatRadarBlip = AddBlipForCoord(coords.x,coords.y,coords.z)
	SetBlipSprite(notifyBoatRadarBlip , math.floor(161))
	SetBlipScale(notifyBoatRadarBlip , 2.0)
	SetBlipColour(notifyBoatRadarBlip, math.floor(1))
	PulseBlip(notifyBoatRadarBlip)

	while GlobalState.boatCargoCoords do
		coords = GlobalState.boatCargoCoords

		if DoesBlipExist(notifyBoatBlip) and DoesBlipExist(notifyBoatRadarBlip) then
			SetBlipCoords(notifyBoatBlip, coords.x, coords.y, coords.z)
			SetBlipCoords(notifyBoatRadarBlip, coords.x, coords.y, coords.z)
		end

		Wait(1000)
	end
end

function ResetCargo()
	if destinationBlip ~= nil and DoesBlipExist(destinationBlip) then
		RemoveBlip(destinationBlip)
		destinationBlip = nil
	end

	if destinationBlipRadius ~= nil and DoesBlipExist(destinationBlipRadius) then
		RemoveBlip(destinationBlipRadius)
		destinationBlipRadius = nil
	end

	if notifyBoatBlip ~= nil and DoesBlipExist(notifyBoatBlip) then
		RemoveBlip(notifyBoatBlip)
		notifyBoatBlip = nil
	end

	if notifyBoatRadarBlip ~= nil and DoesBlipExist(notifyBoatRadarBlip) then
		RemoveBlip(notifyBoatRadarBlip)
		notifyBoatRadarBlip = nil
	end

	showing = false;
	showing2 = false;
	cargoDriver = false
	showCargoInfo = false
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

function DrawText2(x, y, scale, text)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(scale, scale)
	SetTextDropshadow(math.floor(1), math.floor(0), math.floor(0), math.floor(0), math.floor(255))
	SetTextEdge(math.floor(1), math.floor(0), math.floor(0), math.floor(0), math.floor(255))
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry('STRING')
	AddTextComponentString(text)
	DrawText(x, y)
end

AddEventHandler('onResourceStop',function(resource)
    if resource == GetCurrentResourceName() then
		ResetCargo()
    end
end)

inOnBoatCargo = function()
	if GlobalState.boatCargoCoords then
		local coords = GetEntityCoords(PlayerPedId())
		return #(vector2(coords.x, coords.y) - vector2(GlobalState.boatCargoCoords.x, GlobalState.boatCargoCoords.y)) < 200
	else
		return false
	end
end

exports('IsOnBoatCargo', function()
	if GlobalState.boatCargoCoords then
		local coords = GetEntityCoords(PlayerPedId())
		return #(vector2(coords.x, coords.y) - vector2(GlobalState.boatCargoCoords.x, GlobalState.boatCargoCoords.y)) < 200
	else
		return false
	end
end)