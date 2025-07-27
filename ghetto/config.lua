Config = {}

Config.RunningPeriodText = ''

Config.RewardPoints = 100
Config.RewardPointsInterval = 4		--Minutes

Config.MaxTotalWeapons = 2
Config.RewardWeaponsInterval = 15	--Minutes Must be > Config.RewardPointsInterval

Config.KillPoints = 100
Config.DeathPoints = 50

Config.KillPointsOnwed = 200
Config.KillsForPowerUp = 10			--needed kills to get a blueprint_powerup

Config.CaptureTime = 300

--Config.Coords = vector3(226.96, -1601.27, 29.70)
Config.Coords = { -- choosing randomly between those coordinates
	--{coords = vector3(5012.16, -5744.58, 19.88), heading = 325.00, radius = 275.00, respawnCoords = vector3(-46.20, -1222.63, 29.16)},
	{coords = vector3(227.54, -1601.15, 29.72), heading = 38.00, radius = 200.00, respawnCoords = vector3(-46.20, -1222.63, 29.16)},
	--{coords = vector3(227.54, -1601.15, 29.72), heading = 38.00, radius = 200.00, respawnCoords = vector3(770.56, -1407.73, 26.51)},
	--{coords = vector3(227.54, -1601.15, 29.72), heading = 38.00, radius = 200.00, respawnCoords = vector3(-191.38, -2015.25, 27.62)},
}

Config.Radius = 200.00
Config.ExtraRadius = 60.0

Config.EventStart = {
	{hour = 14, minute = 30},
}

Config.EventEnd = {
	{hour = 16, minute = 00},
}

Config.NotifyTime = 30						--Minutes to show the notification before the actual event starts

Config.EventWeekDayKillCount = 1			--Which day to get the weekly winner [1 = Sunday, 2 = Monday, 3 = Tuesday, 4 = Wednesday, 5 = Thursday, 6 = Friday, 7 = Saturday]

Config.EventKillsNeeded	= 10				--How many kills to give Config.EventGhettoCoinsPerNeededKills
Config.EventGhettoCoinsPerNeededKills = 10	--How many ghetto coins for Config.EventKillsNeeded kills

Config.WeeklyWinnerCoins = 5

Config.NPC = {
	model = `g_m_y_mexgoon_03`,
	coords = vector3(226.96, -1601.27, 29.70),
	heading = 82.00
}

Config.NotificationData = {
    name = 'ghetto',
    icon = '',
    text = 'GHETTO EVENT',
    title = 'PLAY AND WIN',
    description = 'GHETTO EVENT, Fight and Win. Only for TOP Shooters. Event Starts at 19:30'
}

Config.Weapons = {
	{name = 'blueprint_ACR',			label = 'ACR'},
	{name = 'blueprint_SCARMK17',		label = 'ScarMk17'},
	{name = 'blueprint_MDR',			label = 'MDR'},
	{name = 'blueprint_FENNEC',			label = 'Fennec'},
	{name = 'blueprint_AK12',			label = 'AK12'},
	{name = 'blueprint_BEOWULF',		label = 'Beowulf'},
	{name = 'blueprint_PP19',			label = 'PP19'},
	{name = 'blueprint_FNFALCMG',		label = 'FNFALCMG'},
	{name = 'blueprint_AVANDK',			label = 'AVANDK'},
	{name = 'blueprint_INTEGRALE553',	label = 'INTEGRALE553'},
}

Config.PoliceWeapons = {
	{name = 'blueprint_AUGA2',				label = 'AUGA2'},
	{name = 'blueprint_MARINE',				label = 'MARINE'},
	{name = 'blueprint_M4CQB',				label = 'M4CQB'},
	{name = 'blueprint_ARMK4',				label = 'ARMK4'},
	{name = 'blueprint_HK43',				label = 'HK43'},
	{name = 'blueprint_M16A1',				label = 'M16A1'},
	{name = 'blueprint_CARBINERIFLE_MK2',	label = 'CARBINERIFLE_MK2'},
}

Config.IgnoreVehicleModels = {
	[`trash`] = true,
	[`packer`] = true,
	[`boxville2`] = true,
	[`UtilliTruck3`] = true,
}

Config.TPBlacklistedPositions = { --to 4 argument einai to radius
	vector4(2515.32, -379.19, 93.14, 100.0),
}