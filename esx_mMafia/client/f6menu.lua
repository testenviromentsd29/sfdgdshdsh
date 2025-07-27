


AddEventHandler("justpressed",function(label,key)
    if label == "F6" then

		ESX.TriggerServerCallback('esx_mMafia:amICriminal', function(isCriminal)
			if ESX.PlayerData.job.name == "ggg" or isCriminal then
				OpenF6Menu()
			end
		end)

    end
end)

local dragCd = 0

RegisterKeyMapping('drag', 'Drag', 'keyboard', '9')

RegisterCommand('drag', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		if dragCd < GetGameTimer() then
			dragCd = GetGameTimer() + 2000

			if string.find(ESX.PlayerData.job.name, 'criminaljob') then
				TriggerServerEvent('esx_mMafia:drag' , GetPlayerServerId(closestPlayer))
			elseif string.find(ESX.PlayerData.job.name, 'police') or string.find(ESX.PlayerData.job.name, 'security') then
				TriggerServerEvent('esx_policejob:drag' , GetPlayerServerId(closestPlayer))
			end
		end
	else
		ESX.ShowNotification("No players nearby")
	end
end)

AddEventHandler('playerSpawned', function(spawn)
	TriggerEvent('esx_mMafia:uncuff')
end)

local lastTimePressed = 0
  
function OpenF6Menu()
	ESX.UI.Menu.CloseAll()
	local elements = {
    --    {label = "Βάλε χειροπέδες", value = "handcuff"},
        {label = "Βγάλε χειροπέδες", value = "unhandcuff"},
	    {label = "Drag/Undrag", value = "drag"},
	    {label = "Put in vehicle", value = "put_in_vehicle"},
	    {label = "Take out of vehicle", value = "out_the_vehicle"},
	    {label = "Κουκούλα", value = "koukoula"},
	    --{label = "Στείλε αμάξι στη μάντρα", value = "mantra"},
    }

	if GetResourceState('cityKing') == 'started' then
		if exports.cityKing:IsOnCityKing() then
			table.insert(elements, {label = "Spawn Props", value = "spawn_props"})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mafia_menu', {
		title    = 'Criminal Menu',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)

		if data.current.value == "spawn_props" then
			TriggerEvent('cityKing:spawnProps')
		else

			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 3.0 then
				local action = data.current.value
				if action == 'handcuff' then
					if not exports.zones:IsInGreenZone() then
						if GetGameTimer()/1000 - lastTimePressed > 5*60 then
							lastTimePressed = GetGameTimer()/1000
							if GlobalState.inEvent ~= 'battleRoyale' then
								TriggerServerEvent('esx_mMafia:handcuff' , GetPlayerServerId(closestPlayer))
							end
						else
							ESX.ShowNotification("Πρέπει να περιμένεις για να πραγματοποιήσεις αυτή την ενέργεια")
						end
					else
						ESX.ShowNotification("You cant do that in a greenzone")
					end
				elseif action == 'mantra' then
					ExecuteCommand("removevehicle")
				elseif action == 'drag' then
					TriggerServerEvent('esx_mMafia:drag' , GetPlayerServerId(closestPlayer))
				elseif action == 'unhandcuff' then
					TriggerServerEvent('esx_mMafia:letGo' , GetPlayerServerId(closestPlayer))
				elseif action == 'put_in_vehicle' then
					TriggerServerEvent('esx_mMafia:putInVehicle' , GetPlayerServerId(closestPlayer))
				elseif action == 'out_the_vehicle' then
					TriggerServerEvent('esx_mMafia:OutVehicle' , GetPlayerServerId(closestPlayer))
				elseif action == 'koukoula' then
					ESX.TriggerServerCallback('esx_mMafia:hasHeadbag', function(result)
						if result and result ~= 'NOT' then
							TriggerEvent('esx_worek:naloz')
						elseif result == 'NOT' then
							ESX.ShowNotification("Δεν είσαι criminal job!")
						else
							ESX.ShowNotification("Δεν έχεις κουκούλα πάνω σου")
						end
					end)
					
					menu.close()
				end
			else
				ESX.ShowNotification("No players nearby")
			end
		end


		
	end,function(data,menu)
		menu.close()
	end)

end





local IsHandcuffed = false
local HandcuffTimer = {}
local DragStatusMafia = {}
DragStatusMafia.IsDragged = false

RegisterNetEvent("amIMafiaHandCuffed")
AddEventHandler("amIMafiaHandCuffed", function(cb)
	cb(IsHandcuffed)
end)

local iAccepted = nil
local handcuffRequest = 0

RegisterNetEvent('esx_mMafia:handcuff')
AddEventHandler('esx_mMafia:handcuff', function()
	iAccepted = nil
	handcuffRequest = GetGameTimer() + 5000

	--[[if exports['dialog']:Decision('Do you want to be cuffied?', "","", "YES", "NO").action == "submit" then
		iAccepted = true
	else
		iAccepted = false
	end

	while (handcuffRequest > GetGameTimer()) and iAccepted == nil do
		Wait(0)
	end

	if not iAccepted then
		return
	end]]
	
	IsHandcuffed    = true
	local playerPed = PlayerPedId()
	Citizen.CreateThread(function()
		Wait(100)
		if IsHandcuffed  then
			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(100)
			end

			TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			--SetEnableHandcuffs(PlayerPedId(), true)
			DisablePlayerFiring(PlayerPedId(), true)
			SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(PlayerPedId(), false)
			DisplayRadar(false)
			DisableControlAction(0, 44, true)
			DisableControlAction(0, 157, true)
			DisableControlAction(0, 158, true)
			DisableControlAction(0, 160, true)

		end
	end)
	if IsHandcuffed then
		CreateThread(function()
			TriggerEvent("vMenu:enableMenu",false)
			while IsHandcuffed do
				Citizen.Wait(1)
				DisableControlAction(0, 24, true) -- Attack
				DisableControlAction(0, 257, true) -- Attack 2
				DisableControlAction(0, 25, true) -- Aim
				DisableControlAction(0, 263, true) -- Melee Attack 1

				DisableControlAction(0, Keys['R'], true) -- Reload
				DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
				DisableControlAction(0, Keys['F'], true) -- Also 'enter'?

				DisableControlAction(0, Keys['F1'], true) -- Disable phone
				DisableControlAction(0, Keys['F2'], true) -- Inventory
				DisableControlAction(0, Keys['F3'], true) -- Animations
				DisableControlAction(0, Keys['F6'], true) -- Job

				DisableControlAction(0, Keys['V'], true) -- Disable changing view
				DisableControlAction(0, Keys['C'], true) -- Disable looking behind
				DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
				DisableControlAction(2, Keys['P'], true) -- Disable pause screen

				DisableControlAction(0, 59, true) -- Disable steering in vehicle
				DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
				DisableControlAction(0, 72, true) -- Disable reversing in vehicle

				DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth

				DisableControlAction(0, 47, true)  -- Disable weapon
				DisableControlAction(0, 264, true) -- Disable melee
				DisableControlAction(0, 257, true) -- Disable melee
				DisableControlAction(0, 140, true) -- Disable melee
				DisableControlAction(0, 141, true) -- Disable melee
				DisableControlAction(0, 142, true) -- Disable melee
				DisableControlAction(0, 143, true) -- Disable melee
				DisableControlAction(0, 75, true)  -- Disable exit vehicle
				DisableControlAction(27, 75, true) -- Disable exit vehicle

				if IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) ~= 1 then
					ESX.Streaming.RequestAnimDict('mp_arresting', function()
						TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
					end)
				end
			end
			TriggerEvent("vMenu:enableMenu",true)
		end)
	end

end)
local cd = 0
RegisterCommand("uncuff", function ()
	if GetGameTimer() > cd then
		cd = GetGameTimer() + 30*60000
		TriggerEvent("esx_mMafia:uncuff")
		Wait(500)
		TriggerEvent("esx_mMafia:uncuff")
		Wait(500)
		TriggerEvent("esx_mMafia:uncuff")
	else
		ESX.ShowNotification("You are on a cooldown")
	end
end)
RegisterNetEvent('esx_mMafia:uncuff')
AddEventHandler('esx_mMafia:uncuff',function()
	local playerPed = PlayerPedId()
	IsHandcuffed = false
	ClearPedSecondaryTask(playerPed)
	--SetEnableHandcuffs(playerPed, false)
	DisablePlayerFiring(playerPed, false)
	SetPedCanPlayGestureAnims(playerPed, true)
	DisplayRadar(true)
	EnableControlAction(0, 44, true)
	EnableControlAction(0, 157, true)
	EnableControlAction(0, 158, true)
	EnableControlAction(0, 160, true)

end)

RegisterNetEvent('esx_mMafia:release')
AddEventHandler('esx_mMafia:release', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		FreezeEntityPosition(GetPlayerPed(-1), true)
		ExecuteCommand("e mechanic4")
		exports['progressBars']:startUI(10000, "Σπάσιμο χειροπέδων..")
		Citizen.Wait(10000)
		ExecuteCommand("e c")
		FreezeEntityPosition(GetPlayerPed(-1), false)
		TriggerServerEvent("esx_mMafia:letGo", GetPlayerServerId(closestPlayer))
	else
		ESX.ShowNotification("No one nearby")
	end
end)

RegisterNetEvent('esx_mMafia:unrestrain')
AddEventHandler('esx_mMafia:unrestrain', function()
	if IsHandcuffed then
		local playerPed = PlayerPedId()
		IsHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		--SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		DisplayRadar(true)

		-- end timer
		
	end
end)

RegisterNetEvent('esx_mMafia:drag')
AddEventHandler('esx_mMafia:drag', function(copID)
	if not IsHandcuffed then
		return
	end
	print(copID)
	DragStatusMafia.IsDragged = not DragStatusMafia.IsDragged
	DragStatusMafia.CopId     = tonumber(copID)
	local playerPed
	local targetPed
	if DragStatusMafia.IsDragged then
		Citizen.CreateThread(function()
			while DragStatusMafia.IsDragged do
				Citizen.Wait(1)
 				playerPed = PlayerPedId()
				targetPed = GetPlayerPed(GetPlayerFromServerId(copID))

				if not DoesEntityExist(targetPed) or playerPed == targetPed then
					DragStatus.IsDragged = false
					break
				end

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					DragStatusMafia.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					DragStatusMafia.IsDragged = false
					DetachEntity(playerPed, true, false)
				end
			end
			DetachEntity(playerPed, true, false)
		end)
	end
end)

RegisterNetEvent('esx_mMafia:putInVehicle')
AddEventHandler('esx_mMafia:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if not IsHandcuffed then
		return
	end

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				DragStatusMafia.IsDragged = false
			end
		end
	end
end)

RegisterNetEvent('esx_mMafia:OutVehicle')
AddEventHandler('esx_mMafia:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

RegisterNetEvent('esx_mMafia:handcuffcriminal')
AddEventHandler('esx_mMafia:handcuffcriminal', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		if GetGameTimer()/1000 - lastTimePressed > 5 then
			lastTimePressed = GetGameTimer()/1000
			TriggerServerEvent('esx_mMafia:handcuff' , GetPlayerServerId(closestPlayer))
		else
			ESX.ShowNotification("Πρέπει να περιμένεις για να πραγματοποιήσεις αυτή την ενέργεια")
		end
	end
end)

RegisterNetEvent('esx_mMafia:unhandcuffcriminal')
AddEventHandler('esx_mMafia:unhandcuffcriminal', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('esx_mMafia:letGo' , GetPlayerServerId(closestPlayer))
	end
end)

RegisterNetEvent('esx_mMafia:putinvehiclecriminal')
AddEventHandler('esx_mMafia:putinvehiclecriminal', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('esx_mMafia:putInVehicle' , GetPlayerServerId(closestPlayer))
	end
end)

RegisterNetEvent('esx_mMafia:outthevehiclecriminal')
AddEventHandler('esx_mMafia:outthevehiclecriminal', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('esx_mMafia:OutVehicle' , GetPlayerServerId(closestPlayer))
	end
end)

RegisterNetEvent('esx_mMafia:headbag')
AddEventHandler('esx_mMafia:headbag', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		ESX.TriggerServerCallback('esx_mMafia:hasHeadbag', function(result)
			if result and result ~= 'NOT' then
				TriggerEvent('esx_worek:naloz')
			elseif result == 'NOT' then
				ESX.ShowNotification("Δεν είσαι criminal job!")
			else
				ESX.ShowNotification("Δεν έχεις κουκούλα πάνω σου")
			end
		end)
	end
end)