ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)

RegisterCommand('cargostart', function(source, args)
	if ESX.GetPlayerData().group == 'user' then
		ESX.ShowNotification('You don\'t have access to use this command')
		return
	end
	
	if args[1] == nil then
		ESX.ShowNotification('Usage: cargostart [model] [warmup]')
		return
	end

	local model = args[1] or ''

	if not IsModelInCdimage(GetHashKey(model)) then
		ESX.ShowNotification('Invalid model')
		return
	end

	local warmup = tonumber(args[2]) or 0
	
	if warmup < 0 then
		ESX.ShowNotification('Warmup minute(s) must be > 0')
		return
	end

	TriggerServerEvent('cargo_night:start', model, warmup)
end)

RegisterCommand('joincargo', function(source, args)
	if GlobalState.cargoStatus ~= 'warmup' then
		ESX.ShowNotification('No cargo warmup is running')
		return
	end

	if not exports.zones:IsInGreenZone() then
		ESX.ShowNotification('You must be in the green zone to join the cargo')
		return
	end

	SetEntityCoords(PlayerPedId(), GlobalState.cargoCoords)
end)

RegisterNetEvent('cargo_night:start')
AddEventHandler('cargo_night:start', function(cargoStart, cargoEnd)
	ProcessCargo(cargoStart, cargoEnd)
end)

function ProcessCargo(cargoStart, cargoEnd)
	local blip = AddBlipForCoord(cargoStart.coords)
	SetBlipSprite(blip, 616)
	SetBlipColour(blip, 1)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Cargo')
	EndTextCommandSetBlipName(blip)
	
	local blipRadius = AddBlipForRadius(cargoStart.coords, Config.Radius)
	SetBlipColour(blipRadius, 1)
	SetBlipAlpha(blipRadius, 128)

	Citizen.CreateThread(function()
		local time = 0

		Citizen.CreateThread(function()
			while GlobalState.cargoStatus == 'warmup' do
				local wait = 500

				if #(GetEntityCoords(PlayerPedId()) - GlobalState.cargoCoords) < Config.Radius then
					wait = 0
					DontShootThisFrame()
				end

				Wait(wait)
			end
		end)

		while GlobalState.cargoStatus == 'warmup' do
			time = GlobalState.cargoWarmupEnd - GlobalState.date.timestamp
			time = time > 0 and (('%02d:%02d'):format(math.floor(time/60), math.floor(time%60))) or '00:00'

			SendNUIMessage({
				action = 'update',
				data = {
					time	= time,
					stage	= 'WARMUP',
				}
			})

			Wait(500)
		end

		SendNUIMessage({action = 'close'})

		TriggerEvent('top_notifications:show', Config.NotificationData)

		Citizen.CreateThread(function()
			while GlobalState.cargoStatus == 'live' do
				local wait = 500

				if NetworkDoesNetworkIdExist(GlobalState.cargoNetId) then
					local vehicle = NetworkGetEntityFromNetworkId(GlobalState.cargoNetId)

					if DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
						SetNewWaypoint(cargoEnd.coords.x, cargoEnd.coords.y)

						if #(GetEntityCoords(vehicle) - cargoEnd.coords) < 100.0 then
							wait = 0
							DrawMarker(1, cargoEnd.coords.x, cargoEnd.coords.y, cargoEnd.coords.z - 1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 5.0, 5.0, 1.0, 255, 0, 0, 128, false, false, 2, false, false, false, false)

							if #(GetEntityCoords(vehicle) - cargoEnd.coords) < 3.0 then
								ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to deliver the cargo')

								if IsControlJustPressed(0, 38) then
									TriggerServerEvent('cargo_night:deliverCargo')
									Wait(1000)
								end
							end
						end
					end
				end

				Wait(0)
			end
		end)

		while GlobalState.cargoStatus == 'live' do
			Wait(1000)

			if DoesBlipExist(blip) then
				SetBlipCoords(blip, GlobalState.cargoCoords)
			end

			if DoesBlipExist(blipRadius) then
				SetBlipCoords(blipRadius, GlobalState.cargoCoords)
			end

			if NetworkDoesNetworkIdExist(GlobalState.cargoNetId) then
				local vehicle = NetworkGetEntityFromNetworkId(GlobalState.cargoNetId)

				if DoesEntityExist(vehicle) then
					SetVehicleCanLeakOil(vehicle, false)
					SetVehicleCanLeakPetrol(vehicle, false)
					SetEntityProofs(vehicle, true, true, true, true, true, true, 1, true)
				end
			end
		end

		if DoesBlipExist(blip) then
			RemoveBlip(blip)
		end

		if DoesBlipExist(blipRadius) then
			RemoveBlip(blipRadius)
		end

		TriggerEvent('top_notifications:hide', Config.NotificationData.name)
	end)
end

RegisterNetEvent('cargo_night:setCargoItems')
AddEventHandler('cargo_night:setCargoItems', function(items)
	local function IsValidItem(itemName)
		local answer = nil
		ESX.TriggerServerCallback('cargo_night:isValidItem', function(cb) answer = cb end, itemName)
		while answer == nil do Wait(0) end
		
		return answer
	end
	
	local elements = {}
	
	for k,v in pairs(items) do
		table.insert(elements, {label = '<b>'..k..' <span style="color:red;"> ['..v..']</span></b>', value = k})
	end
	
	table.insert(elements, {label = '<b><span style="color:red;">Add Item</span></b>', value = 'add_item'})
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cargo_items', {
		title    = 'Cargo Items',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		if data.current.value == 'add_item' then
			local itemName = exports['dialog']:Create('Enter item', '').value
			
			if itemName then
				if IsValidItem(itemName) then
					if itemName ~= 'vehicle' then
						local quantity = tonumber(exports['dialog']:Create('Enter quantity', '').value) or 0
						
						if quantity > 0 then
							items[itemName] = quantity
							TriggerServerEvent('cargo_night:setCargoItems', items)
						end
					else
						local model = exports['dialog']:Create('Enter vehicle name', '').value or ''
						
						if IsModelInCdimage(GetHashKey(model)) then
							items[itemName] = model
							TriggerServerEvent('cargo_night:setCargoItems', items)
						end
					end
				else
					ESX.ShowNotification('Invalid item')
				end
			end
		else
			items[data.current.value] = nil
			TriggerServerEvent('cargo_night:setCargoItems', items)
		end
	end,
	function(data, menu)
		menu.close()
	end)
end)

function DontShootThisFrame()
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
end

exports('InEvent', function()
	if GlobalState.cargoCoords and #(GetEntityCoords(PlayerPedId()) - GlobalState.cargoCoords) < Config.Radius then
		return true
	end

	return false
end)