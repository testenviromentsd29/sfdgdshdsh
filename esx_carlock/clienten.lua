ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local vehicleToJack
local myVehicles = {}
local canRobIndeed = false

RegisterNetEvent('esx_carlock:sendClientAllVehicles')
AddEventHandler('esx_carlock:sendClientAllVehicles',function(plates)
	myVehicles = plates or {}
end)

RegisterNetEvent('esx_carlock:addCar')
AddEventHandler('esx_carlock:addCar',function(plate)
	myVehicles[plate] = true
end)

RegisterNetEvent('esx_carlock:removeCar')
AddEventHandler('esx_carlock:removeCar',function(plate)
	if myVehicles[plate] then
		myVehicles[plate] = nil
	end
end)

Citizen.CreateThread(function()
	local dict = "anim@mp_player_intmenu@key_fob@"
	RequestAnimDict(dict)
	
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(0)
		
		if (IsControlJustPressed(1, 303)) then
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local hasAlreadyLocked = false
			local vehsInarea = ESX.Game.GetVehiclesInArea(coords,20)
			local vehToLock
			local found = false
			local dist = 999999999
			
			for k,v in pairs(vehsInarea) do
				local plate = ESX.Math.Trim(GetVehicleNumberPlateText(v))
				
				for x,y in pairs(myVehicles) do
					if x == plate then
						vehToLock = v
						local vehCoords = GetEntityCoords(vehToLock)
						
						if Vdist(vehCoords.x, vehCoords.y, vehCoords.z, coords.x, coords.y, coords.z) < dist then
							dist = Vdist(vehCoords.x, vehCoords.y, vehCoords.z, coords.x, coords.y, coords.z)
							vehToLock = v
						end
						
						found = true
					end
				end
			end
			
			if vehToLock then
				local coordscar = GetEntityCoords(vehToLock)
				local distance = Vdist(coordscar.x, coordscar.y, coordscar.z, coords.x, coords.y, coords.z)
				
				if distance < 10 then
					if found and hasAlreadyLocked ~= true then
						local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehToLock))
						vehicleLabel = GetLabelText(vehicleLabel)
						local lock = GetVehicleDoorLockStatus(vehToLock)
						
						if lock == 1 or lock == 0 then
							SetVehicleDoorShut(vehToLock, 0, false)
							SetVehicleDoorShut(vehToLock, 1, false)
							SetVehicleDoorShut(vehToLock, 2, false)
							SetVehicleDoorShut(vehToLock, 3, false)
							SetVehicleDoorsLocked(vehToLock, 2)
							PlayVehicleDoorCloseSound(vehToLock, 1)
							ESX.ShowNotification('Κλείδωσες το όχημά σου!')
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							SetVehicleLights(vehToLock, 2)
							Citizen.Wait(150)
							SetVehicleLights(vehToLock, 0)
							Citizen.Wait(150)
							SetVehicleLights(vehToLock, 2)
							Citizen.Wait(150)
							SetVehicleLights(vehToLock, 0)
							hasAlreadyLocked = true

							TriggerServerEvent('vehicleDeleter:refreshVehicle', GetVehicleNumberPlateText(vehToLock), false)
						elseif lock == 2 then
							SetVehicleDoorsLocked(vehToLock, 1)
							PlayVehicleDoorOpenSound(vehToLock, 0)
							ESX.ShowNotification('Ξεκλείδωσες το όχημά σου!')
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							SetVehicleLights(vehToLock, 2)
							Citizen.Wait(150)
							SetVehicleLights(vehToLock, 0)
							Citizen.Wait(150)
							SetVehicleLights(vehToLock, 2)
							Citizen.Wait(150)
							SetVehicleLights(vehToLock, 0)
							FreezeEntityPosition(vehToLock, false)
							hasAlreadyLocked = true

							TriggerServerEvent('vehicleDeleter:refreshVehicle', GetVehicleNumberPlateText(vehToLock), false)
						end
					else
						ESX.ShowNotification("No vehicles to lock nearby.")
					end
				end
			end
		end
	end
end)

function loaddict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end