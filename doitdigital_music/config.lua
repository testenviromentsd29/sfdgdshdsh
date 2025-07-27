Config = {}

Config.UseESX = true					--Use ESX to check if has the item (boombox)

Config.UseQBUS = false					--Use QBUS to check if has the item (boombox)

Config.VolumeCommand = 'volume'			--Command to manipulate the volume

Config.EnableBoombox = false			--Enable boombox functionality?
Config.BoomboxCommand = 'boombox'		--Command to place a boombox
Config.BoomboxCheckHasItem = false		--Check if player has boombox item (Config.BoomboxItemName), (Config.UseESX or Config.UseQBUS must be true)
Config.BoomboxItemName = 'boombox'		--Item name of the boombox if you you want to check if player has the item (Config.UseESX or Config.UseQBUS must be true)
Config.BoomboxModel = `prop_boombox_01`	--Boombox model
Config.BoomboxObjectDistance = 25.0		--Needed distance to check if we need to create the boombox object or delete it
Config.BoomboxMinDistance = 5.0			--Minimum needed distance to place a boombox near other boomboxes
Config.MaxBoomboxesPerPlayer = 1		--How many boomboxes can a player place

Config.EnableRadiocar = true			--Enable radiocar functionality?
Config.RadiocarCommand = 'rcarr'		--Command to open radiocar
Config.RadiocarKeybind = 29				--Keybind to open the radiocar [36 = LEFT CTRL]
Config.RadiocarLoopWait = 0				--Interval to update radiocar music position in milliseconds

Config.RadiocarDisableButtons = {		--Buttons to disable while the radiocar is open (see https://docs.fivem.net/docs/game-references/controls/)
	[0]							= true,	--[V]
	[1]							= true,	--[MOUSE RIGHT]
	[2]							= true,	--[MOUSE DOWN]
	[106]						= true,	--[LEFT MOUSE BUTTON]
	[200]						= true,	--[ESC]
	[Config.RadiocarKeybind]	= true,
}

Config.RadiocarValidClasses = {			--In which type of vehicles you can open the radiocar
	[0] = true,		--Compacts
	[1] = true,		--Sedans
	[2] = true,		--SUVs
	[3] = true,		--Coupes
	[4] = true,		--Muscle
	[5] = true,		--Sports Classics
	[6] = true,		--Sports
	[7] = true,		--Super
	[8] = true,		--Motorcycles
	[9] = true,		--Off-road
	[10] = true,	--Industrial
	[11] = true,	--Utility
	[12] = true,	--Vans
	[13] = false,	--Cycles
	[14] = true,	--Boats
	[15] = true,	--Helicopters
	[16] = true,	--Planes
	[17] = true,	--Service
	[18] = true,	--Emergency
	[19] = true,	--Military
	[20] = true,	--Commercial
	[21] = false,	--Trains
}

ESX = nil
QBCore = nil

if Config.UseESX then
	if IsDuplicityVersion() then	--server-side
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		
		--ESX = exports['es_extended']:getSharedObject()
	else							--client-side
		Citizen.CreateThread(function()
			while ESX == nil do
				TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
				Wait(0)
			end
		end)
		
		--ESX = exports['es_extended']:getSharedObject()
	end
end

if Config.UseQBUS then
	QBCore = exports['qb-core']:GetCoreObject()
end