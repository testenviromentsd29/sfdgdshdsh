ESX = nil

local isBusy = false
local swipesLeft = 0

local currentBucket = 0
local currentBucketName = 'default'

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)

		local playersAround = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 30.0)

		if #playersAround < 1 then
			Wait(5000)
		else
			for i=1,#playersAround do
				if playersAround[i] ~= PlayerId() then
					local server_id = GetPlayerServerId(playersAround[i])
					if GlobalState.PlayersDoingCS[server_id] then
						local c = GetEntityCoords(GetPlayerPed(playersAround[i])) + vector3(0.0, 0.0, 0.2)
						ESX.Game.Utils.DrawText3D(c, '🧹', 1.5)
					end
				end
			end
		end
		
	end
end)

RegisterNetEvent('esx_communityservice:request')
AddEventHandler('esx_communityservice:request', function(id, name)
	print("OK",name,id)
	
	if exports['dialog']:Decision("ΣΚΟΥΠΕΣ", 'O ΠΑΙΧΤΗΣ ' ..name .. " ΘΕΛΕΙ ΝΑ ΜΟΙΡΑΣΤΕΙΤΕ ΤΙΣ ΣΚΟΥΠΕΣ. ΔΕΧΕΣΑΙ;", '', 'ΝΑΙ', 'ΟΧΙ').action == 'submit' then
		TriggerServerEvent("esx_communityservice:acceptSwipes", id)

	else

	end
end)

RegisterNetEvent('esx_communityservice:dialog')
AddEventHandler('esx_communityservice:dialog', function(msg, i, n)
	print('esx_communityservice:dialog', msg, i, n)
	
	local id =  tonumber(i)
	local name = n
	local report = 	exports['dialog']:Create("End community service", "περιέγραψε το report που είχε γίνει", "").value or ""
	
	while report == "" or report == " " or report == "1" do
		report = exports['dialog']:Create("End community service", "περιέγραψε το report που είχε γίνει", "").value or ""
		Wait(100)
	end

	local reason = 	exports['dialog']:Create("End community service", "γιατί βγάζεις την ποινή;", "").value or ""

	while reason == "" or reason == " " or report == "1" do
		reason = exports['dialog']:Create("End community service", "γιατί βγάζεις την ποινή;", "").value or ""
		Wait(100)
	end

	TriggerServerEvent("esx_communityservice:senddialog", id, name, report, reason)
end)

AddEventHandler('buckets:onBucketChanged', function(bucketId, bucketName)
	currentBucket = bucketId
	currentBucketName = bucketName

	Wait(1000)

	if swipesLeft > 0 and currentBucketName ~= GetCurrentResourceName() then
		exports['buckets']:changeBucket(GetCurrentResourceName())
	end
end)

RegisterNetEvent('esx_communityservice:setSwipes')
AddEventHandler('esx_communityservice:setSwipes', function(swipes)
	swipesLeft = swipes
end)

RegisterNetEvent('esx_communityservice:sendToCommunityService')
AddEventHandler('esx_communityservice:sendToCommunityService', function(swipes, drawData, type)
	ProcessCommunityService(swipes, drawData, type)
end)

RegisterNetEvent('esx_communityservice:getType')
AddEventHandler('esx_communityservice:getType', function()
	if exports['dialog']:Decision('Select Type', '', '', 'FEET', 'BIKE').action == 'submit' then
		TriggerServerEvent('esx_communityservice:getType', 'default')
	else
		TriggerServerEvent('esx_communityservice:getType', 'bike')
	end
end)

local vehicleCd = 0

--[[ RegisterCommand('bf4002', function(source, args)
	if swipesLeft < 1 then
		ESX.ShowNotification('You are not on community service')
		return
	end

	if vehicleCd > GetGameTimer() then
		ESX.ShowNotification('You can spawn a vehicle every 10 minutes. Timeleft: '..math.ceil((vehicleCd - GetGameTimer())/60000)..' minutes')
		return
	end

	--vehicleCd = GetGameTimer() + 10*60000

	ESX.Game.SpawnVehicle('bf400', GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), function (vehicle)
		SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
	end)
end) ]]

RegisterNetEvent('esx_communityservice:startSharedSwipes')
AddEventHandler('esx_communityservice:startSharedSwipes', function(swipes, forWho)
	ProcessCommunityServiceForOther(swipes, forWho)
end)

RegisterNetEvent('esx_communityservice:endServiceForPerson')
AddEventHandler('esx_communityservice:endServiceForPerson', function()
	swipesLeft = 0
end)

function ProcessCommunityServiceForOther(swipes, forWho)
	swipesLeft = swipes
	ESX.Game.Teleport(PlayerPedId(), Config.ServiceLocation)

	exports['buckets']:changeBucket(GetCurrentResourceName())

	Citizen.CreateThread(function()
		local locId = math.random(1, #Config.Locations[type])
		
		local blip = AddBlipForCoord(Config.Locations[type][locId])
		SetBlipSprite(blip, 682)
		SetBlipScale(blip, 1.5)
		SetBlipColour(blip, 38)
		SetBlipRoute(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Community Service')
		EndTextCommandSetBlipName(blip)

		while swipesLeft > 0 do
			exports['pma-voice']:overrideProximityRange(1.0, true)

			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if DoesEntityExist(vehicle) and GetEntityModel(vehicle) ~= `bf400` then
				ClearPedTasksImmediately(playerPed)
			end

			if #(coords - Config.Locations[type][locId]) < 100.0 then
				DrawMarker(21, Config.Locations[type][locId], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 50, 50, 200, 128, false, true, 2, true, false, false, false)
				
				if #(coords - Config.Locations[type][locId]) < 1.5 then
					ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to start cleaning')
					
					if IsControlJustReleased(0, 38) then
						if not isBusy then
							isBusy = true
							
							RequestAnimDict('amb@world_human_janitor@male@idle_a')
							while not HasAnimDictLoaded('amb@world_human_janitor@male@idle_a') do Wait(0) end
							
							TaskPlayAnim(playerPed, 'amb@world_human_janitor@male@idle_a', 'idle_a', 8.0, -8.0, -1, 0, 0, false, false, false)
							
							RequestModel(`prop_tool_broom`)
							while not HasModelLoaded(`prop_tool_broom`) do Wait(0) end
							
							local broom = CreateObject(`prop_tool_broom`, coords.x, coords.y, coords.z, true, true, false)
							AttachEntityToEntity(broom, playerPed, GetPedBoneIndex(playerPed, 28422), -0.005, 0.0, 0.0, 360.0, 360.0, 0.0, 1, 1, 0, 1, 0, 1)
							
							SetTimeout(10000, function()
								if #(coords - Config.Locations[type][locId]) < 1.5 then
									TriggerServerEvent('esx_communityservice:cleanForOther', locId, forWho)
								end
								
								if DoesEntityExist(broom) then
									DeleteEntity(broom)
								end
								
								ClearPedTasks(PlayerPedId())
								
								locId = GetRandomLocation(locId)
								
								SetBlipCoords(blip, Config.Locations[type][locId])
								SetBlipRoute(blip, true)
								
								isBusy = false
							end)
						end
					end
				end
			end
			DontShootThisFrame()
			DrawText2(0.175, 0.955, 0.45, 'You have ~b~'..swipesLeft..'~s~ more actions to complete before you can finish your service')
			
			Wait(0)
		end
		exports['pma-voice']:clearProximityOverride()

		ESX.Game.Teleport(PlayerPedId(), Config.ReleaseLocation)

		exports['buckets']:changeBucket('default')
		
		if DoesBlipExist(blip) then
			RemoveBlip(blip)
		end
		
		TriggerServerEvent('esx_communityservice:onFinish')
	end)
end

function ProcessCommunityService(swipes, drawData, type)
	if swipesLeft > 0 then
		swipesLeft = swipes
		ESX.Game.Teleport(PlayerPedId(), Config.ServiceLocation)
		
		return
	end
	
	swipesLeft = swipes
	ESX.Game.Teleport(PlayerPedId(), Config.ServiceLocation)
	SendNUIMessage({action = 'show', type = type})

	exports['buckets']:changeBucket(GetCurrentResourceName())
	
	Citizen.CreateThread(function()
		local locId = math.random(1, #Config.Locations[type])
		
		local blip = AddBlipForCoord(Config.Locations[type][locId])
		SetBlipSprite(blip, 682)
		SetBlipScale(blip, 1.5)
		SetBlipColour(blip, 38)
		SetBlipRoute(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Community Service')
		EndTextCommandSetBlipName(blip)
		
		while swipesLeft > 0 do
			exports['pma-voice']:overrideProximityRange(1.0, true)

			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			
			if type == 'default' then
				if DoesEntityExist(vehicle) then
					ClearPedTasksImmediately(playerPed)
				end
			else
				if DoesEntityExist(vehicle) and GetEntityModel(vehicle) ~= `bf400` then
					ClearPedTasksImmediately(playerPed)
				end
			end
			
			if #(coords - Config.Locations[type][locId]) < 100.0 then
				DrawMarker(21, Config.Locations[type][locId], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 50, 50, 200, 128, false, true, 2, true, false, false, false)
				
				if #(coords - Config.Locations[type][locId]) < 1.5 then
					ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to start cleaning')
					
					if IsControlJustReleased(0, 38) then
						if not isBusy then
							isBusy = true
							
							RequestAnimDict('amb@world_human_janitor@male@idle_a')
							while not HasAnimDictLoaded('amb@world_human_janitor@male@idle_a') do Wait(0) end
							
							TaskPlayAnim(playerPed, 'amb@world_human_janitor@male@idle_a', 'idle_a', 8.0, -8.0, -1, 0, 0, false, false, false)
							
							RequestModel(`prop_tool_broom`)
							while not HasModelLoaded(`prop_tool_broom`) do Wait(0) end
							
							local broom = CreateObject(`prop_tool_broom`, coords.x, coords.y, coords.z, true, true, false)
							AttachEntityToEntity(broom, playerPed, GetPedBoneIndex(playerPed, 28422), -0.005, 0.0, 0.0, 360.0, 360.0, 0.0, 1, 1, 0, 1, 0, 1)
							
							SetTimeout(10000, function()
								if #(coords - Config.Locations[type][locId]) < 1.5 then
									TriggerServerEvent('esx_communityservice:clean', locId)
								end
								
								if DoesEntityExist(broom) then
									DeleteEntity(broom)
								end
								
								ClearPedTasks(PlayerPedId())
								
								locId = GetRandomLocation(locId, type)
								
								SetBlipCoords(blip, Config.Locations[type][locId])
								SetBlipRoute(blip, true)
								
								isBusy = false
							end)
						end
					end
				end
			end
			
			if #(coords - Config.PayLocation) < 50.0 then
				DrawMarker(29, Config.PayLocation, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, false, 2, true, false, false, false)
				
				if #(coords - Config.PayLocation) < 1.5 then
					ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to pay for sentence reduction')
					
					if IsControlJustReleased(0, 38) then
						payForSwipes()
						Wait(500)
					end
				end
			end
			
			--if not InEvent() then
				DontShootThisFrame()
			--end
			
			DrawText2(0.175, 0.955, 0.45, 'You have ~b~'..swipesLeft..'~s~ more actions to complete before you can finish your service')

			if drawData then
				DrawText2(0.450, 0.100, 0.65, 'Staff: ~b~'..drawData.staff..'\n~w~Reason: ~b~'..drawData.reason)
			end
			
			Wait(0)
		end
		exports['pma-voice']:clearProximityOverride()

		SendNUIMessage({action = 'hide'})
		ESX.Game.Teleport(PlayerPedId(), Config.ReleaseLocation)

		exports['buckets']:changeBucket('default')
		
		if DoesBlipExist(blip) then
			RemoveBlip(blip)
		end
		
		TriggerServerEvent('esx_communityservice:onFinish')
	end)
end


function payForSwipes()
	local moneyType = "white"

	if exports['dialog']:Decision(title2, 'Με τι θες να πληρωσεις;', '', 'ΚΑΘΑΡΑ ΛΕΦΤΑ', 'DONATE COINS').action == 'submit' then
		moneyType = "white"
	else
		moneyType = "dc"
	end

	local title = 'Πόσες σκούπες θες να πληρώσεις?'
	local desc = 'Τιμή μίας σκούπας: '..ESX.Math.GroupDigits(Config.PricePerAction)
	if moneyType == "dc" then
		desc = 'Τιμή μίας σκούπας: '..ESX.Math.GroupDigits(Config.DCPricePerAction)
	end
	local desc2 = 'Μπορείς να πληρώσεις μέχρι '..(swipesLeft - 1)..' σκούπες'
	
	local amount = tonumber(exports['dialog']:Create(title, desc, desc2).value) or 0
	
	if amount > 0 and amount < swipesLeft then

		if moneyType == "white" then

			local title2 = 'Θα πληρώσεις $'..ESX.Math.GroupDigits(Config.PricePerAction*amount)..' για '..amount..' σκούπες'
			
			if exports['dialog']:Decision(title2, 'Είσαι σίγουρος μπροκολόκο?', '', 'YES', 'NO').action == 'submit' then
				TriggerServerEvent('esx_communityservice:payForActions', amount, moneyType)
			end
		else
			local title2 = 'Θα πληρώσεις '..ESX.Math.GroupDigits(Config.DCPricePerAction*amount)..'DC για '..amount..' σκούπες'
			
			if exports['dialog']:Decision(title2, 'Είσαι σίγουρος μπροκολόκο?', '', 'YES', 'NO').action == 'submit' then
				TriggerServerEvent('esx_communityservice:payForActions', amount, moneyType)
			end
		end
	end
end

function GetRandomLocation(lastLoc, type)
	local id
	
	repeat
		math.randomseed(GetGameTimer())
		id = math.random(1, #Config.Locations[type])
		
		Wait(0)
	until id ~= lastLoc
	
	return id
end

function DontShootThisFrame()
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
end

function DrawText2(x, y, scale, text)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(scale, scale)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry('STRING')
	AddTextComponentString(text)
	DrawText(x, y)
end

function InEvent()
	if GlobalState.inEvent or GlobalState.inPubg or GlobalState.inGungame or GlobalState.inFortnite or GlobalState.InCustomGame then
		return true
	end
	
	return false
end

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		GlobalState.ComServTimeIn = GetGameTimer()
	end
end)

exports('IsOnCommunityService', function()
	return swipesLeft > 0
end)