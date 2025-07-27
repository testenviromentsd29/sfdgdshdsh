

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


local health
local multi
local pulse = 70
local area = "Unknown"
local cause = "Unknown"
local lastHit
local blood = 100
local bleeding = 0
local dead = false
local timer = 0
local bleedOut = 0

local cPulse = -1
local cBlood = -1
local cNameF = ""
local cNameL = ""
local cArea = ""
local cBleeding = "NONE"
local piasebone = false

RegisterNetEvent('medSystem:diedFromPiase')
AddEventHandler('medSystem:diedFromPiase',function()
	piasebone = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	multi = 2.0
	blood = 100
	pulse = 70
	health = GetEntityHealth(GetPlayerPed(-1))
	area = "LEGS/ARMS"
	bleeding = 1
	bleedOut = Config.DefaultBleedout
	
	local hit, bone = GetPedLastDamageBone(GetPlayerPed(-1))
	
	if (bone == 31086) or piasebone then
		piasebone = false
		multi = 1.0
		TriggerEvent('chatMessage', "MedSystem", {255, 0, 0}, "You have been shot/damaged in HEAD area")
		bleeding = 5
		bleedOut = Config.HeadshotBleedout
		area = "HEAD"
	end
	
	if bone == 24817 or bone == 24818 or bone == 10706 or bone == 24816 or bone == 11816 then
		multi = 1.0
		TriggerEvent('chatMessage', "MedSystem", {255, 0, 0}, "You have been shot/damaged in BODY area")
		bleeding = 2
		bleedOut = Config.BodyBleedout
		area = "BODY"
	end
	
	ESX.TriggerServerCallback('medSystem:getDeathCause', function(deathCause)
		cause = deathCause or "Unknown"
	end)
	
	math.random(GetGameTimer())
	local exBlood = math.random(5, 15)
	
	pulse = math.ceil(bleedOut/Config.MaxBleedout*100)
	blood = pulse + exBlood
	
	if blood > 100 then
		blood = 100
	end
	
	dead = true
	
	Citizen.CreateThread(function()
		while dead do
			if GetEntityHealth(PlayerPedId()) > 0 and dead then
				dead = false
				bleeding = 0
				blood = 100
				pulse = 70
				TriggerEvent('esx_ambulancejob:updatePulseBlood', blood, pulse)
			end
			
			if dead and blood > 0 then
				bleedOut = bleedOut - 5
				
				pulse = math.ceil(bleedOut/Config.MaxBleedout*100)
				blood = pulse + exBlood
				
				if blood > 100 then
					blood = 100
				end
				
				if pulse < 0 then
					pulse = 0
				end
				
				if blood < 0 then
					blood = 0
				end
				
				if (blood < 21 and blood ~= -1) or (pulse < 6 and pulse ~= -1) then
					TriggerEvent('esx_ambulancejob:updatePulseBlood', blood, pulse)
				end
			end

			Wait(5000)
		end
	end)
end)

AddEventHandler('medSystem:isHeadshot', function(cb)
	if area == 'HEAD' then
		cb(true)
	else
		cb(false)
	end
end)

RegisterNetEvent('medSystem:send')
AddEventHandler('medSystem:send', function(caller)
	TriggerServerEvent('medSystem:print', caller, pulse, area, blood, bleeding, cause)
end)

RegisterNetEvent('medSystem:print')
AddEventHandler('medSystem:print', function(source, pl, bl, source, area, bleeding, cause)
	local mugshot = RegisterPedheadshot(GetPlayerPed(GetPlayerFromServerId(source)))
	
	while not IsPedheadshotReady(mugshot) do
		Wait(100)
	end
	
	local txdString = GetPedheadshotTxdString(mugshot)
	
	local msg = '~r~Pulse: ~w~'..pl..'\n~r~Blood: ~w~'..bl..'\n~r~Area: ~w~'..area..'\n~r~Cause: ~w~'..cause
	ESX.ShowAdvancedNotification('EKAB', 'ID: '..source, msg, txdString, 1)
	
	UnregisterPedheadshot(mugshot)
end)