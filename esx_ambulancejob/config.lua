Config                            = {}

Config.DrawDistance               = 15.0

Config.Marker                     = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }

Config.ReviveReward               = 1250  -- revive reward, set to 0 if you don't want it enabled
Config.ReviveRewardSociety		  = 450
Config.DeathReward                = 150
Config.AntiCombatLog              = true	-- enable anti-combat logging?
Config.LoadIpl                    = true	-- disable if you're using fivem-ipl or other IPL loaders
Config.PropertyMenuTime 		  = 30000
Config.AutoRespawnTimer 		  = 180		--RESPAWN TIME HERE
Config.AutoRespawnTimerHS 		  = 30		--RESPAWN TIME FROM HEADSHOT
Config.AllowPayRespawnAfter       = 60		--SECONDS TO PASS TO ALLOW PAYRESPAWN
Config.PayRespawnPrice            = 5000	--PAYRESPAWN PRICE
Config.Locale = 'en'

Config.BodyBleedout               = 420
Config.DefaultBleedout            = 540
Config.HeadshotBleedout           = 45
Config.MaxBleedout                = 600

Config.TemporaryGreenzoneTimer    = 1800	--seconds
Config.TemporaryGreenzoneRadius   = 300.0

Config.WeaponCooldown			  = 0	--seconds

Config.DontLoseItems = {
	['trapezi'] = true,
}

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 3 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 2 * minute -- Time til the player bleeds out

Config.RewardTime                 = 30 * minute  --TESTING
Config.Rewards = {
	{
		deaths = 30,
		revives = 10,
		reward = 100
	},
	{
		deaths = 60,
		revives = 30,
		reward = 500
	},
	{
		deaths = 100,
		revives = 40,
		reward = 800
	},
}

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true
Config.RemoveItemsAfterRPDeath2    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 3000
Config.ReviveLogsWebhook = 'https://canary.discordapp.com/api/webhooks/733437764564942868/a_RJz-JMdsO-la0LMTIX3TxFXSbnZRVErldOdeIKYxl8s9SjGsNZN6PzreMKESbIHsPL'

Config.RespawnPoints = {
	{ coords = vector3(-239.38, 6322.83, 32.43), heading = 226.00 },	--Paleto
	{ coords = vector3(1842.11, 3669.71, 33.68), heading = 207.00 },	--Sandy
	{ coords = vector3(-888.73, -853.50, 20.57), heading = 290.00 },	--City
	{ coords = vector3(4050.76, -4695.23, 4.23), heading = 320.00 },	--Cayo
}

Config.RespawnPointsSelect = {
	{ coords = vector3(4045.53, -4674.45, 4.19), heading = 318.92, label = "Cayo Perico"  },
	{ coords = vector3(1740.52, 3718.09, 34.05), heading = 16.88, label = "Sandy Shores" },
	{ coords = vector3(-52.80, -1222.30, 28.70), heading = 94.68, label = "In Town" },
	{ coords = vector3(-73.73, 6348.13, 31.49), heading = 125.41 , label = "Paleto" },
	{ coords = vector3(-417.30, -319.08, 33.73), heading = 83.69, label = "Ambulance" },
	{ coords = vector3(658.75, 11.22, 85.03), heading = 240.13, label = "Police" },
}

--NPC Medic------------------------------------
Config.CostMedicNPC = 3000
Config.MaxNpcDistance = 100000.0
Config.MinMedicsToCall = 6

Config.BlacklistedNpcZones = {
	['OCEANA'] = true,	--Pacific Ocean
	['PALCOV'] = true,	--Paleto Cove
}
-----------------------------------------------
Config.PayRespawn = 100000
-----------------------------------------------

Config.RespawnAfterSurgery = vector3(-461.55, -326.44, 34.50)
Config.RespawnAfterSurgeryHeading = 83.95

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(-817.58, -1227.04, 17.18),
			sprite = 61,
			scale  = 0.7,
			color  = 4
		},

		
		--[[ Armories = {
			vector3(309.16, -562.39, 42.28)
		}, ]]

		AmbulanceActions = {
			vector3(4930.73,-1997.21,1998.21)
		},

		Pharmacies = {
			vector3(4925.94,-1999.47,1998.21)
		},

		Vehicles = {
			{
				Spawner = vector3(-840.56, -1235.08, 6.93),
				InsideShop = vector3(-834.79, -1303.64, 5.00),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-834.79, -1303.64, 5.00), heading = 0.00, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(-855.71, -1232.36, 14.83),
				InsideShop = vector3(-834.50, -1280.34, 5.00),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-834.50, -1280.34, 5.00), heading = 20.15, radius = 10.0 }
				}
			}
		},

		FastTravels = {
		},

		FastTravelsPrompt = {
		}

	},
	--[[ MasterResident = {

		Blip = {
			coords = vector3(1155.04, -460.19, 66.83),
			sprite = 61,
			scale  = 0.7,
			color  = 2
		},

		AmbulanceActions = {
			vector3(-6050.25, -1351.84, 497.79)
		},

		Pharmacies = {
		},

		Vehicles = {
			{
				Spawner = vector3(1152.91, -456.99, 66.98),
				InsideShop = vector3(1158.36, -464.48, 66.75),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(1151.79, -462.55, 66.79), heading = 170.46, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(-259.22,6309.39,37.57),
				InsideShop = vector3(-74.63, -819.32, 326.56),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-252.39,6319.08,39.66), heading = 314.42, radius = 10.0 }
				}
			}
		},

		FastTravels = {

		},

		FastTravelsPrompt = {

		}

	}, ]]
	PaletoBay = {

		Blip = {
			coords = vector3(-247.44,6330.77,32.43),
			sprite = 61,
			scale  = 0.7,
			color  = 2
		},

		AmbulanceActions = {
			vector3(-252.26,6309.7,31.44)
		},

		Pharmacies = {
			vector3(-429.55, -318.98, -999.91)
		},

		Vehicles = {
			{
				Spawner = vector3(-258.37, 6347.79, 32.43),
				InsideShop = vector3(-258.37, 6347.79, 32.43),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-261.00, 6343.78, 32.43), heading = 270.29, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(-259.22,6309.39,37.57),
				InsideShop = vector3(-74.63, -819.32, 326.56),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-252.39,6319.08,39.66), heading = 314.42, radius = 10.0 }
				}
			}
		},

		FastTravels = {

		},

		FastTravelsPrompt = {

		}

	},
	Alter = {

		Blip = {
			coords = vector3(448.57, -988.02, 30.69),
			sprite = 61,
			scale  = 0.7,
			color  = 2
		},

		AmbulanceActions = {
			vector3(-252.26,6309.7,31.44)
		},

		Pharmacies = {
			vector3(-429.55, -318.98, -999.91)
		},

		Vehicles = {
			{
				Spawner = vector3(427.91, -1013.20, 28.93),
				InsideShop = vector3(427.91, -1013.20, 28.93),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(427.91, -1013.20, 28.93), heading = 180.00, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(453.69, -988.76, 43.69),
				InsideShop = vector3(453.69, -988.76, 43.69),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(453.69, -988.76, 43.69), heading = 0.00, radius = 10.0 }
				}
			}
		},

		FastTravels = {

		},

		FastTravelsPrompt = {

		}

	},
}

--[[ Config.AuthorizedVehicles = {
	
	ambulance = {
		{ model = 'smartekav',		label = 'smartekav',		price = 1, livery = 0},
		{ model = 'fa_ambulance',	label = 'fa_ambulance',		price = 1, livery = 0},
		{ model = 'evleob',			label = 'evleob',			price = 1, livery = 0},
		{ model = 'golf6ekav',		label = 'golf6ekav',		price = 1, livery = 0},
		{ model = 'claekab',		label = 'claekab',			price = 1, livery = 0},
		{ model = 'ekabebike',		label = 'ekabebike',		price = 1, livery = 0},
		{ model = 'kawasaki',		label = 'kawasaki',			price = 1, livery = 0},
		{ model = 'ambulance2d2',	label = 'ambulance2d2',		price = 1, livery = 0},
		{ model = 'insurgent2d2',	label = 'insurgent2d2',		price = 1, livery = 0},
	},
	
	surgeon = {
		{ model = 'smartekav',		label = 'smartekav',		price = 1, livery = 0},
		{ model = 'fa_ambulance',	label = 'fa_ambulance',		price = 1, livery = 0},
		{ model = 'evleob',			label = 'evleob',			price = 1, livery = 0},
		{ model = 'golf6ekav',		label = 'golf6ekav',		price = 1, livery = 0},
		{ model = 'claekab',		label = 'claekab',			price = 1, livery = 0},
		{ model = 'ekabebike',		label = 'ekabebike',		price = 1, livery = 0},
		{ model = 'kawasaki',		label = 'kawasaki',			price = 1, livery = 0},
		{ model = 'ambulance2d2',	label = 'ambulance2d2',		price = 1, livery = 0},
		{ model = 'insurgent2d2',	label = 'insurgent2d2',		price = 1, livery = 0},
	},
	
	doctor = {
		{ model = 'smartekav',		label = 'smartekav',		price = 1, livery = 0},
		{ model = 'fa_ambulance',	label = 'fa_ambulance',		price = 1, livery = 0},
		{ model = 'evleob',			label = 'evleob',			price = 1, livery = 0},
		{ model = 'golf6ekav',		label = 'golf6ekav',		price = 1, livery = 0},
		{ model = 'claekab',		label = 'claekab',			price = 1, livery = 0},
		{ model = 'ekabebike',		label = 'ekabebike',		price = 1, livery = 0},
		{ model = 'kawasaki',		label = 'kawasaki',			price = 1, livery = 0},
		{ model = 'ambulance2d2',	label = 'ambulance2d2',		price = 1, livery = 0},
		{ model = 'insurgent2d2',	label = 'insurgent2d2',		price = 1, livery = 0},
	},
	
	viceboss = {
		{ model = 'smartekav',		label = 'smartekav',		price = 1, livery = 0},
		{ model = 'fa_ambulance',	label = 'fa_ambulance',		price = 1, livery = 0},
		{ model = 'evleob',			label = 'evleob',			price = 1, livery = 0},
		{ model = 'golf6ekav',		label = 'golf6ekav',		price = 1, livery = 0},
		{ model = 'claekab',		label = 'claekab',			price = 1, livery = 0},
		{ model = 'ekabebike',		label = 'ekabebike',		price = 1, livery = 0},
		{ model = 'kawasaki',		label = 'kawasaki',			price = 1, livery = 0},
		{ model = 'ambulance2d2',	label = 'ambulance2d2',		price = 1, livery = 0},
		{ model = 'insurgent2d2',	label = 'insurgent2d2',		price = 1, livery = 0},
	},
	
	boss = {
		{ model = 'smartekav',		label = 'smartekav',		price = 1, livery = 0},
		{ model = 'fa_ambulance',	label = 'fa_ambulance',		price = 1, livery = 0},
		{ model = 'evleob',			label = 'evleob',			price = 1, livery = 0},
		{ model = 'golf6ekav',		label = 'golf6ekav',		price = 1, livery = 0},
		{ model = 'claekab',		label = 'claekab',			price = 1, livery = 0},
		{ model = 'ekabebike',		label = 'ekabebike',		price = 1, livery = 0},
		{ model = 'kawasaki',		label = 'kawasaki',			price = 1, livery = 0},
		{ model = 'ambulance2d2',	label = 'ambulance2d2',		price = 1, livery = 0},
		{ model = 'insurgent2d2',	label = 'insurgent2d2',		price = 1, livery = 0},
	}
} ]]

Config.AuthorizedVehicles = {
	
	ambulance = {
		--[[
		{ model = 'ekav308',		label = 'ekav308',		price = 1, livery = 0},
	
	
		{ model = 'ekavrange',		label = 'ekavrange',	price = 1, livery = 0},
		{ model = 'taxisAmb1',		label = 'taxisAmb1',	price = 1, livery = 0},
		{ model = 'taxisambgs',		label = 'taxisambgs',	price = 1, livery = 0}, ]]
		{ model = 'ekavqashqai',	label = 'ekavqashqai',	price = 1, livery = 0},
		 { model = 'ekav',			label = 'ekav',			price = 1, livery = 0},
		{ model = 'ekavskoda',		label = 'ekavskoda',	price = 1, livery = 0},
		{ model = 'ekavbmw',		label = 'ekavbmw',		price = 1, livery = 0},
		{ model = 'ekavbmw2',		label = 'ekavbmw2',		price = 1, livery = 0},
		{ model = 'scczqjkl',		label = 'scczqjkl',	price = 1, livery = 0},
		{ model = 'ambulance', label = 'ambulance', price = 1, livery = 0},
		{ model = 'lguard', label = 'lguard', price = 1, livery = 0},
	},
	
	surgeon = {
		{ model = 'ekavqashqai',	label = 'ekavqashqai',	price = 1, livery = 0},
		 { model = 'ekav',			label = 'ekav',			price = 1, livery = 0},
		{ model = 'ekavskoda',		label = 'ekavskoda',	price = 1, livery = 0},
		{ model = 'ekavbmw',		label = 'ekavbmw',		price = 1, livery = 0},
		{ model = 'ekavbmw2',		label = 'ekavbmw2',		price = 1, livery = 0},
		{ model = 'scczqjkl',		label = 'scczqjkl',	price = 1, livery = 0},
		{ model = 'ambulance', label = 'ambulance', price = 1, livery = 0},
		{ model = 'lguard', label = 'lguard', price = 1, livery = 0},

	},
	
	doctor = {
		{ model = 'ekavqashqai',	label = 'ekavqashqai',	price = 1, livery = 0},
		 { model = 'ekav',			label = 'ekav',			price = 1, livery = 0},
		{ model = 'ekavskoda',		label = 'ekavskoda',	price = 1, livery = 0},
		{ model = 'ekavbmw',		label = 'ekavbmw',		price = 1, livery = 0},
		{ model = 'ekavbmw2',		label = 'ekavbmw2',		price = 1, livery = 0},
		{ model = 'scczqjkl',		label = 'scczqjkl',	price = 1, livery = 0},
		{ model = 'ambulance', label = 'ambulance', price = 1, livery = 0},
		{ model = 'lguard', label = 'lguard', price = 1, livery = 0},

	},
	
	viceboss = {
		{ model = 'ekavqashqai',	label = 'ekavqashqai',	price = 1, livery = 0},
		 { model = 'ekav',			label = 'ekav',			price = 1, livery = 0},
		{ model = 'ekavskoda',		label = 'ekavskoda',	price = 1, livery = 0},
		{ model = 'ekavbmw',		label = 'ekavbmw',		price = 1, livery = 0},
		{ model = 'ekavbmw2',		label = 'ekavbmw2',		price = 1, livery = 0},
		{ model = 'scczqjkl',		label = 'scczqjkl',	price = 1, livery = 0},
		{ model = 'ambulance', label = 'ambulance', price = 1, livery = 0},
		{ model = 'lguard', label = 'lguard', price = 1, livery = 0},

	},
	
	boss = {
		{ model = 'ekavqashqai',	label = 'ekavqashqai',	price = 1, livery = 0},
		 { model = 'ekav',			label = 'ekav',			price = 1, livery = 0},
		{ model = 'ekavskoda',		label = 'ekavskoda',	price = 1, livery = 0},
		{ model = 'ekavbmw',		label = 'ekavbmw',		price = 1, livery = 0},
		{ model = 'ekavbmw2',		label = 'ekavbmw2',		price = 1, livery = 0},
		{ model = 'scczqjkl',		label = 'scczqjkl',	price = 1, livery = 0},
		{ model = 'ambulance', label = 'ambulance', price = 1, livery = 0},
		{ model = 'lguard', label = 'lguard', price = 1, livery = 0},

	}
}

Config.AuthorizedHelicopters = {

	ambulance = {
		{ model = 'ekavheli', label = 'Ambulance Helicopter', price = 1, livery = 0},
	},

	surgeon = {
		{ model = 'ekavheli', label = 'Ambulance Helicopter', price = 1, livery = 0},
	},

	doctor = {
		{ model = 'ekavheli', label = 'Ambulance Helicopter', price = 1, livery = 0},
	},

	viceboss = {
		{ model = 'ekavheli', label = 'Ambulance Helicopter', price = 1, livery = 0},
	},

	boss = {
		{ model = 'ekavheli', label = 'Ambulance Helicopter', price = 1, livery = 0},
	}
}


--[[ Config.AuthorizedHelicopters = {

	ambulance = {

	},

	surgeon = {
	},

	doctor = {
		{ model = 'EC-135', label = 'Ambulance Helicopter', price = 1, livery = 0},
		{ model = 'policejpheliii', label = 'Ambulance Helicopter 2', price = 1, livery = 0},
	},

	viceboss = {
		{ model = 'EC-135', label = 'Ambulance Helicopter', price = 1, livery = 0},
		{ model = 'policejpheliii', label = 'Ambulance Helicopter 2', price = 1, livery = 0},
	},

	boss = {
		{ model = 'EC-135', label = 'Ambulance Helicopter', price = 1, livery = 0},
		{ model = 'policejpheliii', label = 'Ambulance Helicopter 2', price = 1, livery = 0},
	}
} ]]

Config.RewardMoney = 1000 
Config.WantedTime = 300000 --5 minutes in milliseconds 

----------------------------------------------------------------ConfigHospital code below
ConfigHospital = {}
ConfigHospital.Locale = 'en'

ConfigHospital.MarkerType   = 1
ConfigHospital.DrawDistance = 10.0
ConfigHospital.MarkerSize   = {x = 2.0, y = 2.0, z = 1.0}
ConfigHospital.MarkerColor  = {r = 102, g = 102, b = 204}
ConfigHospital.Price = 3000 -- Edit this to your liking.
ConfigHospital.RevivePrice = 20000 -- Edit this to your liking.
ConfigHospital.SurgeryPrice = 10000 -- Edit this to your liking.

ConfigHospital.EnableUnemployedOnly = false -- If true it will only show Blips to Unemployed Players | false shows it to Everyone.
ConfigHospital.EnableBlips = false -- If true then it will show blips | false does the Opposite.
ConfigHospital.EnablePeds = true -- If true then it will add Peds on Markers | false does the Opposite.

ConfigHospital.Locations = {
	{ x = 4935.78, y = -2018.90, z = 1998.20, heading = 82.69 },
	{ x = -251.80, y = 6331.69, z = 31.43, heading = 48.10 },
	{ x = -251.80, y = -4696.30, z = 3.14, heading = 337.05 },
	{ x = 4052.71, y = -4696.30, z = 3.14, heading = 337.05 }, 
}

ConfigHospital.ReviveLocations = {
	{ x = -419.38, y = 1146.54, z = 325.86, heading = 162.34 },
	{ x = 1878.08, y = 2615.73, z = 44.67, heading = 192.72 },
	{ x = 64.95, y = 3608.55, z = 39.88, heading = 283.06 },
	{ x = 1549.59, y = 847.40, z = 77.58, heading = 72.36 },
	{ x = 2567.42, y = -336.04, z = 93.12, heading = 178.69 },
	--hackerboy
	{ x = -395.91, y = 1229.11, z = 325.64, heading = 166.88 },
	{ x = -523.69, y = 672.58, z = 143.18, heading = 132.56 },
	{ x = -563.59, y = 521.44, z = 106.59, heading = 226.83 },
	{ x = -248.37, y = 414.40, z = 109.00, heading = 267.25 },
	{ x = -119.16, y = 523.44, z = 143.59, heading = 113.68 },
	{ x = 1708.29, y = 6400.92, z = 33.38, heading = 255.61 },
	{ x = 153.54, y = 6549.25, z = 31.87, heading = 195.73 },
	{ x = 2002.33, y = 2568.73, z = 54.59, heading = 195.73 },
	{ x = 1888.14, y = 2393.27, z = 53.71, heading = 341.67 },
	
	{ x = 1073.86, y = 425.32, z = 91.55, heading = 100.00 },
	{ x = 1368.26, y = 712.00, z = 79.81, heading = 250.00 },
	{ x = 1006.96, y = 486.95, z = 98.76, heading = 270.00 },
	{ x = 1726.46, y = 1512.06, z = 84.77, heading = 170.00 },
	--hackerboy new
	{ x = 149.96, y = -1368.84, z = 29.27, heading = 195.83 },
	{ x = 402.70, y = -1466.52, z = 29.49, heading = 299.04 },
	{ x = 439.23, y = -1634.51, z = 29.35, heading = 282.00 },
	{ x = 25.52,  y = -1674.66, z = 29.30, heading = 298.04 },
	{ x = 2522.82,  y = 5470.20, z = 44.60, heading = 18.03 },
	{ x = 2628.90,  y = 5095.06, z = 45.09, heading = 14.94 },

	{ x = 1631.59, y = 1099.26, z = 81.93, heading = 76.40 },
	{ x = 1629.28, y = 1202.41, z = 84.79, heading = 265.40 },
	{ x = 1656.12, y = 1318.04, z = 86.70, heading = 252.73 },
	{ x = 1755.81, y = 2017.58, z = 68.83, heading = 276.28 },
	{ x = 1875.71, y = 2426.65, z = 54.54, heading = 337.19 },
	{ x = 1624.05, y = 1205.46, z = 85.17, heading = 256.42 },
	{ x = 2795.54, y = 4395.25, z = 49.18, heading = 13.07 },
	{ x = 2789.22, y = 4419.29, z = 48.96, heading = 204.71 },
	{ x = 2452.46, y = 2943.95, z = 40.67, heading = 25.19 },
	{ x = 2209.45, y = 2751.11, z = 45.80, heading = 307.34 },


	{ x = -187.38, y = -2017.44, z = 27.62, heading = 145.43 },
	{ x = -46.97, y = -1222.47, z = 29.10, heading = 268.25 },
	{ x = 768.56, y = -1407.24, z = 26.52, heading = 270.02 },
	{ x = -888.96, y = -855.13, z = 20.57, heading = 14.46 },
	{ x = 1840.44, y = 3670.54, z = 33.81, heading = 214.69 },
	{ x = -231.54, y = 6326.04, z = 31.74, heading = 225.40 },
	{ x = 181.49, y = -918.29, z = 30.69, heading = 93.70 },
	{ x = -364.54, y = 26.42, z = 47.63, heading = 351.66 },
	{ x = -1527.84, y = -280.69, z = 49.24, heading = 241.71 },
	{ x = 326.01, y = -207.87, z = 54.09, heading = 176.53 },
	{ x = 1749.00, y = 3720.47, z = 34.03, heading = 110.8 },
	{ x = -1340.57, y = -1299.33, z = 4.84, heading = 296.0 },
	{ x = 636.49, y = 57.18, z = 88.29, heading = 162.23 },
	{ x = -463.81, y = -338.65, z = 34.50, heading = 100.62 },
	{ x = -442.46, y = 6025.92, z = 31.34, heading = 301.34 },
	{ x = 4070.38, y = -4677.88, z = 4.19, heading = 116.60 },

	
	{ x = -759.22, y = 5517.53, z = 35.40, heading = 212.45 },
	{ x = -978.41, y = 5415.40, z = 39.83, heading = 197.13 },
	{ x = -1166.29, y = 5251.89, z = 53.30, heading = 27.95 },
	{ x = -1419.93, y = 5094.62, z = 60.67, heading = 212.56 },
	{ x = -1562.29, y = 4955.31, z = 61.64, heading = 238.93 },
	{ x = -1776.80, y = 4741.87, z = 57.20, heading = 134.62 },
	{ x = -2171.99, y = 4453.69, z = 62.74, heading = 204.27 },
	{ x = -2364.50, y = 4074.81, z = 31.52, heading = 260.93 },
	{ x = -2511.73, y = 3602.80, z = 14.36, heading = 263.87 },
	{ x = -2162.03, y = -369.88, z = 13.11, heading = 354.10 },
	{ x = -3060.14, y = 1728.43, z = 36.32, heading = 282.29 },
	{ x = -2187.70, y = -362.16, z = 13.11, heading = 340.68 },
	{ x = -2973.24, y = 372.90, z = 14.77, heading = 85.55 },
	
	{ x = 2759.64, y = 3478.45, z = 54.59, heading = 255.00 },
	{ x = 2908.62, y = 4375.31, z = 49.40, heading = 10.00 },
	
	{ x = 2908.62, y = 4375.31, z = 49.40, heading = 10.00 },
	
	{ x = 5314.98, y = -5602.38, z = 64.97, heading = 10.00 },
	{ x = 5256.94, y = -5443.40, z = 63.77, heading = 10.00 },
	{ x = 4895.17, y = -5461.99, z = 30.64, heading = 10.00 },
	
	{ x = -818.19, y = -1236.21, z = 7.34, heading = 348.06 },

	{ x = 437.03, y = -986.50, z = 30.69, heading = 315.00 },
	{ x = -242.31, y = 6320.97, z = 32.43, heading = 80.00 },
}

ConfigHospital.PlasticSurgery = {
	{ x = 4052.71, y = -2011.84, z = 1998.20, heading = 274.97 },
}

ConfigHospital.Zones = {}

for i=1, #ConfigHospital.Locations, 1 do
	ConfigHospital.Zones['Shop_' .. i] = {
		Pos   = ConfigHospital.Locations[i],
		Size  = ConfigHospital.MarkerSize,
		Color = ConfigHospital.MarkerColor,
		Type  = ConfigHospital.MarkerType
	}
	
end

ConfigHospital.Zones['Surgery'] = {
	Pos   = ConfigHospital.PlasticSurgery[1],
	Size  = ConfigHospital.MarkerSize,
	Color = ConfigHospital.MarkerColor,
	Type  = ConfigHospital.MarkerType
}

-------------------------------------------------------------------------------------------Bedsystem Code Below
ConfigBedsystem = {}

ConfigBedsystem.Healing = 0 -- // If this is 0, then its disabled.. Default: 3.. That means, if a person lies in a bed, then he will get 1 health every 3 seconds.
ConfigBedsystem.Cooldown = 2 -- // If this is 0, then its disabled.. Default: 2.. That means, if a player goes and stand up, then he need to wait 2 seconds, before he can lay/sit again! [VERY RECOMMENDED]

ConfigBedsystem.objects = {
	Object = nil, ObjectVertX = nil, ObjectVertY = nil, ObjectVertZ = nil, ObjectDir = nil, isBed = nil, -- // Please don't change this line!;)
	ButtonToSitOnChair = 58, -- // Default: G -- // https://docs.fivem.net/game-references/controls/
	ButtonToLayOnBed = 38, -- // Default: E -- // https://docs.fivem.net/game-references/controls/
	ButtonToStandUp = 23, -- // Default: F -- // https://docs.fivem.net/game-references/controls/
	SitAnimation = {anim='PROP_HUMAN_SEAT_CHAIR_MP_PLAYER'},
	BedBackAnimation = {dict='anim@gangops@morgue@table@', anim='ko_front'},
	BedStomachAnimation = {anim='WORLD_HUMAN_SUNBATHE'},
	BedSitAnimation = {anim='WORLD_HUMAN_PICNIC'},
	locations = {
		{object="v_med_bed1", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true},
		{object="v_med_bed2", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true},
		{object="v_serv_ct_chair02", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.0, direction=168.0, bed=false},
		{object="prop_off_chair_04", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="prop_off_chair_03", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="prop_off_chair_05", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="v_club_officechair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="v_ilev_leath_chr", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="v_corp_offchair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="v_med_emptybed", verticalOffsetX=0.0, verticalOffsetY=0.13, verticalOffsetZ=-0.2, direction=90.0, bed=false},
		{object="Prop_Off_Chair_01", verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	}
}

ConfigBedsystem.Text = {
	SitOnChair = '~g~G~w~ to sit',
	SitOnBed = '~g~E~w~ to sit on the bed',
	LieOnBed = '~g~E~w~ to lie on your',
	SwitchBetween = '~w~ Switch between the stomach, back and sit with the ~g~arrow keys',
	Standup = '~g~F~w~ to stand up!'
}

---------------------------------------------------------------------------------------------------------------------------------------
ConfigSurgeryBed = {
    Price = 250,
    ReviveTime = 60, -- seconds until you are revived
    Hospitals = {
        {
            Bed = {coords = vector3(255.84, -1352.3, 25.52), heading = 317.0, occupied = false},
            Peds = {
                pedHash = -730659924,
                reception = {coords = vector3(262.11, -1359.78, 23.54), heading = 51.9},
                doctor = {coords = vector3(255.2, -1351.74, 23.55), heading = 232.59},
            },
        },
    },
}

Strings = {
    ['get_help'] = [[Press %s to get help for ~g~$%s]],
    ['not_enough'] = [[You don't have enough money!]],
    ['getting_help'] = [[You are getting help, %s seconds left!]],
    ['occupied'] = [[The bed is occupied! Come back later]]
}