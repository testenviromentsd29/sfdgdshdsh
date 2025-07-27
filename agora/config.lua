Config = {}

Config.Shops = {
	{
		shopLabel = 'Agora',
		Pos = vector3(45.95, 2788.40, 57.88),
		Items = {
			['raw_copper']				= { sellPrice = 15, useBlack = false, job = 'miner'},
			['raw_iron']				= { sellPrice = 15, useBlack = false, job = 'miner'},
			['kevlar']					= { sellPrice = 15, useBlack = false, job = 'miner'},
			
			['c_grapes_p']	= { sellPrice = 10000, useBlack = false, job = 'company1'},
		},
		Weapons = {
			--WEAPON_MINISMG = 			{label = 'Weapon Mini Smg', 			price = 375, 	useBlack = false},
		},
		Ped = {
			model = 'ig_jimmyboston',
			heading = 142.00
		},
		blip = {
			show = true,
			label = 'Agora',
			sprite = 365,
			color = 44,
		}
	},
}