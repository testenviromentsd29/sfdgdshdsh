
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

local jobStarted = false
local coordsToGo = nil
local visitedCoords           = {}
local prevMarkerIndex         = 0
local lastStart				  = 0
local MinDepositFee = 1
local MaxDepositFee = 5

local caseBlip
local spawnedVehicle

----------------

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	ESX.PlayerData = ESX.GetPlayerData()
	if string.find(ESX.PlayerData.job.name,"bankerjob") then
		for k,v in pairs(Config.Markers) do
			for x,y in pairs(v) do
				if type(y) == "table" then
					TriggerEvent("esx_utilities:add","Bank_"..k..x,"Press ~INPUT_CONTEXT~ to Open "..x,38,y.DrawDistance ,y.Type,y.coords,y.Size,y.Colour,GetCurrentResourceName(),k)
				end
			end
		end
		createJobBlip()
	end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
	
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	if string.find(ESX.PlayerData.job.name,"bankerjob") then
		for k,v in pairs(Config.Markers) do
			for x,y in pairs(v) do
				if type(y) == "table" then
					TriggerEvent("esx_utilities:add","Bank_"..k..x,"Press ~INPUT_CONTEXT~ to Open "..x,38,y.DrawDistance ,y.Type,y.coords,y.Size,y.Colour,GetCurrentResourceName(),k)
				end
			end
		end
		createJobBlip()
	end
end)

local function SetVehicleMaxMods(vehicle)

    local props = {
      modEngine       = 3,
      modBrakes       = 2,
      modTransmission = 2,
      modSuspension   = 3,
      modTurbo        = true,
    }

    ESX.Game.SetVehicleProperties(vehicle, props)
    SetVehicleWindowTint(vehicle,2)
    SetVehicleColours(vehicle,0,0)
    SetVehicleExtraColours(vehicle,0,0)
    SetVehicleDirtLevel(vehicle,0.0)
    SetVehicleNeonLightEnabled(vehicle,0,true)
    SetVehicleNeonLightEnabled(vehicle,1,true) --oti
    SetVehicleNeonLightEnabled(vehicle,2,true)  --xeirotero
    SetVehicleNeonLightEnabled(vehicle,3,true)  --yparxei
    SetVehicleNeonLightsColour(vehicle,35,1,255)
    SetVehicleNumberPlateTextIndex(vehicle,1)
	
    math.randomseed(GetGameTimer())
	local vPlate = 'BNK'..math.random(10000, 99999)
	
    SetVehicleNumberPlateText(vehicle, vPlate)
end

AddEventHandler("justpressed",function(label,key)
    if label == "F6" and string.find(ESX.PlayerData.job.name,"bankerjob") then

        local elements = {}
	    table.insert(elements, { label = "Ξεκίνα τη δουλειά" , value = "start_job" } )
	    table.insert(elements, { label = "Σταμάτα τη δουλειά" , value = "stop_job" } )
		table.insert(elements, { label = "Change deposit fee", value = "deposit_fee"})

	    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'banker_actions',
		{
			title		= 'Επίλεξε Δραστηριότητα',
			align		= 'bottom-right',
			elements	= elements
		}, function(data, menu)
			if data.current.value == "start_job" then
				if lastStart == nil or (GetGameTimer()/1000 - lastStart) > Config.DelayForStart then
					
					if not jobStarted then
						if IsVehicleClose(Config.CarSpawn) then
							if #(Config.Markers[ESX.PlayerData.job.name].Vehicle_Spawner.coords - GetEntityCoords(PlayerPedId())) < 50 then
								jobStarted = true
								lastStart = GetGameTimer()/1000
								startJob()
								ESX.ShowNotification("H δουλεία ξεκίνησε")
							else
								ESX.ShowNotification("Πρέπει να είσαι στη βάση σου για να ξεκινήσεις τη δουλειά")
							end
						else
							ESX.ShowNotification("Πρέπει να έχεις το όχημα δίπλα σου")
						end
						
					end
				else
					ESX.ShowNotification("Πρέπει να περιμένεις "..Config.DelayForStart.." δεύτερα για να πραγμοτοποιήσεις αυτή την ενέργεια")
				end

			elseif data.current.value == "stop_job" then
				jobStarted = false
				--visitedCoords = {}
				--coordsToGo = nil
				--prevMarkerIndex = 0
				ClearGpsCustomRoute()
				ClearGpsMultiRoute()
				ClearGpsPlayerWaypoint()
				SetWaypointOff()
				if caseBlip then
					RemoveBlip(caseBlip)
				end
				ESX.ShowNotification("Σταμάτησες τη δουλειά")
			elseif data.current.value == "deposit_fee" then
				menu.close()
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_fee',
				{
					title = "New deposit fee"
				},
				function(data, menu)
					if ESX.PlayerData.job.grade_name == "boss" then
		
						local amount = tonumber(data.value)
						if amount == nil or amount < MinDepositFee or amount > MaxDepositFee then
							ESX.ShowNotification("Deposit fee must be between "..MinDepositFee.." and "..MaxDepositFee)
						else
							menu.close()
							TriggerServerEvent("bank:changeDepositFee",amount,ESX.PlayerData.job.name)
						end
					else
						menu.close()
					end
				end,
				function(data, menu)
					menu.close()
				end)
			end
		end,function(data, menu)
			menu.close()
		end)

    end
end)

AddEventHandler("pressedmarker", function(markerlabel,MarkerObject)
	if MarkerObject.resource == GetCurrentResourceName() and string.find(ESX.PlayerData.job.name,"bankerjob") then
		if string.find(markerlabel,"Vehicle_Spawner") then
			if not jobStarted then
				local closeVehicle , cdistnace = ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
				if cdistnace > 5 then
					ESX.Game.SpawnVehicle(Config.CarSpawn, Config.Markers[ESX.PlayerData.job.name].VehicleSpawnCoords, Config.Markers[ESX.PlayerData.job.name].VehicleHeading, function(vehicle)		
						TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle,  -1)	
						spawnedVehicle = vehicle		
						SetVehicleMaxMods(vehicle)
					end)
				end
			else
				ESX.ShowNotification("Πρέπει να έχεις ξεκινήσει τη δουλειά για να spawnάρεις όχημα")
			end
		elseif string.find(markerlabel,"Vehicle_Deleter") then
			if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then
				ESX.Game.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), false))
			else
				ESX.ShowNotification("Πρέπει να είσαι μέσα σε όχημα")
			end
		end
	end
end)

function IsVehicleClose(vehicle_name)

	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local vehicle_hash = GetHashKey(vehicle_name)
	local closestVehicle , distance = ESX.Game.GetClosestVehicle(coords)
	if distance <= Config.DistanceToCheckIfVehicleIsNear and GetHashKey(vehicle_name) == GetEntityModel(closestVehicle)  then
		return true
	else
		return false
	end
	

end

function createBlipForCoords(coords)
	if caseBlip then
		RemoveBlip(caseBlip)
	end
	caseBlip = AddBlipForCoord(coordsToGo)
	SetBlipSprite(caseBlip, Config.CaseBlip.Sprite)
	SetBlipDisplay(caseBlip, 4)
	SetBlipScale(caseBlip, Config.CaseBlip.Scale)
	SetBlipColour(caseBlip, Config.CaseBlip.Colour)
	SetBlipAsShortRange(caseBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Case Farm")
	EndTextCommandSetBlipName(caseBlip)
end

function startJob()
	local closeMarker 
	coordsToGo = findNextMarker()
	createBlipForCoords(coordsToGo)
	table.insert(visitedCoords,coordsToGo)
	if #visitedCoords == #Config.GetCasePoints then
		visitedCoords = {}
	end
	SetNewWaypoint(coordsToGo.x, coordsToGo.y)
	local closestMarkerCoords
	local pressedE = false
	CreateThread(function()
		
		while jobStarted do
			if coordsToGo then
				local closeseDistance = 999999
				for i = 1, #Config.GetCasePoints do
					local distance = #(GetEntityCoords(PlayerPedId()) - Config.GetCasePoints[i])
					if distance < closeseDistance then
						closeseDistance = distance
						closestMarkerCoords = Config.GetCasePoints[i]
						
					end
				end
			end
			Wait(3000)
		end


	end)
	CreateThread(function()
		
		while jobStarted do
			print(closestMarkerCoords,coordsToGo)
			if closestMarkerCoords == coordsToGo and not pressedE then
				local style = Config.CaseMarkers

				DrawMarker(style.Type, closestMarkerCoords.x, closestMarkerCoords.y, closestMarkerCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, style.Size.x, style.Size.y, style.Size.z, style.Colour.r, style.Colour.g, style.Colour.b, 100, false, true, 2, false, false, false, false)
				local x,y,z = closestMarkerCoords.x, closestMarkerCoords.y, closestMarkerCoords.z
				if #(GetEntityCoords(PlayerPedId()) - closestMarkerCoords ) <= style.Size.x+0.5 then
					ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to farm case")
					if IsControlJustPressed(0, Keys["E"]) then
						--farm
						if IsVehicleClose(Config.CarSpawn) then
							farm()
							pressedE = true
							CreateThread(function()			
								while #(GetEntityCoords(PlayerPedId()) - closestMarkerCoords ) < 100 do
									Wait(0)
								end
								pressedE = false
							end)
							if #visitedCoords == #Config.GetCasePoints then
								visitedCoords = {}
							end
							coordsToGo = findNextMarker()
							table.insert(visitedCoords,coordsToGo)
							
							SetNewWaypoint(coordsToGo.x, coordsToGo.y)
							createBlipForCoords(coordsToGo)
						else
							ESX.ShowNotification("Πρέπει να έχεις το όχημα δίπλα σου")
						end
						
					end

				end
				
			end
			
			Wait(0)
		end


	end)
	CreateThread(function()
		
		while jobStarted do
			if spawnedVehicle and DoesEntityExist(spawnedVehicle) then
				local pedCoords = GetEntityCoords(PlayerPedId())
				local carCoords = GetEntityCoords(spawnedVehicle)
				if #(pedCoords - carCoords) > Config.DistanceFromVehicleToCancelMission then
					jobStarted = false
					visitedCoords = {}
					coordsToGo = nil
					prevMarkerIndex = 0
					ESX.Game.DeleteVehicle(spawnedVehicle)
					ClearGpsCustomRoute()
					ClearGpsMultiRoute()
					ClearGpsPlayerWaypoint()
					SetWaypointOff()
					if caseBlip then
						RemoveBlip(caseBlip)
					end
					ESX.ShowNotification("Η δουλειά τερματίστηκε γιατί έφυγες μακριά από το όχημά σου")
				end

			end
			Wait(3000)
		end


	end)

end



-----routing-----------------------



function findNextMarker()
	local found 
	local randomIndex 
	local returnCoords 
	while true do
		found = false
		randomIndex = math.random(1,#Config.GetCasePoints)
		returnCoords = Config.GetCasePoints[randomIndex]
		for k,v in pairs(visitedCoords) do
			if v == returnCoords then
				found = true
			end
		end
		if found == false and not areCoordsClose(returnCoords) then
			return returnCoords
		end
		Citizen.Wait(0)
	end    
end


-------------

function farm()

	ClearPedTasks(PlayerPedId())
	local dict = "mini@repair"

	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end

	TaskPlayAnim(PlayerPedId(), dict, "fixing_a_ped", 8.0, 8.0, -1, 50, 0, false, false, false)
	FreezeEntityPosition(PlayerPedId(), true)
	Citizen.Wait(Config.SecondsPlayingAnimation*1000)
	FreezeEntityPosition(PlayerPedId(), false)
	ClearPedTasks(PlayerPedId())
	TriggerServerEvent("esx_bankerjob:farmcase")

end

-------Blip-----------


function createJobBlip()

	for k,v in pairs(Config.Markers) do
		if k == ESX.PlayerData.job.name then

			local blip = AddBlipForCoord(v.Vehicle_Spawner.coords)
			SetBlipSprite(blip, Config.SpawnCarBlip.Sprite)
			SetBlipColour(blip, Config.SpawnCarBlip.Colour)
			SetBlipScale(blip, Config.SpawnCarBlip.Scale)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Bankerjob')
			EndTextCommandSetBlipName(blip)

		end
	end
	

end




---------------------

--Ligma Jobs
--[[ {--bankerjob1
	label = "Trapeza Ellados",
	setjobname = "bankerjob1",
	grades = {
		{code_name = "newbie", level = 0, label = "Νεοσύλλεκτος", salary = 200},
		{code_name = "worker", level = 1, label = "Συλλέκτης", salary = 250},
		{code_name = "manager", level = 2, label = "Μάνατζερ", salary = 300},
		{code_name = "boss", level = 3, label = "Αφεντικό", salary = 400},
	},

	MarkerCustomCode = {
		["CasePayment"] = "/home/ubuntu/servers/testserver4_30124/resources/[ESX]/[Jobs]/[LIGMA]/esx_ligmajobs/customCode/bankerjob1/casepayment.lua",
		["Boss_Actions"] = "/home/ubuntu/servers/testserver4_30124/resources/[ESX]/[Jobs]/[LIGMA]/esx_ligmajobs/customCode/bankerjob1/bossactions.lua",
		
	},
	LocationGrades = {
		CasePayment = 3,
	},
	Locations = {
		Armory = vector3(147.0, -1044, 28.9),
		Boss_Actions = vector3(145.0,-1041.7,28.8),
		CasePayment = vector3(142.12, -1043.0, 29.1),	
		Cloackroom = vector3(145.3, -1037.0, 29.0)
	},
	
	CloackroomOptions = {
		{
			male = {
				['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				['torso_1'] = 40,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 40,
				['pants_1'] = 28,   ['pants_2'] = 2,
				['shoes_1'] = 38,   ['shoes_2'] = 4,
				['chain_1'] = 118,  ['chain_2'] = 0
			},
			female = {
				['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				['torso_1'] = 40,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 40,
				['pants_1'] = 28,   ['pants_2'] = 2,
				['shoes_1'] = 38,   ['shoes_2'] = 4,
				['chain_1'] = 118,  ['chain_2'] = 0
			},
			label = "Πάρε Ρούχα Δουλειάς",
			minimum_grade_level = 0
		},
	},
	LocationStyling = {
		CasePayment = {
			Type = 21,
			Size = { x = 0.5, y = 0.5, z = 0.5},
			Colour = { r = 96, g = 43, b = 255},
		},
		Armory = {
			Type = 42,
			Size = { x = 0.5, y = 0.5, z = 0.5},
			Colour = { r = 250, g = 1, b = 1},
		},
		Cloackroom = {
			Type = 0,
			Size = { x = 0.5, y = 0.5, z = 0.5},
			Colour = { r = 103, g = 157, b = 245},
		},
		Boss_Actions = {
			Type = 21,
			Size = { x = 0.5, y = 0.5, z = 0.5},
			Colour = { r = 1, g = 250, b = 1},
		},

		
	},
	ArmoryOptions = {
		{action = "deposit_weapon", minimum_grade_level = 5},
		{action = "withdraw_weapon", minimum_grade_level = 5},
		{action = "deposit_item", minimum_grade_level = 0},
		{action = "withdraw_item", minimum_grade_level = 2},
	},
	
	Markers = {
		Size = { x = 1.5, y = 1.5, z = 1.0 },
		Colour = { r = 50, g = 50, b = 204 },
		Type = 21
	},

	useSlack = true,
	DiscordLogs = {
		ArmoryHook = '',
	},
	
	
	
}, ]]

RegisterNetEvent('esx_bankerjob:bossactions')
AddEventHandler('esx_bankerjob:bossactions', function(Job)
	ESX.UI.Menu.CloseAll()
						
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boss_action_menu', {
		title    = "Bank Boss Menu",
		align    = 'bottom-right',
		elements = {
			{label = "Boss actions", value= "boss_actions"}
		}
	}, function(data, menu)
	
		if data.current.value == "boss_actions" then
			TriggerEvent('esx_society:openBossMenu', ESX.PlayerData.job.name, function(data, menu)
				menu.close()
			end, { wash = false }) -- disable washing money
		end
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('esx_bankerjob:casepayment')
AddEventHandler('esx_bankerjob:casepayment', function(Job)
	local ProgressBarSeconds = 5
	local progressBarLoading = true

	local TRiggerEVent = TriggerServerEvent

	CreateThread(function()
		while progressBarLoading do
			local coords = GetEntityCoords(PlayerPedId())
			local casePaymentCoords = Job.Locations.CasePayment
			if GetDistanceBetweenCoords(casePaymentCoords,coords,true) > Job.Markers.Size.x then  
				if progressBarLoading then
				progressBarLoading = false
				TriggerEvent('ligma_progressbar:client:cancel')
				end
			end
			Wait(0)
		end
	end)
	ExecuteCommand("e mechanic3")
	TriggerEvent('ligma_progressbar:client:progress',{
	name = "sell_case",
	duration = ProgressBarSeconds*1000,
	label = 'Opening Safe...',
	useWhileDead = false,
	canCancel = true,
	colour = "#e33330",
	controlDisables = {
		disableMovement = false,
		disableCarMovement = true,
		disableMouse = true,
		disableCombat = true,
	},
	animation = {
		animDict = "missheistdockssetup1clipboard@base",
		anim = "base",
		flags = 49,
	},
	
	},function(cancelled)
		if not cancelled then
		progressBarLoading = false
		
		ClearPedTasksImmediately(GetPlayerPed(-1))
		TriggerServerEvent("esx_bankerjob:sellCases")
		end
	end)
	ClearPedTasksImmediately(GetPlayerPed(-1))
end)

function areCoordsClose(coords)
	local pedcoords = GetEntityCoords(PlayerPedId())
	if #(coords - pedcoords ) < 100 then
		return true
	else
		return false
	end
end