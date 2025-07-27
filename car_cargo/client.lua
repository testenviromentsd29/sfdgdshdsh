ESX = nil

local cargoBlip = nil
local cargoRadiusBlip = nil
local cargoDestId = nil
local onGoingCargo = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	InitScript()
end)

RegisterNetEvent('car_cargo:end')
AddEventHandler('car_cargo:end', function()
	onGoingCargo = false
	TriggerEvent('top_notifications:hide', Config.NotificationData.name)
end)

RegisterNetEvent('car_cargo:prestart')
AddEventHandler('car_cargo:prestart', function()
	if DoesBlipExist(cargoBlip) then
		RemoveBlip(cargoBlip)
	end
	
	if DoesBlipExist(cargoRadiusBlip) then
		RemoveBlip(cargoRadiusBlip)
	end
	
	cargoBlip = AddBlipForCoord(Config.Vehicle.coords)
	SetBlipSprite(cargoBlip, math.floor(598))
	SetBlipColour(cargoBlip, math.floor(1))
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Car Cargo')
	EndTextCommandSetBlipName(cargoBlip)
	
	cargoRadiusBlip = AddBlipForRadius(Config.Vehicle.coords, Config.RedzoneRadius)
	SetBlipColour(cargoRadiusBlip, math.floor(1))
	SetBlipDisplay(cargoRadiusBlip, math.floor(4))
	SetBlipAlpha(cargoRadiusBlip, math.floor(150))
	
	Citizen.CreateThread(function()
		TriggerEvent('top_notifications:show', Config.NotificationData)
		Wait(5*60000)
		TriggerEvent('top_notifications:hide', Config.NotificationData.name)
	end)
end)

RegisterNetEvent('car_cargo:start')
AddEventHandler('car_cargo:start', function(destId, caller, netId)
	onGoingCargo = true
	cargoDestId = destId

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
	
	ProcessCargo()
end)

function ProcessCargo()
	if not onGoingCargo then
		TriggerEvent('top_notifications:hide', Config.NotificationData.name)
		return
	end
	
	local playerId = PlayerId()
	local cargoVehicle = nil
	local attachedVeh = nil
	local blipDest = nil
	local inCargoVehicle = false
	local coordsDest = Config.Destinations[cargoDestId]
	local cargoCoords = GlobalState.carcargoCoords or vector3(0.0, 0.0, 0.0)
	
	if DoesBlipExist(cargoBlip) then
		RemoveBlip(cargoBlip)
	end
	
	if DoesBlipExist(cargoRadiusBlip) then
		RemoveBlip(cargoRadiusBlip)
	end
	
	cargoBlip = AddBlipForCoord(cargoCoords)
	SetBlipSprite(cargoBlip, math.floor(598))
	SetBlipColour(cargoBlip, math.floor(1))
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Car Cargo')
	EndTextCommandSetBlipName(cargoBlip)

	cargoRadiusBlip = AddBlipForRadius(cargoCoords, Config.RedzoneRadius)
	SetBlipColour(cargoRadiusBlip, math.floor(1))
	SetBlipDisplay(cargoRadiusBlip, math.floor(4))
	SetBlipAlpha(cargoRadiusBlip, math.floor(150))
	
	Citizen.CreateThread(function()
		while onGoingCargo do
			cargoCoords = GlobalState.carcargoCoords or vector3(0.0, 0.0, 0.0)
			
			if DoesBlipExist(cargoBlip) then
				SetBlipCoords(cargoBlip, cargoCoords)
			end
			
			if DoesBlipExist(cargoRadiusBlip) then
				SetBlipCoords(cargoRadiusBlip, cargoCoords)
			end
			
			if NetworkDoesNetworkIdExist(GlobalState.carcargoVehNetId) then
				cargoVehicle = NetworkGetEntityFromNetworkId(GlobalState.carcargoVehNetId)
				
				if DoesEntityExist(cargoVehicle) then
					if not DoesEntityExist(attachedVeh) then
						RequestModel(`blista`)
						while not HasModelLoaded(`blista`) do Wait(0) end
						
						local coords = GetEntityCoords(cargoVehicle)
						local rotation = GetEntityRotation(cargoVehicle)
						
						attachedVeh = CreateVehicle(`blista`, coords.x, coords.y, coords.z + 3.0, GetEntityHeading(cargoVehicle), false, false)
						
						AttachEntityToEntity(attachedVeh, cargoVehicle, 20, 0.0, -1.5, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					end
				else
					if DoesEntityExist(attachedVeh) then
						DeleteEntity(attachedVeh)
					end
				end
			end
			
			local curVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			
			if DoesEntityExist(curVehicle) and curVehicle == cargoVehicle then
				inCargoVehicle = true
				
				if not DoesBlipExist(blipDest) then
					blipDest = AddBlipForCoord(coordsDest)
					SetBlipSprite(blipDest, math.floor(480))
					SetBlipColour(blipDest, math.floor(1))
					BeginTextCommandSetBlipName('STRING')
					AddTextComponentString('Cargo Destination')
					EndTextCommandSetBlipName(blipDest)
					
					ESX.ShowNotification('Check your minimap for the destination')
				end
				
				SetNewWaypoint(coordsDest.x, coordsDest.y)
			else
				inCargoVehicle = false
				
				if DoesBlipExist(blipDest) then
					RemoveBlip(blipDest)
				end
			end
			
			Wait(500)
		end
		
		if DoesEntityExist(attachedVeh) then
			DeleteEntity(attachedVeh)
		end
		
		if DoesBlipExist(blipDest) then
			RemoveBlip(blipDest)
		end
		
		if DoesBlipExist(cargoBlip) then
			RemoveBlip(cargoBlip)
		end

		if DoesBlipExist(cargoRadiusBlip) then
			RemoveBlip(cargoRadiusBlip)
		end
	end)
	
	Citizen.CreateThread(function()
		while onGoingCargo do
			local wait = 1500
			
			if DoesEntityExist(cargoVehicle) and inCargoVehicle then
				local distance = #(GetEntityCoords(PlayerPedId()) - coordsDest)
				
				if distance < 30.0 then
					wait = 0
					
					DrawMarker(math.floor(28), coordsDest, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, math.floor(0), math.floor(0), math.floor(0), math.floor(30), false, false, math.floor(2), true, false, false, false)
					DrawMarker(math.floor(30), coordsDest, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.4, 0.4, 0.4, math.floor(255), math.floor(0), math.floor(0), math.floor(150), false, false, math.floor(2), true, false, false, false)
				end
			end
			
			Wait(wait)
		end
		
		if DoesBlipExist(blipDest) then
			RemoveBlip(blipDest)
		end
	end)
end

function InitScript()
	local blip = AddBlipForCoord(Config.NPC.coords)
	SetBlipSprite(blip, math.floor(67))
	SetBlipColour(blip, math.floor(1))
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Car Cargo')
	EndTextCommandSetBlipName(blip)
	
	local guard = nil
	
	Citizen.CreateThread(function()
		while true do
			local wait = 2500
			local distance = #(GetEntityCoords(PlayerPedId()) - Config.NPC.coords)
			
			if distance < 25.0 then
				wait = 0
				
				if not DoesEntityExist(guard) then
					guard = CreateStaticNPC(Config.NPC.model, Config.NPC.coords, Config.NPC.heading)
				end
				
				if distance < 5.0 then
					DrawText3D(Config.NPC.coords, 'CAR CARGO')
					
					if distance < 1.9 then
						ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to start the Car Cargo')
						
						if IsControlJustReleased(math.floor(0), math.floor(38)) then
							TriggerServerEvent('car_cargo:start')
							Wait(1000)
						end
					end
				end
			else
				if DoesEntityExist(guard) then
					DeleteEntity(guard)
				end
			end
			
			Wait(wait)
		end
	end)
end

function CreateStaticNPC(model, coords, heading)
	RequestModel(model)
	while not HasModelLoaded(model) do Wait(10) end
	
	local npc = CreatePed(math.floor(5), model, coords.x, coords.y, coords.z - 1.0, heading, false, true)
	SetPedDefaultComponentVariation(npc)
	SetEntityHeading(npc, heading)
	FreezeEntityPosition(npc, true)
	SetEntityInvincible(npc, true)
	SetBlockingOfNonTemporaryEvents(npc, true)
	
	SetModelAsNoLongerNeeded(model)
	
	return npc
end

function CreateCargoDriver(model, vehicle)
	RequestModel(model)
	while not HasModelLoaded(model) do Wait(0) end
	
	local npc = CreatePedInsideVehicle(vehicle, math.floor(5), model, math.floor(-1), false, true)
	SetPedDefaultComponentVariation(npc)
	SetEntityInvincible(npc, true)
	SetBlockingOfNonTemporaryEvents(npc, true)
	SetPedCanBeDraggedOut(npc, false)
	
	SetModelAsNoLongerNeeded(model)
	
	return npc
end

function DrawText2(x, y, scale, text)
	SetTextFont(math.floor(4))
	SetTextProportional(math.floor(1))
	SetTextScale(scale, scale)
	SetTextDropshadow(math.floor(1), math.floor(0), math.floor(0), math.floor(0), math.floor(255))
	SetTextEdge(math.floor(1), math.floor(0), math.floor(0), math.floor(0), math.floor(255))
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry('STRING')
	AddTextComponentString(text)
	DrawText(x, y)
end

function DrawText3D(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
	
    local scale = math.floor(400) / (GetGameplayCamFov() * dist)
	
    SetTextColour(math.floor(255), math.floor(255), math.floor(255), math.floor(255))
	SetTextScale(0.0, 0.4 * scale)
	SetTextFont(math.floor(1))
	SetTextDropshadow(math.floor(0), math.floor(0), math.floor(0), math.floor(0), math.floor(55))
	SetTextDropShadow()
	SetTextCentre(true)
	
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	SetDrawOrigin(coords.x, coords.y, coords.z + math.floor(1), math.floor(0))
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end

inCargo = function()
	if GlobalState.carcargoCoords then
		local coords = GetEntityCoords(PlayerPedId())
		return #(vector2(coords.x, coords.y) - vector2(GlobalState.carcargoCoords.x, GlobalState.carcargoCoords.y)) < Config.RedzoneRadius
	else
		return false
	end
end

exports('IsOnCarCargo', function()
	if GlobalState.carcargoCoords then
		local coords = GetEntityCoords(PlayerPedId())
		return #(vector2(coords.x, coords.y) - vector2(GlobalState.carcargoCoords.x, GlobalState.carcargoCoords.y)) < Config.RedzoneRadius
	else
		return false
	end
end)