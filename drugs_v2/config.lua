Config = {}

Config.CaptureDuration = 10
Config.RewardsInterval = 10
Config.MaxCap = 250

Config.Locations = {
	['weed'] = {
		label = 'Weed Field',
		coords = vector3(2201.43, 5569.67, 53.77),
		radius = 50.0,
		dimensionsX = 5,
		dimensionsY = 5,
		distance = 2.5,
		heading = 0.0,
		prop = `prop_weed_01`,
		duration = 2,
		itemName = 'field_cannabis',
		itemCount = 1,
		npc = {
			model = `a_m_m_farmer_01`,
			coords = vector3(2190.21, 5563.49, 53.67),
			heading = 303.0
		},
		blip = {sprite = 140, color = 2, scale = 0.7},
		blipRadius = {color = 1, alpha = 128},
	},
	['coke'] = {
		label = 'Coke Field',
		coords = vector3(-1667.93, 4601.06, 48.70),
		radius = 50.0,
		dimensionsX = 5,
		dimensionsY = 5,
		distance = 2.5,
		heading = 0.0,
		offset = {x = 0.0, y = 0.0, z = -0.3},
		prop = `prop_plant_01b`,
		duration = 2,
		itemName = 'field_cocaleaf',
		itemCount = 1,
		npc = {
			model = `a_m_m_farmer_01`,
			coords = vector3(-1653.97, 4601.64, 46.56),
			heading = 200.0
		},
		blip = {sprite = 51, color = 2, scale = 0.7},
		blipRadius = {color = 1, alpha = 128},
	},
	['meth'] = {
		label = 'Meth Field',
		coords = vector3(-133.10, -2449.59, 6.02),
		radius = 50.0,
		dimensionsX = 5,
		dimensionsY = 5,
		distance = 2.5,
		heading = 0.0,
		prop = `bkr_prop_meth_phosphorus`,
		duration = 2,
		itemName = 'field_crystal_meth',
		itemCount = 1,
		npc = {
			model = `a_m_m_farmer_01`,
			coords = vector3(-141.10, -2440.50, 6.01),
			heading = 0.0
		},
		blip = {sprite = 51, color = 2, scale = 0.7},
		blipRadius = {color = 1, alpha = 128},
	},
	['weed_hidden'] = {
		label = 'Weed Field',
		coords = vector3(2477.74, 2532.49, 43.24),
		radius = 50.0,
		dimensionsX = 5,
		dimensionsY = 5,
		distance = 2.5,
		heading = 0.0,
		prop = `prop_weed_01`,
		duration = 2,
		itemName = 'field_cannabis',
		itemCount = 1,
		npc = {
			model = `a_m_m_farmer_01`,
			coords = vector3(2477.74, 2532.49, 43.24),
			heading = 340.0
		},
		--blip = {sprite = 140, color = 2, scale = 0.7},
		--blipRadius = {color = 1, alpha = 128},
	},
	['coke_hidden'] = {
		label = 'Coke Field',
		coords = vector3(2558.12, 1323.30, 48.73),
		radius = 50.0,
		dimensionsX = 5,
		dimensionsY = 5,
		distance = 2.5,
		heading = 0.0,
		offset = {x = 0.0, y = 0.0, z = -0.3},
		prop = `prop_plant_01b`,
		duration = 2,
		itemName = 'field_cocaleaf',
		itemCount = 1,
		npc = {
			model = `a_m_m_farmer_01`,
			coords = vector3(2558.12, 1323.30, 48.73),
			heading = 200.0
		},
		--blip = {sprite = 51, color = 2, scale = 0.7},
		--blipRadius = {color = 1, alpha = 128},
	},
}