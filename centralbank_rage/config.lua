Config = {}

Config.LootDuration = 10		--seconds
Config.ScareDuration = 20		--seconds
Config.RobberyCooldown = 3600	--seconds
Config.LockdownTime = 1			--minutes

Config.SecurityGuard = {
	model = `s_m_m_security_01`,
	coords = vector3(257.88, 219.40, 106.29),
	heading = 160.00
}

Config.MoneyPerTrolley = {
	['money']		= 25000,
	['black_money']	= 5000
}

Config.Attackers = {
	{coords = vector3(254.36, 228.07, 101.68), model = `s_m_m_security_01`},
	{coords = vector3(253.60, 226.26, 101.87), model = `s_m_m_security_01`},
	{coords = vector3(255.90, 225.52, 101.88), model = `s_m_m_security_01`},
	{coords = vector3(256.85, 227.22, 101.68), model = `s_m_m_security_01`},
}

Config.Doors = {
	{coords = vector3(256.31, 220.66, 106.43), heading = 340.00, model = `hei_v_ilev_bk_gate_pris`},
	{coords = vector3(262.20, 222.52, 106.43), heading = 250.00, model = `hei_v_ilev_bk_gate2_pris`},
	{coords = vector3(255.23, 223.98, 102.39), heading = 160.00, model = `v_ilev_bk_vaultdoor`},
}

Config.Trolleys = {
    {coords = vector3(255.85, 218.72, 100.69), heading = 159.73, model = `hei_prop_hei_cash_trolly_01`},
    {coords = vector3(259.68, 217.57, 100.69), heading = 159.73, model = `hei_prop_hei_cash_trolly_01`},
    {coords = vector3(263.55, 216.32, 100.69), heading = 159.73, model = `hei_prop_hei_cash_trolly_01`},
    {coords = vector3(258.64, 214.45, 100.69), heading = 337.70, model = `hei_prop_hei_cash_trolly_01`},
    {coords = vector3(262.27, 212.99, 100.69), heading = 337.70, model = `hei_prop_hei_cash_trolly_01`},
}