ESX = nil

local battlepass
local nextLevelEta = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Wait(100)
	end
	
	while ESX.GetPlayerData().identifier == nil do
        Wait(100)
    end
	
	ESX.PlayerData = ESX.GetPlayerData()
	Wait(250)
	ESX.TriggerServerCallback('battlepass:getData', function(data) battlepass = data end, true)
	
	while not battlepass do
		Wait(0)
	end
	
	Wait(math.random(100, 5000))
	UpdateTimer()
end)

RegisterCommand('battlepass', function(source, args)
	if not battlepass then
		ESX.ShowNotification('Please wait some seconds...')
		return
	end
	
	nextLevelEta = math.ceil((Config.MaxXpPerLevel - battlepass['xp'])/Config.XpPerMinute)
	
	local data = {
		level			= battlepass['level'],
		xp				= battlepass['xp'],
		maxXp			= Config.MaxXpPerLevel,
		rewards			= Config.LevelRewards,
		lootboxes		= Config.Lootboxes,
		lootboxes_re	= Config.LootboxesRewards,
		nextLevelEta	= nextLevelEta,
	}
	
	SetNuiFocus(true, true)
	SendNUIMessage({enable = true, data = data})
end)

RegisterNetEvent('battlepass:refreshData')
AddEventHandler('battlepass:refreshData', function(data)
	battlepass = data
end)

RegisterNetEvent('battlepass:onVehicleReward')
AddEventHandler('battlepass:onVehicleReward', function(plate, model)
	if IsModelInCdimage(GetHashKey(model)) then
		local coords = GetEntityCoords(PlayerPedId())

		ESX.Game.SpawnLocalVehicle(model, vector3(coords.x, coords.y, coords.z - 10.0), 0.0, function(vehicle)
			SetVehicleNumberPlateText(vehicle, plate)
			local vehicleProps = exports['tp-garages']:GetVehicleProperties(vehicle)
			DeleteEntity(vehicle)
			TriggerServerEvent('battlepass:onVehicleReward', plate, vehicleProps)
		end)
	else
		TriggerServerEvent('battlepass:onVehicleReward', plate, {notfound = true})
	end
end)

RegisterNUICallback('quit', function()
	SetNuiFocus(false, false)
end)

RegisterNUICallback('reward', function()
	SetNuiFocus(false, false)
	TriggerServerEvent('battlepass:reward')
end)

RegisterNUICallback('buy_lootbox', function(data)
	SetNuiFocus(false, false)
	TriggerServerEvent('battlepass:buyLootbox', tonumber(data.id), data.useCoin)
end)

RegisterNUICallback('buy_level', function()
	SetNuiFocus(false, false)
	Wait(100)
	
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'buy_level', {
		title = 'BUY FULL XP FOR CURRENT LEVEL FOR '..Config.LevelPrice..' COINS [YES OR NO]'
	},
	function(data, menu)
		local answer = data.value or 'no'
		menu.close()
		
		if string.lower(answer) == 'yes' then
			TriggerServerEvent('battlepass:buyLevel')
		end
	end,
	function(data, menu)
		menu.close()
	end)
end)

RegisterNUICallback('reset_battlepass', function()
	SetNuiFocus(false, false)
	Wait(100)
	
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'reset_battlepass', {
		title = 'RESET BATTLEPASS FOR '..Config.ResetPrice..' COINS [YES OR NO]'
	},
	function(data, menu)
		local answer = data.value or 'no'
		menu.close()
		
		if string.lower(answer) == 'yes' then
			TriggerServerEvent('battlepass:resetBattlepass')
		end
	end,
	function(data, menu)
		menu.close()
	end)
end)

function UpdateTimer()
	CreateThread(function()
		Wait(Config.UpdateInterval*1000)
		
		ESX.TriggerServerCallback('battlepass:updateTime', function(xp)
			battlepass['xp'] = xp
			
			if battlepass['xp'] == Config.MaxXpPerLevel then
				ESX.ShowNotification('Battlepass max xp reached! ['..battlepass['xp']..'/'..Config.MaxXpPerLevel..']')
			end
			
			UpdateTimer()
		end)
	end)
end

exports("getBattlepass", function ()
    while not battlepass do
        Wait(1000)
    end
    local tab = {
        level = battlepass['level'],
        xp = battlepass['xp'],
        maxXp = Config.MaxXpPerLevel
    }
    return tab
end)

exports("getLootboxes",function()

    return Config.Lootboxes

end)
exports("getLootboxesRewards",function()

    return Config.LootboxesRewards

end)