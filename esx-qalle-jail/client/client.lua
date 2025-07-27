local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

local PlayerData = {}

local jailTime = 0

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
	ESX.PlayerData = ESX.GetPlayerData()
	while not NetworkIsPlayerActive(PlayerId()) do
		Wait(0)
	end
	Wait(5000)
	while true do
		local model = GetEntityModel(PlayerPedId())
		
		if model == `mp_m_freemode_01` or model == `mp_f_freemode_01` then
			break
		end
		
		Wait(100)
	end
	Wait(1000)
	ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailTime", function(jailCell, newJailTime, reason, dateAdded)
		if newJailTime > 0 then
			jailTime = newJailTime	
			JailLogin(jailCell, reason, dateAdded)
		end
	end)
	
	ProcessGuard()
end)

exports("inJail", function()
	return (jailTime > 0);
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(newData)
	ESX.PlayerData = newData
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	-- TextEntry		-->	The Text above the typing field in the black square
	-- ExampleText		-->	An Example Text, what it should say in the typing field
	-- MaxStringLenght	-->	Maximum String Lenght

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
	local blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
	end
end

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(response)
	PlayerData["job"] = response
	ESX.PlayerData["job"] = response
end)

RegisterNetEvent("esx-qalle-jail:openJailMenu")
AddEventHandler("esx-qalle-jail:openJailMenu", function(job)
	OpenJailMenu(job)
end)

RegisterNetEvent("esx-qaIIe-jail:jailPlayer")
AddEventHandler("esx-qaIIe-jail:jailPlayer", function(newJailTime, jailID, reason, dateAdded)
	jailTime = newJailTime
	--LoadTeleporters()
	Cutscene(jailID)
	InJail(jailID, reason, dateAdded)
end)

RegisterNetEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function()
	jailTime = 0

	UnJail()
end)

function DisableViolentActions()
	Citizen.CreateThread(function()
		while jailTime > 0 do
			if not GlobalState.InCustomGame and not InJobFight() then
				DisableControlAction(0, 24, true)	--INPUT_ATTACK
				DisableControlAction(0, 25, true)	--INPUT_AIM
				DisableControlAction(0, 69, true)	--INPUT_VEH_ATTACK
				DisableControlAction(0, 70, true)	--INPUT_VEH_ATTACK2
				DisableControlAction(0, 92, true)	--INPUT_VEH_PASSENGER_ATTACK
				DisableControlAction(0, 114, true)	--INPUT_VEH_FLY_ATTACK
				DisableControlAction(0, 140, true)	--INPUT_MELEE_ATTACK_LIGHT
				DisableControlAction(0, 141, true)	--INPUT_MELEE_ATTACK_HEAVY
				DisableControlAction(0, 142, true)	--INPUT_MELEE_ATTACK_ALTERNATE
				DisableControlAction(0, 257, true)	--INPUT_ATTACK2
				DisableControlAction(0, 263, true)	--INPUT_MELEE_ATTACK1
				DisableControlAction(0, 264, true)	--INPUT_MELEE_ATTACK2
				DisableControlAction(0, 331, true)	--INPUT_VEH_FLY_ATTACK2
				DisableControlAction(0, 346, true)	--INPUT_VEH_MELEE_LEFT
				DisableControlAction(0, 347, true)	--INPUT_VEH_MELEE_RIGHT
				
				DisablePlayerFiring(PlayerId(), true)
				
				exports['dpemotes']:ForceCloseMenu()
			end
			
			Wait(0)
		end
	end)
end

function JailLogin(jailCell, reason, dateAdded)
	local JailPosition = ConfigJail.Cells[jailCell]
	SetEntityCoords(PlayerPedId(), JailPosition.x, JailPosition.y, JailPosition.z)

	dressAsPrisoner()

	ESX.ShowNotification("Last time you went to sleep you were jailed, because of that you are now put back!")

	InJail(jailCell, reason, dateAdded)
end

function UnJail()
	ESX.Game.Teleport(PlayerPedId(), ConfigJail.Teleports["Boiling Broke"])

	restoreOutfit()

	ESX.ShowNotification("You are released, stay calm outside! Good Luck!")
	SendNUIMessage({
		action = "hide",
	})
end

function disp_time(time)
	local days = math.floor(time/86400)
	local hours = math.floor(math.fmod(time, 86400)/3600)
	local minutes = math.floor(math.fmod(time,3600)/60)
	local seconds = math.floor(math.fmod(time,60))
	return string.format("%d:%02d:%02d:%02d",days,hours,minutes,seconds)
end

function InJail(jailCell, reason, dateAdded)
	--Jail Timer--
	CreateThread(function()
		local firstName = "Unknown"
		
		if ESX.PlayerData.attributes and ESX.PlayerData.attributes.firstName then 
			firstName = ESX.PlayerData.attributes.firstName
		end
		
		local lastName = "Unknown"
		
		if ESX.PlayerData.attributes and ESX.PlayerData.attributes.lastName then 
			lastName = ESX.PlayerData.attributes.lastName
		end
		
		SendNUIMessage({
			action = 'show',
			firstName = firstName,
			lastName = lastName,
			reason = reason,
			dateAdded = dateAdded
		})
		
		DisableViolentActions()
		if string.find(reason, "cheat") then
			jailCell = 'cheater'
		end
		local jailPos = ConfigJail.Cells[jailCell]
		local maxDistance = jailCell == 'default' and 10.0 or 300.0

		if jailCell == 'default' then
			exports['buckets']:changeBucket('jail')
		end
		
		while jailTime > 0 do
			if IsEntityDead(PlayerPedId()) and not GlobalState.InCustomGame and not InJobFight() then
				TriggerEvent('esx_ambulancejob:revlve', true, 150)
			end
			
			SendNUIMessage({
				action = "time",
				time = disp_time(jailTime)
			})
			
			if not GlobalState.InCustomGame and not InJobFight() then
				if jailTime > ConfigJail.TimeToKeepInJail and #(GetEntityCoords(PlayerPedId()) - jailPos) > maxDistance then
					SetEntityCoords(PlayerPedId(), jailPos.x, jailPos.y, jailPos.z, 0, 0, 0, true)
				end
			end
			
			jailTime = jailTime - 1

			if jailTime <= 0 then
				TriggerServerEvent("esx-qalle-jail:finishedJailTime")
			end
			
			Wait(1000)
		end

		local bucket = exports['buckets']:getCurrentBucket()

		if bucket.name == 'jail' then
			exports['buckets']:changeBucket('default')
		end
		
		SendNUIMessage({
			action = 'hide',
		})
	end)
end
Citizen.CreateThread(function()
	while true do
		Wait(1000)
		GlobalState.JailTimeIn = GetGameTimer()
	end
end)
function LoadTeleporters()
	Citizen.CreateThread(function()
		while jailTime > 0 do
			
			local sleepThread = 500

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)
			local cell = vector3(ConfigJail.JailPositions["Cell"]["x"], ConfigJail.JailPositions["Cell"]["y"], ConfigJail.JailPositions["Cell"]["z"])
			if GetDistanceBetweenCoords(PedCoords, cell, true) > 45 then
				--ESX.Game.Teleport(Ped, cell)
			end
			for p, v in pairs(ConfigJail.Teleports) do

				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)

				if DistanceCheck <= 7.5 then

					sleepThread = 5

					ESX.Game.Utils.DrawText3D(v, "[E] Open Door", 0.4)

					if DistanceCheck <= 1.0 then
						if IsControlJustPressed(0, 38) then
							TeleportPlayer(v)
						end
					end
				end
			end

			Citizen.Wait(sleepThread)

		end
	end)
end

function getNearestCell()
	local coords = GetEntityCoords(PlayerPedId())
	local nearest = 1
	local dist = 1000
	for k,v in pairs(ConfigJail.Cells) do
		if k ~= 'default' then
			if #(v - coords) < dist then
				nearest = k
				dist = #(coords - ConfigJail.Cells[nearest])
			end
		end
	end
	return nearest
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		for k,v in pairs(ConfigJail.Cells) do
			if k ~= 'default' then
				if #(v - GetEntityCoords(PlayerPedId())) < 20.0 then
					DrawMarker(27, vector3(v.x, v.y, v.z-0.95), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 0, 200, 255, 100, false, false, 2, false, false, false, false)
				end
			end
		end
	end
end)

function OpenJailMenu(job)
	local nearestCell = getNearestCell()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'jail_prison_menu',
		{
			title    = "Prison Menu",
			align    = 'center',
			elements = {
				{ label = "Jail Person", value = "jail_closest_player" },
				--{ label = "Unjail Person", value = "unjail_player" }
			}
		}, 
	function(data, menu)

		local action = data.current.value

		if action == "jail_closest_player" then

			menu.close()

			TriggerServerEvent('3dme:showCloseIds',GetEntityCoords(PlayerPedId()))
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'comm_serv', {
				title = 'Choose ID'
			}, function(data71, menu71)
				if tonumber(GetPlayerServerId(PlayerId())) == tonumber(data71.value) then
					ESX.ShowNotification('You can\'t send yourself to jail!')
				else
					ESX.UI.Menu.Open(
						'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
						{
							title = "Jail Time (minutes)"
						},
					function(data2, menu2)

						local jailTime = tonumber(data2.value)

						if jailTime > 25 then
							jailTime = 25
							ESX.ShowNotification('Jail time was set to 25!')
						end

						if jailTime == nil then
							ESX.ShowNotification("The time needs to be in minutes!")
						else
							menu2.close()

							--local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

							
							ESX.UI.Menu.Open(
								'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
								{
								title = "Jail Reason"
								},
							function(data3, menu3)
			
								local reason = data3.value
			
								if reason == nil then
									ESX.ShowNotification("You need to put something here!")
								else
									menu3.close()
			
									--local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									
									--[[ if closestPlayer == -1 or closestDistance > 3.0 then
										ESX.ShowNotification("No players nearby!")
									else ]]
										--[[if job == 'police' then
											local targetCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(data71.value)))
											if GetDistanceBetweenCoords(targetCoords, ConfigJail.PrisonerTransfer, true) > 60 then
												ESX.ShowNotification("You need to transfer prisoner at jail first")
												return
											end
										end]]
										TriggerServerEvent("esx-qaIIe-jail:jailPlayer",data71.value, jailTime, reason, nearestCell)
									--end
								end
							end, function(data3, menu3)
								menu3.close()
							end)
						end

					end, function(data2, menu2)
						menu2.close()
					end)
				end
				menu71.close()
			end, function(data71, menu71)
				ESX.UI.Menu.CloseAll()
			end)
		elseif action == "unjail_player" then

			local id =  KeyboardInput("Enter ID","",5)
			id = tonumber(id)
			if id and id > 0 then
				TriggerServerEvent("esx-qalle-jail:unJailPlayer", id)
			end
			

		end

	end, function(data, menu)
		menu.close()
	end)	
end

RegisterNetEvent('esx-qalle-jail:requestShareJail')
AddEventHandler('esx-qalle-jail:requestShareJail', function(caller)
	local title = 'Do you wan\'t to help '..GetPlayerName(GetPlayerFromServerId(caller))..' do his jail?'
	
	if exports['dialog']:Decision(title, 'Are you sure?', '', 'YES', 'NO').action == 'submit' then
		TriggerServerEvent('esx-qalle-jail:requestShareJail', caller)
	end
end)

local onGoingShare = nil

RegisterNetEvent('esx-qalle-jail:startShareJail')
AddEventHandler('esx-qalle-jail:startShareJail', function(caller)
	ProcessShareJail(caller)
end)

RegisterNetEvent('esx-qalle-jail:stopShareJail')
AddEventHandler('esx-qalle-jail:stopShareJail', function()
	onGoingShare = nil
end)

RegisterNetEvent('esx-qalle-jail:shareJail')
AddEventHandler('esx-qalle-jail:shareJail', function()
	jailTime = jailTime - ConfigJail.ShareJailSecondsUpdate
end)

function ProcessShareJail(caller)
	onGoingShare = true
	
	Citizen.CreateThread(function()
		local nextUpdate = GetGameTimer() + ConfigJail.ShareJailSecondsUpdate*1000
		
		while onGoingShare do
			if #(GetEntityCoords(PlayerPedId()) - vector3(1643.27, 2529.96, 45.56)) > 10.0 then
				SetEntityCoords(PlayerPedId(), vector3(1643.27, 2529.96, 45.56))
			end
			
			if nextUpdate < GetGameTimer() then
				nextUpdate = GetGameTimer() + ConfigJail.ShareJailSecondsUpdate*1000
				TriggerServerEvent('esx-qalle-jail:shareJail', caller)
			end
			
			Wait(0)
		end
		
		ESX.Game.Teleport(PlayerPedId(), ConfigJail.Teleports['Boiling Broke'])
	end)
end

local escapeBlips = {}

RegisterNetEvent('esx-qalle-jail:escapeInform')
AddEventHandler('esx-qalle-jail:escapeInform', function(sid)
	if PlayerData and PlayerData.job and PlayerData.job.name == 'police' then
		ESX.ShowNotification('A prisoner is escaping')
		
		escapeBlips[sid] = AddBlipForCoord(1757.47, 2409.19, 62.72)
		SetBlipSprite(escapeBlips[sid], 161)
		SetBlipScale(escapeBlips[sid], 1.5)
		SetBlipColour(escapeBlips[sid], 3)
		PulseBlip(escapeBlips[sid])
	end
end)

RegisterNetEvent('esx-qalle-jail:updateEscapeBlip')
AddEventHandler('esx-qalle-jail:updateEscapeBlip', function(sid, coords)
	if PlayerData and PlayerData.job and PlayerData.job.name == 'police' then
		if DoesBlipExist(escapeBlips[sid]) then
			SetBlipCoords(escapeBlips[sid], coords)
		end
	else
		if DoesBlipExist(escapeBlips[sid]) then
			RemoveBlip(escapeBlips[sid])
		end
	end
end)

RegisterNetEvent('esx-qalle-jail:removeEscapeBlip')
AddEventHandler('esx-qalle-jail:removeEscapeBlip', function(sid)
	if DoesBlipExist(escapeBlips[sid]) then
		RemoveBlip(escapeBlips[sid])
	end
end)

function ProcessGuard()
	local ropeData = {
		marker		= vector3(1757.47, 2409.19, 62.72),
		coords		= vector3(1758.30, 2408.69, 59.26),
		destination	= vector3(1757.62, 2407.76, 45.41),
		rotation	= vector3(-0.00, -0.00, -60.00)
	}
	
	local function StartRopeAtCoords(coords, destination, rotation)
		Wait(250)
		RopeLoadTextures()
		
		SetEntityCoords(PlayerPedId(), coords)
		
		local ropeLength = coords.z - destination.z
		
		local ropeId = AddRope(coords.x, coords.y, coords.z, rotation.x, rotation.y, rotation.z, ropeLength, 4, ropeLength, ropeLength, 1.2, false, false, true, 10.0, false, 0)
		
		RequestClipSet('clipset@anim_heist@hs3f@ig1_rappel@male')
		while not HasClipSetLoaded('clipset@anim_heist@hs3f@ig1_rappel@male') do Wait(0) end
		
		TaskRappelDownWall(PlayerPedId(), coords, destination, destination.z, ropeId, 'clipset@anim_heist@hs3f@ig1_rappel@male', 1)
		N_0xa1ae736541b0fca3(ropeId, true)
		PinRopeVertex(ropeId, (GetRopeVertexCount(ropeId) - 1), coords + vector3(0, 0, 1.0))
		RopeSetUpdateOrder(ropeId, 0)
		
		Citizen.CreateThread(function()
			while true do
				Wait(0)
				
				local coords = GetEntityCoords(PlayerPedId())
				local heightDist = coords.z - destination.z
				
				SetEntityRotation(PlayerPedId(), rotation.x, rotation.y, rotation.z, 2, true)
				ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to stop rappelling')
				
				if heightDist < 0.5 then
					DeleteRope(ropeId)
					ClearPedTasks(PlayerPedId())
					break
				end
				
				if IsControlJustReleased(0, 38) then
					DeleteRope(ropeId)
					ClearPedTasks(PlayerPedId())
					break
				end
			end
		end)
	end
	
	Citizen.CreateThread(function()
		while true do
			local wait = 2500
			local coords = GetEntityCoords(PlayerPedId())
			
			if #(coords - ropeData.marker) < 50.0 then
				wait = 0
				DrawMarker(21, ropeData.marker, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, false, false, false, false)
				
				if #(coords - ropeData.marker) < 1.0 then
					ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to pay ~y~400 DC~w~ to escape')
					
					if IsControlJustReleased(0, 38) then
						ESX.TriggerServerCallback('esx-qalle-jail:payToEscape', function(cb)
							if cb then
								StartRopeAtCoords(ropeData.coords, ropeData.destination, ropeData.rotation)
							end
						end)
						
						Wait(1000)
					end
				end
			end
			
			Wait(wait)
		end
	end)
end

function InJobFight()
	if GetResourceState('esx_jobfight') == 'started' and exports['esx_jobfight']:IsInFight() then
		return true
	end

	return false
end

exports('IsInJail', function()
	return jailTime > 0
end)