ESX = nil

local sellers = nil
local cachedSellers = {}
local currentBucket = 0
local currentBucketName = 'default'

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Wait(100)
	end
	
	ESX.PlayerData = ESX.GetPlayerData()
	
	Wait(math.random(1, 5)*1000)
	
	InitScript()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('buckets:onBucketChanged', function(bucketId, bucketName)
	currentBucket = bucketId
	currentBucketName = bucketName
end)

RegisterNetEvent('esx_autoseller:updateStock')
AddEventHandler('esx_autoseller:updateStock', function(job, stock)
	if sellers and sellers[job] then
		sellers[job].stock = stock
	end
end)

RegisterNetEvent('esx_autoseller:update')
AddEventHandler('esx_autoseller:update', function(job, data)
	if sellers then
		sellers[job] = data
		
		if data then
			local closestId = nil
			local closestDistance = 999999.0
			
			for k,v in pairs(Config.Locations) do
				if #(v.coords - data.coords) < closestDistance then
					closestId = k
					closestDistance = #(v.coords - data.coords)
				end
			end
			
			cachedSellers[closestId][job] = true
		else
			for k,v in pairs(cachedSellers) do
				if cachedSellers[k][job] then
					cachedSellers[k][job] = nil
				end
			end
		end
	end
end)

RegisterNetEvent('esx_autoseller:ping')
AddEventHandler('esx_autoseller:ping', function(job)
	TriggerServerEvent('esx_autoseller:ping', job)
end)

function InitScript()
	ESX.TriggerServerCallback('esx_autoseller:getAutoSellers', function(data) sellers = data end)
	while sellers == nil do Wait(100) end
	
	for k,v in pairs(Config.Locations) do
		cachedSellers[k] = {}
		
		--[[local blip = AddBlipForCoord(v.coords)
		SetBlipSprite(blip, 628)
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, 0)
		SetBlipDisplay(blip, 8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Autoseller')
		EndTextCommandSetBlipName(blip)]]
	end
	
	for k,v in pairs(sellers) do
		local closestId = nil
		local closestDistance = 999999.0
		
		for x,y in pairs(Config.Locations) do
			if #(v.coords - y.coords) < closestDistance then
				closestId = x
				closestDistance = #(v.coords - y.coords)
			end
		end
		
		cachedSellers[closestId][k] = true
	end
	
	local npcs = {}
	
	Citizen.CreateThread(function()
		while true do
			local wait = 1500
			local coords = GetEntityCoords(PlayerPedId())
			
			--[[for k,v in pairs(Config.Locations) do
				if #(coords - v.coords) < 50.0 then
					if not DoesEntityExist(npcs[k]) then
						npcs[k] = CreateNPC(Config.NpcModel, v.coords, v.heading)
					end
					
					if #(coords - v.coords) < 1.5 then
						wait = 0
						ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to use the autoseller')
						
						if IsControlJustReleased(0, 38) then
							SetNuiFocus(true, true)
							SendNUIMessage({action = 'show', autosellers = SetupAutosellers(k), payments = Config.Payments, jobData = ESX.PlayerData.job})
						end
					end
				else
					if DoesEntityExist(npcs[k]) then
						DeleteEntity(npcs[k])
					end
				end
			end]]

			for k,v in pairs(Config.Locations) do
				if #(coords - v.coords) < 25.0 then
					wait = 0
					exports['textui']:Draw3DUI('E', 'Autoseller', v.coords, 25.0)
					
					if #(coords - v.coords) < 1.5 then
						ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to use the autoseller')
						
						if IsControlJustReleased(0, 38) then
							SetNuiFocus(true, true)
							SendNUIMessage({action = 'show', autosellers = SetupAutosellers(k), payments = Config.Payments, jobData = ESX.PlayerData.job})
						end
					end
				end
			end
			
			Wait(wait)
		end
	end)
end

RegisterNUICallback('get_items', function(data, cb)
	local items = nil
	local itemsPromise = promise.new()
	
	ESX.TriggerServerCallback('esx_autoseller:getItems', function(_items)
		items = _items
		itemsPromise:resolve()
	end, data.job)

	Citizen.Await(itemsPromise)
	
	local elements = {}
	
	for k,v in pairs(items) do
		local itemLabel = ESX.GetItemLabel(k) or 'Invalid Item'
		
		table.insert(elements, {
			label		= itemLabel,
			name		= k,
			count		= v.count,
			price		= v.price,
			priceType	= v.priceType,
		})
	end

	cb(elements)
end)

RegisterNUICallback('buy', function(data)
	TriggerServerEvent('esx_autoseller:buyItem', data.name, data.count, data.job)
	Wait(1000)
	SendNUIMessage({action = 'update_shop', job = data.job})
end)

RegisterNUICallback('change_price', function(data)
	SetNuiFocus(false, false)
	
	local minPrice = GetMinPrice(data.name)
	local price = tonumber(exports['dialog']:Create('Enter price per item', 'Price must be >= '..minPrice).value) or 0
	
	if price >= minPrice then
		local priceType = exports['dialog']:Create('Pay item with?', 'gm_coins</br>bank').value
		
		if Config.Payments[priceType] then
			TriggerServerEvent('esx_autoseller:updatePrice', data.name, price, priceType, data.job)
		end
	end
end)

RegisterNUICallback('restock', function(data)
	SetNuiFocus(false, false)
	RestockMenu(data.job)
end)

RegisterNUICallback('quit', function(data)
	SetNuiFocus(false, false)
end)

function SetupAutosellers(id)
	local temp = {}
	
	if currentBucket == 0 then
		for k,v in pairs(cachedSellers[id]) do
			if sellers[k] then
				if ESX.PlayerData.job.name ~= k then
					table.insert(temp, {job = k, stock = sellers[k].stock})
				else
					table.insert(temp, {job = k, stock = 999999999})
				end
			end
		end
	else
		for k,v in pairs(cachedSellers[id]) do
			if sellers[k] and currentBucketName == k then
				if ESX.PlayerData.job.name ~= k then
					table.insert(temp, {job = k, stock = sellers[k].stock})
				else
					table.insert(temp, {job = k, stock = 999999999})
				end
			end
		end
	end
	
	table.sort(temp, function(a,b) return a.stock > b.stock end)
	
	return temp
end

function RestockMenu(job)
	local elements = {}
	
	for k,item in pairs(ESX.GetPlayerData().inventory) do
		if item.count > 0 then
			table.insert(elements, {
				label	= item.label..' x'..item.count,
				name	= item.name,
				count	= item.count
			})
		end
	end
	
	local coins = ESX.GetPlayerData().attributes['donate_coins'] or 0
	
	if coins > 0 then
		table.insert(elements, {
			label	= 'Coins x'..coins,
			name	= 'coins',
			count	= coins
		})
	end
	
	if #elements < 1 then
		ESX.ShowNotification('You dont have any items')
		return
	end
	
	ESX.TriggerServerCallback('esx_autoseller:getUsedSlots', function(slots)
		ESX.UI.Menu.CloseAll()
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'restock_menu', {
			title    = 'Inventory: Slots left: '..(Config.MaxSlots - slots),
			align    = 'bottom-right',
			elements = elements,
		},
		function(data, menu)
			local quantity = tonumber(exports['dialog']:Create('Enter quantity to put', 'Enter quantity').value) or 0
			
			if quantity > 0 and quantity <= data.current.count then
				local minPrice = GetMinPrice(data.current.name)
				local price = tonumber(exports['dialog']:Create('Enter price per item', 'Price must be >= '..minPrice).value) or 0
				
				if price >= minPrice then
					local priceType = exports['dialog']:Create('Pay item with?', 'gm_coins</br>bank').value
					
					if Config.Payments[priceType] then
						TriggerServerEvent('esx_autoseller:putItem', data.current.name, quantity, price, priceType, job)
						Wait(1000)
						RestockMenu(job)
					end
				end
			end
		end,
		function(data, menu)
			menu.close()
		end)
	end, job)
end

RegisterCommand('findmybazaar', function(source, args)
	local job = ESX.PlayerData.job.name
	
	for k,v in pairs(cachedSellers) do
		for x,y in pairs(v) do
			if x == job then
				SetNewWaypoint(Config.Locations[k].coords.x, Config.Locations[k].coords.y)
				ESX.ShowNotification('Check your GPS')
				
				break
			end
		end
	end
end)

RegisterCommand('tpbazaar', function(source, args)
	if ESX.GetPlayerData().group ~= 'user' then
		local job = args[1] or ''
		
		if sellers and sellers[job] then
			SetEntityCoords(PlayerPedId(), sellers[job].coords)
		end
	end
end)

--[[RegisterCommand('openbazaar', function(source, args)	--not working
	local elements = {}
	
	for k,v in pairs(sellers) do
		if v.remote then
			local colour = GetStockColour(v.stock)
			table.insert(elements, {label = ('<span style="color:rgb(%d, %d, %d);">%s'):format(colour.r, colour.g, colour.b, k), value = k})
		end
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'openbazaar', {
		title    = "💲<font color = 'green'>Shops</font>💲",
		align    = 'bottom-right',
		elements = elements,
	},
	function(data, menu)
		menu.close()
		ShopMenu(data.current.value)
	end,
	function(data, menu)
		menu.close()
	end)
end)]]

RegisterCommand('restockbazaar', function(source, args)
	local job = ESX.PlayerData.job.name
	
	if exports['supervip']:isSuperVIP() then
		RestockMenu(job)
	end
end)

RegisterCommand('checkstock', function(source, args)
	local job = ESX.PlayerData.job.name
	
	local items
	
	ESX.TriggerServerCallback('esx_autoseller:getItems', function(cb) items = cb end, job)
	while items == nil do Wait(0) end
	
	local elements = {}
	
	for k,v in pairs(items) do
		local itemLabel = ESX.GetItemLabel(k) or 'Invalid Item'
		
		table.insert(elements, {
			label		= ('%s - <span style="color:green;">%s</span> (STOCK: %s)'):format(itemLabel, ESX.Math.GroupDigits(v.price)..' '..Config.Payments[v.priceType], v.count),
			name		= k,
			count		= v.count,
			price		= v.price,
			priceType	= v.priceType,
		})
	end
	
	if #elements < 1 then
		ESX.ShowNotification('This autoseller is empty')
		return
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop', {
		title    = "💲<font color = 'green'>Shop</font>💲",
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

function GetStockColour(stock)
	for i = #Config.Stock, 1, -1 do
		if stock >= Config.Stock[i].stock then
			return Config.Stock[i].colour
		end
	end
	
	return Config.Stock[1].colour
end

function CreateNPC(model, coords, heading)
	RequestModel(model)
	while not HasModelLoaded(model) do Wait(10) end
	
	local npc = CreatePed(5, model, coords.x, coords.y, coords.z - 1.0, heading, false, true)
	SetPedDefaultComponentVariation(npc)
	SetEntityHeading(npc, heading)
	FreezeEntityPosition(npc, true)
	SetEntityInvincible(npc, true)
	SetBlockingOfNonTemporaryEvents(npc, true)
	
	SetModelAsNoLongerNeeded(model)
	
	return npc
end