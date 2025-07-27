ESX = nil

local npcs = {}

local weaponAmmos = {}
local weaponLabels = {}
local buyCooldown = 0

local weaponTypes = {
	[-728555052]	= 'Melee',
	[416676503]		= 'Handgun',
	[-957766203]	= 'Submachine Gun',
	[860033945]		= 'Shotgun',
	[970310034]		= 'Assault Rifle',
	[1159398588]	= 'Light Machine Gun',
	[-1212426201]	= 'Sniper',
	[-1569042529]	= 'Heavy Weapon',
	[1548507267]	= 'Throwables',
	[1595662460]	= 'Misc',
}

local isBusy = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	local ammoTypes = ESX.GetAmmoTypes()
	
	for k,v in pairs(ESX.GetWeaponList()) do
		weaponLabels[v.name] = v.label
		
        if v.ammo and ammoTypes[v.ammo.hash] then
			weaponAmmos[v.name] = string.upper(string.gsub(ammoTypes[v.ammo.hash], 'AMMO_', '')..' ammo')
        end
    end
	
    InitScript()
end)

RegisterNetEvent('gunshop_night:buy')
AddEventHandler('gunshop_night:buy', function(item, gunshop)
	if not string.find(item, 'WEAPON_') then
		return
	end
	
	isBusy = true
	
	local clerkHandle = npcs[gunshop]
	local weaponHash = GetHashKey(item)
	
	RequestWeaponAsset(weaponHash, 31, 0)
    while not HasWeaponAssetLoaded(weaponHash) do Wait(0) end
	
	local pos = GetEntityCoords(clerkHandle)
	local weaponObject = CreateWeaponObject(weaponHash, 0, pos.x, pos.y, pos.z - 5.0, false, 0.0, false)
	RemoveWeaponAsset(weaponModel)
	FreezeEntityPosition(weaponObject, true)
	
	TaskTurnPedToFaceEntity(PlayerPedId(), clerkHandle, 500)
	
	GiveWeaponObjectToPed(weaponObject, clerkHandle)
	
	SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
	SetCurrentPedWeapon(clerkHandle, GetHashKey('WEAPON_UNARMED'), true)
	
	PlayAnimation(clerkHandle, 'mp_cop_armoury', 'pistol_on_counter_cop')
	Wait(1100)
	SetCurrentPedWeapon(clerkHandle, weaponHash, true)
	PlayAnimation(PlayerPedId(), 'mp_cop_armoury', 'pistol_on_counter')
	Wait(3100)
	RemoveWeaponFromPed(clerkHandle, weaponHash)
	Wait(60)
	--SetCurrentPedWeapon(PlayerPedId(), weaponHash, true)
	
	Wait(2000)
	
	isBusy = false
end)

RegisterNUICallback('get_weapon_data', function(data, cb)
	local result = nil
	local weaponHash = GetHashKey(data.name)
	
	if GetWeapontypeModel(weaponHash) ~= 0 then
		result = {
			type	= weaponTypes[GetWeapontypeGroup(weaponHash)] or 'Unknown',
			ammo	= weaponAmmos[data.name] or 'NO AMMO',
			rounds	= GetWeaponClipSize(weaponHash),
		}
	end
	
	cb(result)
end)

RegisterNUICallback('get_items_needed', function(data, cb)
	local result = {}
	
	for k,v in pairs(data.itemsNeeded) do
		result[k] = {label = ESX.GetItemLabel(k), count = v}
	end
	
	cb(result)
end)

RegisterNUICallback('buy', function(data, cb)
	if string.find(data.name, 'WEAPON_') then
		SetNuiFocus(false, false)
		
		if not isBusy then
			TriggerServerEvent('gunshop_night:buy', data.gunshop, data.type, data.id, data.count)
		end
	else
		if buyCooldown < GetGameTimer() then
			buyCooldown = GetGameTimer() + 1000
			TriggerServerEvent('gunshop_night:buy', data.gunshop, data.type, data.id, data.count)
		end
	end
end)

RegisterNUICallback('quit', function()
	SetNuiFocus(false, false)
	buyCooldown = 0
end)

function InitScript()
	Citizen.CreateThread(function()
		while true do
			local wait = 1500
			local coords = GetEntityCoords(PlayerPedId())
			
			for k,v in pairs(Config.Gunshops) do
				if #(coords - v.coords) < 50.0 then
					if not DoesEntityExist(npcs[k]) then
						npcs[k] = CreateStaticNPC(v.model, v.coords, v.heading)
					end
					
					if #(coords - v.coords) < 1.9 then
						ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to see the weapons menu')
						wait = 0
						
						if IsControlJustReleased(0, 38) and not isBusy then
							WeaponMenu(k)
							Wait(1000)
						end
					end
				else
					if DoesEntityExist(npcs[k]) then
						DeleteEntity(npcs[k])
					end
				end
			end
			
			Wait(wait)
		end
	end)
end

function WeaponMenu(id)
	if not id then
		return
	end

	if not Config.Gunshops[id] then
		return
	end
	

	local sid = GetPlayerServerId(PlayerId())
	local menu = Config.Gunshops[id].menu or 'default'
	
	SetNuiFocus(true, true)
	SendNUIMessage({
		action	= 'show',
		gunshop = id,
		weapons = GenerateShop(menu),
		employee = ESX.GetPlayerJob(sid).name == id,
	})
end

function GenerateShop(menu)
	local temp = {}
	
	for k,v in pairs(Config.WeaponMenus[menu]) do
		for x,y in pairs(v) do
			if string.find(y.name, 'WEAPON_') then
				y.label = weaponLabels[y.name]
			else
				y.label = ESX.GetItemLabel(y.name)
			end
		end
		
		temp[k] = v
	end
	
	return temp
end

function CreateStaticNPC(model, coords, heading)
	RequestModel(model)
	while not HasModelLoaded(model) do Wait(0) end
	
	local npc = CreatePed(5, model, coords.x, coords.y, coords.z - 1.0, heading, false, true)
	SetPedDefaultComponentVariation(npc)
	SetEntityHeading(npc, heading)
	FreezeEntityPosition(npc, true)
	SetEntityInvincible(npc, true)
	SetBlockingOfNonTemporaryEvents(npc, true)
	
	SetModelAsNoLongerNeeded(model)
	
	return npc
end

PlayAnimation = function(ped, dict, anim, settings)
	if dict then
		Citizen.CreateThread(function()
			RequestAnimDict(dict)
			while not HasAnimDictLoaded(dict) do Wait(0) end
			
			if settings == nil then
				TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
			else 
				local speed = 1.0
				local speedMultiplier = -1.0
				local duration = 1.0
				local flag = 0
				local playbackRate = 0
				
				TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
			end
			
			RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end