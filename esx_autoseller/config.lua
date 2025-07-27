Config = {}

Config.MaxSlots = 10000

Config.Stock = {
	{stock = 0,	colour = {r = 250,	g = 0,		b = 0}},
	{stock = 1,	colour = {r = 235,	g = 103,	b = 2}},
	{stock = 5,	colour = {r = 10,	g = 235,	b = 2}},
}

Config.JobUseOnly = {
	['police'] = true,
	['ambulance'] = true,
}

Config.Payments = {
	['bank'] = '$', 
	['gm_coins'] = 'GM Coins', 
}

Config.NpcModel = `g_m_y_mexgoon_03`

Config.Locations = {
	{coords = vector3(152.67, -985.07, 30.09),		heading = 222.76},
	{coords = vector3(171.37, -991.35, 30.09),		heading = 88.730},
	{coords = vector3(144.53, -1032.84, 29.35),		heading = 345.51},
	{coords = vector3(-21.59, -1225.76, 29.34),		heading = 89.810},
	{coords = vector3(-21.70, -1234.01, 29.34),		heading = 98.370},
	{coords = vector3(-42.86, -1226.40, 29.33),		heading = 280.20},
	{coords = vector3(118.10, -1401.18, 29.27),		heading = 278.02},
	{coords = vector3(1847.16, 3667.03, 33.90),		heading = 213.61},
	{coords = vector3(2579.43, -336.85, 93.17),		heading = 122.43},
	{coords = vector3(-877.49, -844.11, 19.18),		heading = 288.07},
	{coords = vector3(768.12, -1416.47, 26.48),		heading = 356.23},
	{coords = vector3(-412.42, 1169.95, 325.85),	heading = 344.90}, 
	{coords = vector3(612.61, 70.22, 91.26),		heading = 154.97},
	{coords = vector3(-1642.36, -215.96, 55.13),	heading = 341.41},
	{coords = vector3(-2186.22, -393.63, 13.43),	heading = 318.28},
	{coords = vector3(-1722.36, -1105.18, 13.02),	heading = 93.330},
	{coords = vector3(-190.11, -2012.72, 27.75),	heading = 85.900},
	{coords = vector3(326.09, -221.62, 54.09),		heading = 10.080},
	{coords = vector3(923.42, -273.93, 67.82),		heading = 295.47},
	{coords = vector3(211.08, -939.17, 30.69),		heading = 65.000},
	{coords = vector3(-4496.77, 9000.05, 2001.00),	heading = 94.530},	--Gunshop - Ammunation
	{coords = vector3(7474.66, 5102.39, 119.03),	heading = 129.19},	--Security
	{coords = vector3(7061.78, 1453.76, 2000.95),	heading = 157.51},	--Pharmacy
	{coords = vector3(4016.87, 7631.43, 828.71),	heading = 177.38},	--Mechanic
	{coords = vector3(9075.98, 7233.18, 2001.32),	heading = 7.9100},	--Phonestore
	{coords = vector3(-485.39, -290.60, 35.44),		heading = 23.000},
	{coords = vector3(4891.66, -5466.50, 30.44),	heading = 269.54},
	{coords = vector3(5264.87, -5443.86, 63.86),	heading = 153.95},
	{coords = vector3(5310.88, -5604.76, 64.54),	heading = 48.370},
	{coords = vector3(4068.25, -4671.17, 4.21),		heading = 113.75},
	{coords = vector3(-1031.52, -2736.71, 20.17),	heading = 110.86},
	{coords = vector3(-1157.31, -1717.34, 4.51),	heading = 261.61},
	{coords = vector3(-813.87, -1226.14, 7.34),		heading = 143.71},
	{coords = vector3(448.58, -988.02, 30.69),		heading = 65.000},
	{coords = vector3(-244.64, 6317.90, 32.43),		heading = 12.000},
}

function GetMinPrice(itemName)
	local price = 1
	
	if string.find(itemName, 'blueprint_') then
		price = 200000
	elseif itemName == 'coins' then
		price = 25000
	end
	
	return price
end