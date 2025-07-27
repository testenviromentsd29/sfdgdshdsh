Config = {}

Config.DrawDistance = 3.0

Config.ParticipationCostAttacker = 5000
Config.ParticipationCostDefender = 5000

Config.WarDuration = 60 	-- In minutes -- Total time the war lasts
Config.CaptureTime = 0.5 -- In minutes -- Total time the capture takes for the gang area

Config.AreaRadius = 150.0

Config.SecondsAfterWhichToChangeBucket = 6
Config.MaxPlayersPerJobInBucket = 20

Config.CraftCost = 1000000

Config.Craft = {
	ballasgangwars			= 'blueprint_NVRIFLE_PURPLE',
	bloodsgangwars			= 'blueprint_FOOLV2_RED',
	marabuntagangwars		= 'blueprint_M4A5v2',
	familiesgangwars		= 'blueprint_AKPUV2',
	vagosgangwars			= 'blueprint_FAMAS_YELLOW',
	cripsgangwars			= 'blueprint_HK516V2',
	westsiderappersgangwars	= 'blueprint_GALILARV2',
}

Config.GangAreas = {
	ballasgangwars = {
		owner = "Ballas",
		date = {day = 4, hour = 19, minute = 0},		-- Days are 0-6 -> Sunday to Saturday
		bot = {
			coords = vector3(106.47, -1955.58, 19.75),
			heading = 3.32,
			model = `csb_ballasog`,
		},
		blip = {
			name = "Ballas",
			sprite = 429,
			color = 27
		},
		rewards = {
            interval = 240, --- After how many minutes it gives a reward
            amount = {1000,2000}, -- min,max money amount to give after every interval
			items = {blueprint_M47 = 1}
        }
	},
	--
	bloodsgangwars = {
		owner = "Bloods",
		date = {day = 3, hour = 19, minute = 0},
		bot = {
			coords = vector3(550.58, -1775.75, 28.31),
			heading = 241.0,
			model = `ig_claypain`,
		},
		blip = {
			name = "Bloods",
			sprite = 429,
			color = 49
		},
		rewards = {
            interval = 240, --- After how many minutes it gives a reward
            amount = {1000,2000}, -- min,max money amount to give after every interval
			items = {blueprint_JBAK = 1}
        }
	},
	--
	marabuntagangwars = {
		owner = "Marabunta Grande",
		date = {day = 5, hour = 19, minute = 0},
		bot = {
			coords = vector3(336.86, -2041.79, 20.09),
			heading = 47.0,
			model = `g_m_m_casrn_01`,
		},
		blip = {
			name = "Marabunta Grande",
			sprite = 429,
			color = 74
		},
		rewards = {
            interval = 240, --- After how many minutes it gives a reward
            amount = {1000,2000}, -- min,max money amount to give after every interval
			items = {blueprint_H2SMG = 1}
        }
	},
	--
	familiesgangwars = {
		owner = "Families",
		date = {day = 1, hour = 19, minute = 0},
		bot = {
			coords = vector3(-164.65, -1675.95, 32.24),
			heading = 70.0,
			model = `g_m_y_famdnf_01`,
		},
		blip = {
			name = "Families",
			sprite = 429,
			color = 69
		},
		rewards = {
            interval = 240, --- After how many minutes it gives a reward
            amount = {1000,2000}, -- min,max money amount to give after every interval
			items = {blueprint_PAINFUL = 1}
        }
	},
	--
	vagosgangwars = {
		owner = "Vagos",
		date = {day = 2, hour = 19, minute = 0},
		bot = {
			coords = vector3(-1102.40, -1638.31, 4.62),
			heading = 311.0,
			model = `g_m_y_mexgoon_03`,
		},
		blip = {
			name = "Vagos",
			sprite = 429,
			color = 46
		},
		rewards = {
            interval = 240, --- After how many minutes it gives a reward
            amount = {1000,2000}, -- min,max money amount to give after every interval
			items = {blueprint_HBAN = 1}
        }
	},
	--
	cripsgangwars = {
		owner = "Crips",
		date = {day = 6, hour = 19, minute = 0},
		bot = {
			coords = vector3(1284.81, -1724.12, 52.70),
			heading = 211.83,
			model = `g_m_y_mexgoon_03`,
		},
		blip = {
			name = "Crips",
			sprite = 429,
			color = 29
		},
		rewards = {
            interval = 240, --- After how many minutes it gives a reward
            amount = {1000,2000}, -- min,max money amount to give after every interval
			items = {blueprint_SCIFW = 1}
        }
	},
	--
	westsiderappersgangwars = {
		owner = "West Side Rappers",
		date = {day = 0, hour = 19, minute = 0},
		bot = {
			coords = vector3(-1015.20, -1083.55, 1.02),
			heading = 112.11,
			model = `g_m_y_mexgoon_03`,
		},
		blip = {
			name = "West Side Rappers",
			sprite = 429,
			color = 40,
			coords = vector3(-1068.86, -1013.88, 2.18),
		},
		rewards = {
            interval = 240, --- After how many minutes it gives a reward
            amount = {1000,2000}, -- min,max money amount to give after every interval
			items = {blueprint_SMG1311 = 1}
        }
	},
}

Config.GangAreasVehicles = {
	ballasgangwars = {
		vehicleColor = {r=102,g=0,b=112},
		vehicleSecondaryColor = {r=88,g=88,b=88},
		vehicleSpawnRange = 140.0,
		vehicles = {
			{model = 'h2m', coords = vector3(85.67, -1931.01, 20.26), heading = 318.52, livery = 1},
			{model = 'rmodjeep', coords = vector3(91.65, -1924.13, 20.60), heading = 138.0},
			{model = 'buccaneer2', coords = vector3(92.86, -1941.78, 19.83), heading = 23.0},
			{model = 'tornado6', coords = vector3(105.32, -1928.69, 20.38), heading = 76.0},
			{model = 'moonbeam2', coords = vector3(112.88, -1946.86, 20.12), heading = 142.0},
			{model = 'rmodrover', coords = vector3(104.63, -1951.15, 20.57), heading = 94.0},
			{model = 'rmodrover', coords = vector3(115.66, -1937.90, 20.56), heading = 9.0},
		--[[ 	{model = 'rmodbolide', coords = vector3(112.22, -1932.03, 20.00), heading = 47.0},
			{model = 'rmodbolide', coords = vector3(97.44, -1948.39, 19.99), heading = 41.0}, ]]
			{model = 'h2m', coords = vector3(93.12, -1962.53, 20.27), heading = 319.0},
			{model = 'rmodjeep', coords = vector3(88.04, -1968.70, 20.66), heading = 319.0},
		}
	},
	--
	bloodsgangwars = {
		vehicleColor = {r=255,g=0,b=0},
		vehicleSecondaryColor = {r=88,g=88,b=88},
		vehicleSpawnRange = 100.0,
		vehicles = {
			{model = 'h2m', coords = vector3(578.19, -1741.38, 28.79), heading = 64.0},
			{model = 'rmodjeep', coords = vector3(573.18, -1739.09, 29.19), heading = 245.0},
			{model = 'moonbeam2', coords = vector3(582.12, -1746.56, 28.74), heading = 352.0},
			{model = 'rmodrover', coords = vector3(554.18, -1729.06, 29.19), heading = 240.0},
			{model = 'h2m', coords = vector3(560.35, -1732.35, 28.80), heading = 64.0},
			--[[ {model = 'rmodbolide', coords = vector3(571.54, -1770.25, 28.51), heading = 64.0}, ]]
			{model = 'buccaneer2', coords = vector3(560.02, -1765.23, 28.37), heading = 244.0},
			{model = 'rmodjeep', coords = vector3(538.75, -1783.08, 28.72), heading = 359.0},
			{model = 'rmodrover', coords = vector3(555.47, -1797.86, 29.12), heading = 350.0},
	--[[ 		{model = 'rmodbolide', coords = vector3(549.32, -1796.92, 28.54), heading = 351.0}, ]]
			{model = 'tornado6', coords = vector3(552.39, -1797.30, 28.94), heading = 350.0},
		}
	},
	--
	marabuntagangwars = {
		vehicleColor = {r=10,g=110,b=180},
		vehicleSecondaryColor = {r=88,g=88,b=88},
		vehicleSpawnRange = 150.0,
		vehicles = {
			{model = 'h2m', coords = vector3(324.58, -1962.62, 23.63), heading = 255.21},
			{model = 'h2m', coords = vector3(329.99, -1967.65, 23.62), heading = 20.71},
			{model = 'rmodjeep', coords = vector3(264.29, -2045.99, 17.72), heading = 78.07},
			{model = 'rmodjeep', coords = vector3(259.06, -2041.00, 17.87), heading = 202.03},
			{model = 'rmodrover', coords = vector3(287.28, -2061.54, 17.98), heading = 31.29},
			{model = 'rmodrover', coords = vector3(348.46, -1988.03, 24.06), heading = 51.36},
			{model = 'moonbeam2', coords = vector3(295.40, -1995.59, 20.08), heading = 320.86},
			{model = 'moonbeam2', coords = vector3(288.55, -2004.01, 19.60), heading = 320.89},
			{model = 'moonbeam2', coords = vector3(282.31, -2011.69, 19.26), heading = 320.92},
			{model = 'tornado6', coords = vector3(301.44, -2006.11, 20.00), heading = 321.11},
			{model = 'tornado6', coords = vector3(295.40, -2013.61, 19.63), heading = 320.46},
			{model = 'buccaneer2', coords = vector3(316.50, -2017.53, 19.84), heading = 91.69},
			{model = 'buccaneer2', coords = vector3(309.35, -2024.94, 19.62), heading = 349.96},
			--[[ {model = 'rmodbolide', coords = vector3(315.79, -2031.05, 19.93), heading = 320.10},
			{model = 'rmodbolide', coords = vector3(321.81, -2022.25, 20.19), heading = 141.87}, ]]
		}
	},
	--
	familiesgangwars = {
		vehicleColor = {r=8,g=111,b=7},
		vehicleSecondaryColor = {r=88,g=88,b=88},
		vehicleSpawnRange = 200.0,
		vehicles = {
			{model = 'h2m', coords = vector3(-149.95, -1711.62, 29.77), heading = 160.0},
			{model = 'h2m', coords = vector3(-156.33, -1718.30, 29.74), heading = 287.46 },
			{model = 'rmodjeep', coords = vector3(-141.03, -1543.75, 34.20), heading = 255.0},
			{model = 'rmodjeep', coords = vector3(-134.99, -1550.20, 34.15), heading = 13.0},
			{model = 'moonbeam2', coords = vector3(-194.89, -1690.83, 33.00), heading = 309.0},
			{model = 'moonbeam2', coords = vector3(-185.23, -1696.05, 32.46), heading = 309.0},
			{model = 'rmodrover', coords = vector3(-88.62, -1582.51, 31.07), heading = 16.9},
			{model = 'rmodrover', coords = vector3(-94.62, -1577.22, 31.60), heading = 251.9},
			--[[ {model = 'rmodbolide', coords = vector3(-145.16, -1647.69, 32.00), heading = 142.0},
			{model = 'rmodbolide', coords = vector3(-140.94, -1642.11, 31.88), heading = 141.0}, ]]
			{model = 'tornado6', coords = vector3(-187.44, -1616.03, 33.45) , heading = 271.0},
			{model = 'buccaneer2', coords = vector3(-189.01, -1647.13, 32.74), heading = 179.0},
			{model = 'buccaneer2', coords = vector3(-178.40, -1645.52, 32.39), heading = 179.0},
			{model = 'buccaneer2', coords = vector3(-194.72, -1635.40, 32.60), heading = 359.0},
			{model = 'buccaneer2', coords = vector3(-178.41, -1628.26, 32.41), heading = 358.0},
			{model = 'buccaneer2', coords = vector3(-179.99, -1615.88, 32.74), heading = 90.0},
		}
	},
	--
	vagosgangwars = {
		vehicleColor = {r=226,g=150,b=10},
		vehicleSecondaryColor = {r=88,g=88,b=88},
		vehicleSpawnRange = 200.0,
		vehicles = {
			{model = 'buccaneer2', coords = vector3(-1074.64, -1654.54, 3.67), heading = 129.0},
			{model = 'moonbeam2', coords = vector3(-1082.98, -1670.95, 4.16), heading = 302.0},
		--[[ 	{model = 'rmodbolide', coords = vector3(-1090.88, -1633.54, 4.01), heading = 124.0},
			{model = 'rmodbolide', coords = vector3(-1107.21, -1632.66, 3.94), heading = 306.0}, ]]
			{model = 'tornado6', coords = vector3(-1115.21, -1622.03, 4.15), heading = 305.0},
			{model = 'rmodrover', coords = vector3(-1108.75, -1603.15, 4.61), heading = 124.0},
			{model = 'rmodrover', coords = vector3(-1118.70, -1593.76, 4.47), heading = 123.0},
			{model = 'h2m', coords = vector3(-1126.96, -1607.08, 3.92), heading = 304.0},
			{model = 'rmodjeep', coords = vector3(-1123.97, -1611.41, 4.31), heading = 304.0},
			{model = 'h2m', coords = vector3(-1129.40, -1584.00, 3.91), heading = 123.0},
			{model = 'rmodjeep', coords = vector3(-1134.85, -1587.60, 4.29), heading = 303.0},
		}
	},
	--
	cripsgangwars = {
		vehicleColor = {r = 16, g = 23, b = 97},
		vehicleSecondaryColor = {r = 16, g = 23, b = 97},
		vehicleSpawnRange = 200.0,
		vehicles = {
			{model = 'rmodbolide', coords = vector3(1360.98, -1700.53, 60.52), 	heading = 223.20},
			{model = 'rmodbolide', coords = vector3(1361.61, -1706.47, 61.02), 	heading = 340.91},
			{model = 'g63', 	   coords = vector3(1311.75, -1715.01, 54.06), 	heading = 115.23},
			{model = 'g63', 	   coords = vector3(1295.76, -1722.17, 53.37), 	heading = 113.87},
			{model = 'rmodjeep',   coords = vector3(1269.41, -1741.65, 50.60), 	heading = 114.20},
			{model = 'rmodjeep',   coords = vector3(1266.04, -1737.06, 50.54), 	heading = 116.13},
		}
	},
	--
	westsiderappersgangwars = {
		vehicleColor = {r = 12, g = 14, b = 36},
		vehicleSecondaryColor = {r = 12, g = 14, b = 36},
		vehicleSpawnRange = 200.0,
		vehicles = {
			{model = 'rmodjeep', 	coords = vector3(-1007.09, -1110.40, 2.06), 	heading = 158.87},
			{model = 'rmodjeep', 	coords = vector3(-1013.72, -1113.68, 2.08), 	heading = 272.74},
			{model = 'G63', 	 	coords = vector3(-1037.92, -1058.62, 2.45), 	heading = 73.18},
			{model = 'G63', 	 	coords = vector3(-1043.53, -1063.86, 2.52), 	heading = 354.09},
			{model = 'rmodbolide', 	coords = vector3(-1024.95, -1097.85, 1.83), 	heading = 29.03},
			{model = 'rmodbolide', 	coords = vector3(-1030.14, -1088.66, 1.91), 	heading = 27.57},
		}
	},
}