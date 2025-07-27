ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)

RegisterNetEvent('donate_sys:mainMenu')
AddEventHandler('donate_sys:mainMenu', function(donateData)
	local elements = {}
	
	for k,v in pairs(donateData) do
		table.insert(elements, {label = '<b>'..k..'</b>', value = k})
	end
	
	table.sort(elements, function(a,b) return a.value < b.value end)
	
	table.insert(elements, {label = '<b><span style="color:green;">Give Pack</span></b>',		value = 'give_pack'})
	table.insert(elements, {label = '<b><span style="color:red;">Create Category</span></b>',	value = 'create_category'})
	table.insert(elements, {label = '<b><span style="color:red;">Delete Category</span></b>',	value = 'delete_category'})
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'main_menu', {
		title    = 'Main Menu',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		if data.current.value == 'give_pack' then
			local category = exports['dialog']:Create('Enter Category Name', 'Give').value
			
			if category and donateData[category] then
				local target = tonumber(exports['dialog']:Create('Enter Target ID', '').value or 0)
				
				if target > 0 then
					TriggerServerEvent('donate_sys:givePack', category, target)
				end
			end
		elseif data.current.value == 'create_category' then
			local category = exports['dialog']:Create('Enter Category Name', 'Create').value
			
			if category then
				TriggerServerEvent('donate_sys:createCategory', category)
			end
		elseif data.current.value == 'delete_category' then
			local category = exports['dialog']:Create('Enter Category Name', 'Delete').value
			
			if category then
				TriggerServerEvent('donate_sys:deleteCategory', category)
			end
		else
			ShowCategory(data.current.value, donateData[data.current.value])
		end
	end,function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('donate_sys:mainMenu')
AddEventHandler('donate_sys:mainMenu', function(donateData)
	local elements = {}
	
	for k,v in pairs(donateData) do
		table.insert(elements, {label = '<b>'..k..'</b>', value = k})
	end
	
	table.sort(elements, function(a,b) return a.value < b.value end)
	
	table.insert(elements, {label = '<b><span style="color:green;">Give Pack</span></b>',		value = 'give_pack'})
	table.insert(elements, {label = '<b><span style="color:red;">Create Category</span></b>',	value = 'create_category'})
	table.insert(elements, {label = '<b><span style="color:red;">Delete Category</span></b>',	value = 'delete_category'})
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'main_menu', {
		title    = 'Main Menu',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		if data.current.value == 'give_pack' then
			local category = exports['dialog']:Create('Enter Category Name', 'Give').value
			
			if category and donateData[category] then
				local link = exports['dialog']:Create('Enter Screenshot Link', '').value or ''

				if string.len(link) > 1 and string.len(link) < 256 then
					local target = tonumber(exports['dialog']:Create('Enter Target ID', '').value or 0)
					
					if target > 0 then
						TriggerServerEvent('donate_sys:givePack', category, target, link)
					end
				end
			end
		elseif data.current.value == 'create_category' then
			local category = exports['dialog']:Create('Enter Category Name', 'Create').value
			
			if category then
				TriggerServerEvent('donate_sys:createCategory', category)
			end
		elseif data.current.value == 'delete_category' then
			local category = exports['dialog']:Create('Enter Category Name', 'Delete').value
			
			if category then
				TriggerServerEvent('donate_sys:deleteCategory', category)
			end
		else
			ShowCategory(data.current.value, donateData[data.current.value])
		end
	end,function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('donate_sys:showCategoryItems')
AddEventHandler('donate_sys:showCategoryItems', function(category, items)
	ShowCategory(category, items)
end)

RegisterNetEvent('donate_sys:notify')
AddEventHandler('donate_sys:notify', function(msg)
	Citizen.CreateThread(function()
		while true do
			if IsControlJustReleased(0, 47) or IsDisabledControlJustReleased(0, 47) then
				TriggerServerEvent('donate_sys:notifyDone')
				break
			end
			
			DrawText2(0.15, 0.35, 0.75, '~HUD_COLOUR_GOLD~ Press G to read your donate message')
			Wait(0)
		end
		
		exports['fDialog']:OpenDialog('Donate Message', msg)
	end)
end)

RegisterNetEvent('donate_sys:giveDonateTicket')
AddEventHandler('donate_sys:giveDonateTicket', function(donateData)
	local target = tonumber(exports['dialog']:Create('Enter Target ID', '').value or 0)
	
	if target > 0 then
		local category = exports['dialog']:Create('Enter Category Name', '').value or ''

		if donateData[category] then
			local link = exports['dialog']:Create('Enter Screenshot Link', '').value or ''

			if string.len(link) > 1 and string.len(link) < 256 then
				TriggerServerEvent('donate_sys:giveDonateTicket', target, category, link)
			end
		end
	end
end)

RegisterNetEvent('donate_sys:ticketNotify')
AddEventHandler('donate_sys:ticketNotify', function(msg)
	Citizen.CreateThread(function()
		local scaleform = RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')
		while not HasScaleformMovieLoaded(scaleform) do Wait(0) end

		BeginScaleformMovieMethod(scaleform, 'SHOW_SHARD_WASTED_MP_MESSAGE')
		PushScaleformMovieMethodParameterString('DONATE')
		PushScaleformMovieMethodParameterString(msg)
		EndScaleformMovieMethod()

		while true do
			if IsControlJustReleased(0, 200) or IsDisabledControlJustReleased(0, 200) then
				break
			end

			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
			Wait(0)
		end

		SetScaleformMovieAsNoLongerNeeded(scaleform)
	end)
end)

function ShowCategory(category, items)
	local elements = {}
	
	for k,v in pairs(items) do
		table.insert(elements, {label = '<b>'..k..' <span style="color:red;"> ['..v..']</span></b>', value = k})
	end
	
	table.sort(elements, function(a,b) return a.value < b.value end)
	
	table.insert(elements, {label = '<b><span style="color:red;">Add Item</span></b>', value = 'add_item'})
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'items', {
		title    = '['..category..'] Items',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		if data.current.value == 'add_item' then
			local itemName = exports['dialog']:Create('Enter Item', '').value
			
			if itemName then
				if IsValidItem(itemName) then
					local quantity = tonumber(exports['dialog']:Create('Enter quantity', '').value) or 0
					
					if quantity > 0 then
						items[itemName] = quantity
						TriggerServerEvent('donate_sys:setCategoryItems', category, items)
					end
				else
					ESX.ShowNotification('Invalid item')
				end
			end
		else
			items[data.current.value] = nil
			TriggerServerEvent('donate_sys:setCategoryItems', category, items)
		end
	end,
	function(data, menu)
		menu.close()
	end)
end

function IsValidItem(itemName)
	local answer = nil
	ESX.TriggerServerCallback('donate_sys:isValidItem', function(cb) answer = cb end, itemName)
	while answer == nil do Wait(0) end
	
	return answer
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