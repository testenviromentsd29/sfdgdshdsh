ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	Wait(math.random(100, 3000))
	
	while GetGameTimer() < 30000 do
		Wait(1000)
	end
	
	--CheckMaou1()
	CheckMaou2()
	CheckMaou3()
	CheckMaou4()
	CheckMaou5()
end)

RegisterNetEvent('c_perms:showPermissions')
AddEventHandler('c_perms:showPermissions', function(permissions, names)
	local elements = {}
	
	for k,v in pairs(names) do
		table.insert(elements, {label = v..' ['..k..']', value = k})
	end
	
	table.sort(elements, function(a,b) return a.label < b.label end)
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'permissions', {
		title    = 'Permissions',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		ESX.UI.Menu.CloseAll()
		ManagePermissions(data.current.value, permissions[data.current.value], names[data.current.value])
	end,function(data, menu)
	   menu.close()
	end)
end)

function ManagePermissions(identifier, permissions, name)
	local elements = {}
	
	for k,v in pairs(Config.Permissions) do
		if permissions[k] then
			table.insert(elements, {label = '<span style="color:green;">'..k..'</span>', value = k})
		else
			table.insert(elements, {label = '<span style="color:red;">'..k..'</span>', value = k})
		end
	end
	
	table.sort(elements, function(a,b) return a.value < b.value end)
	
	table.insert(elements, {label = 'SAVE PERMISSIONS', value = 'save_permissions'})
	table.insert(elements, {label = 'DELETE PERMISSIONS', value = 'delete_permissions'})
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_permissions', {
		title    = 'Permissions of '..name,
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		menu.close()
		
		if data.current.value == 'save_permissions' then
			TriggerServerEvent('c_perms:savePermissions', identifier, permissions)
		elseif data.current.value == 'delete_permissions' then
			TriggerServerEvent('c_perms:deletePermissions', identifier)
		else
			if permissions[data.current.value] then
				permissions[data.current.value] = nil
			else
				permissions[data.current.value] = true
			end
			
			ManagePermissions(identifier, permissions, name)
		end
	end,function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('c_perms:armoryItems')
AddEventHandler('c_perms:armoryItems', function(data)
	local elements = {}
	
	for k,v in pairs(data) do
		table.insert(elements, {label = v.item_name..' <font color=\'red\'>x'..comma_value(v.total_items)..'</font>'})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_items', {
		title    = 'Armory Items',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		menu.close()
	end,function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('c_perms:armoryBlueprints')
AddEventHandler('c_perms:armoryBlueprints', function(data)
	local elements = {}
	
	for k,v in pairs(data) do
		table.insert(elements, {label = v.item_name..' <font color=\'red\'>x'..comma_value(v.total_weapons)..'</font>'})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_blueprints', {
		title    = 'Armory Blueprints',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		menu.close()
	end,function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('c_perms:armoryWeapons')
AddEventHandler('c_perms:armoryWeapons', function(data)
	local elements = {}
	
	for k,v in pairs(data) do
		table.insert(elements, {label = v.weapon..' <font color=\'red\'>x'..comma_value(v.total_weapons)..'</font>'})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_weapons', {
		title    = 'Armory Weapons',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		menu.close()
	end,function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('c_perms:playersMoney')
AddEventHandler('c_perms:playersMoney', function(data, account)
	local elements = {}
	
	for k,v in pairs(data) do
		table.insert(elements, {label = tostring(v.name)..' ['..v.group..'] <font color=\'red\'>x'..comma_value(v.account)..'</font>'..' '..account})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'players_money', {
		title    = 'Players '..account,
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		menu.close()
	end,function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('c_perms:playersCoins')
AddEventHandler('c_perms:playersCoins', function(data)
	local elements = {}
	
	for k,v in pairs(data) do
		table.insert(elements, {label = v.name..' ['..v.group..'] <font color=\'red\'>x'..comma_value(v.coins)..'</font>'})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'players_coins', {
		title    = 'Players Coins',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		menu.close()
	end,function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('c_perms:playersGmCoins')
AddEventHandler('c_perms:playersGmCoins', function(data)
	local elements = {}
	
	for k,v in pairs(data) do
		table.insert(elements, {label = v.name..' ['..v.group..'] <font color=\'red\'>x'..comma_value(v.coins)..'</font>'})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'players_coins', {
		title    = 'Players GM Coins',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		menu.close()
	end,function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('c_perms:searchPlayer')
AddEventHandler('c_perms:searchPlayer', function(data, playerName)
	local elements = {}
	
	local totalMinutes = 0
	
	for k,v in pairs(data) do
		totalMinutes = totalMinutes + v.minutes
		table.insert(elements, {label = 'Played: '..v.minutes..' minute(s) Logout: '..v.logout..''})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'search_player', {
		title    = playerName..' [Total Minutes: '..totalMinutes..']',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		menu.close()
	end,function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('c_perms:findPlayer')
AddEventHandler('c_perms:findPlayer', function(data)
	local elements = {}
	
	for k,v in pairs(data) do
		table.insert(elements, {label = v.identifier, value = v.identifier})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'find_player', {
		title    = 'Find Player',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		menu.close()
		TriggerEvent('devmode:copytext', data.current.value)
	end,function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('c_perms:findItem')
AddEventHandler('c_perms:findItem', function(data)
	local elements = {}
	
	for k,v in pairs(data) do
		table.insert(elements, {label = v.name..' ['..v.label..']', value = v.name})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'find_item', {
		title    = 'Find Item',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		menu.close()
		TriggerEvent('devmode:copytext', data.current.value)
	end,function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('c_perms:getNoobs')
AddEventHandler('c_perms:getNoobs', function(data)
	local elements = {}
	
	for k,v in pairs(data) do
		table.insert(elements, {label = v.name..' played: '..v.minutes..' minute(s)', value = v.minutes})
	end
	
	table.sort(elements, function(a,b) return a.value < b.value end)
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'get_noobs', {
		title    = 'Noobs',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		menu.close()
	end,function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('c_perms:searchJobLabel')
AddEventHandler('c_perms:searchJobLabel', function(data)
	local elements = {}
	
	for k,v in pairs(data) do
		table.insert(elements, {label = v.name..' ['..v.label..']'})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'search_job_label', {
		title    = 'Search Job Label',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		menu.close()
	end,function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('c_perms:onGiveVehicle')
AddEventHandler('c_perms:onGiveVehicle', function(model)
	if IsModelInCdimage(GetHashKey(model)) then
		local coords = GetEntityCoords(PlayerPedId())
		local vehicleSpawned = false
		
		Citizen.CreateThread(function()
			while not vehicleSpawned do
				DrawText2(0.01, 0.6, 0.52, 'Please wait to get the vehicle')
				Wait(0)
			end
		end)
		
		ESX.Game.SpawnLocalVehicle(model, vector3(coords.x, coords.y, coords.z - 10.0), 0.0, function(vehicle)
			vehicleSpawned = true
			
			local vehicleProps = exports['tp-garages']:GetVehicleProperties(vehicle)
			DeleteEntity(vehicle)
			TriggerServerEvent('c_perms:onGiveVehicle', vehicleProps)
		end)
	else
		TriggerServerEvent('c_perms:onGiveVehicle', {notfound = true})
	end
end)

exports('HasAccess', function(permission)
	local hasAccess
	
	ESX.TriggerServerCallback('c_perms:hasAccess', function(result) hasAccess = result end, permission)
	while hasAccess == nil do Wait(0) end
	
	return hasAccess
end)

function comma_value(amount)
	local formatted = amount
	
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		
		if (k == 0) then
			break
		end
	end
	
	return formatted
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

function CheckMaou1()
	local resources = {
		['esx-qalle-jail']			= 0,
		['esx_communityservice']	= 0,
	}
	
	Citizen.CreateThread(function()
		while true do
			for resourceName,_ in pairs(resources) do
				if GetResourceState(resourceName) ~= 'started' then
					resources[resourceName] = resources[resourceName] + 1
					
					if resources[resourceName] == 2 then
						TriggerServerEvent('c_perms:maou1', resourceName)
						break
					end
				end
			end
			
			Wait(5000)
		end
	end)
end

function CheckMaou2()
	local timesCaught = 0
	local cooldown = 0
	local group = ESX.GetPlayerData().group
	
	if group ~= 'user' then
		return
	end
	
	Citizen.CreateThread(function()
		while true do
			if GlobalState.inKillzone or GlobalState.inGungame or GlobalState.InCustomGame then
				cooldown = GetGameTimer() + 5000
			end
			
			if cooldown < GetGameTimer() then
				if GetPlayerInvincible(PlayerId()) and not GlobalState.inKillzone and not GlobalState.inGungame and not GlobalState.InCustomGame then
					local seconds = math.floor(GetGameTimer()/1000)
					
					if seconds > 90 then
						timesCaught = timesCaught + 1
						
						if timesCaught > 4 then
							TriggerServerEvent('c_perms:maou2', math.floor(GetGameTimer()/1000))
							break
						end
					end
				else
					timesCaught = 0
				end
			end
			
			Wait(1000)
		end
	end)
end

function CheckMaou3()
	local timesCaught = 0
	
	Citizen.CreateThread(function()
		while true do
			local modifier = GetPlayerWeaponDamageModifier(PlayerId())
			
			if modifier > 1.30 then
				timesCaught = timesCaught + 1
				
				if timesCaught > 2 then
					timesCaught = 0
					TriggerServerEvent('c_perms:maou3', modifier)
					
					Wait(5*60000)
				end
			end
			
			Wait(1000)
		end
	end)
end

function CheckMaou4()
	local group = ESX.GetPlayerData().group
	
	if group == 'user' then
		return
	end
	
	ExecuteCommand('god')
	
	if group == 'rookie' or group == 'helper' or group == 'supporter' or group == 'mod' then
		Citizen.CreateThread(function()
			while true do
				if GetSelectedPedWeapon(PlayerPedId()) ~= `WEAPON_UNARMED` then
					SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
				end
				
				Wait(1000)
			end
		end)
	end
end

function CheckMaou5()
	local loadout = {}
	local cooldown = 0
	
	RegisterNetEvent('esx:addWeapon')
	AddEventHandler('esx:addWeapon', function(weaponName, ammo)
		cooldown = GetGameTimer() + 2000
		loadout[GetHashKey(weaponName)] = weaponName
	end)
	
	RegisterNetEvent('esx:removeWeapon')
	AddEventHandler('esx:removeWeapon', function(weaponName)
		cooldown = GetGameTimer() + 2000
		loadout[GetHashKey(weaponName)] = nil
	end)
	
	Citizen.CreateThread(function()
		while ESX.GetPlayerData().loadout == nil do
			Wait(250)
		end
		
		for k,v in pairs(ESX.GetPlayerData().loadout) do
			loadout[GetHashKey(v.name)] = v.name
		end
		
		while true do
			Wait(1000)
			
			if GlobalState.inRange or GlobalState.inPubg or GlobalState.inGungame or GlobalState.InCustomGame or GlobalState.inFortnite or GlobalState.inPistolEvent or IsPedInAnyVehicle(PlayerPedId(), false) then
				cooldown = GetGameTimer() + 2000
			end
			
			if cooldown < GetGameTimer() then
				local weaponHash = GetSelectedPedWeapon(PlayerPedId())
				
				if loadout[weaponHash] == nil and weaponHash ~= `WEAPON_UNARMED` then
					TriggerEvent('esx:restoreLoadout')
				end
			end
		end
	end)
end