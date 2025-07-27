ESX = nil

local onGoingRobbery = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	CreateBlip()
	InitScript()
end)

function CreateBlip()
	local blip = AddBlipForCoord(Config.NPC.coords)
	SetBlipSprite(blip, 605)
	SetBlipColour(blip, 1)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('ATM Robberies')
	EndTextCommandSetBlipName(blip)
end

function InitScript()
	local npc = nil
	
	Citizen.CreateThread(function()
		while true do
			local wait = 1500
			local coords = GetEntityCoords(PlayerPedId())
			
			if #(coords - Config.NPC.coords) < 25.0 then
				if not DoesEntityExist(npc) then
					npc = CreateStaticNPC()
				end
				
				if #(coords - Config.NPC.coords) < 1.2 then
					wait = 0
					ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to start ATM Robberies')
					
					if IsControlJustReleased(0, 38) then
						TriggerServerEvent('atm_robberies:start')
						Wait(1000)
					end
				end
			else
				if DoesEntityExist(npc) then
					DeleteEntity(npc)
				end
			end
			
			Wait(wait)
		end
	end)
end

RegisterNetEvent('atm_robberies:start')
AddEventHandler('atm_robberies:start', function(id, netId, state)
	onGoingRobbery = true
	GlobalState.atmRobberyState = state
	
	ProcessAtmRobbery(id, netId)
end)

function ProcessAtmRobbery(id, netId)
	local inZone = false
	local blipDest = nil
	local atmVehicle = -1
	
	local atmVehicleBlip = AddBlipForCoord(Config.Vehicle.coords)
	SetBlipSprite(atmVehicleBlip, 500)
	SetBlipColour(atmVehicleBlip, 1)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('ATM Robberies')
	EndTextCommandSetBlipName(atmVehicleBlip)
	
	local atmRadiusBlip = AddBlipForRadius(Config.Vehicle.coords, Config.RedzoneRadius)
	SetBlipColour(atmRadiusBlip, 1)
	SetBlipDisplay(atmRadiusBlip, 4)
	SetBlipAlpha(atmRadiusBlip, 128)
	
	Citizen.CreateThread(function()
		while onGoingRobbery and GlobalState.atmRobberyState < 6 do
			if GlobalState.atmRobberyState >= 3 and GlobalState.atmRobberyState <= 4 then
				local distance = #(GetEntityCoords(PlayerPedId()) - Config.ATMs[id].destination)
				
				if distance < Config.RedzoneRadius then
					if not inZone then
						inZone = true
						TriggerServerEvent('atm_robberies:enteredZone', true)
					end
				else
					if inZone then
						inZone = false
						TriggerServerEvent('atm_robberies:enteredZone', false)
					end
				end
			end
			
			SetBlipCoords(atmVehicleBlip, GlobalState.atmRobberyVehCoords or Config.Vehicle.coords)
			SetBlipCoords(atmRadiusBlip, GlobalState.atmRobberyVehCoords or Config.Vehicle.coords)
			
			if NetworkDoesNetworkIdExist(netId) then
				atmVehicle = NetworkGetEntityFromNetworkId(netId)
				
				if DoesEntityExist(atmVehicle) then
					if NetworkGetEntityOwner(atmVehicle) == PlayerId() then
						SetEntityProofs(atmVehicle, true, true, true, true, true, true, 1, true)
					end
				else
					atmVehicle = -1
				end
			else
				atmVehicle = -1
			end
			
			local curVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			
			if DoesEntityExist(curVehicle) and curVehicle == atmVehicle and GetPedInVehicleSeat(atmVehicle, -1) == PlayerPedId() then
				if not DoesBlipExist(blipDest) then
					blipDest = AddBlipForCoord(Config.ATMs[id].destination)
					SetBlipSprite(blipDest, 480)
					SetBlipColour(blipDest, 1)
					BeginTextCommandSetBlipName('STRING')
					AddTextComponentString('Destination')
					EndTextCommandSetBlipName(blipDest)
				end
				
				SetNewWaypoint(Config.ATMs[id].destination.x, Config.ATMs[id].destination.y)
			else
				if DoesBlipExist(blipDest) then
					RemoveBlip(blipDest)
				end
			end
			
			Wait(500)
		end
		
		if DoesBlipExist(blipDest) then
			RemoveBlip(blipDest)
		end
	end)
	
	while onGoingRobbery and GlobalState.atmRobberyState == 1 do
		local wait = 1500
		
		if DoesEntityExist(atmVehicle) and GetPedInVehicleSeat(atmVehicle, -1) == PlayerPedId() then
			local distance = #(GetEntityCoords(PlayerPedId()) - Config.ATMs[id].destination)
			
			if distance < 100.0 then
				wait = 0
				
				DrawMarker(0, Config.ATMs[id].destination, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, false, 2, false, false, false, false)
				
				if distance < 2.0 and GetEntitySpeed(atmVehicle) < 5.0 then
					TriggerServerEvent('atm_robberies:destinationReached')
					Wait(1000)
				end
			end
		end
		
		Wait(wait)
	end
	
	while onGoingRobbery and GlobalState.atmRobberyState == 2 do
		local wait = 1500
		
		local atmObject = GetClosestObjectOfType(Config.ATMs[id].coords.x, Config.ATMs[id].coords.y, Config.ATMs[id].coords.z, 1.0, Config.ATMs[id].model, false, false)
		
		if DoesEntityExist(atmObject) then
			local distance = #(GetEntityCoords(PlayerPedId()) - Config.ATMs[id].coords)
			
			if distance < 50.0 then
				wait = 0
				DrawMarker(1, Config.ATMs[id].coords, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 0.5, 255, 0, 0, 150, false, false, 2, false, false, false, false)
				
				if distance < 1.5 then
					ESX.ShowHelpNotification('Press ~INPUT_ENTER~ to plant the bomb')
					
					if IsControlJustReleased(0, 23) then
						RequestAnimDict('weapons@projectile@sticky_bomb')
						while not HasAnimDictLoaded('weapons@projectile@sticky_bomb') do Wait(0) end
						
						TaskPlayAnim(PlayerPedId(), 'weapons@projectile@sticky_bomb', 'plant_vertical', 2.0, -8.0, -1, 0, 0, false, false, false)
						
						TriggerServerEvent('atm_robberies:plantBomb')
						Wait(1000)
					end
				end
			end
		end
		
		Wait(wait)
	end
	
	while onGoingRobbery and GlobalState.atmRobberyState == 3 do
		local wait = 500
		
		if inZone then
			wait = 0
			
			local seconds = GlobalState.atmRobberyExplosion - GlobalState.date.timestamp
			
			if seconds < 1 then
				seconds = 0
			end
			
			local timeTxt = (('%02d:%02d'):format(math.floor(seconds/60), math.floor(seconds%60)))
			
			--DrawText2(0.45, 0.20, 0.8, '~r~EXPLOSION: '..timeTxt)
			exports['eventTimer']:ShowTimer('EXPLOSION IN', timeTxt);
		end
		
		Wait(wait)
	end
	
	if inZone then
		RequestNamedPtfxAsset('core')
		while not HasNamedPtfxAssetLoaded('core') do Wait(0) end
		
		SetPtfxAssetNextCall('core')
		
		StartParticleFxNonLoopedAtCoord('exp_grd_sticky', Config.ATMs[id].coords.x, Config.ATMs[id].coords.y, Config.ATMs[id].coords.z, 0.0, 0.0, 0.0, 1.0, false, false, false)
		
		PlaySoundFromCoord(-1, 'MAIN_EXPLOSION_CHEAP', Config.ATMs[id].coords.x, Config.ATMs[id].coords.y, Config.ATMs[id].coords.z, '', 0, 0, 0)
		ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 1.0)
	end
	
	local isLooting = false
	
	while onGoingRobbery and GlobalState.atmRobberyState == 4 do
		local wait = 1500
		
		local atmObject = GetClosestObjectOfType(Config.ATMs[id].coords.x, Config.ATMs[id].coords.y, Config.ATMs[id].coords.z, 1.0, Config.ATMs[id].model, false, false)
		
		if DoesEntityExist(atmObject) then
			local distance = #(GetEntityCoords(PlayerPedId()) - Config.ATMs[id].coords)
			
			if distance < 50.0 then
				wait = 0
				DrawMarker(1, Config.ATMs[id].coords, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 0.5, 0, 255, 0, 150, false, false, 2, false, false, false, false)
				
				if distance < 1.5 then
					ESX.ShowHelpNotification('Press ~INPUT_ENTER~ to loot the money')
					
					if IsControlJustReleased(0, 23) then
						if not isLooting then
							isLooting = true
							ExecuteCommand('e mechanic3')
							
							TriggerEvent('mythic_progressbar:client:progress', {
								name = 'looting',
								duration = Config.LootDuration*1000,
								label = 'Looting...',
								useWhileDead = false,
								canCancel = true,
								controlDisables = {
									disableMovement = true,
									disableCarMovement = true,
									disableMouse = false,
									disableCombat = true,
								},
							}, function(cancelled)
								ExecuteCommand('e c')
								TriggerServerEvent('atm_robberies:lootMoney', cancelled)
								Wait(1000)
								isLooting = false
							end)
						end
					end
				end
			end
		end
		
		Wait(wait)
	end
	
	local isLooting = false
	
	while onGoingRobbery and GlobalState.atmRobberyState == 5 do
		Wait(500)
		
		if DoesEntityExist(atmVehicle) and GetPedInVehicleSeat(atmVehicle, -1) == PlayerPedId() then
			TriggerServerEvent('atm_robberies:nextDestination')
			Wait(1000)
		end
	end
	
	if DoesBlipExist(atmVehicleBlip) then
		RemoveBlip(atmVehicleBlip)
	end
	
	if DoesBlipExist(atmRadiusBlip) then
		RemoveBlip(atmRadiusBlip)
	end
end

function CreateStaticNPC()
	RequestModel(Config.NPC.model)
	while not HasModelLoaded(Config.NPC.model) do Wait(0) end
	
	local npc = CreatePed(5, Config.NPC.model, Config.NPC.coords.x, Config.NPC.coords.y, Config.NPC.coords.z - 1.0, Config.NPC.heading, false, true)
	SetPedDefaultComponentVariation(npc)
	SetEntityHeading(npc, Config.NPC.heading)
	FreezeEntityPosition(npc, true)
	SetEntityInvincible(npc, true)
	SetBlockingOfNonTemporaryEvents(npc, true)
	
	SetModelAsNoLongerNeeded(Config.NPC.model)
	
	return npc
end

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

exports('IsInZone', function()
	if GlobalState.atmRobberyVehCoords and #(GetEntityCoords(PlayerPedId()) - GlobalState.atmRobberyVehCoords) < Config.RedzoneRadius then
		return false
	end
	
	return false
end)