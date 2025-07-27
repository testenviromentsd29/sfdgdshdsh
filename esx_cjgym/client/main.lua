-- Made by carolosjk
ESX = nil
local PlayerData

--stats 
local strength = 0
local stamina = 0
local health = 0
local sprint = 0 
local previousHealth = 200

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

	ProcessStrengthLocations()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

function ProcessStrengthLocations()
	Citizen.CreateThread(function()
		local gameTimer = 0

		while true do
			local inZone = false
			local coords = GetEntityCoords(PlayerPedId())

			for k,v in pairs(Config.StrengthLocations) do
				if #(coords - v.coords) < v.radius then
					inZone = true
					break
				end
			end

			if inZone then
				if gameTimer == 0 then
					gameTimer = GetGameTimer() + 10*60000
				end

				if gameTimer < GetGameTimer() then
					local newStrength = strength + 4
					strength = newStrength > 100 and 100 or newStrength

					gameTimer = GetGameTimer() + 10*60000
				end
			else
				if gameTimer ~= 0 then
					gameTimer = 0
				end
			end

			Wait(1000)
		end
	end)
end

--STATS EFFECTS
--Sprint
Citizen.CreateThread(function()
	while ESX == nil do 
		Wait(100)
	end
	while true do 
		Wait(0)
		if sprint > 0 then
			SetPedMoveRateOverride(PlayerPedId(),1.0 + (Config.sprintBonus*sprint)/10000)
		else
			Wait(1000)
		end
	end
end)
  
--Stamina
Citizen.CreateThread(function()
	while true do
		if stamina > 0 then
			Wait(math.floor(10000-stamina*20))
			RestorePlayerStamina(PlayerId(), stamina*0.005)
		else
			Wait(1000)
		end
	end
end)
  
--Health
function updateHealth()
	local playerPed = PlayerPedId()
	Wait(2000)
	if health > 0 then
		local currentMaxHealth = math.floor(200 + Config.healthBonus*(health/100))
		SetPedMaxHealth(playerPed,currentMaxHealth )
		if previousHealth < currentMaxHealth then
			SetEntityHealth(playerPed,GetEntityHealth(playerPed)+ (currentMaxHealth-previousHealth))
		end
	end
end
  
--Recoil / Strength
Citizen.CreateThread(function()
	while Config.betterRecoil do
		Citizen.Wait(0)
		if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
			local _,wep = GetCurrentPedWeapon(PlayerPedId())
			_,cAmmo = GetAmmoInClip(PlayerPedId(), wep)
			if Config.recoils[wep] and Config.recoils[wep] ~= 0 then
				tv = 0
				reduction = (1.0 - strength*(Config.strengthBonus/100)/100)
				if GetFollowPedCamViewMode() ~= 4 then
					repeat 
						Wait(0)
						p = GetGameplayCamRelativePitch()
						h = GetGameplayCamRelativeHeading()
						SetGameplayCamRelativePitch(p+0.1, 0.2*reduction)
						SetGameplayCamRelativeHeading(h+(math.random(-1,1)/8)*reduction)
						tv = tv+0.1
					until tv >= Config.recoils[wep]
				else
					repeat 
						Wait(0)
						p = GetGameplayCamRelativePitch()
						h = GetGameplayCamRelativeHeading()
						if Config.recoils[wep] > 0.1 then
							SetGameplayCamRelativePitch(p+0.6*reduction, 1.2*reduction)
							SetGameplayCamRelativeHeading(h+6*(math.random(-1,1)/8)*reduction)
							tv = tv+0.6
						else
							SetGameplayCamRelativePitch(p+0.016, 0.333*reduction)
							SetGameplayCamRelativeHeading(h+0.16*(math.random(-1,1)/8)*reduction)
							tv = tv+0.1
						end
					until tv >= Config.recoils[wep]
				end
			end
		end
	end
end)
  
--Stat decay
Citizen.CreateThread(function()
	if Config.timeTillDecay > 0 then 
		while true do
			Wait(Config.timeTillDecay*60000)
			if health > 0 then
				health = health-1
			end
			if strength > 0 then 
				strength = strength-1
			end
			if stamina > 0 then 
				stamina = stamina-1
			end
			if sprint > 0 then 
				sprint = sprint-1
			end
		end
	end
end)

RegisterNetEvent('esx_cjgym:addstat')
AddEventHandler('esx_cjgym:addstat', function(stat,value)
	updateStat(stat,value)
end)

RegisterNetEvent('esx_cjgym:updateStats')
AddEventHandler('esx_cjgym:updateStats', function(stat, value,consumableName,statType)
	updateStat(stat,value,true,consumableName,statType)
end)
  
function updateStat(stat,value,consumable,consumableName,statType) --name of stat and value to be added(can be negative, e.x. -5)
	if consumable == nil then 
		consumable = false
	end

	if stat == "health" then
		local old = health
		if health >= 50 and consumable then 
			ESX.ShowNotification("Your stats can't go above 50% with consumables")
			return
		elseif consumable then
			TriggerServerEvent('esx_cjgym:useConsumable' ,consumableName,statType)
		end
		health = health + value
		if health < 0 then
			health = 0 
		elseif health > 100 then
			health = 100
		elseif health > 50 and consumable then
			health = 50
		end
		updateHealth()
		ESX.ShowNotification("You gained ~r~"..health-old.." ~g~ health")
	elseif stat == "strength" then
		local old = strength
		if strength >= 50 and consumable then 
			ESX.ShowNotification("Your stats can't go above 50% with consumables")
			return
		elseif consumable then
			TriggerServerEvent('esx_cjgym:useConsumable' ,consumableName,statType)
		end
		strength = strength + value
		if strength < 0 then
			strength = 0 
		elseif strength > 100 then
			strength = 100
		elseif strength > 50 and consumable then
			strength = 50
		end
		ESX.ShowNotification("You gained ~r~"..strength-old.." ~g~ strength")
	elseif stat == "stamina" then
		local old = stamina
		if stamina >= 50 and consumable then 
			ESX.ShowNotification("Your stats can't go above 50% with consumables")
			return
		elseif consumable then
			TriggerServerEvent('esx_cjgym:useConsumable' ,consumableName,statType)
		end
		stamina = stamina + value
		if stamina < 0 then
			stamina = 0 
		elseif stamina > 100 then
			stamina = 100
		elseif stamina > 50 and consumable then
			stamina = 50
		end
		ESX.ShowNotification("You gained ~r~"..stamina-old.." ~g~ stamina")
	elseif stat == "sprint" then
		local old = sprint
		if sprint >= 50 and consumable then 
			ESX.ShowNotification("Your stats can't go above 50% with consumables")
			return
		elseif consumable then
			TriggerServerEvent('esx_cjgym:useConsumable' ,consumableName,statType)
		end
		sprint = sprint + value
		if sprint < 0 then
			sprint = 0 
		elseif sprint > 100 then
			sprint = 100
		elseif sprint > 50 and consumable then
			sprint = 50
		end
		ESX.ShowNotification("You gained ~r~"..sprint-old.." ~g~ sprint")
	end
end

Citizen.CreateThread(function()
	while ESX == nil do
		Wait(1000)
	end
	while PlayerData == nil do
		Wait(1000)
	end
	Wait(5000)
	if PlayerData and PlayerData.subscription and (PlayerData.subscription == "level2" or PlayerData.subscription == "level3" or PlayerData.subscription == "level4") then
		while true do
			strength = 100
			Wait(5000)
		end
	end
end)

exports('getStrength', function()
	return strength
end)