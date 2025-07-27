Config = {}

Config.Rewards = {
	[5]		= {item = 'bp_helmet',				amount = 1},
	[10]	= {item = 'level3',					amount = 2},
	[15]	= {item = 'capacityvip',			amount = 5},
	[20]	= {item = 'bank',					amount = 20000000},
	[25]	= {item = 'blueprint_M4_T_NEON',	amount = 10},
	[30]	= {item = 'ghettovip',				amount = 15},
	[35]	= {item = 'coins',					amount = 5000},
	[40]	= {item = 'bank',					amount = 50000000},
	[45]	= {item = 'level3',					amount = 2},
	[50]	= {item = 'blueprint_M47V2',		amount = 20},
	[55]	= {item = 'blueprint_M82V2',		amount = 20},
	[60]	= {item = 'bp_helmet',				amount = 1},
	[65]	= {item = 'bulletproof7',			amount = 100},
	[70]	= {item = 'coins',					amount = 10000},
	[75]	= {item = 'vehicle',				amount = 'alterigoss'},
	[85]	= {item = 'blueprint_M4_HALLOWEEN',	amount = 50},
	[90]	= {item = 'bank',					amount = 150000000},
	[95]	= {item = 'bp_helmet',				amount = 1},
	[100]	= {item = 'level3',					amount = 7},
}

Config.Tasks = {
	['kills']				= {label = 'Πάρε 25 kills',							need = 25,	xp = 300,	type = 'kills'},
	['headshots']			= {label = 'Πάρε 100 headshots',					need = 100,	xp = 300,	type = 'kills'},
	['ghetto_kills']		= {label = 'Πάρε 50 kills στο Ghetto',				need = 50,	xp = 300,	type = 'kills'},
	['pubg_hs_kills']		= {label = 'Πάρε σε ένα PUBG 5 kills με headshot',	need = 5,	xp = 300,	type = 'kills'},
	['cargo_kills']			= {label = 'Πάρε σε ένα Cargo 20 kills',			need = 20,	xp = 300,	type = 'kills'},
	['crate_kills']			= {label = 'Πάρε σε ένα Crate 25 kills',			need = 25,	xp = 300,	type = 'kills'},
	
	['online_time_20']		= {label = 'Μείνε για 20 λεπτά στον Server',		need = 20,	xp = 300,	type = 'online'},
	['online_time_30']		= {label = 'Μείνε για 30 λεπτά στον Server',		need = 30,	xp = 300,	type = 'online'},
	['online_time_60']		= {label = 'Μείνε για 60 λεπτά στον Server',		need = 60,	xp = 300,	type = 'online'},
	['online_time_120']		= {label = 'Μείνε για 2 ώρες στον Server',			need = 120,	xp = 300,	type = 'online'},
	['online_time_240']		= {label = 'Μείνε για 4 ώρες στον Server',			need = 240,	xp = 300,	type = 'online'},
	['online_time_360']		= {label = 'Μείνε για 6 ώρες στον Server',			need = 360,	xp = 300,	type = 'online'},
	
	['drive_veh_10']		= {label = 'Οδήγησε για 10 λεπτά',					need = 10,	xp = 300,	type = 'drive'},
	['drive_veh_15']		= {label = 'Οδήγησε για 15 λεπτά',					need = 15,	xp = 300,	type = 'drive'},
	
	['stay_alive_30']		= {label = 'Μείνε ζωντανός για 30 λεπτά',			need = 30,	xp = 300,	type = 'alive'},
	['stay_alive_45']		= {label = 'Μείνε ζωντανός για 45 λεπτά',			need = 45,	xp = 300,	type = 'alive'},
	
	['buy_veh_dc']			= {label = 'Αγόρασε ένα όχημα με donate coins',		need = 2,	xp = 300,	type = 'buy_veh'},
	--['buy_veh_black']		= {label = 'Αγόρασε ένα όχημα με μαύρα χρήματα',	need = 2,	xp = 300,	type = 'buy_veh'},
	['buy_veh_white']		= {label = 'Αγόρασε ένα όχημα με καθαρά χρήματα',	need = 2,	xp = 300,	type = 'buy_veh'},
	['buy_boat']			= {label = 'Αγόρασε μια βάρκα από τον boat dealer',	need = 2,	xp = 300,	type = 'buy_veh'},
	['buy_auction']			= {label = 'Αγόρασε από το Auction House',			need = 2,	xp = 300},
	['buy_bazaar']			= {label = 'Αγόρασε από ένα Bazaar',				need = 2,	xp = 300},
	['bid']					= {label = 'Κάνε bid σε μια δημοπρασία',			need = 2,	xp = 300},
	
	['start_cr_cargo']		= {label = 'Ξεκίνα ένα Criminal Cargo',				need = 2,	xp = 300},
	['start_boat_cargo']	= {label = 'Ξεκινά ένα Boat Cargo',					need = 2,	xp = 300},
	['start_vangelico']		= {label = 'Ξεκίνα μια ληστεία στο Vangelico',		need = 2,	xp = 300},
	['start_sandy_crate']	= {label = 'Ξεκίνα ένα Sandy Crate',				need = 2,	xp = 300},
	['start_atm_rob']		= {label = 'Ξεκίνα την ληστεία στα ΑΤΜ',			need = 2,	xp = 300},
	['start_store_rob']		= {label = 'Ξεκίνα μια ληστεία σε ένα μαγαζάκι',	need = 2,	xp = 300},
}