Config = {}

Config.DrawDistance = 3.0   --Distance within which you can interact with the gas pumps
Config.DefaultGasStationRange = 30 -- Pumps within this range from the coords given at Config.GasStations below, are owned by the gas station in the same coords.

-- Default prices are for when the gas station doesn't have any owners
Config.DefaultGasPricePerLiter = 3
Config.DefaultGasCanisterPrice = 500
Config.DefaultRepairKitPrice = 1500

Config.DefaultOwnerName = "GOVERNMENT OWNED"
Config.DefaultGasStationName = "GM Petrol"
Config.DefaultControlledByText = "GREEK MAFIA"

Config.RepairKitItemName = "fixkit2"

Config.PremiumFuelItemName = "megalo_mpitoni"
Config.BuyPremiumPrice = 100000
Config.SellPremiumPrice = 500

Config.GasStationFuelCapacity = 10000	-- Max fuel capacity for the gas station. It's the amount it will get to when refilled by the owner
Config.RefillStationCapacityCost = 5000	-- This cost gets less the less fuel missing from the gas station. This is the cost to go from 0% to 100%

Config.CostPercentageToSociety = 1.0	--How much of the order price goes into the gas station society, decimals from 0 to 1

Config.MaxPricePerType = {
	['gasoline'] = 5,
	['repair-kit'] = 2000,
	['canister'] = 500,
}

Config.MinPricePerType = {
	['gasoline'] = 0.6,
	['repair-kit'] = 1400,
	['canister'] = 150,
}

Config.PumpModels = {
	[-2007231801] = true,
	[1339433404] = true,
	[1694452750] = true,
	[1933174915] = true,
	[-462817101] = true,
	[-469694731] = true,
	[-164877493] = true
}

-- Class multipliers. If you want SUVs to use less fuel, you can change it to anything under 1.0, and vise versa.
Config.Classes = {
	[0] = 0.5, -- Compacts
	[1] = 0.5, -- Sedans
	[2] = 0.5, -- SUVs
	[3] = 0.5, -- Coupes
	[4] = 0.5, -- Muscle
	[5] = 0.5, -- Sports Classics
	[6] = 0.5, -- Sports
	[7] = 0.5, -- Super
	[8] = 0.5, -- Motorcycles
	[9] = 0.5, -- Off-road
	[10] = 0.5, -- Industrial
	[11] = 0.5, -- Utility
	[12] = 0.5, -- Vans
	[13] = 0.0, -- Cycles
	[14] = 0.0, -- Boats
	[15] = 0.0, -- Helicopters
	[16] = 0.0, -- Planes
	[17] = 0.5, -- Service
	[18] = 0.5, -- Emergency
	[19] = 0.5, -- Military
	[20] = 0.5, -- Commercial
	[21] = 0.5, -- Trains
}

-- The left part is at percentage RPM, and the right is how much fuel (divided by 10) you want to remove from the tank every second
Config.FuelUsage = {
	[1.0] = 1.4,
	[0.9] = 1.2,
	[0.8] = 1.0,
	[0.7] = 0.9,
	[0.6] = 0.8,
	[0.5] = 0.7,
	[0.4] = 0.5,
	[0.3] = 0.4,
	[0.2] = 0.2,
	[0.1] = 0.1,
	[0.0] = 0.0,
}

Config.GasStations = {
	{coords = vector3(49.4187, 2778.793, 58.043), job = nil},
	{coords = vector3(263.894, 2606.463, 44.983), job = nil},
	{coords = vector3(1039.958, 2671.134, 39.550), job = nil},
	{coords = vector3(1207.260, 2660.175, 37.899), job = nil},
	{coords = vector3(2539.685, 2594.192, 37.944), job = nil},
	{coords = vector3(2679.858, 3263.946, 55.240),  job = nil},
	{coords = vector3(2005.055, 3773.887, 32.403), job = nil},
	{coords = vector3(1687.156, 4929.392, 42.078), job = nil},
	{coords = vector3(1701.314, 6416.028, 32.763), job = nil},
	{coords = vector3(179.857, 6602.839, 31.868), job = nil},
	{coords = vector3(-94.4619, 6419.594, 31.489), job = nil},
	{coords = vector3(-2554.996, 2334.40, 33.078), job = nil},
	{coords = vector3(-1800.375, 803.661, 138.651), job = nil},
	{coords = vector3(-1437.622, -276.747, 46.207), job = 'venzinadiko5'},
	{coords = vector3(-2096.243, -320.286, 13.168), job = nil},
	{coords = vector3(-724.619, -935.1631, 19.213), job = nil},
	{coords = vector3(-526.019, -1211.003, 18.184), job = nil},
	{coords = vector3(-70.2148, -1761.792, 29.534), job = nil},
	{coords = vector3(819.653, -1028.846, 26.403), job = nil},
	{coords = vector3(1208.951, -1402.567,35.224), job = nil},
	{coords = vector3(1181.381, -330.847, 69.316), job = nil},
	{coords = vector3(620.843, 269.100, 103.089), job = nil},
	{coords = vector3(2581.321, 362.039, 108.468), job = nil},
	{coords = vector3(176.631, -1562.025, 29.263), job = 'venzinadiko1'},
	{coords = vector3(-319.292, -1471.715, 30.549), job = nil},
	{coords = vector3(1784.324, 3330.55, 41.253), job = nil},
}

-- Fuel decor - No idea if it's needed!
Config.FuelDecor = "_FUEL_LEVEL"

-- What keys are disabled while you're fueling.
Config.DisableKeys = {0, 22, 23, 24, 29, 30, 31, 37, 44, 56, 82, 140, 166, 167, 168, 170, 288, 289, 311, 323}