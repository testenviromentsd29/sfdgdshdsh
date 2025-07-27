Config                            = {}
Config.MaxWeapons                 = 10
Config.OpenKey                    = "F10"
Config.OpenTime                   = 750
Config.WeaponWeight               = 5
Config.DaysToDeleteItemIfNotUsed  = 60

Config.DefaultTrunkCapacity       = 25000

Config.SubExtraCapacity = {
	['level2'] = 200,
	['level3'] = 200,
}

Config.AllowedJobsToOpenPlates = {
	['police'] = true,
}

Config.BypassModels = { --models to not check for ownership
	[`mule3`] = true,
	[`pounder`] = true,
	[`mule2`] = true,
	[`boxville2`] = true,
	[`bagger`] = true,
}

Config.VehicleTrunkLimit = {
	[0] = 200, --Compact
	[1] = 200, --Sedan
	[2] = 300, --SUV
	[3] = 200, --Coupes
	[4] = 300, --Muscle
	[5] = 200, --Sports Classics
	[6] = 200, --Sports
	[7] = 200, --Super
	[8] = 50, --Motorcycles
	[9] = 200, --Off-road
	[10] = 200, --Industrial
	[11] = 200, --Utility
	[12] = 300, --Vans
	[13] = 0, --Cycles
	[14] = 300, --Boats
	[15] = 200, --Helicopters
	[16] = 0, --Planes
	[17] = 200, --Service
	[18] = 200, --Emergency
	[19] = 0, --Military
	[20] = 200, --Commercial
	[21] = 0 --Trains
}


Config.CustomTrunks = {
	[`adder`] = 10,
	[`sumtruck`] = 1500,
	[`ponyyy`] = 1000,
	[`f175`] = 200,
	[`mule2`] = 2000,
	[`boxville2`] = 1500,
	[`bagger`] = 1000,
	[`hino500`] = 9000,
}