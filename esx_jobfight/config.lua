Config = {}

Config.FightRadius = 300.0
Config.FightSeconds = 15*60

Config.CountDownSeconds = 10
Config.ReqExpireSeconds = 30

Config.Maps = {
	['here']  = {},
	['skate'] = {center = vector3(-2913.60, -1035.10, 102.00), spawn1 = vector3(-2914.16, -1009.83, 101.00), spawn2 = vector3(-2912.56, -1062.00, 101.00)},
	--['airskate'] = {center = vector3(-2103.15, -1788.35, 650.88), spawn1 = vector3(-2111.36, -1796.64, 655.93), spawn2 = vector3(-2096.21, -1796.83, 655.93)},
	['dust2'] = {center = vector3(-3223.39, -1336.99, 108.26), spawn1 = vector3(-3207.34, -1300.67, 105.06), spawn2 = vector3(-3229.97, -1375.83, 111.46)},
	--['pixel'] = {center = vector3(-3740.13, -3002.54, 542.73), spawn1 = vector3(-3740.51, -2981.48, 542.92), spawn2 = vector3(-3740.32, -3023.83, 542.92)},
	['loipon'] = {center = vector3(-3627.36, 3040.36, 1092.79), spawn1 = vector3(-3643.27, 3083.88, 1092.80), spawn2 = vector3(-3616.84, 3004.71, 1092.83)},
	--['heli'] = {center = vector3(-2554.67, -1405.00, 419.36), spawn1 = vector3(-2614.01, -1406.33, 420.46), spawn2 = vector3(-2513.28, -1394.91, 419.36)},	
	--['oldschool3vs3'] = {center = vector3(-1548.48, 2899.47, 31.18), spawn1 = vector3(-1579.75, 2963.72, 33.16), spawn2 = vector3(-1512.02, 2831.05, 31.06)},
	['Cs:SPY']      = {center = vector3(-3543.31, 1361.32, 310.36),  	spawn1 = vector3(-3528.72, 1361.52, 310.36), 	spawn2 = vector3(-3559.97, 1360.91, 310.36)},
	['mini_dust']   = {center = vector3(-3180.79, -349.95, 555.34),  	spawn1 = vector3(-3180.24, -331.81, 556.53), 	spawn2 = vector3(-3180.77, -365.39, 556.53)},
	['minecraft']   = {center = vector3(-1955.97, -1503.55, 321.06), 	spawn1 = vector3(-1972.94, -1493.69, 321.06), 	spawn2 = vector3(-1928.68, -1513.39, 321.06)},
	--['neon'] 	    = {center = vector3(-3195.12, -480.49, 318.88), 	spawn1 = vector3(-3240.46, -478.08, 318.88), 	spawn2 = vector3(-3166.87, -477.82, 318.88)},
	--['neon2'] 	    = {center = vector3(-2183.04, -2370.34, 500.73),	spawn1 = vector3(-2129.96, -2364.27, 500.73),	spawn2 = vector3(-2218.28, -2363.38, 500.73)},
	--['bighelizone'] = {center = vector3(1830.93, -3152.78, 399.52), 	spawn1 = vector3(1803.93, -3195.99, 397.72), 	spawn2 = vector3(1866.55, -3102.33, 397.72)},
	--['arena1'] = {center = vector3(-3036.65, 4119.04, 716.88), spawn1 = vector3(-3034.12, 4091.66, 714.08), spawn2 = vector3(-3028.44, 4140.96, 714.08)},
	['airport']		= {center = vector3(-1993.88, -2034.63, 514.33),	spawn1 = vector3(-1933.05, -2074.74, 514.33),	spawn2 = vector3(-2024.27, -1991.47, 514.33)},
	['desert']		= {center = vector3(-3634.57, 665.57, 528.63),		spawn1 = vector3(-3676.87, 711.95, 522.10),		spawn2 = vector3(-3593.74, 621.35, 522.10)},
	['luna_park']	= {center = vector3(-1758.86, -2366.69, 809.78),	spawn1 = vector3(-1754.92, -2413.54, 809.78),	spawn2 = vector3(-1749.53, -2321.02, 809.78)},
	['villas']		= {center = vector3(-2827.74, -3328.41, 515.85),	spawn1 = vector3(-2785.45, -3371.70, 517.93),	spawn2 = vector3(-2875.96, -3280.54, 517.93)},
	['anemogenitries']	= {center = vector3(2208.36, 2084.93, 130.49),	spawn1 = vector3(2271.77, 2019.24, 131.22),	spawn2 = vector3(2161.12, 2159.46, 118.54)},
	['5020']			= {center = vector3(-407.85, 1185.56, 325.54),	spawn1 = vector3(-388.57, 1264.90, 333.13),	spawn2 = vector3(-423.45, 1130.97, 325.86)},
	--['gma_new']			= {center = vector3(-859.8, -254.74, 1541.92),	spawn1 = vector3(-831.33, -253.48, 1525.57),	spawn2 = vector3(-903.22, -258.70, 1525.57)},
	--['gma_new_v2']		= {center = vector3(-868.63, -433.64, 1533.60),	spawn1 = vector3(-866.38, -432.89, 1533.60),	spawn2 = vector3(-866.57, -452.30, 1533.60)},
	['new_arena10vs10'] = {center = vector3(-147.25, -4351.11, 337.29), spawn1 = vector3(-84.80, -4348.68, 334.61), spawn2 = vector3(-210.10, -4348.30, 334.61)},
	--['18_07_2024'] = {center = vector3(747.68, 3383.90, 62.24), spawn1 = vector3(701.99, 3383.26, 76.60), spawn2 = vector3(853.18, 3394.93, 73.00)},
}