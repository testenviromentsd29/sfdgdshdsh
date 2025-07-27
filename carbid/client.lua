ESX = nil

local auctions = {}
local vehicles = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	Wait(math.random(2000, 3000))
	
	ESX.TriggerServerCallback('carbid:getAuctions', function(data)
		for id,v in pairs(data) do
			auctions[id] = v
			ProcessAuction(id)
		end
	end)
end)

RegisterCommand('tpdimoprasies', function(source, args)
	if exports['zones'].IsInGreenZone() then
		SetEntityCoords(PlayerPedId(), -108.35, -430.61, 36.06)
	else
		ESX.ShowNotification('You are not in a greenzone')
	end
end)

RegisterCommand('tpbid', function(source, args)
	if exports['zones'].IsInGreenZone() then
		SetEntityCoords(PlayerPedId(), -108.35, -430.61, 36.06)
	else
		ESX.ShowNotification('You are not in a greenzone')
	end
end)

RegisterNetEvent('carbid:create')
AddEventHandler('carbid:create', function(id, data)
	auctions[id] = data
	ProcessAuction(id)
end)

RegisterNetEvent('carbid:end')
AddEventHandler('carbid:end', function(id)
	auctions[id] = nil
end)

RegisterNetEvent('carbid:update')
AddEventHandler('carbid:update', function(id, data)
	auctions[id] = data
end)

RegisterNetEvent('carbid:showHistory')
AddEventHandler('carbid:showHistory', function(history)
	local elements = {}
	
	for k,v in ipairs(history or {}) do
		table.insert(elements, {label = v})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'history', {
		title    = 'Bid History',
		align    = 'bottom-right',
		elements = elements,
	},
	function(data, menu)
		menu.close()
	end,
	function(data, menu)
		menu.close()
	end)
end)

function ProcessAuction(id)
	local vehicle = nil
	
	local timestamp = auctions[id].timestamp
	local vehProps = auctions[id].vehProps
	local coords = auctions[id].coords
	local model = auctions[id].model
	
	local color = nil
	local priceColor = nil
	
	if auctions[id].priceType == 'bank' then
		color = {r = 0, g = 255, b = 0}
		priceColor = '~g~'
	elseif auctions[id].priceType == 'black_money' then
		color = {r = 255, g = 0, b = 0}
		priceColor = '~r~'
	elseif auctions[id].priceType == 'coins' then
		color = {r = 225, g = 215, b = 0}
		priceColor = '~y~'
	end
	
	Citizen.CreateThread(function()
		while auctions[id] do
			local wait = 1500
			local distance = #(coords - GetEntityCoords(PlayerPedId()))
			
			if distance < 100.0 then
				wait = 500
				
				if not DoesEntityExist(vehicle) then
					ESX.Game.SpawnLocalVehicle(model, coords, 0.0, function(entity) vehicle = entity end)
					while not DoesEntityExist(vehicle) do Wait(0) end
					
					vehicles[id] = vehicle
					
					FreezeEntityPosition(vehicle, true)
					SetEntityInvincible(vehicle, true)
					SetVehicleDoorsLocked(vehicle, 2)
					SetVehicleUndriveable(vehicle, true)
					SetEntityCollision(vehicle, false, false)
					
					ESX.Game.SetVehicleProperties(vehicle, vehProps)
				end
				
				if DoesEntityExist(vehicle) then
					SetEntityHeading(vehicle, GetEntityHeading(vehicle) + 0.08)
				end
				
				if distance < 50.0 then
					wait = 0
					DrawMarker(1, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 6.0, 6.0, 2.0, color.r, color.g, color.b, 100, false, false, 2, false, false, false, false)
					
					if distance < 25.0 then
						local timeLeft = timestamp - GlobalState.date.timestamp
						
						if timeLeft > 0 then
							timeLeft = (('%02d:%02d:%02d'):format(math.floor(timeLeft/3600), math.floor(timeLeft/60%60), math.floor(timeLeft%60)))
						else
							timeLeft = 'PLEASE WAIT'
						end
						
						local txt = '~r~'..model..'\n'..priceColor..' '..ESX.Math.GroupDigits(auctions[id].price)..' '..Config.MoneyLabels[auctions[id].priceType]..'\n~g~Top Bidder: ~b~'..auctions[id].bidder.name..'\n~w~Timeleft: ~r~'..timeLeft
						DrawText3D(coords, txt)
						
						if distance < 5.0 then
							ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to open the Auction Menu')
							
							if IsControlJustReleased(0, 38) then
								AuctionMenu(id)
							end
						end
					end
				end
			else
				if DoesEntityExist(vehicle) then
					DeleteEntity(vehicle)
					vehicles[id] = nil
				end
			end
			
			Wait(wait)
		end
		
		if DoesEntityExist(vehicle) then
			DeleteEntity(vehicle)
		end
	end)
end

function AuctionMenu(id)
	local elements = {}
	
	table.insert(elements, {label = 'Test Drive',	value = 'test_drive'})
	table.insert(elements, {label = 'Bid History',	value = 'bid_history'})
	table.insert(elements, {label = 'Bid',			value = 'bid'})
	
	if Config.EnableCancelBid then
		table.insert(elements, {label = 'Cancel Bid',	value = 'cancel_bid'})
	end
	
	if ESX.GetPlayerData().group == 'superadmin' then
		table.insert(elements, {label = '<span style="color:red;">DELETE</span>', value = 'delete'})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'auction_menu', {
		title    = 'Auction Menu',
		align    = 'bottom-right',
		elements = elements,
	},
	function(data, menu)
		menu.close()
		
		if not auctions[id] then return end
		
		if #(GetEntityCoords(PlayerPedId()) - auctions[id].coords) < 5.0 then
			if data.current.value == 'test_drive' then
				TestDrive(id)
			elseif data.current.value == 'bid_history' then
				TriggerServerEvent('carbid:showHistory', id)
			elseif data.current.value == 'bid' then
				local cur = auctions[id].price
				local bid = tonumber(exports['dialog']:Create('Enter amount to bid', 'Bid must be > '..cur).value)
				
				if bid and bid > cur then
					TriggerServerEvent('carbid:bid', id, bid)
				end
			elseif data.current.value == 'cancel_bid' then
				TriggerServerEvent('carbid:cancelBid', id)
			elseif data.current.value == 'delete' then
				TriggerServerEvent('carbid:delete', id)
			end
		end
	end,
	function(data, menu)
		menu.close()
	end)
end

function TestDrive(id)
	exports['esx_cardealer']:TestDrive(auctions[id].model)
end

--[[function TestDrive(id)
	local coords = GetEntityCoords(PlayerPedId())
	
	local model = auctions[id].model
	local vehProps = auctions[id].vehProps
	
	SetEntityCoords(PlayerPedId(), Config.TestDrive.coords)
	ESX.ShowNotification('Test drive will finish in '..Config.TestDrive.duration..' second(s)')
	
	ESX.Game.SpawnLocalVehicle(model, Config.TestDrive.coords, Config.TestDrive.heading, function(vehicle)
		ESX.Game.SetVehicleProperties(vehicle, vehProps)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		
		SetTimeout(Config.TestDrive.duration*1000, function()
			if DoesEntityExist(vehicle) then
				DeleteEntity(vehicle)
			end
			
			SetEntityCoords(PlayerPedId(), coords)
		end)
	end)
end]]

RegisterCommand('carbid', function(source, args)
	if ESX.GetPlayerData().group ~= 'superadmin' then
		return
	end
	
	if args[1] then
		CarbidCmd(args)
		return
	end
	
	local auctionData = {
		model		= nil,
		coords		= nil,
		duration	= nil,
		price		= nil,
		priceType	= nil,
		vehProps	= nil
	}
	
	local elements = {}
	
	table.insert(elements, {label = 'Model',		value = 'model'})
	table.insert(elements, {label = 'Coords',		value = 'coords'})
	table.insert(elements, {label = 'Duration',		value = 'duration'})
	table.insert(elements, {label = 'Price',		value = 'price'})
	table.insert(elements, {label = 'Price Type',	value = 'priceType'})
	table.insert(elements, {label = 'Create',		value = 'create'})
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'auction_menu', {
		title    = 'Auction Menu',
		align    = 'bottom-right',
		elements = elements,
	},
	function(data, menu)
		if data.current.value == 'model' then
			local model = exports['dialog']:Create('Enter model', '').value
			
			if model then
				if IsModelInCdimage(GetHashKey(model)) then
					auctionData[tostring(data.current.value)] = model
					
					local coords = GetEntityCoords(PlayerPedId())
					
					ESX.Game.SpawnLocalVehicle(model, vector3(coords.x, coords.y, coords.z - 10.0), 0.0, function(vehicle)
						auctionData['vehProps'] = exports['tp-garages']:GetVehicleProperties(vehicle)
						DeleteEntity(vehicle)
						
						menu.setElement(1, 'label', 'Model: '..model)
						menu.refresh()
					end)
				else
					ESX.ShowNotification('Model not found')
				end
			end
		elseif data.current.value == 'coords' then
			local coords = GetEntityCoords(PlayerPedId())
			local coordsTxt = ('vector3(%.2f, %.2f, %.2f)'):format(coords.x, coords.y, coords.z - 1.0)
			
			auctionData[tostring(data.current.value)] = vector3(coords.x, coords.y, coords.z - 1.0)
			
			menu.setElement(2, 'label', 'Coords: '..coordsTxt)
			menu.refresh()
		elseif data.current.value == 'duration' then
			local duration = tonumber(exports['dialog']:Create('Enter duration', 'In minutes').value)
			
			if duration and duration > 0 then
				auctionData[tostring(data.current.value)] = duration
				
				menu.setElement(3, 'label', 'Duration: '..duration..' minute(s)')
				menu.refresh()
			end
		elseif data.current.value == 'price' then
			local price = tonumber(exports['dialog']:Create('Enter price', '').value)
			
			if price and price > 0 then
				auctionData[tostring(data.current.value)] = price
				
				menu.setElement(4, 'label', 'Price: '..price)
				menu.refresh()
			end
		elseif data.current.value == 'priceType' then
			local priceType = exports['dialog']:Create('Enter price type', 'bank</br>black_money</br>coins').value
			
			if priceType and (priceType == 'bank' or priceType == 'black_money' or priceType == 'coins') then
				auctionData[tostring(data.current.value)] = priceType
				
				menu.setElement(5, 'label', 'Price Type: '..priceType)
				menu.refresh()
			end
		elseif data.current.value == 'create' then
			if auctionData.model and auctionData.coords and auctionData.duration and auctionData.price and auctionData.priceType and auctionData.vehProps then
				menu.close()
				TriggerServerEvent('carbid:create', auctionData)
			end
		end
	end,
	function(data, menu)
		menu.close()
	end)
end)

function CarbidCmd(args)
	local auctionData = {
		model		= nil,
		coords		= nil,
		duration	= nil,
		price		= nil,
		priceType	= nil,
		vehProps	= nil
	}
	
	local model = args[1]
	
	if IsModelInCdimage(GetHashKey(model)) then
		auctionData['model'] = model
		
		local coords = GetEntityCoords(PlayerPedId())
		
		ESX.Game.SpawnLocalVehicle(model, vector3(coords.x, coords.y, coords.z - 10.0), 0.0, function(vehicle)
			auctionData['vehProps'] = exports['tp-garages']:GetVehicleProperties(vehicle)
			DeleteEntity(vehicle)
			
			auctionData['coords'] = vector3(coords.x, coords.y, coords.z - 1.0)
			
			local duration = tonumber(args[2])
			
			if duration and duration > 0 then
				auctionData['duration'] = duration
				
				local price = tonumber(args[3])
				
				if price and price > 0 then
					auctionData['price'] = price
					
					local priceType = args[4]
					
					if priceType and (priceType == 'bank' or priceType == 'black_money' or priceType == 'coins') then
						auctionData['priceType'] = priceType
						
						if auctionData.model and auctionData.coords and auctionData.duration and auctionData.price and auctionData.priceType and auctionData.vehProps then
							TriggerServerEvent('carbid:create', auctionData)
						end
					else
						ESX.ShowNotification('Price types: bank, black_money, coins')
					end
				else
					ESX.ShowNotification('Price must be > 0')
				end
			else
				ESX.ShowNotification('Duration must be > 0')
			end
		end)
	else
		ESX.ShowNotification('Model not found')
	end
end

function DrawText3D(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
	
    local scale = 400 / (GetGameplayCamFov() * dist)
	
    SetTextColour(255, 255, 255, 255)
	SetTextScale(0.0, 0.5 * scale)
	SetTextFont(1)
	SetTextDropshadow(0, 0, 0, 0, 55)
	SetTextDropShadow()
	SetTextCentre(true)
	
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	SetDrawOrigin(coords.x, coords.y, coords.z + 2.0, 0)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k,v in pairs(vehicles) do
			if DoesEntityExist(v) then
				DeleteEntity(v)
			end
		end
	end
end)