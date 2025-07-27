Config = {}

Config.Color = 1
Config.Alpha = 150

Config.Sprite = 310
Config.Size = 0.8
Config.BlipColor = 39 
Config.Name = "Crate Drop"

Config.EventBucket = 'CrateDrop'

Config.MoneyReward = 0

Config.BlackMoneyReward = 0

Config.ItemRewards = {}

Config.ItemRewards2 = {}

Config.ItemRewards3 = {
	['blueprint_G36K_2'] = 2,
	['blueprint_G3_2'] = 2,
	['blueprint_M133_2'] = 2,
	['blueprint_BAS_P_RED'] = 2,
	['blueprint_AKPU'] = 2,
	['painkiller3'] = 20,
	['bulletproof6'] = 20,
	['bounty_jammer'] = 20,
	['sonar'] = 20,
}

Config.NotificationData = {
    name = 'crate-drop',
	icon = '',
	text = 'CRIMINAL',
	title = 'CRATE DROP',
	description = 'A crate with Weapons and Vests will be dropped, collect the crate and get the rewards'
}

Config.WeaponRewards = {
}

--timers in seconds
Config.CrateCollectTimer = 30
Config.TimeUntilPlaneArrives = 600

Config.Locations = {
	{name = "Crate Drop", x = -777.70, 		y = 1650.53, 	z = 202.92,		radius = 200.0},
	{name = "Crate Drop", x = -2040.19, 	y = 931.84, 	z = 180.88,		radius = 200.0},
	{name = "Crate Drop", x = -1517.26, 	y = 1446.98, 	z = 120.22,		radius = 200.0},
	{name = "Crate Drop", x = 1502.03, 		y = 1669.73, 	z = 111.76,		radius = 200.0},
	{name = "Crate Drop", x = 2114.23, 		y = 1889.15, 	z = 93.39,		radius = 200.0},
	{name = "Crate Drop", x = 1857.81, 		y = 375.88, 	z = 161.66,		radius = 200.0},
	{name = "Crate Drop", x = 464.32, 		y = 664.36, 	z = 193.69,		radius = 200.0},
	{name = "Crate Drop", x = 1649.17, 		y = -1369.61, 	z = 83.41,		radius = 200.0},
	{name = "Crate Drop", x = 1451.95, 		y = -2395.98, 	z = 66.80,		radius = 200.0},
	{name = "Crate Drop", x = 1222.87, 		y = -2056.49, 	z = 44.36,		radius = 200.0},
}

Config.Locs = {}
for i, v in ipairs(Config.Locations) do
	local pos = math.random(1, #Config.Locs+1)
	table.insert(Config.Locs, pos, v)
end

Config.Hours = {
	{startHour = 00, startMinute = 30},
	{startHour = 01, startMinute = 30},
	{startHour = 02, startMinute = 30},
	{startHour = 03, startMinute = 30},
	{startHour = 04, startMinute = 30},
	{startHour = 05, startMinute = 30},
	{startHour = 06, startMinute = 30},
	{startHour = 07, startMinute = 30},
	{startHour = 08, startMinute = 30},
	{startHour = 09, startMinute = 30},
	{startHour = 10, startMinute = 30},
	{startHour = 11, startMinute = 30},
	{startHour = 12, startMinute = 30},
	{startHour = 13, startMinute = 30},
	{startHour = 14, startMinute = 30},
	{startHour = 15, startMinute = 30},
	{startHour = 16, startMinute = 30},
	{startHour = 17, startMinute = 30},
	{startHour = 18, startMinute = 30},
	{startHour = 19, startMinute = 30},
	{startHour = 20, startMinute = 30},
	{startHour = 21, startMinute = 30},
	{startHour = 22, startMinute = 30},
	{startHour = 23, startMinute = 30},
}