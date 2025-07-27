Config = {}

Config.Cooldown = 1800   --seconds
Config.PrestartWait = 2		--seconds

Config.CargoPlate = 'CARCARGO'
Config.RedzoneRadius = 150.0

Config.NotificationData = {
    name = 'car-cargo',
	icon = '',
	text = 'CAR',
	title = 'CARGO',
	description = 'A criminal just started the transport of the Car, steal the Car and deliver.'
}

Config.NPC = {
	model	= `s_m_y_marine_03`,
	coords	= vector3(-1132.10, 2690.92, 18.80),
	heading	= 71.00
}

Config.Vehicle = {
	coords	= vector3(-1138.25, 2677.02, 18.09),
	heading	= 201.00,
	speed	= 30.0
}

Config.Destinations = {
	vector3(3799.76, 4462.13, 5.00),
	vector3(1617.11, 1180.97, 84.57),
}

Config.CargoRewards = {
    --['blueprint_REDDRAGON']		= 10,
	['vehicle']					= 'alter1',
	['vehicle2']					= 'alter2',
}