ESX = nil

local stats = {}
local power = {}
local loadout = {}
local currentJob = 'unemployed'
local weaponTypes = {}
local abilities = {damage = 0, armor = 0, speed = 0, health = 0, vest = 0, stamina = 0}

local skullStatDmg = 0.0
local weaponPowerModifier = 0.003
local weedDefenseModifier = 30	--percent

local damages = {
	['WEAPON_KNUCKLE'] = 0.5,
	['WEAPON_ASSAULTRIFLEMK2_SPLASH'] = 1.5,
	['WEAPON_SPECIALCARBINEMK2_SPLASH'] = 1.5,
	['WEAPON_SMGMK2_SPLASH'] = 1.5,
	['WEAPON_RED_SMG'] = 1.5,
	['WEAPON_ASSAULTRIFLEMK2_RED_MOD'] = 1.5,
	['WEAPON_AWP_GOLD'] = 1.5,
	['WEAPON_SCAR-L_G'] = 1.5,
	['WEAPON_DESERT_EAGLE_GOLD'] = 1.5,
	['WEAPON_M47V2'] = 1.2,
	['WEAPON_SCAR-L'] = 1.6,
	['WEAPON_M4_T_NEON'] = 1.2,
	['WEAPON_COMBATHP'] = 1.2,
	['WEAPON_H05117_P'] = 1.2,
	['WEAPON_CARL_FOX'] = 1.2,
	['WEAPON_HFSMG'] = 0.2,
	['WEAPON_MP5X'] = 0.2,
	['WEAPON_LIMITLESS_CARBINE_MK2'] = 0.2,
	['WEAPON_PAINFUL'] = 0.2,
	['WEAPON_VERESK'] = 0.2,
	['WEAPON_CAUSTIC'] = 0.2,
	['WEAPON_HSMG'] = 0.2,
	['WEAPON_M4A1_CHROMIUM'] = 0.2,
	['WEAPON_ISY'] = 0.2,
	['WEAPON_SALTY_SNACK'] = 0.2,
	['WEAPON_L85_CHRISTMAS'] = 0.2,
	['WEAPON_HFSMGV2'] = 0.2,
	['WEAPON_M47'] = 0.2,
	['WEAPON_M82'] = 0.2,
	['WEAPON_ISYV2'] = 0.2,
	['WEAPON_HFAP'] = 0.2,
	['WEAPON_XM4'] = 0.2,
	['WEAPON_MC4'] = 0.2,
	['WEAPON_NEVA'] = 0.2,
	['WEAPON_REDDRAGON'] = 0.2,
	['WEAPON_M9_P_CHROMIUM'] = 0.2,
	['WEAPON_MUSICFEST'] = 0.2,
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end
	
	while ESX.GetPlayerData().loadout == nil do
		Wait(10)
	end
	
	while ESX.GetPlayerData().stats == nil do
		Wait(250)
	end
	
	local ammoTypes = ESX.GetAmmoTypes()

	for k,v in ipairs(ESX.GetWeaponList()) do
		if v.ammo and ammoTypes[v.ammo.hash] then
			weaponTypes[GetHashKey(v.name)] = string.gsub(ammoTypes[v.ammo.hash], 'AMMO_', '')
		end
	end
	
	local tempPlayerData = ESX.GetPlayerData()
	
	loadout = tempPlayerData.loadout
	stats = tempPlayerData.stats
	currentJob = tempPlayerData.job.name
	
	for k,v in pairs(loadout) do
		if v.power then
			power[GetHashKey(v.name)] = v.power*weaponPowerModifier
		end
	end
	
	ProcessAbilities()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	currentJob = job.name
end)

RegisterNetEvent('esx:onSetStat')
AddEventHandler('esx:onSetStat', function(stat, value)
	stats[stat] = value
end)

RegisterNetEvent('esx:setWeaponPower')
AddEventHandler('esx:setWeaponPower', function()
	Wait(1000)
	power = {}
	loadout = ESX.GetPlayerData().loadout
	
	for k,v in pairs(loadout) do
		if v.power then
			power[GetHashKey(v.name)] = v.power*weaponPowerModifier
		end
	end
end)

RegisterNetEvent('esx:addWeapon')
AddEventHandler('esx:addWeapon', function()
	Wait(1000)
	power = {}
	loadout = ESX.GetPlayerData().loadout
	
	for k,v in pairs(loadout) do
		if v.power then
			power[GetHashKey(v.name)] = v.power*weaponPowerModifier
		end
	end
end)

RegisterNetEvent('esx_mMafia:sendAbilities')
AddEventHandler('esx_mMafia:sendAbilities', function(data)
	SetAbilities(data, true)
end)

RegisterNetEvent('esx_society:sendAbilities')
AddEventHandler('esx_society:sendAbilities', function(data)
	SetAbilities(data, false)
end)

function SetAbilities(data, isCriminal)
	Citizen.CreateThread(function()
		Wait(500)
		
		if (currentJob == 'police' and not isCriminal) or (currentJob ~= 'police' and isCriminal) then
			if data then
				abilities.damage	= data.damage or 0
				abilities.armor		= data.armor or 0
				abilities.speed		= data.speed or 0
				abilities.health	= data.health or 0
				abilities.vest		= data.vest or 0
				abilities.stamina	= data.stamina or 0
			else
				abilities = {damage = 0, armor = 0, speed = 0, health = 0, vest = 0, stamina = 0}
			end
			
			print(json.encode(abilities))
		end
	end)
end

CreateThread(function()
	local prevDefModifier = 0.0
	while true do
		Wait(6000)
		
		TriggerEvent('esx_status:getStatus', 'weed', function(status)
			local defModifier = abilities.armor*0.0015
			
			if status.getPercent() >= 50 then
				defModifier = defModifier + (weedDefenseModifier/100)
			end
			
			if defModifier ~= prevDefModifier then
				local defenseMod = GetPlayerWeaponDefenseModifier(PlayerId())
				SetPlayerMeleeWeaponDefenseModifier(PlayerId(), defenseMod+prevDefModifier)
				SetPlayerWeaponDefenseModifier(PlayerId(), defenseMod+prevDefModifier)

				defenseMod = GetPlayerWeaponDefenseModifier(PlayerId())
				SetPlayerMeleeWeaponDefenseModifier(PlayerId(), defenseMod-defModifier)
				SetPlayerWeaponDefenseModifier(PlayerId(), defenseMod-defModifier)

				prevDefModifier = defModifier
			end
		end)
		
		TriggerEvent('esx_status:getStatus', 'skull', function(status)
			if status.getPercent() >= 50 then
				skullStatDmg = 0.6
			else
				skullStatDmg = 0.0
			end
		end)
	end
end)

local debugMode = 0



RegisterCommand("getweaponstolimit", function (source, args)
	local tosend = {}
	local minimumMulti = tonumber(args[1])
	local c = ""
	local d = ""
	for k,v in pairs(damages) do
		if v <= minimumMulti then
			print(k, v)
			--[[ c = c .. "setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." range 90.000000\n"
			c = c .. "setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." damage 15.000000\n"
			c = c .. "setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." hs_max_distance 109.000000\n"
			c = c .. "setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." hs_dmg_modifier 100.000000\n"
			c = c .. "setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." recoil_accuracy_max 0.000000\n"
			c = c .. "setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." recoil_shake_amplitude 0.12000\n"
			c = c .. "setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." time_between_shots 0.200000\n"


			d = d .. "setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." range 90.000000;"
			d = d .. "setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." damage 15.000000;"
			d = d .. "setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." hs_max_distance 109.000000;"
			d = d .. "setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." hs_dmg_modifier 100.000000;"
			d = d .. "setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." recoil_accuracy_max 0.000000;"
			d = d .. "setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." recoil_shake_amplitude 0.12000;"
			d = d .. "setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." time_between_shots 0.200000;" ]]

			local pack = "jrbWeapons"
			local w = {["AKPUV2"] = true,
			["BAS_P_RED"] = true,
			["DESERT_EAGLE_GOLD"] = true,
			["GYSV2"] = true,
			["ISYV2S"] = true,
			["M4A5V2"] = true,
			["MUSICFEST_V2"] = true,
			["NVRIFLE_PURPLE"] = true,
			["SCAR-L"] = true,
			["XM7_6_8"] = true,
			["ASSAULTRIFLEMK2_RED_MOD"] = true,
			["BLASTXP"] = true,
			["FAMAS_YELLOW"] = true,
			["HFSMGV2"] = true,
			["L85_CHRISTMAS"] = true,
			["M4_HALLOWEEN"] = true,
			["NERF1"] = true,
			["PANDAPISTOL"] = true,
			["SCAR-L_G"] = true,
			["ASSAULTRIFLEMK2_SPLASH"] = true,
			["BULLPUP_SMG"] = true,
			["GALILARV2"] = true,
			["HK516V2"] = true,
			["M133V3"] = true,
			["M4_T_NEON"] = true,
			["NERF2"] = true,
			["REDDRAGONV2"] = true,
			["SMGMK2_SPLASH"] = true,
			["AWP_GOLD"] = true,
			["CRISS_CHRISTMAS"] = true,
			["GRAUV2"] = true,
			["ISYV2"] = true,
			["M47V2"] = true,
			["M82V2"] = true,
			["NEVAV2"] = true,
			["RED_SMG"] = true,
			["SPECIALCARBINEMK2_SPLASH"] = true,
			}


			if w[string.gsub(k, "WEAPON_", "")] then
				pack = "killua_weapon_pack"
			end



			ExecuteCommand("setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." range 90.000000")
			Wait(250)
			ExecuteCommand("setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." damage 15.000000")
			Wait(250)
			ExecuteCommand("setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." hs_max_distance 109.000000")
			Wait(250)
			ExecuteCommand("setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." hs_dmg_modifier 100.000000")
			Wait(250)
			ExecuteCommand("setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." recoil_accuracy_max 0.000000")
			Wait(250)
			ExecuteCommand("setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." recoil_shake_amplitude 0.12000")
			Wait(250)
			ExecuteCommand("setweaponinfo " .. pack .. " "..string.gsub(k, "WEAPON_", "").." time_between_shots 0.200000")
			print("DONE WEAPON", string.gsub(k, "WEAPON_", ""))
			Wait(250)

		end
	end

end)

Citizen.CreateThread(function()
	local hashToDmg = {}
	
	for k,v in pairs(damages) do
		hashToDmg[GetHashKey(k)] = v
	end

	RegisterNetEvent('damage:sendDamages')
	AddEventHandler('damage:sendDamages', function(data)
		for k,v in pairs(data) do
			damages[k] = v
			hashToDmg[GetHashKey(k)] = v
		end
	end)

	local spTimer = 0

	AddEventHandler('esx_extraitems:super_potion3_used', function(seconds)
		spTimer = GetGameTimer() + seconds*1000
	end)
	
	Wait(2000)
	
	local charlevelDmg = 0.0
	local strengthLevelDmg = 0.0
	local turfWarsDmg = 0.0
	local spDmg = 0.0
	
	Citizen.CreateThread(function()
		while true do
			if GetResourceState('charlevel') == 'started' or GetResourceState('charlevel') == 'running' then
				charlevelDmg = math.floor(exports['charlevel']:GetMyLevel()/20)*0.05
			else
				charlevelDmg = 0.0
			end

			if GetResourceState('esx_cjgym') == 'started' or GetResourceState('esx_cjgym') == 'running' then
				strengthLevelDmg = math.floor(exports['esx_cjgym']:getStrength()/20)*0.05
			else
				strengthLevelDmg = 0.0
			end

			if GetResourceState('turf_wars') == 'started' or GetResourceState('turf_wars') == 'running' then
				turfWarsDmg = exports['turf_wars']:CountOwnedAreas(currentJob)*0.008
			else
				turfWarsDmg = 0.0
			end

			if spTimer > GetGameTimer() then
				spDmg = 0.1
			else
				spDmg = 0.0
			end
			
			Wait(1000)
		end
	end)

	AddTextEntry("damage_debug", "~a~~a~")

	local function DrawText2(x, y, scale, text1, text2)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextScale(scale, scale)
		SetTextDropshadow(1, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry('damage_debug')
		AddTextComponentString(text1)
		AddTextComponentString(text2)
		DrawText(x, y)
	end
	
	while true do
		local weapon = GetSelectedPedWeapon(PlayerPedId())
		
		if weapon ~= -1569615261 then
			local modifier = (hashToDmg[weapon] or 1.0) + skullStatDmg + abilities.damage*0.001 + (power[weapon] or 0) + (stats[weaponTypes[weapon]] or 0)*weaponPowerModifier + charlevelDmg + turfWarsDmg + strengthLevelDmg + spDmg
			SetWeaponDamageModifier(weapon, modifier)
			
			if debugMode == 1 then
				local txt = 'default: '..(hashToDmg[weapon] or 1.0)..'\n'
				txt = txt..'skull: '..skullStatDmg..'\n'
				txt = txt..'abilities: '..(abilities.damage*0.001)..'\n'
				txt = txt..'power: '..(power[weapon] or 0)..'\n'
				local txt2 = 'stats: '..(stats[weaponTypes[weapon]] or 0)*weaponPowerModifier..'\n'
				txt2 = txt2..'charlevel: '..charlevelDmg..'\n'
				txt2 = txt2..'turfwars: '..turfWarsDmg..'\n'
				txt2 = txt2..'strength: '..strengthLevelDmg..'\n'
				txt2 = txt2..'total: '..modifier
				
				DrawText2(0.23, 0.40, 0.6, txt, txt2)
			elseif debugMode == 2 then
				local txt = 'total multiplier damage: '..modifier

				DrawText2(0.23, 0.40, 0.6, txt, '')
			end
		end
		
		SetWeaponDamageModifier(-1553120962, 0.05) ---VEHICLE DAMAGE ANTIVDM
		SetWeaponDamageModifier(`WEAPON_BZGAS`, 0.5)
		
		Wait(0)
	end
end)

RegisterCommand('damage_debug', function(source, args)
	if ESX.GetPlayerData().group == 'superadmin' then
		debugMode = debugMode > 0 and 0 or 1
	else
		debugMode = debugMode > 0 and 0 or 2
	end
end)

function ProcessAbilities()
	Citizen.CreateThread(function()
		while true do
			Wait(5000)
			
			if abilities.speed then
				local multi = 1.0 + abilities.speed/math.floor(1000)
				SetRunSprintMultiplierForPlayer(PlayerId(), multi)
			else
				SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
			end
			
			if abilities.stamina and abilities.stamina == 100 then
				ResetPlayerStamina(PlayerId())
			end
			
			if abilities.health and not IsEntityDead(PlayerPedId()) then
				local newHealth = GetEntityHealth(PlayerPedId()) + math.floor(abilities.health*10/100)
				
				if newHealth <= math.floor(300) then
					SetEntityHealth(PlayerPedId(), newHealth)
				end
			end
			
			if abilities.vest and not IsEntityDead(PlayerPedId()) then
				local curArmor = GetPedArmour(PlayerPedId())
				
				if curArmor > math.floor(0) then
					local newArmor = curArmor + math.floor(abilities.vest*10/100)
					
					if newArmor <= math.floor(100) then
						SetPedArmour(PlayerPedId(), newArmor)
					end
				end
			end
		end
	end)
end

RegisterNetEvent('damage:onWeaponPowerUpUse')
AddEventHandler('damage:onWeaponPowerUpUse', function()
	local playerPed = PlayerPedId()
	local weaponHash = GetSelectedPedWeapon(playerPed)
	
	local weaponName = nil
	local list = ESX.GetWeaponList()
	
	for i = 1, #list do
		if GetHashKey(list[i].name) == weaponHash then
			weaponName = list[i].name
			
			break
		end
	end
	
	if weaponName then
		TriggerServerEvent('damage:onWeaponPowerUpUse', weaponName)
	end
end)

RegisterNetEvent("damage:drugEffect")
AddEventHandler("damage:drugEffect",function(effect, itemName)
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	
	if effect == 'weed' then
		if itemName == 'trifyllo_tsigaraki' then
			local anim_lib = "amb@world_human_smoking_pot@male@base"
			local anim_dict = "base"
			
			RequestAnimDict(anim_lib)
			
			while not HasAnimDictLoaded(anim_lib) do
				Citizen.Wait(0)
			end
			
			exports['progressBars']:startUI(5000, "Getting High...")
			
			if not DoesEntityExist(vehicle) then
				--TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_SMOKING_POT", 0, 1)
			end
			
			Citizen.Wait(5000)
			ClearPedTasks(PlayerPedId())
		
			TriggerServerEvent('damage:onDrugUse', effect)
		elseif itemName == 'creatine_smoothie_p' then
			local anim_lib = "mp_player_inteat@pnq"
			local anim_dict = "loop"
			
			RequestAnimDict(anim_lib)
			
			while not HasAnimDictLoaded(anim_lib) do
				Citizen.Wait(0)
			end
			
			exports['progressBars']:startUI(2000, "Drinking Creatine Smoothie...")
			
			if not DoesEntityExist(vehicle) then
				--TaskPlayAnim(PlayerPedId(),anim_lib,anim_dict,3.0,0.5,2000,31,1.0,0,0)
			end
			
			Citizen.Wait(2000)
			ClearPedTasks(PlayerPedId())
		
			TriggerServerEvent('damage:onDrugUse', effect)
		end
	elseif effect == 'skull' then
		if itemName == 'mytia_cocainis' then
			local anim_lib = "amb@code_human_wander_idles@male@idle_a"
			local anim_dict = "idle_b_rubnose"

			RequestAnimDict(anim_lib)
			
			while not HasAnimDictLoaded(anim_lib) do
				Citizen.Wait(0)
			end
			
			exports['progressBars']:startUI(3000, "Sniffing...")
			
			if not DoesEntityExist(vehicle) then
				--TaskPlayAnim(PlayerPedId(),anim_lib,anim_dict,3.0,0.5,3000,31,1.0,0,0)
			end
			
			Citizen.Wait(3000)
			ClearPedTasks(PlayerPedId())
			
			TriggerServerEvent('damage:onDrugUse', effect)
		elseif itemName == 'protein_bar_p' then
			local anim_lib = "mp_player_inteat@burger"
			local anim_dict = "mp_player_int_eat_burger"
			
			RequestAnimDict(anim_lib)
			
			while not HasAnimDictLoaded(anim_lib) do
				Citizen.Wait(0)
			end
			
			exports['progressBars']:startUI(3000, "Eating Protein Bar...")
			
			if not DoesEntityExist(vehicle) then
				--TaskPlayAnim(PlayerPedId(),anim_lib,anim_dict,3.0,0.5,3000,31,1.0,0,0)
			end
			
			Citizen.Wait(3000)
			ClearPedTasks(PlayerPedId())
		
			TriggerServerEvent('damage:onDrugUse', effect)
		end
	end
end)