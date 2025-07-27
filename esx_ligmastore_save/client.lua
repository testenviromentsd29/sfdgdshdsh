ESX = nil

local isBusy = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	Wait(1000)
	
	local blip = AddBlipForCoord(Config.Location)
	SetBlipSprite(blip, 351)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 1.2)
	SetBlipColour(blip, 3)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Get Items Back')
	EndTextCommandSetBlipName(blip)
	
	while true do
		local wait = 3000
		local distance = #(GetEntityCoords(PlayerPedId()) - Config.Location)
		
		if distance < 20.0 then
			wait = 0
			DrawMarker(30, Config.Location, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 100, 255, 255, 150, true, true, 2, false, false, false, false)
			
			if distance < 1.0 then
				ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to get your stuff back')
				
				if IsControlJustReleased(0, 38) and not isBusy then
					ESX.TriggerServerCallback('esx_ligmastore_save:getArmories', function(data)
						if data then
							SelectArmory(data)
						else
							ESX.ShowNotification('No armories found')
						end
					end)
					
					Wait(1000)
				end
			end
		end
		
		Wait(wait)
	end
end)

function SelectArmory(names)
	local elements = {}
	
	for i=1, #names do
		table.insert(elements, {label = names[i], value = names[i]})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'select_armory', {
		title    = 'Select Armory',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		local armory = data.current.value
		
		menu.close()
		
		local result = exports['dialog']:Decision(armory, 'What do you want to withdraw?', '', 'Items', 'Weapons').action
		local type = (result == 'submit' and 'items' or result == 'cancel' and 'weapons')
		
		if type then
			ESX.TriggerServerCallback('esx_ligmastore_save:getArmoryData', function(data)
				if data then
					WithdrawMenu(armory, data, type)
				else
					ESX.ShowNotification('No items/weapons found')
				end
			end, armory, type)
		end
	end,
	function(data, menu)
		menu.close()
	end)
end

function WithdrawMenu(armory, armoryData, type)
	local elements = {}
	
	if type == 'items' then
		for k,v in pairs(armoryData) do
			table.insert(elements, {label = ESX.GetItemLabel(k)..' x'..v, value = k})
		end
	elseif type == 'weapons' then
		for k,v in pairs(armoryData) do
			table.insert(elements, {label = string.gsub(v.weapon, 'WEAPON_', ''), value = k})
		end
	end
	
	if #elements < 1 then
		ESX.ShowNotification('No data found')
		return
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'withdraw_menu', {
		title    = 'Select Item/Weapon',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		if not isBusy then
			local itemId = data.current.value
			
			menu.close()
			
			local amount = 1
			
			if type == 'items' then
				local dialog = exports['dialog']:Create('Withdraw', 'Enter amount to withdraw')
				amount = tonumber(dialog.value) or -1
			end
			
			if amount >= 1 then
				isBusy = true
				
				ESX.TriggerServerCallback('esx_ligmastore_save:withdraw', function(newData)
					if newData then
						WithdrawMenu(armory, newData, type)
					else
						WithdrawMenu(armory, armoryData, type)
					end
					
					Wait(1000)
					isBusy = false
				end, armory, type, itemId, amount)
			else
				WithdrawMenu(armory, armoryData, type)
			end
		else
			ESX.ShowNotification('Dont spam')
		end
	end,
	function(data, menu)
		menu.close()
	end)
end