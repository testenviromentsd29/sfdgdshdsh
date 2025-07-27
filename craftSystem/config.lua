Config = {}

Config.ItemTypes = {
	['security'] = {
		{
			name = 'bulletproof8',
			quantity = 1,
			needed = {
				{ name = "bank", label = 'Cash', amount = 500000 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
	},
	['blacksmith'] = {
		{
			name = 'blueprint_HFAP',
			quantity = 1,
			needed = {
				{ name = "recipe_AR", amount = 1 },
				{ name = "recipe_SMG", amount = 1 },
				{ name = "recipe_PISTOL", amount = 1 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
		{
			name = 'blueprint_M4A5V2',
			quantity = 1,
			needed = {
				{ name = "recipe_AR", amount = 1 },
				{ name = "recipe_SMG", amount = 1 },
				{ name = "recipe_PISTOL", amount = 1 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
		{
			name = 'blueprint_GRAU_2',
			quantity = 1,
			needed = {
				{ name = "recipe_AR", amount = 1 },
				{ name = "recipe_SMG", amount = 1 },
				{ name = "recipe_PISTOL", amount = 1 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
		{
			name = 'blueprint_M133_2',
			quantity = 1,
			needed = {
				{ name = "recipe_AR", amount = 1 },
				{ name = "recipe_SMG", amount = 1 },
				{ name = "recipe_PISTOL", amount = 1 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
		{
			name = 'blueprint_AK47_NIGHTWISH',
			quantity = 1,
			needed = {
				{ name = "recipe_AR", amount = 1 },
				{ name = "recipe_SMG", amount = 1 },
				{ name = "recipe_PISTOL", amount = 1 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
	},
	['lab'] = {
		{
			name = 'painkiller5',
			quantity = 1,
			needed = {
				{ name = "painkiller3", amount = 5 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
		{
			name = 'mytia_cocainis',
			quantity = 1,
			needed = {
				{ name = "cocaleaf", amount = 25 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
		{
			name = 'trifyllo_tsigaraki',
			quantity = 1,
			needed = {
				{ name = "cannabis", amount = 25 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
		{
			name = 'powerrade',
			quantity = 1,
			needed = {
				{ name = "painkiller3", amount = 2 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
	},
	['football'] = {
		{
			name = 'blueprint_BOTTLE',
			quantity = 1,
			needed = {
				{ name = "black_money", label = 'Dirty Money', amount = 5000 },
				{ name = "bank", label = 'Cash', amount = 5000 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
		{
			name = 'blueprint_BAT',
			quantity = 1,
			needed = {
				{ name = "black_money", label = 'Dirty Money', amount = 5000 },
				{ name = "bank", label = 'Cash', amount = 5000 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
		{
			name = 'blueprint_DAGGER',
			quantity = 1,
			needed = {
				{ name = "black_money", label = 'Dirty Money', amount = 5000 },
				{ name = "bank", label = 'Cash', amount = 5000 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
		{
			name = 'blueprint_NIGHTSTICK',
			quantity = 1,
			needed = {
				{ name = "black_money", label = 'Dirty Money', amount = 5000 },
				{ name = "bank", label = 'Cash', amount = 5000 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
		{
			name = 'blueprint_KNUCKLE',
			quantity = 1,
			needed = {
				{ name = "black_money", label = 'Dirty Money', amount = 5000 },
				{ name = "bank", label = 'Cash', amount = 5000 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
		{
			name = 'blueprint_HAMMER',
			quantity = 1,
			needed = {
				{ name = "black_money", label = 'Dirty Money', amount = 5000 },
				{ name = "bank", label = 'Cash', amount = 5000 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
		{
			name = 'blueprint_STONE_HATCHET',
			quantity = 1,
			needed = {
				{ name = "black_money", label = 'Dirty Money', amount = 5000 },
				{ name = "bank", label = 'Cash', amount = 5000 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
		{
			name = 'blueprint_MACHETE',
			quantity = 1,
			needed = {
				{ name = "black_money", label = 'Dirty Money', amount = 5000 },
				{ name = "bank", label = 'Cash', amount = 5000 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
		{
			name = 'blueprint_SWITCHBLADE',
			quantity = 1,
			needed = {
				{ name = "black_money", label = 'Dirty Money', amount = 5000 },
				{ name = "bank", label = 'Cash', amount = 5000 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
		{
			name = 'blueprint_BATTLEAXE',
			quantity = 1,
			needed = {
				{ name = "black_money", label = 'Dirty Money', amount = 5000 },
				{ name = "bank", label = 'Cash', amount = 5000 },
			},
			duration = 4, 
			animation = {command = 'mechanic'}
		},
	},
}

Config.Preconfig = {
	['security']	= {coords = vector3(7461.87, 5093.83, 119.03),	discount = 0.0},
	['blacksmith']	= {coords = vector3(3611.76, -211.15, 127.19),	discount = 0.0},
	['lab']			= {coords = vector3(3554.39, -830.14, 2029.29),	discount = 0.0},
}

Config.PreconfigOmilos = {
	['blacksmith']	= {coords = vector3(-2501.84, -1188.85, 1034.68),	discount = 0.0},
	['lab']			= {coords = vector3(-2550.99, -1199.70, 1034.68),	discount = 0.0},
}

Config.JobsZones = {
	nojob = {
		{
			job = 'blacksmith1',
			discount = 0.0,
			coords = vector3(3611.76, -211.15, 127.19),
			items = Config.ItemTypes['blacksmith']
		},
		{
			job = 'blacksmith2',
			discount = 0.0,
			coords = vector3(3611.76, -211.15, 127.19),
			items = Config.ItemTypes['blacksmith']
		},
		{
			job = 'blacksmith3',
			discount = 0.0,
			coords = vector3(3611.76, -211.15, 127.19),
			items = Config.ItemTypes['blacksmith']
		},
		{
			job = 'blacksmith4',
			discount = 0.0,
			coords = vector3(3611.76, -211.15, 127.19),
			items = Config.ItemTypes['blacksmith']
		},
		{
			job = 'blacksmith5',
			discount = 0.0,
			coords = vector3(3611.76, -211.15, 127.19),
			items = Config.ItemTypes['blacksmith']
		},
		{
			job = 'blacksmith6',
			discount = 0.0,
			coords = vector3(3611.76, -211.15, 127.19),
			items = Config.ItemTypes['blacksmith']
		},
		{
			job = 'blacksmith7',
			discount = 0.0,
			coords = vector3(3611.76, -211.15, 127.19),
			items = Config.ItemTypes['blacksmith']
		},
		{
			job = 'blacksmith8',
			discount = 0.0,
			coords = vector3(3611.76, -211.15, 127.19),
			items = Config.ItemTypes['blacksmith']
		},
		{
			job = 'lab1',
			discount = 0.0,
			coords = vector3(3554.39, -830.14, 2029.29),
			items = Config.ItemTypes['lab']
		},
		{
			job = 'lab2',
			discount = 0.0,
			coords = vector3(3554.39, -830.14, 2029.29),
			items = Config.ItemTypes['lab']
		},
		{
			job = 'lab3',
			discount = 0.0,
			coords = vector3(3554.39, -830.14, 2029.29),
			items = Config.ItemTypes['lab']
		},
		{
			job = 'lab4',
			discount = 0.0,
			coords = vector3(3554.39, -830.14, 2029.29),
			items = Config.ItemTypes['lab']
		},
		{
			job = 'lab5',
			discount = 0.0,
			coords = vector3(3554.39, -830.14, 2029.29),
			items = Config.ItemTypes['lab']
		},
		{
			job = 'lab6',
			discount = 0.0,
			coords = vector3(3554.39, -830.14, 2029.29),
			items = Config.ItemTypes['lab']
		},
		{
			job = 'lab7',
			discount = 0.0,
			coords = vector3(3554.39, -830.14, 2029.29),
			items = Config.ItemTypes['lab']
		},
		{
			job = 'company1',
			discount = 0.0,
			coords = vector3(-1926.58, 2042.14, 140.83),
			items = {
				{
					name = 'c_grapes_p',
					quantity = 1,
					needed = {
						{ name = "c_grapes", amount = 5 },
					},
					duration = 8, 
					animation = {command = 'mechanic'}
				},
			}
		},
		--[[{
			job = 'veh_factory1',
			discount = 0.0,
			coords = vector3(1177.56, 2636.45, 37.75),
			items = {
				{
					name = 'alter1',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'alter2',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'alter5',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rsq8m',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'zr3802',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'cerberus2',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'bruiser2',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory2',
			discount = 0.0,
			coords = vector3(1245.03, 1868.08, 79.10),
			items = {
				{
					name = 'lionscity',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'alter1',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'alter2',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'alter5',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'insurgent2',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodmustang',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = '18citaro',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'taxischerokee99',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'epic_mc',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'SSG_Comet6',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory3',
			discount = 0.0,
			coords = vector3(2513.55, -459.31, 92.99),
			items = {
				{
					name = 'alter1',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'alter2',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'alter5',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory4',
			discount = 0.0,
			coords = vector3(1257.86, -1971.02, 43.26),
			items = {
				{
					name = 'alter1',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'alter2',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'alter5',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'oycm3',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory5',
			discount = 0.0,
			coords = vector3(-131.43, -1181.16, 25.29),
			items = {
				{
					name = 'g63',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'dm1200',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rx84',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'huralbnormal',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'gnats2',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'RX8R',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'vigerozxwb',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'mgt18lb',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'oycs7lm',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'sl65bs09',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory6',
			discount = 0.0,
			coords = vector3(488.96, -1328.84, 29.24),
			items = {
				{
					name = 'g63',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'dm1200',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'amggt63',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'sl63amg22',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'taxisrs',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory7',
			discount = 0.0,
			coords = vector3(957.65, -109.93, 74.40),
			items = {
				{
					name = 'g63',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'dm1200',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'mvisiongt',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'wildtrak',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory8',
			discount = 0.0,
			coords = vector3(-549.10, -889.69, 25.09),
			items = {
				{
					name = 'g63',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'dm1200',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'w223b50',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'brabusgt600',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory9',
			discount = 0.0,
			coords = vector3(458.59, 261.07, 103.20),
			items = {
				{
					name = 'g63',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'dm1200',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'M3G80TDB',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory10',
			discount = 0.0,
			coords = vector3(-708.60, -871.46, 23.46),
			items = {
				{
					name = 'g63',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'dm1200',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory11',
			discount = 0.0,
			coords = vector3(193.85, -1252.45, 29.21),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'huralbnormal',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'RX8R',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'sl65bs09',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'stingraywb',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'lawmaster',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'lykan',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'taxisbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 's14legend',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'deluxo2',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory12',
			discount = 0.0,
			coords = vector3(550.10, -136.69, 59.29),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'taxisPatriot',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'taxisMustang',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'taxisKuruma',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory13',
			discount = 0.0,
			coords = vector3(-470.13, 273.29, 83.27),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'bc',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'sportage',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory14',
			discount = 0.0,
			coords = vector3(397.52, -634.86, 28.50),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'sjdodge',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'pika01',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'ami',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory15',
			discount = 0.0,
			coords = vector3(-239.32, -2646.84, 6.00),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory16',
			discount = 0.0,
			coords = vector3(99.12, -2696.51, 6.00),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'taxisNemesis',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'taxissanchez',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory17',
			discount = 0.0,
			coords = vector3(-1159.47, -555.21, 29.89),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'taxisvenatusc',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory18',
			discount = 0.0,
			coords = vector3(-53.00, -1111.59, 26.44),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'epic_mchr',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'offlrds1000r',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodi8mlb',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'taxissbmwm8',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'ksd',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'gs1200',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory19',
			discount = 0.0,
			coords = vector3(-228.53, 6240.10, 31.49),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'taxispuipui',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory21',
			discount = 0.0,
			coords = vector3(-480.29, -1009.20, 23.55),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'highmare',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodm3e36',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory22',
			discount = 0.0,
			coords = vector3(-602.60, -896.87, 25.22),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory23',
			discount = 0.0,
			coords = vector3(816.63, -877.78, 25.25),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory24',
			discount = 0.0,
			coords = vector3(-166.16, -2129.34, 16.70),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory25',
			discount = 0.0,
			coords = vector3(-1307.88, -1520.86, 4.42),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory26',
			discount = 0.0,
			coords = vector3(-1352.00, -756.46, 22.37),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'taxissnyder',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory27',
			discount = 0.0,
			coords = vector3(814.05, -2982.57, 6.02),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'twizy',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory28',
			discount = 0.0,
			coords = vector3(43.46, -656.23, 31.63),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory29',
			discount = 0.0,
			coords = vector3(-730.47, -67.24, 41.75),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory30',
			discount = 0.0,
			coords = vector3(-1169.28, -1170.51, 5.62),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'flammpanzer3',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory31',
			discount = 0.0,
			coords = vector3(65.29, -581.90, 31.63),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'taxisFiretruck',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory32',
			discount = 0.0,
			coords = vector3(96.10, -2216.36, 6.17),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory33',
			discount = 0.0,
			coords = vector3(-407.51, 189.81, 81.38),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory34',
			discount = 0.0,
			coords = vector3(1661.95, -1862.67, 108.86),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory35',
			discount = 0.0,
			coords = vector3(1234.41, -3205.47, 5.69),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'bm66',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			job = 'veh_factory36',
			discount = 0.0,
			coords = vector3(295.77, 2893.83, 43.61),
			items = {
				{
					name = 'rmodjeep',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'rmodbolide',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
				{
					name = 'bossikan_88',
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},]]
		{
			coords = vector3(461.41, 3563.27, 33.62),
			items = {
				{
					name = 'magic_potion',
					quantity = 1,
					needed = {
						{ name = "pill", amount = 2 },
						{ name = "coca_seed", amount = 2 },
						{ name = "oxy_pill", amount = 2 },
						{ name = "painkiller4", amount = 2 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			coords = vector3(707.10, -967.55, 30.41),
			items = {
				{
					name = 'laptop',
					quantity = 1,
					needed = {
						{ name = "hacking_tool", amount = 1 },
						{ name = "usb", amount = 1 },
						{ name = "motherboard", amount = 1 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
		{
			coords =  vector3(527.61, -1925.16, 29.01),
			items = {
				{
					name = 'blueprint_ARC15',
					quantity = 1,
					needed = {
						{ name = "kaoutsouk",   amount = 10 },
						{ name = "cable",       amount = 10 },
						{ name = "aluminum",    amount = 10 },
						{ name = "mademi",      amount = 10 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				},
			}
		},
	},

	pao = {
		{
			coords = vector3(-1912.95, -2191.07, 2116.11),
			items = Config.ItemTypes['football']
		},
	},

	aek = {
		{
			coords = vector3(-1913.66, -2191.17, 1899.61),
			items = Config.ItemTypes['football']
		},
	},

	olympiakos = {
		{
			coords = vector3(-1913.89, -2191.28, 1700.11),
			items = Config.ItemTypes['football']
		},
	},

	paok = {
		{
			coords = vector3(-1913.52, -2191.34, 1999.64),
			items = Config.ItemTypes['football']
		},
	},

	aris = {
		{
			coords = vector3(-1912.66, -2190.94, 1800.36),
			items = Config.ItemTypes['football']
		},
	},
}