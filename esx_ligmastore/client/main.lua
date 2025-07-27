
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}



local PlayerData                = {}


local currentBucket 			= math.floor(0)
local currentBucketName 		= "default"

ESX                             = nil

local currentArmory 			= ""

local enableField 				= false
local ArmoriesByCategory		= {}
local MarkersInRange			= {}
local MarkerIsIn				= nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	
	while ESX.GetPlayerData().identifier == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	ESX.PlayerData = ESX.GetPlayerData()
	
	while Config == nil do
		Wait(0)
	end
	
	ArmoriesByCategory.motels = {}
	ArmoriesByCategory.nProperties = {}
	ArmoriesByCategory.job = {}
	ArmoriesByCategory.personal = {}
end)

AddEventHandler('buckets:onBucketChanged', function(bucketId, bucketName)
	currentBucket = bucketId
	currentBucketName = bucketName
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if ArmoriesByCategory.job then 
		ArmoriesByCategory.job[ESX.PlayerData.job.name] = nil
	end
	PlayerData.job = job
	ESX.PlayerData.job = job

end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    
    for k,v in ipairs(PlayerData.accounts) do
		if v.name == account.name then
			PlayerData.accounts[k] = account
			break
		end
	end

end)

RegisterNetEvent('esx_ligmastore:getLocations')
AddEventHandler('esx_ligmastore:getLocations', function(motels,personals,nProperties,jobArmories)
	print('Got Armory Locations')
	for name,armory in pairs(motels) do 
		addArmoryToItsCategory(name,armory)
	end
	for name,armory in pairs(personals) do
		armory.job = ESX.PlayerData.identifier
		addArmoryToItsCategory(name,armory)
	end
	for name,armory in pairs(nProperties) do 
		addArmoryToItsCategory(name,armory)
	end
	for name,armory in pairs(jobArmories) do 
		addArmoryToItsCategory(name,armory)
	end
	print('All Armories in categories')
end)

RegisterNetEvent('esx_ligmastore:updateCoords')
AddEventHandler('esx_ligmastore:updateCoords', function(name, job, coords)
	if not string.find(job, 'steam:') then
		if ArmoriesByCategory.personal[job] == nil then
			ArmoriesByCategory.personal[job] = {}
		end
		
		ArmoriesByCategory.personal[job][name].coords = coords
	else
		if ArmoriesByCategory.personal[ESX.PlayerData.identifier] == nil then
			ArmoriesByCategory.personal[ESX.PlayerData.identifier] = {}
		end

		if ArmoriesByCategory.personal[ESX.PlayerData.identifier][name] then
			ArmoriesByCategory.personal[ESX.PlayerData.identifier][name].coords = coords
		end
	end
end)

RegisterNetEvent('esx_ligmastore:updateWhitelist')
AddEventHandler('esx_ligmastore:updateWhitelist', function(name, armory)
	if ArmoriesByCategory.personal[ESX.PlayerData.identifier] == nil then
		ArmoriesByCategory.personal[ESX.PlayerData.identifier] = {}
	end
	ArmoriesByCategory.personal[ESX.PlayerData.identifier][name] = armory

	MarkersInRange[name] = nil
end)

RegisterNetEvent('esx_ligmastore:update')
AddEventHandler('esx_ligmastore:update', function(name,newArmory)
	MarkersInRange = {}
	if newArmory or type(name) == 'table' then  --prosthiki armory
		Wait(1000) -- gia na ginei to setjob prwta
		if type(name) == 'table' then --ola ta armory you job tou (setjob edw)
			for k,v in pairs(name) do 
				addArmoryToItsCategory(k,v)
			end
		elseif ESX.PlayerData.identifier == newArmory.job then 
			addArmoryToItsCategory(name,newArmory)
		elseif ESX.PlayerData.job.name == newArmory.job then --update password edw
			addArmoryToItsCategory(name,newArmory)
		end
	elseif newArmory == nil then 
		if ArmoriesByCategory.personal[name] then
			ArmoriesByCategory.personal[name] = nil
		end
		if ArmoriesByCategory.job[name] then
			ArmoriesByCategory.job[name] = nil
		end
		if ArmoriesByCategory.nProperties[name] then
			ArmoriesByCategory.nProperties[name] = nil
		end
		if ArmoriesByCategory.motels[name] then
			ArmoriesByCategory.motels[name] = nil
		end
	end
end)

RegisterNetEvent('esx_ligmastore:armoryRequests')
AddEventHandler('esx_ligmastore:armoryRequests', function(requests, timestamp)
	local elements = {}
	
	for k,v in pairs(requests) do
		for sid,y in pairs(v) do
			if y.expire < (timestamp + 30) then
				table.insert(elements, {label = y.name..' for '..y.label, value = k, sid = sid})
			end
		end
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'temporary_use_armory_request', {
		title    = 'Temporary Use Armory Request',
		align    = 'bottom-right',
		elements = elements,
	},
	function(data, menu)
		menu.close()
		
		if exports['dialog']:Decision('Armory', 'Let '..data.current.label..' use temporary the armory for '..Config.TempUseArmoryDuration..' minute(s)?', '', 'YES', 'NO').action == 'submit' then
			TriggerServerEvent('esx_ligmastore:acceptArmoryRequest', data.current.value, data.current.sid)
		end
	end,
	function(data, menu)
		menu.close()
	end)
end)

RegisterCommand('personal_armories', function(source, args)
	if GetVehiclePedIsIn(PlayerPedId(), false) > 0 or GetPedConfigFlag(PlayerPedId(), 120, false) or IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) or IsEntityDead(PlayerPedId()) then
		return
	end
	
	ESX.TriggerServerCallback('esx_ligmastore:hasRemotePersonalArmoryAccess', function(cb)
		if not cb then
			ESX.ShowNotification('You don\'t have access to use this command')
			return
		end
		
		if not ArmoriesByCategory.personal[ESX.PlayerData.identifier] then
			ESX.ShowNotification('You don\'t have personal armories')
			return
		end
		
		local elements = {}
		
		for k,v in pairs(ArmoriesByCategory.personal[ESX.PlayerData.identifier]) do
			table.insert(elements, {label = v.nickname or v.label, value = v})
		end
		
		ESX.UI.Menu.CloseAll()
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'personal_armories', {
			title    = 'Personal Armories',
			align    = 'bottom-right',
			elements = elements,
		},
		function(data, menu)
			menu.close()
			OpenArmoryMenu(data.current.value, GetEntityCoords(PlayerPedId()))
		end,
		function(data, menu)
			menu.close()
		end)
	end)
end)

local PasswordNeeded = {}

CreateThread(function()
	while ArmoriesByCategory.motels == nil do Wait(0) end -- perimenw na loadarei server
	checkMarkersInRange()
end)

function checkMarkersInRange()
	while true do 
		local ped_coords = GetEntityCoords(PlayerPedId())
		for category,armoriesInCategory in pairs(ArmoriesByCategory) do
			local mycategory = armoriesInCategory[ESX.PlayerData.identifier] or armoriesInCategory[ESX.PlayerData.job.name]
			if mycategory then
				for armoryName,armory in pairs(mycategory) do
					local armory_coords = load("return "..armory.coords)()
					if #(ped_coords - armory_coords) <= Config.DrawDistance then 
						if MarkersInRange[armoryName] == nil then
							if CanDrawMarker(armoryName,armory.job) then
								MarkersInRange[armoryName] = armory

								StartDrawing(armoryName)
							end							
						end
					else
						MarkersInRange[armoryName] = nil
					end
					Wait(100)
				end
			end
		end
		Wait(3000)
	end
end

function StartDrawing(armoryName)
	CreateThread(function()
		while MarkersInRange[armoryName] do 
			local armory = MarkersInRange[armoryName]
			local armory_coords = load("return "..armory.coords)()
			--exports['textui']:Draw3DUI('E', 'Armory', armory_coords, 25.0)
			DrawMarker(Config.Markers.Type, armory_coords.x, armory_coords.y, armory_coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Markers.Size.x, Config.Markers.Size.y, Config.Markers.Size.z, Config.Markers.Colour.r, Config.Markers.Colour.g, Config.Markers.Colour.b, math.floor(100), false, true, math.floor(2), false, false, false, false)
			if #(GetEntityCoords(PlayerPedId()) - armory_coords) <= 1.5 then 
				SetTextComponentFormat('STRING')
				AddTextComponentString("Press ~INPUT_CONTEXT~ to Open "..(armory.nickname or armory.label))
				DisplayHelpTextFromStringLabel(math.floor(0), math.floor(0), math.floor(1), math.floor(-1))
				
				if IsControlJustPressed(math.floor(0),  math.floor(Keys['E'])) then
					local elements = {
						{label = "Access Armory", value = "access_armory"},
						--{label = "Exchange Weapons", value = "exchange_weapons"},
						--{label = "Trade Weapon to Blueprint", value = "convert_blueprint"},
					}

					if getArmoryCategory(armoryName, armory) == 'personal' then
						table.insert(elements, {label = "Add whitelist members", value = "add_whitelist"})
						table.insert(elements, {label = "Remove whitelist members", value = "remove_whitelist"})
						table.insert(elements, {label = "Remove my whitelist", value = "remove_my_whitelist"})
						table.insert(elements, {label = "Withdraw logs", value = "withdraw_logs"})
						table.insert(elements, {label = "Give Weapons for DC", value = "destroy_weapons"})
						table.insert(elements, {label = "Add Nickname", value = "add_nickname"})
						table.insert(elements, {label = "Deposit All", value = "deposit_all"})
					end

					if string.find(ESX.PlayerData.job.name, "criminaljob") then
						--table.insert(elements, {label = "Exchange weapons", value = "exchange"})
					end

					local pdata = ESX.GetPlayerData()
                    local inventory = pdata.inventory
					local canMove = false
					local action
					for k,v in pairs(inventory) do
						if k == Config.MoveArmoryItem and v.count > 0 then
							canMove = true
							break
						end
					end

					if canMove then
						table.insert(elements, {label = "Move Armory", value = "move_armory"})
					end
					
					TriggerEvent('devmode:copytext', armory.name)

					ESX.UI.Menu.CloseAll()
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_option', {
						title    = armory.nickname or armory.label,
						align    = 'bottom-right',
						elements = elements
					}, function(data, menu)
						action = data.current.value
						menu.close()
					end,function(data,menu)
						action = 'none'
						menu.close()
					end)
					while action == nil do Wait(100) end

					if action == 'access_armory' then
						if armory.password ~= nil and armory.password ~= 0 and PasswordNeeded[armory.id] == nil then
							if exports['dialog']:Decision('Armory', 'What you want to do?', '', 'USE ARMORY', 'CHANGE ARMORY PASSWORD').action == 'submit' then
								toggleField(true,armory)
							else
								local pass = tonumber(exports['dialog']:Create('Armory', 'Enter new password').value)
								
								if pass and pass >= math.floor(1000) and pass <= math.floor(9999) then
									TriggerServerEvent('esx_ligmastore:newPassword', armory.name, pass)
								else
									ESX.ShowNotification('Password must be numbers 4 digits')
								end
							end
						else
							OpenArmoryMenu(armory)
						end
					elseif action == 'exchange' then
						TriggerEvent("exchangeWeapons:openMenu")
					elseif action == 'add_whitelist' then
						addWhitelistMembers(armoryName)
					elseif action == 'remove_whitelist' then
						removeWhitelistMembers(armoryName)
					elseif action == 'remove_my_whitelist' then
						TriggerServerEvent('esx_ligmastore:removeMyWhitelist', armoryName)
					elseif action == 'withdraw_logs' then
						TriggerServerEvent('esx_ligmastore:withdrawLogs', armoryName)
					elseif action == 'destroy_weapons' then
						TriggerServerEvent('esx_ligmastore:getWeaponsForDestroy', armoryName)
					elseif action == 'add_nickname' then
						local nickname = exports['dialog']:Create('Armory', 'Enter Nickname').value or ''

						if string.len(nickname) > 0 and string.len(nickname) < 32 then
							TriggerServerEvent('esx_ligmastore:changeNickname', armoryName, nickname)
						end
					elseif action == 'move_armory' then
						TriggerServerEvent('esx_ligmastore:moveArmory', armoryName)
					elseif action == 'deposit_all' then
						DepositAll(armory)
					elseif action == 'convert_blueprint' then
						--OpenConvertBlueprintMenu()
					elseif action == 'exchange_weapons' then
						exports['exchangeWeapons']:openMenu()
					end
				end
			end
			Wait(0)
		end
	end)
end

function DepositAll(armory)
	TriggerEvent('closeInventory')
	
	for k,v in pairs(ESX.GetPlayerData().inventory) do
		local invPromise = promise.new()

		ESX.TriggerServerCallback('esx_ligmastore:addItem', function()
			invPromise:resolve()
		end, armory.name, armory.job, v.name, v.count, 'standard_item')

		Citizen.Await(invPromise)
	end

	ESX.ShowNotification('Done')
end

RegisterNetEvent('esx_ligmastore:getWeaponsForDestroy')
AddEventHandler('esx_ligmastore:getWeaponsForDestroy', function(items, armory)
	local elements = {}
	
	for k,v in pairs(Config.WeaponsForDestroy) do
		table.insert(elements, {label = k..' x'..(items[k] or 0), value = k})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_weapons_for_dc', {
		title    = 'Give Weapons for DC',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		local amount = tonumber(exports['dialog']:Create('Give Weapons for DC', 'Enter amount, must be x2').value) or 0
		
		if amount > 0 and amount%2 == 0 and amount <= (items[data.current.value] or 0) then
			menu.close()
			TriggerServerEvent('esx_ligmastore:destroyWeapon', data.current.value, amount, armory)
		end
	end,
	function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('esx_ligmastore:withdrawLogs')
AddEventHandler('esx_ligmastore:withdrawLogs', function(logs)
	local elements = {}
	
	for k,v in ipairs(logs or {}) do
		table.insert(elements, {label = v})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'withdraw_logs', {
		title    = 'Withdraw Logs',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		menu.close()
	end,
	function(data, menu)
		menu.close()
	end)
end)

function CanDrawMarker(armoryName, jobName)
	if string.find(jobName, 'steam:') and not string.find(armoryName, 'Armory') and jobName == ESX.PlayerData.identifier then --motel
		if currentBucketName == armoryName then
			return true
		end
	end
	if currentBucket > math.floor(0) and currentBucketName == jobName then
		if ESX.PlayerData.identifier == jobName or ESX.PlayerData.job.name == jobName then
			return true
		else
			return false 
		end
	end
	if currentBucket == math.floor(0) then
		if ESX.PlayerData.identifier == jobName or ESX.PlayerData.job.name == jobName or ArmoriesByCategory.personal[ESX.PlayerData.identifier][armoryName].whitelist[ESX.PlayerData.identifier] then
			return true
		else
			return false 
		end
	end
	if ESX.PlayerData.job then
		if armoryName == ESX.PlayerData.job.name then
			return true
		end
	end
	return false
end

function OpenConvertBlueprintMenu()
	local action
	local elements = {}

	local data = ESX.GetPlayerData()
	weapons = data.loadout
	for key, value in pairs(weapons) do
		if weapons[key].name ~= 'WEAPON_UNARMED' then
			table.insert(elements, {label = weapons[key].label, value = weapons[key].name})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'convert_blueprint', {
		title    = 'Trade Blueprint',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		action = data.current.value
		menu.close()
	end,function(data,menu)
		action = 'none'
		menu.close()
	end)
	while action == nil do Wait(100) end

	TriggerServerEvent('esx_ligmastore:convertBlueprint', action)
end

function addWhitelistMembers(armoryName)
	local id = KeyboardInput("Insert Player Id")
	TriggerServerEvent('esx_ligmastore:addWhitelistMember', armoryName, id)
end

function removeWhitelistMembers(armoryName)
	local whitelistMembers
	ESX.TriggerServerCallback('esx_ligmastore:getWhitelistMembers', function(members)
		whitelistMembers = members
	end, armoryName)
	
	while whitelistMembers == nil do Wait(100) end

	if whitelistMembers == 'none' then return end

	local steamid
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'whitelist_members', {
		title    = 'Whitelist Members',
		align    = 'bottom-right',
		elements = whitelistMembers
	}, function(data, menu)
		steamid = data.current.value
		menu.close()
	end,function(data,menu)
		steamid = 'none'
		menu.close()
	end)
	while steamid == nil do Wait(100) end

	if steamid == 'none' then return end

	TriggerServerEvent('esx_ligmastore:removeWhitelistMember', armoryName, steamid)
end

function KeyboardInput(TextEntry)
	local answer
	ESX.UI.Menu.Open(
		'dialog', GetCurrentResourceName(), TextEntry,
		{
			title = TextEntry,
		},
	function (data, menu)
		menu.close()
		if data.value ~= nil then
			answer = tostring(data.value)
		else
			answer = "0"
		end
	end,
	function (data, menu)
		menu.close()
		answer = "0"
	end)

	while answer == nil do Wait(100) end

	return answer
end

function OpenArmoryMenu(armory, bypassCoords)
	ClearPedTasksImmediately(PlayerPedId())
	PlayerData = ESX.GetPlayerData()
	inventory = PlayerData.inventory
	
	loadout = PlayerData.loadout
	local content = getArmory(armory)
	if content == "opened" then 
		ESX.ShowNotification("Armory is opened by another player!!")
		return 
	end
	local totalItems = math.floor(0) 
	for k,v in pairs(content) do 
		totalItems = totalItems + math.floor(1)
	end
	local maxItems = math.floor(0)
	if string.find(armory.name,"property") then
		maxItems = Config.PropertyGeneralLimit 
	elseif string.find(armory.name,"motel_") then
		maxItems = Config.MotelGeneralLimit 
	else
		maxItems = Config.GeneralLimit 
	end
	if Config.CustomCapacity[armory.name] then 
		maxItems = Config.CustomCapacity[armory.name]
	end
	startSecurity(armory, bypassCoords)
	local newLabel = armory.label
	newLabel = string.gsub(newLabel,ESX.PlayerData.identifier,"")
	newLabel = string.gsub(newLabel,"_"," ")

	table.sort(content, function(a, b) return a.count > b.count end) --Sort Items

	exports['esx_inventoryhud_matza']:OpenShop(content, 'esx_ligmastore:Cb',newLabel.."<div id='capacity'>Capacity: "..math.floor(totalItems).."/"..maxItems.."</div>", "armory")
	currentArmory = armory
end

RegisterNetEvent('esx_ligmastore:Cb')
AddEventHandler('esx_ligmastore:Cb', function(data,action)
	if action == "put" then 
		if data.item.wid or data.item.type == 'item_weapon' then --its weapon
			ESX.TriggerServerCallback('esx_ligmastore:addWeapon', function()
				OpenArmoryMenu(currentArmory)
			end, currentArmory.name,currentArmory.job, data.item.name,data.item.count,data.item.wid)		
		else
			local type = "standard_item"
			if data.item.name == "black_money" then 
				type = "black_money"
			end
			ESX.TriggerServerCallback('esx_ligmastore:addItem', function()
				OpenArmoryMenu(currentArmory)
			end, currentArmory.name,currentArmory.job,data.item.name,data.quantity,type)	
		end
	elseif action == "buy" then 
		if data.item.wid or data.item.type == 'item_weapon' then --its weapon
			ESX.TriggerServerCallback('esx_ligmastore:removeArmoryWeapon', function()
				OpenArmoryMenu(currentArmory)
			end, currentArmory.name,currentArmory.job, data.item.name,data.item.count,data.item.wid)		
		else
			local type = "standard_item"
			if data.item.name == "black_money" then 
				type = "black_money"
			end
			ESX.TriggerServerCallback('esx_ligmastore:removeItem', function()
				OpenArmoryMenu(currentArmory)
			end,currentArmory.name,currentArmory.job,data.item.name,data.quantity,type)
		end
	elseif action == "depositall" then 
		ESX.TriggerServerCallback('esx_ligmastore:addAll', function()
			OpenArmoryMenu(currentArmory)
		end, currentArmory.name,currentArmory.job)
	end
end)

function getArmory(armory)
	local answer = nil 
	ESX.TriggerServerCallback('esx_ligmastore:getArmoryContent', function(weapons,itemsAndBlack)
		if weapons == nil and itemsAndBlack == nil then 
			answer = "opened"
			return 
		end
		local tmp = {}

		local sortBlueprints = {}
		local sortWeapons = {}
		local sortItems = {}
		for i=1, #weapons, 1 do
			table.insert(sortWeapons, {
				label = ESX.GetWeaponLabel(weapons[i].weaponName) or weapons[i].weaponName,
				name = weapons[i].weaponName,
				count = weapons[i].ammo,
				durability = weapons[i].weapondurability,
				id = weapons[i].id
			})
		end

		for k,v in pairs(itemsAndBlack) do
			if v.quantity > 0 then
				if string.find(k, 'blueprint_') then
					table.insert(sortBlueprints, {
						label = ESX.GetItemLabel(k),
						name = k,
						count = v.quantity,
						type = v.type
					})
				else
					table.insert(sortItems, {
						label = ESX.GetItemLabel(k),
						name = k,
						count = v.quantity,
						type = v.type
					})
				end
			end
		end

		table.sort(sortBlueprints, function(a, b) return a.label:lower() < b.label:lower() end)
		table.sort(sortWeapons, function(a, b) return a.label:lower() < b.label:lower() end)
		table.sort(sortItems, function(a, b) return a.label:lower() < b.label:lower() end)

		for k,v in ipairs(sortBlueprints) do
			table.insert(tmp, v)
		end

		for k,v in ipairs(sortWeapons) do
			table.insert(tmp, v)
		end

		for k,v in ipairs(sortItems) do
			table.insert(tmp, v)
		end

		answer = tmp
	end,armory,true,true)
	while answer == nil do 
		Wait(0)
	end
	return answer
end

function startSecurity(armory, bypassCoords)
	if not exports.esx_inventoryhud_matza:isAnyUIOpen() then
		Wait(500)
		TriggerServerEvent("esx_ligmastore:setstatus", armory,true)
		CreateThread(function()
			TriggerEvent('vMenu:enableMenu', false)
			
			while exports.esx_inventoryhud_matza:isAnyUIOpen() do 
				Wait(0)
				local coords = GetEntityCoords(PlayerPedId())
				DisableControlAction(math.floor(0), math.floor(289))
				ESX.UI.Menu.CloseAll()
				if IsEntityPlayingAnim(PlayerPedId(), "random@mugging3", "handsup_standing_base", math.floor(3)) then
					ClearPedTasksImmediately(PlayerPedId())
				end
				local armory_coords = bypassCoords or load("return "..armory.coords)()
				if #( coords - armory_coords ) > 3 then
					TriggerEvent("closeInventory")
				end
			end
			TriggerEvent('vMenu:enableMenu', true)
			TriggerServerEvent("esx_ligmastore:setstatus", armory,false)
		end)

		CreateThread(function()
			while exports.esx_inventoryhud_matza:isAnyUIOpen() do
				Wait(500)
				local veh , distance = ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
				if distance < 5 then
					ESX.ShowNotification("You can't open armory with a vehicle nearby")
					TriggerEvent("closeInventory")
				end
			end
		end)
	end
end


function toggleField(enable,action)

	SetNuiFocus(enable, enable)
	enableField = enable
	if enable then
		SendNUIMessage({

			type = "enableui",
			enable = enable,
			action = action
		})
	else
		SendNUIMessage({
			type = "enableui",
			enable = enable,
			action = "none"
		})
	end

end

RegisterNUICallback('try', function(data, cb)

	toggleField(false)
    
	local code = data.code
	local action = data.action
	if tonumber(code) == tonumber(action.password) then
		PasswordNeeded[action.id or GetGameTimer()] = true
		OpenArmoryMenu(action)
		isInMarker = nil
	else
		ESX.ShowNotification("Wrong Password")
	end
	
    cb('ok')
end)

RegisterNUICallback('escape', function(data, cb)

    toggleField(false)
    SetNuiFocus(false, false)


    cb('ok')
end)


AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	
	toggleField(false)
end)



function addArmoryToItsCategory(armoryName,armory)
	if armory.job == ESX.PlayerData.identifier or ESX.PlayerData.job.name == armory.job or armory.whitelist[ESX.PlayerData.identifier] then
		if string.find(armoryName,"motel") then 
			if ArmoriesByCategory.motels[armory.job] == nil then 
				ArmoriesByCategory.motels[armory.job] = {}
			end
			ArmoriesByCategory.motels[armory.job][armoryName] = armory
		elseif armory.label == 'your personal armory' then
			if ArmoriesByCategory.personal[armory.job] == nil then 
				ArmoriesByCategory.personal[armory.job] = {}
			end
			ArmoriesByCategory.personal[armory.job][armoryName] = armory
			
			local armory_coords = load("return "..armory.coords)()
			ArmoriesByCategory.personal[armory.job][armoryName].blip = CreatePersonalArmoryBlip(armory_coords)
		elseif string.find(armoryName,"property") and armory.label ~= 'your personal armory' then --nProperty
			if ArmoriesByCategory.nProperties[armory.job] == nil then 
				ArmoriesByCategory.nProperties[armory.job] = {}
			end
			ArmoriesByCategory.nProperties[armory.job][armoryName] = armory
		else --job armory
			if ArmoriesByCategory.job[armory.job] == nil then 
				ArmoriesByCategory.job[armory.job] = {}
			end
			ArmoriesByCategory.job[armory.job][armoryName] = armory
		end
	end
end

function removeArmoryFromItsCategory(armoryName,armory)
	if armory.job == ESX.PlayerData.identifier or ESX.PlayerData.job.name == armory.job then
		if string.find(armoryName,"motel") then 
			if ArmoriesByCategory.motel[armory.job] == nil then 
				ArmoriesByCategory.motel[armory.job] = {}
			end
			ArmoriesByCategory.motel[armory.job][armoryName] = nil
		elseif armory.label == 'your personal armory' then
			if ArmoriesByCategory.personal[armory.job] == nil then 
				ArmoriesByCategory.personal[armory.job] = {}
			end
			
			if ArmoriesByCategory.personal[armory.job][armoryName] and DoesBlipExist(ArmoriesByCategory.personal[armory.job][armoryName].blip) then
				RemoveBlip(ArmoriesByCategory.personal[armory.job][armoryName].blip)
			end
			
			ArmoriesByCategory.personal[armory.job][armoryName] = nil
		elseif string.find(armoryName,"property") and armory.label ~= 'your personal armory' then --nProperty
			if ArmoriesByCategory.nProperties[armory.job] == nil then 
				ArmoriesByCategory.nProperties[armory.job] = {}
			end
			ArmoriesByCategory.nProperties[armory.job][armoryName] = nil
		else --job armory
			if ArmoriesByCategory.job[armory.job] == nil then 
				ArmoriesByCategory.job[armory.job] = {}
			end
			ArmoriesByCategory.job[armory.job][armoryName] = nil
		end
	end
end

function getArmoryCategory(armoryName,armory)
	if string.find(armoryName,"motel") then 
		return 'motel'
	elseif armory.label == 'your personal armory' then
		return 'personal'
	elseif string.find(armoryName,"property") and armory.label ~= 'your personal armory' then --nProperty
		return 'nProperties'
	else --job armory
		return 'job'
	end
end

function CreatePersonalArmoryBlip(coords)
	local blip = AddBlipForCoord(coords)
	SetBlipSprite(blip, 478)
	SetBlipScale(blip, 0.7)
	SetBlipColour(blip, 5)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Personal Armory')
	EndTextCommandSetBlipName(blip)
	
	return blip
end

RegisterCommand('myarmory', function()
	local elements = {}
	for armoryName,armory in pairs(ArmoriesByCategory.personal[ESX.PlayerData.identifier]) do
		local armory_coords = load("return "..armory.coords)()

		table.insert(elements, {label = armory.nickname or armory.label, coords = armory_coords})
	end

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'my_armories', {
		title    = 'My Armories',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		coords = data.current.coords

		ClearGpsPlayerWaypoint()
		SetNewWaypoint(coords.x, coords.y)
	end,function(data,menu)
		menu.close()
	end)
end)

RegisterCommand('changemyarmory', function()
	local elements = {}
	
	for armoryName,armory in pairs(ArmoriesByCategory.personal[ESX.PlayerData.identifier]) do
		local armory_coords = load("return "..armory.coords)()
		table.insert(elements, {label = armory.label, value = armoryName})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'change_my_armories', {
		title    = 'Change My Armories',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		menu.close()
		
		if GetSelectedPedWeapon(PlayerPedId()) == `WEAPON_UNARMED` then
			TriggerServerEvent('esx_ligmastore:changeMyArmory', data.current.value)
		end
	end,function(data,menu)
		menu.close()
	end)
end)

exports('GetPersonalArmories', function()
	return ArmoriesByCategory.personal
end)

exports('GetMotelArmories', function()
	return ArmoriesByCategory.motel
end)

exports('isExist', function(job)
    for category,armoriesInCategory in pairs(ArmoriesByCategory) do
        local mycategory = armoriesInCategory[ESX.GetPlayerData().job.name]
        if mycategory then
            return load("return "..mycategory[ESX.GetPlayerData().job.name].coords)()
        end
    end
    return false
end)