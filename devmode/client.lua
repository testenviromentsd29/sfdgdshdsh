local devmode = false

ESX = nil
_SpecialAbilities = {}
CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject",function(a) ESX = a end)
		Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	
	Wait(1000*math.random(4, 5))
	print(ESX.DumpTable(GlobalState.BlockedWeapons))
	print(ESX.DumpTable(GlobalState.UsersBlockedWeapon))
	local clBlockedWeapons = {}

	Citizen.CreateThread(function()
		while true do
			Wait(5000)
			for k,v in pairs(GlobalState.BlockedWeapons) do
				clBlockedWeapons[tostring(GetHashKey(k))] = true
			end	
		end
	end)


	ESX.PlayerData = ESX.GetPlayerData()
	Citizen.CreateThread(function()
		while true do
			Wait(500)
			local currentweapon = GetSelectedPedWeapon(PlayerPedId())
			if currentweapon == `WEAPON_STUNGUN` then
				SetPedAmmo(PlayerPedId(), `WEAPON_STUNGUN`, 1)
			end
		end
	end)
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			local currentweapon = GetSelectedPedWeapon(PlayerPedId())

			if (clBlockedWeapons and clBlockedWeapons[tostring(currentweapon)]) or (GlobalState.UsersBlockedWeapon[ESX.PlayerData.identifier] and GlobalState.UsersBlockedWeapon[ESX.PlayerData.identifier] > GlobalState.date.timestamp) then
				SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
			end
	
		end 
	end)
	
	print(ESX.DumpTable(GlobalState.BlockedClothes))
--[[ 	print(1,GetPedDrawableVariation(PlayerPedId(), 0))
	print(2,GetPedDrawableVariation(PlayerPedId(), 1))
	print(3,GetPedDrawableVariation(PlayerPedId(), 2))
	print(4,GetPedDrawableVariation(PlayerPedId(), 3))
	print(5,GetPedDrawableVariation(PlayerPedId(), 4))
	print(6,GetPedDrawableVariation(PlayerPedId(), 5))
	print(7,GetPedDrawableVariation(PlayerPedId(), 6))
	print(8,GetPedDrawableVariation(PlayerPedId(), 7))
	print(9,GetPedDrawableVariation(PlayerPedId(), 8))
	print(10,GetPedDrawableVariation(PlayerPedId(), 9))
	print(11,GetPedDrawableVariation(PlayerPedId(), 10))
	print(12,GetPedDrawableVariation(PlayerPedId(), 11)) ]]
	Citizen.CreateThread(function()
		Wait(2000)
		while true do
			Wait(0)
			local model = GetEntityModel(PlayerPedId())
			model = tonumber(model)
			if GlobalState.BlockedClothes[model] then
				for k,v in pairs(GlobalState.BlockedClothes[model]) do
					local drawable = GetPedDrawableVariation(PlayerPedId(), k)
					local texture = GetPedTextureVariation(PlayerPedId(), k)
					
					if GlobalState.BlockedClothes[model][k][drawable] then 
						if GlobalState.BlockedClothes[model][k][drawable][texture] then
							if GlobalState.BlockedClothes[model][k][drawable][texture][ESX.PlayerData.identifier] == nil then
								SetPedComponentVariation(PlayerPedId(), k, 0, 0, 0)
								ESX.ShowNotification("You cannot wear this.")
							end
						end
					end
				end
				
			end
		end
	end)
	--[[ 
	0: Face
	1: Mask
	2: Hair
	3: Torso
	4: Leg
	5: Parachute / bag
	6: Shoes
	7: Accessory
	8: Undershirt
	9: Kevlar
	10: Badge
	11: Torso 2 ]]
	local BlockedClothesPerJob = {
		--[[ [`mp_m_freemode_01`] = {
			[4] = {
				[87] = {["police"] = true, ['police2'] = true, ['army'] = true, ['army2'] = true},

			},
			[7] = {
				[62] = {["police"] = true, ['police2'] = true, ['army'] = true, ['army2'] = true},
				[82] = {["police"] = true, ['police2'] = true, ['army'] = true, ['army2'] = true},
				[84] = {["police"] = true, ['police2'] = true, ['army'] = true, ['army2'] = true},
				
			},
			[11] = {--component
				[842] = { --drawableVariant
					["police"] = true,
					["police2"] = true,
					["army"] = true,
					["army2"] = true,
				},
				[220] = {["police"] = true, ['police2'] = true, ['army'] = true, ['army2'] = true},
				[35] = {["police"] = true, ['police2'] = true, ['army'] = true, ['army2'] = true},
				[843] = {["police"] = true, ['police2'] = true},
				[844] = {["police"] = true, ['police2'] = true},
				[845] = {["police"] = true, ['police2'] = true},
				[846] = {["police"] = true, ['police2'] = true},
				[847] = {["police"] = true, ['police2'] = true},
				[848] = {["police"] = true, ['police2'] = true},
				[849] = {["police"] = true, ['police2'] = true},
				[850] = {["police"] = true, ['police2'] = true},
				[851] = {["police"] = true, ['police2'] = true},
				[852] = {["police"] = true, ['police2'] = true},
				[853] = {["police"] = true, ['police2'] = true},
				[854] = {["police"] = true, ['police2'] = true},
				[855] = {["police"] = true, ['police2'] = true},
				[856] = {["police"] = true, ['police2'] = true},
				[857] = {["police"] = true, ['police2'] = true},
				[858] = {["police"] = true, ['police2'] = true},
				[859] = {["police"] = true, ['police2'] = true},
				[860] = {["police"] = true, ['police2'] = true},
				[861] = {["police"] = true, ['police2'] = true},
				[862] = {["police"] = true, ['police2'] = true},
				[863] = {["police"] = true, ['police2'] = true},
				[864] = {["police"] = true, ['police2'] = true},
				[865] = {["police"] = true, ['police2'] = true},
				[866] = {["police"] = true, ['police2'] = true},
				[867] = {["police"] = true, ['police2'] = true},
				[868] = {["police"] = true, ['police2'] = true},
				[869] = {["police"] = true, ['police2'] = true},
				[870] = {["police"] = true, ['police2'] = true},
				[871] = {["police"] = true, ['police2'] = true},
				[872] = {["police"] = true, ['police2'] = true},
				[873] = {["police"] = true, ['police2'] = true},
				[874] = {["police"] = true, ['police2'] = true},
				[875] = {["police"] = true, ['police2'] = true},
			}
		} ]]
	}
	

	Citizen.CreateThread(function()
		Wait(2000)
		while true do
			Wait(0)
			local model = GetEntityModel(PlayerPedId())
			model = tonumber(model)
			if BlockedClothesPerJob[model] then
				for k,v in pairs(BlockedClothesPerJob[model]) do
					local drawable = GetPedDrawableVariation(PlayerPedId(), k)
					if BlockedClothesPerJob[model][k][drawable] then 
						if BlockedClothesPerJob[model][k][drawable] then
							if BlockedClothesPerJob[model][k][drawable][ESX.PlayerData.job.name] == nil then
								SetPedComponentVariation(PlayerPedId(), k, 0, 0, 0)
								ESX.ShowNotification("You cannot wear this.")
							end
						end
					end
				end
				
			end
		end
	end)
	if ESX.PlayerData.attributes and ESX.PlayerData.attributes["specialAbilities"] then
		local spe = json.decode(ESX.PlayerData.attributes["specialAbilities"])
		_SpecialAbilities = spe
	end
	--DebugBones()
	TimerDC()
	TimerVehicleLootbox()
	ProcessPinnedLocations()
	VipAmmo()
	NoMeeleeInEvents()
	--AntiGlitchPeak()
	BikeRagdoll()
	SquareBlips()
	ProcessCountPlayers()

end)


RegisterNetEvent('devmode:showlogconnect')
AddEventHandler('devmode:showlogconnect', function(t)
	local elements = {}
	for i=1,#t do
		table.insert(elements, {
			label = t[i].time .. " - " .. t[i].log,
			value = ""
		})
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'das', {
		title    = 'LastConnects',
		align    = 'center',
		elements = elements,
	},function(data, menu)
		
	end,function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('devmode:showhelp')
AddEventHandler('devmode:showhelp', function()
local elements = {
	{label = "armoryblueprints [σου δείχνει τι όπλα υπάρχουν μέσα σε armory σε μορφή blueprint]", value = ""},
	{label = "armoryitems [item] [μπορείς να βάλεις το αντικείμενο και σου λένε τα αντικείμενα που υπάρχουν στα αρμορυ]", value = ""},
	{label = "armoryweapons [σου δείχνει τι όπλα υπάρχουν μέσα σε armory]", value = ""},
	{label = "playersmoney [τα λεφτά τα καθαρά χρήματα που υπάρχουν στις τράπεζες ανά παίκτη]", value = ""},
	{label = "playerscoins [τα donate coins ανά παίκτη.]", value = ""},
	{label = "weaponinfo [weapon] [σου δίνει το damage , το range και το damage headshot που έχει κάποιο όπλο]", value = ""},
	{label = "setweaponinfo [weapon] [type] [value] [σετάρεις τις τιμές κάθε όπλου] Valid types: range, damage, hs_dmg_modifier Valid types: range, damage, hs_dmg_modifier, recoil_accuracy_max, recoil_shake_amplitude", value = ""},
	{label = "/level3viponline [από τους παίκτες που είναι online πόσοι έχουν level3 vip]", value = ""},
	{label = "/getVip [type] [σου λέει πόσα υπάρχουν συνολικά]", value = ""},
	{label = "/getVipDays [type] [days] [και σου λέει από την μέρα που το πατάς ανάλογα την μέρα που θα βάλεις πόσα θα λήξουν]", value = ""},
}
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'asds', {
		title    = 'SUPERADMIN HELP',
		align    = 'center',
		elements = elements,
	},function(data, menu)
		menu.close()
	end,function(data, menu)
		menu.close()
	end)
end)

--############################################
--############################################
--############################################
--############################################
_GoldMines = {}
RegisterNetEvent('devmode:goldmines')
AddEventHandler('devmode:goldmines', function(mines)
	_GoldMines = mines
end)

local _ActiveGoldMineNPC = nil
_ActiveGoldMine = nil
Citizen.CreateThread(function()
	while true do
		Wait(5000)
		local coords = GetEntityCoords(PlayerPedId())
		for i=1,#_GoldMines do
			if #(coords - _GoldMines[i].coords) < 10 then
				if _ActiveGoldMine == i then
				else
					if _ActiveGoldMineNPC then
						DeleteEntity(_ActiveGoldMineNPC)
					end
					_ActiveGoldMineNPC = CreateMineNPC("s_m_m_dockwork_01", _GoldMines[i].coords, 0.0)
					_ActiveGoldMine = i
				end
				
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if _ActiveGoldMine then
			local data = _GoldMines[_ActiveGoldMine]
			if data then
				local coords = GetEntityCoords(PlayerPedId())
				if #(coords - data.coords) < 2 then
					ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to collect the gold")
					if IsControlJustPressed(0, 38) then
						TriggerServerEvent("devmode:CollectMine", _GoldMines[_ActiveGoldMine].id)
						Wait(1000)
					end
				end
			end
		else
			Wait(1000)
		end
	end
end)

function CreateMineNPC(model, coords, heading)
	RequestModel(model)
 
	while not HasModelLoaded(model) do
	   Wait(10)
	end
 
	RequestAnimDict('melee@large_wpn@streamed_core')
 
	while not HasAnimDictLoaded('melee@large_wpn@streamed_core') do
	   Wait(10)
	end
 
	local npc = CreatePed(5, model, coords.x, coords.y, coords.z - 1.0, heading, false, true)
	SetPedDefaultComponentVariation(npc)
	SetEntityHeading(npc, heading)
	FreezeEntityPosition(npc, true)
	SetEntityInvincible(npc, true)
 
	SetBlockingOfNonTemporaryEvents(npc, true)
	TaskPlayAnim(npc, 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
	SetModelAsNoLongerNeeded(model)
	return npc
 end




--############################################
--############################################
--############################################
--############################################

RegisterNetEvent('esx:setattr')
AddEventHandler('esx:setattr', function(attr, v)
	ESX.PlayerData.attributes[attr] = v
	if attr == specialAbilities then
		local spe = json.decode(ESX.PlayerData.attributes["specialAbilities"])
		_SpecialAbilities = spe
	end
end)
local NoFlyModels = {
	[`deluxo`] = true,
	[`dmc12cp`] = true,
	[`taxisBus`] = true,
	[`toreador`] = true,
	[`hellfiregift `] = true,
	[`offh2pressor`] = true,
	[`tmaxDX`] = true,
	[`nimbus16`] = true,
	[`thruster4 `] = true,
	[`drag`] = true,
	[`alterigos6`] = true,
	[`lambf`] = true,
	[`c3ktem`] = true,
	[`dv4r`] = true,
	[`taxisegt`] = true,
	[`thenilu27`] = true,
}

local disActions = false
Citizen.CreateThread(function()
	while GlobalState.NoFlyZones == nil do
		Wait(0)
	end
	while true do
		Wait(1000)
		local shouldDis = false
		for k,v in pairs(GlobalState.NoFlyZones) do
			if #(GetEntityCoords(PlayerPedId()) - v.coords) < v.radius then
				local veh = GetVehiclePedIsIn(PlayerPedId(), false)
				if DoesEntityExist(veh) then
					local vehModel = GetEntityModel(veh)
					if NoFlyModels[vehModel] then
						local driver = GetPedInVehicleSeat(veh, -1)
						if driver == PlayerPedId() then
							shouldDis = true
						end
					end
				end
			end
		end
		if shouldDis then
			disActions = true
		else
			disActions = false
		end
	end
	
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if disActions then
			DisableAllControlActions(true)
			EnableControlAction(0,23,true)
			EnableControlAction(0,75,true)
		else
			Wait(1000)
		end
	end
end)

RegisterCommand("checkability", function ()
	if _SpecialAbilities and _SpecialAbilities ~= {} then
		if _SpecialAbilities["strength"] and _SpecialAbilities["strength"].endIt >= GlobalState.date.timestamp then
			ESX.ShowNotification("Your strength ability ends in " .. math.floor((_SpecialAbilities["strength"].endIt - GlobalState.date.timestamp)/(60*60*24)) .. " days" )
		end
		if _SpecialAbilities["speed"] and _SpecialAbilities["speed"].endIt >= GlobalState.date.timestamp then
			ESX.ShowNotification("Your speed ability ends in " .. math.floor((_SpecialAbilities["speed"].endIt - GlobalState.date.timestamp)/(60*60*24)) .. " days" )
		end
		if _SpecialAbilities["damage"] and _SpecialAbilities["damage"].endIt >= GlobalState.date.timestamp then
			ESX.ShowNotification("Your damage ability ends in " .. math.floor((_SpecialAbilities["damage"].endIt - GlobalState.date.timestamp)/(60*60*24)) .. " days" )
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if _SpecialAbilities and _SpecialAbilities ~= {} then
			if _SpecialAbilities["strength"] and _SpecialAbilities["strength"].endIt >= GlobalState.date.timestamp then
				SetPlayerMeleeWeaponDefenseModifier(PlayerId(), _SpecialAbilities["strength"].level)
				SetPlayerWeaponDefenseModifier(PlayerId(), _SpecialAbilities["strength"].level)
			end
			if _SpecialAbilities["speed"] and _SpecialAbilities["speed"].endIt >= GlobalState.date.timestamp then
				print("has speed")
				SetRunSprintMultiplierForPlayer(PlayerPedId(), _SpecialAbilities["speed"].level)
			end
			if _SpecialAbilities["damage"] and _SpecialAbilities["damage"].endIt >= GlobalState.date.timestamp then
				print("has damage")

				local weapon = GetSelectedPedWeapon(PlayerPedId())
				if weapon ~= -1569615261 then
					SetWeaponDamageModifier(weapon, _SpecialAbilities["damage"].level)
				end
			end
		else
			Wait(1000)
		end
	end
end)

local atmp = 0
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if GlobalState.CurTime ~= nil then
			if GlobalState.CurTime < GetGameTimer() - 5000 then
				if atmp > 3 then
					TriggerServerEvent("devmode:resetMyTimes")
				end
				atmp = atmp + 1
				Wait(3000)

			end
		end
	end
end)
local atmp2 = 0
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if GlobalState.ComServTimeIn ~= nil then
			if GlobalState.ComServTimeIn < GetGameTimer() - 10000 then
				if atmp2 > 3 then
					TriggerServerEvent("devmode:resetMyTimes2")
					break
				end
				atmp2 = atmp2 + 1
				Wait(2000)
				
			end
		end
	end
end)
local atmp3 = 0
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if GlobalState.JailTimeIn ~= nil then
			if GlobalState.JailTimeIn < GetGameTimer() - 10000 then
				if atmp3 > 3 then
					TriggerServerEvent("devmode:resetMyTimes3")
					break
				end
				atmp3 = atmp3 + 1
				Wait(2000)
				
			end
		end
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	if job.name == 'police' or job.name == 'police2' then
		TriggerServerEvent("devmode:amIPolice")
	end
end)


RegisterNetEvent('devmode:msgdonate')
AddEventHandler('devmode:msgdonate', function(job)
	local text = exports["fDialog"]:OpenDialog("Τι θες να αναφερεις;", '')
	if text and text ~= "" then
		TriggerServerEvent("devmode:msgdonate", job, text)
	end
end)

RegisterNetEvent('devmode:seemessages')
AddEventHandler('devmode:seemessages', function(msgs)
	local elements = {}
	for k,v in pairs(msgs) do
		table.insert(elements, {value = k, label = v.name .. " " .. v.identifier .. " " .. v.discord .. " " .. v.job .. " "  .. v.text})
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menuName', {
		title    = 'Donate Messages',
		align    = 'center',
		elements = elements,
	},function(data, menu)
		if data.current.value then
			TriggerServerEvent("devmode:deletemessage", data.current.value)
		end
		menu.close()
	end,function(data, menu)
		menu.close()
	end)
end)


RegisterCommand("aaaaaaaaaaaaa", function (source, args)
	if ESX.PlayerData.identifier == "steam:11000010599d460" then
		print(GetDisplayNameFromVehicleModel(tonumber(args[1])))

		ESX.Game.SpawnVehicle(tonumber(args[1]), GetEntityCoords(PlayerPedId()) + vector3(0.0, 0.0, 1.0), 0.0, function(vehicle)
			TriggerEvent("devmode:copytext",  GetDisplayNameFromVehicleModel(tonumber(args[1])))
			Citizen.CreateThread(function()
				while DoesEntityExist(vehicle) do
					Wait(0)
					ESX.Game.Utils.DrawText3D( GetEntityCoords(vehicle) + vector3(0.0, 0.0, 1.0), GetDisplayNameFromVehicleModel(tonumber(args[1])), 2.0, 4)
				end
			end)
			Citizen.Wait(5000)
			DeleteEntity(vehicle)
		end)
	end
end)

RegisterNetEvent('devmode:openReplaceVehicleTickets')
AddEventHandler('devmode:openReplaceVehicleTickets', function()
	ESX.UI.Menu.CloseAll()
	local elements = {
		{label = "Vehicle", value = "nero"},
{label = "Vehicle", value = "sm722"},
{label = "Vehicle", value = "specter"},
{label = "Vehicle", value = "seven70"},
{label = "Vehicle", value = "raptor"},
{label = "Vehicle", value = "ruston"},
{label = "Vehicle", value = "winky"},
{label = "Vehicle", value = "vagrant"},
{label = "Vehicle", value = "verus"},
{label = "Vehicle", value = "mesa3"},
{label = "Vehicle", value = "marshall"},
{label = "Vehicle", value = "kamacho"},
{label = "Vehicle", value = "tenf2"},
{label = "Vehicle", value = "vstr"},
{label = "Vehicle", value = "tropos"},
{label = "Vehicle", value = "vectre"},
{label = "Vehicle", value = "verlierer2"},
{label = "Vehicle", value = "zr380"},
{label = "Vehicle", value = "sultan2"},
{label = "Vehicle", value = "omnis"},
{label = "Vehicle", value = "omnisegt"},
{label = "Vehicle", value = "casco"},
{label = "Vehicle", value = "coquette2"},
{label = "Vehicle", value = "infernus2"},
{label = "Vehicle", value = "autarch"},
{label = "Vehicle", value = "champion"},
{label = "Vehicle", value = "entityxf"},
{label = "Vehicle", value = "emerus"},
{label = "Vehicle", value = "infernus"},
{label = "Vehicle", value = "lm87"},
{label = "Vehicle", value = "prototipo"},
{label = "Vehicle", value = "sc1"},
{label = "Vehicle", value = "tezeract"},
{label = "Vehicle", value = "thrax"},
{label = "Vehicle", value = "torero2"},
{label = "Vehicle", value = "turismor"},
{label = "Vehicle", value = "stretch"},
		{label = "Vehicle", value = "accolade"},
{label = "Vehicle", value = "blistacr"},
{label = "Vehicle", value = "coquettewb"},
{label = "Vehicle", value = "elegyrh6"},
{label = "Vehicle", value = "hellhound"},
{label = "Vehicle", value = "jogger"},
{label = "Vehicle", value = "ncavalcade"},
{label = "Vehicle", value = "recursion"},
{label = "Vehicle", value = "sancyb4"},
{label = "Vehicle", value = "serena"},
{label = "Vehicle", value = "toreador2"},
{label = "Vehicle", value = "vulture"},
{label = "Vehicle", value = "ariant"},
{label = "Vehicle", value = "buffalowb"},
{label = "Vehicle", value = "cwagon"},
{label = "Vehicle", value = "euros"},
{label = "Vehicle", value = "hycrh7"},
{label = "Vehicle", value = "kawaii"},
{label = "Vehicle", value = "nebulaw"},
{label = "Vehicle", value = "remustwo"},
{label = "Vehicle", value = "savestrare"},
{label = "Vehicle", value = "stratumc"},
{label = "Vehicle", value = "trailw"},
{label = "Vehicle", value = "weevilup"},
{label = "Vehicle", value = "arias"},
{label = "Vehicle", value = "callista"},
{label = "Vehicle", value = "dbvolante"},
{label = "Vehicle", value = "feltzer9"},
{label = "Vehicle", value = "imperial"},
{label = "Vehicle", value = "komodafr"},
{label = "Vehicle", value = "nriata"},
{label = "Vehicle", value = "rh82"},
{label = "Vehicle", value = "scharmann"},
{label = "Vehicle", value = "streiter2"},
{label = "Vehicle", value = "tulip2s"},
{label = "Vehicle", value = "yosemiteswb"},
{label = "Vehicle", value = "asteropers"},
{label = "Vehicle", value = "caracara6x6"},
{label = "Vehicle", value = "deluxo2"},
{label = "Vehicle", value = "gauntletc"},
{label = "Vehicle", value = "inferrod"},
{label = "Vehicle", value = "kriegerc"},
{label = "Vehicle", value = "nsandstorm"},
{label = "Vehicle", value = "rhinetaxi"},
{label = "Vehicle", value = "scheisser"},
{label = "Vehicle", value = "sunrise1"},
{label = "Vehicle", value = "turismoo"},
{label = "Vehicle", value = "zionks"},
{label = "Vehicle", value = "astronc"},
{label = "Vehicle", value = "castella"},
{label = "Vehicle", value = "domc"},
{label = "Vehicle", value = "gauntlets"},
{label = "Vehicle", value = "ingotc"},
{label = "Vehicle", value = "lentus"},
{label = "Vehicle", value = "oraclelwb"},
{label = "Vehicle", value = "roxanne"},
{label = "Vehicle", value = "schwartzerc"},
{label = "Vehicle", value = "surano3"},
{label = "Vehicle", value = "turtle"},
{label = "Vehicle", value = "zodiac"},
{label = "Vehicle", value = "atlas"},
{label = "Vehicle", value = "clique3"},
{label = "Vehicle", value = "dubstag"},
{label = "Vehicle", value = "gstghell1"},
{label = "Vehicle", value = "issi8s"},
{label = "Vehicle", value = "mf1"},
{label = "Vehicle", value = "peacemaker2"},
{label = "Vehicle", value = "sabot"},
{label = "Vehicle", value = "sentinelsg4"},
{label = "Vehicle", value = "tfdominator"},
{label = "Vehicle", value = "zr150"},
{label = "Vehicle", value = "bansheepo"},
{label = "Vehicle", value = "clubgtr"},
{label = "Vehicle", value = "elegant"},
{label = "Vehicle", value = "hachura"},
{label = "Vehicle", value = "issic"},
{label = "Vehicle", value = "navarra"},
{label = "Vehicle", value = "primolx"},
{label = "Vehicle", value = "sabrecab"},
{label = "Vehicle", value = "seraph3"},
{label = "Vehicle", value = "thraxd"},
{label = "Vehicle", value = "vorstand"},
{label = "Vehicle", value = "zr250"},
{label = "Vehicle", value = "DB204sBlackHorse"},
{label = "Vehicle", value = "DB300sdemon"},
{label = "Vehicle", value = "DBb800"},
{label = "Vehicle", value = "DBbiza2"},
{label = "Vehicle", value = "DBboostv"},
{label = "Vehicle", value = "DBChevyCorvetteC6T"},
{label = "Vehicle", value = "DBDemonHycade"},
{label = "Vehicle", value = "DBdolphteslapd"},
{label = "Vehicle", value = "DBdonrrss"},
{label = "Vehicle", value = "DBdrejailbreak2"},
{label = "Vehicle", value = "DBESHAWK"},
{label = "Vehicle", value = "DBf355spxxbk"},
{label = "Vehicle", value = "DBGODzDCYUKON"},
{label = "Vehicle", value = "DBgstsickmaro"},
{label = "Vehicle", value = "DBhellephantdurangoFD"},
{label = "Vehicle", value = "DBhp_911"},
{label = "Vehicle", value = "DBm323"},
{label = "Vehicle", value = "DBMG63PxxBK"},
{label = "Vehicle", value = "DBmk4hycade"},
{label = "Vehicle", value = "DBr878b"},
{label = "Vehicle", value = "dbRedeyeTracky"},
{label = "Vehicle", value = "DBRRazirrisa"},
{label = "Vehicle", value = "DBsou_720_wb"},
{label = "Vehicle", value = "DBtatebugatti"},
{label = "Vehicle", value = "DBToraVeyron"},
{label = "Vehicle", value = "DBToraWBHellcat"},
{label = "Vehicle", value = "DBuruslambo23s"},
{label = "Vehicle", value = "DBvanzc6t"},
{label = "Vehicle", value = "drem3adro"},
{label = "Vehicle", value = "fer296beast"},
{label = "Vehicle", value = "gst862"},
{label = "Vehicle", value = "gstpstnc6"},
{label = "Vehicle", value = "hellbeast"},
{label = "Vehicle", value = "gronos6x6"},
{label = "Vehicle", value = "m2hycadev2"},
{label = "Vehicle", value = "mustanghycade"},
{label = "Vehicle", value = "r8hycade"},
{label = "Vehicle", value = "raptorbeast"},
{label = "Vehicle", value = "rs5hycade"},
	}
	local _CurVeh = nil
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dsad', {
		title    = 'Choose the vehicle you want',
		align    = 'bottom-right',
		elements = elements,
	},function(data, menu)
		if data.current.value then

			if exports['dialog']:Decision('REPLACE VEHICLE TICKET', "Are you sure?", '', 'YES', 'NO').action == 'submit' then
				_v = nil
				ESX.Game.SpawnVehicle(data.current.value, GetEntityCoords(PlayerPedId()) + vector3(0.0, 0.0, 1.0), 0.0, function(vehicle)
					SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
					_v = vehicle
				end)
				while _v == nil do
					Wait(0)
				end
				Wait(1000)
				local vehicleProps = ESX.Game.GetVehicleProperties(_v)
				DeleteEntity(_v)
				DeleteVehicle(_v)
				TriggerServerEvent("devmode:getTicketVehicle", vehicleProps)
				menu.close()
				if _CurVeh then
					DeleteEntity(_CurVeh)
					DeleteVehicle(_CurVeh)
				end
			else
			end
		end
	end,function(data, menu)
		menu.close()
		if _CurVeh then
			DeleteEntity(_CurVeh)
			DeleteVehicle(_CurVeh)
		end
	end, function (data,menu)
		if data.current.value then
			if _CurVeh then
				DeleteEntity(_CurVeh)
				DeleteVehicle(_CurVeh)
			end
			ESX.Game.SpawnLocalVehicle(data.current.value, GetEntityCoords(PlayerPedId()) + GetEntityForwardVector(PlayerPedId()) * 4, 0.0, function(vehicle)
				_CurVeh = vehicle
				Citizen.CreateThread(function ()
					Wait(10000)
					if vehicle then
						if DoesEntityExist(vehicle) then
							DeleteEntity(vehicle)
							DeleteVehicle(vehicle)
						end
					end
				end)
			end)
		end
		
	end)
end)


RegisterNetEvent('devmode:openVehicleTickets')
AddEventHandler('devmode:openVehicleTickets', function()
	ESX.UI.Menu.CloseAll()
	local elements = {
		{label = "xkmaster48v", value = "xkmaster48v"},
{label = "warfare", value = "warfare"},
{label = "vdcoffin", value = "vdcoffin"},
{label = "420x", value = "420x"},
{label = "86cr250", value = "86cr250"},
{label = "alter1", value = "alter1"},
{label = "bulletbill", value = "bulletbill"},
{label = "celicabzk", value = "celicabzk"},
{label = "duness", value = "duness"},
{label = "frauscher16", value = "frauscher16"},
{label = "jltv", value = "jltv"},
{label = "monowheel", value = "monowheel"},
{label = "remower", value = "remower"},
{label = "sccjkl", value = "sccjkl"},
{label = "scczqjkl", value = "scczqjkl"},
{label = "sphere", value = "sphere"},
{label = "sr510", value = "sr510"},
{label = "Stromberg", value = "Stromberg"},
{label = "taxisBagger", value = "taxisBagger"},
{label = "taxisChristmas", value = "taxisChristmas"},
{label = "taxisPatini", value = "taxisPatini"},
	}
	local _CurVeh = nil
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dsad', {
		title    = 'Choose the vehicle you want',
		align    = 'bottom-right',
		elements = elements,
	},function(data, menu)
		if data.current.value then

			if exports['dialog']:Decision('VEHICLE TICKET', "Are you sure?", '', 'YES', 'NO').action == 'submit' then
				_v = nil
				ESX.Game.SpawnVehicle(data.current.value, GetEntityCoords(PlayerPedId()) + vector3(0.0, 0.0, 1.0), 0.0, function(vehicle)
					SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
					_v = vehicle
				end)
				while _v == nil do
					Wait(0)
				end
				local vehicleProps = ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false))
				DeleteEntity(_v)
				DeleteVehicle(_v)
				TriggerServerEvent("devmode:getTicketVehicle", vehicleProps)
				menu.close()
				if _CurVeh then
					DeleteEntity(_CurVeh)
					DeleteVehicle(_CurVeh)
				end
			else
			end
		end
	end,function(data, menu)
		menu.close()
		if _CurVeh then
			DeleteEntity(_CurVeh)
			DeleteVehicle(_CurVeh)
		end
	end, function (data,menu)
		if data.current.value then
			if _CurVeh then
				DeleteEntity(_CurVeh)
				DeleteVehicle(_CurVeh)
			end
			ESX.Game.SpawnLocalVehicle(data.current.value, GetEntityCoords(PlayerPedId()) + GetEntityForwardVector(PlayerPedId()) * 4, 0.0, function(vehicle)
				_CurVeh = vehicle
				SetVehicleFuelLevel(vehicle, 0.0)
				SetVehicleUndriveable(vehicle, true)
				Citizen.CreateThread(function()
					
					while DoesEntityExist(_CurVeh) do
						local veh = GetVehiclePedIsIn(PlayerPedId(), false)
						if veh == _CurVeh then
							TaskLeaveVehicle(PlayerPedId(), _CurVeh, 0)
						end
						Wait(500)
					end
				end)
			end)
		end
		
	end)
end)
RegisterNetEvent('devmode:openWeaponTickets')
AddEventHandler('devmode:openWeaponTickets', function()
	ESX.UI.Menu.CloseAll()
	local elements = {
		{label = "SCIFIRIFLE MK2", value = "WEAPON_SCIFIRIFLE_MK2"},
		{label = "RAINIER AK", value = "WEAPON_RAINIER_AK"},
		{label = "SCIFIRIFLE", value = "WEAPON_SCIFIRIFLE"},
		{label = "ACSCHG", value = "WEAPON_ACSCHG"},
		{label = "MPS4", value = "WEAPON_MPS4"},
		{label = "M1233", value = "WEAPON_M1233"},
		{label = "CCAKM", value = "WEAPON_CCAKM"},
		{label = "FORTNITE SCARL XMAS", value = "WEAPON_FORTNITE_SCARL_XMAS"},
		{label = "CARTOON RIFLE", value = "WEAPON_CARTOON_RIFLE"},
		{label = "SXMDR", value = "WEAPON_SXMDR"},
	}
	local _CurVeh = nil
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dsad', {
		title    = 'Choose the weapon you want',
		align    = 'bottom-right',
		elements = elements,
	},function(data, menu)
		if data.current.value then

			if exports['dialog']:Decision('WEAPON TICKET', "Are you sure?", '', 'YES', 'NO').action == 'submit' then
				TriggerServerEvent("devmode:getTicketWeapon", data.current.value)
				menu.close()
			end
		end
	end,function(data, menu)
		menu.close()
	end)
end)

local guide_map_data = {
	["Gunshop"] = vector3(19.14, -1109.14, 29.80),
	["Security"] = vector3(749.60, 220.89, 87.03),
	["Ammunation"] = vector3(-83.88, 41.50, 71.87),
	["Pharmacy"] = vector3(-1014.87, -481.34, 38.47),
	["Blacksmith"] = vector3(-230.68, -855.50, 30.41),
	["Sunergeio"] = vector3(-74.81, -1342.16, 29.26),
	["Fagadiko"] = vector3(-251.15, -944.24, 31.22),
	["Club"] = vector3(-1845.48, -337.53, 57.08),
	
	["Cafe"] = vector3(-653.04, -817.38, 24.66),
	["Hacker"] = vector3(397.66, -919.58, 29.42),
	["Lab"] =  vector3(-231.94, -858.51, 30.41),
	["Ekab"] = vector3(-826.70, -1220.16, 6.93),
	["Police"] = vector3(2569.37, -340.11, 92.97) ,
	["WeaponFactory"] = vector3(116.1626, -447.3362, 40.12524),
	["VehicleFactory"] = vector3(-703.31, -864.41, 23.45),

}
RegisterCommand("guide_map", function ()
	ESX.UI.Menu.CloseAll()
	local elements = {}
	for k,v in pairs(guide_map_data) do
		table.insert(elements, {
			label = k,
			value = k
		})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'guide_map', {
		title    = 'Hit enter on a job to set a waypoint',
		align    = 'bottom-right',
		elements = elements,
	},function(data, menu)
		if data.current.value then
			SetNewWaypoint(guide_map_data[data.current.value].x, guide_map_data[data.current.value].y)
			ESX.ShowNotification('Waypoint set')
		end
		menu.close()
	end,function(data, menu)
		menu.close()
	end)	
end)

function ProcessPinnedLocations()
	local blips = {}
	local pinned = json.decode(GetResourceKvpString('pinned_locations')) or {}
	
	for k,v in pairs(pinned) do
		local blip = AddBlipForCoord(tonumber(v.x), tonumber(v.y), tonumber(v.z))
		SetBlipSprite(blip, 787)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 1.5)
		SetBlipColour(blip, 1)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(v.name)
		EndTextCommandSetBlipName(blip)
		
		table.insert(blips, blip)
	end
	
	RegisterCommand('pinloc', function(source, args)
		if args[1] then
			if #pinned > 3 then
				ESX.ShowNotification('You have reached the max pinlocs')
				return
			end
			
			local name = args[1]
			local coords = GetEntityCoords(PlayerPedId())
			
			table.insert(pinned, {name = name, x = coords.x, y = coords.y, z = coords.z})
			SetResourceKvp('pinned_locations', json.encode(pinned))
			
			local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
			SetBlipSprite(blip, 787)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 1.5)
			SetBlipColour(blip, 1)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString(name)
			EndTextCommandSetBlipName(blip)
			
			table.insert(blips, blip)
		end
	end)
	
	RegisterCommand('pinloc_reset', function(source, args)
		for k,v in pairs(blips) do
			if DoesBlipExist(v) then
				RemoveBlip(v)
			end
		end
		
		pinned = {}
		DeleteResourceKvp('pinned_locations')
	end)
end

function TimerDC()
	TriggerServerEvent('devmode:timerDC')
	
	Citizen.CreateThread(function()
		while true do
			Wait(240*60000)
			TriggerServerEvent('devmode:timerDC')
		end
	end)
end

function TimerVehicleLootbox()
	TriggerServerEvent('devmode:timerVehicleLootbox')
	
	Citizen.CreateThread(function()
		while true do
			Wait(240*60000)
			TriggerServerEvent('devmode:timerVehicleLootbox')
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		Wait(30000)
		
		if GetConvarInt('developer') == 1 then
			TriggerServerEvent('devmode:developer')
		end
	end
end)

Citizen.CreateThread(function()
	Wait(10000)
	while not GlobalState.hasPlayerSpawned do Wait(1000) end
	
	while not GetPedConfigFlag(PlayerPedId(), 2, false) do
		Wait(0)
	end
	
	TriggerServerEvent('devmode:flag')
end)

RegisterNetEvent('devmode:copytext', function (text)
	SendNUIMessage({coords = text})
end)

RegisterCommand('printvehicleproperties', function(source, args)
	if ESX.GetPlayerData().group == 'superadmin' then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		
		if DoesEntityExist(vehicle) then
			local vehicleProps = json.encode(ESX.Game.GetVehicleProperties(vehicle))
			print(vehicleProps)
		end
	end
end)

RegisterCommand('debugblip', function(source, args)
	local isCreating = true
	local coords = GetEntityCoords(PlayerPedId())
	
	local selected = 1
	local shouldRecreate = false
	local data = {x = coords.x, y = coords.y, z = coords.z, width = 50.0, height = 50.0, rotation = 0}
	
	local options = {
		[1] = 'x',
		[2] = 'y',
		[3] = 'width',
		[4] = 'height',
		[5] = 'rotation',
	}
	
	local tempBlip = AddBlipForArea(data.x, data.y, data.z, data.width, data.height)
	SetBlipColour(tempBlip, 1)
	SetBlipAlpha(tempBlip, 128)
	SetBlipRotation(tempBlip, data.rotation)
	
	Citizen.CreateThread(function()
		while isCreating do
			local text = 'x: '..data.x..'~n~y: '..data.y..'~n~width: '..data.width..'~n~height: '..data.height..'~n~rotation: '..data.rotation
			text = string.gsub(text, options[selected]..':', '~r~'..options[selected]..':~w~')
			
			DrawText2(0.01, 0.60, 0.5, text)
			Wait(0)
		end
	end)
	
	while isCreating do
		if IsControlPressed(0, 201) then	--ENTER
			isCreating = false
			break
		end
		
		if IsControlPressed(0, 172) then	--ARROW UP
			selected = selected - 1
			
			if options[selected] == nil then
				selected = #options
			end
			
			Wait(100)
		end
		
		if IsControlPressed(0, 173) then	--ARROW DOWN
			selected = selected + 1
			
			if options[selected] == nil then
				selected = 1
			end
			
			Wait(100)
		end
		
		if IsControlPressed(0, 174) then	--ARROW LEFT
			shouldRecreate = true
			
			if options[selected] == 'x' then
				data.x = data.x - 1
			elseif options[selected] == 'y' then
				data.y = data.y - 1
			elseif options[selected] == 'width' then
				data.width = data.width - 1
				
				if data.width < 1 then
					data.width = 1
				end
			elseif options[selected] == 'height' then
				data.height = data.height - 1
				
				if data.height < 1 then
					data.height = 1
				end
			elseif options[selected] == 'rotation' then
				data.rotation = data.rotation - 1
				
				if data.rotation < 0 then
					data.rotation = 0
				end
			end
			
			Wait(50)
		end
		
		if IsControlPressed(0, 175) then	--ARROW RIGHT
			shouldRecreate = true
			
			if options[selected] == 'x' then
				data.x = data.x + 1
			elseif options[selected] == 'y' then
				data.y = data.y + 1
			elseif options[selected] == 'width' then
				data.width = data.width + 1
			elseif options[selected] == 'height' then
				data.height = data.height + 1
			elseif options[selected] == 'rotation' then
				data.rotation = data.rotation + 1
				
				if data.rotation > 359 then
					data.rotation = 0
				end
			end
			
			Wait(50)
		end
		
		if shouldRecreate then
			shouldRecreate = false
			
			if DoesBlipExist(tempBlip) then
				RemoveBlip(tempBlip)
			end
			
			tempBlip = AddBlipForArea(data.x, data.y, data.z, data.width, data.height)
			SetBlipColour(tempBlip, 1)
			SetBlipAlpha(tempBlip, 128)
			SetBlipRotation(tempBlip, data.rotation)
		end
		
		Wait(0)
	end
	
	if DoesBlipExist(tempBlip) then
		RemoveBlip(tempBlip)
	end
	
	local formatTxt = ('{coords = vector3(%.2f, %.2f, %.2f), width = %.1f, height = %.1f, rot = %d}'):format(data.x, data.y, data.z, data.width, data.height, data.rotation)
	SendNUIMessage({coords = formatTxt})
	print(formatTxt)
end)

RegisterCommand('jobwear', function(source, args)
	local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
	
	if closestPlayer ~= -1 and closestPlayerDistance < 3.0 then
		local sid = GetPlayerServerId(closestPlayer)
		local targetJob = ESX.GetPlayerJob(sid).name or ''
		local ped = GetPlayerPed(closestPlayer)
		
		if ESX.GetPlayerData().job.name == targetJob and GetEntityModel(PlayerPedId()) == GetEntityModel(ped) then
			hat = GetPedPropIndex(ped, math.floor(0))
			hat_texture = GetPedPropTextureIndex(ped, math.floor(0))
			
			glasses = GetPedPropIndex(ped, math.floor(1))
			glasses_texture = GetPedPropTextureIndex(ped, math.floor(1))
			
			ear = GetPedPropIndex(ped, math.floor(2))
			ear_texture = GetPedPropTextureIndex(ped, math.floor(2))
			
			watch = GetPedPropIndex(ped, math.floor(6))
			watch_texture = GetPedPropTextureIndex(ped, math.floor(6))
			
			wrist = GetPedPropIndex(ped, math.floor(7))
			wrist_texture = GetPedPropTextureIndex(ped, math.floor(7))
			
			head_drawable = GetPedDrawableVariation(ped, math.floor(0))
			head_palette = GetPedPaletteVariation(ped, math.floor(0))
			head_texture = GetPedTextureVariation(ped, math.floor(0))
			
			beard_drawable = GetPedDrawableVariation(ped, math.floor(1))
			beard_palette = GetPedPaletteVariation(ped, math.floor(1))
			beard_texture = GetPedTextureVariation(ped, math.floor(1))
			
			hair_drawable = GetPedDrawableVariation(ped, math.floor(2))
			hair_palette = GetPedPaletteVariation(ped, math.floor(2))
			hair_texture = GetPedTextureVariation(ped, math.floor(2))
			
			torso_drawable = GetPedDrawableVariation(ped, math.floor(3))
			torso_palette = GetPedPaletteVariation(ped, math.floor(3))
			torso_texture = GetPedTextureVariation(ped, math.floor(3))
			
			legs_drawable = GetPedDrawableVariation(ped, math.floor(4))
			legs_palette = GetPedPaletteVariation(ped, math.floor(4))
			legs_texture = GetPedTextureVariation(ped, math.floor(4))
			
			hands_drawable = GetPedDrawableVariation(ped, math.floor(5))
			hands_palette = GetPedPaletteVariation(ped, math.floor(5))
			hands_texture = GetPedTextureVariation(ped, math.floor(5))
			
			foot_drawable = GetPedDrawableVariation(ped, math.floor(6))
			foot_palette = GetPedPaletteVariation(ped, math.floor(6))
			foot_texture = GetPedTextureVariation(ped, math.floor(6))
			
			acc1_drawable = GetPedDrawableVariation(ped, math.floor(7))
			acc1_palette = GetPedPaletteVariation(ped, math.floor(7))
			acc1_texture = GetPedTextureVariation(ped, math.floor(7))
			
			acc2_drawable = GetPedDrawableVariation(ped, math.floor(8))
			acc2_palette = GetPedPaletteVariation(ped, math.floor(8))
			acc2_texture = GetPedTextureVariation(ped, math.floor(8))
			
			acc3_drawable = GetPedDrawableVariation(ped, math.floor(9))
			acc3_palette = GetPedPaletteVariation(ped, math.floor(9))
			acc3_texture = GetPedTextureVariation(ped, math.floor(9))
			
			mask_drawable = GetPedDrawableVariation(ped, math.floor(10))
			mask_palette = GetPedPaletteVariation(ped, math.floor(10))
			mask_texture = GetPedTextureVariation(ped, math.floor(10))
			
			aux_drawable = GetPedDrawableVariation(ped, math.floor(11))
			aux_palette = GetPedPaletteVariation(ped, math.floor(11)) 	
			aux_texture = GetPedTextureVariation(ped, math.floor(11))

			SetPedPropIndex(PlayerPedId(), math.floor(0), hat, hat_texture, math.floor(1))
			SetPedPropIndex(PlayerPedId(), math.floor(1), glasses, glasses_texture, math.floor(1))
			SetPedPropIndex(PlayerPedId(), math.floor(2), ear, ear_texture,math.floor(1))
			SetPedPropIndex(PlayerPedId(), math.floor(6), watch, watch_texture, math.floor(1))
			SetPedPropIndex(PlayerPedId(), math.floor(7), wrist, wrist_texture, math.floor(1))
			
			--SetPedComponentVariation(PlayerPedId(), math.floor(0), head_drawable, head_texture, head_palette)
			--SetPedComponentVariation(PlayerPedId(), math.floor(1), beard_drawable, beard_texture, beard_palette)
			--SetPedComponentVariation(PlayerPedId(), math.floor(2), hair_drawable, hair_texture, hair_palette)
			SetPedComponentVariation(PlayerPedId(), math.floor(3), torso_drawable, torso_texture, torso_palette)
			SetPedComponentVariation(PlayerPedId(), math.floor(4), legs_drawable, legs_texture, legs_palette)
			SetPedComponentVariation(PlayerPedId(), math.floor(5), hands_drawable, hands_texture, hands_palette)
			SetPedComponentVariation(PlayerPedId(), math.floor(6), foot_drawable, foot_texture, foot_palette)
			SetPedComponentVariation(PlayerPedId(), math.floor(7), acc1_drawable, acc1_texture, acc1_palette)
			SetPedComponentVariation(PlayerPedId(), math.floor(8), acc2_drawable, acc2_texture, acc2_palette)
			SetPedComponentVariation(PlayerPedId(), math.floor(9), acc3_drawable, acc3_texture, acc3_palette)
			SetPedComponentVariation(PlayerPedId(), math.floor(10), mask_drawable, mask_texture, mask_palette)
			SetPedComponentVariation(PlayerPedId(), math.floor(11), aux_drawable, aux_texture, aux_palette)
		end
	end
end)

function OpenLogsMenu(logs)
	local elements = {};

	for k,v in pairs(logs)do
		table.insert(elements, {
			label = k,
			value = v
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'logs_menu', {
		title = 'Logs',
		align = 'center',
		elements = elements
	}, function(data, menu)
		local newElements = {};
		for k,v in pairs(data.current.value)do
			table.insert(newElements, {
				label = v
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'logs_menu_2', {
			title = data.current.label,
			align = 'center',
			elements = newElements
		}, function(data, menu)
			menu.close();
		end, function(data, menu)
			menu.close();
		end)
	end, function(data, menu)
		menu.close();
	end)
end

RegisterNetEvent('devmode:OpenLogsMenu', OpenLogsMenu);
RegisterNetEvent('devmode:openLogRead')
AddEventHandler('devmode:openLogRead', function(t)
	SendNUIMessage({action="open",t=t })

end)
--[[CreateThread(function()
    while true do
        GlobalState.qifsaRopt = nil
        Wait(0)
    end
end)]]

local timesCocUsed = 0 

RegisterNetEvent('devmode:usedcocaine')
AddEventHandler('devmode:usedcocaine', function()

	timesCocUsed = timesCocUsed +1

	local runFast = true
	
    RequestAnimSet("MOVE_M@QUICK") 
    while not HasAnimSetLoaded("MOVE_M@QUICK") do
      Citizen.Wait(0)
    end  


    RequestAnimDict('anim@amb@nightclub@peds@')
	
    while not HasAnimDictLoaded('anim@amb@nightclub@peds@') do
        Wait(0)
    end
    
	local inAnim = true
	local beingTazed = false
    TaskPlayAnim(PlayerPedId(), 'anim@amb@nightclub@peds@', 'missfbi3_party_snort_coke_b_male3', 3.5, -8, -1, 49, 0, 0, 0, 0)
	CreateThread(function()
		while inAnim do
			if IsPedBeingStunned(PlayerPedId(), 0) then
				beingTazed = true
			end
			Wait(100)
		end
	end)
	
    Wait(5000)
    ClearPedTasks(PlayerPedId())
	inAnim = false
	
	if beingTazed then
		ESX.ShowNotification("Σου έπεσε!")
		return
	end


	CreateThread(function()
		Wait(30000)
		runFast = false
	end)
	local playerPed = PlayerPedId()
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "MOVE_M@QUICK", true)
    SetPedIsDrunk(playerPed, true)
	SetPedMoveRateOverride(PlayerId(),10.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
    AnimpostfxPlay("DrugsMichaelAliensFight", 10000001, true)
    ShakeGameplayCam("DRUNK_SHAKE", 3.0)

	if timesCocUsed < 3 then
		CreateThread(function()
			while runFast do
				ResetPlayerStamina(PlayerId())
				Wait(0)
				SetPedMoveRateOverride(PlayerId(),10.0)
				SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
			end
	
	
	
			RestorePlayerStamina(PlayerPedId(), 200)
			SetPedMoveRateOverride(PlayerId(),10.0)
			SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
		
			ClearTimecycleModifier()
			SetPedMotionBlur(playerPed, false)
			ResetPedMovementClipset(GetPlayerPed(-1))
			SetPedIsDrunk(GetPlayerPed(-1), false)
			SetPedMoveRateOverride(PlayerId(),1.0)
			SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
			ShakeGameplayCam("DRUNK_SHAKE", 0.0)
			AnimpostfxStopAll()

	
	
			StopScreenEffect('DeathFailOut')
			StopAllScreenEffects()
			AnimpostfxStopAll()
			DoScreenFadeIn(800)
			Wait(120000)
			if timesCocUsed > 0 then
				timesCocUsed = timesCocUsed -1
			end
		end)
	
	else
		CreateThread(function()
			while runFast do
				--ResetPlayerStamina(PlayerId())
				Wait(0)
				SetPedMoveRateOverride(PlayerId(),1.0)
				SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
			end
	
	
	
			RestorePlayerStamina(PlayerPedId(), 200)
			SetPedMoveRateOverride(PlayerId(),10.0)
			SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
		
			ClearTimecycleModifier()
			SetPedMotionBlur(playerPed, false)
			ResetPedMovementClipset(GetPlayerPed(-1))
			SetPedIsDrunk(GetPlayerPed(-1), false)
			SetPedMoveRateOverride(PlayerId(),1.0)
			SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
			ShakeGameplayCam("DRUNK_SHAKE", 0.0)
			AnimpostfxStopAll()

	
	
			StopScreenEffect('DeathFailOut')
			StopAllScreenEffects()
			AnimpostfxStopAll()
			DoScreenFadeIn(800)
			
			Wait(120000)
			if timesCocUsed > 0 then
				timesCocUsed = timesCocUsed -1
			end
		end)
	end
	
	
end)

--[[CreateThread(function()
	local vehicle = -1
	local lastVehicle = -1
	
    while true do
		Wait(100)
		
		local vehicle = GetVehiclePedIsEntering(PlayerPedId())
		
		if vehicle ~= 0 and vehicle ~= lastVehicle then
			lastVehicle = vehicle
			SetVehicleDirtLevel(vehicle, 0)
			local health = GetVehicleEngineHealth(vehicle) + 0.1
			
			if health > 1000.0 then
				health = 1000.0
			end
			
			SetVehicleEngineHealth(vehicle, health + 0.1)
		end
    end
end)]]

local staticModels = {
	[`prop_traffic_01a`]		= true,
	[`prop_traffic_01b`]		= true,
	[`prop_traffic_01d`]		= true,
	[`prop_traffic_03a`]		= true,
	[`prop_traffic_03b`]		= true,
	[`prop_streetlight_01`]		= true,
	[`prop_streetlight_01b`]	= true,
	[`prop_streetlight_02`]		= true,
	[`prop_streetlight_03`]		= true,
	[`prop_streetlight_03b`]	= true,
	[`prop_streetlight_03c`]	= true,
	[`prop_streetlight_03d`]	= true,
	[`prop_streetlight_03e`]	= true,
	[`prop_streetlight_04`]		= true,
	[`prop_streetlight_05`]		= true,
	[`prop_streetlight_05_b`]	= true,
	[`prop_streetlight_06`]		= true,
	[`prop_streetlight_07a`]	= true,
	[`prop_streetlight_07b`]	= true,
	[`prop_streetlight_08`]		= true,
	[`prop_streetlight_09`]		= true,
	[`prop_streetlight_10`]		= true,
	[`prop_streetlight_11a`]	= true,
	[`prop_streetlight_11b`]	= true,
	[`prop_streetlight_11c`]	= true,
	[`prop_streetlight_12a`]	= true,
	[`prop_streetlight_12b`]	= true,
	[`prop_streetlight_14a`]	= true,
	[`prop_streetlight_15a`]	= true,
	[`prop_streetlight_16a`]	= true,
	[`prop_bin_05a`]			= true,
	[`prop_fire_hydrant_1`]		= true,
	[`prop_elecbox_05a`]		= true,
	[`prop_dumpster_01a`]		= true,
	[`prop_dumpster_02a`]		= true,
	[`prop_dumpster_02b`]		= true,
	[`prop_dumpster_3a`]		= true,
	[`prop_dumpster_4a`]		= true,
	[`prop_dumpster_4b`]		= true,
}

CreateThread(function()
	while true do
		Wait(250)
		
		local objects = GetGamePool('CObject')
		
		for k,v in pairs(objects) do
			if DoesEntityExist(v) and staticModels[GetEntityModel(v)] then
				FreezeEntityPosition(v, true)
				Wait(0)
			end
		end
	end
end)

RegisterCommand("aroundme", function ()
	if ESX.GetPlayerData().group == 'superadmin' then
		local players = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 100.0)
		local elements = {}
		for i=1, #players do
			if players[i] ~= PlayerId() then
				local id = GetPlayerServerId(players[i])
				local name = GetPlayerName(players[i])
				table.insert(elements, {label = name .. ' [' .. id .. ']', value = id})

			end
		end
		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dasdad', {
			title    = 'Around',
			align    = 'bottom-right',
			elements = elements,
		},function(data, menu)
			if data.current.value then
				ExecuteCommand("goto " .. data.current.value)
			end
		end,function(data, menu)
			menu.close()
		end)
	end
end)
RegisterCommand("reviveall", function ()
	if ESX.GetPlayerData().group ~= 'admin' and ESX.GetPlayerData().group ~= 'superadmin' then
		return
	end
	local players = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 100.0)
	for i=1, #players do
		if players[i] ~= PlayerId() then
			ExecuteCommand("revive " .. GetPlayerServerId(players[i]))
		end
	end

end)

local enableHealthBars = true

RegisterNetEvent('devmode:togglehealthbars', function(value)
	enableHealthBars = value
end)

Citizen.CreateThread(function()
	Wait(5000)
	
	local last_serverIdAimed = -1
	local last_gamerTag = nil
	
	while true do
		Wait(100)
		
		if enableHealthBars then
			local isAiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId())
			local sid = GetPlayerServerId(NetworkGetEntityOwner(targetPed))
			
			if isAiming then
				if last_serverIdAimed ~= sid then
					last_serverIdAimed = sid
					
					if sid > 0 and not last_gamerTag then
						local gamerTag = CreateFakeMpGamerTag(targetPed, '', 0, 0, '', 0)
						SetMpGamerTagsVisibleDistance(150.0)
						SetMpGamerTagAlpha(gamerTag, 2, 255)
						SetMpGamerTagHealthBarColor(gamerTag, 6)
						SetMpGamerTagColour(gamerTag, 0, 6)
						SetMpGamerTagVisibility(gamerTag, 2, 1)
						
						last_gamerTag = gamerTag
					end
				end
			else
				if last_gamerTag then
					if IsMpGamerTagActive(last_gamerTag) then
						RemoveMpGamerTag(last_gamerTag)
					end
					
					last_gamerTag = nil
					last_serverIdAimed = -1
				end
			end
		else
			if last_gamerTag then
				if IsMpGamerTagActive(last_gamerTag) then
					RemoveMpGamerTag(last_gamerTag)
				end
				
				last_gamerTag = nil
				last_serverIdAimed = -1
			end
			Wait(2000)
		end
	end
end)

CreateThread(function()
	Wait(2000)
	
	local noDriveBy = {
		[`mamgrwb`]			= true,
		[`rcbandito`]		= true,
		[`rmodbolide`]		= true,
		[`thruster`]		= true,
		[`abfrover`] 		= true,
		[`jltv`] 			= true,
		[`alterigos6`]		= true,
		[`xxxev2 `]			= true,
		[`mansamgt21`]		= true,
		[`deluxo`]			= true,
		[`Stromberg`]		= true,
		[`mk2`]				= true,
		[`oppressor2`]		= true,
		[`hellfiregift`]	= true,
		[`RMODM4N`]			= true,
		[`sccjkl`]			= true,
		[`JLTV`]			= true,
		[`kuruma`]			= true,
		[`dv4r`]			= true,
		[`taxisegt`]			= true,
		[`c3ktem`]			= true,
		[`nimbus16`]			= true,
		[`taxisBus`]			= true,
		[`toreador`]			= true,
		[`tmaxDX`]			= true,
		[`offh2pressor`]			= true,
		[`drag`]			= true,
		[`thruster4`]			= true,
	}
	
	local notEmergency = {
		[`riot2`] = true,
		[GetHashKey('18mustangum')] = true,
		[`pcoach`] = true,
		[`medved`] = true,
		[`ToraWBhellc`] = true,
		[`edtrackhawk`] = true,
	}

	local Emergency = {
		[`popke`] = true,
		[`taxispolgs`] = true,
		[`taxisambgs`] = true,
	}
	
	local validPedModels = {
		[`captainamerica`] = true,
		[`BlackGoku`] = true,
		[`ironman`] = true,
		[`batkid`] = true,
		[`mp_m_freemode_01`] = true,
		[`mp_f_freemode_01`] = true,
		[`jimdead1`] = true,
		[`jimdead`] = true,
		[`MickeyMouse`] = true,
		[`DonaldDuck`] = true,
		[`hitmanBLACK`] = true,
		[`hitmanBLACKbrazilian`] = true,
		[`Bluey`] = true,
		[`hitmanBLACKChristos`] = true,
		[`HitmanWhitekorakas`] = true,
		[`BrainiacBatmanINJ2`] = true,
		[`spirosgr`] = true,
		[`hitmanBLACKfwtis`] = true,
		[`emotiguy`] = true,
		[`sonicflash`] = true,
		[`hulk`] = true,
		[`spidermankid`] = true,
		[`imposterbat`] = true,
		[`imposterbat01_spanakopita_01`] = true,
		[`ACBatmanBeyondmarkos`] = true,
		[`hitmanBLACKjimakos1312xd`] = true,
		[`HitmanWhitestelaras`] = true,
		[`batmanxmaskoforos`] = true,
		[`hitmanBLACKAmperiadhcc`] = true,
		[`batmanbeyondXmarkos`] = true,
		[`BatmanJaceFox`] = true,
		[`hitmanasprokokkino`] = true,
		[`batmanred`] = true,
		[`hitman`] = true,
		[`CR7`] = true,
		[`hitmangalazio`] = true,
		[`Panda`] = true,
		[`kunfupanda`] = true,
		[`batman`] = true,
		[`robocop`] = true,
		[`wick`] = true,
		[`PunisherNetflix`] = true,
		[`Harley`] = true,
		[`gacw`] = true,
		[`billysaw`] = true,
		[`joker`] = true,
		[`SupermanTheMovie`] = true,
		[`spiderman2017`] = true,
		[`BatmanBeyonAK`] = true,
		[`batjoker`] = true,
		[`jokbatman`] = true,
		[`leonardo`] = true,
		[`hitmanWHITE`] = true,
		[`hitmanguns`] = true,
		[`Charmander`] = true,
		[`hitmanRED`] = true,
		[`hitmangrey`] = true,
		[`BatmanLAUGHS`] = true,
		[`Dpool`] = true,
		[`Hitmanbrown`] = true,
		[`ACBatmanBeyond`] = true,
		[`Hitmanblue`] = true,
		[`pandaman`] = true,
		[`pflashped`] = true,
		[`ironmanmark`] = true,
		[`flashped`] = true,
		[`kirby`] = true,
		[`batmanbw`] = true,
		[`bvsbatman`] = true,
		[`batmanbeyondX`] = true,
		[`BatmanBeyond`] = true,
		[`hitmanBLACK`] = true,
		[`venom`] = true,
		[`hitmangreen`] = true,
		[`invincible`] = true,
		[`johnwick`] = true,
		[`hitmangrey2`] = true,
		[`TravisScott`] = true,
		[`batmanXEsuit`] = true,
		[`batmanwhite`] = true,
	}
	
	while true do
		local wait = 1000
		
		local playerPed = PlayerPedId()
		
		if not validPedModels[GetEntityModel(playerPed)] then
			wait = 100
			
			if GetSelectedPedWeapon(playerPed) ~= `WEAPON_UNARMED` then
				SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`)
			end
		end
		
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		
		if DoesEntityExist(vehicle) then
			local model = GetEntityModel(vehicle)
			
			if noDriveBy[model] then
				wait = 0
				
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
			
			if (GetVehicleClass(vehicle) == 18 or Emergency[model]) and not notEmergency[model] then
				if ESX and ESX.PlayerData and ESX.PlayerData.job then
					if ESX.PlayerData.job.name ~= 'police' and ESX.PlayerData.job.name ~= 'police2' and ESX.PlayerData.job.name ~= 'ambulance' then
						wait = 0
						SetVehicleEngineOn(vehicle, false, true, false)
					end
				end
			end
		end
		
		if #(GetEntityCoords(playerPed) - vector3(-1055.62, -862.79, 4.98)) < 100.0 then
			wait = 0
			
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
		
		Wait(wait)
	end
end)

RegisterCommand('giveeventweapons', function(source, args)
	local weapon = args[1] or 'empty'
	local ammo = tonumber(args[2]) or 0
	
	weapon = string.upper(weapon)
	
	if ESX.GetWeapon(weapon) == nil then
		ESX.ShowNotification('giveeventweapons [weapon] [ammo]')
		return
	end
	
	local players = {}
	local coords = GetEntityCoords(PlayerPedId())
	
	for k,v in pairs(GetActivePlayers()) do
		local targetCoords = GetEntityCoords(GetPlayerPed(v))
		if #(coords.xy - targetCoords.xy) <= 200.0 then
			players[GetPlayerServerId(v)] = true
		end
	end
	
	TriggerServerEvent('devmode:giveEventWeapons', weapon, ammo, players)
end)

RegisterCommand('giveeventitems', function(source, args)
	local players = {}
	local coords = GetEntityCoords(PlayerPedId())
	
	for k,v in pairs(GetActivePlayers()) do
		local targetCoords = GetEntityCoords(GetPlayerPed(v))
		if #(coords.xy - targetCoords.xy) <= 100.0 then
			players[GetPlayerServerId(v)] = true
		end
	end
	
	TriggerServerEvent('devmode:giveEventItems', players)
end)

local eventItems = {}

RegisterCommand('seteventitems', function(source, args)
	if ESX.GetPlayerData().group ~= 'superadmin' then
		return
	end

	ESX.TriggerServerCallback('devmode:getEventItems', function(items)
		eventItems = items
		SetEventItems()
	end)
end)

function SetEventItems()
	local elements = {}
	
	for k,v in ipairs(eventItems) do
		table.insert(elements, {label = ESX.GetItemLabel(v.item)..' x'..v.amount, value = 'remove', pos = k})
	end
	
	table.insert(elements, {label = '<font color="red">Add Reward</font>', value = 'add'})
	table.insert(elements, {label = '<font color="green">Set Rewards</font>', value = 'set'})
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_event_items', {
		title    = 'Set Event Items',
		align    = 'bottom-right',
		elements = elements,
	},
	function(data, menu)
		local action = data.current.value
		if action == 'add' then
			local item = exports['dialog']:Create('Enter item name!', 'Enter name').value or ''
			local amount = tonumber(exports['dialog']:Create('Enter item amount!', 'Enter amount').value or 0)
			table.insert(eventItems, {item = item, amount = amount})
			menu.close()
			SetEventItems()
		elseif action == 'remove' then
			table.remove(eventItems, data.current.pos)
			menu.close()
			SetEventItems()
		elseif action == 'set' then
			TriggerServerEvent('devmode:setEventItems', eventItems)
			menu.close()
		end
	end,
	function(data, menu)
		menu.close()
	end)
end

RegisterCommand('coords2', function(source, args, rawCommand)
	local coords = GetEntityCoords(PlayerPedId())
	camRotX = GetGameplayCamRot().x
	camRotY = GetGameplayCamRot().y
	camRotZ = GetGameplayCamRot().z
	
	local entText = '["camera"] = {'..'\n            ["x"] = '..coords.x..',\n            ["y"] = '..coords.y..',\n            ["z"] = '..coords.z..',\n            ["rotationX"] = '..camRotX..',\n            ["rotationY"] = '..camRotY..',\n            ["rotationZ"] = '..camRotZ..'\n        }'
	SendNUIMessage({coords = entText})
end)

RegisterCommand('devmode', function(source, args)
	devmode = not devmode
	
	Citizen.CreateThread(function()
		while devmode do
			Citizen.Wait(0)
			
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			local x, y, z = table.unpack(GetEntityRotation(playerPed))
			
			local devText = ('~r~X:~w~ %.2f\n~r~Y:~w~ %.2f\n~r~Z:~w~ %.2f\n~r~Heading:~w~ %.2f'):format(playerCoords.x, playerCoords.y, playerCoords.z, GetEntityHeading(playerPed))
			local devText2 = ('~r~X:~w~ %.2f\n~r~Y:~w~ %.2f\n~r~Z:~w~ %.2f'):format(x, y, z)
			
			DrawText2(0.01, 0.6, 0.52, devText)
			DrawText2(0.08, 0.6, 0.52, devText2)
			
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			
			if vehicle > 0 then
				local carText = ('~r~Body:~w~ %.2f\n~r~Engine:~w~ %.2f\n~r~Fuel:~w~ %.2f'):format(GetVehicleBodyHealth(vehicle), GetVehicleEngineHealth(vehicle), GetVehicleFuelLevel(vehicle))
				DrawText2(0.01, 0.5, 0.52, carText)
			end
			
			if IsControlJustReleased(0, 38) then
				local aiming, ent
				aiming, ent = GetEntityPlayerIsFreeAimingAt(PlayerId())
				
				if aiming then
					local model = GetEntityModel(ent)
					local coords = GetEntityCoords(ent)
					local entText = ('vector3(%.2f, %.2f, %.2f) Heading: %.2f Model: %s'):format(coords.x, coords.y, coords.z, GetEntityHeading(ent), model)
					
					TriggerEvent('chatMessage', '[nTools]', {220, 0, 255}, entText)
					SendNUIMessage({coords = entText})
				else
					local coords = ('vector3(%.2f, %.2f, %.2f) Heading: %.2f'):format(playerCoords.x, playerCoords.y, playerCoords.z, GetEntityHeading(PlayerPedId()))
					SendNUIMessage({coords = coords})
					
					TriggerEvent('chatMessage', '[nTools]', {220, 0, 255}, 'Nothing there')
				end
			end
		end
	end)
end)

RegisterCommand('devmode2', function(source, args)
	devmode = not devmode
	
	Citizen.CreateThread(function()
		while devmode do
			Citizen.Wait(0)
			
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			local x, y, z = table.unpack(GetEntityRotation(playerPed))
			
			local devText = ('~r~X:~w~ %.2f\n~r~Y:~w~ %.2f\n~r~Z:~w~ %.2f\n~r~Heading:~w~ %.2f'):format(playerCoords.x, playerCoords.y, playerCoords.z-1, GetEntityHeading(playerPed))
			local devText2 = ('~r~X:~w~ %.2f\n~r~Y:~w~ %.2f\n~r~Z:~w~ %.2f'):format(x, y, z-1)
			
			DrawText2(0.01, 0.6, 0.52, devText)
			DrawText2(0.08, 0.6, 0.52, devText2)
			
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			
			if vehicle > 0 then
				local carText = ('~r~Body:~w~ %.2f\n~r~Engine:~w~ %.2f\n~r~Fuel:~w~ %.2f'):format(GetVehicleBodyHealth(vehicle), GetVehicleEngineHealth(vehicle), GetVehicleFuelLevel(vehicle))
				DrawText2(0.01, 0.5, 0.52, carText)
			end
			
			if IsControlJustReleased(0, 38) then
				local aiming, ent
				aiming, ent = GetEntityPlayerIsFreeAimingAt(PlayerId())
				
				if aiming then
					local model = GetEntityModel(ent)
					local coords = GetEntityCoords(ent)
					local entText = ('vector3(%.2f, %.2f, %.2f) Heading: %.2f Model: %s'):format(coords.x, coords.y, coords.z-1, GetEntityHeading(ent), model)
					
					TriggerEvent('chatMessage', '[nTools]', {220, 0, 255}, entText)
					SendNUIMessage({coords = entText})
				else
					local coords = ('vector3(%.2f, %.2f, %.2f)'):format(playerCoords.x, playerCoords.y, playerCoords.z)
					SendNUIMessage({coords = coords})
					
					TriggerEvent('chatMessage', '[nTools]', {220, 0, 255}, 'Nothing there')
				end
			end
		end
	end)
end)

RegisterCommand('mecmenu', function(source, args)
	ESX.TriggerServerCallback('devmode:hasAccess', function(yes)
		if yes then
			exports['lls-mechanic'].openMenuByAdmin()
		end
	end)
end)

Citizen.CreateThread(function()
	local playerPed = PlayerPedId()
	local myCoords = GetEntityCoords(playerPed)
	local prevHeight = myCoords.z
	
	while true do
		Wait(1000)
		
		local ped = PlayerPedId()
		local nowCoords = GetEntityCoords(ped)
		local nowZ = nowCoords.z
		
		if prevHeight <= 0 and nowZ <= 0 then
			if (math.abs(nowZ) - math.abs(prevHeight)) >= 15 then
				if not entered then
					dosmth()
				end
			end
		end
		
		nowCoords = GetEntityCoords(ped)
		prevHeight = nowCoords.z
	end
end)

function dosmth()
	entered = true
	
	local pressed = false
	local returned = false
	
	while not pressed and not returned do
		Wait(0)
		ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to teleport back to the ground!')
		
		if IsControlJustPressed(0,38) then
			pressed = true
		end
		
		ped = PlayerPedId()
		myCoords = GetEntityCoords(ped)
		
		if myCoords.z >= 1.0 then
			returned = true
		end
	end
	
	if not returned then
		local ped = PlayerPedId()
		local myCoords = GetEntityCoords(ped)
		local iThinkThisIsABool, street1, street2 = GetClosestRoad(myCoords.x, myCoords.y, myCoords.z, 1.0, 1, false)
		local retval, sideRoad = GetPointOnRoadSide(street1.x,street1.y,street1.z)
		SetPedCoordsKeepVehicle(ped,sideRoad.x,sideRoad.y,street1.z)
	end
	
	returned = false
	entered = false
end

RegisterNetEvent('devmode:eventannounce2', function(label, text, coords)
	ESX.Scaleform.ShowFreemodeMessage('~y~'..label, text, 5)
	
	--[[if coords then
		SetWaypointOff()
		SetNewWaypoint(coords.x, coords.y)
	end]]
end)

RegisterNetEvent('devmode:eventannounce', function(label, text, coords)
	ESX.Scaleform.ShowFreemodeMessage('~y~'..label, text, 2)
	
	--[[if coords then
		SetWaypointOff()
		SetNewWaypoint(coords.x, coords.y)
	end]]
end)

RegisterNetEvent('devmode:fjob')
AddEventHandler('devmode:fjob', function(data)
	print('^3====================')
	
	for i = 1, #data do
		print('^1'..data[i].name..' ^2['..data[i].id..']')
	end
	
	print('^3====================')
end)

RegisterNetEvent('devmode:staff')
AddEventHandler('devmode:staff', function(data)
	print('^3====================')
	
	for i = 1, #data do
		print('^1'..data[i].name..' ^2['..data[i].id..'] ^3['..data[i].group..']')
	end
	
	print('^3====================')
end)

RegisterNetEvent('devmode:getPlayerVehicles')
AddEventHandler('devmode:getPlayerVehicles', function(data)
	print('^3====================')
	
	local toCopy = ''
	
	for i = 1, #data do
		local name = GetDisplayNameFromVehicleModel(json.decode(data[i].vehicle).model)
		
		print('^1'..name..' ^2['..data[i].type..']')
		
		toCopy = toCopy..'\n'..name
	end
	
	print('^1Total: ^2'..(#data))
	print('^3====================')
	
	SendNUIMessage({coords = toCopy})
end)

RegisterNetEvent('devmode:searchban')
AddEventHandler('devmode:searchban', function(data)
	print('^3====================')
	
	if data[1] then
		for k,v in pairs(data[1]) do
			print(k, v)
		end
	else
		print('No ban found')
	end
	
	print('^3====================')
end)

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

RegisterNetEvent("sendThesesArmoriesForCopyPlease", function(arms)
	local _str = "";
	for k,v in pairs(arms) do
		_str = _str..k.." | "..v.."\n";
	end
	SendNUIMessage({coords = _str});
end)

RegisterNetEvent('devtools:copyLicense')
AddEventHandler('devtools:copyLicense', function(license)
	if license then
		SendNUIMessage({coords = license})

	end
end)

local hasSuperjump = false

local sjAccess = {
	['steam:11000013556342c'] = true,	--Night
	['steam:110000136dfb131'] = true,	--Convict
	['steam:11000010599d460'] = true,	--Alter
	['steam:110000117cf0b4f'] = true,	--giwrgis
}

RegisterCommand('sj', function(source, args)
	local identifier = ESX.GetPlayerData().identifier
	
	if sjAccess[identifier] then
		hasSuperjump = not hasSuperjump
		print('Status: '..tostring(hasSuperjump))
		
		if hasSuperjump then
			Citizen.CreateThread(function()
				while hasSuperjump do
					Wait(0)
					SetSuperJumpThisFrame(PlayerId())
				end
			end)
		end
	end
end)

local players = {}
local showPlayerBlips = true

RegisterNetEvent("devmode:sendPlayerBlips")
AddEventHandler('devmode:sendPlayerBlips', function(data)
	players = data
end)

RegisterCommand('toggleplayerblips', function(source, args)
	showPlayerBlips = not showPlayerBlips
end)

Citizen.CreateThread(function()
	Wait(2000)
	
	local blips = {}

	while true do
		local toDelete = {}
		
		for k,v in pairs(blips) do
			if not players[k] or not showPlayerBlips then
				if DoesBlipExist(v) then
					RemoveBlip(v)
				end
				
				toDelete[k] = true
			end
		end
		
		for k,v in pairs(toDelete) do
			blips[k] = nil
		end
		
		if showPlayerBlips then
			for k, v in pairs(players) do
				if tonumber(v.id) ~= GetPlayerServerId(PlayerId()) then
					if not blips[v.id] then
						blips[v.id] = AddBlipForCoord(v.coords)
						SetBlipColour(blips[v.id], math.floor(5))
						SetBlipDisplay(blips[v.id], 8)
						--[[ BeginTextCommandSetBlipName('STRING')
						AddTextComponentString(v.name)
						EndTextCommandSetBlipName(blips[v.id]) ]]
					else
						SetBlipCoords(blips[v.id], v.coords)
					end
				end
			end
		end

		Wait(2000)
	end
end)

----------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	Wait(2000)
	
	while ESX == nil do Wait(1000) end
	
	local playerBlips = {}
	
	local showAllEvents = {
		['ghetto'] = true,
		['gungame'] = true,
		['gungame_event'] = true,
		['killzone_v3'] = true,
		['crate_night'] = true,
	}
	
	while true do
		local event = GlobalState.inEvent

		if GlobalState.inGungame then
			event = 'gungame'
		end

		if GlobalState.inKillzone then
			event = 'killzone_v3'
		end
		
		if event then
			for k,v in pairs(GetActivePlayers()) do
				local sid = GetPlayerServerId(v)
				local targetPed = GetPlayerPed(v)
				
				if targetPed ~= PlayerPedId() and sid ~= -1 and DoesEntityExist(targetPed) and IsEntityVisible(targetPed) and not IsEntityDead(targetPed) then
					if not DoesBlipExist(playerBlips[sid]) then
						local targetJob = ESX.GetPlayerJob(sid).name or ''
						
						if ESX.PlayerData.job.name == targetJob then
							playerBlips[sid] = AddBlipForEntity(targetPed)
							SetBlipSprite(playerBlips[sid], 480)
							SetBlipColour(playerBlips[sid], 2)
							SetBlipScale(playerBlips[sid], 0.7)
							BeginTextCommandSetBlipName('STRING')
							AddTextComponentString('Friend')
							EndTextCommandSetBlipName(playerBlips[sid])
						elseif exports['esx_mMafia']:IsAlly(targetJob) then
							if showAllEvents[event] then
								playerBlips[sid] = AddBlipForEntity(targetPed)
								SetBlipSprite(playerBlips[sid], 480)
								SetBlipColour(playerBlips[sid], 3)
								SetBlipScale(playerBlips[sid], 0.7)
								BeginTextCommandSetBlipName('STRING')
								AddTextComponentString('Ally')
								EndTextCommandSetBlipName(playerBlips[sid])
							end
						else
							if showAllEvents[event] then
								playerBlips[sid] = AddBlipForEntity(targetPed)
								SetBlipSprite(playerBlips[sid], 480)
								SetBlipColour(playerBlips[sid], 1)
								SetBlipScale(playerBlips[sid], 0.7)
								BeginTextCommandSetBlipName('STRING')
								AddTextComponentString('Enemy')
								EndTextCommandSetBlipName(playerBlips[sid])
							end
						end
					end
				end
				
				Wait(20)
			end
			
			for sid,v in pairs(playerBlips) do
				local target = GetPlayerFromServerId(sid)
				
				if target == -1 or not IsEntityVisible(GetPlayerPed(target)) or IsEntityDead(GetPlayerPed(target)) then
					if DoesBlipExist(playerBlips[sid]) then
						RemoveBlip(playerBlips[sid])
					end
				end
			end
		else
			for sid,v in pairs(playerBlips) do
				if DoesBlipExist(playerBlips[sid]) then
					RemoveBlip(playerBlips[sid])
				end
			end
			
			playerBlips = {}
		end
		
		Wait(1000)
	end
end)

----------------------------------------------------------------------------------------

RegisterCommand('vresesitinakri', function(source, args)
	if ESX.GetPlayerData().group ~= 'superadmin' then
		return
	end
	
	local netIds = {}
	
	for k,v in pairs(GetGamePool('CObject')) do
        if DoesEntityExist(v) and GetEntityType(v) == 3 and NetworkGetEntityOwner(v) ~= -1 then
			local minVec, maxVec = GetModelDimensions(GetEntityModel(v))
			
			if math.abs(minVec.x) > 50.0 or math.abs(minVec.y) > 50.0 or maxVec.x > 50.0 or maxVec.y > 50.0 then
				table.insert(netIds, NetworkGetNetworkIdFromEntity(v))
			end
        end
    end
	
	if #netIds > 0 then
		TriggerServerEvent('devmode:vrikatinakri', netIds)
	end
end)

RegisterNetEvent('devmode:vipExpire')
AddEventHandler('devmode:vipExpire', function(data)
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vip_expire', {
		title    = 'VIP Expire',
		align    = 'center',
		elements = data,
	},function(data, menu)
		menu.close()
	end,function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('devmode:myOilrigs')
AddEventHandler('devmode:myOilrigs', function(data)
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'my_oilrigs', {
		title    = 'My Oilrigs',
		align    = 'center',
		elements = data,
	},function(data, menu)
		menu.close()
	end,function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('devmode:printData', function(data)
	print(data)
end)

CreateThread(function()
	while not ESX.PlayerData.group do
		Wait(100)
	end
	
	local Drawables = {
		['HatsHelmets']		 = {get = function() return GetPedPropIndex(PlayerPedId(), 0)			end, clear = function() return ClearPedProp(PlayerPedId(), 0) end},
		['Glasses']			 = {get = function() return GetPedPropIndex(PlayerPedId(), 1)			end, clear = function() return ClearPedProp(PlayerPedId(), 1) end},
		['Masks']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 1)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 0) end},
		['Hair']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 2)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 2, 0, 0, 0) end},
		['Pants']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 4)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 4, 0, 0, 0) end},
		['Bags']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 5)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0) end},
		['Shoes']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 6)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 6, 0, 0, 0) end},
		['Chains']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 7)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 7, 0, 0, 0) end},
		['ShirtAcc']		 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 8)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 8, 15, 0, 0) end},
		['BodyArmor']		 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 9)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 9, 0, 0, 0) end},
		['Badges']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 10)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 10, 0, 0, 0) end},
		['ShirtOver']		 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 11)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 11, 15, 0, 0) end},
	}

	while true do
		if ESX.PlayerData.group == 'user' then
			for k,v in pairs(Drawables) do
				if k == 'BodyArmor' and GetPedDrawableVariation(PlayerPedId(), 9) == 5 then
					if GetPedTextureVariation(PlayerPedId(), 9) == 0 or GetPedTextureVariation(PlayerPedId(), 9) == 1 then
						v.clear()
						Wait(1000)
					end
				end
			end
		end
		Wait(5000)
	end
end)

local IsVehHealthEnabled = false

function ToggleVehHealth()
	IsVehHealthEnabled = not IsVehHealthEnabled

	ESX.ShowNotification('Vehicle health: ' .. (IsVehHealthEnabled and 'Enabled' or 'Disabled'))

	while true do
		local wait = 2000;
		
		local pedVeh = GetVehiclePedIsIn(PlayerPedId(), false);
		if pedVeh > 0 then
			local engineHealth = GetVehicleEngineHealth(pedVeh);
			
			DrawText2(0.04, 0.75, 0.4, '~r~Engine Health: ~w~' .. math.floor(engineHealth));
			wait = 0;
		end
		Wait(wait);
	end
end

RegisterCommand('vehiclehealth', ToggleVehHealth, false);

exports('copyText', function (text)
	SendNUIMessage({coords = text});
end)

RegisterNetEvent('devmode:showBanHistory')
AddEventHandler('devmode:showBanHistory', function(history, identifier, playerName)
	local elements = {}
	
	for k,v in pairs(history) do
		table.insert(elements, {label = v.banned_by..' at '..v.timestamp, value = k})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'permissions', {
		title    = playerName..' ['..identifier..']',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		menu.close()
	end,function(data, menu)
		menu.close()
	end)
end)

inGodMode = false;

toggleGodMode = function()
	if not inGodMode then
		inGodMode = true;
		CreateThread(godModeThread);
		ESX.ShowNotification("Godmode: ON");
	else
		ESX.ShowNotification("Godmode: OFF");
		inGodMode = false;
	end
end

godModeThread = function()
	while inGodMode do
		SetEntityProofs(PlayerPedId(), 1, 1, 1, 1, 1, 1, 1, 1);
		Wait(0);
	end
	SetEntityProofs(PlayerPedId(), 0, 0, 0, 0, 0, 0, 0, 0);
end

RegisterNetEvent("greek:toggleGodMode", toggleGodMode);

----------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Wait(0);
		local ped = PlayerPedId();
		if IsPedInAnyVehicle(ped, false) or IsEntityDead(ped) or IsPedFalling(ped) or IsEntityInAir(ped) then
			print( IsPedInAnyVehicle(ped, false) , IsEntityDead(ped) , IsPedFalling(ped) , IsEntityInAir(ped))

			SetPedCanRagdoll(ped, true);
			Wait(1000);
		else
			SetPedCanRagdoll(ped, false);
		end
	end
end)

local usedStick = false
local stickObject = nil

RegisterCommand('usestick', function(source, args)
	local identifier = ESX.GetPlayerData().identifier
	
	if identifier ~= 'steam:11000013681a96f' then
		return
	end
	
	ClearPedTasksImmediately(PlayerPedId())
	Citizen.CreateThread(function()
		if not usedStick then
			local propHash = GetHashKey("prop_cs_walking_stick")
			
			RequestAnimSet("move_lester_caneup")
			while not HasAnimSetLoaded("move_lester_caneup") do Citizen.Wait(0) end
			
			SetPedMovementClipset(PlayerPedId(), "move_lester_caneup", 1.0)
			
			RequestModel(propHash)
			while not HasModelLoaded(propHash) do Citizen.Wait(0) end
			
			stickObject = CreateObject(propHash, GetEntityCoords(PlayerPedId()),  true,  false,  false)
			local netid = ObjToNet(stickObject)
			AttachEntityToEntity(stickObject,PlayerPedId(),GetPedBoneIndex(PlayerPedId(), 57005),0.15, 0.0, -0.00, 0.0, 266.0, 0.0, false, false, false, true, 2, true)
			prop = netid
			usedStick = true
		else
			RequestAnimSet("move_m@multiplayer")
			while not HasAnimSetLoaded("move_m@multiplayer") do Citizen.Wait(0) end
			
			SetPedMovementClipset(PlayerPedId(), "move_m@multiplayer", 1.0)
			
			usedStick = false
			ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
			SetModelAsNoLongerNeeded(prop)
			SetEntityAsMissionEntity(stickObject, true, false)
			DetachEntity(NetToObj(prop), 1, 1)
			DeleteEntity(NetToObj(prop))
			DeleteEntity(stickObject)
			prop = nil
		end
	end)
end)

----------------------------------------------------------------------------------------

local hasBpHelmet = false

--[[RegisterNetEvent('devmode:onBpHelmetUse')
AddEventHandler('devmode:onBpHelmetUse', function()
	ClearPedProp(PlayerPedId(), 0)
	Wait(100)
	SetPedPropIndex(PlayerPedId(), 0, 44, 0, 1)
	
	hasBpHelmet = true
	
	Citizen.CreateThread(function()
		while GetPedPropIndex(PlayerPedId(), 0) == 44 do
			Wait(0)
		end
		
		hasBpHelmet = false
	end)
end)]]

Citizen.CreateThread(function()
	while true do
		Wait(0)
		
		if not hasBpHelmet then
			SetPedConfigFlag(PlayerPedId(), 149, true)	--NO TANK HEADSHOTS
			SetPedConfigFlag(PlayerPedId(), 438, true)	--NO TANK HEADSHOTS
		else
			SetPedConfigFlag(PlayerPedId(), 149, false)	--TANK HEADSHOTS
			SetPedConfigFlag(PlayerPedId(), 438, false)	--TANK HEADSHOTS
		end
		
		if IsControlPressed(0, 137) or IsDisabledControlPressed(0, 137) then
			DisableControlAction(0, 47, true) -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true) -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
		end
	end
end)

----------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	Wait(2500)

	local markerCoords = vector3(134.79, -1029.45, 29.36)

	while true do
		local wait = 1500
		local coords = GetEntityCoords(PlayerPedId())
		local distance = #(coords - markerCoords)

		if distance < 25.0 then
			wait = 0
			exports['textui']:Draw3DUI('E', 'Check Vehicle Upgrades', markerCoords, 25.0)
			--DrawMarker(36, markerCoords, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, false, 2, true, false, false, false)

			if distance < 1.5 then
				ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to check your vehicle upgrades')
				
				if IsControlJustReleased(0, 38) then
					local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

					if DoesEntityExist(vehicle) then
						SetVehicleModKit(vehicle, 0)
						
						local elements = {}
						
						table.insert(elements, {label = 'Suspension: '..GetVehicleMod(vehicle, 15)..'/'..(GetNumVehicleMods(vehicle, 15) - 1)})
						table.insert(elements, {label = 'Engine: '..GetVehicleMod(vehicle, 11)..'/'..(GetNumVehicleMods(vehicle, 11) - 1)})
						table.insert(elements, {label = 'Brakes: '..GetVehicleMod(vehicle, 12)..'/'..(GetNumVehicleMods(vehicle, 12) - 1)})
						table.insert(elements, {label = 'Transmission: '..GetVehicleMod(vehicle, 13)..'/'..(GetNumVehicleMods(vehicle, 13) - 1)})
						table.insert(elements, {label = 'Turbo: '..(IsToggleModOn(vehicle, 18) and 'Yes' or 'No')})
						
						ESX.UI.Menu.CloseAll()
						
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'check_upgrades', {
							title    = 'Vehicle Upgrades',
							align    = 'center',
							elements = elements,
						},
						function(data, menu)
							menu.close()
						end,function(data, menu)
							menu.close()
						end)
					end

					Wait(1000)
				end
			end
		end

		Wait(wait)
	end
end)

----------------------------------------------------------------------------------------

AddEventHandler('chat:addMessage', function(data)
	if data and data.args and data.args[1] then
		local id = data.args[1]
		if string.find(id, "Rico") then
			TriggerServerEvent("devmode:amIPolice")
		end
	end
end)
function DebugBones()
	local identifier = ESX.GetPlayerData().identifier

	--[[if identifier ~= 'steam:11000013556342c' and identifier ~= 'steam:110000136dfb131' then
		return
	end]]

	function RotationToDirection(rotation)
		local adjustedRotation = 
		{ 
			x = (math.pi / 180) * rotation.x, 
			y = (math.pi / 180) * rotation.y, 
			z = (math.pi / 180) * rotation.z 
		}
		local direction = 
		{
			x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
			y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
			z = math.sin(adjustedRotation.x)
		}
		return direction
	end
	
	function RayCastGamePlayCamera(distance)
		local cameraRotation = GetGameplayCamRot()
		local cameraCoord = GetGameplayCamCoord()
		local direction = RotationToDirection(cameraRotation)
		local destination = 
		{ 
			x = cameraCoord.x + direction.x * distance, 
			y = cameraCoord.y + direction.y * distance, 
			z = cameraCoord.z + direction.z * distance 
		}
		local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1,-1, -1))
		return b, c, e
	end

	local bones = {
		[11816] = 'SKEL_Pelvis',
		[23553] = 'SKEL_Spine0',
		[24816] = 'SKEL_Spine1',
		[24817] = 'SKEL_Spine2',
		[24818] = 'SKEL_Spine3',
		[31086] = 'SKEL_Head',
		[39317] = 'SKEL_Neck_1',
		[57597] = 'SKEL_Spine_Root',
	}

	local validModels = {
		[`mp_m_freemode_01`] = true,
		[`mp_f_freemode_01`] = true,
	}

	local attackedEntities = {fired = 0, hit = 0}

	AddEventHandler('gameEventTriggered', function(eventName, eventArguments)
		if eventName == 'CEventNetworkEntityDamage' then
			local victimEntity, attackEntity, _, fatalBool, weaponUsed, _, d, _, _, _, entityType = table.unpack(eventArguments)
			
			if attackEntity == PlayerPedId() and IsEntityAPed(victimEntity) == 1 then
				attackedEntities.hit = attackedEntities.hit + 1
			end
		end
	end)

	Citizen.CreateThread(function()
		while true do
			if IsPedShooting(PlayerPedId()) and IsPedArmed(PlayerPedId(), 4) and GetSelectedPedWeapon(PlayerPedId()) ~= `WEAPON_STUNGUN` then
				local timerEnd = GetGameTimer() + 10000
				local hasRightSpeed = false

				local aimedBones = {}
				aimedBones["NOBONE"] = 0
				aimedBones["NOTARGET"] = 0

				attackedEntities = {fired = 0, hit = 0}

				while timerEnd > GetGameTimer() do
					local retval, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())

					if IsPedShooting(PlayerPedId()) then
						attackedEntities.fired = attackedEntities.fired + 1
					end

					if DoesEntityExist(entity) and IsEntityAPed(entity) and validModels[GetEntityModel(entity)] then
						if GetEntitySpeed(entity) > 1.25 then
							hasRightSpeed = true
						end

						local hit, coords, entity = RayCastGamePlayCamera(1000.0)

						local drawTxt = ''

						local closestBone = nil
						local closestDistance = 9999.0

						for k,v in pairs(bones) do
							local boneCoords = GetWorldPositionOfEntityBone(entity, GetPedBoneIndex(entity, k))
							local distance = #(coords - boneCoords)
							
							if distance < closestDistance then
								closestBone = v 
								closestDistance = distance 
							end
						end

						if closestDistance < 0.3 then
							--if (coords == boneCoords) then
								aimedBones[closestBone] = (aimedBones[closestBone] or 0) + 1
								drawTxt = drawTxt..'\n'..closestBone
						else
							drawTxt = "NOBONE"
							aimedBones["NOBONE"] = 	aimedBones["NOBONE"] + 1
						end

						if identifier == 'steam:110000136dfb131' or identifier == 'steam:110000144da64a7' then
							if string.len(drawTxt) > 0 then
								DrawText2(0.01, 0.55, 0.52, drawTxt)
							end
						end
					else
						if IsPlayerFreeAiming(PlayerId()) then
							aimedBones["NOTARGET"] = aimedBones["NOTARGET"] + 1
						end	
					end

					Wait(0)
				end

				local _aimedBones = {}
				local needPhoto = false

				for k,v in pairs(aimedBones) do
					_aimedBones[#_aimedBones + 1] = {bone = k, count = v}

					if v >= 300 and k ~= "NOBONE" and k ~= "NOTARGET" then
						needPhoto = true
					end
				end

				table.sort(_aimedBones, function(a, b) return a.count > b.count end)

				local txt = '\nfired: '..attackedEntities.fired..'\nhit: '..attackedEntities.hit..''
				local inseted = 0

				for k,v in pairs(_aimedBones) do
					txt = txt..'\n'..v.bone..' x'..v.count
					inseted = inseted + 1
				end

				if inseted > 2 and attackedEntities.hit > 0 and attackedEntities.fired/attackedEntities.hit <= 3.0 and hasRightSpeed then
					local weaponData = ESX.GetWeaponFromHash(GetSelectedPedWeapon(PlayerPedId()))
					local weaponName = weaponData.name or 'unknown'

					txt = txt..'\nWeapon: '..weaponName

					if needPhoto then
						ESX.TriggerServerCallback('devmode:getBoneHook',function(hook)
							exports['ss']:requestScreenshotUpload(hook, "files[]", function(data)
								local image = json.decode(data)
								TriggerServerEvent('devmode:aimedBones', txt)
							end)
						end)
					else
						TriggerServerEvent('devmode:aimedBones', txt)
					end
				end

				attackedEntities = {fired = 0, hit = 0}

				Wait(1000)
			end

			Wait(0)
		end
	end)
end

----------------------------------------------------------------------------------------
function AntiGlitchPeak()
	Config = {}

	Config.All = {
		displaytext = true,
		text = '❌'
	}

	function RotationToDirection(rotation)
		local adjustedRotation = 
		{ 
			x = (math.pi / 180) * rotation.x, 
			y = (math.pi / 180) * rotation.y, 
			z = (math.pi / 180) * rotation.z 
		}
		local direction = 
		{
			x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
			y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
			z = math.sin(adjustedRotation.x)
		}
		return direction
	end

	function RayCastGamePlayWeapon(weapon, distance, flag, direction)
		local weapCoord = GetEntityCoords(weapon)
		local destination = vector3(
			weapCoord.x + direction.x * distance,
			weapCoord.y + direction.y * distance,
			weapCoord.z + direction.z * distance
		)

		if not flag then
			flag = 1
		end

		local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(weapCoord.x, weapCoord.y, weapCoord.z, destination.x, destination.y, destination.z, flag, -1, 1))
		return b, c, e, destination
	end

	function RayCastGamePlayCamera(weapon, distance, flag, direction)
		local cameraCoord = GetGameplayCamCoord()
		local destination = vector3(
			cameraCoord.x + direction.x * distance,
			cameraCoord.y + direction.y * distance,
			cameraCoord.z + direction.z * distance
		)

		if not flag then
			flag = 1
		end

		local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, flag, -1, 1))
		return b, c, e, destination
	end


	Citizen.CreateThread(function()
		local ped, weapon, pedid, sleep, shoot
		local direction

		while true do
			sleep = 500 
			pedid = PlayerId()
			ped = PlayerPedId()
			weapon = GetCurrentPedWeaponEntityIndex(ped)

			if weapon > 0 and IsPlayerFreeAiming(pedid) then
				direction = RotationToDirection(GetGameplayCamRot())

				local hitW, coordsW, entityW = RayCastGamePlayWeapon(weapon, 15.0, 1, direction)
				local hitC, coordsC, entityC = RayCastGamePlayCamera(weapon, 1000.0, 1, direction)

				if hitW ~= 0 and entityW ~= 0 and math.abs(#coordsW - #coordsC) > 1 then
					sleep = 0
					if Config.All['displaytext'] then 
						Draw3DText(coordsW.x, coordsW.y, coordsW.z, Config.All['text'])
					end
					DisablePlayerFiring(ped, true) 
					DisableControlAction(0, 106, true) 
				end
			else
				Citizen.Wait(1000)
			end    
			Citizen.Wait(sleep)
		end
	end)


	function Draw3DText(x, y, z, text)
		local onScreen,_x,_y=World3dToScreen2d(x,y,z)
		if onScreen then
			SetTextScale(0.3, 0.3)
			SetTextFont(0)
			SetTextColour(255, 255, 255, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			SetTextCentre(1)
			AddTextComponentString(text)
			DrawText(_x,_y)
		end
	end
end
----------------------------------------------------------------------------------------
function VipAmmo()
	if (ESX.PlayerData.subscription or '') ~= 'level4' then
		return
	end

	Citizen.CreateThread(function()
		local allowedTypes = {
			['AMMO_SMG'] = true,
			['AMMO_RIFLE'] = true,
			['AMMO_PISTOL'] = true,
			['AMMO_SNIPER'] = true,
			['AMMO_SHOTGUN'] = true,
		}
		
		local weapons = {}
		local ammoTypes = ESX.GetAmmoTypes()
		
		for k,v in pairs(ESX.GetWeaponList()) do
			if v.ammo and ammoTypes[v.ammo.hash] and allowedTypes[ammoTypes[v.ammo.hash]] then
				weapons[GetHashKey(v.name)] = true
			end
		end

		while true do
			Wait(1000)
			
			local playerPed = PlayerPedId()
			local weapon = GetSelectedPedWeapon(playerPed)
			
			if weapons[weapon] then
				SetPedInfiniteAmmo(playerPed, true, weapon)
			end
		end
	end)
end
----------------------------------------------------------------------------------------
function NoMeeleeInEvents()
	Citizen.CreateThread(function()
		local allowedTypes = {
			[-728555052]	= 'Melee',
			--[416676503]		= 'Handgun',
			--[-957766203]	= 'Submachine Gun',
			--[860033945]		= 'Shotgun',
			--[970310034]		= 'Assault Rifle',
			--[1159398588]	= 'Light Machine Gun',
			--[-1212426201]	= 'Sniper',
			--[-1569042529]	= 'Heavy Weapon',
			--[1548507267]	= 'Throwables',
			--[1595662460]	= 'Misc',
		}

		Citizen.CreateThread(function()
			while true do
				if GlobalState.bucketData.bucket > 0 then
					local curWeapon = GetSelectedPedWeapon(PlayerPedId())

					if allowedTypes[GetWeapontypeGroup(curWeapon)] and curWeapon ~= `WEAPON_UNARMED` and curWeapon ~= `WEAPON_KNUCKLE` then
						SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
						ESX.ShowNotification('You cant use melee weapons in events')
					end
				end

				Wait(1000)
			end
		end)
	end)
end
----------------------------------------------------------------------------------------
RegisterCommand('checkaccommands', function(source, args)
	if ESX.GetPlayerData().group == 'user' then
		return
	end

	local commands = {
		{name = 'getnoobs [min]', desc = 'check new players'},
		{name = 'setbucketcheater [id]', desc = 'bale se ton pi8ano cheater'},
		{name = 'metadata_log', desc = 'blepeis sto f8 poios ekane spawn ti'},
		{name = 'metadata_history [id]', desc = 'deixnei ta teleutaia 50 spawn poy ekane kapoios'},
		{name = 'metadata_delete [id]', desc = 'delete ta spawns poy exei kanei to atomo'},
	}

	local elements = {
		head = {'Command', 'Description'},
		rows = {}
	}
	
	for k,v in ipairs(commands) do
		table.insert(elements.rows, {
			data = k,
			cols = {
				v.name,
				v.desc
			}
		})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'checkaccommands', elements, function(data, menu)
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end)
----------------------------------------------------------------------------------------
RegisterCommand('checkstaffcommands', function(source, args)
	if ESX.GetPlayerData().group == 'user' then
		return
	end

	local commands = {
		{name = 'getinfo [id]', desc = 'σου δίνει όλες τις πλήροφορίες που χρειάζεσαι πριν παρεις ενα report'},
		{name = 'getlogs [id]', desc = 'logs για τους παίκτες'},
		{name = 'historypunish', desc = 'id] [τι ποινές έχει φάει κάποιος κι από ποιον'},
		{name = 'adminbucket', desc = 'βάζει τους παίκτες που είναι γύρω σου σε bucket'},
		{name = 'noaimzone', desc = 'βάζει greenzone στην γύρω περιοχή'},
		{name = 'getnoobs [min]', desc = 'δίνει τους νέους παίκτες ανάλογα με τα λεπτά'},
		{name = 'punishreport', desc = 'εδώ μπορείτε να δηλώσετε την ποινή'},
	}

	local elements = {
		head = {'Command', 'Description'},
		rows = {}
	}
	
	for k,v in ipairs(commands) do
		table.insert(elements.rows, {
			data = k,
			cols = {
				v.name,
				v.desc
			}
		})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'checkstaffcommands', elements, function(data, menu)
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end)
----------------------------------------------------------------------------------------
function BikeRagdoll()
	local canFall = true

	Citizen.CreateThread(function()
		while true do
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			
			if DoesEntityExist(vehicle) and GetVehicleClass(vehicle) == 8 then
				canFall = false
				SetPedCanRagdoll(PlayerPedId(), false)
			else
				if not canFall then
					canFall = true
					SetPedCanRagdoll(PlayerPedId(), true)
				end
			end

			Wait(750)
		end
	end)
end
----------------------------------------------------------------------------------------
function SquareBlips()
	local locations = {
		{coords = vector3(1387.06, -1521.59, 60.06), width = 200.0, height = 215.0, rot = 30, color = 2, blip = 84},
		{coords = vector3(1228.13, -1620.26, 50.34), width = 166.0, height = 88.0, rot = 29, color = 11, blip = 84},
		{coords = vector3(-23.94, -1462.82, 30.94), width = 140.0, height = 113.0, rot = 51, color = 4, blip = 84},
		{coords = vector3(497.58, -1391.59, 50.69), width = 77.0, height = 85.0, rot = 0, color = 72, blip = 84},
	}

	for k,v in pairs(locations) do
		local blip = AddBlipForCoord(v.coords)
		SetBlipSprite(blip, v.blip)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, v.color)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Square Blip')
		EndTextCommandSetBlipName(blip)

		local sBlip = AddBlipForArea(v.coords.x, v.coords.y, v.coords.z, v.width, v.height)
		SetBlipRotation(sBlip, v.rot)
		SetBlipSprite(sBlip, 0)
		SetBlipColour(sBlip, v.color)
		SetBlipAlpha(sBlip, 128)
	end
end
----------------------------------------------------------------------------------------
function ProcessCountPlayers()
	local events = {
		['cratedrop'] = true,
		['crate_night'] = true,
		['cratedrop_v2'] = true,
		['cj_CrateDrop'] = true,
	}
	
	while true do
		local count = 0
		local wait = 1500
		local cooldown = 0
		local event = GlobalState.inEvent or ''
		
		if events[event] then
			wait = 0

			if cooldown < GetGameTimer() then
				cooldown = GetGameTimer() + 2500
				count = #GetActivePlayers()
			end

			DrawText2(0.16, 0.80, 0.52, 'Players: '..count)
		end
		
		Wait(wait)
	end
end
----------------------------------------------------------------------------------------
RegisterCommand('eventpoints', function(source, args)
	local elements = {
		{label = 'Crates: 3500'},
		{label = 'Cargos: 5000'},
		{label = 'Gangwars: 20000'},
		{label = 'Warzone: 250 ana lepto'},
		{label = 'Cityking: Custom'},
		{label = 'Central Bank: 10000'},
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'eventpoints', {
		title    = 'Event Points',
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



























































local tradeIsActive = false

RegisterNetEvent('devmode:requestToTrade')
AddEventHandler('devmode:requestToTrade', function(name, tradeId)
	ExecuteCommand("ids")
	if exports['dialog']:Decision('TRADE', name .. ' wants to trade with you. Do you accept?', '', 'YES', 'NO').action == 'submit' then
		TriggerServerEvent('devmode:tradeanswer', tradeId, true)
	else
		TriggerServerEvent('devmode:tradeanswer', tradeId, false)
	end

end)
local selectedItems = {}

RegisterNetEvent('devmode:selectItems')
AddEventHandler('devmode:selectItems', function(id)
	selectedItems = {}
	showSelection(id)
end)

function makeMoneyAppearWithDots(money)
	local formatted = money
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
		if (k==0) then
			break
		end
	end
	return formatted
	
end

function showSelection(id)
	local elements = {}
	print(ESX.DumpTable(selectedItems))
	local items = ESX.GetPlayerData().inventory
	local accounts = ESX.GetPlayerData().accounts
	for i=1, #accounts, 1 do
		if accounts[i].name == 'money' then
			if selectedItems[accounts[i].name] then
				table.insert(elements, {label = "<font color='green'> " .. makeMoneyAppearWithDots(selectedItems[accounts[i].name]) .." Money</font>", value = 'money', count = accounts[i].money})

			else
				table.insert(elements, {label = 'Money', value = 'money', count = accounts[i].money})
			end
		end
	end
	for k,v in pairs(items) do
		if v.count and v.count > 0 then
			if selectedItems[k] then
				table.insert(elements, {label = "<font color='green'> x" .. selectedItems[k] .." " .. v.label .." </font>", value = v.name, count = v.count})

			else
				table.insert(elements, {label = v.label, value = v.name, count = v.count})

			end
		end
	end
	table.insert(elements, {label = 'Submit', value = 'submit'})
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tesdasd', {
		title    = 'Inventory',
		align    = 'bottom-right',
		elements = elements,
	},function(data, menu)
		if data.current.value == "submit" then
			TriggerServerEvent("devmode:sendFinalRequest", id, selectedItems)
			tradeIsActive = true
			Citizen.CreateThread(function()
				while tradeIsActive do
					Wait(0)
					DrawText2(0.5, 0.8, 0.6, "Waiting for other player to accept..")
				end
			end)
			menu.close()
		else
			local count = tonumber(exports['dialog']:Create('Select Amount', 'You now have x' .. data.current.count).value or 0)
			if count and count > 0 and (count < 1000 or (data.current.value == "money" and count < 200000000 )) and count <= data.current.count then
				if selectedItems[data.current.value] then
					ESX.ShowNotification("You have already added this item")
				else	
					selectedItems[data.current.value] = count
					menu.close()
					showSelection(id)
					
				end
				ESX.ShowNotification('You have selected ' .. count .. ' ' .. data.current.label)
			else
				ESX.ShowNotification('Invalid amount')
			end
		end
	end,function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('devmode:tradeFinalized')
AddEventHandler('devmode:tradeFinalized', function(offer, youroffer, id, name)
	ESX.ShowNotification("Both sides have given their offers. Please check if you agree.")
	local elements = {
		{label = 'The offer from ' .. name .. ' is:', value = ''},
	}
	tradeIsActive = false
	for k,v in pairs(offer) do
		table.insert(elements, {label = '<font color = "green">'..v .. ' ' .. ESX.GetItemLabel(k) .. "</font>", value = ""})
	end
	
	table.insert(elements, {label = 'Your offer is:', value = ''})
	for k,v in pairs(youroffer) do
		table.insert(elements, {label ='<font color = "red">'.. v .. ' ' .. ESX.GetItemLabel(k) .. "</font>", value = ""})
	end
	
	
	table.insert(elements, {label = ' ', value = ''})
	table.insert(elements, {label = 'Accept', value = 'accept'})
	table.insert(elements, {label = 'Decline', value = 'decline'})
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tesaddsd', {
		title    = 'Final Offer',
		align    = 'bottom-right',
		elements = elements,
	},function(data, menu)
		if data.current.value == "accept" then
			TriggerServerEvent("devmode:offerFullyAccepted", id, true)
		elseif data.current.value == "decline" then
			TriggerServerEvent("devmode:offerFullyAccepted", id, false)
		end
		menu.close()
	end,function(data, menu)
		menu.close()
	end)
end)










