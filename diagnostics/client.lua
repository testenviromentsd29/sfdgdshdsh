local weapons = {}

Citizen.CreateThread(function()
	local ESX = nil
	
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	for k,v in pairs(ESX.GetWeaponList()) do
		weapons[GetHashKey(v.name)] = v.name
	end
	
	weapons[-1569615261] = 'WEAPON_UNARMED'
	
	ESX = nil
	
	math.randomseed(GetGameTimer())
	Wait(math.random(3000, 5000))
	
	local forceUpdate = false
	local nextUpdate = GetGameTimer() + 5000
	local lastCoords = vector3(0.0, 0.0, 0.0)
	
	local playerPed = nil
	local coords = nil
	local coordsTxt = nil
	local weaponHash = nil
	local weaponName = nil
	local vehicle = nil
	local vehicleName = nil
	local speed = nil
	
	while true do
		playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
		coordsTxt = ('vector3(%.2f, %.2f, %.2f)'):format(coords.x, coords.y, coords.z)
		
		weaponHash = GetSelectedPedWeapon(playerPed)
		weaponName = weapons[weaponHash] or weaponHash
		vehicle = GetVehiclePedIsIn(playerPed)
		vehicleName = 'No vehicle'
		
		if DoesEntityExist(vehicle) then
			vehicleName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
			speed = ('%.2f'):format(GetEntitySpeed(vehicle))
		else
			speed = ('%.2f'):format(GetEntitySpeed(playerPed))
		end
		
		if #(coords - lastCoords) > 75.0 then
			nextUpdate = 0
		end
		
		if nextUpdate < GetGameTimer() then
			nextUpdate = GetGameTimer() + 5000
			TriggerServerEvent('diagnostics:update', coords, coordsTxt, weaponName, vehicleName, speed)
			Wait(1000)
		end
		
		lastCoords = coords
		
		Wait(100)
	end
end)