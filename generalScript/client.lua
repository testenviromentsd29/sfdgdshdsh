ESX = nil
local PlayerData

local currentBucket = math.floor(0)
local currentBucketName = "default"

AddEventHandler('buckets:onBucketChanged', function(bucketId, bucketName)
	currentBucket = bucketId
	currentBucketName = bucketName
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end
	
	Wait(2000)
	
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

------------ KEYWORDS ------------
RegisterNetEvent('generalScript:copyLink', function(link)
	SendNUIMessage({text = link})
	ESX.ShowNotification('Link Copied')
end)
------------ KEYWORDS ------------

------------ PAYCOMSERVJAIL ------------
--[[ Citizen.CreateThread(function()
	if Config.PayComservJailNpc.blip.show then
		createBlip()
	end

	Citizen.CreateThread(NpcDist)

    while true do
        local wait = math.floor(1000)

		if #(GetEntityCoords(PlayerPedId()) - Config.PayComservJailNpc.pos) < 15.0 then
			--DrawMarker(1, Config.PayComservJailNpc.pos.x, Config.PayComservJailNpc.pos.y, Config.PayComservJailNpc.pos.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.2, 1.2, 0.8, 255, 0, 0, 100, false, false, 2, true, false, false, false)
			wait = math.floor(0)

			ESX.Game.Utils.DrawText3D(vector3(Config.PayComservJailNpc.pos.x, Config.PayComservJailNpc.pos.y, Config.PayComservJailNpc.pos.z + 1.2), 'Press [~g~E~w~] to Pay Comserv - Jail', 1.2, math.floor(6))

			if #(GetEntityCoords(PlayerPedId()) - Config.PayComservJailNpc.pos) < 2.0 then
				
				if IsControlJustReleased(math.floor(0), math.floor(38)) then
					openMenu()
				end
			end
		end

        Wait(wait)
    end
end)

function openMenu()
	local elements = {
		{label = 'Pay Community Service', value = 'comserv'},
		{label = 'Pay Jail', value = 'jail'},
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pay_comservjail', {
		title    = 'Choose Option',
		align    = 'bottom-right',
		elements = elements,
	},
	function(data, menu)
		local option = data.current.value
		local price
		ESX.TriggerServerCallback('generalScript:canPayComservJail', function(cb)
			price = cb
		end, option)
		while price == nil do Wait(100) end

		if price > 0 then
			if exports['dialog']:Decision('PAY '..string.upper(option), "Are you sure you want to pay "..option.." for $"..price.."?", "", "YES", "NO").action == "submit" then
				TriggerServerEvent('generalScript:payComservJail', option)
				menu.close()
			end
		end
	end,
	function(data, menu)
		menu.close()
	end)
end

function createBlip()
    local blip = AddBlipForCoord(Config.PayComservJailNpc.pos)
    SetBlipSprite(blip, Config.PayComservJailNpc.blip.id)
    SetBlipScale(blip, Config.PayComservJailNpc.blip.scale)
    SetBlipColour(blip, Config.PayComservJailNpc.blip.color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.PayComservJailNpc.blip.name)
    EndTextCommandSetBlipName(blip)
end

function NpcDist()
	local npc
	while true do
		if #(GetEntityCoords(PlayerPedId()) - Config.PayComservJailNpc.pos) < 60.0 then
			if not npc then
				npc = createNpc()
			end
		else
			if DoesEntityExist(npc) then
				DeleteEntity(npc)
			end
			npc = nil
		end

		Wait(2000)
	end
end

function createNpc()
    RequestModel(Config.PayComservJailNpc.model)
        
    while not HasModelLoaded(Config.PayComservJailNpc.model) do
        Wait(10)
    end

    RequestAnimDict('mini@strip_club@idles@bouncer@base')

    while not HasAnimDictLoaded('mini@strip_club@idles@bouncer@base') do
        Wait(10)
    end
    
    local npc = CreatePed(5, Config.PayComservJailNpc.model, Config.PayComservJailNpc.pos.x, Config.PayComservJailNpc.pos.y, Config.PayComservJailNpc.pos.z - math.floor(1), Config.PayComservJailNpc.heading, false, true)
    SetEntityHeading(npc, Config.PayComservJailNpc.heading)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    
    TaskPlayAnim(npc, 'mini@strip_club@idles@bouncer@base', 'base', 8.0, 0.0, math.floor(-1), math.floor(1), math.floor(0), math.floor(0), math.floor(0), math.floor(0))
    
    SetModelAsNoLongerNeeded(Config.PayComservJailNpc.model)

	return npc
end ]]
------------ PAYCOMSERVJAIL ------------

------------ TIME ZONES ------------
RegisterNetEvent('generalScript:createTimezone')
AddEventHandler('generalScript:createTimezone', function(data)
	table.insert(Config.TimeZones, data)
end)

RegisterNetEvent('generalScript:removeTimezone')
AddEventHandler('generalScript:removeTimezone', function(delzone)
	table.remove(Config.TimeZones, delzone)
end)

RegisterCommand('addtimezone', function()
	if PlayerData.group ~= 'superadmin' then return end

	local radius = tonumber(numberDialog('Enter Zone Radius'))
	local startTime = tonumber(numberDialog('Enter Start Time'))
	local endTime = tonumber(numberDialog('Enter End Time'))

	TriggerServerEvent('generalScript:createTimezone', radius, startTime, endTime)
end)

RegisterCommand('removetimezone', function()
	if PlayerData.group ~= 'superadmin' then return end

	local currzone
	local coords = GetEntityCoords(PlayerPedId())
	for k,v in pairs(Config.TimeZones) do
		if #(v.coords - coords) < v.radius then
			currzone = k
			break
		end
	end

	if currzone then
		TriggerServerEvent('generalScript:removeTimezone', currzone)
	else
		ESX.ShowNotification('You are not in a time zone')
	end
end)

function numberDialog(title)
	local string = nil
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(),"timezone_dialog",{title = title},function(data, menu)
		string = data.value
		menu.close()
	end,function(data, menu)
		menu.close()
	end)
	while ESX.UI.Menu.IsOpen('dialog', GetCurrentResourceName(), 'timezone_dialog') do
		Wait(100)
	end
	return string
end

Citizen.CreateThread(function()
	Wait(5000)
	ESX.TriggerServerCallback('generalScript:getActions', function(actions)
		for i=1, #actions do
			if actions[i].action == 'create' then
				table.insert(Config.TimeZones, actions[i].data)
			else
				table.remove(Config.TimeZones, actions[i].data)
			end
		end
	end)

	while true do
		local wait = 2000
		if GlobalState.inEvent == nil and currentBucket == 0 then
			local time
			if GetResourceState('weather') == 'started' then
				time = exports.weather:GetGameTime()
			else
				time = {hour = GetClockHours(), minute = GetClockMinutes()}
			end
			local currTime = time.hour
			local coords = GetEntityCoords(PlayerPedId())

			if PlayerData and PlayerData.job and PlayerData.job.name ~= 'police' then
				for k,v in ipairs(Config.TimeZones) do
					if #(vector2(coords.x, coords.y) - vector2(v.coords.x, v.coords.y)) < v.radius then
						if v.endTime >= v.startTime then
							if currTime >= v.startTime and currTime <= v.endTime then
								wait = 0
							end
						else
							if (currTime >= v.startTime and currTime <= 23) or (currTime >= 0 and currTime <= v.endTime) then
								wait = 0
							end
						end

						if wait == 0 then
							DisablePlayerFiring(PlayerId(), true)
							SetPlayerCanDoDriveBy(PlayerId(), false)
							DisableControlAction(math.floor(0), math.floor(170), true)
							DisableControlAction(math.floor(1), math.floor(170), true)
							exports['dpemotes']:ForceCloseMenu()

							if IsDisabledControlJustPressed(math.floor(0), math.floor(170)) or IsDisabledControlJustPressed(math.floor(1), math.floor(170)) then
								SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
							end
						else
							SetPlayerCanDoDriveBy(PlayerId(), true)
						end
					end
				end
			end
		end

		Wait(wait)
	end
end)
------------ TIME ZONES ------------

------------ DISABLE FIRE POSITIONS ------------
Citizen.CreateThread(function()
    while true do
        local wait = 1000
        if currentBucket == 0 then
            local coords = GetEntityCoords(PlayerPedId())
            for k,v in ipairs(Config.disableFirePositions) do
                if #(coords - v.coords) < v.radius then
                    wait = 0
                    break
                end
            end
        end

        if wait == 0 then
            DisablePlayerFiring(PlayerId(), true)
			SetPlayerCanDoDriveBy(PlayerId(), false)
			DisableControlAction(math.floor(0), math.floor(170), true)
			DisableControlAction(math.floor(1), math.floor(170), true)
			
			DisableControlAction(0, 140, true) -- light attack
			DisableControlAction(0, 141, true) -- heavy attack
			DisableControlAction(0, 142, true) -- alternative attack
			
			exports['dpemotes']:ForceCloseMenu()

			if IsDisabledControlJustPressed(math.floor(0), math.floor(170)) or IsDisabledControlJustPressed(math.floor(1), math.floor(170)) then
				SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
			end
		else
			SetPlayerCanDoDriveBy(PlayerId(), true)
        end

        Wait(wait)
    end
end)
------------ DISABLE FIRE POSITIONS ------------

------------ DISABLE KICK ON MOTORCYCLE ------------
Citizen.CreateThread(function()
    while true do
        Wait(5000)
        SetPedConfigFlag(PlayerPedId(), 422, true)
    end
end)
------------ DISABLE KICK ON MOTORCYCLE ------------

------------ EVENTS HANDLER ------------
local eventsTimes = {
	{
		event = "Battleground",
		times = {
			"12:00",
		}
	},
	{
		event = "Ghetto Event",
		times = {
			"19:00",
		}
	},
	{
		event = "Central Bank",
		times = {
			"15:00",
		}
	},
	{
		event = "Cayo Perico Event",
		times = {
			"00:00",
		}
	},
	{
		event = "Warzone",
		times = {
			"13:00",
			"14:00",
			"15:00",
			"16:30",
			"18:00",
			"22:00",
			"02:00",
			"04:00",
		}
	},
	{
		event = "Gang Wars",
		times = {
			"Monday 21:00 Families",
			"Tuesday 21:00 Vagos",
			"Wednesday 21:00 Bloods",
			"Thursday 21:00 Ballas",
			"Friday 21:00 Marabunta",
		}
	},
	{
		event = "City King",
		times = {
			"Monday 20:00 City",
			"Tuesday 20:00 Sandy",
			"Wednesday 20:00 Paleto",
			"Thursday 20:00 Groove",
			"Friday 20:00 Perico",
		}
	},
	{
		event = "Raids",
		times = {
			"Friday 20:00 Blackmarket",
			"Saturday 20:00 Coke",
			"Sunday 20:00 Weed",
		}
	},
	{
		event = "Territories",
		times = {
			"Wednesday 22.00 North Territory",
			"Thursday 22.00 East Territory",
			"Friday 22.00 Venice Territory",
			"Saturday 21.00 Industrial Territory",
			"Sunday 21.00 Harbor Territory",
		}
	},
}

RegisterCommand("events", function()
	ESX.UI.Menu.CloseAll()

	local elements = {}

	for k,v in ipairs(eventsTimes) do
		table.insert(elements, {label = v.event, times = v.times})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), '',
	{
		title		= 'Chat Status',
		align		= 'bottom-right',
		elements	= elements
	}, function(data, menu)
		local event = data.current.label
		local times = data.current.times

		local eventelems = {}
		for i=1,#times do
			table.insert(eventelems, {label = times[i]})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), '',
		{
			title		= event .. ' Times',
			align		= 'bottom-right',
			elements	= eventelems
		}, function(data2, menu2)
			
		end,function(data2, menu2)
			menu2.close()
		end)


	end,function(data, menu)
		menu.close()
	end)
end)

Citizen.CreateThread(function()
	local cargoForceGreenzone = {
		{coords = vector3(196.93, -936.52, 30.69),	radius = 250.0},
		{coords = vector3(1657.76, 2523.77, 45.56),	radius = 250.0},
	}
	
    while true do
		local currentEvent = nil
		
		for event, data in pairs(Config.Events) do
			if GetResourceState(event) == 'started' then
				if data.inEvent() then
					currentEvent = event
					break
				end
			end
		end
		
		if currentEvent and (string.find(string.lower(currentEvent), 'cargo') or currentEvent == 'vangelico_rob') then
			local coords = GetEntityCoords(PlayerPedId())
			
			for k,v in pairs(cargoForceGreenzone) do
				if #(coords - v.coords) < v.radius then
					currentEvent = nil
					break
				end
			end
		end
		
		GlobalState.inEvent = currentEvent
		
		Wait(1500)
	end
end)

exports('getEventsConfig', function()
	return Config.Events
end)
------------ EVENTS HANDLER ------------