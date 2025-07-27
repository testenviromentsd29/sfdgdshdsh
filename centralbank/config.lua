Config = {}

Config.PrestartWait = 5         --seconds
Config.EventDuration = 60*60	--seconds
Config.HeistDuration = 20*60	--seconds	Config.HeistDuration must be > Config.LootDuration
Config.LootDuration = 15*60		--seconds

Config.PoliceReward = 25000000
Config.MoneyPerTrolley = 5000000

Config.Coords = vector3(229.53, 214.22, 105.55)
Config.Radius = 220.00

Config.Teleports = {
	enter = vector3(229.92, 214.22, 104.66),	--enter bank
	exit = vector3(232.97, 215.78, 105.39)		--exit bank
}

Config.Hours = {
	[1] = {hour = 14, minute = 00},		--Sunday
	[2] = {hour = 14, minute = 00},		--Monday
	[3] = {hour = 14, minute = 00},		--Tuesday
	[4] = {hour = 14, minute = 00},		--Wednesday
	[5] = {hour = 14, minute = 00},		--Thursday
	[6] = {hour = 14, minute = 00},		--Friday
	[7] = {hour = 14, minute = 00},		--Saturday
}

Config.Trolleys = {
    {pos = vector3(255.85, 218.72, 100.69), heading = 159.73, rotation = vector3(-180.0, -180.0, 24.44),	pedPos = vector3(255.68, 218.21, 100.69), pedHeading = 339.98},
    {pos = vector3(259.68, 217.57, 100.69), heading = 159.73, rotation = vector3(-180.0, -180.0, 24.44),	pedPos = vector3(259.52, 217.06, 100.69), pedHeading = 334.56},
    {pos = vector3(263.55, 216.32, 100.69), heading = 159.73, rotation = vector3(-180.0, -180.0, 24.44),	pedPos = vector3(263.46, 215.79, 100.69), pedHeading = 337.68},
    {pos = vector3(258.64, 214.45, 100.69), heading = 337.70, rotation = vector3(-0, -0, -22.3),			pedPos = vector3(258.81, 215.03, 100.69), pedHeading = 153.75},
    {pos = vector3(262.27, 212.99, 100.69), heading = 337.70, rotation = vector3(-0, -0, -22.3),			pedPos = vector3(262.42, 213.52, 100.69), pedHeading = 158.26},
}

Config.Entrances = {
	{coords = vector3(231.51, 216.52, 106.40), h1 = 295.00, h2 = 15.00, model = `hei_prop_hei_bankdoor_new`},
	{coords = vector3(232.61, 214.16, 106.40), h1 = 115.00, h2 = 35.00, model = `hei_prop_hei_bankdoor_new`},
	{coords = vector3(258.20, 204.10, 106.40), h1 = 340.00, h2 = 60.00, model = `hei_prop_hei_bankdoor_new`},
	{coords = vector3(260.64, 203.21, 106.40), h1 = 160.00, h2 = 80.00, model = `hei_prop_hei_bankdoor_new`},
}

Config.Employees = {
	{coords = vector3(254.75, 222.50, 106.29), heading = 300.00, model = `a_f_y_business_04`},
	{coords = vector3(249.37, 224.50, 106.29), heading = 300.00, model = `a_f_y_business_04`},
	{coords = vector3(244.36, 226.19, 106.29), heading = 300.00, model = `a_f_y_business_04`},
}

Config.Guards = {
	{coords = vector3(251.56, 220.64, 106.29), heading = 70.000, model = `s_m_y_ranger_01`},
	{coords = vector3(250.38, 214.52, 106.29), heading = 70.000, model = `s_m_y_ranger_01`},
	{coords = vector3(240.29, 219.10, 106.29), heading = 280.00, model = `s_m_y_ranger_01`},
}

Config.Doors = {
	--[1] = {coords = vector3(256.31, 220.66, 106.43), heading = 340.04, model = `hei_v_ilev_bk_gate_pris`},
	[2] = {coords = vector3(262.20, 222.52, 106.43), heading = 250.10, model = `hei_v_ilev_bk_gate2_pris`},
	[3] = {coords = vector3(255.23, 223.98, 102.39), heading = 160.27, model = `v_ilev_bk_vaultdoor`},
	--[4] = {coords = vector3(251.86, 221.07, 101.83), heading = 160.00, model = `hei_v_ilev_bk_safegate_pris`},
	--[5] = {coords = vector3(261.30, 214.51, 101.83), heading = 250.00, model = `hei_v_ilev_bk_safegate_pris`},
}

Config.Tasks = {
	[1] = {coords = vector3(261.89, 223.50, 105.30), heading = 250.00,	time = 2},
	[2] = {coords = vector3(264.93, 219.90, 100.69), heading = 320.00,	time = 2},
	[3] = {coords = vector3(253.33, 228.14, 100.68), heading = 70.000,	time = 2},
}

Config.Gas = {
	{coords = vector3(242.56, 220.06, 106.29), scale = 5.0},
	{coords = vector3(256.11, 215.40, 106.29), scale = 5.0},
	{coords = vector3(255.48, 225.30, 106.29), scale = 5.0},
	{coords = vector3(254.42, 221.23, 101.68), scale = 5.0},
	{coords = vector3(258.60, 217.61, 101.68), scale = 5.0},
}

Config.Lasers = {
    laser1 = {
        {vector3(258.554, 222.672, 100.84), vector3(258.554, 222.672, 101.44)},
        {vector3(260.344, 227.69, 100.84), vector3(260.344, 227.69, 101.44)},
        {travelTimeBetweenTargets = {8.0, 8.0}, waitTimeAtTargets = {0.2, 0.2}, name = 'lasers1',color = {255, 0, 26,255}}
    },
    laser2 = {
        {vector3(258.554, 222.672, 101.64), vector3(258.554, 222.672, 102.24)},
        {vector3(260.344, 227.69, 101.64), vector3(260.344, 227.69, 102.24)},
        {travelTimeBetweenTargets = {8.0, 8.0}, waitTimeAtTargets = {0.2, 0.2}, name = 'lasers2',color = {255, 0, 26,255}}
    },
    laser3 = {
        {vector3(258.554, 222.672, 102.44), vector3(258.554, 222.672, 103.04)},
        {vector3(260.344, 227.69, 102.44), vector3(260.344, 227.69, 103.04)},
        {travelTimeBetweenTargets = {8.0, 8.0}, waitTimeAtTargets = {0.2, 0.2}, name = 'lasers3',color = {255, 0, 26,255}}
    },
    laser4 = {
        {vector3(258.554, 222.672, 103.24), vector3(258.554, 222.672, 103.84)},
        {vector3(260.344, 227.69, 103.24), vector3(260.344, 227.69, 103.84)},
        {travelTimeBetweenTargets = {8.0, 8.0}, waitTimeAtTargets = {0.2, 0.2}, name = 'lasers4',color = {255, 0, 26,255}}
    },
    laserUp1 = {
        {vector3(265.45, 222.75, 108.558), vector3(265.20, 221.85, 108.558)},
        {vector3(263.30, 223.70, 105.284), vector3(263.0, 222.80, 105.284)},
        {travelTimeBetweenTargets = {0.8, 0.8}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = false, name = 'lasersUp1', color = {255, 0, 26,255}}
    },
    laserUp2 = {
        {vector3(265.10, 221.75, 108.558), vector3(264.85, 220.85, 108.558)},
        {vector3(262.9, 222.70, 105.284), vector3(262.6, 221.80, 105.284)},
        {travelTimeBetweenTargets = {0.4, 0.4}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = false, name = 'lasersUp2', color = {255, 0, 26,255}}
    },
    laserUp3 = {
        {vector3(264.75, 220.75, 108.558), vector3(264.50, 219.85, 108.558)},
        {vector3(262.5, 221.70, 105.284), vector3(262.2, 220.8, 105.284)},
        {travelTimeBetweenTargets = {0.8, 0.8}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = false, name = 'lasersUp3', color = {255, 0, 26,255}}
    },
    laserUp4 = {
        {vector3(264.40, 219.75, 108.558), vector3(264.15, 218.75, 108.558)},
        {vector3(262.1, 220.70, 105.284), vector3(261.80, 219.70, 105.284)},
        {travelTimeBetweenTargets = {0.4, 0.4}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = false, name = 'lasersUp4', color = {255, 0, 26,255}}
    }
}

Config.Props = {
	['idcard']		= `p_ld_id_card_01`,
	['panel']		= `hei_prop_hei_securitypanel`,
	['money_brick']	= `hei_prop_heist_cash_pile`
}

Config.NotificationData = {
    name = 'central-bank',
    icon = '',
    text = 'Bank Robbery',
    title = 'Central Bank',
    description = 'The Central Bank event will begin in 5 minutes.'
}