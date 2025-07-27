ESX = nil

local activeCam = nil
local previewVehicle = nil
local testDriveVehicle = nil
local allVehicles = nil
local angleY = 0.0
local angleZ = 0.0
local zoomCd = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	InitScript()
end)

RegisterNetEvent('esx_cardealer:sendAllVehicles')
AddEventHandler('esx_cardealer:sendAllVehicles', function(data)
	allVehicles = data
end)

RegisterNetEvent('esx_cardealer:spawnVehicle')
AddEventHandler('esx_cardealer:spawnVehicle', function(dealer, name, vehicleProps)
	local coords = Config.Dealers[dealer].vehicle_spawn_point
	local heading = Config.Dealers[dealer].vehicle_spawn_heading

	ESX.Game.SpawnVehicle(name, coords, heading, function(vehicle)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
		TriggerServerEvent('betrayed_garage:takeout', vehicleProps['plate'], NetworkGetNetworkIdFromEntity(vehicle))
	end)
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if DoesEntityExist(testDriveVehicle) then
			DeleteEntity(testDriveVehicle)
		end

		if DoesEntityExist(previewVehicle) then
			DeleteEntity(previewVehicle)
		end

		if activeCam then
			ClearFocus()
			RenderScriptCams(false, false, 0, 1, 0)
			DestroyCam(activeCam, false)
		end
	end
end)

function InitScript()
	for k,v in pairs(Config.Dealers) do
		if v.have_blip then
			local blip = AddBlipForCoord(v.view_catalog_coords)

			SetBlipSprite(blip, v.blip.sprite)
			SetBlipScale(blip, v.blip.scale)
			SetBlipColour(blip, v.blip.color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString(v.label)
			EndTextCommandSetBlipName(blip)
		end
	end

	Citizen.CreateThread(function()
		while true do
			local wait = 1500
			local coords = GetEntityCoords(PlayerPedId())

			for k,v in pairs(Config.Dealers) do
				if #(coords - v.view_catalog_coords) < 25.0 then
					wait = 0
					exports['textui']:Draw3DUI('E', v.label, v.view_catalog_coords, 25.0)
					
					if #(coords - v.view_catalog_coords) < 1.5 then
						ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to view the catalog')

						if IsControlJustReleased(0, 38) then
							OpenCatalog(k)
						end
					end
				end
			end

			Wait(wait)
		end
	end)
end

function OpenCatalog(id)
	if allVehicles == nil then
		ESX.ShowNotification('Please wait...')
		return
	end

	local discount = 0
	local pData = ESX.GetPlayerData()

	if pData.job.name == Config.Dealers[id].job.setjob then
		discount = Config.Dealers[id].job.percentCheaperIfIHaveTheJob
	elseif string.find((pData.subscription or ''), 'level') then
		discount = Config.VipDiscount
	end

	local camData = Config.Dealers[id].camera

	activeCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
	SetCamCoord(activeCam, camData.camera_coords.x, camData.camera_coords.y, camData.camera_coords.z)
	SetCamRot(activeCam, camData.camRotation.RX, camData.camRotation.RY, camData.camRotation.RZ)
	RenderScriptCams(true, false, 0, 1, 0)
	SetFocusArea(camData.camera_coords.x, camData.camera_coords.y, camData.camera_coords.z, 0.0, 0.0, 0.0)

	SetNuiFocus(true, true)
	SendNUIMessage({action = 'show', dealer = id, discount = discount, colors = Config.Colors, vehicles = GenerateList(id)})
end

RegisterNUICallback('rotate', function(data)
	local whereTo = data.direction
	local angleY = angleY

	if whereTo == 'left' then
		SetEntityHeading(previewVehicle, GetEntityHeading(previewVehicle) + 1.0)
	elseif whereTo == 'right' then
		SetEntityHeading(previewVehicle, GetEntityHeading(previewVehicle) - 1.0)
	end
end)

RegisterNUICallback('zoom', function(data)
	if zoomCd then
		return
	end

	zoomCd = true

	if DoesCamExist(activeCam) then
		local fov = GetCamFov(activeCam)
		
		if data.zoom then
			fov = fov - 2.0
			
			if fov < 20.0 then
				fov = 20.0
			end
		else
			fov = fov + 2.0
			
			if fov > 70.0 then
				fov = 70.0
			end
		end
		
		SetCamFov(activeCam, fov)
	end

	zoomCd = false
end)

RegisterNUICallback('preview', function(data, cb)
	local coords = Config.Dealers[data.dealer].vehicle_preview_point
	local heading = Config.Dealers[data.dealer].vehicle_preview_heading

	if DoesEntityExist(previewVehicle) then
		DeleteEntity(previewVehicle)
	end

	ESX.Game.SpawnLocalVehicle(data.name, coords, heading, function(vehicle)
		FreezeEntityPosition(vehicle, true)
		previewVehicle = vehicle

		--[[if DoesCamExist(activeCam) then
			PointCamAtEntity(activeCam, previewVehicle, 0.0, 0.0, 0.0, true)
		end]]

		local maxSpeed = math.floor(GetVehicleEstimatedMaxSpeed(previewVehicle) * 3.6) * 1.2
		local fuelCapacity = GetVehicleHandlingFloat(previewVehicle, 'CHandlingData', 'fPetrolTankVolume')
		local modCount = getTotalModCount(previewVehicle)
		local seats = GetVehicleMaxNumberOfPassengers(previewVehicle) + 1

		local maxSpeedPercentage = (maxSpeed / maxSpeed) * 100
		local fuelCapacityPercentage = (fuelCapacity / 100) * 100
		local modCountPercentage = (modCount / 250) * 100
		local seatsPercentage = (seats / seats) * 100

		local stats = {
			{label = 'Max Speed', value = math.ceil(maxSpeed), percentage = maxSpeedPercentage},
			{label = 'Fuel Capacity', value = fuelCapacity, percentage = fuelCapacityPercentage},
			{label = 'Mod Count', value = modCount, percentage = modCountPercentage},
			{label = 'Seats', value = seats, percentage = seatsPercentage}
		}

		cb(stats)
	end)
end)

RegisterNUICallback('color', function(data, cb)
	if DoesEntityExist(previewVehicle) then
		SetVehicleColours(previewVehicle, Config.Colors[data.color].id, Config.Colors[data.color].id)
	end
end)

RegisterNUICallback('buy', function(data)
	local vehicleProps = ESX.Game.GetVehicleProperties(previewVehicle)

	if DoesEntityExist(previewVehicle) then
		DeleteEntity(previewVehicle)
	end

	ClearFocus()
	RenderScriptCams(false, false, 0, 1, 0)
	DestroyCam(activeCam, false)
	
	activeCam = nil

	SetNuiFocus(false, false)
	TriggerServerEvent('esx_cardealer:buyVehicle', data.dealer, data.name, vehicleProps)
end)

RegisterNUICallback('test_drive', function(data, cb)
	SetNuiFocus(false, false)

	local testDrive = Config.Dealers[data.dealer].TestDrive or Config.TestDrive

	local lastCoords = GetEntityCoords(PlayerPedId())
	SetEntityCoords(PlayerPedId(), testDrive.coords)

	if DoesEntityExist(testDriveVehicle) then
		DeleteEntity(testDriveVehicle)
	end

	ClearFocus()
	RenderScriptCams(false, false, 0, 1, 0)

	local timerEnd = GetGameTimer() + testDrive.seconds*1000

	ESX.Game.SpawnLocalVehicle(data.name, testDrive.coords, testDrive.heading, function(vehicle)
		testDriveVehicle = vehicle
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

		Wait(1000)

		while timerEnd > GetGameTimer() do
			if not DoesEntityExist(vehicle) then
				break
			end

			if GetVehiclePedIsIn(PlayerPedId(), false) ~= vehicle then
				break
			end

			if #(GetEntityCoords(vehicle) - testDrive.coords) > testDrive.range then
				SetEntityCoords(vehicle, testDrive.coords)
				SetEntityHeading(vehicle, testDrive.heading)
			end

			DisableControlAction(0, 45, 0)
			DisableControlAction(0, 75, 0)	--INPUT_VEH_EXIT

			DisableControlAction(0, 24, true)	--INPUT_ATTACK
			DisableControlAction(0, 25, true)	--INPUT_AIM
			DisableControlAction(0, 69, true)	--INPUT_VEH_ATTACK
			DisableControlAction(0, 70, true)	--INPUT_VEH_ATTACK2
			DisableControlAction(0, 92, true)	--INPUT_VEH_PASSENGER_ATTACK
			DisableControlAction(0, 114, true)	--INPUT_VEH_FLY_ATTACK
			DisableControlAction(0, 140, true)	--INPUT_MELEE_ATTACK_LIGHT
			DisableControlAction(0, 141, true)	--INPUT_MELEE_ATTACK_HEAVY
			DisableControlAction(0, 142, true)	--INPUT_MELEE_ATTACK_ALTERNATE
			DisableControlAction(0, 257, true)	--INPUT_ATTACK2
			DisableControlAction(0, 263, true)	--INPUT_MELEE_ATTACK1
			DisableControlAction(0, 264, true)	--INPUT_MELEE_ATTACK2
			DisableControlAction(0, 331, true)	--INPUT_VEH_FLY_ATTACK2
			DisableControlAction(0, 346, true)	--INPUT_VEH_MELEE_LEFT
			DisableControlAction(0, 347, true)	--INPUT_VEH_MELEE_RIGHT
			
			DisablePlayerFiring(PlayerId(), true)

			if IsDisabledControlJustReleased(0, 75) then
				break
			end

			if IsDisabledControlJustReleased(0, 47) then
				exports['lls-mechanic'].openMenuByAdmin()
			end

			DrawText2(0.45, 0.85, 0.7, 'Press F to stop test drive\nPress G to upgrade')
			
			Wait(0)
		end

		if DoesEntityExist(vehicle) then
			DeleteEntity(vehicle)
		end

		SetEntityCoords(PlayerPedId(), lastCoords)

		RenderScriptCams(true, false, 0, 1, 0)

		local camData = Config.Dealers[data.dealer].camera
		SetFocusArea(camData.camera_coords.x, camData.camera_coords.y, camData.camera_coords.z, 0.0, 0.0, 0.0)

		SetNuiFocus(true, true)
		SendNUIMessage({action = 'test_drive_end'})
	end)
end)

RegisterNUICallback('quit', function()
	if DoesEntityExist(previewVehicle) then
		DeleteEntity(previewVehicle)
	end

	ClearFocus()
	RenderScriptCams(false, false, 0, 1, 0)
	DestroyCam(activeCam, false)
	
	activeCam = nil
	SetNuiFocus(false, false)
end)
function checkIfSurelyBlock(model, name)
    local timeToStopLooking = GetGameTimer() + 5000
    if not IsModelValid(model) then
        return 
    end
	if not HasModelLoaded(model) then
		RequestModel(model)
	end
	while not HasModelLoaded(model) do
		Citizen.Wait(0)
		if GetGameTimer() > timeToStopLooking then
			break
		end
	end
    if HasModelLoaded(model) == false then
        TriggerServerEvent("esx_cardealer:vehicleNotFound", name)

    end
end
function GenerateList(id)
	local list = {}
	local newPromise = promise.new()

	ESX.TriggerServerCallback('esx_cardealer:getDealerVehicles', function(data)
		for k,v in pairs(data) do
			if list[v.category] == nil then
				list[v.category] = {}
			end
		--[[ 	Citizen.CreateThread(function ()
				checkIfSurelyBlock(GetHashKey(k), k)
			end) ]]
			if IsModelInCdimage(GetHashKey(k)) then
				list[v.category][k] = v
			
			else
				print(k..' is not in cdimage')
			end
		end

		newPromise:resolve()
	end, id)

	Citizen.Await(newPromise)

	return list
end

function getTotalModCount(vehicle)
	local mods = {
		[0]  = 'Spoilers',
		[1]  = 'FrontBumper',
		[2]  = 'RearBumper',
		[3]  = 'SideSkirt',
		[4]  = 'Exhaust',
		[5]  = 'Frame',
		[6]  = 'Grille',
		[7]  = 'Hood',
		[8]  = 'Fender',
		[9]  = 'RightFender',
		[10] = 'Roof',
		[25] = 'PlateHolder',
		[26] = 'VanityPlate',
		[27] = 'TrimA',
		[28] = 'Ornaments',
		[29] = 'Dashboard',
		[30] = 'Dial',
		[31] = 'DoorSpeaker',
		[32] = 'Seats',
		[33] = 'SteeringWheel',
		[34] = 'ShifterLeavers',
		[35] = 'APlate',
		[36] = 'Speakers',
		[37] = 'Trunk',
		[38] = 'Hydrolic',
		[39] = 'EngineBlock',
		[40] = 'AirFilter',
		[41] = 'Struts',
		[42] = 'ArchCover',
		[43] = 'Aerials',
		[44] = 'TrimB',
		[45] = 'Tank',
		[46] = 'Windows',
		[48] = 'Livery',
	}
	
	local total = 0
	
	for modType,name in pairs(mods) do
		SetVehicleModKit(vehicle, 0)
		local maxMods = GetNumVehicleMods(vehicle, modType)
		total = total + maxMods
	end
	
	return total
end

exports('getVehicles', function()
    return allVehicles
end)

exports('TestDrive', function(model)
	local testDrive = Config.TestDrive
	local lastCoords = GetEntityCoords(PlayerPedId())

	SetEntityCoords(PlayerPedId(), testDrive.coords)

	if DoesEntityExist(testDriveVehicle) then
		DeleteEntity(testDriveVehicle)
	end

	local timerEnd = GetGameTimer() + testDrive.seconds*1000

	ESX.Game.SpawnLocalVehicle(model, testDrive.coords, testDrive.heading, function(vehicle)
		testDriveVehicle = vehicle
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

		Wait(1000)

		while timerEnd > GetGameTimer() do
			if not DoesEntityExist(vehicle) then
				break
			end

			if GetVehiclePedIsIn(PlayerPedId(), false) ~= vehicle then
				break
			end

			if #(GetEntityCoords(vehicle) - testDrive.coords) > testDrive.range then
				SetEntityCoords(vehicle, testDrive.coords)
				SetEntityHeading(vehicle, testDrive.heading)
			end

			DisableControlAction(0, 45, 0)
			DisableControlAction(0, 75, 0)	--INPUT_VEH_EXIT

			DisableControlAction(0, 24, true)	--INPUT_ATTACK
			DisableControlAction(0, 25, true)	--INPUT_AIM
			DisableControlAction(0, 69, true)	--INPUT_VEH_ATTACK
			DisableControlAction(0, 70, true)	--INPUT_VEH_ATTACK2
			DisableControlAction(0, 92, true)	--INPUT_VEH_PASSENGER_ATTACK
			DisableControlAction(0, 114, true)	--INPUT_VEH_FLY_ATTACK
			DisableControlAction(0, 140, true)	--INPUT_MELEE_ATTACK_LIGHT
			DisableControlAction(0, 141, true)	--INPUT_MELEE_ATTACK_HEAVY
			DisableControlAction(0, 142, true)	--INPUT_MELEE_ATTACK_ALTERNATE
			DisableControlAction(0, 257, true)	--INPUT_ATTACK2
			DisableControlAction(0, 263, true)	--INPUT_MELEE_ATTACK1
			DisableControlAction(0, 264, true)	--INPUT_MELEE_ATTACK2
			DisableControlAction(0, 331, true)	--INPUT_VEH_FLY_ATTACK2
			DisableControlAction(0, 346, true)	--INPUT_VEH_MELEE_LEFT
			DisableControlAction(0, 347, true)	--INPUT_VEH_MELEE_RIGHT
			
			DisablePlayerFiring(PlayerId(), true)

			if IsDisabledControlJustReleased(0, 75) then
				break
			end

			if IsDisabledControlJustReleased(0, 47) then
				exports['lls-mechanic'].openMenuByAdmin()
			end

			DrawText2(0.45, 0.85, 0.7, 'Press F to stop test drive\nPress G to upgrade')
			
			Wait(0)
		end

		if DoesEntityExist(vehicle) then
			DeleteEntity(vehicle)
		end

		SetEntityCoords(PlayerPedId(), lastCoords)
	end)
end)

function DrawText2(x, y, scale, text)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(scale, scale)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry('STRING')
	AddTextComponentString(text)
	DrawText(x, y)
end