Config = {}

Config.Events = {
	{name = 'Gang Cargo',		resource = 'gang_cargo',		type = 'cargo',	coords = vector3(1121.57, 3390.17, 35.00),		getCooldown = function() return exports['gang_cargo']:GetCooldown()		end},
	{name = 'Police Cargo',		resource = 'police_cargo',		type = 'cargo',	coords = vector3(-2347.95, 3266.95, 32.81),		getCooldown = function() return exports['police_cargo']:GetCooldown()	end},
	{name = 'Heli Cargo',		resource = 'heli_cargo',		type = 'cargo',	coords = vector3(2121.41, 4782.38, 40.97),		getCooldown = function() return exports['heli_cargo']:GetCooldown()		end},
	{name = 'Boat Cargo',		resource = 'cargo',				type = 'cargo',	coords = vector3(13.92, -2798.37, 4.09),		getCooldown = function() return exports['cargo']:GetCooldown()			end},
	{name = 'Drug Cargo',		resource = 'drugCargo',			type = 'cargo',	coords = vector3(1552.32, -2126.44, 77.29) ,		getCooldown = function() return exports['drugCargo']:GetCooldown()		end},
	{name = 'Premium Cargo',	resource = 'premiumCargo',		type = 'cargo',	coords = vector3(1742.50, -1623.27, 112.37),	getCooldown = function() return exports['premiumCargo']:GetCooldown()	end},
	{name = 'Military Cargo',	resource = 'military_cargo',	type = 'cargo',	coords = vector3(-2305.11, 3388.24, 31.26),		getCooldown = function() return exports['military_cargo']:GetCooldown()	end},
	{name = 'Vangelico Cargo',	resource = 'vangelico_rob',		type = 'cargo',	coords = vector3(-631.44, -239.22, 38.11),		getCooldown = function() return exports['vangelico_rob']:GetCooldown()	end},
	{name = 'Heist Cargo',		resource = 'heist_cargo',		type = 'cargo',	coords = vector3(-820.43, -1268.31, 5.15),		getCooldown = function() return exports['heist_cargo']:GetCooldown()	end},
	{name = 'Train Cargo',		resource = 'train_event',		type = 'cargo',	coords = vector3(-142.01, 6148.82, 32.34),		getCooldown = function() return exports['train_event']:GetCooldown()	end},
	{name = 'All Cargo',		resource = 'all_cargo',			type = 'cargo',	coords = vector3(1247.38, -3332.89, 6.03),		getCooldown = function() return exports['all_cargo']:GetCooldown()		end},
	{name = 'Car Cargo',		resource = 'car_cargo',			type = 'cargo',	coords =  vector3(-1132.10, 2690.92, 18.80),		getCooldown = function() return exports['car_cargo']:GetCooldown()		end},
	
	--{name = 'Groove Drop',		resource = 'cj_GroveDrop',		type = 'crate',	coords = vector3(54.76, -1808.43, 25.24),		getCooldown = function() return exports['cj_GroveDrop']:GetCooldown()	end},
	--{name = 'Sandy Drop',		resource = 'cj_SandyDrop',		type = 'crate',	coords = vector3(776.93, 3327.67, 41.43),		getCooldown = function() return exports['cj_SandyDrop']:GetCooldown()	end},
	--{name = 'Paleto Drop',		resource = 'cj_PaletoDrop',		type = 'crate',	coords = vector3(-18.09, 6203.96, 30.11),		getCooldown = function() return exports['cj_PaletoDrop']:GetCooldown()	end},
	--{name = 'Premium Drop',		resource = 'cj_PremiumDrop',	type = 'crate',	coords = vector3(61.57, 3707.92, 38.75),		getCooldown = function() return exports['cj_PremiumDrop']:GetCooldown()	end},
	
	{name = 'Groove Drop',		resource = 'cratedrop_v2',		type = 'crate',	coords = vector3(54.76, -1808.43, 25.24),		getCooldown = function() return exports['cratedrop_v2']:GetCooldown('grove')	end},
	{name = 'Sandy Drop',		resource = 'cratedrop_v2',		type = 'crate',	coords = vector3(776.93, 3327.67, 41.43),		getCooldown = function() return exports['cratedrop_v2']:GetCooldown('sandy')	end},
	{name = 'Paleto Drop',		resource = 'cratedrop_v2',		type = 'crate',	coords = vector3(-18.09, 6203.96, 30.11),		getCooldown = function() return exports['cratedrop_v2']:GetCooldown('paleto')	end},
	{name = 'Premium Drop',		resource = 'cratedrop_v2',		type = 'crate',	coords = vector3(61.57, 3707.92, 38.75),		getCooldown = function() return exports['cratedrop_v2']:GetCooldown('premium')	end},
	{name = 'Cayo Drop',		resource = 'cratedrop_v2',		type = 'crate',	coords = vector3(4862.10, -5167.03, 2.44),		getCooldown = function() return exports['cratedrop_v2']:GetCooldown('cayo')		end},
}