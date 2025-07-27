Config = {}

Config.RedzoneRadius = 100.0
Config.BombDuration = 300	--seconds
Config.LootDuration = 30	--seconds
Config.Repeat = 4			--times to repeat
Config.Cooldown = 3600		--seconds

Config.NPC = {
	model = `ig_agent`,
	coords = vector3(1007.18, 2388.06, 51.50),
	heading = 70.00
}

Config.Vehicle = {
	model = `rumpo`,
	coords = vector3(1000.88, 2390.19, 51.60),
	heading = 345.00
}

--dini lefta [line: 194]
Config.Rewards = {
	['coins'] = 100,
}

Config.ATMs = {
	{
		model = `prop_atm_01`,
		coords = vector3(2559.05, 389.47, 107.62),
		destination = vector3(2565.89, 391.29, 108.46),
	},
	{
		model = `prop_atm_01`,
		coords = vector3(540.22, 2671.68, 41.16),
		destination = vector3(540.95, 2676.76, 42.12),
	},
	{
		model = `prop_atm_01`,
		coords = vector3(-3240.03, 1008.55, 11.83),
		destination = vector3(-3236.73, 1008.12, 12.38),
	},
	{
		model = `prop_atm_01`,
		coords = vector3(1735.01, 6410.01, 34.04),
		destination = vector3(1733.50, 6403.57, 34.70),
	},
	{
		model = `prop_atm_01`,
		coords = vector3(-1827.69, 784.46, 137.32),
		destination = vector3(-1821.47, 782.32, 137.85),
	},
}