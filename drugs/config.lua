Config = {}

Config.MaxProps = 12

Config.Locations = {
	--[[['cannabis'] = {
		name = 'Weed Field',
		spawnRadius = 30.0,
		redzoneRadius = 100.0,
		label = 'cannabis',
		item = 'cannabis',
		prop = 'prop_weed_01',
		criticalItem = {
			item = "trifyllo_tsigaraki",
			chance = 0,
		},
		gatherNumber = 5,
		experienceGive = 16,
		farmSeconds = 6,
		criminalXp = 16,
		coords = vector3(2207.96, 5572.76, 53.74),
		blip = {sprite = 140, color = 2, scale = 0.7},
		blipRadius = {color = 1, alpha = 128}
	},
	['cannabis_hidden'] = {
		name = 'Weed Field Hidden',
		spawnRadius = 30.0,
		redzoneRadius = 150.0,
		label = 'cannabis',
		item = 'cannabis',
		prop = 'prop_weed_01',
		criticalItem = {
			item = "trifyllo_tsigaraki",
			chance = 50,
		},
		gatherNumber = 20,
		experienceGive = 24,
		farmSeconds = 6,
		criminalXp = 24,
		coords = vector3(-2513.07, 2736.70, 2.86)
	},
	['cocaleaf'] = {
		name = 'Coca Field',
		spawnRadius = 30.0,
		redzoneRadius = 100.0,
		label = 'cocaleaf',
		item = 'cocaleaf', 
		prop = 'prop_plant_01b', 	
		criticalItem = {
			item = "mytia_cocainis",
			chance = 0,
		},
		gatherNumber = 5, 
		experienceGive = 24,
		farmSeconds = 6,
		criminalXp = 24,
		coords = vector3(3353.10, 5497.49, 19.39),
		blip = {sprite = 51, color = 2, scale = 0.7},
		blipRadius = {color = 1, alpha = 128}
	},
	['cocaleaf_hidden'] = {
		name = 'Coca Field Field',
		spawnRadius = 30.0,
		redzoneRadius = 150.0,
		label = 'cocaleaf',
		item = 'cocaleaf', 
		prop = 'prop_plant_01b', 	
		criticalItem = {
			item = "mytia_cocainis",
			chance = 50,
		},
		gatherNumber = 20, 
		experienceGive = 32,
		farmSeconds = 6,
		criminalXp = 32,
		coords = vector3(-1583.67, 4669.50, 45.78),
	},]]
	
	--JOBS
	['barrel'] = {
		name = 'Crude Oil',
		--job = "oilworker",
		spawnRadius = 35.0,
		redzoneRadius = -1.0,
		label = 'Crude Oil',
		item = 'crude_oil',
		criticalItem = {
			item = "megalo_mpitoni",
			chance = 2,
		},
		prop = 'prop_barrel_exp_01b',
		gatherNumber = 1,
		criminalXp = 0,
		farmSeconds = 6,
		coords = vector3(2723.48, 1361.91, 24.52),
		--blip = {sprite = 436, color = 1, scale = 0.7},
		--blipRadius = {color = 1, alpha = 128}
	},
	['unprocessed_dried_cannabis'] = {
		name = 'Pharmaceutical Cannabis',
		--job = "farmer",
		spawnRadius = 50.0,
		redzoneRadius = -1.0,
		label = 'Dried Cannabis',
		item = 'unprocessed_dried_cannabis',
		criticalItem = {
			item = "highgradefemaleseed",
			chance = 2,
		},
		prop = 'prop_weed_01',
		gatherNumber = 1,
		criminalXp = 0,
		farmSeconds = 6,
		coords = vector3(2056.27, 4927.46, 40.96),
		--blip = {sprite = 140, color = 2, scale = 0.7},
		--blipRadius = {color = 1, alpha = 128}
	},
	['rocks'] = {
		name = 'Rocks',
		--job = "metalorixos",
		spawnRadius = 50.0,
		redzoneRadius = -1.0,
		label = 'Rocks',
		items = {
			"raw_copper",
			"raw_iron",
		},
		criticalItem = {
			item = "titanium",
			chance = 2,
		},
		prop = 'prop_rock_4_c',
		animationload = [[
			if pickaxe == nil then
				pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true); 
			end
			AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.05, -0.10, -0.03, -300.0, 00.00, 180.0, true, true, false, true, 1, true);
			for i=1, 4 do
				local ped = PlayerPedId();
				RequestAnimDict("melee@large_wpn@streamed_core");
				TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0);
				Wait(1000);
				ClearPedTasks(ped);
			end
			DetachEntity(pickaxe, 1, true);
			DeleteEntity(pickaxe);
			DeleteObject(pickaxe);
			if pickaxe ~= nil then
				pickaxe = nil;
			end
		]],
		gatherNumber = 1,
		criminalXp = 0,
		farmSeconds = 5,
		coords = vector3(1984.45, 3364.99, 44.11),
		--blip = {sprite = 85, color = 4, scale = 0.7},
		--blipRadius = {color = 1, alpha = 128}
	},
	--[[ ['company1'] = {
		name = 'Farm',
		job = "company1",
		spawnRadius = 20.0,
		label = 'Grapes',
		item = 'c_grapes',
		prop = 'prop_weed_01',
		modifyZ = -0.3,
		gatherNumber = 10,
		civilianXp = 5,
		farmSeconds = 6,
		coords = vector3(-1860.61, 2095.88, 139.24),
		blip = {sprite = 501, color = 3, scale = 0.7},
	}, ]]
}