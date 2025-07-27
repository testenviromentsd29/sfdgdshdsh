ESX = nil

local PlayerData = {}
local eventKills = {}
local employees = {}
local trolleys = {}
local guards = {}
local lasers = {}

local cashCase = nil
local radiusBlip = nil
local eventStarted = false
local heistStarted = false
local inEvent = false
local imWinner = false
local imInBank = false
local allGuardsDead = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end
	
	PlayerData = ESX.GetPlayerData()
	
	--ProcessDoors()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('centralbank:prestartMsg')
AddEventHandler('centralbank:prestartMsg', function()
	TriggerEvent('top_notifications:show', Config.NotificationData)
end)

RegisterNetEvent('centralbank:startEvent')
AddEventHandler('centralbank:startEvent', function()
	TriggerEvent('top_notifications:hide', Config.NotificationData.name)
	
	eventStarted = true
	ProcessEvent()
end)

RegisterNetEvent('centralbank:endEvent')
AddEventHandler('centralbank:endEvent', function(winner)
	eventStarted = false
	
	if PlayerData.job.name == winner then
		if inEvent then
			imWinner = true
			
			if winner ~= 'police' then
				ProcessWinner()
			else
				ProcessWinnerPolice()
			end
		end
	end
end)

RegisterNetEvent('centralbank:releaseGas')
AddEventHandler('centralbank:releaseGas', function()
	if imWinner then
		Citizen.CreateThread(function()
			RequestNamedPtfxAsset('core')
			while not HasNamedPtfxAssetLoaded('core') do Wait(0) end
			
			for k,v in pairs(Config.Gas) do
				SetPtfxAssetNextCall('core')
				Config.Gas[k].effect = StartParticleFxLoopedAtCoord('exp_grd_bzgas_smoke', v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, v.scale, 0.0, 0.0, 0.0, math.floor(0))
			end
			
			while imWinner do
				Wait(150)
				
				if imInBank then
					SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - math.floor(1))
					
					if IsEntityDead(PlayerPedId()) then
						imInBank = false
						SetEntityCoords(PlayerPedId(), Config.Teleports['enter'])
						TriggerServerEvent('centralbank:exitHeist')
						
						ESX.ShowNotification('You have died from the gas')
						
						EndHeist()
					end
				else
					Wait(1000)
				end
			end
			
			for k,v in pairs(Config.Gas) do
				if DoesParticleFxLoopedExist(v.effect) then
					StopParticleFxLooped(v.effect, math.floor(0))
				end
			end
		end)
	end
end)

RegisterNetEvent('centralbank:endHeist')
AddEventHandler('centralbank:endHeist', function()
	if imInBank then
		ESX.ShowNotification('The central bank event just ended, you have been moved out')
	end
	
	EndHeist()
end)

RegisterNetEvent('centralbank:updateTeam')
AddEventHandler('centralbank:updateTeam', function(job, data)
	eventKills[job] = data
end)

RegisterNetEvent('centralbank:enterBank')
AddEventHandler('centralbank:enterBank', function()
	local _, guardGroup = AddRelationshipGroup('guards')
	
	SetRelationshipBetweenGroups(math.floor(5), guardGroup, GetHashKey('PLAYER'))
	SetRelationshipBetweenGroups(math.floor(5), GetHashKey('PLAYER'), guardGroup)
	
	local netIDs = {}
	
	for i=math.floor(1), #Config.Guards do
		guards[i] = CreateGuardNPC(Config.Guards[i].model, Config.Guards[i].coords, Config.Guards[i].heading, guardGroup)
		netIDs[i] = NetworkGetNetworkIdFromEntity(guards[i])
	end
	
	Wait(500)
	TriggerServerEvent('centralbank:sendGuards', netIDs)
end)

RegisterNetEvent('centralbank:guardsDead')
AddEventHandler('centralbank:guardsDead', function()
	allGuardsDead = true
end)

RegisterNetEvent('centralbank:policeReward')
AddEventHandler('centralbank:policeReward', function()
	if imWinner then
		local targetPed = employees[math.floor(1)]
		
		if DoesEntityExist(targetPed) then
			ClearPedTasks(targetPed)
			
			if DoesEntityExist(cashCase) then
				DeleteEntity(cashCase)
			end
			
			PlayPedAmbientSpeechWithVoiceNative(targetPed, 'GENERIC_THANKS', 'A_F_M_BUSINESS_02_WHITE_MINI_01', 'SPEECH_PARAMS_STANDARD', math.floor(0))
			ESX.ShowNotification('Police took the reward</br>You can now leave the bank')
		end
	end
end)

RegisterNetEvent('centralbank:startHeist')
AddEventHandler('centralbank:startHeist', function()
	if not imWinner then
		return
	end
	
	heistStarted = true
	
	local targetPed = employees[math.floor(1)]
	
	FreezeEntityPosition(targetPed, false)
	ClearPedTasksImmediately(targetPed)
	
	RequestAnim('missminuteman_1ig_2')
	TaskPlayAnim(targetPed, 'missminuteman_1ig_2', 'handsup_base', 2.0, 2.0, math.floor(-1), math.floor(51), math.floor(0), false, false, false)
	
	PlayPedAmbientSpeechWithVoiceNative(targetPed, 'GUN_BEG', 'A_F_M_BUSINESS_02_WHITE_MINI_01', 'SPEECH_PARAMS_ALLOW_REPEAT', math.floor(0))
	
	TaskGoToCoordAnyMeans(targetPed, Config.Tasks[math.floor(1)].coords, 1.0, math.floor(0), math.floor(0), math.floor(786603), 1.0)
	
	Wait(6000)
	
	SetEntityCoords(targetPed, Config.Tasks[math.floor(1)].coords)
	SetEntityHeading(targetPed, Config.Tasks[math.floor(1)].heading)
	
	FreezeEntityPosition(targetPed, true)
	ClearPedTasksImmediately(targetPed)
	
	RequestModel(Config.Props['idcard'])
	while not HasModelLoaded(Config.Props['idcard']) do Wait(0) end
	
	local targetCoords = GetEntityCoords(targetPed)
	local idcard = CreateObject(Config.Props['idcard'], targetCoords, false, true, false)
	local boneIndex = GetPedBoneIndex(targetPed, math.floor(28422))
	local panel = GetClosestObjectOfType(targetCoords, 4.0, Config.Props['panel'], false, false, false)

	AttachEntityToEntity(idcard, targetPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, math.floor(1), true)
	TaskStartScenarioInPlace(targetPed, 'PROP_HUMAN_ATM', math.floor(0), true)
	Wait(1500)
	AttachEntityToEntity(idcard, panel, boneIndex, -0.09, -0.02, -0.08, 270.0, 0.0, 270.0, true, true, false, true, math.floor(1), true)
	FreezeEntityPosition(idcard)
	Wait(Config.Tasks[math.floor(1)].time*1000)
	PlaySoundFrontend(math.floor(-1), 'ATM_WINDOW', 'HUD_FRONTEND_DEFAULT_SOUNDSET')
	
	lasers['laserUp1'].setActive(false)
	lasers['laserUp2'].setActive(false)
	lasers['laserUp3'].setActive(false)
	lasers['laserUp4'].setActive(false)
	
	Wait(2000)
	
	if DoesEntityExist(idcard) then
		DeleteEntity(idcard)
	end
	
	local door2 = GetClosestObjectOfType(Config.Doors[math.floor(2)].coords, 1.0, Config.Doors[math.floor(2)].model, false, false, false)
	
	Citizen.CreateThread(function()
		while GetEntityHeading(door2) < math.floor(359) do
			SetEntityHeading(door2, GetEntityHeading(door2) + 1.0)
			Wait(6)
		end
	end)
	
	FreezeEntityPosition(targetPed, false)
	ClearPedTasksImmediately(targetPed)
	
	TaskPlayAnim(targetPed, 'missminuteman_1ig_2', 'handsup_base', 2.0, 2.0, math.floor(-1), math.floor(51), math.floor(0), false, false, false)
	TaskGoToCoordAnyMeans(targetPed, Config.Tasks[math.floor(2)].coords, 1.0, math.floor(0), math.floor(0), math.floor(786603), 1.0)
	
	Wait(15000)
	
	SetEntityCoords(targetPed, Config.Tasks[math.floor(2)].coords)
	SetEntityHeading(targetPed, Config.Tasks[math.floor(2)].heading)
	
	FreezeEntityPosition(targetPed, true)
	ClearPedTasksImmediately(targetPed)
	
	RequestAnim('anim@heists@prison_heiststation@cop_reactions')
	TaskPlayAnim(targetPed, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 3.0, 3.0, math.floor(-1), math.floor(1), math.floor(0), false, false, false)
	
	Wait(Config.Tasks[math.floor(2)].time*1000)
	
	PlaySoundFrontend(math.floor(-1), 'COLLECTED', 'HUD_AWARDS')
	
	lasers['laser1'].setActive(false)
	lasers['laser2'].setActive(false)
	lasers['laser3'].setActive(false)
	lasers['laser4'].setActive(false)
	
	FreezeEntityPosition(targetPed, false)
	ClearPedTasksImmediately(targetPed)
	
	TaskPlayAnim(targetPed, 'missminuteman_1ig_2', 'handsup_base', 2.0, 2.0, math.floor(-1), math.floor(51), math.floor(0), false, false, false)
	TaskGoToCoordAnyMeans(targetPed, Config.Tasks[math.floor(3)].coords, 1.0, math.floor(0), math.floor(0), math.floor(786603), 1.0)
	
	Wait(11500)
	
	SetEntityCoords(targetPed, Config.Tasks[math.floor(3)].coords)
	SetEntityHeading(targetPed, Config.Tasks[math.floor(3)].heading)
	
	FreezeEntityPosition(targetPed, true)
	ClearPedTasksImmediately(targetPed)
	
	RequestModel(Config.Props['idcard'])
	while not HasModelLoaded(Config.Props['idcard']) do Wait(0) end
	
	local targetCoords = GetEntityCoords(targetPed)
	local idcard = CreateObject(Config.Props['idcard'], targetCoords, false, true, false)
	local boneIndex = GetPedBoneIndex(targetPed, math.floor(28422))
	local panel = GetClosestObjectOfType(targetCoords, 4.0, Config.Props['panel'], false, false, false)

	AttachEntityToEntity(idcard, targetPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, math.floor(1), true)
	TaskStartScenarioInPlace(targetPed, 'PROP_HUMAN_ATM', math.floor(0), true)
	Wait(1500)
	AttachEntityToEntity(idcard, panel, boneIndex, -0.09, -0.02, -0.08, 270.0, 0.0, 270.0, true, true, false, true, math.floor(1), true)
	FreezeEntityPosition(idcard)
	Wait(Config.Tasks[math.floor(3)].time*1000)
	PlaySoundFrontend(math.floor(-1), 'ATM_WINDOW', 'HUD_FRONTEND_DEFAULT_SOUNDSET')
	
	Wait(2000)
	
	if DoesEntityExist(idcard) then
		DeleteEntity(idcard)
	end
	
	PlaySoundFrontend(math.floor(-1), 'COLLECTED', 'HUD_AWARDS')
	
	FreezeEntityPosition(targetPed, false)
	ClearPedTasksImmediately(targetPed)
	TaskTurnPedToFaceCoord(targetPed, 258.80, 224.09, 101.68, math.floor(1250))
	Wait(1250)
	FreezeEntityPosition(targetPed, true)
	
	TaskPlayAnim(targetPed, 'missminuteman_1ig_2', 'handsup_base', 2.0, 2.0, math.floor(-1), math.floor(51), math.floor(0), false, false, false)
	
	SpawnTrolleys()
	
	local vault = Config.Doors[math.floor(3)]
	local vaultDoor = GetClosestObjectOfType(vault.coords, 1.0, vault.model, false, false, false)
	
	CreateThread(function()
		while GetEntityHeading(vaultDoor) > math.floor(30) do
			PlaySoundFromEntity(math.floor(-1), 'OPENING', vaultDoor, 'MP_PROPERTIES_ELEVATOR_DOORS', math.floor(1), math.floor(1))
			Wait(900)
		end
	end)
	
	while GetEntityHeading(vaultDoor) > math.floor(30) do
		SetEntityHeading(vaultDoor, GetEntityHeading(vaultDoor) - 0.1)
		Wait(5)
	end
end)

RegisterNetEvent('centralbank:lootTrolley')
AddEventHandler('centralbank:lootTrolley', function(id)
	if imWinner then
		if DoesEntityExist(trolleys[id]) then
			DeleteEntity(trolleys[id])
		end
		
		ESX.Game.SpawnLocalObject('hei_prop_hei_cash_trolly_03', Config.Trolleys[id].pos, function(object)
			SetEntityHeading(object, Config.Trolleys[id].heading)
			trolleys[id] = object
		end)
	end
end)

function SpawnTrolleys()
	for k,v in pairs(Config.Trolleys) do
		if DoesEntityExist(trolleys[k]) then
			DeleteEntity(trolleys[k])
		end
		
		ESX.Game.SpawnLocalObject('hei_prop_hei_cash_trolly_01', v.pos, function(object)
			SetEntityHeading(object, v.heading)
			trolleys[k] = object
		end)
		
		while not DoesEntityExist(trolleys[k]) do Wait(0) end
	end
	
	Citizen.CreateThread(function()
		while heistStarted do
			local coords = GetEntityCoords(PlayerPedId())
			
			for k,v in pairs(Config.Trolleys) do
				if #(coords - v.pedPos) < 1.2 then
					ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to loot the trolley ['..k..']')
					
					if IsControlJustReleased(math.floor(0), math.floor(38)) then
						if imInBank then
							ESX.TriggerServerCallback('centralbank:canLootTrolley', function(yes)
								if yes then
									LootTrolley(k)
								else
									ESX.ShowNotification('This trolley has been looted')
								end
							end, k)
						else
							ESX.ShowNotification('You have not entered the right way...')
						end
						
						Wait(2000)
					end
				end
			end
			
			Wait(0)
		end
	end)
end

function LootTrolley(id)
	Grab2clear = false
	Grab3clear = false
	
	local trolleyModel = GetHashKey('hei_prop_hei_cash_trolly_01')
	
	local trolleyData = Config.Trolleys[id]
	local Trolley = GetClosestObjectOfType(trolleyData.pos.x, trolleyData.pos.y, trolleyData.pos.z, 1.0, trolleyModel, false, false, false)
	
	if DoesEntityExist(Trolley) then
		DeleteEntity(Trolley)
	end
	
	RequestModel(trolleyModel)
	while not HasModelLoaded(trolleyModel) do Wait(0) end
	
	Trolley = CreateObject(trolleyModel, trolleyData.pos.x, trolleyData.pos.y, trolleyData.pos.z, true, true)
	SetEntityHeading(Trolley, trolleyData.heading)
	
	local CashAppear = function()
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		local grabmodel = GetHashKey('hei_prop_heist_cash_pile')
		
		RequestModel(grabmodel)
		while not HasModelLoaded(grabmodel) do Wait(0) end
		
		local grabobj = CreateObject(grabmodel, pedCoords, true)
		
		FreezeEntityPosition(grabobj, true)
		SetEntityInvincible(grabobj, true)
		SetEntityNoCollisionEntity(grabobj, ped)
		SetEntityVisible(grabobj, false, false)
		AttachEntityToEntity(grabobj, ped, GetPedBoneIndex(ped, math.floor(60309)), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, math.floor(0), true)
		
		local endGrabbing = GetGameTimer() + math.floor(37000)
		
		Citizen.CreateThread(function()
			while endGrabbing > GetGameTimer() and heistStarted do
				Wait(0)
				
				DisableControlAction(math.floor(0), math.floor(73), true)
				
				if HasAnimEventFired(ped, GetHashKey('CASH_APPEAR')) then
					if not IsEntityVisible(grabobj) then
						SetEntityVisible(grabobj, true, false)
					end
				end
				
				if HasAnimEventFired(ped, GetHashKey('RELEASE_CASH_DESTROY')) then
					if IsEntityVisible(grabobj) then
						SetEntityVisible(grabobj, false, false)
					end
				end
			end
			
			DeleteObject(grabobj)
		end)
	end
	
	local emptyobj = GetHashKey('hei_prop_hei_cash_trolly_03')
	
	if IsEntityPlayingAnim(Trolley, 'anim@heists@ornate_bank@grab_cash', 'cart_cash_dissapear', math.floor(3)) then
		return
	end
	
	local baghash = GetHashKey('hei_p_m_bag_var22_arm_s')
	
	RequestAnimDict('anim@heists@ornate_bank@grab_cash')
	RequestModel(baghash)
	RequestModel(emptyobj)
	
	while not HasAnimDictLoaded('anim@heists@ornate_bank@grab_cash') and not HasModelLoaded(emptyobj) and not HasModelLoaded(baghash) do
		Wait(0)
	end
	
	local ped = PlayerPedId()
	
	GrabBag = CreateObject(GetHashKey('hei_p_m_bag_var22_arm_s'), GetEntityCoords(PlayerPedId()), true, false, false)
	Grab1 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), math.floor(2), false, false, math.floor(1065353216), math.floor(0), 1.3)
	NetworkAddPedToSynchronisedScene(ped, Grab1, 'anim@heists@ornate_bank@grab_cash', 'intro', 1.5, -4.0, math.floor(1), math.floor(16), math.floor(1148846080), math.floor(0))
	NetworkAddEntityToSynchronisedScene(GrabBag, Grab1, 'anim@heists@ornate_bank@grab_cash', 'bag_intro', 4.0, -8.0, math.floor(1))
	SetPedComponentVariation(ped, math.floor(5), math.floor(0), math.floor(0), math.floor(0))
	NetworkStartSynchronisedScene(Grab1)
	Wait(1500)
	
	CashAppear()
	
	if not Grab2clear then
		Grab2 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), math.floor(2), false, false, math.floor(1065353216), math.floor(0), 1.3)
		NetworkAddPedToSynchronisedScene(ped, Grab2, 'anim@heists@ornate_bank@grab_cash', 'grab', 1.5, -4.0, math.floor(1), math.floor(16), math.floor(1148846080), math.floor(0))
		NetworkAddEntityToSynchronisedScene(GrabBag, Grab2, 'anim@heists@ornate_bank@grab_cash', 'bag_grab', 4.0, -8.0, math.floor(1))
		NetworkAddEntityToSynchronisedScene(Trolley, Grab2, 'anim@heists@ornate_bank@grab_cash', 'cart_cash_dissapear', 4.0, -8.0, math.floor(1))
		NetworkStartSynchronisedScene(Grab2)
		Wait(37000)
	end
	
	if not Grab3clear then
		Grab3 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), math.floor(2), false, false, math.floor(1065353216), math.floor(0), 1.3)
		NetworkAddPedToSynchronisedScene(ped, Grab3, 'anim@heists@ornate_bank@grab_cash', 'exit', 1.5, -4.0, math.floor(1), math.floor(16), math.floor(1148846080), math.floor(0))
		NetworkAddEntityToSynchronisedScene(GrabBag, Grab3, 'anim@heists@ornate_bank@grab_cash', 'bag_exit', 4.0, -8.0, math.floor(1))
		NetworkStartSynchronisedScene(Grab3)
	end
	
	TriggerServerEvent('centralbank:lootTrolley', id, NetworkGetNetworkIdFromEntity(Trolley))
	
	Wait(1800)
	
	if DoesEntityExist(GrabBag) then
		DeleteEntity(GrabBag)
	end
	
	RemoveAnimDict('anim@heists@ornate_bank@grab_cash')
	SetModelAsNoLongerNeeded(emptyobj)
	SetModelAsNoLongerNeeded(GetHashKey('hei_p_m_bag_var22_arm_s'))
end

function ProcessWinner()
	for i=math.floor(1), #Config.Employees do
		employees[i] = CreateLocalNPC(Config.Employees[i].model, Config.Employees[i].coords, Config.Employees[i].heading)
		TaskCower(employees[i], math.floor(-1))
	end
	
	Citizen.CreateThread(function()
		while imWinner or imInBank do
			local coords = GetEntityCoords(PlayerPedId())
			
			for k,v in pairs(Config.Teleports) do
				if #(coords - v) < 25.0 then
					DrawMarker(math.floor(27), v, 0.0, 0.0, 0.0, math.floor(0), 0.0, 0.0, 1.0, 1.0, 1.0, math.floor(255), math.floor(0), math.floor(0), math.floor(255), false, false, math.floor(2), true, false, false, false)
					
					if #(coords - v) < 1.2 then
						ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to '..k..' the bank')
						
						if IsControlJustReleased(math.floor(0), math.floor(38)) then
							if k == 'enter' then
								imInBank = true
								SetEntityCoords(PlayerPedId(), Config.Teleports['exit'])
								Createlasers()
								TriggerServerEvent('centralbank:enterBank')
								
								ESX.ShowNotification('If you exit the bank you cannot re-enter')
							elseif k == 'exit' then
								imInBank = false
								SetEntityCoords(PlayerPedId(), Config.Teleports['enter'])
								DeleteLasers()
								TriggerServerEvent('centralbank:exitHeist')
								
								EndHeist()
							end
							
							Wait(2000)
						end
					end
				end
			end
			
			Wait(0)
		end
	end)
	
	Citizen.CreateThread(function()
		while not heistStarted do
			for k,v in pairs(Config.Doors) do
				local door = GetClosestObjectOfType(v.coords, 1.0, v.model, false, false, false)
				
				if DoesEntityExist(door) then
					SetEntityHeading(door, v.heading)
					FreezeEntityPosition(door, true)
				end
			end
			
			local isAiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId())
			
			if isAiming and targetPed == employees[math.floor(1)] then
				if allGuardsDead then
					TriggerServerEvent('centralbank:startHeist')
				else
					ESX.ShowNotification('Kill all the guards first!')
				end
				
				Wait(2000)
			end
			
			Wait(500)
		end
	end)
end

function ProcessWinnerPolice()
	for i=math.floor(1), #Config.Employees do
		employees[i] = CreateLocalNPC(Config.Employees[i].model, Config.Employees[i].coords, Config.Employees[i].heading)
	end
	
	local targetPed = employees[math.floor(1)]
	
	RequestModel(GetHashKey('prop_cash_case_02'))
	while not HasModelLoaded(GetHashKey('prop_cash_case_02')) do Wait(0) end
	
	cashCase = CreateObject(GetHashKey('prop_cash_case_02'), GetEntityCoords(targetPed), false, true)
	AttachEntityToEntity(cashCase, targetPed, GetPedBoneIndex(targetPed, math.floor(57005)), 0.20, 0.05, -0.25, 260.0, 60.0, math.floor(0), true, true, false, true, math.floor(1), true)
	
	RequestAnimDict('anim@heists@box_carry@')
	while not HasAnimDictLoaded('anim@heists@box_carry@') do Wait(0) end
	
	TaskPlayAnim(targetPed, 'anim@heists@box_carry@', 'idle', 8.0, -8.0, math.floor(-1), math.floor(50), math.floor(0), false, false, false)
	
	Citizen.CreateThread(function()
		while imWinner do
			local coords = GetEntityCoords(PlayerPedId())
			
			for k,v in pairs(Config.Teleports) do
				if #(coords - v) < 25.0 then
					DrawMarker(math.floor(27), v, 0.0, 0.0, 0.0, math.floor(0), 0.0, 0.0, 1.0, 1.0, 1.0, math.floor(255), math.floor(0), math.floor(0), math.floor(255), false, false, math.floor(2), true, false, false, false)
					
					if #(coords - v) < 1.2 then
						ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to '..k..' the bank')
						
						if IsControlJustReleased(math.floor(0), math.floor(38)) then
							if k == 'enter' then
								imInBank = true
								SetEntityCoords(PlayerPedId(), Config.Teleports['exit'])
								Createlasers()
								
								ESX.ShowNotification('If you exit the bank you cannot re-enter')
							elseif k == 'exit' then
								imInBank = false
								SetEntityCoords(PlayerPedId(), Config.Teleports['enter'])
								DeleteLasers()
								TriggerServerEvent('centralbank:exitHeist')
								
								EndHeist()
							end
							
							Wait(2000)
						end
					end
				end
			end
			
			Wait(0)
		end
	end)
	
	Citizen.CreateThread(function()
		while imWinner do
			if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(targetPed)) < 2.0 then
				ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to take the reward')
				
				if IsControlJustReleased(math.floor(0), math.floor(38)) then
					TriggerServerEvent('centralbank:policeReward')
					Wait(1000)
				end
			else
				Wait(1500)
			end
			
			Wait(0)
		end
	end)
end

function ProcessEvent()
	radiusBlip = AddBlipForRadius(Config.Coords, Config.Radius)
	SetBlipColour(radiusBlip, math.floor(1))
	SetBlipAlpha(radiusBlip, math.floor(80))
	
	Citizen.CreateThread(function()
		while eventStarted do
			local coords = GetEntityCoords(PlayerPedId())
			
			if not inEvent and #(coords.xy - Config.Coords.xy) < (Config.Radius + 50.0) then
				DisableControlAction(math.floor(0), math.floor(24), true)	--INPUT_ATTACK
				DisableControlAction(math.floor(0), math.floor(25), true)	--INPUT_AIM
				DisableControlAction(math.floor(0), math.floor(69), true)	--INPUT_VEH_ATTACK
				DisableControlAction(math.floor(0), math.floor(70), true)	--INPUT_VEH_ATTACK2
				DisableControlAction(math.floor(0), math.floor(92), true)	--INPUT_VEH_PASSENGER_ATTACK
				DisableControlAction(math.floor(0), math.floor(114), true)	--INPUT_VEH_FLY_ATTACK
				DisableControlAction(math.floor(0), math.floor(140), true)	--INPUT_MELEE_ATTACK_LIGHT
				DisableControlAction(math.floor(0), math.floor(141), true)	--INPUT_MELEE_ATTACK_HEAVY
				DisableControlAction(math.floor(0), math.floor(142), true)	--INPUT_MELEE_ATTACK_ALTERNATE
				DisableControlAction(math.floor(0), math.floor(257), true)	--INPUT_ATTACK2
				DisableControlAction(math.floor(0), math.floor(263), true)	--INPUT_MELEE_ATTACK1
				DisableControlAction(math.floor(0), math.floor(264), true)	--INPUT_MELEE_ATTACK2
				DisableControlAction(math.floor(0), math.floor(331), true)	--INPUT_VEH_FLY_ATTACK2
				DisableControlAction(math.floor(0), math.floor(346), true)	--INPUT_VEH_MELEE_LEFT
				DisableControlAction(math.floor(0), math.floor(347), true)	--INPUT_VEH_MELEE_RIGHT
				
				DisablePlayerFiring(PlayerId(), true)

				exports['dpemotes']:ForceCloseMenu()
			else
				Wait(1500)
			end
			
			Wait(0)
		end
	end)
	
	Citizen.CreateThread(function()
		while eventStarted do
			local coords = GetEntityCoords(PlayerPedId())
			
			if not inEvent and #(coords.xy - Config.Coords.xy) < Config.Radius then
				if not IsEntityDead(PlayerPedId()) and GetVehiclePedIsIn(PlayerPedId(), false) == math.floor(0) then
					if PlayerData.job.name == 'police' or (PlayerData.job.name ~= 'police' and #(coords.xy - Config.Coords.xy) > (Config.Radius - 10.0)) then
						ESX.TriggerServerCallback('centralbank:canEnter', function(canEnter)
							if canEnter then
								inEvent = true
								
								SendNUIMessage({action = 'showTab'})
								TriggerServerEvent('centralbank:enterEvent', true)

								SetBlipColour(radiusBlip, math.floor(5))
								
								ESX.ShowNotification('You entered the Central Bank event')
								
								InsideEvent()
							end
						end)
						
						Wait(3000)
					end
				end
			elseif inEvent and #(coords.xy - Config.Coords.xy) > Config.Radius then
				inEvent = false
				
				SendNUIMessage({action = 'hideTab'})
				SendNUIMessage({action = 'hideScore'})
				
				TriggerServerEvent('centralbank:enterEvent', false)
				SetBlipColour(radiusBlip, math.floor(1))
				
				ESX.ShowNotification('You left the Central Bank event')
				
				Wait(3000)
			end
			
			Wait(1500)
		end
		
		inEvent = false
		
		if DoesBlipExist(radiusBlip) then
			RemoveBlip(radiusBlip)
		end
		
		radiusBlip = nil
		
		SendNUIMessage({action = 'hideTab'})
		SendNUIMessage({action = 'hideScore'})
	end)
end

function InsideEvent()
	local showingScore = false
	
	Citizen.CreateThread(function()
		while inEvent do
			if not showingScore and IsControlPressed(math.floor(0), math.floor(211)) then
				showingScore = true
				
				local kills = eventKills[PlayerData.job.name] and eventKills[PlayerData.job.name].kills or math.floor(0)
				SendNUIMessage({action = 'showScore', info = FormatTable(eventKills), kills = kills})
			elseif showingScore and IsControlJustReleased(math.floor(0), math.floor(211)) then
				showingScore = false
				SendNUIMessage({action = 'hideScore'})
				Wait(1000)
			end
			
			Wait(0)
		end
	end)
end

function ProcessDoors()
	Citizen.CreateThread(function()
		while true do
			local wait = 2000
			local coords = GetEntityCoords(PlayerPedId())
			
			for k,v in pairs(Config.Entrances) do
				if #(coords - v.coords) < 25.0 then
					wait = 0
					
					local door = GetClosestObjectOfType(v.coords, 0.1, v.model, false, false, false)
					
					if DoesEntityExist(door) then
						SetEntityHeading(door, v.h1)
						FreezeEntityPosition(door, true)
						
						Wait(100)
					end
				end
			end
			
			Wait(wait)
		end
	end)
end

function Createlasers()
	Citizen.CreateThread(function()
		for k,v in pairs(Config.Lasers) do
			lasers[k] = Laser.new(Config.Lasers[k][math.floor(1)],Config.Lasers[k][math.floor(2)],Config.Lasers[k][math.floor(3)])
			
			lasers[k].onPlayerHit(function(playerBeingHit, hitPos)
				if playerBeingHit then
					StartEntityFire(PlayerPedId())
					SetEntityHealth(PlayerPedId(), math.floor(0))
				else
					-- Laser just stopped hitting the playerf
					-- hitPos will just be a zero vector here
				end
			end)
			
			if v then
				lasers[k].setActive(true)
			end
		end
	end)
end

function DeleteLasers()
	for k,v in pairs(Config.Lasers) do
		if lasers[k] then
			lasers[k].setActive(false)
		end
	end
end

function EndHeist()
	eventStarted = false
	heistStarted = false
	
	if imWinner then
		imWinner = false
		
		if imInBank then
			imInBank = false
			SetEntityCoords(PlayerPedId(), Config.Teleports['enter'])
		end
		
		for i=math.floor(1), #employees do
			if DoesEntityExist(employees[i]) then
				DeleteEntity(employees[i])
			end
		end
		
		for i=math.floor(1), #guards do
			if DoesEntityExist(guards[i]) then
				DeleteEntity(guards[i])
			end
		end
		
		for i=math.floor(1), #trolleys do
			if DoesEntityExist(trolleys[i]) then
				DeleteEntity(trolleys[i])
			end
		end
		
		if DoesEntityExist(cashCase) then
			DeleteEntity(cashCase)
		end
	end
end

function CreateGuardNPC(model, coords, heading, group)
	RequestModel(model)
	
	while not HasModelLoaded(model) do
		Wait(10)
	end
	
	local npc = CreatePed(math.floor(5), model, coords.x, coords.y, coords.z - 1.0, heading, true, true)
	SetPedRandomComponentVariation(npc)
	SetEntityHeading(npc, heading)
	SetPedCanRagdoll(npc, false)
	SetPedAccuracy(npc, math.floor(70))
	SetPedArmour(npc, math.floor(100))
	SetPedCanSwitchWeapon(npc, true)
	SetPedDropsWeaponsWhenDead(npc, false)
	SetPedFleeAttributes(npc, math.floor(0), false)
	SetRagdollBlockingFlags(npc, math.floor(1))
	SetPedDiesWhenInjured(npc, false)
	SetPedHearingRange(npc, 250.0)
	GiveWeaponToPed(npc, 'WEAPON_PISTOL', math.floor(255), false, false)
	TaskGuardCurrentPosition(npc, 10.0, 10.0, math.floor(1))
	SetPedCombatMovement(npc, math.floor(2))
	SetPedKeepTask(npc, true)
	SetPedRelationshipGroupHash(npc, group)
	
	SetModelAsNoLongerNeeded(model)
	
	return npc
end

function CreateLocalNPC(model, coords, heading)
	RequestModel(model)
	
	while not HasModelLoaded(model) do
		Wait(10)
	end
	
	local npc = CreatePed(math.floor(5), model, coords.x, coords.y, coords.z - 1.0, heading, false, true)
	SetPedRandomComponentVariation(npc)
	SetEntityHeading(npc, heading)
	FreezeEntityPosition(npc, true)
	SetEntityInvincible(npc, true)
	SetPedCanRagdoll(npc, false)
	SetBlockingOfNonTemporaryEvents(npc, true)
	
	SetModelAsNoLongerNeeded(model)
	
	return npc
end

function RequestAnim(dict)
	RequestAnimDict(dict)
	
	while not HasAnimDictLoaded(dict) do
		Wait(0)
	end
end

function FormatTable(data)
	local elements = {}
	
	for k,v in pairs(data) do
		table.insert(elements, {label = v.label, points = v.kills})
	end
	
	return elements
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for i=math.floor(1), #employees do
			if DoesEntityExist(employees[i]) then
				DeleteEntity(employees[i])
			end
		end
		
		for i=math.floor(1), #guards do
			if DoesEntityExist(guards[i]) then
				DeleteEntity(guards[i])
			end
		end
		
		for i=math.floor(1), #trolleys do
			if DoesEntityExist(trolleys[i]) then
				DeleteEntity(trolleys[i])
			end
		end
		
		if DoesEntityExist(cashCase) then
			DeleteEntity(cashCase)
		end
	end
end)

exports('InOnCentralBank', function()
	return inEvent
end)