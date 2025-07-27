


Config                            = {}


Config.Blips = {
    Scale = 0.9,

    --[[ In Vehicle ]]
    VehicleSprite = 225,
    VehicleColor = 1,

}

Config.MaxVehiclesOnTracker = 20
Config.DrawDistance               = 30.0
Config.HuntedOverheadDrawDistance = 15.0
Config.ArmoryMarkerType           = 21
Config.VehicleMarkerType   		  = 36
Config.HelicopterMarkerType       = 34
Config.BoatMarkerType             = 35
Config.BossActionMarkerType       = 22
Config.CloackroomMarkerType       = 0
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = true -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.BuyAttachmentsMinGrade     = 20

Config.BuyAttachments = {
	{label = 'x20 Grips $20000',		itemName = 'grip'},
	{label = 'x20 Extendeds $20000',	itemName = 'extended'},
	{label = 'x20 Scopes $20000',		itemName = 'scope'},
	{label = 'x20 Suppressors $20000',	itemName = 'suppressor'},
}


Config.Locale = 'en'

Config.Reward = {
	
	Bank = false,

	Items = {
		mushroom = 12,
		wildmushroom = 12,
		weed = 12,
		cannabis = 12,
		lsd = 12,
		kapsoules = 12,
		lysergiko = 12,
		cocaine = 12,
		cocaleaf = 12,
		serotonini = 12,
		dopamini = 12,
		crack = 12,
		premiumcocaleaf = 12,
		ammonia = 12,
		soda = 12,
		mdma = 12,
		amfetamini = 12,
		methilamini = 12,
	},

	Weapon = {		
		WEAPON_KNIFE = 200,

        WEAPON_PISTOL50 = 250,
        WEAPON_GLOCK17 = 250,
        WEAPON_PISTOL = 250,
        WEAPON_SNSPISTOL = 250,
        WEAPON_M9 = 250,
        WEAPON_P226 = 250,

        WEAPON_MP40 = 1260,
		WEAPON_MP5SD = 1260,
		WEAPON_MICROSMG = 1260,
		WEAPON_BIZON = 1260,
		WEAPON_MCX = 1260,
		WEAPON_MAC10 = 1260,
		WEAPON_45ACP = 1260,
		WEAPON_MP7 = 1260,
		WEAPON_MP5A1 = 1260,
		WEAPON_P90 = 1260,
		WEAPON_MPX = 1260,
		WEAPON_PKM = 1260,
		WEAPON_VSS = 1260,
		WEAPON_BTR = 1260,
		WEAPON_HK43 = 1260,
		WEAPON_AK102 = 1260,
		WEAPON_AKM = 1260,
		WEAPON_G36C = 1260,
		WEAPON_HK516 = 1260,
		WEAPON_RPK = 1260,
		WEAPON_TAR = 1260,
		WEAPON_SIG516 = 1260,
		WEAPON_CBQ = 1260,
		WEAPON_M4A4 = 1260,
		WEAPON_MALYUK = 1260,
		WEAPON_M203 = 1260,
		WEAPON_FAMAS = 1260,
		WEAPON_BARSKA = 1260,
		WEAPON_AK47 = 1260,
		WEAPON_AUG = 1260,
		WEAPON_G36K = 1260,
		WEAPON_LVOAC = 1260,
		WEAPON_M4A5 = 1260,
		WEAPON_SUNDA = 1260,
		WEAPON_ISY = 1260,
		WEAPON_M4CQB = 1260,
		WEAPON_ARMK4 = 1260,
		WEAPON_M1A = 1260,
		WEAPON_ACR = 1260,
		WEAPON_SCARMK17 = 1260,
		WEAPON_MDR = 1260,
		WEAPON_FENNEC = 1260,
		WEAPON_FNFAL = 1260,
		WEAPON_KILO433 = 1260,
		WEAPON_STG = 1260,
		WEAPON_T9ACC = 1260,
		WEAPON_AK12 = 1260,
		WEAPON_AK103 = 1260,
		WEAPON_BEOWULF = 1260,
		WEAPON_CARBINERIFLE_MK2 = 1260,
		WEAPON_MARINE = 1260,
		WEAPON_HK416 = 1260,
		WEAPON_AUGA2 = 1260,
		WEAPON_M16A1 = 1260,
		WEAPON_MP5A5 = 1260,
	}

}


Config.PoliceStations = {

	LSPD = {  --dont change 
		Job = 'police',

		Blip = {
			Coords  = vector3(2471.27, -384.58, 109.62),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.1,
			Colour  = 4
		},

		Destroyer = {
			vector3(2048.35, 2983.27, -62.90),
			vector3(600.29, 11.31, 81.74),
			vector3(-455.74, 6014.47, 31.72),
			--
			vector3(1774.12, 2517.14, 45.83),
		},
		
		Cloakrooms = {
			vector3(-2858.90, -1248.65, 1060.93), --Main
			vector3(-433.12,5990.68,31.72), --Paleto
			--
			vector3(1734.53, 2493.80, 45.82), --filakes
			vector3(132.45, -769.66, 242.15), --fib
		},

		Armories = {
			vector3(475.69, 4769.88, -58.99),
			vector3(-1080.73, -860.06, 5.04),	--Eksw
			vector3(-447.62, 6008.62, 31.72),	--Paleto
			vector3(582.16, -12.67, 82.74),		--Main
			--
			vector3(1772.31, 2514.18, 45.83), --filakes
			vector3(118.94, -729.97, 242.15), --fib
			
			vector3(2527.54, -336.06, 101.89),
		},

		Items = {
			--vector3(586.88, -11.81, 82.74), --Main
			--vector3(-427.07, 5999.71, 31.72), --Paleto
			--vector3(-1059.70, -843.79, 4.25), --Vespucci
		},

		--[[StockArmories = { --free inStock
			vector3(479.75, -996.79, 30.5)
		}, ]]

		Vehicles = {
			
			Spawner = vector3(1787.29, 2514.55, 45.57),
			SpawnerPaleto = vector3(-481.72, 6024.10, 31.34),
			SpawnerVespucci = vector3(2537.14, -378.25, 92.99),
			SpawnerPolice1 = vector3(-1075.82, -856.35, 5.04),

			InsideShop = vector4(1782.33, 2462.49, 45.57, 124.0),
			InsideShopPaleto = vector4(-440.09, 5988.79, 35.32, 136.30),
			InsideShopVespucci = vector4(2485.33, -448.28, 92.99, 180.0),
			InsideShopPolice1 = vector4(-1061.75, -865.56, 4.95, 72.74),
			
			SpawnPoints = {
				{ coords = vector3(1794.12, 2474.67, 45.57), heading = 332.96, radius = 6.0 },
			},
			SpawnPointsPaleto = {
				{ coords = vector3(-440.26, 5988.95, 35.32), heading = 106.48, radius = 6.0 },
			},
			SpawnPointsVespucci = {
				{ coords = vector3(2485.33, -448.28, 92.99), heading = 180.00, radius = 6.0 },
			},
			SpawnPointsPolice1 = {
				{ coords = vector3(-1038.76, -855.88, 4.88), heading = 180.00, radius = 6.0 },
			},
		},

		Helicopters = {
			
			Spawner = vector3(1766.62, 2518.86, 55.15),
			SpawnerPaleto = vector3(-461.47, 5998.74, 31.34),
			SpawnerVespucci = vector3(2506.03, -422.06, 118.03),

			InsideShop = vector4(1739.32, 2493.15, 55.15, 348.97),
			InsideShopPaleto = vector4(-378.78, 6051.97, 36.32, 98.27),
			InsideShopVespucci = vector4(2510.99, -342.07, 118.19, 100.0),
			
			SpawnPoints = {
				{ coords =  vector3(1738.38, 2493.03, 55.15) , heading = 339.40, radius = 10.0 }
			},
			SpawnPointsPaleto = {
				{ coords = vector3(-378.50, 6053.02, 36.32), heading = 167.48, radius = 6.0 },
			}
			
		},

		Boats = {
			Spawner = vector3(-1067.80, -955.28, 2.39),
			InsideShop = vector3(-1063.79, -960.57, 0.12),
			SpawnPoints = {
				{ coords = vector3(-1063.79, -960.57, 0.12), heading = 128.07, radius = 10.0 }
			},
		},

		BossActions = {
			vector3(550.19, -25.20, 82.74)
		}

	}, 

	Police2 = {  --dont change 
		Job = 'police2',

		Blip = {
			Coords  = vector3(-439.82, 6019.58, 31.49),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.1,
			Colour  = 38
		},

		Destroyer = {
			vector3(-442.63, 5988.69, 31.72),
		},
		
		Cloakrooms = {
			--vector3(-2858.90, -1248.65, 1060.93), --Main
		},

		Armories = {
			vector3(-437.59, 5988.51, 31.72),
		},

		Items = {
			--vector3(586.88, -11.81, 82.74), --Main
		},

		Vehicles = {
			Spawner = vector3(-486.39, 6023.97, 31.34),

			InsideShop = vector4(-378.78, 6051.97, 36.32, 98.27),
			
			SpawnPoints = {
				{ coords = vector3(-468.42, 6038.64, 31.16), heading = 222.94, radius = 6.0 },
			},
		},

		Helicopters = {
			Spawner = vector3(-461.47, 5998.74, 31.34),

			InsideShop = vector4(1739.32, 2493.15, 55.15, 348.97),
			
			SpawnPoints = {
				{ coords = vector3(-378.50, 6053.02, 36.32), heading = 167.48, radius = 6.0 },
			},
			
		},

		Boats = {
			Spawner = vector3(-1067.80, -955.28, 2.39),
			InsideShop = vector3(-1063.79, -960.57, 0.12),
			SpawnPoints = {
				{ coords = vector3(-1063.79, -960.57, 0.12), heading = 128.07, radius = 10.0 }
			},
		},

		BossActions = {
			vector3(550.19, -25.20, 82.74)
		}
	},
}

Config.WeaponStock = {
	["WEAPON_NIGHTSTICK"] = { quantity = 3, price = 500 },
}

Config.AuthorizedWeapons = {
	[0] = {
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},
	
	[1] = {--Αστυφύλακας
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },

	},

	[2] = {--Υπαρχιφύλακας
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },

	},

	[3] = {--Αρχιφύλακας
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },

	},

	[4] = {--Ανθυπαστυνόμος
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },

	},

	[5] = {--Υπαστυνόμος Β`
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },

	},

	[6] = {--Υπαστυνόμος Α`
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},

	[7] = {--Αστυνόμος Β`
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
	},

	[8] = {--Τροχαία
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},

	[9] = {--Αρχηγός Τροχαίας
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},

	[10] = {--Ομάδα Ζ
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},

	[11] = {--Ομαδάρχης Ομάδας Ζ
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},

	[12] = {--Bounty Hunter B
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},

	[13] = {--Bounty Hunter A
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},

	[14] = {--Άμεση Δράση
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},

	[15] = {--Ομαδάρχης Άμεσης Δράσης
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},

	[16] = {--Ομάδα ΔΙ.ΑΣ.
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},

	[17] = {--Ομαδάρχης Ομάδα ΔΙ.ΑΣ.
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},

	[18] = {--Ο.Π.Κ.Ε.
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},

	[19] = {--Ε.Κ.Α.Μ.
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},

	[20] = {--Ομαδάρχης Ο.Π.Κ.Ε.
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},

	[21] = {--Ομαδάρχης Ε.Κ.Α.Μ.
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},

	[22] = {--Ασφάλεια
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},

	[23] = {--Αστυνόμος Α
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},

	[24] = {--Υποδιοικητής
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},

	[25] = {--Διοικητής
		{ weapon = 'WEAPON_FLASHLIGHT',			price = 1500 },
		{ weapon = 'WEAPON_NIGHTSTICK',			price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 150000 },
		{ weapon = 'WEAPON_STUNGUN',			price = 10000 },
		{ weapon = 'WEAPON_BZGAS',				price = 20000 },
		{ weapon = 'WEAPON_VINTAGEPISTOL',		price = 50000 },

		{ weapon = 'WEAPON_COMBATPISTOL',		price = 50000 },
		{ weapon = 'WEAPON_MINISMG',			price = 40000 },
		{ weapon = 'WEAPON_PISTOL_MK2',			price = 50000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN',		price = 90000 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2',	price = 100000 },
		
		{ weapon = 'WEAPON_M4CQB',				price = 150000 },
		
		
		{ weapon = 'WEAPON_HK416',				price = 150000 },
	
		{ weapon = 'WEAPON_M16A1',				price = 150000 },
		
		
		{ weapon = 'WEAPON_CARBINERIFLE',		price = 120000 },
		{ weapon = 'WEAPON_APPISTOL',			price = 150000 },
		{ weapon = 'WEAPON_SRM2',				price = 300000 },
		{ weapon = 'WEAPON_CAUSTIC_PD',				price = 1000000 },
	},
}

Config.AuthorizedVehicles = {
	Shared = {
	--[[ 	{ model = 'police',		label = 'police',			price = 1, livery = 0 },
		{ model = 'police2',		label = 'police2',			price = 1, livery = 0 },
		{ model = 'police3',		label = 'police3',			price = 1, livery = 0 },
		{ model = 'police4',		label = 'police4',			price = 1, livery = 0 },
		{ model = 'sheriff2',		label = 'sheriff2',			price = 1, livery = 0 },
		{ model = 'policet',		label = 'policet',			price = 1, livery = 0 },
		{ model = 'fbi',		label = 'fbi',			price = 1, livery = 0 },
		{ model = 'pranger',		label = 'pranger',			price = 1, livery = 0 },
		{ model = 'policeb',		label = 'policeb',			price = 1, livery = 0 },
		{ model = 'riot',		label = 'riot',			price = 1, livery = 0 },
		{ model = 'jltv',		label = 'jltv',			price = 1, livery = 0 },
		{ model = 'warfare',		label = 'warfare',			price = 1, livery = 0 },
		{ model = 'xkmaster48v',		label = 'xkmaster48v',			price = 1, livery = 0 },
		{ model = 'scczqjkl',		label = 'scczqjkl',			price = 1, livery = 0 }, ]]

		{ model = '20tahoe',		label = '20tahoe',			price = 1, livery = 0 },
		{ model = 'polevo10',		label = 'polevo10',			price = 1, livery = 0 },
		{ model = 'polaudia4',		label = 'polaudia4',			price = 1, livery = 0 },
		{ model = 'polcharger',		label = 'polcharger',			price = 1, livery = 0 },
		{ model = 'polskoda',		label = 'polskoda',			price = 1, livery = 0 },
		{ model = 'polqashqai',		label = 'polqashqai',			price = 1, livery = 0 },
		{ model = 'polskoda3',		label = 'polskoda3',			price = 1, livery = 0 },
		{ model = 'polbmw',		label = 'polbmw',			price = 1, livery = 0 },


		{ model = 'polamggtr',		label = 'polamggtr',		price = 1, livery = 0 },
		{ model = 'sjcop1',			label = 'sjcop1',			price = 1, livery = 0 },
		{ model = 'ekamcherokee99',	label = 'ekamcherokee99',	price = 1, livery = 0 },
		{ model = 'taxisPolice',	label = 'taxisPolice',		price = 1, livery = 0 },
		{ model = 'taxispolgs',		label = 'taxispolgs',		price = 1, livery = 0 },
		{ model = 'taxisPolice1',	label = 'taxisPolice1',		price = 1, livery = 0 },
		{ model = 'polbmw2',		label = 'polbmw2',			price = 1, livery = 0 },
		{ model = 'polrange',		label = 'polrange',			price = 1, livery = 0 },
		{ model = 'ekam',			label = 'ekam',				price = 1, livery = 0 },
		{ model = 'ekamG65',		label = 'ekamG65',			price = 1, livery = 0 },
		{ model = 'ekame60',		label = 'ekame60',			price = 1, livery = 0 },
		{ model = '2020tacoma',		label = '2020tacoma',		price = 1, livery = 0 },
		{ model = 'ekamtundra',		label = 'ekamtundra',		price = 1, livery = 0 },
		{ model = 'taxispolun',		label = 'taxispolun',		price = 1, livery = 0 },
		{ model = 'police4',		label = 'police4',			price = 1, livery = 0 },
		{ model = 'taxisGTPolice',  label = 'taxisGTPolice',    price = 1, livery = 0 },
	},

	[0] = {--Δοκιμοι
		--{ model = 'pol308',		label = 'pol308',		price = 1, livery = 0 },
		--{ model = 'polaudia4',	label = 'polaudia4',	price = 1, livery = 0 },
		--[[ { model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},	
	
	[1] = {--Αστυφύλακας
		--{ model = 'pol308',	label = 'pol308',		price = 1, livery = 0 },
		--[[ --{ model = 'polaudia4',	label = 'polaudia4',	price = 1, livery = 0 },
		{ model = 'poltahoe',	label = 'poltahoe',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',	price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]

	},
	
	[2] = {--Υπαρχιφύλακας	
		--[[ { model = 'pol308',		label = 'pol308',	 price = 1, livery = 0 },
		--{ model = 'polaudia4',	label = 'polaudia4', price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',price = 1, livery = 0 },
		{ model = 'pol308',		label = 'pol308',    price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]

	},
	
	[3] = {--Αρχιφύλακας	
		--{ model = 'pol308',	label = 'pol308',		price = 1, livery = 0 },
		--{ model = 'polaudia4',	label = 'polaudia4',		price = 1, livery = 0 },
		--[[ { model = 'polrange',	label = 'polrange',		price = 1, livery = 0 },
		--{ model = 'polz',	label = 'polz',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]

	},
	
	[4] = {--Ανθυπαστυνόμος	
		--{ model = 'pol308',	label = 'pol308',		price = 1, livery = 0 },
		--[[ { model = 'polaudia4',	label = 'polaudia4',		price = 1, livery = 0 },
		--{ model = 'polcharger',	label = 'polcharger',		price = 1, livery = 0 },
		--{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		--{ model = 'polskoda3',	label = 'polskoda3',		price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]

	},
	
	[5] = {--Υπαστυνόμος Β`	
		--[[ { model = 'pol308',	label = 'pol308',		price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',		price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',		price = 1, livery = 0 },
		{ model = 'pole60',	label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polbus',	label = 'polbus',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]

	},
	
	[6] = {--Υπαστυνόμος Α`	
	--[[ 	{ model = 'pol308',	label = 'pol308',		price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',		price = 1, livery = 0 },
		{ model = 'pole60',	label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',		price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',		price = 1, livery = 0 },
		{ model = 'polevo9',	label = 'polevo9',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]

	},
	
	[7] = {--Αστυνόμος Β`	
		--[[ { model = 'pol308',	label = 'pol308',		price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',		price = 1, livery = 0 },
		{ model = 'pole60',	label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polevo9',	label = 'polevo9',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',		price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},	
	
	[8] = {--Τροχαία	
		--[[ { model = 'pol308',	label = 'pol308',		price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},	
	
	[9] = {--Αρχηγός Τροχαίας	
	--[[ 	{ model = 'pol308',	label = 'pol308',		price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},

	[10] = {--Ομάδα Ζ
		--[[ { model = '20tahoe',	label = '20tahoe',		price = 1, livery = 0 },
		{ model = '2020tacoma',	label = '2020tacoma',	price = 1, livery = 0 },
		--{ model = 'opke',		label = 'opke',			price = 1, livery = 0 },
		{ model = 'pol308',	label = 'pol308',			price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',		price = 1, livery = 0 },
		{ model = 'polbmw',	label = 'polbmw',		price = 1, livery = 0 },
		{ model = 'polbmw2',	label = 'polbmw2',		price = 1, livery = 0 },
		{ model = 'polbus',	label = 'polbus',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',		price = 1, livery = 0 },
		{ model = 'pole60',	label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polevo9',	label = 'polevo9',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',		price = 1, livery = 0 },
		{ model = 'polrange',	label = 'polrange',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',		price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',		price = 1, livery = 0 },
		{ model = 'poltahoe',	label = 'poltahoe',		price = 1, livery = 0 },
		--{ model = 'polz',	label = 'polz',		price = 1, livery = 0 },
		--{ model = 'sv4',	label = 'sv4',		price = 1, livery = 0 },
		{ model = 'polxt',	label = 'polxt',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},

	[11] = {--Ομαδάρχης Ομάδας Ζ
	--[[ 	{ model = '20tahoe',	label = '20tahoe',		price = 1, livery = 0 },
		{ model = '2020tacoma',	label = '2020tacoma',	price = 1, livery = 0 },
		--{ model = 'opke',		label = 'opke',			price = 1, livery = 0 },
		{ model = 'pol308',	label = 'pol308',			price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',		price = 1, livery = 0 },
		{ model = 'polbmw',	label = 'polbmw',		price = 1, livery = 0 },
		{ model = 'polbmw2',	label = 'polbmw2',		price = 1, livery = 0 },
		{ model = 'polbus',	label = 'polbus',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',		price = 1, livery = 0 },
		{ model = 'pole60',	label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polevo9',	label = 'polevo9',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',		price = 1, livery = 0 },
		{ model = 'polrange',	label = 'polrange',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',		price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',		price = 1, livery = 0 },
		{ model = 'poltahoe',	label = 'poltahoe',		price = 1, livery = 0 },
		--{ model = 'polz',	label = 'polz',		price = 1, livery = 0 },
		--{ model = 'sv4',	label = 'sv4',		price = 1, livery = 0 },
		{ model = 'polxt',	label = 'polxt',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},	
	
	[12] = {--Bounty Hunter B	
	--[[ 	{ model = '20tahoe',	label = '20tahoe',		price = 1, livery = 0 },
		{ model = '2020tacoma',	label = '2020tacoma',	price = 1, livery = 0 },
		--{ model = 'opke',		label = 'opke',			price = 1, livery = 0 },
		{ model = 'pol308',	label = 'pol308',			price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',		price = 1, livery = 0 },
		{ model = 'polbmw',	label = 'polbmw',		price = 1, livery = 0 },
		{ model = 'polbmw2',	label = 'polbmw2',		price = 1, livery = 0 },
		{ model = 'polbus',	label = 'polbus',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',		price = 1, livery = 0 },
		{ model = 'pole60',	label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polevo9',	label = 'polevo9',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',		price = 1, livery = 0 },
		{ model = 'polrange',	label = 'polrange',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',		price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',		price = 1, livery = 0 },
		{ model = 'poltahoe',	label = 'poltahoe',		price = 1, livery = 0 },
		--{ model = 'polz',	label = 'polz',		price = 1, livery = 0 },
		--{ model = 'sv4',	label = 'sv4',		price = 1, livery = 0 },
		{ model = 'polxt',	label = 'polxt',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},	
	
	[13] = {--Bounty Hunter A	
	--[[ 	{ model = '20tahoe',	label = '20tahoe',		price = 1, livery = 0 },
		{ model = '2020tacoma',	label = '2020tacoma',	price = 1, livery = 0 },
		--{ model = 'opke',		label = 'opke',			price = 1, livery = 0 },
		{ model = 'pol308',	label = 'pol308',			price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',		price = 1, livery = 0 },
		{ model = 'polbmw',	label = 'polbmw',		price = 1, livery = 0 },
		{ model = 'polbmw2',	label = 'polbmw2',		price = 1, livery = 0 },
		{ model = 'polbus',	label = 'polbus',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',		price = 1, livery = 0 },
		{ model = 'pole60',	label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polevo9',	label = 'polevo9',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',		price = 1, livery = 0 },
		{ model = 'polrange',	label = 'polrange',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',		price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',		price = 1, livery = 0 },
		{ model = 'poltahoe',	label = 'poltahoe',		price = 1, livery = 0 },
		--{ model = 'polz',	label = 'polz',		price = 1, livery = 0 },
		--{ model = 'sv4',	label = 'sv4',		price = 1, livery = 0 },
		{ model = 'polxt',	label = 'polxt',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},	
	
	[14] = {--Άμεση Δράση	
	--[[ 	{ model = '20tahoe',	label = '20tahoe',		price = 1, livery = 0 },
		{ model = '2020tacoma',	label = '2020tacoma',	price = 1, livery = 0 },
		--{ model = 'opke',		label = 'opke',			price = 1, livery = 0 },
		{ model = 'pol308',	label = 'pol308',			price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',		price = 1, livery = 0 },
		{ model = 'polbmw',	label = 'polbmw',		price = 1, livery = 0 },
		{ model = 'polbmw2',	label = 'polbmw2',		price = 1, livery = 0 },
		{ model = 'polbus',	label = 'polbus',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',		price = 1, livery = 0 },
		{ model = 'pole60',	label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polevo9',	label = 'polevo9',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',		price = 1, livery = 0 },
		{ model = 'polrange',	label = 'polrange',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',		price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',		price = 1, livery = 0 },
		{ model = 'poltahoe',	label = 'poltahoe',		price = 1, livery = 0 },
		--{ model = 'polz',	label = 'polz',		price = 1, livery = 0 },
		--{ model = 'sv4',	label = 'sv4',		price = 1, livery = 0 },
		{ model = 'polxt',	label = 'polxt',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},	
	
	[15] = {--Ομαδάρχης Άμεσης Δράσης	
	--[[ 	{ model = '20tahoe',	label = '20tahoe',		price = 1, livery = 0 },
		{ model = '2020tacoma',	label = '2020tacoma',	price = 1, livery = 0 },
		--{ model = 'opke',		label = 'opke',			price = 1, livery = 0 },
		{ model = 'pol308',		label = 'pol308',		price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',	price = 1, livery = 0 },
		{ model = 'polbmw',		label = 'polbmw',		price = 1, livery = 0 },
		{ model = 'polbmw2',	label = 'polbmw2',		price = 1, livery = 0 },
		{ model = 'polbus',		label = 'polbus',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',	price = 1, livery = 0 },
		{ model = 'pole60',		label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polevo9',	label = 'polevo9',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',	price = 1, livery = 0 },
		{ model = 'polrange',	label = 'polrange',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',	price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',	price = 1, livery = 0 },
		{ model = 'poltahoe',	label = 'poltahoe',		price = 1, livery = 0 },
		--{ model = 'polz',		label = 'polz',			price = 1, livery = 0 },
		--{ model = 'sv4',		label = 'sv4',			price = 1, livery = 0 },
		{ model = 'polxt',		label = 'polxt',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',	price = 1, livery = 0 },
		{ model = 'rs6rabt20',	label = 'rs6rabt20',	price = 1, livery = 0 },
		{ model = 'pveln',		label = 'pveln',		price = 1, livery = 0 },
		{ model = 'pgolfr18',	label = 'pgolfr18',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},	
	
	[16] = {--Ομάδα ΔΙ.ΑΣ.	
		--[[ { model = '20tahoe',	label = '20tahoe',		price = 1, livery = 0 },
		{ model = '2020tacoma',	label = '2020tacoma',	price = 1, livery = 0 },
		--{ model = 'opke',		label = 'opke',			price = 1, livery = 0 },
		{ model = 'pol308',		label = 'pol308',		price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',	price = 1, livery = 0 },
		{ model = 'polbmw',		label = 'polbmw',		price = 1, livery = 0 },
		{ model = 'polbmw2',	label = 'polbmw2',		price = 1, livery = 0 },
		{ model = 'polbus',		label = 'polbus',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',	price = 1, livery = 0 },
		{ model = 'pole60',		label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polevo9',	label = 'polevo9',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',	price = 1, livery = 0 },
		{ model = 'polrange',	label = 'polrange',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',	price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',	price = 1, livery = 0 },
		{ model = 'poltahoe',	label = 'poltahoe',		price = 1, livery = 0 },
		--{ model = 'polz',		label = 'polz',			price = 1, livery = 0 },
		--{ model = 'sv4',		label = 'sv4',			price = 1, livery = 0 },
		{ model = 'polxt',		label = 'polxt',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',	price = 1, livery = 0 },
		{ model = 'rs6rabt20',	label = 'rs6rabt20',	price = 1, livery = 0 },
		{ model = 'pveln',		label = 'pveln',		price = 1, livery = 0 },
		{ model = 'pgolfr18',	label = 'pgolfr18',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},	
	
	[17] = {--Ομαδάρχης Ομάδα ΔΙ.ΑΣ.	
		--[[ { model = '20tahoe',	label = '20tahoe',		price = 1, livery = 0 },
		{ model = '2020tacoma',	label = '2020tacoma',	price = 1, livery = 0 },
		--{ model = 'opke',		label = 'opke',			price = 1, livery = 0 },
		{ model = 'pol308',		label = 'pol308',		price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',	price = 1, livery = 0 },
		{ model = 'polbmw',		label = 'polbmw',		price = 1, livery = 0 },
		{ model = 'polbmw2',	label = 'polbmw2',		price = 1, livery = 0 },
		{ model = 'polbus',		label = 'polbus',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',	price = 1, livery = 0 },
		{ model = 'pole60',		label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polevo9',	label = 'polevo9',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',	price = 1, livery = 0 },
		{ model = 'polrange',	label = 'polrange',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',	price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',	price = 1, livery = 0 },
		{ model = 'poltahoe',	label = 'poltahoe',		price = 1, livery = 0 },
		--{ model = 'polz',		label = 'polz',			price = 1, livery = 0 },
		--{ model = 'sv4',		label = 'sv4',			price = 1, livery = 0 },
		{ model = 'polxt',		label = 'polxt',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',	price = 1, livery = 0 },
		{ model = 'rs6rabt20',	label = 'rs6rabt20',	price = 1, livery = 0 },
		{ model = 'pveln',		label = 'pveln',		price = 1, livery = 0 },
		{ model = 'pgolfr18',	label = 'pgolfr18',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},	
	
	[18] = {--Ο.Π.Κ.Ε.	
		--[[ { model = '20tahoe',	label = '20tahoe',		price = 1, livery = 0 },
		{ model = '2020tacoma',	label = '2020tacoma',	price = 1, livery = 0 },
		--{ model = 'opke',		label = 'opke',			price = 1, livery = 0 },
		{ model = 'pol308',		label = 'pol308',		price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',	price = 1, livery = 0 },
		{ model = 'polbmw',		label = 'polbmw',		price = 1, livery = 0 },
		{ model = 'polbmw2',	label = 'polbmw2',		price = 1, livery = 0 },
		{ model = 'polbus',		label = 'polbus',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',	price = 1, livery = 0 },
		{ model = 'pole60',		label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polevo9',	label = 'polevo9',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',	price = 1, livery = 0 },
		{ model = 'polrange',	label = 'polrange',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',	price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',	price = 1, livery = 0 },
		{ model = 'poltahoe',	label = 'poltahoe',		price = 1, livery = 0 },
		--{ model = 'polz',		label = 'polz',			price = 1, livery = 0 },
		--{ model = 'sv4',		label = 'sv4',			price = 1, livery = 0 },
		{ model = 'polxt',		label = 'polxt',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',	price = 1, livery = 0 },
		{ model = 'rs6rabt20',	label = 'rs6rabt20',	price = 1, livery = 0 },
		{ model = 'pveln',		label = 'pveln',		price = 1, livery = 0 },
		{ model = 'pgolfr18',	label = 'pgolfr18',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},	
	
	[19] = {--Ε.Κ.Α.Μ.	
		--[[ { model = '20tahoe',	label = '20tahoe',		price = 1, livery = 0 },
		{ model = '2020tacoma',	label = '2020tacoma',	price = 1, livery = 0 },
		--{ model = 'opke',		label = 'opke',			price = 1, livery = 0 },
		{ model = 'pol308',		label = 'pol308',		price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',	price = 1, livery = 0 },
		{ model = 'polbmw',		label = 'polbmw',		price = 1, livery = 0 },
		{ model = 'polbmw2',	label = 'polbmw2',		price = 1, livery = 0 },
		{ model = 'polbus',		label = 'polbus',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',	price = 1, livery = 0 },
		{ model = 'pole60',		label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polevo9',	label = 'polevo9',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',	price = 1, livery = 0 },
		{ model = 'polrange',	label = 'polrange',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',	price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',	price = 1, livery = 0 },
		{ model = 'poltahoe',	label = 'poltahoe',		price = 1, livery = 0 },
		--{ model = 'polz',		label = 'polz',			price = 1, livery = 0 },
		--{ model = 'sv4',		label = 'sv4',			price = 1, livery = 0 },
		{ model = 'polxt',		label = 'polxt',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',	price = 1, livery = 0 },
		{ model = 'rs6rabt20',	label = 'rs6rabt20',	price = 1, livery = 0 },
		{ model = 'pveln',		label = 'pveln',		price = 1, livery = 0 },
		{ model = 'pgolfr18',	label = 'pgolfr18',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},
	
	[20] = {--Ομαδάρχης Ο.Π.Κ.Ε.	
		--[[ { model = '20tahoe',	label = '20tahoe',		price = 1, livery = 0 },
		{ model = '2020tacoma',	label = '2020tacoma',	price = 1, livery = 0 },
		--{ model = 'opke',		label = 'opke',			price = 1, livery = 0 },
		{ model = 'pol308',		label = 'pol308',		price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',	price = 1, livery = 0 },
		{ model = 'polbmw',		label = 'polbmw',		price = 1, livery = 0 },
		{ model = 'polbmw2',	label = 'polbmw2',		price = 1, livery = 0 },
		{ model = 'polbus',		label = 'polbus',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',	price = 1, livery = 0 },
		{ model = 'pole60',		label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polevo9',	label = 'polevo9',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',	price = 1, livery = 0 },
		{ model = 'polrange',	label = 'polrange',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',	price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',	price = 1, livery = 0 },
		{ model = 'poltahoe',	label = 'poltahoe',		price = 1, livery = 0 },
		--{ model = 'polz',		label = 'polz',			price = 1, livery = 0 },
		--{ model = 'sv4',		label = 'sv4',			price = 1, livery = 0 },
		{ model = 'polxt',		label = 'polxt',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',	price = 1, livery = 0 },
		{ model = 'rs6rabt20',	label = 'rs6rabt20',	price = 1, livery = 0 },
		{ model = 'pveln',		label = 'pveln',		price = 1, livery = 0 },
		{ model = 'pgolfr18',	label = 'pgolfr18',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},	
	
	[21] = {--Ομαδάρχης Ε.Κ.Α.Μ.	
		--[[ { model = '20tahoe',	label = '20tahoe',		price = 1, livery = 0 },
		{ model = '2020tacoma',	label = '2020tacoma',	price = 1, livery = 0 },
		--{ model = 'opke',		label = 'opke',			price = 1, livery = 0 },
		{ model = 'pol308',		label = 'pol308',		price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',	price = 1, livery = 0 },
		{ model = 'polbmw',		label = 'polbmw',		price = 1, livery = 0 },
		{ model = 'polbmw2',	label = 'polbmw2',		price = 1, livery = 0 },
		{ model = 'polbus',		label = 'polbus',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',	price = 1, livery = 0 },
		{ model = 'pole60',		label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polevo9',	label = 'polevo9',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',	price = 1, livery = 0 },
		{ model = 'polrange',	label = 'polrange',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',	price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',	price = 1, livery = 0 },
		{ model = 'poltahoe',	label = 'poltahoe',		price = 1, livery = 0 },
		--{ model = 'polz',		label = 'polz',			price = 1, livery = 0 },
		--{ model = 'sv4',		label = 'sv4',			price = 1, livery = 0 },
		{ model = 'polxt',		label = 'polxt',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',	price = 1, livery = 0 },
		{ model = 'rs6rabt20',	label = 'rs6rabt20',	price = 1, livery = 0 },
		{ model = 'pveln',		label = 'pveln',		price = 1, livery = 0 },
		{ model = 'pgolfr18',	label = 'pgolfr18',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},	
	
	[22] = {--Ασφάλεια	
	--[[ 	{ model = '20tahoe',	label = '20tahoe',		price = 1, livery = 0 },
		{ model = '2020tacoma',	label = '2020tacoma',	price = 1, livery = 0 },
		--{ model = 'opke',		label = 'opke',			price = 1, livery = 0 },
		{ model = 'pol308',		label = 'pol308',		price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',	price = 1, livery = 0 },
		{ model = 'polbmw',		label = 'polbmw',		price = 1, livery = 0 },
		{ model = 'polbmw2',	label = 'polbmw2',		price = 1, livery = 0 },
		{ model = 'polbus',		label = 'polbus',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',	price = 1, livery = 0 },
		{ model = 'pole60',		label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polevo9',	label = 'polevo9',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',	price = 1, livery = 0 },
		{ model = 'polrange',	label = 'polrange',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',	price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',	price = 1, livery = 0 },
		{ model = 'poltahoe',	label = 'poltahoe',		price = 1, livery = 0 },
		--{ model = 'polz',		label = 'polz',			price = 1, livery = 0 },
		--{ model = 'sv4',		label = 'sv4',			price = 1, livery = 0 },
		{ model = 'polxt',		label = 'polxt',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',	price = 1, livery = 0 },
		{ model = 'rs6rabt20',	label = 'rs6rabt20',	price = 1, livery = 0 },
		{ model = 'pveln',		label = 'pveln',		price = 1, livery = 0 },
		{ model = 'pgolfr18',	label = 'pgolfr18',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},	
	
	[23] = {--Αστυνόμος Α	
		--[[ { model = '20tahoe',	label = '20tahoe',		price = 1, livery = 0 },
		{ model = '2020tacoma',	label = '2020tacoma',	price = 1, livery = 0 },
		--{ model = 'opke',		label = 'opke',			price = 1, livery = 0 },
		{ model = 'pol308',		label = 'pol308',		price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',	price = 1, livery = 0 },
		{ model = 'polbmw',		label = 'polbmw',		price = 1, livery = 0 },
		{ model = 'polbmw2',	label = 'polbmw2',		price = 1, livery = 0 },
		{ model = 'polbus',		label = 'polbus',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',	price = 1, livery = 0 },
		{ model = 'pole60',		label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polevo9',	label = 'polevo9',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',	price = 1, livery = 0 },
		{ model = 'polrange',	label = 'polrange',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',	price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',	price = 1, livery = 0 },
		{ model = 'poltahoe',	label = 'poltahoe',		price = 1, livery = 0 },
		--{ model = 'polz',		label = 'polz',			price = 1, livery = 0 },
		--{ model = 'sv4',		label = 'sv4',			price = 1, livery = 0 },
		{ model = 'polxt',		label = 'polxt',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',	price = 1, livery = 0 },
		{ model = 'rs6rabt20',	label = 'rs6rabt20',	price = 1, livery = 0 },
		{ model = 'pveln',		label = 'pveln',		price = 1, livery = 0 },
		{ model = 'pgolfr18',	label = 'pgolfr18',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},	
	
	[24] = {--Υποδιοικητής	
	--[[ 	{ model = '20tahoe',	label = '20tahoe',		price = 1, livery = 0 },
		{ model = '2020tacoma',	label = '2020tacoma',	price = 1, livery = 0 },
		--{ model = 'opke',		label = 'opke',			price = 1, livery = 0 },
		{ model = 'pol308',		label = 'pol308',		price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',	price = 1, livery = 0 },
		{ model = 'polbmw',		label = 'polbmw',		price = 1, livery = 0 },
		{ model = 'polbmw2',	label = 'polbmw2',		price = 1, livery = 0 },
		{ model = 'polbus',		label = 'polbus',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',	price = 1, livery = 0 },
		{ model = 'pole60',		label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polevo9',	label = 'polevo9',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',	price = 1, livery = 0 },
		{ model = 'polrange',	label = 'polrange',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',	price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',	price = 1, livery = 0 },
		{ model = 'poltahoe',	label = 'poltahoe',		price = 1, livery = 0 },
		--{ model = 'polz',		label = 'polz',			price = 1, livery = 0 },
		--{ model = 'sv4',		label = 'sv4',			price = 1, livery = 0 },
		{ model = 'polxt',		label = 'polxt',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',	price = 1, livery = 0 },
		{ model = 'rs6rabt20',	label = 'rs6rabt20',	price = 1, livery = 0 },
		{ model = 'pveln',		label = 'pveln',		price = 1, livery = 0 },
		{ model = 'pgolfr18',	label = 'pgolfr18',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},	
	
	[25] = {--Διοικητής	
		--[[ { model = '20tahoe',	label = '20tahoe',		price = 1, livery = 0 },
		{ model = '2020tacoma',	label = '2020tacoma',	price = 1, livery = 0 },
		--{ model = 'opke',		label = 'opke',			price = 1, livery = 0 },
		{ model = 'pol308',		label = 'pol308',		price = 1, livery = 0 },
		{ model = 'polaudia4',	label = 'polaudia4',	price = 1, livery = 0 },
		{ model = 'polbmw',		label = 'polbmw',		price = 1, livery = 0 },
		{ model = 'polbmw2',	label = 'polbmw2',		price = 1, livery = 0 },
		{ model = 'polbus',		label = 'polbus',		price = 1, livery = 0 },
		{ model = 'polcharger',	label = 'polcharger',	price = 1, livery = 0 },
		{ model = 'pole60',		label = 'pole60',		price = 1, livery = 0 },
		{ model = 'polevo9',	label = 'polevo9',		price = 1, livery = 0 },
		{ model = 'polnspeedo',	label = 'polnspeedo',	price = 1, livery = 0 },
		{ model = 'polrange',	label = 'polrange',		price = 1, livery = 0 },
		{ model = 'polskoda',	label = 'polskoda',		price = 1, livery = 0 },
		{ model = 'polskoda3',	label = 'polskoda3',	price = 1, livery = 0 },
		{ model = 'polqashqai',	label = 'polqashqai',	price = 1, livery = 0 },
		{ model = 'poltahoe',	label = 'poltahoe',		price = 1, livery = 0 },
		--{ model = 'polz',		label = 'polz',			price = 1, livery = 0 },
		--{ model = 'sv4',		label = 'sv4',			price = 1, livery = 0 },
		{ model = 'polxt',		label = 'polxt',		price = 1, livery = 0 },
		--{ model = 'raptor2',	label = 'Raptor 2',		price = 1, livery = 0 },
		{ model = 'polskoda4',	label = 'polskoda4',	price = 1, livery = 0 },
		{ model = 'rs6rabt20',	label = 'rs6rabt20',	price = 1, livery = 0 },
		{ model = 'pveln',		label = 'pveln',		price = 1, livery = 0 },
		{ model = 'pgolfr18',	label = 'pgolfr18',		price = 1, livery = 0 },
		{ model = 'pr1custom',	label = 'pr1custom',	price = 1, livery = 0 }, ]]
	},
}


Config.AuthorizedBoats = {
	[0] = {--Δημοτική Αστυνομία

	},

	[1] = {--Ομαδάρχης Δημοτικής Αστυνομίας

	},

	[2] = {--Υπαρχιφύλακας

	},

	[3] = {--Αρχιφύλακας

	},

	[4] = {--Λιμενοφύλακας
	},

	[5] = {--Κελευστής
	},

	[6] = {--Επικελευστής
	},

	[7] = {--Πλοίαρχος
	},

	[8] = {--Ο.Υ.Κ.
	},

	[9] = {--Ομαδάρχης Ο.Υ.Κ.
	},

	[10] = {--Αρχιπλοίαρχος
	},

	[11] = {--Αντιναύαρχος
	},

	[12] = {--Ναύαρχος
	},

	[13] = {--Bounty Hunter B

	},

	[14] = {--Bounty Hunter A
	},

	[15] = {--Άμεση Δράση

	},

	[16] = {--Ομαδάρχης Άμεσης Δράσης
		{ model = 'smallboat', label = 'Small Boat', price = 1, livery = 0 },
		{ model = 'HILLBOATY', label = 'Medium Boat', price = 1, livery = 0 },
		{ model = 'largeboat', label = 'Large Boat', price = 1, livery = 0 },

	},

	[17] = {--Ομάδιας ΔΙ.ΑΣ.
		{ model = 'smallboat', label = 'Small Boat', price = 1, livery = 0 },
		{ model = 'HILLBOATY', label = 'Medium Boat', price = 1, livery = 0 },
		{ model = 'largeboat', label = 'Large Boat', price = 1, livery = 0 },
	},

	[18] = {--Ομαδάρχης Ομάδιας ΔΙ.ΑΣ.

	},

	[19] = {--Ο.Π.Κ.Ε.

	},

	[20] = {--Ε.Κ.Α.Μ.

	},

	[21] = {--Ομαδάρχης Ο.Π.Κ.Ε.
	},

	[22] = {--Ομαδάρχης Ε.Κ.Α.Μ.
	},

	[23] = {--Μυστικές Υπηρεσίες

	},

	[24] = {--Αστυνόμος Α

	},

	[25] = {--Υποδιοικητής
		{ model = 'smallboat', label = 'Small Boat', price = 1, livery = 0 },
		{ model = 'HILLBOATY', label = 'Medium Boat', price = 1, livery = 0 },
		{ model = 'largeboat', label = 'Large Boat', price = 1, livery = 0 },
	},

	[26] = {--Διοικητής
		{ model = 'smallboat', label = 'Small Boat', price = 1, livery = 0 },
		{ model = 'HILLBOATY', label = 'Medium Boat', price = 1, livery = 0 },
		{ model = 'largeboat', label = 'Large Boat', price = 1, livery = 0 },
	}
}


Config.AuthorizedHelicopters = {
	[0] = {--Δημοτική Αστυνομία
		
	},

	[1] = {--Ομαδάρχης Δημοτικής Αστυνομίας

	},

	[2] = {--Υπαρχιφύλακας

	},

	[3] = {--Αρχιφύλακας

	},

	[4] = {--Λιμενοφύλακας

	},

	[5] = {--Κελευστής

	},

	[6] = {--Επικελευστής

	},

	[7] = {--Πλοίαρχος

	},

	[8] = {--Ο.Υ.Κ.

	},

	[9] = {--Ομαδάρχης Ο.Υ.Κ.

	},

	[10] = {--Αρχιπλοίαρχος

	},

	[11] = {--Αντιναύαρχος
		--{ model = 'opkeheli', label = 'Police Helicopter', price = 1, livery = 0 },
		{ model = 'polheli', label = 'Police Helicopter 2', price = 1, livery = 0 },
	},

	[12] = {--Ναύαρχος
		--{ model = 'opkeheli', label = 'Police Helicopter', price = 1, livery = 0 },
		{ model = 'polheli', label = 'Police Helicopter 2', price = 1, livery = 0 },
	},

	[13] = {--Bounty Hunter B
		--{ model = 'opkeheli', label = 'Police Helicopter', price = 1, livery = 0 },
		{ model = 'polheli', label = 'Police Helicopter 2', price = 1, livery = 0 },
	},

	[14] = {--Bounty Hunter A

	},

	[15] = {--Άμεση Δράση

	},

	[16] = {--Ομαδάρχης Άμεσης Δράσης

	},

	[17] = {--Ομάδιας ΔΙ.ΑΣ.

	},

	[18] = {--Ομαδάρχης Ομάδιας ΔΙ.ΑΣ.
		--{ model = 'opkeheli', label = 'Police Helicopter', price = 1, livery = 0 },
		{ model = 'polheli', label = 'Police Helicopter 2', price = 1, livery = 0 },

	},

	[19] = {--Ο.Π.Κ.Ε.
		--{ model = 'opkeheli', label = 'Police Helicopter', price = 1, livery = 0 },
		{ model = 'polheli', label = 'Police Helicopter 2', price = 1, livery = 0 },
	},

	[20] = {--Ε.Κ.Α.Μ.
		--{ model = 'opkeheli', label = 'Police Helicopter', price = 1, livery = 0 },
		{ model = 'polheli', label = 'Police Helicopter 2', price = 1, livery = 0 },
	},

	[21] = {--Ομαδάρχης Ο.Π.Κ.Ε.
		--{ model = 'opkeheli', label = 'Police Helicopter', price = 1, livery = 0 },
		{ model = 'polheli', label = 'Police Helicopter 2', price = 1, livery = 0 },
	},

	[22] = {--Ομαδάρχης Ε.Κ.Α.Μ.
		--{ model = 'opkeheli', label = 'Police Helicopter', price = 1, livery = 0 },
		{ model = 'polheli', label = 'Police Helicopter 2', price = 1, livery = 0 },
	},

	[23] = {--Μυστικές Υπηρεσίες
		--{ model = 'opkeheli', label = 'Police Helicopter', price = 1, livery = 0 },
		{ model = 'polheli', label = 'Police Helicopter 2', price = 1, livery = 0 },
	},

	[24] = {--Αστυνόμος Α
		--{ model = 'opkeheli', label = 'Police Helicopter', price = 1, livery = 0 },
		{ model = 'polheli', label = 'Police Helicopter 2', price = 1, livery = 0 },
	},

	[25] = {--Υποδιοικητής
		--{ model = 'opkeheli', label = 'Police Helicopter', price = 1, livery = 0 },
		{ model = 'polheli', label = 'Police Helicopter 2', price = 1, livery = 0 },
	},
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	recruit_wear = {
		male = {
			['mask_1'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 31,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 53,
			['pants_1'] = 58,   ['pants_2'] = 0,
			['shoes_1']=  44,   ['shoes_2'] = 0,
			['chain_1'] = 21,    ['chain_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		},
		female = {
			['mask_1'] = 0,
			['arms'] = 56,
			['pants_1'] = 20,   ['pants_2'] = 0,
			['shoes_1']=  35,   ['shoes_2'] = 0,
			['chain_1'] = 30,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 79,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	recruit_wearW = {
		male = {
			['mask_1'] = 0,
			['tshirt_1'] = 67,  ['tshirt_2'] = 0,
			['torso_1'] = 16,   ['torso_2'] = 3,
			['arms'] = 48,
			['pants_1'] = 58,   ['pants_2'] = 0,
			['shoes_1']=  44,   ['shoes_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		},
		female = {
			['mask_1'] = 0,
			['arms'] = 64,
			['pants_1'] = 20,   ['pants_2'] = 0,
			['shoes_1']=  35,   ['shoes_2'] = 0,
			['chain_1'] = 36,    ['chain_2'] = 0,
			['tshirt_1'] = 46,  ['tshirt_2'] = 0,
			['torso_1'] = 22,   ['torso_2'] = 3,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	astifilakas_wear = {
		male = {
			['mask_1'] = 0,
			['arms'] = 0,
			['pants_1'] = 23,   ['pants_2'] = 0,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['tshirt_1'] = 67,  ['tshirt_2'] = 0,
			['torso_1'] = 16,   ['torso_2'] = 0,
		},
		female = {
			['mask_1'] = 0,
			['arms'] = 14,
			['pants_1'] = 21,   ['pants_2'] = 0,
			['shoes_1']=  35,   ['shoes_2'] = 0,
			['chain_1'] = 36,    ['chain_2'] = 0,
			['tshirt_1'] = 46,  ['tshirt_2'] = 0,
			['torso_1'] = 22,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	astifilakas_wearW = {
		male = {
			['mask_1'] = 0,
			['arms'] = 4,
			['pants_1'] = 23,   ['pants_2'] = 0,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['tshirt_1'] = 67,  ['tshirt_2'] = 0,
			['torso_1'] = 26,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	astifilakas_wearF = {
		male = {
			['mask_1'] = 0,
			['arms'] = 4,
			['pants_1'] = 23,   ['pants_2'] = 1,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 21,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 29,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		},
		female = {
			['mask_1'] = 0,
			['arms'] = 14,
			['pants_1'] = 21,   ['pants_2'] = 1,
			['shoes_1']=  35,   ['shoes_2'] = 0,
			['chain_1'] = 30,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 26,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	astifilakas_wearYpiresias = {
		male = {
			['mask_1'] = 0,
			['arms'] = 11,
			['pants_1'] = 26,   ['pants_2'] = 0,
			['shoes_1']=  10,   ['shoes_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 33,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		},
		female = {
			['mask_1'] = 0,
			['arms'] = 14,
			['pants_1'] = 16,   ['pants_2'] = 0,
			['shoes_1']=  39,   ['shoes_2'] = 0,
			['chain_1'] = 36,    ['chain_2'] = 0,
			['tshirt_1'] = 14,  ['tshirt_2'] = 0,
			['torso_1'] = 31,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	astifilakas_wearYpiresias2 = {
		male = {
			['mask_1'] = 0,
			['arms'] = 6,
			['pants_1'] = 26,   ['pants_2'] = 0,
			['shoes_1']=  10,   ['shoes_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 34,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		},
		female = {
			['mask_1'] = 0,
			['arms'] = 14,
			['pants_1'] = 16,   ['pants_2'] = 0,
			['shoes_1']=  39,   ['shoes_2'] = 0,
			['chain_1'] = 36,    ['chain_2'] = 0,
			['tshirt_1'] = 14,  ['tshirt_2'] = 0,
			['torso_1'] = 32,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	astifilakas_wearSport = {
		male = {
			['mask_1'] = 0,
			['arms'] = 0,
			['pants_1'] = 23,   ['pants_2'] = 0,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 21,    ['chain_2'] = 0,
			['tshirt_1'] = 37,  ['tshirt_2'] = 0,
			['torso_1'] = 36,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		},
		female = {
			['mask_1'] = 0,
			['arms'] = 14,
			['pants_1'] = 21,   ['pants_2'] = 0,
			['shoes_1']=  35,   ['shoes_2'] = 0,
			['chain_1'] = 15,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 34,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	astifilakas_wearJacket = {
		male = {
			['mask_1'] = 0,
			['arms'] = 1,
			['pants_1'] = 23,   ['pants_2'] = 0,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 21,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 101,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		},
		female = {
			['mask_1'] = 0,
			['arms'] = 56,
			['pants_1'] = 21,   ['pants_2'] = 0,
			['shoes_1']=  35,   ['shoes_2'] = 0,
			['chain_1'] = 36,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 80,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	astifilakas_wearPilot = {
		male = {
			['mask_1'] = 0,
			['arms'] = 0,
			['pants_1'] = 30,   ['pants_2'] = 0,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 58,   ['torso_2'] = 0,
			['glasses_1'] = -1,
			['helmet_1'] = 46
		}
	},
	limeniko_wearJacket = {
		male = {
			['mask_1'] = 0,
			['arms'] = 1,
			['pants_1'] = 23,   ['pants_2'] = 0,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 21,    ['chain_2'] = 0,
			['tshirt_1'] = 59,  ['tshirt_2'] = 0,
			['torso_1'] = 102,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		},
		female = {
			['mask_1'] = 0,
			['arms'] = 56,
			['pants_1'] = 21,   ['pants_2'] = 0,
			['shoes_1']=  35,   ['shoes_2'] = 0,
			['chain_1'] = 36,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 80,   ['torso_2'] = 2,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	limeniko_wearScuba = {
		male = {
			['mask_1'] = 16,
			['arms'] = 1,
			['pants_1'] = 150,   ['pants_2'] = 7,
			['shoes_1']=  87,   ['shoes_2'] = 7,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['tshirt_1'] = 204,  ['tshirt_2'] = 0,
			['torso_1'] = 83,   ['torso_2'] = 0,
			['glasses_1'] = 37,   ['glasses_2'] = 0,
			['helmet_1'] = -1,
		},
		female = {
			['mask_1'] = 17,
			['arms'] = 14,
			['pants_1'] = 30,   ['pants_2'] = 0,
			['shoes_1']=  20,   ['shoes_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['tshirt_1'] = 233,  ['tshirt_2'] = 0,
			['torso_1'] = 86,   ['torso_2'] = 0,
			['glasses_1'] = 16,   ['glasses_2'] = 0,
			['helmet_1'] = -1,
		}
	},
	limeniko_wearLimenarxis = {
		male = {
			['mask_1'] = 0,
			['arms'] = 84,
			['pants_1'] = 26,   ['pants_2'] = 1,
			['shoes_1']=  60,   ['shoes_2'] = 4,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['helmet_1'] = 42,
			['glasses_1'] = -1,
		},
		female = {
			['mask_1'] = 0,
			['arms'] = 95,
			['pants_1'] = 16,   ['pants_2'] = 1,
			['shoes_1']=  39,   ['shoes_2'] = 1,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['tshirt_1'] = 14,  ['tshirt_2'] = 0,
			['torso_1'] = 47,   ['torso_2'] = 0,
			['helmet_1'] = 30,
			['glasses_1'] = -1,
		}
	},
	limeniko_wearJacket2 = {
		male = {
			['mask_1'] = 0,
			['arms'] = 8,
			['pants_1'] = 23,   ['pants_2'] = 0,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 27,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	limeniko_wearJacket3 = {
		male = {
			['mask_1'] = 0,
			['arms'] = 8,
			['pants_1'] = 23,   ['pants_2'] = 0,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 18,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		},
		female = {
			['mask_1'] = 0,
			['arms'] = 14,
			['pants_1'] = 21,   ['pants_2'] = 0,
			['shoes_1']=  35,   ['shoes_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 18,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	limeniko_wear = {
		male = {
			['mask_1'] = 0,
			['arms'] = 0,
			['pants_1'] = 23,   ['pants_2'] = 0,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['tshirt_1'] = 37,  ['tshirt_2'] = 0,
			['torso_1'] = 16,   ['torso_2'] = 2,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		},
		female = {
			['mask_1'] = 0,
			['arms'] = 14,
			['pants_1'] = 21,   ['pants_2'] = 0,
			['shoes_1']=  35,   ['shoes_2'] = 0,
			['chain_1'] = 36,    ['chain_2'] = 0,
			['tshirt_1'] = 46,  ['tshirt_2'] = 0,
			['torso_1'] = 22,   ['torso_2'] = 2,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	dias_wear = {
		male = {
			['mask_1'] = 0,
			['mask'] = 22,
			['arms'] = 24,
			['pants_1'] = 46,   ['pants_2'] = 0,
			['shoes_1']=  44,   ['shoes_2'] = 0,
			['chain_1'] = 21,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 53,   ['torso_2'] = 0,
			['glasses_1'] = -1,
			['helmet_1'] = 8
		},
		female = {
			['mask_1'] = 0,
			['arms'] = 22,
			['pants_1'] = 23,   ['pants_2'] = 0,
			['shoes_1']=  35,   ['shoes_2'] = 0,
			['chain_1'] = 21,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['glasses_1'] = -1,
			['helmet_1'] = 8
		}
	},
	dias_wearMplouza = {
		male = {
			['mask_1'] = 0,
			['arms'] = 0,
			['pants_1'] = 23,   ['pants_2'] = 0,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['tshirt_1'] = 23,  ['tshirt_2'] = 0,
			['torso_1'] = 16,   ['torso_2'] = 4,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		},
		female = {
			['mask_1'] = 0,
			['arms'] = 14,
			['pants_1'] = 21,   ['pants_2'] = 0,
			['shoes_1']=  35,   ['shoes_2'] = 0,
			['chain_1'] = 36,    ['chain_2'] = 0,
			['tshirt_1'] = 46,  ['tshirt_2'] = 0,
			['torso_1'] = 22,   ['torso_2'] = 4,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	opke_wear = {
		male = {
			['mask_1'] = 0,
			['arms'] = 0,
			['pants_1'] = 23,   ['pants_2'] = 1,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['tshirt_1'] = 23,  ['tshirt_2'] = 0,
			['torso_1'] = 16,   ['torso_2'] = 1,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		},
		female = {
			['mask_1'] = 0,
			['arms'] = 14,
			['pants_1'] = 21,   ['pants_2'] = 1,
			['shoes_1']=  35,   ['shoes_2'] = 0,
			['chain_1'] = 36,    ['chain_2'] = 0,
			['tshirt_1'] = 46,  ['tshirt_2'] = 0,
			['torso_1'] = 22,   ['torso_2'] = 1,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	opke_wear2 = {
		male = {
			['mask_1'] = 0,
			['arms'] = 2,
			['pants_1'] = 23,   ['pants_2'] = 1,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 21,    ['chain_2'] = 0,
			['tshirt_1'] = 23,  ['tshirt_2'] = 0,
			['torso_1'] = 26,   ['torso_2'] = 1,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	opke_wear3 = {
		male = {
			['mask_1'] = 0,
			['arms'] = 1,
			['pants_1'] = 23,   ['pants_2'] = 1,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 21,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 29,   ['torso_2'] = 1,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	opke_wear4 = {
		male = {
			['mask_1'] = 0,
			['arms'] = 1,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 21,    ['chain_2'] = 0,
			['tshirt_1'] = 33,  ['tshirt_2'] = 0,
			['torso_1'] = 30,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	opke_wear5 = {
		male = {
			['mask_1'] = 0,
			['arms'] = 1,
			['pants_1'] = 23,   ['pants_2'] = 1,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 21,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 31,   ['torso_2'] = 1,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		},
		female = {
			['mask_1'] = 0,
			['arms'] = 56,
			['pants_1'] = 21,   ['pants_2'] = 1,
			['shoes_1']=  35,   ['shoes_2'] = 0,
			['chain_1'] = 36,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 80,   ['torso_2'] = 1,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	opke_wear6 = {
		male = {
			['mask_1'] = 0,
			['arms'] = 0,
			['pants_1'] = 23,   ['pants_2'] = 1,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['tshirt_1'] = 59,  ['tshirt_2'] = 0,
			['torso_1'] = 36,   ['torso_2'] = 1,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		},
		female = {
			['mask_1'] = 0,
			['arms'] = 14,
			['pants_1'] = 21,   ['pants_2'] = 1,
			['shoes_1']=  35,   ['shoes_2'] = 0,
			['chain_1'] = 15,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 34,   ['torso_2'] = 1,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	opke_wear7 = {
		male = {
			['mask_1'] = 0,
			['arms'] = 0,
			['pants_1'] = 23,   ['pants_2'] = 1,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 20,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 37,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	opke_wear8 = {
		male = {
			['mask_1'] = 0,
			['arms'] = 0,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 21,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 94,   ['torso_2'] = 0,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		},
		female = {
			['mask_1'] = 0,
			['arms'] = 22,
			['pants_1'] = 23,   ['pants_2'] = 2,
			['shoes_1']=  35,   ['shoes_2'] = 0,
			['chain_1'] = 21,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 2,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		}
	},
	ekam_wear = {
		male = {
			['mask_1'] = 0,
			['arms'] = 0,
			['pants_1'] = 31,   ['pants_2'] = 1,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 21,    ['chain_2'] = 0,
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 30,   ['torso_2'] = 1,
			['helmet_1'] = -1,
			['glasses_1'] = -1,
		},
	},
	ekam_wear2 = {
		male = {
			['mask_1'] = 22,
			['arms'] = 24,  
			['pants_1'] = 31,   ['pants_2'] = 1,
			['shoes_1']=  45,   ['shoes_2'] = 0,
			['chain_1'] = 21,    ['chain_2'] = 0,
			['tshirt_1'] = 59,  ['tshirt_2'] = 0,
			['torso_1'] = 94,   ['torso_2'] = 1,
			['glasses_1'] = -1,
			['helmet_1'] = 47
		},
	},
}

Config.UniqueClothes = {
	[`mp_m_freemode_01`] = {
		['HatsHelmets']	= {
			[92] = true,
		},
		['Glasses']		= {},
		['Masks']		= {},
		['Hair']		= {},
		['Pants']		= {},
		['Bags']		= {},
		['Shoes']		= {},
		['Chains']		= {},
		['ShirtAcc']	= {},
		['BodyArmor']	= {
			[2] = true,
			[3] = true,
			[4] = true,
			[6] = true,
			[7] = true,
			[8] = true,
			[10] = true,
			[17] = true,
			[18] = true,
			[19] = true,
			[23] = true,
			[52] = true,
			[55] = true,
		},
		['Badges']		= {},
		['ShirtOver']	= {
			[32] = true, 
			[38] = true, 
			[39] = true, 
			[40] = true, 
			[41] = true, 
			[42] = true, 
			[73] = true, 
			[74] = true, 
			[87] = true, 
			[91] = true, 
			[131] = true,
			[29] = true,
		},
	},

	[`mp_f_freemode_01`] = {
		['HatsHelmets']	= {},
		['Glasses']		= {},
		['Masks']		= {},
		['Hair']		= {},
		['Pants']		= {},
		['Bags']		= {},
		['Shoes']		= {},
		['Chains']		= {},
		['ShirtAcc']	= {},
		['BodyArmor']	= {},
		['ShirtOver']	= {},
	},
}

Config.Drawables = {
	['HatsHelmets']		 = {get = function() return GetPedPropIndex(PlayerPedId(), 0)			end, clear = function() return ClearPedProp(PlayerPedId(), 0) end},
	['Glasses']			 = {get = function() return GetPedPropIndex(PlayerPedId(), 1)			end, clear = function() return ClearPedProp(PlayerPedId(), 1) end},
	['Masks']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 1)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 0) end},
	['Hair']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 2)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 2, 0, 0, 0) end},
	['Pants']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 4)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 4, 0, 0, 0) end},
	['Bags']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 5)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0) end},
	['Shoes']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 6)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 6, 0, 0, 0) end},
	['Chains']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 7)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 7, 0, 0, 0) end},
	['ShirtAcc']		 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 8)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 8, 15, 0, 0) end},
	['BodyArmor']		 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 9)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 9, 0, 0, 0) end},
	['Badges']			 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 10)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 10, 0, 0, 0) end},
	['ShirtOver']		 = {get = function() return GetPedDrawableVariation(PlayerPedId(), 11)	end, clear = function() return SetPedComponentVariation(PlayerPedId(), 11, 15, 0, 0) end},
}