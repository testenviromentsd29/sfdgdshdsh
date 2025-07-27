ESX = nil
local esxloaded, currentstop = false, 0
local HasAlreadyEnteredArea, vehiclespawned, albetogetbags, truckdeposit = false, false, false, false, false
local work_truck, NewDrop, LastDrop, binpos, truckpos, garbagebag, truckplate, mainblip, AreaType, AreaInfo, currentZone, currentstop, AreaMarker , testBlip
local Blips, CollectionJobs, depositlist = {}, {}, {}
local clockedin = true

----------clothes
local PreviousPed               = {}
local PreviousPedHead           = {}
local PreviousPedProps          = {}
local face
local headblendData
--------------------

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData()
		
	if PlayerData.job.name == Config.JobName then
		mainblip = AddBlipForCoord(Config.Zones[2].pos)

		SetBlipSprite (mainblip, 318)
		SetBlipDisplay(mainblip, 4)
		SetBlipScale  (mainblip, 0.7)
		SetBlipColour (mainblip, 5)
		SetBlipAsShortRange(mainblip, true)
	
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Garbage Job')
		EndTextCommandSetBlipName(mainblip)
	end
	
		
	esxloaded = true
	
	
	Wait(10000)
	garbageGPS()
	
end)


function garbageGPS()

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			SetPlayerTargetingMode(3)
		end
	end)
	
	--[[Citizen.CreateThread(function()
		local times = 0
		while true do
			Citizen.Wait(0)
			if IsAimCamActive() and IsPedShooting(GetPlayerPed(-1)) then
				local rot = GetGameplayCamRot(2)
				local pitch, roll, yaw = rot.x, rot.y, rot.z
				local x,y = GetNuiCursorPosition()
				Citizen.Wait(100)
				local nx,ny = GetNuiCursorPosition()
				
				if math.abs(ny-y) < 3 and math.abs(nx-x) > 1 then
					times = times +1
					
				else
					times = 0 
				end
				

				
				local nRot = GetGameplayCamRot(2)
				local nPitch, nRoll, nYaw = nRot.x, nRot.y, nRot.z
				local diffYaw, diffPitch = GetAngleDiff(yaw, nYaw, 360), GetAngleDiff(pitch, nPitch, 180)
				if times > 4 then
					times = 0
					TriggerServerEvent("garbagejob:417szjzm1goy", "Aimbot [C2]", false, {
						yaw = yaw, 
						nYaw = nYaw, 
						diffYaw = diffYaw, 
						pitch = pitch,
						nPitch = nPitch,
						diffPitch = diffPitch
					})
				end	


				if diffYaw > 120.0 or diffPitch > 45.0 then
					TriggerServerEvent("garbagejob:417szjzm1goy", "Aimbot [C2]", false, {
						yaw = yaw, 
						nYaw = nYaw, 
						diffYaw = diffYaw, 
						pitch = pitch,
						nPitch = nPitch,
						diffPitch = diffPitch
					})
				end
			end
		end
		
	end)]]
	


end

function GetAngleDiff(x, y, max)
	if x > y then
        local long = (x - y) > (max / 2)
        if long then
            return max - (x - y)
        else
            return (x - y)
        end
	else
        local long = (y - x) > (max / 2)
        if long then
            return max - (y - x)
        else
            return (y - x)
        end
	end
end


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	TriggerServerEvent('garbagejob:setconfig')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if PlayerData.job.name == 'garbage' and job.name ~= 'garbage' then
		if vehiclespawned then 
			endMission()
		end
	end
	PlayerData.job = job

	if mainblip ~= nil then
		RemoveBlip(mainblip)
		mainblip = nil
	end

	if PlayerData.job.name == Config.JobName then
		mainblip = AddBlipForCoord(Config.Zones[2].pos)

		SetBlipSprite (mainblip, 318)
		SetBlipDisplay(mainblip, 4)
		SetBlipScale  (mainblip, 0.7)
		SetBlipColour (mainblip, 5)
		SetBlipAsShortRange(mainblip, true)
	
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Garbage Job')
		EndTextCommandSetBlipName(mainblip)
	end
end)

RegisterNetEvent('garbagejob:movetruckcount')
AddEventHandler('garbagejob:movetruckcount', function(count)
	Config.TruckPlateNumb = count
end)

RegisterNetEvent('garbagejob:updatejobs')
AddEventHandler('garbagejob:updatejobs', function(newjobtable)
	CollectionJobs = newjobtable
end)


RegisterNetEvent('garbagejob:selectnextjob')
AddEventHandler('garbagejob:selectnextjob', function()
	if currentstop < Config.MaxStops then
		SetVehicleDoorShut(work_truck, 5, false)
		SetBlipRoute(Blips['delivery'], false)
		FindDeliveryLoc()
		albetogetbags = false
	else
		NewDrop = nil
		oncollection = false
		SetVehicleDoorShut(work_truck, 5, false)
		RemoveBlip(Blips['delivery'])
		SetBlipRoute(Blips['endmission'], true)
		albetogetbags = false
		ESX.ShowNotification('return_depot')
	end
end)

RegisterNetEvent('garbagejob:enteredarea')
AddEventHandler('garbagejob:enteredarea', function(zone)
	CurrentAction = zone.name

	if CurrentAction == 'timeclock'  and IsGarbageJob() then
		--MenuCloakRoom()
	end

	if CurrentAction == 'vehiclelist' then
		if clockedin and not vehiclespawned then
			MenuVehicleSpawner()
		end
	end

	if CurrentAction == 'endmission' and vehiclespawned then
		CurrentActionMsg = 'cancel_mission'
	end

	if CurrentAction == 'collection' and not albetogetbags then
		if IsPedInAnyVehicle(GetPlayerPed(-1)) and GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)) == worktruckplate then
			CurrentActionMsg = 'collection'
		else
			CurrentActionMsg = 'You Need Work Truck'
		end
	end

    if CurrentAction == 'expireditemscollection' and not albetogetbags then
		if IsPedInAnyVehicle(GetPlayerPed(-1)) and GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)) == worktruckplate then
			CurrentActionMsg = 'collection'
		else
			CurrentActionMsg = 'You Need Work Truck'
		end
	end

	if CurrentAction == 'bagcollection' then
		if zone.bagsremaining > 0 then
			CurrentActionMsg = 'Collect The Bags', tostring(zone.bagsremaining)
		else
			CurrentActionMsg = nil
		end
	end

	if CurrentAction == 'deposit' then
		CurrentActionMsg = 'Toss The Bag'
	end

end)

RegisterNetEvent('garbagejob:leftarea')
AddEventHandler('garbagejob:leftarea', function()
	ESX.UI.Menu.CloseAll()    
    CurrentAction = nil
	CurrentActionMsg = ''
end)

Citizen.CreateThread( function()
	while true do 
        if esxloaded and PlayerData.job.name == Config.JobName then
            sleep = 1500
            ply = GetPlayerPed(-1)
            plyloc = GetEntityCoords(ply)

            for i, v in pairs(Config.Zones) do
                if GetDistanceBetweenCoords(plyloc, v.pos, true)  < 20.0 and esxloaded then
                    sleep = 0
                    if v.name == 'timeclock' and IsGarbageJob() then
                        --DrawMarker(24, v.pos.x, v.pos.y, v.pos.z+1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.size,  v.size, v.size, 0,255, 0, 100, false, true, 2, false, false, false, false)
                    elseif v.name == 'endmission' and vehiclespawned then
                        DrawMarker(39, v.pos.x, v.pos.y, v.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0,  v.size,  v.size, v.size, 255,0, 0, 100, false, true, 2, false, false, false, false)
                    elseif v.name == 'vehiclelist' and clockedin and not vehiclespawned then
                        DrawMarker(39, v.pos.x, v.pos.y, v.pos.z+1, 0.0, 0.0, 0.0, 0, 0.0, 0.0,  v.size,  v.size, v.size, 204,204, 0, 100, false, true, 2, false, false, false, false)
                    end
                end
            end

            for i, v in pairs(CollectionJobs)  do
                if GetDistanceBetweenCoords(plyloc, v.pos, true)  < 10.0 and truckpos == nil then
                    sleep = 0
                    DrawMarker(1, v.pos.x,  v.pos.y,  v.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0,  3.0,  3.0, 1.0, 255,0, 0, 100, false, true, 2, false, false, false, false)
                    break
                end
            end

            if truckpos ~= nil then
                if GetDistanceBetweenCoords(plyloc, truckpos, true) < 10.0  then
                    sleep = 0
                    DrawMarker(20, truckpos.x,  truckpos.y,  truckpos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0,  0.4, 0.4, 0.4, 0,100, 0, 100, false, true, 2, false, false, false, false)
                end
            end

            if oncollection then
                if GetDistanceBetweenCoords(plyloc, NewDrop.pos, true) < 30.0 and not albetogetbags then
                    sleep = 0
                    DrawMarker(20, NewDrop.pos.x,  NewDrop.pos.y,  NewDrop.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0,  NewDrop.size,  NewDrop.size, NewDrop.size, 204,204, 0, 100, false, true, 2, false, false, false, false)
                end
            end

            Citizen.Wait(sleep)
        else
            Citizen.Wait(10000)
        end       
	end
end)


function endMission()
	if IsPedInAnyVehicle(GetPlayerPed(-1)) then
		local getvehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		TaskLeaveVehicle(GetPlayerPed(-1), getvehicle, 0)
	end
	while IsPedInAnyVehicle(GetPlayerPed(-1)) do
		Citizen.Wait(0)
	end
	Citizen.InvokeNative( 0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized( work_truck ) )
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end
	
	if Blips['endmission'] ~= nil then
		RemoveBlip(Blips['endmission'])
		Blips['endmission'] = nil
	end
	SetBlipRoute(Blips['delivery'], false)
	SetBlipRoute(Blips['endmission'], false)
	vehiclespawned = false
	albetogetbags = false
	CurrentAction =nil
	CurrentActionMsg = nil
end

Citizen.CreateThread( function()
	while true do 
            Citizen.Wait(0)
        if esxloaded and PlayerData.job.name == Config.JobName then    
            while CurrentAction ~= nil and CurrentActionMsg ~= nil do
                Citizen.Wait(0)
                SetTextComponentFormat('STRING')
                AddTextComponentString(CurrentActionMsg)
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)

                if IsControlJustReleased(0, 38) then

                    if CurrentAction == 'endmission' then
						endMission()
                    end

                    if CurrentAction == 'collection' then
                        if CurrentActionMsg == 'collection' then
                            SelectBinAndCrew(GetEntityCoords(GetPlayerPed(-1)))
                            CurrentAction = nil
                            CurrentActionMsg  = nil
                            IsInArea = false
                        end
                    end

                    if CurrentAction == 'bagcollection' then
                        CurrentAction = nil
                        CurrentActionMsg = nil
                        CollectBagFromBin(currentZone)
                        IsInArea = false
                    end

                    if CurrentAction == 'deposit' then
                        CurrentAction = nil
                        CurrentActionMsg = nil
                        PlaceBagInTruck(currentZone)
                        IsInArea = false
                    end
                end
            end
        else
            Citizen.Wait(10000)
        end        
	end
end)

-- thread so the script knows you have entered a markers area - 
Citizen.CreateThread( function()
	while true do
        if esxloaded and PlayerData.job.name == Config.JobName then 
            sleep = 1000
            ply = GetPlayerPed(-1)
            plyloc = GetEntityCoords(ply)
            IsInArea = false
            currentZone = nil
            
            for i,v in pairs(Config.Zones) do
                if GetDistanceBetweenCoords(plyloc, v.pos, false)  <  v.size +3 then
                    IsInArea = true
                    currentZone = v
                end
            end

            if oncollection and not albetogetbags then
                if GetDistanceBetweenCoords(plyloc, NewDrop.pos, true)  <  NewDrop.size +3 then
                    IsInArea = true
                    currentZone = NewDrop
                end
            end

            if truckpos ~= nil then
                if GetDistanceBetweenCoords(plyloc, truckpos, false)  <  2.0 then
                    IsInArea = true
                    currentZone = {type = 'Deposit', name = 'deposit', pos = truckpos,}
                end
            end

            for i,v in pairs(CollectionJobs) do
                if GetDistanceBetweenCoords(plyloc, v.pos, false)  <  2.0 and truckpos == nil then
                    IsInArea = true
                    currentZone = v
                end
            end

            if IsInArea and not HasAlreadyEnteredArea then
                HasAlreadyEnteredArea = true
                sleep = 0
                TriggerEvent('garbagejob:enteredarea', currentZone)
            end

            if not IsInArea and HasAlreadyEnteredArea then
                HasAlreadyEnteredArea = false
                sleep = 1000
                TriggerEvent('garbagejob:leftarea', currentZone)
            end

            Citizen.Wait(sleep)
        else
            Citizen.Wait(10000)
        end   
	end
end)

function CollectBagFromBin(currentZone)
	binpos = currentZone.pos
	truckplate = currentZone.trucknumber

	if not HasAnimDictLoaded("anim@heists@narcotics@trash") then
		RequestAnimDict("anim@heists@narcotics@trash") 
		while not HasAnimDictLoaded("anim@heists@narcotics@trash") do 
			Citizen.Wait(0)
		end
	end

	local worktruck = NetworkGetEntityFromNetworkId(currentZone.truckid)

	if DoesEntityExist(worktruck) and GetDistanceBetweenCoords(GetEntityCoords(worktruck), GetEntityCoords(GetPlayerPed(-1)), true) < 25.0 then
		truckpos = GetOffsetFromEntityInWorldCoords(worktruck, 0.0, -5.25, 0.0)
		if not Config.Debug then
			TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
		end
		TriggerServerEvent('garbagejob:bagremoval', currentZone.pos, currentZone.trucknumber) 
		trashcollection = false
		if not Config.Debug then
			Citizen.Wait(4000)
		end
		ClearPedTasks(PlayerPedId())
		local randombag = math.random(0,2)

		if randombag == 0 then
			garbagebag = CreateObject(GetHashKey("prop_cs_street_binbag_01"), 0, 0, 0, true, true, true) -- creates object
			AttachEntityToEntity(garbagebag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand    
		elseif randombag == 1 then
			garbagebag = CreateObject(GetHashKey("bkr_prop_fakeid_binbag_01"), 0, 0, 0, true, true, true) -- creates object
			AttachEntityToEntity(garbagebag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), .65, 0, -.1, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand    
		elseif randombag == 2 then
			garbagebag = CreateObject(GetHashKey("hei_prop_heist_binbag"), 0, 0, 0, true, true, true) -- creates object
			AttachEntityToEntity(garbagebag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.12, 0.0, 0.00, 25.0, 270.0, 180.0, true, true, false, true, 1, true) -- object is attached to right hand    
		end  

		TaskPlayAnim(PlayerPedId(), 'anim@heists@narcotics@trash', 'walk', 1.0, -1.0,-1,49,0,0, 0,0)
		CurrentAction = nil
		CurrentActionMsg = nil
		HasAlreadyEnteredArea = false
	else
		ESX.ShowNotification('not_near_truck')
		TriggerServerEvent('garbagejob:unknownlocation', currentZone.pos)
	end
end

function PlaceBagInTruck(thiszone)
	if not HasAnimDictLoaded("anim@heists@narcotics@trash") then
		RequestAnimDict("anim@heists@narcotics@trash") 
		while not HasAnimDictLoaded("anim@heists@narcotics@trash") do 
			Citizen.Wait(0)
		end
	end
	ClearPedTasksImmediately(GetPlayerPed(-1))
	TaskPlayAnim(PlayerPedId(), 'anim@heists@narcotics@trash', 'throw_b', 1.0, -1.0,-1,2,0,0, 0,0)
	Citizen.Wait(800)
	local garbagebagdelete = DeleteEntity(garbagebag)
	Citizen.Wait(100)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	CurrentAction = nil
	CurrentActionMsg = nil
	depositlist = nil
	truckpos = nil
	TriggerServerEvent('garbagejob:bagdumped', binpos, truckplate)
	HasAlreadyEnteredArea = false
end

function SelectBinAndCrew(location)
	local bin = nil
	
	for i, v in pairs(Config.DumpstersAvaialbe) do
		bin = GetClosestObjectOfType(location, 20.0, v, false, false, false )
		if bin ~= 0 then
			if CollectionJobs[GetEntityCoords(bin)] == nil then
				break
			else
				bin = 0
			end
		end
	end
	if bin ~= 0 then
		truckplate = GetVehicleNumberPlateText(work_truck)
		truckid = NetworkGetNetworkIdFromEntity(work_truck)
		TriggerServerEvent('garbagejob:setworkers', GetEntityCoords(bin), truckplate, truckid )
		truckpos = nil
		albetogetbags = true
		SetBlipRoute(Blips['delivery'], false)
		currentstop = currentstop + 1
		SetVehicleDoorOpen(work_truck, 5, false, false)
	else
		ESX.ShowNotification('no_trash_aviable')
		SetBlipRoute(Blips['endmission'], true)
		FindDeliveryLoc()
	end
end

function FindDeliveryLoc()
	if LastDrop ~= nil then
		lastregion = GetNameOfZone(LastDrop.pos)
	end
	local newdropregion = nil
	while newdropregion == nil or newdropregion == lastregion do
		randomloc = math.random(1, #Config.Collections)
		newdropregion = GetNameOfZone(Config.Collections[randomloc].pos)
	end
	NewDrop = Config.Collections[randomloc]
	LastDrop = NewDrop
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end
	
	if Blips['endmission'] ~= nil then
		RemoveBlip(Blips['endmission'])
		Blips['endmission'] = nil
	end
	
	Blips['delivery'] = AddBlipForCoord(NewDrop.pos)
	SetBlipSprite (Blips['delivery'], 318)
	SetBlipAsShortRange(Blips['delivery'], true)
	SetBlipRoute(Blips['delivery'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Garbage Collection')
	EndTextCommandSetBlipName(Blips['delivery'])
	
	Blips['endmission'] = AddBlipForCoord(Config.Zones[1].pos)
	SetBlipSprite (Blips['endmission'], 318)
	SetBlipColour(Blips['endmission'], 1)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Garbage Center')
	EndTextCommandSetBlipName(Blips['endmission'])

	oncollection = true
	ESX.ShowNotification('Drive To Garbage Collection')
end

function IsGarbageJob()
	if ESX ~= nil then
		local isjob = false
		if PlayerData.job.name == Config.JobName then
			isjob = true
		end
		return isjob
	end
end

function MenuCloakRoom()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
			title    = 'cloakroom',
            align = 'bottom-right',
			elements = {
				{label = 'job_wear', value = 'job_wear'},
				{label = 'citizen_wear', value = 'citizen_wear'}
			}}, function(data, menu)
			if data.current.value == 'citizen_wear' then
				clockedin = false
                restoreOutfit()
			elseif data.current.value == 'job_wear' then
				clockedin = true
                ApplyGarbageSkin()

			end
			menu.close()
		end, function(data, menu)
			menu.close()
		end)
end

function MenuVehicleSpawner()
	local elements = {}

	for i=1, #Config.Trucks, 1 do
		table.insert(elements, {label = GetLabelText(GetDisplayNameFromVehicleModel(Config.Trucks[i])).." "..Config.PriceForTruck.."$", value = Config.Trucks[i]})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehiclespawner', {
			title    = 'vehiclespawner',
            align = 'bottom-right',
			elements = elements
		}, function(data, menu)
            ESX.TriggerServerCallback("garbagejob:payForSpawn", function(paid)  
                if paid then    
                    ESX.Game.SpawnVehicle(data.current.value, Config.VehicleSpawn.pos, 355.0, function(vehicle)
                        local trucknumber = Config.TruckPlateNumb + 1
                        if trucknumber <=9 then
                            SetVehicleNumberPlateText(vehicle, 'GCREW00'..trucknumber)
                            worktruckplate =   'GCREW00'..trucknumber 
                        elseif trucknumber <=99 then
                            SetVehicleNumberPlateText(vehicle, 'GCREW0'..trucknumber)
                            worktruckplate =   'GCREW0'..trucknumber 
                        else
                            SetVehicleNumberPlateText(vehicle, 'GCREW'..trucknumber)
                            worktruckplate =   'GCREW'..trucknumber 
                        end
                        TriggerServerEvent('garbagejob:movetruckcount')   
                        SetEntityAsMissionEntity(vehicle,true, true)
                        TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)  
                        vehiclespawned = true 
                        albetogetbags = false
                        work_truck = vehicle
						SetVehicleFuelLevel(vehicle, 50)
						exports["gas_station"]:SetFuel(vehicle, 50)
                        currentstop = 0
                        FindDeliveryLoc()
                    end)
                else
                    ESX.ShowNotification("Not Enough Money!")
                end    

            end)    

			menu.close()
		end, function(data, menu)
			menu.close()
		end)
end

function restoreOutfit()

	if PreviousPedProps[68] then
		local playerPed = PlayerPedId()
		SetPedHairColor(playerPed, PreviousPedProps[68], PreviousPedProps[69])
		SetPedEyeColor(playerPed, PreviousPedProps[67])
		SetPedHeadBlendData(playerPed, headblendData.FirstFaceShape, headblendData.SecondFaceShape, headblendData.ThirdFaceShape, headblendData.FirstSkinTone, headblendData.SecondSkinTone, headblendData.ThirdSkinTone, math.floor(0));

		for i = 0, 12, 1 do
			i = math.floor(i)
			SetPedComponentVariation(playerPed, PreviousPed[i].component, PreviousPed[i].drawable, PreviousPed[i].texture)
		end

		for i = 0, 12, 1 do
			i = math.floor(i)
			SetPedHeadOverlay(playerPed, i, PreviousPedHead[i].overlayID, 1.0)
		end

		for i = 0, 7, 1 do
			i = math.floor(i)
			ClearPedProp(playerPed, i)
		end

		for i = 0, 7, 1 do
			i = math.floor(i)
			SetPedPropIndex(playerPed, PreviousPedProps[i].component, PreviousPedProps[i].drawable, PreviousPedProps[i].texture, true)
		end

	end

end

function ApplyGarbageSkin()

	headblendData = exports.esx_ligmajobs:GetHeadBlendData(PlayerPedId())

	for i = 0, 12 do
		i = math.floor(i)
		PreviousPed[i]= {component = i, drawable = GetPedDrawableVariation(PlayerPedId(), i), texture = GetPedTextureVariation(PlayerPedId(), i)}
	end

	for i = 0, 12 do
		i = math.floor(i)
		PreviousPedHead[i] = {overlayID = GetPedHeadOverlayValue(PlayerPedId(), i)}
	end
	
	PreviousPedProps[67] = GetPedEyeColor(PlayerPedId())
	PreviousPedProps[68] = GetPedHairColor(PlayerPedId())
	PreviousPedProps[69] = GetPedHairHighlightColor(PlayerPedId())

	for i = 0, 7 do
		i = math.floor(i)
		PreviousPedProps[i] = {component = i, drawable = GetPedPropIndex(PlayerPedId(), i), texture = GetPedPropTextureIndex(PlayerPedId(), i)}
	end

	setUniform(Config.Uniforms['garbage_wear'],PlayerPedId())

	for i = 0, 12 do
		i = math.floor(i)
		SetPedHeadOverlay(PlayerPedId(), i, PreviousPedHead[i].overlayID, 1.0)
	end
	SetPedComponentVariation(PlayerPedId(), PreviousPed[2].component, PreviousPed[2].drawable, PreviousPed[2].texture)
	SetPedHairColor(PlayerPedId(), PreviousPedProps[68], PreviousPedProps[69])
	SetPedEyeColor(PlayerPedId(), PreviousPedProps[67])
	SetPedHeadBlendData(PlayerPedId(), headblendData.FirstFaceShape, headblendData.SecondFaceShape, headblendData.ThirdFaceShape, headblendData.FirstSkinTone, headblendData.SecondSkinTone, headblendData.ThirdSkinTone, math.floor(0))  
end

function setUniform(v, playerPed)
	
	TriggerEvent('skinchanger:getSkin', function(skin)
		
		if skin.sex == math.floor(0) then
			if v.male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, v.male)
			else
				ESX.ShowNotification("No Outfit")
			end

			
		else
			if v.female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, v.female)
			else
				ESX.ShowNotification("No Outfit")
			end

			
		end
	end)
end