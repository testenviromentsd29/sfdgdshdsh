------ JUST FUNCTIONS -------


---- FUEL USAGE
fuelSynced = false
function ManageFuelUsage(vehicle)
    if not DecorExistOn(vehicle, Config.FuelDecor) then
		SetFuel(vehicle, math.random(200, 800) / 10)
	elseif not fuelSynced then
		SetFuel(vehicle, GetFuel(vehicle))

		fuelSynced = true
	end

	if IsVehicleEngineOn(vehicle) then
		SetFuel(vehicle,GetVehicleFuelLevel(vehicle) - Config.FuelUsage[ESX.Math.Round(GetVehicleCurrentRpm(vehicle),1)] * (Config.Classes[GetVehicleClass(vehicle)] or 1.0) / 10)
	end
end

exports('GetFuel',function(vehicle) GetFuel(vehicle) end)
exports('SetFuel',function(vehicle,fuel) SetFuel(vehicle,fuel) end)

function GetFuel(vehicle)
	return DecorGetFloat(vehicle, Config.FuelDecor)
end

function SetFuel(vehicle, fuel)
	if fuel and fuel >= 0 then
        if fuel > 100 then
            fuel = 100
        end
		SetVehicleFuelLevel(vehicle, fuel + 0.0)
		DecorSetFloat(vehicle, Config.FuelDecor, GetVehicleFuelLevel(vehicle))
	end
end

------ BLIPS
function CreateBlips()
    for _, station in pairs(Config.GasStations) do
        CreateBlip(station.coords)
    end
end

function CreateBlip(coords)
	local blip = AddBlipForCoord(coords)

	SetBlipSprite(blip, 361)
	SetBlipScale(blip, 0.6)
	SetBlipColour(blip, 1)
	SetBlipDisplay(blip, 8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Gas Station")
	EndTextCommandSetBlipName(blip)

	return blip
end

function FindNearestFuelPump(coords)
	local fuelPumps = {}
	local handle, object = FindFirstObject()
	local success

	repeat
		if Config.PumpModels[GetEntityModel(object)] then
			table.insert(fuelPumps, object)
		end

		success, object = FindNextObject(handle, object)
	until not success

	EndFindObject(handle)

	local pumpObject = 0
	local pumpDistance = 1000

	for _, fuelPumpObject in pairs(fuelPumps) do
		local dstcheck = GetDistanceBetweenCoords(coords, GetEntityCoords(fuelPumpObject))

		if dstcheck < pumpDistance then
			pumpDistance = dstcheck
			pumpObject = fuelPumpObject
		end
	end

	return pumpObject, pumpDistance
end

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)

	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end


---- UI Menu functions -------
MenuOpen = false

function OpenMenu(vehicle,dontRemoveInput)
    local data = {}
    if vehicle then
        data.inVehicle = true
        data.vehicleFuelMissing = ESX.Math.Round(100.0 - GetFuel(vehicle))
    else
        data.inVehicle = false
    end
	
	local gasPricePerLiter = Config.DefaultGasPricePerLiter
	local subscription = ESX.GetPlayerData().subscription or ''
	
	if subscription == "level1" or subscription == "level3" or subscription == "level4" then
		gasPricePerLiter = gasPricePerLiter/2
	end
	
    data.fuelPricePerLiter = gasPricePerLiter
    data.repairKitPrice = Config.DefaultRepairKitPrice
    data.gasCanisterPrice = Config.DefaultGasCanisterPrice
    data.owner = Config.DefaultOwnerName
    data.name = Config.DefaultGasStationName
    data.controlled = Config.DefaultControlledByText
	data.dontRemoveInput = dontRemoveInput

	if currentGasStation then
		local station = GasStations[currentGasStation]
		if station.name then
			data.name = station.name
		end
		if station.data then
			if station.data.owner then
				data.owner = station.data.owner
			end
			if station.data.prices then
				data.fuelPricePerLiter = station.data.prices['gasoline'] or gasPricePerLiter
				data.repairKitPrice = station.data.prices['repair-kit'] or Config.DefaultRepairKitPrice
				data.gasCanisterPrice = station.data.prices['canister'] or Config.DefaultGasCanisterPrice
			end
			if station.data.controlled then
				data.owner = station.data.controlled
			end
		end
	end

	if currentGasStation and ESX.PlayerData.job.name == currentGasStation and ESX.PlayerData.job.grade_name == 'boss' then
		data.showOwnerPanel = true
		data.fuelQuantity = GasStations[currentGasStation].quantity
		data.fuelMaxCapacity = Config.GasStationFuelCapacity
	end

	SendNUIMessage({
		action = "show",
        data = data
	})
	SetNuiFocus(true,true)
	MenuOpen = true
end

function CloseMenu()
	SendNUIMessage({
		action = "onCloseMenu"
	})
	SetNuiFocus(false,false)
	MenuOpen = false
end

function PlaceOrder(order)
    order.gasoline = math.ceil(tonumber(order.gasoline))
    if not order.gasoline or order.gasoline < 0 then
        order.gasoline = 0
    end
    order.repairkits = math.ceil(tonumber(order.repairkits))
    if not order.repairkits or order.repairkits < 0 then
        order.repairkits = 0
    end
    order.gascanister = math.ceil(tonumber(order.gascanister))
    if not order.gascanister or order.gascanister < 0 then
        order.gascanister = 0
    end
    TriggerServerEvent("gas_station:placeOrder",order,currentGasStation)
end

-- Fuel from petrol can
local isFueling = false
function FuelFromPetrolCan(vehicle)
	local ped = PlayerPedId()
	TaskTurnPedToFaceEntity(ped, vehicle, 1000)
	Citizen.Wait(1000)
	SetCurrentPedWeapon(ped, 883325847, true)
	LoadAnimDict("timetable@gardener@filling_can")
	TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
	
	local startingFuel = GetFuel(vehicle)
	isFueling = true
	while isFueling do
		for _, controlIndex in pairs(Config.DisableKeys) do
			DisableControlAction(0, controlIndex)
		end

		local vehicleCoords = GetEntityCoords(vehicle)

		local currentFuel = GetVehicleFuelLevel(vehicle)
		DrawText3Ds(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z + 0.5, "Press ~g~[E]~w~ to stop\nGas can: ~g~" .. ESX.Round(GetAmmoInPedWeapon(ped, 883325847) / 4500 * 100, 1) .. "% | Vehicle: " .. ESX.Round(currentFuel, 1) .. "%")

		local fuelToAdd = math.random(1,2) / 100.0

		local ammoCount = GetAmmoInPedWeapon(ped, 883325847)
		if ammoCount - fuelToAdd * 100 >= 0 then
			currentFuel = currentFuel + fuelToAdd
			SetPedAmmo(ped, 883325847, math.floor(GetAmmoInPedWeapon(ped, 883325847) - fuelToAdd * 100))
		else
			isFueling = false
		end


		if currentFuel > 100.0 then
			currentFuel = 100.0
			isFueling = false
		end

		SetFuel(vehicle,currentFuel)

		if not IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
			TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
		end

		if IsControlJustReleased(0, 38) or DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) then
			isFueling = false
		end

		Wait(0)
	end

	local ammoCount = GetAmmoInPedWeapon(PlayerPedId(), 883325847)
	TriggerServerEvent('esx:updateWeaponAmmo', "WEAPON_PETROLCAN", ammoCount)

	ClearPedTasks(ped)
	RemoveAnimDict("timetable@gardener@filling_can")
end

function LoadAnimDict(dict)
	if not HasAnimDictLoaded(dict) then
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(10)
		end
	end
end