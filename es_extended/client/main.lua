Citizen.CreateThread(function()
	StatSetInt(`MP0_SHOOTING_ABILITY`, 100, true)
	StatSetInt(`MP0_STRENGTH`, 50, true)
	StatSetInt(`MP0_STEALTH_ABILITY`, 50, true)
	StatSetInt(`MP0_FLYING_ABILITY`, 50, true)
	StatSetInt(`MP0_LUNG_CAPACITY`, 10, true)
	StatSetInt(`MP0_STAMINA`, 0, true)
	StatSetFloat(`MP0_PLAYER_MENTAL_STATE`, 0.0, true)
end)

local restoringLoadout = 0
local isPaused, isDead, pickups = false, false, {}
WeaponLabels = {}

local loadout = {}
local semaphore = false
local updateWeight = false

local durability = {}
local weaponHashToName = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if NetworkIsPlayerActive(PlayerId()) then
			TriggerServerEvent('esx:onPlayerJoined')
			break
		end
	end
end)

ESX.MaxWeight = Config.MaxWeight

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
	end
end


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
	ESX.PlayerLoaded = true
	ESX.PlayerData = playerData

	-- check if player is coming from loading screen
	if GetEntityModel(PlayerPedId()) == GetHashKey('PLAYER_ZERO') then
		local defaultModel = GetHashKey('a_m_y_stbla_02')
		RequestModel(defaultModel)

		while not HasModelLoaded(defaultModel) do
			Citizen.Wait(10)
		end

		SetPlayerModel(PlayerId(), defaultModel)
		SetPedDefaultComponentVariation(PlayerPedId())
		SetPedRandomComponentVariation(PlayerPedId(), true)
		SetModelAsNoLongerNeeded(defaultModel)
	end

	-- freeze the player
	FreezeEntityPosition(PlayerPedId(), true)

	-- enable PVP
	SetCanAttackFriendly(PlayerPedId(), true, false)
	NetworkSetFriendlyFireOption(true)

	-- disable wanted level
	ClearPlayerWantedLevel(PlayerId())
	SetMaxWantedLevel(0)

	if Config.EnableHud then
		for k,v in ipairs(playerData.accounts) do
			local accountTpl = '<div><img src="img/accounts/' .. v.name .. '.png"/>&nbsp;{{money}}</div>'
			ESX.UI.HUD.RegisterElement('account_' .. v.name, k, 0, accountTpl, {money = ESX.Math.GroupDigits(v.money)})
		end

		local jobTpl = '<div>{{job_label}} - {{grade_label}}</div>'

		if playerData.job.grade_label == '' or playerData.job.grade_label == playerData.job.label then
			jobTpl = '<div>{{job_label}}</div>'
		end

		ESX.UI.HUD.RegisterElement('job', #playerData.accounts, 0, jobTpl, {
			job_label = playerData.job.label,
			grade_label = playerData.job.grade_label
		})
	end
	Wait(1000)
	print('ESX.Game.Teleport START')
	ESX.Game.Teleport(PlayerPedId(), {
		x = playerData.coords.x,
		y = playerData.coords.y,
		z = playerData.coords.z + 0.25,
		heading = playerData.coords.heading
	}, function()
		print('ESX.Game.Teleport DONE')
		TriggerServerEvent('esx:onPlayerSpawn'  )
		TriggerEvent('esx:onPlayerSpawn')
		TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
		Citizen.Wait(4000)
		ShutdownLoadingScreen()
		ShutdownLoadingScreenNui()
		FreezeEntityPosition(PlayerPedId(), false)
		GlobalState.hasPlayerSpawned = true
		DoScreenFadeIn(10000)
		StartServerSyncLoops()
	end)
	
	for i=1,#Config.Weapons,1 do
        WeaponLabels[Config.Weapons[i].name] = Config.Weapons[i].label
    end

	TriggerEvent('esx:loadingScreenOff')
	Wait(2000) --wait for loadout to be restored
	semaphore = true
	for k,v in pairs(Config.Weapons) do
		local weaponHash = GetHashKey(v.name)
		weaponHashToName[weaponHash] = v.name
		if HasPedGotWeapon(PlayerPedId(),  weaponHash,  false) and v.name ~= 'WEAPON_UNARMED' and v.name ~= 'WEAPON_PETROLCAN' then
			loadout[weaponHash] = GetPedAmmoTypeFromWeapon(PlayerPedId(),weaponHash)
		end
	end
	
	semaphore = false
	
	TriggerEvent('esx:restoreLoadout')
	if ESX.PlayerData.subscription then
		TriggerEvent("trew_hud_ui:togglesubscription",true)
	end
end)

RegisterNetEvent('esx:setMaxWeight')
AddEventHandler('esx:setMaxWeight', function(newMaxWeight) 
	ESX.PlayerData.maxWeight = newMaxWeight
end)


RegisterNetEvent('esx:setWeight')
AddEventHandler('esx:setWeight', function(weight)
	ESX.PlayerData.weight = weight
end)


RegisterNetEvent("esx:getxp")
AddEventHandler("esx:getxp", function(Exp)
	ESX.PlayerData.Experiences = Exp
end)

RegisterNetEvent('esx:onSetStat')
AddEventHandler('esx:onSetStat', function(stat, value)
	ESX.PlayerData.stats[stat] = value
end)

RegisterNetEvent("esx:getotherplayerdata")
AddEventHandler("esx:getotherplayerdata", function(data)

	ESX.OtherPlayerData = data

end)

RegisterNetEvent("esx:newotherplayerdata")
AddEventHandler("esx:newotherplayerdata", function(src,data)

	while ESX.OtherPlayerData == nil do 
		Wait(0)
	end
	ESX.OtherPlayerData[src] = data

end)

RegisterNetEvent("esx:othersetjob")
AddEventHandler("esx:othersetjob", function(id,job)

	if ESX.OtherPlayerData == nil then  -- auto mporei na ginei an mpoun polloi mazi tautoxrona
		ESX.OtherPlayerData = {}
	end
	if ESX.OtherPlayerData[id] == nil then
		ESX.OtherPlayerData[id] = {}
	end
	ESX.OtherPlayerData[id].job = job

end)


RegisterNetEvent("esx:othersetjob2")
AddEventHandler("esx:othersetjob2", function(id,job)

	if ESX.OtherPlayerData == nil then -- auto mporei na ginei an mpoun polloi mazi tautoxrona
		ESX.OtherPlayerData = {}
	end
	if ESX.OtherPlayerData[id] == nil then
		ESX.OtherPlayerData[id] = {}
	end
	ESX.OtherPlayerData[id].job2 = job

end)

RegisterNetEvent('esx:setWeaponPower')
AddEventHandler('esx:setWeaponPower', function(weaponName, power)
	for k,v in pairs(ESX.PlayerData.loadout) do
		if v.name == weaponName then
			ESX.PlayerData.loadout[k].power = power
			
			break
		end
	end
end)



RegisterNetEvent('esx:setWeaponPower')
AddEventHandler('esx:setWeaponPower', function(weaponName, power)
	for k,v in pairs(ESX.PlayerData.loadout) do
		if v.name == weaponName then
			ESX.PlayerData.loadout[k].power = power
			
			break
		end
	end
end)

RegisterNetEvent("esx:refreshxp")
AddEventHandler("esx:refreshxp", function(name,Exp)
    if ESX.PlayerData.Experiences == nil then
        ESX.PlayerData.Experiences = {}
    end
	
    ESX.PlayerData.Experiences[name] = Exp
end)

RegisterNetEvent("esx:getjobattributes")
AddEventHandler("esx:getjobattributes", function(attr)
	ESX.JobAttributes = attr
end)

RegisterNetEvent("esx:updatejobattributes")
AddEventHandler("esx:updatejobattributes", function(job,key,val)
	if ESX.JobAttributes == nil then
		ESX.JobAttributes = {}
	end
	
	if ESX.JobAttributes[job] == nil then
		ESX.JobAttributes[job] = {}
	end
	
	ESX.JobAttributes[job][key] = val
end)


RegisterNetEvent("esx:heartbeat")
AddEventHandler("esx:heartbeat", function()
	TriggerServerEvent("esx:antiremove"..GetPlayerServerId(PlayerId()))
end)

AddEventHandler('esx:onPlayerSpawn', function() isDead = false end)
AddEventHandler('esx:onPlayerDeath', function() isDead = true end)

AddEventHandler('skinchanger:modelLoaded', function()
	while not ESX.PlayerLoaded do
		Citizen.Wait(100)
	end

	TriggerEvent('esx:restoreLoadout')
end)

RegisterNetEvent("esx:refreshdurability")
AddEventHandler("esx:refreshdurability",function(myloadout)
	ESX.PlayerData.loadout = myloadout
	for k,v in ipairs(myloadout) do
		local weaponName = v.name
		local weaponHash = GetHashKey(weaponName)
		durability[weaponHash] = v.durability
	end
end)

RegisterNetEvent("esx:changedGroup")
AddEventHandler("esx:changedGroup",function(newGroup)
	ESX.PlayerData.group = newGroup

	TriggerEvent('es_admin:setGroup', newGroup)
end)

AddEventHandler('esx:restoreLoadout', function()
	if restoringLoadout == 0 then
		restoringLoadout = GetGameTimer() + 2000
		
		Citizen.CreateThread(function()
			while restoringLoadout ~= 0 do
				SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
				Wait(0)
			end
		end)
		
		while restoringLoadout > GetGameTimer() do
			Wait(100)
		end
		
		TriggerEvent('esx:restoringLoadout')
		
		ESX.TriggerServerCallback('esx:restoreLoadout', function(loadout)
			if loadout then
				local ammoTypes = {}
				
				for k,v in pairs(Config.Weapons) do
					local weaponHash = GetHashKey(v.name)
					
					if HasPedGotWeapon(PlayerPedId(), weaponHash, false) then
						RemoveWeaponFromPed(PlayerPedId(), weaponHash)
						SetPedAmmo(PlayerPedId(), weaponHash, 0)
					end
				end
				
				RemoveAllPedWeapons(PlayerPedId(), true)
				Wait(100)

				ESX.PlayerData.loadout = loadout
				
				for k,v in ipairs(ESX.PlayerData.loadout) do
					local weaponName = v.name
					local weaponHash = GetHashKey(weaponName)
					
					durability[weaponHash] = v.durability
					GiveWeaponToPed(PlayerPedId(), weaponHash, 0, false, false)
					SetPedWeaponTintIndex(PlayerPedId(), weaponHash, v.tintIndex)
					
					local ammoType = GetPedAmmoTypeFromWeapon(PlayerPedId(), weaponHash)
					
					SetPedAmmo(PlayerPedId(), weaponHash, 0)
					SetPedAmmoByType(PlayerPedId(), ammoType, 0)
					
					for k2, v2 in ipairs(v.components) do
						local com = ESX.GetWeaponComponent(weaponName, v2)
						if com then
							local componentHash = com.hash
							GiveWeaponComponentToPed(PlayerPedId(), weaponHash, componentHash)
						else
							print("Failed to give component "..v2.." for weapon "..weaponName)
						end
					end

					if ammoTypes[ammoType] == nil then
						ammoTypes[ammoType] = v.ammo

						--print('new', ammoType, v.ammo)
					end
				end
				
				for k, v in pairs(ammoTypes) do
					SetPedAmmoByType(PlayerPedId(), k, v)
				end
			end
			
			ESX.ShowNotification('Loadout restored')
			TriggerEvent('esx:loadoutRestored')
			Wait(2000)
			restoringLoadout = 0
		end)
	else
		restoringLoadout = GetGameTimer() + 2000
	end
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for k,v in ipairs(ESX.PlayerData.accounts) do
		if v.name == account.name then
			ESX.PlayerData.accounts[k] = account
			break
		end
	end

end)

RegisterNetEvent('esx:setDonateCoins')
AddEventHandler('esx:setDonateCoins', function(coins)
	ESX.PlayerData.donate_coins = coins
end)

RegisterNetEvent("esx:setItems")
AddEventHandler("esx:setItems",function(name,count,itemObj)

	local prevCounter = 0
	if ESX.PlayerData.inventory[name] then 
		prevCounter = ESX.PlayerData.inventory[name].count 
	end
	ESX.PlayerData.inventory[name] = itemObj
	if prevCounter > count then 
		ESX.UI.ShowInventoryItemNotification(false, ESX.PlayerData.inventory[name].label, prevCounter - count)
	elseif prevCounter < count then
		ESX.UI.ShowInventoryItemNotification(true, ESX.PlayerData.inventory[name].label, count - prevCounter)
	end
end)

RegisterNetEvent('esx:addWeaponItem')
AddEventHandler('esx:addWeaponItem', function(name)
	ESX.UI.ShowInventoryItemNotification(true, ESX.GetWeaponLabel(name), 1)
end)

RegisterNetEvent('esx:removeWeaponItem')
AddEventHandler('esx:removeWeaponItem', function(name)
	ESX.UI.ShowInventoryItemNotification(false, ESX.GetWeaponLabel(name), 1)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job)
	ESX.PlayerData.job2 = job
end)


RegisterNetEvent('esx:addWeapon')
AddEventHandler('esx:addWeapon', function(weaponName, ammo)
	while semaphore do
		Wait(0)
	end
	
	semaphore = true
	
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)
	local newAmmo = GetPedAmmoByType(playerPed, ammoType) + ammo
	
	GiveWeaponToPed(playerPed, weaponHash, newAmmo, false, false)
	SetPedAmmoByType(playerPed, ammoType, newAmmo)
	
	table.insert(ESX.PlayerData.loadout,{
		name = weaponName,
		ammo = newAmmo,
		label = ESX.GetWeaponLabel(weaponName),
		components = {}
	})
	
	local wIDs = {}
	
	for k, v in pairs(ESX.PlayerData.loadout) do
		if GetPedAmmoTypeFromWeapon(playerPed, GetHashKey(v.name)) == ammoType then
			v.ammo = newAmmo
			table.insert(wIDs, k)
		end
	end
	
	TriggerServerEvent('esx:updateWeaponAmmo', weaponName, newAmmo, wIDs)
	
	semaphore = false
	
	local invokingResource = GetInvokingResource() or 'es_extended'
	TriggerServerEvent('c_perms:esx', invokingResource, weaponName)
end)

RegisterNetEvent('esx:addWeaponComponent')
AddEventHandler('esx:addWeaponComponent', function(weaponName, weaponComponent)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

	GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
	for k,v in pairs(ESX.PlayerData.loadout) do
		if v.name == weaponName then
			table.insert(v.components,weaponComponent)
			break
		end
	end
end)

RegisterNetEvent('esx:setWeaponAmmocl')
AddEventHandler('esx:setWeaponAmmocl', function(weaponName, weaponAmmo)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)
	
	SetPedAmmo(playerPed, weaponHash, weaponAmmo)
	SetPedAmmoByType(playerPed, ammoType, weaponAmmo)
	
	for k, v in pairs(ESX.PlayerData.loadout) do
		if GetPedAmmoTypeFromWeapon(playerPed, GetHashKey(v.name)) == ammoType then
			v.ammo = weaponAmmo
		end
	end
end)

RegisterNetEvent('esx:setWeaponAmmo')
AddEventHandler('esx:setWeaponAmmo', function(weaponName, weaponAmmo)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)
	
	SetPedAmmo(playerPed, weaponHash, weaponAmmo)
	SetPedAmmoByType(playerPed, ammoType, weaponAmmo)
	
	local wIDs = {}
	
	for k, v in pairs(ESX.PlayerData.loadout) do
		if GetPedAmmoTypeFromWeapon(playerPed, GetHashKey(v.name)) == ammoType then
			v.ammo = weaponAmmo
			table.insert(wIDs, k)
		end
	end
	
	TriggerServerEvent('esx:updateWeaponAmmo', weaponName, weaponAmmo, wIDs)
end)

RegisterNetEvent('esx:setWeaponAmmohash')
AddEventHandler('esx:setWeaponAmmohash', function(hash, weaponAmmo)
	local playerPed = PlayerPedId()
	local weaponHash = hash
	local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)
	
	SetPedAmmo(playerPed, weaponHash, weaponAmmo)
	SetPedAmmoByType(playerPed, ammoType, weaponAmmo)
	
	local wIDs = {}
	
	for k, v in pairs(ESX.PlayerData.loadout) do
		if GetPedAmmoTypeFromWeapon(playerPed, GetHashKey(v.name)) == ammoType then
			v.ammo = weaponAmmo
			table.insert(wIDs, k)
		end
	end
	
	TriggerServerEvent('esx:updateWeaponAmmo', v.name, weaponAmmo, wIDs)
end)

RegisterNetEvent('esx:setWeaponTint')
AddEventHandler('esx:setWeaponTint', function(weaponName, weaponTintIndex)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

	SetPedWeaponTintIndex(playerPed, weaponHash, weaponTintIndex)
end)

RegisterNetEvent('esx:removeWeapon')
AddEventHandler('esx:removeWeapon', function(weaponName)
	while semaphore do
		Wait(0)
	end
	
	isRemoving = true
	semaphore = true
	
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)
	
	for i = 1 , #ESX.PlayerData.loadout do
		if ESX.PlayerData.loadout[i] then
			if ESX.PlayerData.loadout[i].name == weaponName then
				table.remove(ESX.PlayerData.loadout, i)
			end
		end
	end
	
	SetPedAmmo(playerPed, weaponHash, 0)
	SetPedAmmoByType(playerPed, ammoType, 0)
	
	semaphore = false
end)

RegisterNetEvent('esx:removeWeaponDone')
AddEventHandler('esx:removeWeaponDone', function(weaponName, data)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)
	
	ESX.PlayerData.loadout = data
	
	local wIDs = {}
	
	for k, v in pairs(ESX.PlayerData.loadout) do
		if GetPedAmmoTypeFromWeapon(playerPed, GetHashKey(v.name)) == ammoType then
			v.ammo = 0
			table.insert(wIDs, k)
		end
	end
	
	SetPedAmmo(playerPed, weaponHash, 0)
	SetPedAmmoByType(playerPed, ammoType, 0)
	
	TriggerEvent('esx:restoreLoadout')
	TriggerServerEvent('esx:updateWeaponAmmo', '', 0, wIDs)
end)

RegisterNetEvent('esx:removeWeaponComponent')
AddEventHandler('esx:removeWeaponComponent', function(weaponName, weaponComponent)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

	RemoveWeaponComponentFromPed(playerPed, weaponHash, componentHash)
	for k,v in pairs(ESX.PlayerData.loadout) do
		if v.name == weaponName then
			for i = 1, #v.components do
				if v.components[i] == weaponComponent then
					table.remove(v.components,i)
					break
				end
			end

			break
		end
	end
end)

RegisterNetEvent('esx:teleport')
AddEventHandler('esx:teleport', function(coords)
	local playerPed = PlayerPedId()

	-- ensure decmial number
	coords.x = coords.x + 0.0
	coords.y = coords.y + 0.0
	coords.z = coords.z + 0.0

	ESX.Game.Teleport(playerPed, coords)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	--[[ if Config.EnableHud then
		ESX.UI.HUD.UpdateElement('job', {
			job_label = job.label,
			grade_label = job.grade_label
		})
	end ]]
end)

RegisterNetEvent('esx:spawnVehicle')
AddEventHandler('esx:spawnVehicle', function(vehicleName)
	local model = (type(vehicleName) == 'number' and vehicleName or GetHashKey(vehicleName))

	if IsModelInCdimage(model) then
		local playerPed = PlayerPedId()
		local playerCoords, playerHeading = GetEntityCoords(playerPed), GetEntityHeading(playerPed)

		ESX.Game.SpawnVehicle(model, playerCoords, playerHeading, function(vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		end)
	else
		TriggerEvent('chat:addMessage', {args = {'^1SYSTEM', 'Invalid vehicle model.'}})
	end
end)

--[[ RegisterNetEvent('esx:createPickup')
AddEventHandler('esx:createPickup', function(pickupId, label, coords, type, name, components, tintIndex)
	local function setObjectProperties(object)
		SetEntityAsMissionEntity(object, true, false)
		PlaceObjectOnGroundProperly(object)
		FreezeEntityPosition(object, true)
		SetEntityCollision(object, false, true)

		pickups[pickupId] = {
			obj = object,
			label = label,
			inRange = false,
			coords = vector3(coords.x, coords.y, coords.z)
		}
	end

	if type == 'item_weapon' then
		local weaponHash = GetHashKey(name)
		ESX.Streaming.RequestWeaponAsset(weaponHash)
		local pickupObject = CreateWeaponObject(weaponHash, 50, coords.x, coords.y, coords.z, true, 1.0, 0)
		SetWeaponObjectTintIndex(pickupObject, tintIndex)

		for k,v in ipairs(components) do
			local component = ESX.GetWeaponComponent(name, v)
			GiveWeaponComponentToWeaponObject(pickupObject, component.hash)
		end

		setObjectProperties(pickupObject)
	else
		ESX.Game.SpawnLocalObject('prop_money_bag_01', coords, setObjectProperties)
	end
end) ]]

--[[ RegisterNetEvent('esx:createMissingPickups')
AddEventHandler('esx:createMissingPickups', function(missingPickups)
	for pickupId,pickup in pairs(missingPickups) do
		TriggerEvent('esx:createPickup', pickupId, pickup.label, pickup.coords, pickup.type, pickup.name, pickup.components, pickup.tintIndex)
	end
end) ]]

RegisterNetEvent('esx:registerSuggestions')
AddEventHandler('esx:registerSuggestions', function(registeredCommands)
	for name,command in pairs(registeredCommands) do
		if command.suggestion then
			TriggerEvent('chat:addSuggestion', ('/%s'):format(name), command.suggestion.help, command.suggestion.arguments)
		end
	end
end)

RegisterNetEvent('esx:removePickup')
AddEventHandler('esx:removePickup', function(pickupId)
	if pickups[pickupId] and pickups[pickupId].obj then
		ESX.Game.DeleteObject(pickups[pickupId].obj)
		pickups[pickupId] = nil
	end
end)

RegisterNetEvent('esx:deleteVehicle')
AddEventHandler('esx:deleteVehicle', function(radius)
	local playerPed = PlayerPedId()
	
	local toIgnore = {
		[`riot2`]		= true,
		[`journey`]		= true,
		[`barracks`]	= true,
		[`stockade`]	= true,
		[`frogger2`]	= true,
	}

	if radius and tonumber(radius) then
		radius = tonumber(radius) + 0.01
		local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(playerPed), radius)

		for k,entity in ipairs(vehicles) do
			local attempt = 0

			while not NetworkHasControlOfEntity(entity) and attempt < 100 and DoesEntityExist(entity) do
				Citizen.Wait(100)
				NetworkRequestControlOfEntity(entity)
				attempt = attempt + 1
			end

			if DoesEntityExist(entity) and NetworkHasControlOfEntity(entity) then
				if not toIgnore[GetEntityModel(entity)] then
					ESX.Game.DeleteVehicle(entity)
				end
			end
		end
	else
		local vehicle, attempt = ESX.Game.GetVehicleInDirection(), 0

		if IsPedInAnyVehicle(playerPed, true) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		end

		while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
			Citizen.Wait(100)
			NetworkRequestControlOfEntity(vehicle)
			attempt = attempt + 1
		end

		if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
			if not toIgnore[GetEntityModel(vehicle)] then
				ESX.Game.DeleteVehicle(vehicle)
			end
		end
	end
end)

-- Pause menu disables HUD display
--[[ if Config.EnableHud then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(300)

			if IsPauseMenuActive() and not isPaused then
				isPaused = true
				ESX.UI.HUD.SetDisplay(0.0)
			elseif not IsPauseMenuActive() and isPaused then
				isPaused = false
				ESX.UI.HUD.SetDisplay(1.0)
			end
		end
	end)

	AddEventHandler('esx:loadingScreenOff', function()
		ESX.UI.HUD.SetDisplay(1.0)
	end)
end ]]

function StartServerSyncLoops()
	-- keep track of ammo
	local lastShoot = 0
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			
			if isDead then
				Citizen.Wait(500)
			else
				local playerPed = PlayerPedId()
				
				if IsPedShooting(playerPed) then
					local _,weaponHash = GetCurrentPedWeapon(playerPed, true)
					local weapon = ESX.GetWeaponFromHash(weaponHash)
					
					if weapon then
						if lastShoot == 0 then
							Citizen.CreateThread(function()
								while lastShoot > GetGameTimer() do
									Wait(100)
								end
								
								local ammoCount = GetAmmoInPedWeapon(playerPed, weaponHash)
								
								if not Config.CountableWeapons[weaponHash] then
									TriggerEvent('esx:setWeaponAmmo', weapon.name, ammoCount)
								elseif ammoCount == 0 then
									TriggerServerEvent('esx:removeCountableWeapon', weapon.name)
								end
								
								lastShoot = 0
							end)
						end
						
						lastShoot = GetGameTimer() + 1250
					end
				end
			end
		end
	end)

	-- sync current player coords with server
	Citizen.CreateThread(function()
		Wait(5000)
		
		local nextUpdate = GetGameTimer() + 5000
		local previousCoords = vector3(ESX.PlayerData.coords.x, ESX.PlayerData.coords.y, ESX.PlayerData.coords.z)
		
		while true do
			local playerPed = PlayerPedId()
			
			if DoesEntityExist(playerPed) then
				local playerCoords = GetEntityCoords(playerPed)
				local distance = #(playerCoords - previousCoords)
				
				if distance > 1 then
					if distance > 100 then
						nextUpdate = 0
					end
					
					if nextUpdate < GetGameTimer() then
						nextUpdate = GetGameTimer() + 5000
						previousCoords = playerCoords
						
						local playerHeading = ESX.Math.Round(GetEntityHeading(playerPed), 1)
						local formattedCoords = {x = ESX.Math.Round(playerCoords.x, 1), y = ESX.Math.Round(playerCoords.y, 1), z = ESX.Math.Round(playerCoords.z, 1), heading = playerHeading}
						
						TriggerServerEvent('esx:updateCoords' , formattedCoords)
					end
				end
			end
			
			Citizen.Wait(500)
		end
	end)
	
	Citizen.CreateThread(function()
		Wait(5000)
		
		local lastBagId = -99
		local lastDecalId = -99
		
		while true do
			Citizen.Wait(5000)
			
			local playerPed = PlayerPedId()
			
			if DoesEntityExist(playerPed) then
				local bagId = GetPedDrawableVariation(PlayerPedId(), 5)	--Bag
				local decalId = GetPedDrawableVariation(PlayerPedId(), 10)	--Decals
				local hairId = GetPedDrawableVariation(PlayerPedId(), 2)	--Hair
				
				if GetEntityModel(PlayerPedId()) == `mp_m_freemode_01` then
					local helmetId = GetPedPropIndex(playerPed, 0)	--Helmet
					local lowerId  = GetPedDrawableVariation(PlayerPedId(), 4)	--Lower
					local shirtId  = GetPedDrawableVariation(PlayerPedId(), 11)	--ShirtOverlay
					
					if Config.BlacklistedHelmets[helmetId] then
						ClearPedProp(playerPed, 0)
					end
					
					if Config.BlacklistLower[lowerId] then
						SetPedComponentVariation(PlayerPedId(), 4, 0, 0, 0)
					end
					
					if Config.BlacklistShirtOverlay[shirtId] then
						SetPedComponentVariation(PlayerPedId(), 11, 0, 0, 0)
					end
					
					if Config.BlacklistedHair[hairId] then
						SetPedComponentVariation(PlayerPedId(), 2, 1, 1, 3)
					end
				end
				
				if bagId ~= lastBagId or decalId ~= lastDecalId or updateWeight then
					lastBagId = bagId
					lastDecalId = decalId
					updateWeight = false
					
					if GetEntityModel(PlayerPedId()) == `mp_m_freemode_01` then
						TriggerServerEvent('esx:backpack', bagId, decalId, 'male')
					elseif GetEntityModel(PlayerPedId()) == `mp_f_freemode_01` then
						TriggerServerEvent('esx:backpack', bagId, decalId, 'female')
					end
				end
			end
		end
	end)
end

RegisterNetEvent('esx:backpack')
AddEventHandler('esx:backpack',function()
	if GetEntityModel(PlayerPedId()) == `mp_m_freemode_01` then
		SetPedComponentVariation(PlayerPedId(), 5, 51, 0, 2)
	elseif GetEntityModel(PlayerPedId()) == `mp_f_freemode_01` then
		SetPedComponentVariation(PlayerPedId(), 5, 22, 0, 2)
	end
end)

--[[ Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, 289) then
			if IsInputDisabled(0) and not isDead and not ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
				ESX.ShowInventory()
			end
		end
	end
end) ]]

-- Pickups
--[[ Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local playerCoords, letSleep = GetEntityCoords(playerPed), true
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer(playerCoords)

		for pickupId,pickup in pairs(pickups) do
			local distance = #(playerCoords - pickup.coords)

			if distance < 5 then
				local label = pickup.label
				letSleep = false

				if distance < 1 then
					if IsControlJustReleased(0, 38) then
						if IsPedOnFoot(playerPed) and (closestDistance == -1 or closestDistance > 3) and not pickup.inRange then
							pickup.inRange = true

							local dict, anim = 'weapons@first_person@aim_rng@generic@projectile@sticky_bomb@', 'plant_floor'
							ESX.Streaming.RequestAnimDict(dict)
							TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
							Citizen.Wait(1000)

							TriggerServerEvent('esx:onPickup' , pickupId)
							PlaySoundFrontend(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
						end
					end

					label = ('%s~n~%s'):format(label, _U('threw_pickup_prompt'))
				end

				ESX.Game.Utils.DrawText3D({
					x = pickup.coords.x,
					y = pickup.coords.y,
					z = pickup.coords.z + 0.25
				}, label, 1.2, 1)
			elseif pickup.inRange then
				pickup.inRange = false
			end
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end) ]]

RegisterNetEvent('esx:showSubs')
AddEventHandler('esx:showSubs',function(subs)
	if #subs > 0 then
        local elements = {}
        table.insert(elements,{label = "<font color='yellow'>Όνομα   |   </font> <font color='green'>Κατηγορία   |   </font> <font color='orange'>Λήξη</font>", value = ""})
		for k,v in pairs(subs) do
            table.insert(elements,{label = "<font color='yellow'>"..v.name.."</font>    |   <font color='green'>"..v.category.."</font>    |   <font color='orange'>"..v.expireat.."</font>", value = v.identifier, name = v.name, category = v.category})
        end
        ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'subscriptions',
        {
            title    = 'Subscriptions',
            align    = 'center',
            elements = elements
        },
        function(data, menu)
            if data.current.value ~= "" then
                menu.close()
                local steamId = data.current.value
				local Name = data.current.name
				local id = data.current.id
				local category = data.current.category
                local Confirmation = {}
                table.insert(Confirmation,{label = "<font color='yellow'>ΝΑΙ</font>", value = "yes"})
                table.insert(Confirmation,{label = "<font color='green'>ΟΧΙ</font>", value = "no"})
                ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'ConfirmMenu',
                {
                    title    = 'Delete?',
                    align    = 'center',
                    elements = Confirmation
                },
                function(data1, menu1)
                    menu1.close()
					if data1.current.value == "yes" then
                        TriggerServerEvent('esx:deleteSubscriber' ,steamId,Name,category)
                        menu.close()
                    end
                end,
                function(data1,menu1)
                    menu1.close()
                end)
            end
        end,
        function(data,menu)
            menu.close()
        end)
	end
end)

function drawMessage(content)
	SetTextFont(math.floor(2))
	SetTextScale(0.40, 0.40)
	SetTextEntry("STRING")
	AddTextComponentString(content)
	DrawText(0.92, 0.95)
end


local bc = 0

RegisterNetEvent('esx:setbc')
AddEventHandler('esx:setbc', function(val)
	bc = val
	if bc == nil then
		bc = 0
	end

end)

RegisterNetEvent('esx:setattr')
AddEventHandler('esx:setattr', function(key,val)
	ESX.PlayerData.attributes[key] = val
end)

RegisterNetEvent('esx:updateWeight')
AddEventHandler('esx:updateWeight', function()
	updateWeight = true
end)

if Config.useBattleCoins == true then
	CreateThread(function()
		while true do
			local text = "~r~BC~w~ : "..bc
			SetTextScale(0.35, 0.35)
			SetTextFont(4)
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(text)
			local posX = 0.015
			local posY = 0.98
			EndTextCommandDisplayText(posX, posY)
			Wait(0)
		end
	end)
end



if Config.WeaponDurabillity then
	local previousDura = {}
	function savedurability()
		if ESX and ESX.PlayerData and ESX.PlayerData.loadout then
			if (ESX.PlayerData.subscription or '') ~= 'level4' then
				local found = false
				for k,v in pairs(ESX.PlayerData.loadout) do
					local weaponName = v.name
					local weaponHash = GetHashKey(weaponName)
					if durability[weaponHash] ~= previousDura[weaponName] then
						previousDura[weaponName] = durability[weaponHash]
						found = true
					end
				end
				if found then
					TriggerServerEvent("esx:setdura" ,previousDura)
				end
			end
		end
	
	end
	CreateThread(function()
	
		while true do
			savedurability()
			Wait(10000)
		end

	end)
	RegisterNetEvent("esx_setdurability")
	AddEventHandler("esx_setdurability",function(weaponName,dura)
		durability[GetHashKey(weaponName)] = dura
	end)

	RegisterNetEvent("esx_adddurability")
	AddEventHandler("esx_adddurability",function(weaponName,dura)
		if tonumber(durability[GetHashKey(weaponName)]) + tonumber(dura) > 100 then
			durability[GetHashKey(weaponName)] = 100
		else
			durability[GetHashKey(weaponName)] = tonumber(durability[GetHashKey(weaponName)]) + tonumber(dura)
		end
		
		savedurability()
	end)

	CreateThread(function()
		while true do
			local weapon = GetSelectedPedWeapon(PlayerPedId())
			if weapon ~= -1569615261 and weapon ~= 883325847 then
				if IsPedShooting(PlayerPedId()) then
					local weaponName = weaponHashToName[weapon]
					if weaponName == nil then
						weaponName = weapon
					end

					Config.WeaponDurabillityRates[weaponName] = 0.1

					--[[if Config.WeaponDurabillityRates[weaponName] == nil then
						Config.WeaponDurabillityRates[weaponName] = 0.1
					end]]
					if durability[weapon] then
						durability[weapon] = durability[weapon] - Config.WeaponDurabillityRates[weaponName]
						if durability[weapon] <= 0 then
							savedurability()
						end
					end
				end
				if durability[weapon] and durability[weapon] <= 0 then
					DisablePlayerFiring(PlayerPedId(),true)
					
				end
			end
			Wait(0)
		end
	end)
	--[[ CreateThread(function()
		while true do
			local weapon = GetSelectedPedWeapon(PlayerPedId())
			if weapon ~= -1569615261 then
				local format1 = '%.' .. 2 .. 'f'
				if durability[weapon] then
					local text 
					if durability[weapon] <= 0 then
						text = "~r~Weapon Durability~w~ : [~r~Broken~w~]"
					else
						text = "~r~Weapon Durability~w~ : ".. string.format(format1, durability[weapon])
					end
				
					SetTextScale(0.35, 0.35)
					SetTextFont(4)
					SetTextOutline()
					BeginTextCommandDisplayText('STRING')
					AddTextComponentSubstringPlayerName(text)
					local posX = 0.06
					local posY = 0.98
					EndTextCommandDisplayText(posX, posY)
				end
			end
			Wait(0)
		end
	end) ]]
end

RegisterNetEvent('esx:commandSetJob')
AddEventHandler('esx:commandSetJob', function(target, targetName, job, grade, label)
	if exports['dialog']:Decision('Setjob '..job..' '..grade..' ['..label..'] for '..targetName..' ['..target..'] ?', 'Are you sure?', '', 'YES', 'NO').action == 'submit' then
		TriggerServerEvent('esx:commandSetJob', target, job, grade)
	end
end)