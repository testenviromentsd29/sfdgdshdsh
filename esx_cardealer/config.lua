Config = {}

Config.VipDiscount = 25 -- percent

Config.TestDrive = { --default
	seconds = 30,
	coords  = vector3(-942.64,-3365.96,12.95),
	range   = 400.0,
	heading = 58.0,
}

Config.Colors = {
	{id = 0,	hex = "#0d1116"},	--Metallic Black
    {id = 111,	hex = "#ffffff"},	--Metallic White
    {id = 4,	hex = "#999da0"},	--Metallic Silver
    {id = 64,	hex = "#47578f"},	--Metallic Blue
    {id = 27,	hex = "#c00e1a"},	--Metallic Red
    {id = 12,	hex = "#13181f"},	--Matte Black
    {id = 39,	hex = "#cf1f21"},	--Matte Red
    {id = 62,	hex = "#233155"},	--Metallic Dark Blue
}

Config.Dealers = {
	["white"] = {
		label = "Dealer",
		view_catalog_coords = vector3(-2189.78, -389.48, 13.47),
		vehicle_spawn_point = vector3(-2179.47, -370.66, 13.10),
		vehicle_spawn_heading = 167.86,
		vehicle_preview_point = vector3(-2035.47, -362.69, 52.00),
		vehicle_preview_heading = 101.84,
		marker_draw_distance = 30,
		marker_type = 36,
		marker_size = { x = 2.0, y = 2.0, z = 2.0 },
		marker_colour = { r = 200, g = 200, b = 200 },
		vehicle_type = 'car',
		have_blip = false,
		camera = {
			camera_coords = { x = -2047.72 , y = -365.94 , z = 54.64 },
			camRotation = { RX = -19.96, RY = -0.0, RZ = -79.37 },
		},
		blip = {
			sprite = 225,
			scale = 1.0,
			color = 3,
		},
		job = {
			setjob = "cardealer2",
			percentToSociety = 5,
			percentCheaperIfIHaveTheJob = 20,
		}
	},
	["white2"] = {
		label = "Dealer",
		view_catalog_coords = vector3(253.20, -1149.72, 29.28),
		vehicle_spawn_point = vector3(253.12, -1162.20, 29.15),
		vehicle_spawn_heading = 0.00,
		vehicle_preview_point = vector3(296.15, -1157.04, 36.25),
		vehicle_preview_heading = 0.00,
		marker_draw_distance = 30,
		marker_type = 36,
		marker_size = { x = 2.0, y = 2.0, z = 2.0 },
		marker_colour = { r = 200, g = 200, b = 200 },
		vehicle_type = 'car',
		have_blip = false,
		camera = {
			camera_coords = { x = 305.83 , y = -1146.65 , z = 36.24 },
			camRotation = { RX = -5.46, RY = 0.05, RZ = 138.13 },
		},
		blip = {
			sprite = 225,
			scale = 1.0,
			color = 3,
		},
		job = {
			setjob = "cardealer6",
			percentToSociety = 5,
			percentCheaperIfIHaveTheJob = 20,
		}
	},
	["white3"] = {
		label = "Dealer",
		view_catalog_coords = vector3(-585.10, -1161.41, 22.18),
		vehicle_spawn_point = vector3(-596.88, -1088.95, 22.18),
		vehicle_spawn_heading = 227.00,
		vehicle_preview_point = vector3(-586.58, -1189.30, 17.67),
		vehicle_preview_heading = 306.00,
		marker_draw_distance = 30,
		marker_type = 36,
		marker_size = { x = 2.0, y = 2.0, z = 2.0 },
		marker_colour = { r = 200, g = 200, b = 200 },
		vehicle_type = 'car',
		have_blip = false,
		camera = {
			camera_coords = { x = -566.12 , y = -1180.62 , z = 25.79 },
			camRotation = { RX = -31.90, RY = -4.26, RZ = 99.64 },
		},
		blip = {
			sprite = 225,
			scale = 1.0,
			color = 3,
		},
		job = {
			setjob = "cardealer7",
			percentToSociety = 5,
			percentCheaperIfIHaveTheJob = 20,
		}
	},
	--
	["aspra"] = {
		label = "Dealer",
		view_catalog_coords = vector3(684.27, 622.18, 128.91),
		vehicle_spawn_point = vector3(703.35, 649.89, 128.91),
		vehicle_spawn_heading = 247.86,
		vehicle_preview_point = vector3(624.08, 614.86, 129.28),
		vehicle_preview_heading = 305.0,
		marker_draw_distance = 30,
		marker_type = 36,
		marker_size = { x = 2.0, y = 2.0, z = 2.0 },
		marker_colour = { r = 200, g = 200, b = 200 },
		vehicle_type = 'car',
		have_blip = false,
		camera = {
			camera_coords = { x = 629.33 , y = 628.68 , z = 129.14 },
			camRotation = { RX = -8.94, RY = -0.0, RZ = 159.27 },
		},
		blip = {
			sprite = 225,
			scale = 1.0,
			color = 3,
		},
		job = {
			setjob = "cardealer3",
			percentToSociety = 5,
			percentCheaperIfIHaveTheJob = 20,
		}
	},

	--
	--[[["black"] = {
		label = "Black Dealer",
		view_catalog_coords = vector3(-2187.03, -399.57, 13.29),
		vehicle_spawn_point = vector3(-2145.38, -378.24, 13.17),
		vehicle_spawn_heading = 167.06,
		vehicle_preview_point = vector3(-2038.52, -369.15, 48.11),
		vehicle_preview_heading = 139.40,
		marker_draw_distance = 30,
		marker_type = 36,
		marker_size = { x = 2.0, y = 2.0, z = 2.0 },
		marker_colour = { r = 200, g = 200, b = 200 },
		vehicle_type = 'car',
		have_blip = false,
		camera = {
			camera_coords = { x = -2047.82 , y = -379.08 , z = 52.26 },
			camRotation = { RX = -19.25, RY = 0.0, RZ = -46.25 },
		},
		blip = {
			sprite = 225,
			scale = 1.0,
			color = 3,
		},
		job = {
			setjob = "cardealer4",
			percentToSociety = 5,
			percentCheaperIfIHaveTheJob = 20,
		}
	},]]
	
	["leuka"] = {
		label = "Dealer",
		view_catalog_coords = vector3(-833.48, -2356.48, 14.57),
		vehicle_spawn_point = vector3(-824.05, -2359.74, 14.57),
		vehicle_spawn_heading = 327.26,
		vehicle_preview_point = vector3(-818.74, -2351.92, 14.57),
		vehicle_preview_heading = 73.06,
		marker_draw_distance = 30,
		marker_type = 36,
		marker_size = { x = 2.0, y = 2.0, z = 2.0 },
		marker_colour = { r = 200, g = 200, b = 200 },
		vehicle_type = 'car',
		have_blip = false,
		camera = {
			camera_coords = { x = -826.82 , y = -2349.46 , z = 18.94 },
			camRotation = { RX = -36.95, RY = 0.0, RZ = -116.24 },
		},
		blip = {
			sprite = 225,
			scale = 1.0,
			color = 3,
		},
		TestDrive = { 
			seconds = 30,
			coords  = vector3(-817.75, -2346.11, 14.57),
			range   = 500,
			heading = 145.00,
		},
		job = {
			setjob = "cardealer5",
			percentToSociety = 5,
			percentCheaperIfIHaveTheJob = 20,
		}
	},

	["cardealer8"] = {
		label = "Dealer",
		view_catalog_coords = vector3(77.46, -205.52, 54.49),
		vehicle_spawn_point = vector3(85.83, -213.11, 54.49),
		vehicle_spawn_heading = 340.00,
		vehicle_preview_point = vector3(74.44, -257.96, 55.15),
		vehicle_preview_heading = 23.00,
		marker_draw_distance = 30,
		marker_type = 36,
		marker_size = { x = 2.0, y = 2.0, z = 2.0 },
		marker_colour = { r = 200, g = 200, b = 200 },
		vehicle_type = 'car',
		have_blip = false,
		camera = {
			camera_coords = { x = 65.32 , y = -240.00 , z = 57.98 },
			camRotation = { RX = -11.16, RY = -0.0, RZ = -157.50 },
		},
		blip = {
			sprite = 225,
			scale = 1.0,
			color = 3,
		},
		job = {
			setjob = "cardealer8",
			percentToSociety = 5,
			percentCheaperIfIHaveTheJob = 20,
		}
	},

	["cardealer9"] = {
		label = "Dealer",
		view_catalog_coords = vector3(-796.46, -219.90, 37.25),
		vehicle_spawn_point = vector3(-743.63, -258.75, 36.95),
		vehicle_spawn_heading = 38.00,
		vehicle_preview_point = vector3(-758.46, -235.48, 37.28),
		vehicle_preview_heading = 200.00,
		marker_draw_distance = 30,
		marker_type = 36,
		marker_size = { x = 2.0, y = 2.0, z = 2.0 },
		marker_colour = { r = 200, g = 200, b = 200 },
		vehicle_type = 'car',
		have_blip = false,
		camera = {
			camera_coords = { x = -752.37 , y = -246.49 , z = 37.09 },
			camRotation = { RX = -1.63, RY = 0.05, RZ = 27.94 },
		},
		blip = {
			sprite = 225,
			scale = 1.0,
			color = 3,
		},
		job = {
			setjob = "cardealer9",
			percentToSociety = 5,
			percentCheaperIfIHaveTheJob = 20,
		}
	},
	
	["second"] = {
		label = "Boat Dealer",
		view_catalog_coords = vector3(-784.39, -1355.73, 5.15),
		vehicle_spawn_point = vector3(-727.14, -1357.52, 0.09),
		vehicle_spawn_heading = 132.90,
		vehicle_preview_point = vector3(-874.06, -1348.48, 1.58),
		vehicle_preview_heading = 190.04,
		marker_draw_distance = 30,
		marker_type = 35,
		marker_size = { x = 2.0, y = 2.0, z = 2.0 },
		marker_colour = { r = 200, g = 200, b = 200 },
		vehicle_type = 'boat',
		have_blip = true,
		camera = {
			camera_coords = { x = -871.38, y = -1381.0, z = 6.65 },
			camRotation = { RX = -0.0, RY = 0.0, RZ = 1.02 },
		},
		blip = {
			sprite = 427,
			scale = 1.0,
			color = 3,
		},
		TestDrive = { 
			seconds = 30,
			coords  = vector3(-892.62, -1680.08, -5.80),
			range   = 500,
			heading = 132.88,
		},	
		job = {
			setjob = "boatdealer",
			percentToSociety = 20,
			percentCheaperIfIHaveTheJob = 20,
		}
	},
	["third"] = {
		label = "Boat Dealer",
		view_catalog_coords = vector3(4050.57, -4691.16, 4.21),
		vehicle_spawn_point = vector3(4075.32, -4727.97, 0.22),
		vehicle_spawn_heading = 208.90,
		vehicle_preview_point = vector3(4147.07, -5052.04, 0.54),
		vehicle_preview_heading = 344.04,
		marker_draw_distance = 30,
		marker_type = 35,
		marker_size = { x = 2.0, y = 2.0, z = 2.0 },
		marker_colour = { r = 200, g = 200, b = 200 },
		vehicle_type = 'boat',
		have_blip = false,
		camera = {
			camera_coords = { x = 4147.19, y = -5024.35, z = 5.76 },
			camRotation = { RX = -180.0, RY = -180.0, RZ = 8.93 },
		},
		blip = {
			sprite = 427,
			scale = 1.0,
			color = 3,
		},
		TestDrive = { 
			seconds = 30,
			coords  = vector3(4537.31, -4776.62, 0.22),
			range   = 500,
			heading = 123.88,
		},	
		job = {
			setjob = "boatdealer",
			percentToSociety = 20,
			percentCheaperIfIHaveTheJob = 20,
		}
	},
	["heli_dealer"] = {
		label = "Heli Dealer",
		view_catalog_coords = vector3(-1034.26, -3016.67, 13.95),
		vehicle_spawn_point = vector3(-1046.04, -3047.86, 13.95),
		vehicle_spawn_heading = 60.00,
		vehicle_preview_point = vector3(-999.26, -3004.23, 48.73),
		vehicle_preview_heading = 315.00,
		marker_draw_distance = 34,
		marker_type = 34,
		marker_size = { x = 2.0, y = 2.0, z = 2.0 },
		marker_colour = { r = 200, g = 200, b = 200 },
		vehicle_type = 'helicopter',
		helicopter_rent_spawn_locations = {
			{ pos = vector3(-1131.93, -2998.09, 13.95), heading = 60.00 },
		},
		camera = {
			camera_coords = { x = -999.84 , y = -2985.97 , z = 55.28 },
			camRotation = { RX = -20.104454040527, RY = -5.3360849960882e-08, RZ = -177.48161315918 },
		},
		have_blip = true,
		blip = {
			sprite = 64,
			scale = 0.8,
			color = 3,
		},
		job = {
			setjob = "heli1",
			percentToSociety = 20,
			percentCheaperIfIHaveTheJob = 15,
		}
	},
	--[[ ["helaki2_dealership"] = {
		label = "Heli Dealer",
		view_catalog_coords = vector3(4021.92, -4647.25, 4.01),
		vehicle_spawn_point = vector3(3921.85, -4632.97, 2.15),
		vehicle_spawn_heading = 91.0,
		vehicle_preview_point = vector3(4042.58, -4635.83, 4.76),
		vehicle_preview_heading = 189.11,
		marker_draw_distance = 34,
		marker_type = 34,
		marker_size = { x = 2.0, y = 2.0, z = 2.0 },
		marker_colour = { r = 200, g = 200, b = 200 },
		vehicle_type = 'helicopter',
		helicopter_rent_spawn_locations = {
			{ pos = vector3(4049.61, -4635.23, 4.00), heading = 108.0 },
		},
		helicopter_rent_return_coords = vector3(3985.82, -4661.11, 4.27),
		camera = {
			camera_coords = { x = 4039.22, y = -4660.02, z = 6.16},
			camRotation = { RX = 0.0, RY = 0.0, RZ = -5.7 },
		},
		have_blip = false,
		blip = {
			sprite = 64,
			scale = 0.8,
			color = 3,
		},
		job = {
			setjob = "heli2",
			percentToSociety = 20,
			percentCheaperIfIHaveTheJob = 15,
		}
		
	},
	["helak3_dealershipp"] = {
		label = "Heli Dealer",
		view_catalog_coords = vector3(-1141.61, -314.96, 37.82),
		vehicle_spawn_point = vector3(-1121.07, -335.51, 50.02),
		vehicle_spawn_heading = 94.0,
		vehicle_preview_point = vector3(-1154.55, -318.31, 46.78),
		vehicle_preview_heading = 277.0,
		marker_draw_distance = 34,
		marker_type = 34,
		marker_size = { x = 2.0, y = 2.0, z = 2.0 },
		marker_colour = { r = 200, g = 200, b = 200 },
		vehicle_type = 'helicopter',
		helicopter_rent_spawn_locations = {
			{ pos = vector3(-1121.07, -335.51, 50.02), heading = 94.0 },
		},
		helicopter_rent_return_coords = vector3(-1153.19, -317.96, 46.78),
		camera = {
			camera_coords = { x = -1136.5, y = -305.34 , z = 49.11},
			camRotation = { RX = -13.04, RY = 0.0, RZ = 127.89 },
		},
		have_blip = true,
		blip = {
			sprite = 64,
			scale = 0.8,
			color = 3,
		},
		job = {
			setjob = "heli3",
			percentToSociety = 20,
			percentCheaperIfIHaveTheJob = 15,
		}
		
	},
	["helak4_dealershipp"] = {
		label = "Heli Dealer",
		view_catalog_coords = vector3(-724.07, -1478.30, 5.00),
		vehicle_spawn_point = vector3(-764.67, -1452.28, 5.00),
		vehicle_spawn_heading = 251.0,
		vehicle_preview_point = vector3(-736.27, -1455.45, 5.00),
		vehicle_preview_heading = 198.0,
		marker_draw_distance = 34,
		marker_type = 34,
		marker_size = { x = 2.0, y = 2.0, z = 2.0 },
		marker_colour = { r = 200, g = 200, b = 200 },
		vehicle_type = 'helicopter',
		helicopter_rent_spawn_locations = {
			{ pos = vector3(-764.67, -1452.28, 5.00), heading = 251.0 },
		},
		helicopter_rent_return_coords = vector3(-764.67, -1452.28, 5.00),
		camera = {
			camera_coords = { x = -728.5, y = -1476.34 , z = 7.11},
			camRotation = { RX = -0.0, RY = 0.0, RZ = 12.07 },
		},
		have_blip = true,
		blip = {
			sprite = 64,
			scale = 0.8,
			color = 3,
		},
		job = {
			setjob = "heli4",
			percentToSociety = 20,
			percentCheaperIfIHaveTheJob = 15,
		}
		
	},
	["helak5_dealershipp"] = {
		label = "Heli Dealer",
		view_catalog_coords = vector3(1778.86, 3234.19, 42.40),
		vehicle_spawn_point = vector3(1761.02, 3258.74, 41.48),
		vehicle_spawn_heading = 100.0,
		vehicle_preview_point = vector3(1713.58, 3253.90, 41.76) ,
		vehicle_preview_heading = 243.0,
		marker_draw_distance = 34,
		marker_type = 34,
		marker_size = { x = 2.0, y = 2.0, z = 2.0 },
		marker_colour = { r = 200, g = 200, b = 200 },
		vehicle_type = 'helicopter',
		helicopter_rent_spawn_locations = {
			{ pos = vector3(1771.17, 3240.10, 42.14), heading = 104.0 },
		},
		helicopter_rent_return_coords = vector3(1771.17, 3240.10, 42.14),
		camera = {
			camera_coords = { x = 1690.65, y = 3249.94, z = 45.28},
			camRotation = { RX = -12.96, RY = -0.0, RZ = -85.84 },
		},
		have_blip = true,
		blip = {
			sprite = 64,
			scale = 0.8,
			color = 3,
		},
		job = {
			setjob = "heli5",
			percentToSociety = 20,
			percentCheaperIfIHaveTheJob = 15,
		}
	},
	["helak6_dealershipp"] = {
		label = "Heli Dealer",
		view_catalog_coords = vector3(-194.64, -1983.60, 27.62),
		vehicle_spawn_point = vector3(-183.84, -1960.80, 27.62),
		vehicle_spawn_heading = 180.83,
		vehicle_preview_point = vector3(-201.26, -1968.98, 27.62),
		vehicle_preview_heading = 180.83,
		marker_draw_distance = 34,
		marker_type = 34,
		marker_size = { x = 2.0, y = 2.0, z = 2.0 },
		marker_colour = { r = 200, g = 200, b = 200 },
		vehicle_type = 'helicopter',
		helicopter_rent_spawn_locations = {
			{ pos = vector3(-183.84, -1960.80, 27.62), heading = 180.83 },
		},
		helicopter_rent_return_coords = vector3(-201.26, -1968.98, 27.62),
		camera = {
			camera_coords = { x = -183.22, y = -1978.89 , z = 31.71},
			camRotation = { RX = -16.29, RY = -0.0, RZ = 63.68 },
		},
		have_blip = true,
		blip = {
			sprite = 64,
			scale = 0.8,
			color = 3,
		},
		job = {
			setjob = "heli6",
			percentToSociety = 20,
			percentCheaperIfIHaveTheJob = 15,
		}
		
	},
	
	["helak7_dealershipp"] = {
		label = "Heli Dealer",
		view_catalog_coords = vector3(-1900.97, 1998.88, 141.88),
		vehicle_spawn_point = vector3(-1897.50, 2025.52, 140.74),
		vehicle_spawn_heading = 173.79,
		vehicle_preview_point = vector3(-1900.54, 2008.80, 141.54),
		vehicle_preview_heading = 180.83,
		marker_draw_distance = 34,
		marker_type = 34,
		marker_size = { x = 2.0, y = 2.0, z = 2.0 },
		marker_colour = { r = 200, g = 200, b = 200 },
		vehicle_type = 'helicopter',
		helicopter_rent_spawn_locations = {
			{ pos = vector3(-1896.43, 2011.57, 141.40), heading = 181.91 },
		},
		helicopter_rent_return_coords = vector3(-1900.54, 2008.80, 141.54),
		camera = {
			camera_coords = { x = -1897.21, y = 2008.41 , z = 144.13},
			camRotation = { RX = -22.04, RY = -0.0, RZ = -9.59 },
		},
		have_blip = false,
		blip = {
			sprite = 64,
			scale = 0.8,
			color = 3,
		},
		job = {
			setjob = "heli7",
			percentToSociety = 20,
			percentCheaperIfIHaveTheJob = 15,
		}
	}, ]]
}