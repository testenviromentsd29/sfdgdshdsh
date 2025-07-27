Config = {}
Config.TruckPlateNumb = 0  
Config.MaxStops	= 100 
Config.MaxBags = 10 
Config.MinBags = 8 
Config.BagPay = 3 
Config.StopPay = 300 
Config.JobName = 'garbage'  
Config.BonusItem = 'plastic_pack'
Config.BonusChance = 20


Config.PriceForTruck = 1
Config.ExpiredItemsCansCapacity = 100





Config.Trucks = {
  'trash',
}

Config.DumpstersAvaialbe = {
  218085040,
  666561306,
  -58485588,
  -206690185,
  1511880420,
  682791951,
  -387405094,
  364445978,
  1605769687,
  -1831107703,
  -515278816,
  -1790177567,
}

Config.VehicleSpawn = {pos = vector3(840.69, -1974.23, 29.29) }

Config.Zones = {
	[1] = {type = 'Zone', size = 1.0 , name = 'endmission', pos = vector3(832.61, -1981.04, 29.30)},
	[2] = {type = 'Zone', size = 0.4 , name = 'timeclock', pos = vector3(849.61, -1995.38, 28.98)},
	[3] = {type = 'Zone', size = 0.4 , name = 'vehiclelist', pos = vector3(843.57, -1984.81, 28.30)},
}


Config.Collections = {
  [1] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(114.83,-1462.31, 29.29508)},
  [2] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(-6.04,-1566.23, 29.209197)},
  [3] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(-1.88,-1729.55, 29.300233)},
  [4] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(159.09,-1816.69, 27.91234)},
  [5] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(358.94,-1805.07, 28.96659)},
  [6] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(481.36,-1274.82, 29.64475)},
  [7] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(127.9472,-1057.73, 29.19237)},
  [8] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(-1613.123, -509.06, 34.99874)},
  [9] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(342.78,-1036.47, 29.19420)},
  [10] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(383.03,-903.60, 29.15601)}, 
  [11] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(165.44,-1074.68, 28.90792)}, 
  [12] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(50.42,-1047.98, 29.31497)}, 
  [13] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(-1463.92, -623.96, 30.20619)},
  [14] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(443.96,-574.33, 28.49450)},
  [15] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(-1255.41,-1286.82,3.58411)}, 
  [16] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(-1229.35, -1221.41, 6.44954)},
  [17] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(-31.94,-93.43, 57.24907)},
  [18] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(274.31,-164.43, 60.35734)},
  [19] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(-364.33,-1864.71, 20.24249)}, 
  [20] = {type = 'Collection', size = 1.0 , name = 'collection', pos = vector3(-1239.42, -1401.13, 3.75217)},


}

Config.Uniforms = {
	garbage_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 23,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['bags_1'] = 0,
			['shoes_1'] = 12,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 4,    ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 23,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 19,   ['pants_2'] = 0,
			['bags_1'] = 0,
			['shoes_1'] = 12,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 4,    ['chain_2'] = 0
		},
	}
}