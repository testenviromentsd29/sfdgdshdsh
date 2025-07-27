Config = {}

Config.EnterCooldown = 5			--seconds
Config.GungameKills = {1, 3}
Config.GungameLevels = {60, 100}
Config.ExitLocation = vector3(182.09, -922.46, 30.69)
Config.DrawTextMsg = 'Join the gungame event'

Config.Locations = {
	--{coords = vector3(982.33, -3009.48, 5.90),		radius = 100.0},
	--{coords = vector3(297.26, -2003.52, 20.44),		radius = 100.0},
	{coords = vector3(-1186.25, 37.60, 52.72),		radius = 100.0},
	{coords = vector3(996.28, 2275.28, 49.21),		radius = 100.0},
	{coords = vector3(-2116.65, 3067.66, 32.82),	radius = 100.0},
	{coords = vector3(-1349.04, -3039.39, 13.95),	radius = 100.0},
}

Config.Hours = {
	{startHour = 00, startMinute = 00},
	{startHour = 02, startMinute = 00},
	{startHour = 04, startMinute = 00},
	{startHour = 06, startMinute = 00},
	{startHour = 08, startMinute = 00},
	{startHour = 10, startMinute = 00},
	{startHour = 12, startMinute = 00},
	{startHour = 14, startMinute = 00},
	{startHour = 16, startMinute = 00},
	{startHour = 18, startMinute = 00},
	{startHour = 20, startMinute = 00},
	{startHour = 22, startMinute = 00},
}

Config.Rewards = {
	['capacityvip'] = 1,
}

Config.BlacklistedWeapons = {
	['WEAPON_AWP_GOLD'] = true,
	['WEAPON_SCAR-L_G'] = true,
	['WEAPON_GORILLA_GUN'] = true,
	['WEAPON_DESERT_EAGLE_GOLD'] = true,
	['WEAPON_AK12'] = true,
}