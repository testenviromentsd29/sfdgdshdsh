
Config = {}
Config.Locale = 'en'

Config.Accounts = {
	bank = _U('account_bank'),
	black_money = _U('account_black_money'),
	money = _U('account_money')
}

Config.StartingAccountMoney = {bank = 30000, money = 10000}

Config.EnableSocietyPayouts = false -- pay from the society account that the player is employed at? Requirement: esx_society
Config.EnableHud            = false -- enable the default hud? Display current job and accounts (black, bank & cash)
Config.MaxWeight            = 800   -- the max inventory weight without backpack
Config.PaycheckInterval     = 1 * 30000 -- how often to recieve pay checks in milliseconds
Config.EnableDebug          = false

Config.PaycheckIntervalBattleNet = 10 * 60000
Config.useBattleCoins       = false
Config.WeaponDurabillity    = true

Config.CountableWeapons = {
	[`WEAPON_BALL`] = true
}

Config.BlacklistedHelmets = {
	
}

Config.BlacklistedHair = {
	[67] = true,
}

Config.BlacklistLower = {
	[18] = true,
	[11] = true,
}

Config.BlacklistShirtOverlay = {
	[21] = true,
	[129] = true,
}

Config.WeightModifier = {
	['male'] = {
		['decals'] = {
			[1] = 1600,
		},
		
		['bags'] = {
			[27] = 1600,
			[28] = 1600,
			[29] = 1600,
			[46] = 1600,
			[47] = 1600,
			[48] = 1600,
			[49] = 1600,
			[50] = 1600,
			[51] = 1600,
			[52] = 1600,
			[53] = 1600,
			[83] = 1600,
			[84] = 1600,
			[87] = 1600,
			[88] = 1600,
			[89] = 1600,
			[90] = 1600,
			[91] = 1600,
			[92] = 1600,
			[93] = 1600,
			[94] = 1600,
			[107] = 1600,
			[108] = 1600,
		}
	},
	
	['female'] = {
		['decals'] = {
			[1] = 1600,
		},
		
		['bags'] = {
			[21] = 1600,
			[22] = 1600,
			[23] = 1600,
			[40] = 1600,
			[41] = 1600,
			[44] = 1600,
			[45] = 1600,
			[81] = 1600,
			[82] = 1600,
			[85] = 1600,
			[86] = 1600,
		}
	}
}

Config.WeaponDurabillityRates = {
	["WEAPON_PETROLCAN"] = 0.0,
	--AR

	["WEAPON_GUSENBEG"] = 0.25,
	["WEAPON_CARBINERIFLE_MK2"] = 0.25,
	["WEAPON_LVOAC"] = 0.25,
	["WEAPON_ASSAULTRIFLE"] = 0.25,
	["WEAPON_ADVANCEDRIFLE"] = 0.25,
	["WEAPON_BULLPUPRIFLE_MK2"] = 0.25,
	["WEAPON_RPK"] = 0.25,
	["WEAPON_M16A1"] = 0.25,
	["WEAPON_AUGA1"] = 0.25,
	["WEAPON_SPECIALCARBINE_MK2"] = 0.25,
	["WEAPON_SPECIALCARBINE"] = 0.25,
	["WEAPON_CARBINERIFLE"] = 0.25,
	["WEAPON_ASSAULTRIFLE_MK2"] = 0.25,
	["WEAPON_GALIL"] = 0.25,
	["WEAPON_G36K"] = 0.25,
	["WEAPON_AUG"] = 0.25,
	["WEAPON_SIG516"] = 0.25,
	["WEAPON_SMG"] = 0.33,				--SMG
	["WEAPON_COMBATPDW"] = 0.33,
	["WEAPON_MINISMG"] = 0.33,
	["WEAPON_MICROSMG"] = 0.33,
	["WEAPON_COMPACTRIFLE"] = 0.33,
	["WEAPON_AKM"] = 0.33,
	["WEAPON_SMG_MK2"] = 0.33,
	["WEAPON_ASSAULTSMG"] = 0.33,
	["WEAPON_MP5A1"] = 0.33,
	["WEAPON_MPX"] = 0.33,
	["WEAPON_MACHINEPISTOL"] = 0.50, 	--PISTOL
	["WEAPON_APPISTOL"] = 0.50,
	["WEAPON_VINTAGEPISTOL"] = 0.66,
	["WEAPON_REVOLVER"] = 0.66,
	["WEAPON_HEAVYPISTOL"] = 0.66,
	["WEAPON_PISTOL"] = 0.66,
	["WEAPON_PISTOL50"] = 0.66,
	["WEAPON_SNSPISTOL"] = 0.66,
	["WEAPON_COMBATPISTOL"] = 0.66,
	["WEAPON_GLOCK17"] = 0.66,
	["WEAPON_PUMPSHOTGUN"] = 0.66 	--SHOTGUN
}