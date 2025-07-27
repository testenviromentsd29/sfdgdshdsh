Config = {}

Config.Coords = vector3(5019.41, -5737.36, 17.68)
Config.Radius = 200.0

Config.CaptureTime = 300			--seconds
Config.RewardsInterval = 600		--seconds
Config.DropWeaponsOnDeath = false	--Drop weapon on death?
Config.DeleteWeapons = 180			--Delete dropped weapons afted X seconds

Config.EventDuration = 2*3600	--seconds
Config.StartHour = 15
Config.StartMinute = 00

Config.Rewards = {
	'blueprint_M762',
	'blueprint_LGWII',
	'blueprint_HOWA',
	'blueprint_MAC10',
	'blueprint_M203',
	'blueprint_ANARCHY',
}

Config.NPC = {
	model = `g_m_y_mexgoon_03`,
	coords = vector3(227.54, -1601.15, 29.72),
	heading = 38.00,
}

Config.NotificationData = {
    name = 'ghetto',
    icon = '',
    text = 'GM EVENT',
    title = 'PLAY AND WIN',
    description = 'GM EVENT, Fight and Win. Only for TOP Shooters. '
}

Config.TPBlacklistedPositions = { --to 4 argument einai to radius
	vector4(2515.32, -379.19, 93.14, 100.0),
}