ESX = nil
local loadingScreenFinished = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_identity:alreadyRegistered')
AddEventHandler('esx_identity:alreadyRegistered', function()
	while not loadingScreenFinished do
		Citizen.Wait(100)
	end

	TriggerEvent('esx_skin:playerRegistered')
end)

AddEventHandler('esx:loadingScreenOff', function()
	loadingScreenFinished = true
end)

local points = {
    --vector3(-233.07, -2041.10, 27.76),
	vector3(-1037.62, -2737.69, 20.17),
}

if not Config.UseDeferrals then
	local guiEnabled, isDead = false, false

	AddEventHandler('esx:onPlayerDeath', function(data)
		isDead = true
	end)

	AddEventHandler('esx:onPlayerSpawn', function(spawn)
		isDead = false
	end)

	function EnableGui(state)
		SetNuiFocus(state, state)
		guiEnabled = state

		SendNUIMessage({
			type = "enableui",
			enable = state
		})
	end
	
	RegisterNetEvent('esx_identity:showRegisterIdentity')
	AddEventHandler('esx_identity:showRegisterIdentity', function()
		print("ASKING FOR POS")
		Wait(1000)
		ESX.TriggerServerCallback('esx_identity:getPosition', function(result)
			print("GOT POS")
			print(result)
			ESX.Game.Teleport(PlayerPedId(),points[result])
		end)
		TriggerEvent('esx_skin:resetFirstSpawn')
		

		if not isDead then
			EnableGui(true)
	

			Citizen.CreateThread(function()
				while guiEnabled do
					Citizen.Wait(0)
					
					DisableControlAction(0, 1,   true) -- LookLeftRight
					DisableControlAction(0, 2,   true) -- LookUpDown
					DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
					DisableControlAction(0, 142, true) -- MeleeAttackAlternate
					DisableControlAction(0, 30,  true) -- MoveLeftRight
					DisableControlAction(0, 31,  true) -- MoveUpDown
					DisableControlAction(0, 21,  true) -- disable sprint
					DisableControlAction(0, 24,  true) -- disable attack
					DisableControlAction(0, 25,  true) -- disable aim
					DisableControlAction(0, 47,  true) -- disable weapon
					DisableControlAction(0, 58,  true) -- disable weapon
					DisableControlAction(0, 263, true) -- disable melee
					DisableControlAction(0, 264, true) -- disable melee
					DisableControlAction(0, 257, true) -- disable melee
					DisableControlAction(0, 140, true) -- disable melee
					DisableControlAction(0, 141, true) -- disable melee
					DisableControlAction(0, 143, true) -- disable melee
					DisableControlAction(0, 75,  true) -- disable exit vehicle
					DisableControlAction(27, 75, true) -- disable exit vehicle
					SetNuiFocus(true,true)
				end
				Wait(500)
				SetNuiFocus(false,false)
			end)
		end
	end)

	RegisterNUICallback('register', function(data, cb)
		ESX.TriggerServerCallback('esx_identity:registerIdentity', function(callback)
			if callback then
				ESX.ShowNotification(_U('thank_you_for_registering'))
				EnableGui(false)
				TriggerEvent('esx_skin:playerRegistered')
				TriggerEvent('esx_skin:openSaveableMenu')
				
--				SetEntityCoords(GetPlayerPed(-1),-269.08 , -956.35 , 30.22)
			else
				--ESX.ShowNotification(_U('registration_error'))
			end
		end, data)
	end)

	
end

local hasFocus = false

RegisterCommand("fixme", function()
	if not hasFocus then
		SetNuiFocus(true,true)
		hasFocus = true
	else
		SetNuiFocus(false,false)
		hasFocus = false
	end
end)