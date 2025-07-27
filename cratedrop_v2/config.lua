Config = {}

Config.CrateDelay = 600		--seconds
Config.CaptureTime = 20		--seconds
Config.CrateCooldown = 1800	--seconds

Config.Crates = {
	['premium'] = {
		label = 'Premium Drop',
		npc = {
			model = `ig_agent`,
			coords = vector3(61.57, 3707.92, 39.75),
			heading = 25.00
		},
		locations = {
			{coords = vector3(311.09, 4330.02, 48.72),	radius = 100.0},
			{coords = vector3(-173.08, 4239.77, 44.93),	radius = 100.0},
			{coords = vector3(-131.67, 3074.79, 23.46),	radius = 100.0},
			{coords = vector3(436.08, 3550.42, 33.24),	radius = 100.0},
			{coords = vector3(236.55, 3371.76, 40.15),	radius = 100.0},
		},
		rewards = {
			['coins'] = 500,
			--['level4'] = 1,
			['blueprint_BAS_P_RED'] = 10,
		},
	},
	['grove'] = {
		label = 'Grove Drop',
		npc = {
			model = `ig_agent`,
			coords = vector3(54.77, -1808.43, 25.25),
			heading = 130.00
		},
		locations = {
			{coords = vector3(7.46, -1830.78, 24.97),		radius = 100.0},
			{coords = vector3(-393.52, -1421.22, 29.32),	radius = 100.0},
		},
		rewards = {
			['mytia_cocainis'] = 100,
			['trifyllo_tsigaraki'] = 100,
			['magic_potion'] = 100,
			['painkiller4'] = 100,
		},
	},
	['paleto'] = {
		label = 'Paleto Drop',
		npc = {
			model = `ig_agent`,
			coords = vector3(-18.09, 6203.96, 31.11),
			heading = 90.00
		},
		locations = {
			{coords = vector3(-699.10, 5813.69, 17.22),	radius = 100.0},
			{coords = vector3(-292.36, 6085.04, 31.48),	radius = 100.0},
			{coords = vector3(76.39, 6326.94, 31.23),	radius = 100.0},

			{coords = vector3(297.16, 6739.13, 15.40),	radius = 100.0},
		},
		rewards = {
			['bulletproof4'] = 100,
			['bulletproof7'] = 100,
			['bulletproof6'] = 100,
			['bulletproof5'] = 100,
		},
	},
	['sandy'] = {
		label = 'Sandy Drop',
		npc = {
			model = `ig_agent`,
			coords = vector3(1776.94, 3327.67, 41.43),
			heading = 300.00
		},
		locations = {
			{coords = vector3(1242.68, 3001.06, 42.23),	radius = 100.0},
			{coords = vector3(1108.94, 3356.95, 34.63),	radius = 100.0},
			{coords = vector3(1532.97, 3502.17, 36.30),	radius = 100.0},
			{coords = vector3(2589.39, 3997.44, 41.80),	radius = 100.0},
		--[[ 	{coords = vector3(419.78, 2991.07, 40.74),	radius = 100.0},
			{coords = vector3(216.35, 3394.22, 38.40),	radius = 100.0}, ]]
		},
		rewards = {
			['weapon_powerup'] = 100,
			['super_potion'] = 100,
			['weaponkit'] = 100,
			['extended'] = 100,
			['scope'] = 100,
		},
	},
	['cayo'] = {
		label = 'Cayo Perico Drop',
		npc = {
			model = `ig_agent`,
			coords = vector3(4862.10, -5167.03, 2.44),
			heading = 219.00
		},
		locations = {
			{coords = vector3(4876.64, -5286.53, 8.48),	radius = 100.0},
			{coords = vector3(4876.64, -5286.53, 8.48),	radius = 100.0},
			{coords = vector3(4876.64, -5286.53, 8.48),	radius = 100.0},
		},
		rewards = {
			['bulletproof9'] = 10,
			['bulletproof8'] = 10,
			['AMMO_MG'] = 20,
			['blueprint_M9_P_CHROMIUM'] = 5,
			['blueprint_M4A1_CHROMIUM'] = 5,
			['super_potion3'] = 10,
			['super_potion2'] = 10,
		},
	},
}