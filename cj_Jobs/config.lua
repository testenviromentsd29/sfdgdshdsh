
Config = {}
Config.DrawDistance = 30.0
Config.MarkerSize   = {x = 2.5, y = 2.5, z = 0.8}
Config.MarkerColor  = {r = 102, g = 102, b = 204}
Config.MarkerType   = 1
Config.Size         = {x = 2.5, y = 2.5, z = 0.8}
Config.Color        = {r = 60, g = 128, b = 255}
Config.Type         = 1

Config.GetJobsLocation = vector3(-264.7,-969.25,30.22)
Config.Ped = {
	model = "s_m_m_lathandy_01",
	heading = 18.0
}
Config.JobsList = {
	--[[ Εμφανίζονται με σείρα οπως το UI ]]

	--[[ KALHMERA CAROLE POUTSARA <3 ]]
	-- [1] = {value = "kratos1", label = "Δικηγόρος", description = "More Info Soon!"}, 
	-- [2] = {value = "gardener", label = "Καθαριστής Δήμου", description = "More Info Soon!"},
	-- [3] = {value = "postman", label = "Ταχυδρόμος", description = "More Info Soon!"},
	-- [4] = {value = "poolcleaner", label = "Καθαριστής Πισίνας", description = "More Info Soon!"},
	-- [1] = {value = "garbage", label = "Σκουπιδιάρης", description = "More Info Soon!"},
	-- [2] = {value = "farmer", label = "Farmer", description = "More Info Soon!"},
	-- [3] = {value = "miner", label = "Miner", description = "More Info Soon!"},
	-- [4] = {value = "slaughterer", label = "Butcher", description = "More Info Soon!"},
	-- [6] = {value = "deh", label = "ΔΕΗ", description = "More Info Soon!"},
	-- [5] = {value = "woodcutter", label = "Ξυλοκόπος", description = "More Info Soon!"},
	-- [6] = {value = "soon", label = "Alitiz", description = "More Info Soon!"},
	-- [7] = {value = "soon", label = "Kolovos", description = "More Info Soon!"},
}
Config.PaymentBlip = vector3(-545.09,-204.12,39.22)

Config.Jobs = {
	-- New Jobs
	-- slaughterer = {
	-- 	vehicleSpawner = {pos = vector3(979.32 ,-2111.35 , 29.47), heading = 260.0, 
	-- 						price = 2000, vehicles = {},
	-- 						message = "See your minimap for a waypoint and start slaughtering chicken"},
		
	-- },
	-- farmer = {
	-- 	vehicleSpawner = {pos = vector3(285.97 , 6650.33 , 28.57), heading = 260.0, 
	-- 						price = 2000, vehicles = {},
	-- 						message = "See your minimap for a waypoint and start farming fruits"},
	-- },
	-- miner = {
	-- 	vehicleSpawner = {pos = vector3(3159.19,5257.83,29.0), heading = 260.0, 
	-- 						price = 2000, vehicles = {},
	-- 						message = "See your minimap for a waypoint and start mining"},
	-- },
	-- fisher = {
	-- 	vehicleSpawner = {pos = vector3(-1493.39 , -1727.87 , -5.84), heading = 260.0, 
	-- 						price = 2000, vehicles = {},
	-- 						message = "See your minimap for a waypoint and start fishing"},
	-- },
	-- vigneron = {
	-- 	vehicleSpawner = {pos = vector3(-1913.97 , 1810.9 , 183.37 ), heading = 260.0, 
	-- 						price = 2000, vehicles = {},
	-- 						message = "See your minimap for a waypoint and start collecting Fruits & Grapes"},
	-- }, 

	-- Old Jobs
	-- garbage = {
	-- 	vehicleSpawner = {pos = vector3(388.91,3591.18,33.29), heading = 260.0, 
	-- 						price = 2000, vehicles = {{label = "Σκουπιδιάρικο", value = "trash"}},
	-- 						message = "See your minimap for a waypoint and start collecting garbage"},
	-- 	vehicleDeleter = {pos = vector3(329.28,3561.55,33.17)},
	-- 	payment = {pos = vector3(-545.08,-204.08,37.22), paymentAmount = {100,200}},
	-- 	jobBlip = {pos = vector3(357.65,3581.9,32.35), sprite = 161, color = 1, name = "Garbage Job"}
	-- },
	gardener = {
		vehicleSpawner = {pos = vector3(-514.92,-264.33,35.42), heading = 113.0, 
		price = 0, vehicles = {{label = "Όχημα εργασίας", value = "UtilliTruck3"}},
		message = "See your minimap for a waypoint and start cleaning"},
		vehicleDeleter = {pos = vector3(-527.15,-268.69,35.26)},
		payment = {pos = vector3(-545.08,-204.08,37.22), paymentAmount = {2700,2700}},
		jobBlip = {pos = vector3(-521.15,-266.69,5.26), sprite = 161, color = 7, name = "Gardener Job"}
	},
	postman = {
		vehicleSpawner = {pos = vector3(-262.71,-853.53,31.34), heading = 69.0, 
		price = 0, vehicles = {{label = "Όχημα εργασίας", value = "boxville2"}},
		message = "See your minimap for a waypoint and start delivering letters!"},
		vehicleDeleter = {pos = vector3(-274.71,-834.75,31.63)},
		payment = {pos = vector3(-545.08,-204.08,37.22), paymentAmount = {2550,2550}},
		jobBlip = {pos = vector3(-268.22,-845.33,26.26), sprite = 161, color = 5, name = "Postman Job"}
	},
	-- poolcleaner = {
	-- 	vehicleSpawner = {pos = vector3(-1302.65,-1303.48,4.73), heading = 201.0, 
	-- 						price = 2000, vehicles = {{label = "Όχημα εργασίας", value = "UtilliTruck3"}},
	-- 						message = "See your minimap for a waypoint and start cleaning pools!"},
	-- 	vehicleDeleter = {pos = vector3(-1299.09,-1314.33,4.75)},
	-- 	payment = {pos = vector3(-545.08,-204.08,37.22), paymentAmount = {100,200}},
	-- 	jobBlip = {pos = vector3(-1302.61,-1309.49,0.51), sprite = 161, color = 3, name = "Pool Cleaner Job"}
	-- },
	-- deh = {
	-- 	vehicleSpawner = {pos = vector3(-575.43,-383.26,34.89), heading = 269.0, 
	-- 						price = 2000, vehicles = {{label = "Όχημα εργασίας", value = "utillitruck"}},
	-- 						message = "See your minimap for a waypoint and start fixing lamps!"},
	-- 	vehicleDeleter = {pos = vector3(-563.32,-382.97,34.96)},
	-- 	payment = {pos = vector3(-560.71,-390.53,35.04), paymentAmount = {100,200}},
	-- },
	-- woodcutter = {
	-- 	vehicleSpawner = {pos = vector3(0.0,0.0,0.0), heading = 269.0, 
	-- 						price = 2000, vehicles = {{label = "Όχημα εργασίας", value = "utillitruck"}},
	-- 						message = "See your minimap for a waypoint and start fixing lamps!"},
	-- 	vehicleDeleter = {pos = vector3(0.0,0.0,0.0)},
	-- 	payment = {pos = vector3(0.0,0.0,0.0), paymentAmount = {0,0}},
	-- },

}

Config.GarbageLocations = {
	vector3(256.70, -986.32, 28.8),
	vector3(116.83, -1463.31, 28.6),
	vector3(-9.04, -1564.23, 28.8),
	vector3(-1.2, -1733.55, 28.8),
	vector3(50.98,-830.6,30.07),
	vector3(32.89,-1010.58,28.46),
	vector3(357.94, -1811.07, 28.3),
	vector3(489.36, -1283.82, 29.2),
	vector3(243.21,-823.62,29.0),
	vector3(449.56,-572.67,28.49),
	vector3(-1331.87,-1192.73,4.62),
	vector3(9.21,-1030.34,28.46),
	vector3(-326.97,-1317.9,30.4),
	vector3(-8.87,-1036.12,28.03),
	vector3(-349.03,-1070.08,21.96),
	vector3(-155.39,-1413.73,29.86),
	vector3(249.51,-661.23,37.46),
	vector3(449.56,-574.46,27.5),
	vector3(490.62,-998.55,26.78),
	vector3(509.58,-1620.68,28.25),
	vector3(-625.99,-1790.49,22.95),
	vector3(-609.48,-1785.33,22.65),
	vector3(-589.95,-1764.31,22.18),
	vector3(-587.6,-1739.19,21.66),
	vector3(-589.82,-1737.36,21.76),
	vector3(-619.86,-1608.89,25.9),
	vector3(-621.69,-1608.6,25.9),
	vector3(-614.86,-1609.24,25.9),
	vector3(-1073.66,-471.58,35.65),
	vector3(508.17,-1622.13,28.3),
}

Config.Locations = {
	gardener = {
		vector3(-1201.46,22.83,48.48),
		vector3(-997.16,-108.17,39.91),
		vector3(-1293.25,110.83,55.37),
		vector3(-202.26,-783.54,29.2),
		vector3(-188.3,-776.4,29.45),
		vector3(-140.44,-794.72,31.23),
		vector3(151.92,-995.56,28.36),
		vector3(164.67,-990.44,29.09),
		vector3(180.73,-1006.75,28.33),
		vector3(222.14,-986.04,28.25),
		vector3(249.37,-914.07,28.15),
		vector3(258.48,-882.51,28.19),
		vector3(218.59,-864.29,29.27),
		vector3(-98.17,-442.45,34.88),
		vector3(-109.65,-440.86,34.94),
		vector3(-116.91,-433.19,34.91),
		vector3(-121.34,-411.33,33.83),
		vector3(-107.79,-400.85,35.03),
		vector3(-87.5,-396.03,35.98),
		vector3(-63.51,-429.28,37.16),
		vector3(859.0,-281.7,64.64),
		vector3(854.95,-257.35,64.44),
		vector3(833.47,-265.39,64.78),
		vector3(745.86,-199.35,65.11),
		vector3(717.48,-233.5,65.38),
	},
	postman = {
		vector3(-1057.21 ,-358.5 ,36.77),
		vector3(-1044.56 , -300.18 ,36.85),
		vector3(-1070.22 , -259.18 ,36.82),
		vector3( -1190.49 , -268.48 ,36.59),
		vector3( -1344.14 , -350.1 ,35.67),
		vector3(-1452.48 , -417.04 ,34.71),
		vector3( -1558.97 , -483.39 ,34.48),
		vector3( -1429.74 , -95.44 , 50.75),
		vector3(-480.74 , -11.7 , 44.28),
		vector3(-357.49 , -27.9 , 46.22),
		vector3(121.74 , -164.68 , 53.69),
		vector3(218.58 , -200.07 , 53.01),
		vector3(297.13 , -229.5 , 52.99),
		vector3(261.75 , -215.97 , 52.97),
		vector3(522.74 , -158.75 , 55.58),
		vector3(529.36 , 101.0 , 95.33),
		vector3(-515.37 , 25.88 , 43.58),
		vector3(-515.41 , 27.15 , 43.57),
		vector3(-536.56 , 22.97 , 43.28),
		vector3(-634.43 , 139.64 , 56.24),
		vector3(-599.4 , 248.68 , 81.13),
		vector3(-594.83 , 273.94 , 81.2),
		vector3(-595.56 , 273.96 , 81.18),
		vector3(-596.37 , 273.89 , 81.16),
		vector3(445.35 , 89.29 , 98.05),
		vector3(446.19 , 88.59 , 98.0),
		vector3(447.52 , 88.24 , 97.92),
		vector3(458.48 , 119.87 , 97.95),
		vector3(457.07 , 120.58 , 98.04),
		vector3(456.05 , 121.01 , 98.09),
	},
	poolcleaner = {
		vector3(-240.36 , 468.19 , 125.73),
		vector3(-318.24 , 518.12 , 120.42),
		vector3(-466.17 , 573.21 , 124.88),
		vector3(-571.96 , 574.02 , 113.97),
		vector3(-564.44 , 555.85 , 109.4),
		vector3(-617.67 , 543.97 , 111.3),
		vector3(-618.23 , 458.11 , 107.82),
		vector3(-648.8 , 450.86 , 109.42),
		vector3(-668.25 , 517.14 , 109.48),
		vector3(-748.22 , 486.5 , 106.47),
		vector3(-790.51 , 484.08 , 99.18),
		vector3(-819.25 , 459.23 , 89.17),
		vector3(-923.22 , 481.98 , 83.8),
		vector3(-983.82 , 459.19 , 80.37),
		vector3(-995.87 , 446.84 , 78.97),
		vector3(-1026.08 , 422.01 , 71.86),
		vector3(-1058.9 , 365.98 , 69.75),
		vector3(-1146.33 , 443.61 , 85.62),
		vector3(-1205.39 , 433.62 , 84.62),
		vector3(-1296.69 , 480.37 , 96.57),
		vector3(-1327.83 , 547.11 , 123.34),
		vector3(-1390.8 , 496.0 , 120.02),
		vector3(-1303.27 , 574.77 , 128.6),
		vector3(-1269.1 , 599.91 , 138.28),
		vector3(-1131.51 , 722.26 , 154.49),
		vector3(-1766.08 , 437.56 , 126.41),
		vector3(-1772.64 , 434.29 , 126.31),
		vector3(-1716.06 , 369.14 , 88.78),
		vector3(-1475.4 , 174.1 , 54.92),
	},
	deh = {
		vector3(-185.09,-844.38,28.96),
		vector3(-162.44,-877.48,28.22),
		vector3(-127.02,-930.05,28.25),
		vector3(-14.44,-966.42,28.46),
		vector3(158.09,-901.45,29.37),
		vector3(424.89,-947.84,28.27),
		vector3(479.53,-947.81,26.4),
		vector3(508.43,-815.93,23.78),
		vector3(515.38,-287.33,45.62),
		vector3(510.4,-228.5,48.51),
		vector3(529.1,-127.73,59.8),
		vector3(607.84,-53.89,74.09),
		vector3(776.74,147.79,79.61),
		vector3(769.57,607.7,124.98),
		vector3(713.02,1284.43,359.3),
		vector3(314.84,2100.49,103.32),
		vector3(291.35,2585.86,43.52),
		vector3(285.37,2666.12,43.47),
		vector3(-99.75,1849.23,197.9),
		vector3(-2532.61,1053.04,181.61),
		vector3(-2600.51,1083.69,169.21),
		vector3(-2625.89,1109.66,163.32),
		vector3(-2631.64,1137.93,160.02),
		vector3(-3101.82,1343.78,19.15),
		vector3(-75.49,6446.52,30.42),
		vector3(-74.07,6472.19,30.51),
		vector3(-35.93,6546.5,30.96),
		vector3(7.77,6498.13,30.5),
	}
}