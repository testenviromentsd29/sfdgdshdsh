
Keys = {
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

Job 							= {} --needs to stay as global variable


local PlayerData                = {}

local Markers 					= {}
local mConfig

local unlocked 					= false
local allowedToChange		    = false

local addedClubsMarkets 		= false
local BlipObjects               
local Draws 					= {}
local Insides 					= {}
local findJob 					= false
local MarkerIsIn 				= ''
local isInAnyMarker 			= false
local customCodes 				= {}


ESX                             = nil

--debug

-----------mechanic variables
local IsMechanicBusy          = false
local OnJob                   = false
local CurrentlyTowedVehicle   = nil
local Blips                   = {} --these are mechanic npc jobs blips
local BlipsCreated			  = {}
local NPCOnJob                = false
local NPCTargetTowableZone    = nil
local NPCHasSpawnedTowable    = false
local NPCLastCancel           = GetGameTimer() - math.floor(5) * math.floor(60000)
local NPCHasBeenNextToTowable = false
local NPCTargetDeleterZone    = false
local IsDead                  = false
local IsBusy                  = false

--instructionals
local form = nil
local data = {}

local entries = {}

----------------

local carryingVehicle

Experiences 				 	= {}

Vehicles 				      	= {}
myCar					  		= {}
orginalCarProerties				= {}

lsMenuIsShowed		  		  	= false
isInLSMarker		      		= false
local addedMechanicMarkers    	= false
-------------------------------

---------------shops-----------
local addedShops = false
local shopSettings = {}
local ShopMarkers = {}


--------------clubs------------
local spawned 					= 0
local Plants 					= {}
local isPickingUp, isProcessing = false, false
local numberDrug 


--clothes
local PreviousPed               = {}
local PreviousPedHead           = {}
local PreviousPedProps          = {}
local playerPed 			    = PlayerPedId()
local face
local headblendData

local currentBucket = 0
local currentBucketName = "default"


local DefaultStylings = {
	Armory = {
		Type = 42,
		Size = { x = 0.5, y = 0.5, z = 0.5},
		Colour = { r = 250, g = 1, b = 1},
	},
	BossActions = {
		Type = 21,
		Size = { x = 0.5, y = 0.5, z = 0.5},
		Colour = { r = 1, g = 250, b = 1},
	},
	Vehicle_Options = {
		Type = 36,
		Size = { x = 0.5, y = 0.5, z = 0.5},
		Colour = { r = 1, g = 250, b = 1},
	},
}

function splitString(string)
	local stringTable = {}
	local string1 = ""
	local string2 = ""
	local found = false
	for i = 1, string.len(string) do
		local char = string.sub(string, i, i)
		if char == "_" then
			found = true
		elseif found == false then
			string1 = string1..char
		elseif found == true then
			string2 = string2..char
		end
	end
	stringTable[1] = string1
	stringTable[2] = string2
	return stringTable
end

local F6Garage = [[
	ESX.UI.Menu.CloseAll()
	local elements = {}
	table.insert(elements,{label = "Κόψε Απόδειξη", value = "billing"})

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), Job.setjobname..'_actions',
		{
			title    = "Choose Action",
			align    = "bottom-right",
			elements = elements
		},
	function(data, menu)
		if data.current.value == "billing" then
			ESX.UI.Menu.Open(
			'dialog', GetCurrentResourceName(), 'billing',
			{
				title = "Enter Invoice"
			},
			function(data, menu)

				local amount = tonumber(data.value)
				if amount == nil or amount < 0 then
					ESX.ShowNotification("Invalid Amount")
				else
				
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification("No players nearby")
					else
						menu.close()
					TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))
					Wait(1000)
					TriggerEvent('esx_ligmajobs_addons:KeyboardInput',function(result)
						local reason = exports['dialog']:Create('Enter a reason for bill!', 'Enter reason').value or ""
						TriggerServerEvent('esx_billing:sendBiII', result, 'society_'..Job.setjobname, Job.label.."<br>"..reason, amount)
					end,"Enter Id","",math.floor(4))
					end
				end
			end, function(data, menu)
				menu.close()
			end
			)
		
		elseif data.current.value == "mantra" then
			TriggerEvent("garages:vehicleDeletion")
		end
	end, function(data, menu)
		menu.close()
	end)

]]


local F6Mechanic = [[ 
	function hasItem(name)
		return ESX.DoIHaveItem(name,1)
	end
	
	ESX.UI.Menu.CloseAll()
	local elms = {}
	--table.insert(elms, { label = "Κάνε Παραγγελία", value = "make_order" } )
	table.insert(elms, { label = "Κόψε απόδειξη", value = "billing" } )
	table.insert(elms, { label = "Set Bill Percent", value = "setbillpercent"})
	table.insert(elms, { label = "Φτιάξε το αμάξι", value = "fix_vehicle" } )
	table.insert(elms, { label = "Καθάρισε το αμάξι", value = "clean_vehicle" } )
	--table.insert(elms, { label = "Γενικό Service", value = "rep_km" } )
	table.insert(elms, { label = "Boost Vehicle", value = "boost_vehicle" } )
	if not exports.esx_mechanicMission:isMissionStarted() then
		table.insert(elms, { label = "Στείλε το αμάξι στη μάντρα", value = "del_vehicle" } )
		table.insert(elms, { label = "Φόρτωσε το αμάξι στο φορτηγό", value = "dep_vehicle" } )
		table.insert(elms, { label = "Mechanic Mission", value = "mec_mission" } )
	end
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), Job.setjobname..'_actions',
	{
		title    = Job.label,
		align    = 'bottom-right',
		elements = elms
	},
	function(data, menu)
		if IsMechanicBusy then return end
		if data.current.value == 'make_order' then
			TriggerEvent('jobDelivery:startOrder')
			menu.close()
		elseif data.current.value == 'setbillpercent' then
			TriggerEvent('esx_billing:SetBillPercent')
			menu.close()
		elseif data.current.value == 'billing' then
			
			ESX.UI.Menu.Open(
			'dialog', GetCurrentResourceName(), 'billing',
			{
				title = "Enter Amount"
			},
			function(data, menu)

				local amount = tonumber(data.value)
				if amount == nil or amount < 0 then
					ESX.ShowNotification("Invalid Amount")
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == math.floor(-1) or closestDistance > 20.0 then
						ESX.ShowNotification("No players Nearby")
					else
						menu.close()
						if Job.MecSettings and Job.MecSettings.billToSociety then
							TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))
							Wait(2000)
							TriggerEvent('esx_ligmajobs_addons:KeyboardInput',function(result)
								local reason = exports['dialog']:Create('Enter a reason for bill!', 'Enter reason').value or ""
								TriggerServerEvent('esx_billing:sendBiII', result, 'society_'..Job.setjobname, Job.label.."<br>"..reason, amount)
							end,"Enter Id","",math.floor(4))
						else
							TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))
							Wait(2000)
							TriggerEvent('esx_ligmajobs_addons:KeyboardInput',function(result)
								local reason = exports['dialog']:Create('Enter a reason for bill!', 'Enter reason').value or ""
								TriggerServerEvent('esx_billing:sendBiII', result, 'society_'..Job.setjobname, Job.label.."<br>"..reason, amount)
							end,"Enter Id","",math.floor(4))
						end
								
					end
				end
			end,
			function(data, menu)
				menu.close()
			end)
		

		elseif data.current.value == "mec_mission" then
			if not exports.esx_mechanicMission:isMissionStarted() then
				TriggerEvent('esx_mechanicMission:startMission',Job)
			else
				ESX.ShowNotification('Mission is already started!')
			end
			menu.close()
		elseif data.current.value == "rep_km" then
			TriggerEvent('vehicle_km:fixVehicle')
		elseif data.current.value == "boost_vehicle" then
			ExecuteCommand("mechanic_extra")
		elseif data.current.value == "hijack_vehicle" then

			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification("You can\'t do this from inside the vehicle!")
				return
			end

			if DoesEntityExist(vehicle) then
				IsMechanicBusy = true
				TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", math.floor(0), true)
				Citizen.CreateThread(function()
					Citizen.Wait(10000)

					SetVehicleDoorsLocked(vehicle, math.floor(1))
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)

					ESX.ShowNotification("Vehicle Unlocked")
					IsMechanicBusy = false
				end)
			else
				ESX.ShowNotification("No vehicles nearby")
			end

		elseif data.current.value == "fix_vehicle" then
			TriggerEvent('mainmenu:fixvehicle')
		elseif data.current.value == "clean_vehicle" then
			TriggerEvent('mainmenu:cleanvehicle')
		elseif data.current.value == "del_vehicle" then

			local ped = PlayerPedId()

			if DoesEntityExist(ped) and not IsEntityDead(ped) then
					local pos = GetEntityCoords( ped )
	
				if IsPedSittingInAnyVehicle(ped) then
					local vehicle = GetVehiclePedIsIn( ped, false )
		
					if GetPedInVehicleSeat(vehicle, math.floor(-1)) == ped then
						ESX.ShowNotification("Vehicle has been ~r~impounded")
						ESX.Game.DeleteVehicle(vehicle)
					else
						ESX.ShowNotification('You must be in the driver seat!')
					end
				else
					local vehicle = ESX.Game.GetVehicleInDirection()
		
					if DoesEntityExist(vehicle) then
						ESX.ShowNotification("Vehicle has been ~r~impounded")
						ESX.Game.DeleteVehicle(vehicle)
					else
						ESX.ShowNotification("You must be ~r~near a vehicle~s~ to impound it.")
					end
				end
			end
			

		elseif data.current.value == "dep_vehicle" then

			local playerped = PlayerPedId()
			local vehicle 
	
			local towmodel = GetHashKey('flatbed')
			local isVehicleTow = false
			local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(playerped),math.floor(10))

			for k,v in pairs(vehicles) do
				if IsVehicleModel(v,towmodel) or IsVehicleModel(v,GetHashKey('tow')) then
					isVehicleTow = true
					vehicle = v
					break
				end
			end
	
			if isVehicleTow then
					local targetVehicle = ESX.Game.GetVehicleInDirection()
				if CurrentlyTowedVehicle == nil then
					if targetVehicle ~= 0 and targetVehicle ~= nil then
						if not IsPedInAnyVehicle(playerped, true) then
							if vehicle ~= targetVehicle then
								AttachEntityToEntity(targetVehicle, vehicle, math.floor(20), -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, math.floor(20), true)
								CurrentlyTowedVehicle = targetVehicle
								ESX.ShowNotification("vehicle successfully ~b~attached~s~")
				
							else
								ESX.ShowNotification("~r~you can\'t~s~ attach own tow truck")
							end
						end
					else
						ESX.ShowNotification("There is no ~r~vehicle~s~ to be attached")
					end
				else
					AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, math.floor(20), -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, math.floor(20), true)
					DetachEntity(CurrentlyTowedVehicle, true, true)
		
					CurrentlyTowedVehicle = nil
		
					ESX.ShowNotification("vehicle successfully ~b~dettached~s~!")
				end
			else
				ESX.ShowNotification("~r~Action impossible!~s~ You need a ~b~Flatbed~s~ to load a vehicle")
			end

		
		end

	end,function(data, menu)
		menu.close()
	end)
	

]]


local F6Menu = [[ 
	ESX.UI.Menu.CloseAll()
	local elements = {}
	--table.insert(elements, { label = "Κάνε Παραγγελία", value = "make_order" } )
	table.insert(elements,{label = "Κόψε Απόδειξη", value = "billing"})
	table.insert(elements,{label = "Set Bill Percent", value = "setbillpercent"})

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), Job.setjobname..'_actions',
		{
			title    = "Choose Action",
			align    = "bottom-right",
			elements = elements
		},
	function(data, menu)
		if data.current.value == 'make_order' then
			TriggerEvent('jobDelivery:startOrder')
			menu.close()
		elseif data.current.value == 'setbillpercent' then
			TriggerEvent('esx_billing:SetBillPercent')
			menu.close()
		elseif data.current.value == "billing" then
			ESX.UI.Menu.Open(
			'dialog', GetCurrentResourceName(), 'billing',
			{
				title = "Enter Invoice"
			},
			function(data, menu)

				local amount = tonumber(data.value)
				if amount == nil or amount < 0 then
					ESX.ShowNotification("Invalid Amount")
				else
				
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification("No players nearby")
					else
						menu.close()
						TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))
						Wait(1000)
						TriggerEvent('esx_ligmajobs_addons:KeyboardInput',function(result)
							local reason = exports['dialog']:Create('Enter a reason for bill!', 'Enter reason').value or ""
							TriggerServerEvent('esx_billing:sendBiII', result, 'society_'..Job.setjobname, Job.label.."<br>"..reason, amount)
						end,"Enter Id","",math.floor(4))
					end
				end
			end, function(data, menu)
				menu.close()
			end
			)
		end
	end, function(data, menu)
		menu.close()
	end)
]]

local F6SecurityMenu = [[ 
	local elements = {}
	
	--table.insert(elements, { label = "Κάνε Παραγγελία", value = "make_order" } )
	table.insert(elements, { label = "Set Bill Percent", value = "setbillpercent"})
	if PlayerData.job and PlayerData.job.grade_name == 'transporter' then
		table.insert(elements, {label = "Package Options", value = 'package_opt'})
	end

	--table.insert(elements, {label = "Handcuff",	      value = 'handcuff'})
	table.insert(elements, {label = "Drag",           value = 'drag'})
	table.insert(elements, {label = "Put in vehicle", value = 'put_in_vehicle'})
	table.insert(elements, {label = "Out of vehicle", value = 'out_the_vehicle'})
	
	if Experiences and Experiences["society_security1"] and Experiences["society_security1"].amount >= 750 then
		--table.insert(elements, {label = "Call Police",    value = 'call_police'})
	end
	table.insert(elements,{label = "Κόψε Απόδειξη", value = "billing"})

	ESX.UI.Menu.CloseAll()
		
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'bank_actions',
	{
		title    = "Security Actions",
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		local action = data.current.value

		if data.current.value == 'make_order' then
			TriggerEvent('jobDelivery:startOrder')
			menu.close()
		elseif data.current.value == 'setbillpercent' then
			TriggerEvent('esx_billing:SetBillPercent')
			menu.close()
		elseif data.current.value == 'call_police' then
			local ped = PlayerPedId()
			
			local PedPosition = GetEntityCoords(ped)
			local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
			local now = GetGameTimer()/1000
			if now-lastTimeCalledForHelp > 120 then
				TriggerServerEvent('esx_addons_gcphone:startCall','police', "Help me, security here", PlayerCoords, {
	
					PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
				})
				
				lastTimeCalledForHelp = GetGameTimer()/1000
				menu.close()
				ESX.ShowNotification("Police Notified!")
			else
				ESX.ShowNotification("You have to wait to call for help again")
			end
		elseif data.current.value == "billing" then
			ESX.UI.Menu.Open(
			'dialog', GetCurrentResourceName(), 'billing',
			{
				title = "Enter Invoice"
			},
			function(data, menu)

				local amount = tonumber(data.value)
				if amount == nil or amount < 0 then
					ESX.ShowNotification("Invalid Amount")
				else
				
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 5.0 then
						ESX.ShowNotification("No players nearby")
					else
						menu.close()
						TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))
						Wait(1000)
						TriggerEvent('esx_ligmajobs_addons:KeyboardInput',function(result)
							local reason = exports['dialog']:Create('Enter a reason for bill!', 'Enter reason').value or ""
							TriggerServerEvent('esx_billing:sendBiII', result, 'society_'..Job.setjobname, Job.label.."<br>"..reason, amount)
						end,"Enter Id","",math.floor(4))

						
					end
				end
			end, function(data, menu)
				menu.close()
			end
			)
		elseif action == 'handcuff' then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			print(GetPlayerServerId(closestPlayer))

			if closestPlayer ~= -1 and closestDistance <= 3.0 then
				print(GetPlayerServerId(closestPlayer))
				TriggerServerEvent('esx_policejob:handcuff2' , GetPlayerServerId(closestPlayer))
			end
		elseif action == 'drag' then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 3.0 then
				TriggerServerEvent('esx_policejob:drag' , GetPlayerServerId(closestPlayer))
			end
		elseif action == 'put_in_vehicle' then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 3.0 then
				TriggerServerEvent('esx_policejob:putInVehicle' , GetPlayerServerId(closestPlayer))
			end

		elseif action == 'out_the_vehicle' then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 3.0 then
				TriggerServerEvent('esx_policejob:OutVehicle' , GetPlayerServerId(closestPlayer))
			end
		elseif action == 'package_opt' then
			local elements = {}
			
			table.insert(elements, {label = "Package Light Vests", value = 'bulletproof1'})
			table.insert(elements, {label = "Package Medium Vests", value = 'bulletproof2'})
			table.insert(elements, {label = "Package Heavy Vests", value = 'bulletproof3'})
			table.insert(elements, {label = "Unpackage Light Vests", value = 'p_bulletproof1'})
			table.insert(elements, {label = "Unpackage Medium Vests", value = 'p_bulletproof2'})
			table.insert(elements, {label = "Unpackage Heavy Vests", value = 'p_bulletproof3'})
			
			ESX.UI.Menu.CloseAll()
			
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'package_actions',
			{
				title    = "Package Actions",
				align    = 'bottom-right',
				elements = elements
			}, function(data, menu)
				ESX.UI.Menu.CloseAll()
				
				local coords = GetEntityCoords(PlayerPedId())
				local action = false
				
				if string.find(data.current.value, 'p_') == 1 then
					action = true
				end
				
				local itemName = string.gsub(data.current.value, 'p_', '')
				
				FreezeEntityPosition(PlayerPedId(), true)
				
				if not action then
					exports['progressBars']:startUI(5000, "Packaging..")
				else
					exports['progressBars']:startUI(5000, "Unpackaging..")
				end
				
				ExecuteCommand("e mechanic4")
				Citizen.Wait(5000)
				ClearPedTasks(PlayerPedId())
				FreezeEntityPosition(PlayerPedId(), false)
				
				if GetDistanceBetweenCoords(coords, GetEntityCoords(PlayerPedId()), true) < 2.0 then
					TriggerServerEvent('esx_ligmajobs_addons:packageItem', itemName, action)
				end
			end, 
			function(data, menu)
				menu.close()
			end)
		end
	end, 
	function(data, menu)
		menu.close()
	end)
]]

local F6Tolls = [[ 
	ESX.UI.Menu.CloseAll()
	local elements = {}
	table.insert(elements,{label = "Κόψε Απόδειξη", value = "billing"})
	table.insert(elements,{label = "Set Bill Percent", value = "setbillpercent"})
	table.insert(elements,{label = "Αγορα EPass", value = "buyepass"})

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), Job.setjobname..'_actions',
		{
			title    = "Choose Action",
			align    = "bottom-right",
			elements = elements
		},
	function(data, menu)
		if data.current.value == 'buyepass' then
			TriggerServerEvent('TollsBooth:buymyEpass')
			menu.close()
		elseif data.current.value == 'setbillpercent' then
			TriggerEvent('esx_billing:SetBillPercent')
			menu.close()
		elseif data.current.value == "billing" then
			ESX.UI.Menu.Open(
			'dialog', GetCurrentResourceName(), 'billing',
			{
				title = "Enter Invoice"
			},
			function(data, menu)

				local amount = tonumber(data.value)
				if amount == nil or amount < 0 then
					ESX.ShowNotification("Invalid Amount")
				else
				
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification("No players nearby")
					else
						menu.close()
						TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))
						Wait(1000)
						TriggerEvent('esx_ligmajobs_addons:KeyboardInput',function(result)
							local reason = exports['dialog']:Create('Enter a reason for bill!', 'Enter reason').value or ""
							TriggerServerEvent('esx_billing:sendBiII', result, 'society_'..Job.setjobname, Job.label.."<br>"..reason, amount)
						end,"Enter Id","",math.floor(4))
					end
				end
			end, function(data, menu)
				menu.close()
			end
			)
		end
	end, function(data, menu)
		menu.close()
	end)
]]
local F6Trader = [[ 
	ESX.UI.Menu.CloseAll()
	local elements = {}
	table.insert(elements,{label = "Κόψε Απόδειξη", value = "billing"})
	table.insert(elements,{label = "Set Bill Percent", value = "setbillpercent"})
	table.insert(elements,{label = "Μετατροπη οπλου σε blueprint", value = "buyepass"})

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), Job.setjobname..'_actions',
		{
			title    = "Choose Action",
			align    = "bottom-right",
			elements = elements
		},
	function(data, menu)
		if data.current.value == 'buyepass' then


			ESX.PlayerData = ESX.GetPlayerData()
			weapons = ESX.PlayerData.loadout


			local elements = {}
			for key, value in pairs(weapons) do
				table.insert(elements,{label = value.label, value = value.name})
			end
			
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dasdasd', {
				title    = 'Choose weapon',
				align    = 'bottom-right',
				elements = elements,
			},function(data, menu)
				if data.current.value then
					TriggerServerEvent("esx_ligmajobs:tradeThisWeapon", data.current.value)
				end
				menu.close()
			end,function(data, menu)
				menu.close()
			end)





			menu.close()
		elseif data.current.value == 'setbillpercent' then
			TriggerEvent('esx_billing:SetBillPercent')
			menu.close()
		elseif data.current.value == "billing" then
			ESX.UI.Menu.Open(
			'dialog', GetCurrentResourceName(), 'billing',
			{
				title = "Enter Invoice"
			},
			function(data, menu)

				local amount = tonumber(data.value)
				if amount == nil or amount < 0 then
					ESX.ShowNotification("Invalid Amount")
				else
				
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification("No players nearby")
					else
						menu.close()
						TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))
						Wait(1000)
						TriggerEvent('esx_ligmajobs_addons:KeyboardInput',function(result)
							local reason = exports['dialog']:Create('Enter a reason for bill!', 'Enter reason').value or ""
							TriggerServerEvent('esx_billing:sendBiII', result, 'society_'..Job.setjobname, Job.label.."<br>"..reason, amount)
						end,"Enter Id","",math.floor(4))
					end
				end
			end, function(data, menu)
				menu.close()
			end
			)
		end
	end, function(data, menu)
		menu.close()
	end)
]]
local F6Menus = {
	["SecurityF6"] = F6SecurityMenu,
	["MechanicF6"] = F6Mechanic,
	["GarageF6"] = F6Garage,
	["BillingF6"] = F6Menu,
	["TollsF6"] = F6Tolls,
	["TraderF6"] = F6Trader,

}






function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= math.floor(1) and UpdateOnscreenKeyboard() ~= math.floor(2) do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= math.floor(2) then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
	end
end

function debugprint(...)
	if Config.DebugMode then
		print(...)
	end
end

function ligmaload(text,...)
	if text == nil or text == "" then
		return
	end
	local func, err = load(text)
	if func then
		local ok, add = pcall(func)
		if ok then
			if add then
				add(...)
			end
		else
			print("Execution error:", add)
		end
	else
		print("Compilation error:", err)
	end

end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	
	Wait(2000)

	PlayerData = ESX.GetPlayerData()
	
	local start = GetGameTimer()/1000
	
	while mConfig == nil do
		local now = GetGameTimer()/1000
		if now-start > 15 then
			start = 9999999 -- make sure that it wont run again
			debugprint("failed to load Config because of a delayed client script startup. Requesting from server")
			ESX.TriggerServerCallback('esx_ligmajobs:getconf', function(data)
				Job = data.job
				mConfig = data.config
				BlipObjects = data.blips
				if Job then
					Job["DiscordLogs"] = nil
					Job["SlackLogs"] = nil
				end
				
			end)
		end
		Wait(0)
	end
	debugprint("Config Loaded")
	Wait(1000)


	if not Job then
		Job = {}
		Job.Locations = {}
	end
    findJob = true
	if Job.isMechanic then

		ESX.TriggerServerCallback('esx_ligmajobs:getVehiclesPrices', function(vehicles)
			Vehicles = vehicles
			
			if Job.MecSettings.customprices then
				for k,v in pairs(Job.MecSettings.customprices) do
					for i = 1, #Vehicles do
						if Vehicles[i].model == k then
							Vehicles[i].price = tonumber(v)
							debugprint("Overwritten price of "..k)
							break
						end
					end
				end
			end
		end)

	end
	ESX.TriggerServerCallback('esx_ligmajobs:getStaff', function(staff)
		allowedToChange = staff
		if allowedToChange then
			local enabled = false
			local type = 0
			local colour = 0
			RegisterCommand("changemarker", function()
				if allowedToChange then
					if isInAnyMarker then
						enabled = not enabled
						Citizen.CreateThread(function()
							SetInstructionalButton("Change Colour", math.floor(Keys["SPACE"]), true)
							SetInstructionalButton("Type", math.floor(Keys["N6"]), true)
							SetInstructionalButton("Z Axis", math.floor(Keys["TOP"]), true)
							SetInstructionalButton("Z Axis", math.floor(Keys["DOWN"]), true)
							while enabled do
								if form then
									DrawScaleformMovieFullscreen(form, math.floor(255), math.floor(255), math.floor(255), math.floor(255), math.floor(0))
								end
								Wait(0)
							end
						end)
						
						
						if not enabled and isInAnyMarker then
							if Job.LocationStyling and Job.LocationStyling[MarkerIsIn] then
								if Job.LocationStyling[MarkerIsIn].Type == nil then
									Job.LocationStyling[MarkerIsIn].Type = Job.Markers.Type
								end
								if Job.LocationStyling[MarkerIsIn].Colour == nil then
									Job.LocationStyling[MarkerIsIn].Colour = Job.Markers.Colour
								end
								if Job.LocationStyling[MarkerIsIn].Size == nil then
									Job.LocationStyling[MarkerIsIn].Size = Job.Markers.Size
								end
							end
							TriggerServerEvent("esx_ligmajobs:changemarker", Job.setjobname ,MarkerIsIn,Insides[MarkerIsIn],Job.LocationStyling)	
						else
							type = 0
							colour = 0
						end
					else
						ESX.ShowNotification("Please enter a marker to change it's coords")
					end
				end
			end, false)
			CreateThread(function()
				while true do
					if enabled and isInAnyMarker then
						local mycoords = GetEntityCoords(PlayerPedId())
						local px,py,pz = table.unpack(mycoords)
						local mcoords = Job.Locations[MarkerIsIn]
                        local x,y,z = table.unpack(mcoords)
                        if Job.LocationStyling == nil then
                            Job.LocationStyling = {}
                        end
						if Job.LocationStyling[MarkerIsIn] == nil then
							Job.LocationStyling[MarkerIsIn] = {}
						end
						if Job.LocationStyling[MarkerIsIn].Type == nil then
							Job.LocationStyling[MarkerIsIn].Type = Job.Markers.Type
						end
						if Job.LocationStyling[MarkerIsIn].Colour == nil then
							Job.LocationStyling[MarkerIsIn].Colour = Job.Markers.Colour
						end
						if Job.LocationStyling[MarkerIsIn].Size == nil then
							Job.LocationStyling[MarkerIsIn].Size = Job.Markers.Size
						end
						if IsControlPressed(math.floor(0),math.floor(Keys["DOWN"])) then					
							z = z - 0.05
							Wait(50)
						end
						if IsControlPressed(math.floor(0),math.floor(Keys["TOP"])) then
							z = z + 0.05
							Wait(50)
						end
						if IsControlJustPressed(math.floor(0),math.floor(Keys["N4"])) then
							type = type - 1
							if type < -1 then
								type = 28
							elseif type > 28 then
								type = -1
							end
							if Job.LocationStyling == nil then
								Job.LocationStyling = {}
							end
							if Job.LocationStyling[MarkerIsIn] == nil then
								Job.LocationStyling[MarkerIsIn] = {}
							end
							Job.LocationStyling[MarkerIsIn]["Type"] = type
							
						end
						if IsControlJustPressed(math.floor(0),math.floor(Keys["N6"])) then
							type = type + 1
							if type < -1 then
								type = 28
							elseif type > 28 then
								type = -1
							end
							if Job.LocationStyling == nil then
								Job.LocationStyling = {}
							end
							if Job.LocationStyling[MarkerIsIn] == nil then
								Job.LocationStyling[MarkerIsIn] = {}
							end
							Job.LocationStyling[MarkerIsIn]["Type"] = type
							
						end
						if IsControlJustPressed(math.floor(0),math.floor(Keys["SPACE"])) then
							local r,g,b = 0,0,0
							local r = KeyboardInput("Enter Red","",math.floor(3))
							r = tonumber(r)
							if r < 0 or r > 255 then
								r = 0
							end
							local g = KeyboardInput("Enter Green","",math.floor(3))
							g = tonumber(g)
							if g < 0 or g > 255 then
								g = 0
							end
							local b = KeyboardInput("Enter Blue","",math.floor(3))
							b = tonumber(b)
							if b < 0 or b > 255 then
								b = 0
							end
							if Job.LocationStyling == nil then
								Job.LocationStyling = {}
							end
							if Job.LocationStyling[MarkerIsIn] == nil then
								Job.LocationStyling[MarkerIsIn] = {}
							end
							
							Job.LocationStyling[MarkerIsIn]["Colour"] = { r = r, g = g, b = b}
						end
						
						Job.Locations[MarkerIsIn] = vector3(px,py,z)
						Insides[MarkerIsIn] = vector3(px,py,z)
					end
					Wait(0)
				end
			end)
		end
	end)
end)

RegisterNetEvent("esx:getjobattributes")
AddEventHandler("esx:getjobattributes", function(attr)
	ESX.JobAttributes = attr
end)

RegisterNetEvent("esx:updatejobattributes")
AddEventHandler("esx:updatejobattributes", function(job,key,val)
	while ESX == nil do
		Wait(100)
	end
	
	if ESX.JobAttributes == nil then
		ESX.JobAttributes = {}
	end
	if ESX.JobAttributes[job] == nil then
		ESX.JobAttributes[job] = {}
	end
	ESX.JobAttributes[job][key] = val
end)

RegisterNetEvent("esx_ligmajobs:changeMyMarker")
AddEventHandler("esx_ligmajobs:changeMyMarker", function(name,coords,markerstyling)
	Job.Locations[name] = coords
	Insides[name] = coords
	if markerstyling then
		Job.LocationStyling = markerstyling
	end
end)

RegisterNetEvent("esx_ligmajobs:setkey")
AddEventHandler("esx_ligmajobs:setkey",function(payload)
	unlocked = payload
end)

CreateThread(function()
	while mConfig == nil or BlipObjects == nil or PlayerData.job == nil do
		debugprint("waiting for blips")
		Wait(500)
	end
	Wait(4000)
    for k,v in pairs(BlipObjects) do
        if v.Blip then
			if v.Blip.Coords and (v.Blip.job == nil or PlayerData.job.name == v.Blip.job) then
				if type(v.Blip.Coords) == "string" then
					v.Blip.Coords = load("return "..v.Blip.Coords)()
				end
				if type(v.Blip.Coords) == "table" then
					v.Blip.Coords = vector3(v.Blip.Coords.x,v.Blip.Coords.y,v.Blip.Coords.z)
				end
				if v.Blip.onoffduty == nil or v.Blip.onoffduty == false then 
					if Config.hideBlips == nil then
						local blip = AddBlipForCoord(v.Blip.Coords)

						SetBlipSprite (blip, v.Blip.Sprite)
						SetBlipDisplay(blip, v.Blip.Display)
						SetBlipScale  (blip, v.Blip.Scale)
						SetBlipColour (blip, v.Blip.Colour)
						SetBlipAsShortRange(blip, true)
					
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(v.Blip.Name)
						EndTextCommandSetBlipName(blip)
					end
				end
            
      		end
		end
		if v.Blips and type(v.Blips) == "table" then
			for x,blipObject in pairs(v.Blips) do
				if blipObject.onoffduty == nil or blipObject.onoffduty == false then 
					if type(blipObject.Coords) == "string" then
						blipObject.Coords = load("return "..blipObject.Coords)()
					end
					if type(blipObject.Coords) == "table" then
						blipObject.Coords = vector3(blipObject.Coords.x,blipObject.Coords.y,blipObject.Coords.z)
					end
					if blipObject.Coords and (blipObject.job == nil or PlayerData.job.name == blipObject.job) then
						if Config.hideBlips == nil then
							local blip = AddBlipForCoord(blipObject.Coords)
							SetBlipSprite (blip, blipObject.Sprite)
							SetBlipDisplay(blip, blipObject.Display)
							SetBlipScale  (blip, blipObject.Scale)
							SetBlipColour (blip, blipObject.Colour)
							SetBlipAsShortRange(blip, true)
						
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(blipObject.Name)
							EndTextCommandSetBlipName(blip)
						end
					end
				end
			end
		end
	end

end)

--[[ RegisterNetEvent("esx_ligmajobs:createBlip")
AddEventHandler("esx_ligmajobs:createBlip",function(name)
	if name and BlipObjects[name] then
		local v = BlipObjects[name]
		if v.Blip then
			if v.Blip.Coords and (v.Blip.job == nil or PlayerData.job.name == v.Blip.job) then
				if v.Blip.onoffduty then 
					if type(v.Blip.Coords) == "string" then
						v.Blip.Coords = load("return "..v.Blip.Coords)()
					end
					if type(v.Blip.Coords) == "table" then
						v.Blip.Coords = vector3(v.Blip.Coords.x,v.Blip.Coords.y,v.Blip.Coords.z)
					end
					
					local blip = AddBlipForCoord(v.Blip.Coords)
					BlipsCreated[name] = blip
					
					SetBlipSprite (blip, v.Blip.Sprite)
					SetBlipDisplay(blip, v.Blip.Display)
					SetBlipScale  (blip, v.Blip.Scale)
					SetBlipColour (blip, v.Blip.Colour)
					SetBlipAsShortRange(blip, true)
				
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(v.Blip.Name)
					EndTextCommandSetBlipName(blip)
				end
            
      		end
		end
		if v.Blips and type(v.Blips) == "table" then
			for x,blipObject in pairs(v.Blips) do
				if blipObject.onoffduty then 
					if type(blipObject.Coords) == "string" then
						blipObject.Coords = load("return "..blipObject.Coords)()
					end
					if type(blipObject.Coords) == "table" then
						blipObject.Coords = vector3(blipObject.Coords.x,blipObject.Coords.y,blipObject.Coords.z)
					end
					if blipObject.Coords and (blipObject.job == nil or PlayerData.job.name == blipObject.job) then
						local blip = AddBlipForCoord(blipObject.Coords)
						BlipsCreated[name] = blip
						SetBlipSprite (blip, blipObject.Sprite)
						SetBlipDisplay(blip, blipObject.Display)
						SetBlipScale  (blip, blipObject.Scale)
						SetBlipColour (blip, blipObject.Colour)
						SetBlipAsShortRange(blip, true)
					
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(blipObject.Name)
						EndTextCommandSetBlipName(blip)
					end
				end
			end
		end

	end

end) ]]

--[[ RegisterNetEvent("esx_ligmajobs:removeblip")
AddEventHandler("esx_ligmajobs:removeblip",function(name)

	if BlipObjects[name] and BlipsCreated[name] then
		
		RemoveBlip(BlipsCreated[name])
		BlipsCreated[name] = nil

	end

end) ]]

debugprint("Script Started")

RegisterNetEvent("esx_ligmajobs:conf")
AddEventHandler("esx_ligmajobs:conf",function(data,customDrugLocations)
	debugprint("Received config")

	if data.job then
		for k,v in pairs(data.job) do
			Job[k] = v
		end
	end

	mConfig = data.config
	BlipObjects = data.blips

	if customDrugLocations then
		if Config.Gathering then
			for k,v in pairs(Config.Gathering) do
				if PlayerData.subscription then
					Config.Gathering[k].farmSeconds = math.floor(Config.Gathering[k].farmSeconds/2)
				end
				
				if customDrugLocations[k] then
					Config.Gathering[k].gatherCoords = customDrugLocations[k]
				end
			end
		end
	end
end)

RegisterNetEvent("esx_ligmajobs:receivecustom")
AddEventHandler("esx_ligmajobs:receivecustom",function(mycode)
	debugprint("Received Custom Code")
	customCodes = mycode
end)

RegisterNetEvent("esx_ligmajobs:getMarkets")
AddEventHandler("esx_ligmajobs:getMarkets",function(data)
	debugprint("received shops")
	CreateThread(function()
		Wait(10000)
		if not addedShops then
			addedShops = true
			debugprint("An error has occured with shops")
		end
	end)
	while mConfig == nil do
		Wait(0)
	end
	while Job == nil do
		Wait(0)
	end

	local before = GetGameTimer()/1000
	while Job.Locations == nil do
		local now = GetGameTimer()/1000
		if now - before > 3 then
			Job.Locations = {}
			break
		end
		Wait(0)
	end
	for k,v in pairs(data) do
		if type(v.coords) == "string" then
			v.coords = load("return "..v.coords)()
		end
		if type(v.coords) == "table" then
			v.coords = vector3(v.coords.x,v.coords.y,v.coords.z)
		end
		Job.Locations[v.label] = v.coords
		shopSettings[v.label] = v.settings
		--[[ if ShopBlips[v.label] == nil then
			ShopBlips[v.label] = AddBlipForCoord(v.coords)
	
			SetBlipSprite (ShopBlips[v.label], mConfig.GlobalShopSettings.Blip.Sprite)
			SetBlipDisplay(ShopBlips[v.label], mConfig.GlobalShopSettings.Blip.Display)
			SetBlipScale  (ShopBlips[v.label], mConfig.GlobalShopSettings.Blip.Scale)
			SetBlipColour (ShopBlips[v.label], mConfig.GlobalShopSettings.Blip.Colour)
			SetBlipAsShortRange(ShopBlips[v.label], true)
		
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.realLabel)
			EndTextCommandSetBlipName(ShopBlips[v.label])
		end ]]

	end
	
	ShopMarkers = mConfig.GlobalShopSettings.Markers
	if Job.Markers == nil then
		Job["Markers"] = mConfig.GlobalShopSettings.Markers
	end
	
	addedShops = true
	
end)

AddEventHandler('buckets:onBucketChanged', function(bucketId, bucketName)
	currentBucket = bucketId
	currentBucketName = bucketName
end)

local settingjob = false
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	while settingjob do
		Wait(0)
	end
	settingjob = true
    findJob = false
	Draws = nil --is done to bread loops
	PlayerData.job = job

	local found = false
	debugprint("Emptying Locations")
    if Job.Locations then
        for k,v in pairs(Job.Locations) do
            Job.Locations[k] = nil
        end
    end
	------------------------------------------------------------------------ this is done in order to break previous loops

	ESX.TriggerServerCallback('esx_ligmajobs:getconf', function(data,customDrugLocations)
		Job = data.job
		mConfig = data.config
		BlipObjects = data.blips
		if Job then
			Job["DiscordLogs"] = nil
			Job["SlackLogs"] = nil
			found = true
		end

		findJob = true
		if not found then
			Job = {}
			Job.Locations = {}
		else
			debugprint("Job matched "..Job.setjobname)
			debugprint("Job Locations below")
			
		end
        local tmpTable = {}
        local start = GetGameTimer()/1000
        while Job.Locations == nil do
            local now = GetGameTimer()/1000
            if now-start > 4 then
                ESX.ShowNotification("An error has occured please relog")
                return
                
            end
            Wait(0)
        end
        for k,v in pairs(Job.Locations) do --measure distances
            if type(v) == "string" then
                v = load("return "..v)()
            end
            if type(v) == "table" then
                v = vector3(v.x,v.y,v.z)
            end
            tmpTable[k] = v
            Job.Locations[k] = nil
        end
        Wait(5200)--dont change it is in order to break previous loops
        for k,v in pairs(tmpTable) do --measure distances
            Job.Locations[k] = v
        end
        -------------------------------------------------------------------------
        debugprint("Searching Job")
		addedShops = false
		addedClubsMarkets = false
		addedMechanicMarkers = false
		
		if Job and Job.isClub then
			for k,v in pairs(Job.ClubSettings.shops) do
				Job.Locations["ClubShop_"..k] = vector3(v.Pos.x,v.Pos.y,v.Pos.z)
			end
			addedClubsMarkets = true
		end
		
		if Job and Job.isMechanic then
			if Job.isMechanic then

				ESX.TriggerServerCallback('esx_ligmajobs:getVehiclesPrices', function(vehicles)
					Vehicles = vehicles
					if Job.MecSettings and Job.MecSettings.customprices then
						for k,v in pairs(Job.MecSettings.customprices) do
							for i = 1, #Vehicles do
								if Vehicles[i].model == k then
									Vehicles[i].price = tonumber(v)
									debugprint("Overwritten price of "..k)
									break
								end
							end
						end
					end
				end)
		
			end
			for k,v in pairs(Job.MecSettings) do
				if string.find(k,"Upgrades") then
					if type(v) == "string" then
						v = load("return "..v)()
					end
					if type(v) == "table" then
						v = vector3(v.x,v.y,v.z)
					end
					Job.Locations[k] = v
				end
			end
	
			addedMechanicMarkers = true
		end
		debugprint("waiting shops")
		local before = GetGameTimer()/1000
		while addedShops == false do --wait for shop markers to be inserted to Job.Locations
			local now = GetGameTimer()/1000
			if (now - before) > 14 then
				break
			end
			Wait(0)
		end
		debugprint("shops loaded")
		while findJob == false do 
			Wait(0)
		end
		debugprint("Start Drawing Markers")
		if Job.Locations == nil then
			Job.Locations = {} -- in case players Job doesnt exist in ligmajobs
		end
		for k,v in pairs(Job.Locations) do --measure distances
			
			if type(v) == "string" then
				Job.Locations[k] = load("return "..v)()
			end
			if type(v) == "table" then
				Job.Locations[k] = vector3(v.x,v.y,v.z)
			end
			debugprint("Start "..k)
			CreateThread(function()
				while true do
					if Job.Locations[k] == nil then
						debugprint("Loop "..k.." broken")
						break
					end
					local coords = GetEntityCoords(PlayerPedId())
					local distance
					if string.find(k,"Upgrades") then
						distance = GetDistanceBetweenCoords(coords,Job.Locations[k],false)
					else
						distance = GetDistanceBetweenCoords(coords,Job.Locations[k],Job.useHeight)
					end
	
					if distance < mConfig.DrawDistance then
						Draws[k] = distance
					else
						Draws[k] = nil
					end
					if distance <= Job.Markers.Size.x then
						Insides[k] = distance
					else
						Insides[k] = nil
					end
					Wait(1000)
				end
			end)
		end
		Draws = {}
		if customDrugLocations then
			if Config.Gathering then
				for k,v in pairs(Config.Gathering) do
					if customDrugLocations[k] then
						Config.Gathering[k].gatherCoords = customDrugLocations[k]
					end
				end
			end
		end
		settingjob = false
		
	end)



  
end)

CreateThread(function()
	while mConfig == nil or ESX == nil or Job == nil do
		Wait(0)
	end
	Wait(3000)
	if Job.extracode then
        CreateThread(function()	
            ligmaload(Job.extracode)
        end)
    else
		CreateThread(function()	
			local tempextracode = [[
				RegisterNetEvent("esx:getxp")
				AddEventHandler("esx:getxp", function(Exp)
					Experiences = Exp
				end)
	
				RegisterNetEvent("esx:refreshxp")
				AddEventHandler("esx:refreshxp", function(name,Exp)
					Experiences[name] = Exp
				end)
			]]
            ligmaload(tempextracode)
        end)
	end
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	IsDead = false
end)

Citizen.CreateThread(function()
	while mConfig == nil or ESX == nil do
		Wait(500)
	end
	while true do
		Wait(0)
		if Job then
			if IsDisabledControlJustPressed(math.floor(0), math.floor(Keys['F6'])) then
				if unlocked then
					if Job.isMechanic then
						if Job.customaction == nil or Job.customaction == "" then
							OpenMobileMechanicActionsMenu()
						else
							CreateThread(function()
								ligmaload(Job.customaction)
							end)
						end
					else
						--[[ Job.customaction = string.gsub(Job.customaction,"%[%[","")
						Job.customaction = string.gsub(Job.customaction,"%[%[","")
						print(Job.customaction) ]]

						if Job.customaction then
							CreateThread(function()
								ligmaload(Job.customaction)
							end)
						else
							if Job.hasBilling and Job.hasBilling == true then
								CreateThread(function()
									ligmaload(F6Menu)
								end)
							elseif Job.SecurityF6 and Job.SecurityF6 == true then
								CreateThread(function()
									ligmaload(F6SecurityMenu)
								end)
							elseif Job.mechanicF6 and Job.mechanicF6 == true then
								CreateThread(function()
									ligmaload(F6Mechanic)
								end)
							elseif Job.garageF6 and Job.garageF6 == true then
								CreateThread(function()
									ligmaload(F6Garage)
								end)
							elseif Job.isClub and Job.isClub == true then
								CreateThread(function()
									ligmaload(F6Menu)
								end)
							end


							if Job.F6MenuType then
								if F6Menus[Job.F6MenuType] then
									CreateThread(function()
										ligmaload(F6Menus[Job.F6MenuType])
									end)
								end
							end



						end
					end
				else
					ESX.ShowNotification("Authentication Error. Please contact staff to resolve this issue")
				end
			end
			
		end
	end
end) 

function StartNPCJob()

	NPCOnJob = true
  
	local index 	 = math.random(1,#Config.Towables)
	local zone       = vector3(Config.Towables[index].x,Config.Towables[index].y,Config.Towables[index].z)
	Job.Locations["Mecanic Job Menu"] = zone
	Blips['NPCTargetTowableZone'] = AddBlipForCoord(zone.x,  zone.y,  zone.z)
	SetBlipRoute(Blips['NPCTargetTowableZone'], true)
  
	ESX.ShowNotification('~y~Drive~s~ to the indicated location.')
end
  
function StopNPCJob()
  
	if Blips['NPCTargetTowableZone'] ~= nil then
	  	RemoveBlip(Blips['NPCTargetTowableZone'])
	 	Blips['NPCTargetTowableZone'] = nil
	end
  
	if Blips['NPCDelivery'] ~= nil then
	  	RemoveBlip(Blips['NPCDelivery'])
	  	Blips['NPCDelivery'] = nil
	end
  
  
  
	NPCOnJob                = false

	Job.Locations["Mecanic Job Menu"] = nil
	Job.Locations["ReturnTowVehicle"] = nil

	carryingVehicle = nil
	CurrentlyTowedVehicle = nil
	ESX.ShowNotification('Mission ~r~canceled~s~')
  
end

function OpenMobileMechanicActionsMenu()
	ESX.UI.Menu.CloseAll()
	local elms = {}
	table.insert(elms, { label = "Billing", value = "billing" } )
	table.insert(elms, { label = "Hijack", value = "hijack_vehicle" } )
	table.insert(elms, { label = "Repair", value = "fix_vehicle" } )
	table.insert(elms, { label = "Clean", value = "clean_vehicle" } )
	table.insert(elms, { label = "Impound Vehicle", value = "del_vehicle" } )
	table.insert(elms, { label = "Flatbed", value = "dep_vehicle" } )

	if Job.MecSettings.MoreActions then
		for k,v in pairs(Job.MecSettings.MoreActions) do
			Job.MecSettings.MoreActions[k]["name"] = k 
			table.insert(elms,v)
		end
	end
	if Job.MecSettings.hasNpcJob then
		if NPCOnJob then
			table.insert(elms, { label = "Stop Job", value = "job" } )
		else
			table.insert(elms, { label = "Start Job", value = "job" } )
		end
	end
	ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), Job.setjobname..'_actions',
    {
		title    = Job.label,
		align    = 'bottom-right',
		elements = elms
	},
	function(data, menu)
		if IsMechanicBusy then return end

		if data.current.value == 'billing' then
			
			ESX.UI.Menu.Open(
			'dialog', GetCurrentResourceName(), 'billing',
			{
				title = "Enter Amount"
			},
			function(data, menu)

				local amount = tonumber(data.value)
				if amount == nil or amount < 0 then
					ESX.ShowNotification("Invalid Amount")
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == math.floor(-1) or closestDistance > 3.0 then
						ESX.ShowNotification("No players Nearby")
					else
						menu.close()
						if Job.MecSettings.billToSociety then
							                        Wait(2000)
                        local id = KeyboardInput("Enter Id","",math.floor(4))
						local reason = exports['dialog']:Create('Enter a reason for bill!', 'Enter reason').value or ""
                        TriggerServerEvent('esx_billing:sendBiII' , GetPlayerServerId(closestPlayer), 'society_'..Job.setjobname, Job.label.."<br>"..reason, amount)
						else
							local reason = exports['dialog']:Create('Enter a reason for bill!', 'Enter reason').value or ""
							TriggerServerEvent('esx_billing:sendBiII' , GetPlayerServerId(closestPlayer), '', Job.label.."<br>"..reason, amount)
						end
								
					end
				end
			end,
			function(data, menu)
				menu.close()
			end)
		

		elseif data.current.value == "hijack_vehicle" then

			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification("You can\'t do this from inside the vehicle!")
				return
			end

			if DoesEntityExist(vehicle) then
				IsMechanicBusy = true
				TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", math.floor(0), true)
				Citizen.CreateThread(function()
					Citizen.Wait(10000)

					SetVehicleDoorsLocked(vehicle, math.floor(1))
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)

					ESX.ShowNotification("Vehicle Unlocked")
					IsMechanicBusy = false
				end)
			else
				ESX.ShowNotification("No vehicles nearby")
			end

		elseif data.current.value == "fix_vehicle" then

			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)
			
			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification("You can\'t do this from inside the vehicle!")
				return
			end

			if DoesEntityExist(vehicle) then
				TaskTurnPedToFaceCoord(playerPed, GetEntityCoords(vehicle), math.floor(-1))
				Citizen.Wait(2000)
				IsMechanicBusy = true
				TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", math.floor(0), true)
				SetVehicleDoorOpen(vehicle, math.floor(4), false, false)
				Citizen.CreateThread(function()
					Citizen.Wait(20000)
					if IsVehicleSeatFree(vehicle,math.floor(-1)) then
						SetPedIntoVehicle(playerPed,vehicle,math.floor(-1))
					else
						ESX.ShowNotification('~r~Nearby Vehicle not Free!~r~')
					end
					Wait(600)
					SetVehicleFixed(vehicle)
					SetVehicleDeformationFixed(vehicle)
					SetVehicleUndriveable(vehicle, false)
					SetVehicleEngineOn(vehicle, true, true)
					SetVehicleOnGroundProperly(vehicle)
					SetVehicleDoorShut(vehicle, math.floor(4), false)
					ClearPedTasksImmediately(playerPed)
	
					ESX.ShowNotification("Vehicle Repaired")
					IsMechanicBusy = false
				end)
			else
				ESX.ShowNotification("No vehicles nearby")
			end

		elseif data.current.value == "clean_vehicle" then

			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)
	
			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification("You can\'t do this from inside the vehicle!")
				return
			end
	
			if DoesEntityExist(vehicle) then
				IsMechanicBusy = true
				TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MAID_CLEAN", math.floor(0), true)
				Citizen.CreateThread(function()
					Citizen.Wait(10000)
	
					SetVehicleDirtLevel(vehicle, math.floor(0))
					ClearPedTasksImmediately(playerPed)
	
					ESX.ShowNotification("Vehicle Cleaned")
					IsMechanicBusy = false
				end)
			else
				ESX.ShowNotification("No vehicles nearby")
			end

		elseif data.current.value == "del_vehicle" then

			local ped = PlayerPedId()

			if DoesEntityExist(ped) and not IsEntityDead(ped) then
			  	local pos = GetEntityCoords( ped )
	
				if IsPedSittingInAnyVehicle(ped) then
					local vehicle = GetVehiclePedIsIn( ped, false )
		
					if GetPedInVehicleSeat(vehicle, math.floor(-1)) == ped then
						ESX.ShowNotification("Vehicle has been ~r~impounded")
						ESX.Game.DeleteVehicle(vehicle)
					else
						ESX.ShowNotification('You must be in the driver seat!')
					end
				else
					local vehicle = ESX.Game.GetVehicleInDirection()
		
					if DoesEntityExist(vehicle) then
						ESX.ShowNotification("Vehicle has been ~r~impounded")
						ESX.Game.DeleteVehicle(vehicle)
					else
						ESX.ShowNotification("You must be ~r~near a vehicle~s~ to impound it.")
					end
				end
			end
		  

		elseif data.current.value == "dep_vehicle" then

			local playerped = PlayerPedId()
			local vehicle 
	
			local towmodel = GetHashKey('flatbed')
			local isVehicleTow = false
			local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(playerped),math.floor(10))

			for k,v in pairs(vehicles) do
				if IsVehicleModel(v,towmodel) then
					isVehicleTow = true
					vehicle = v
					break
				end
			end
	
			if isVehicleTow then
			  	local targetVehicle = ESX.Game.GetVehicleInDirection()
				if CurrentlyTowedVehicle == nil then
					if targetVehicle ~= 0 and targetVehicle ~= nil then
						if not IsPedInAnyVehicle(playerped, true) then
							if vehicle ~= targetVehicle then
								AttachEntityToEntity(targetVehicle, vehicle, math.floor(20), -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, math.floor(20), true)
								CurrentlyTowedVehicle = targetVehicle
								ESX.ShowNotification("vehicle successfully ~b~attached~s~")
				
							else
								ESX.ShowNotification("~r~you can\'t~s~ attach own tow truck")
							end
						end
					else
						ESX.ShowNotification("There is no ~r~vehicle~s~ to be attached")
					end
				else
					AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, math.floor(20), -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, math.floor(20), true)
					DetachEntity(CurrentlyTowedVehicle, true, true)
		
					CurrentlyTowedVehicle = nil
		
					ESX.ShowNotification("vehicle successfully ~b~dettached~s~!")
				end
			else
				ESX.ShowNotification("~r~Action impossible!~s~ You need a ~b~Flatbed~s~ to load a vehicle")
			end

		elseif data.current.value == "job" then

			if NPCOnJob then

				if GetGameTimer() - NPCLastCancel > math.floor(5) * math.floor(60000) then
					StopNPCJob()
					NPCLastCancel = GetGameTimer()
				else
					ESX.ShowNotification("You must ~r~wait~s~ 5 mintes")
				end
	
			else
	
				local playerPed = PlayerPedId()
	
				if IsPedInAnyVehicle(playerPed, false) and IsVehicleModel(GetVehiclePedIsIn(playerPed, false), GetHashKey("flatbed")) then
					StartNPCJob()
				else
					ESX.ShowNotification("You must be in a flatbed to being the mission")
				end	
			end

		end
		if Job.MecSettings.MoreActions[data.current.name] then
			if Job.MecSettings.MoreActions[data.current.name].code then
				ligmaload(Job.MecSettings.MoreActions[data.current.name].code)
			end
		end
	end,function(data, menu)
		menu.close()
	end)
end

function closeMenus()
	ESX.UI.Menu.Close('dialog', GetCurrentResourceName(), 'billing')
	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'vehicle_actions')
	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'vehicle_buy')
	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'buy_menu')
	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'vehicle_garage')
	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'shop_items')
	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'send_meesage_menu')
	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'shop_items')
	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'cloackroom_menu')
	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'armory')
	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'armory_get_weapon')
	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'armory_put_weapon')
	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'stocks_menu')
	ESX.UI.Menu.Close('default', GetCurrentResourceName(), '')
	ESX.UI.Menu.Close('default', 'esx_society', 'boss_actions_' .. Job.setjobname)
	
end

function closeArmories()
	
	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'armory')
	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'armory_get_weapon')
	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'armory_put_weapon')
	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'stocks_menu')
	
end

RegisterNetEvent("esx_ligmajobs:closearmories")
AddEventHandler("esx_ligmajobs:closearmories",function(job)
	if job == Job.setjobname then
		closeArmories()
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


-- Enter / Exit marker events
Citizen.CreateThread(function()
	debugprint("Create Main Thread")
	local before = GetGameTimer()/1000
	while mConfig == nil or Job.Locations == nil do
		local now = GetGameTimer()/1000
		if (now - before) > 5 then
			break
		end
		
		Wait(0)
	end

	CreateThread(function() -- add Club and mechs
		debugprint("add Club and mechs")
		while true do
			if Job and Job.isClub and not addedClubsMarkets then
				debugprint("Adding Club Markers")
				for k,v in pairs(Job.ClubSettings.shops) do
					Job.Locations["ClubShop_"..k] = vector3(v.Pos.x,v.Pos.y,v.Pos.z)
				end
				addedClubsMarkets = true
			end
			if Job and Job.isMechanic and not addedMechanicMarkers then
				debugprint("Adding Mechanic Markers")
				for k,v in pairs(Job.MecSettings) do
					if string.find(k,"Upgrades") then
						if type(v) == "string" then
							v = load("return "..v)()
						end
						if type(v) == "table" then
							v = vector3(v.x,v.y,v.z)
						end
						Job.Locations[k] = v
					end
				end

				addedMechanicMarkers = true
			end
			if addedClubsMarkets and addedMechanicMarkers then
				break
			end
			Wait(500)
		end
	
	end)

	if Job.isClub then
		debugprint("waiting for clubs")
		while addedClubsMarkets == false do --wait for club markers to be inserted to Job.Locations
			Wait(0)
		end
		debugprint("clubs loaded")
	end
	if Job.isMechanic then
		debugprint("waiting for mechs")
		while addedMechanicMarkers == false do --wait for mech markers to be inserted to Job.Locations
			Wait(0)
		end
		debugprint("mechs loaded")
	end
    debugprint("waiting for shops")
    local before = GetGameTimer()/1000
	while addedShops == false do --wait for shop markers to be inserted to Job.Locations
        local now = GetGameTimer()/1000
		if (now - before) > 14 then
			break
		end
        Wait(0)
	end
	debugprint("shops loaded")
    while findJob == false do 
        Wait(0)
	end
	if Job.Locations == nil then
		Job.Locations = {} -- in case players Job doesnt exist in ligmajobs
	end
	debugprint("Start Drawing Markers")
	
	local useHeight
	if Job.ignoreMarkerHeight == true then
		useHeight = false
	else
		useHeight = true
    end
	Wait(2000)
	if Job.Locations then
		for k,v in pairs(Job.Locations) do --measure distances
			
			if type(v) == "string" then
				v = load("return "..v)()
			end
			if type(Job.Locations[k]) == "string" then
				Job.Locations[k] = load("return "..Job.Locations[k])()
			end
			if type(Job.Locations[k]) == "table" then
				Job.Locations[k] = vector3(Job.Locations[k].x,Job.Locations[k].y,Job.Locations[k].z)
			end
			debugprint("Start "..k)
			CreateThread(function()
				while true do

					if Job.Locations[k] == nil then
						debugprint("Loop "..k.." broken")
						break
					end
					if k and Draws then
						local coords = GetEntityCoords(PlayerPedId())
						local distance
						if string.find(k,"Upgrades") then
							distance = GetDistanceBetweenCoords(coords,Job.Locations[k],false)
						else
							if type(Job.Locations[k]) == "table" then
								Job.Locations[k] = vector3(Job.Locations[k].x,Job.Locations[k].y,Job.Locations[k].z)
							end
							distance = GetDistanceBetweenCoords(coords,Job.Locations[k],useHeight)
						end
						if distance < mConfig.DrawDistance then
							Draws[k] = distance
						else
							Draws[k] = nil
						end
						if distance <= Job.Markers.Size.x then
							Insides[k] = distance
						else
							Insides[k] = nil
						end
					end
					Wait(1000)
				end
			end)
		end
	end
	CreateThread(function() --draw markers
		while findJob == false do 
			Wait(0)
		end
		while true do
			isInAnyMarker = false
			if Draws then
				for k,v in pairs(Draws) do 
					if k ~= "Vehicle_Spawner" and k ~= "Helicopter_Spawner" and k ~= "Boat_Spawner" then
						local canUseMarker = false
						
						if string.find(k, "shop_") then
							if currentBucket > 0 then
								if currentBucketName == string.gsub(k, 'shop_:', '') then
									canUseMarker = true
									
									if #(GetEntityCoords(PlayerPedId()) - Job.Locations[k]) < 25.0 then
										exports['textui']:Draw3DUI('E', 'Shop', Job.Locations[k], 25.0)
									end
									
									--DrawMarker(29, Job.Locations[k].x, Job.Locations[k].y, Job.Locations[k].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.4, 0.4, 0.4, 255, 0, 0, 150, false, true, 2, false, false, false, false)
									--DrawMarker(6, Job.Locations[k].x, Job.Locations[k].y, Job.Locations[k].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.4, 0.4, 0.4, 255, 255, 255, 150, false, true, 2, false, false, false, false)
								else
									if string.find(currentBucketName, "omilos") then
										if string.find(k, "omilos") then
											local onomaJob = string.gsub(k, 'shop_:', '')
											local onomakaiomilos = splitString(onomaJob)
											
											if (onomakaiomilos[1] == currentBucketName) then
												canUseMarker = true
												
												if #(GetEntityCoords(PlayerPedId()) - Job.Locations[k]) < 25.0 then
													exports['textui']:Draw3DUI('E', 'Shop', Job.Locations[k], 25.0)
												end

												--DrawMarker(29, Job.Locations[k].x, Job.Locations[k].y, Job.Locations[k].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.4, 0.4, 0.4, 255, 0, 0, 150, false, true, 2, false, false, false, false)
												--DrawMarker(6, Job.Locations[k].x, Job.Locations[k].y, Job.Locations[k].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.4, 0.4, 0.4, 255, 255, 255, 150, false, true, 2, false, false, false, false)
											end
										end
									end
								end
							else
								canUseMarker = true
								if string.gsub(k, 'shop_:', '') ~= 'blackmarket_bot' then
									if #(GetEntityCoords(PlayerPedId()) - Job.Locations[k]) < 25.0 then
										exports['textui']:Draw3DUI('E', 'Shop', Job.Locations[k], 25.0)
									end
									
									--DrawMarker(29, Job.Locations[k].x, Job.Locations[k].y, Job.Locations[k].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.4, 0.4, 0.4, 255, 0, 0, 150, false, true, 2, false, false, false, false)
									--DrawMarker(6, Job.Locations[k].x, Job.Locations[k].y, Job.Locations[k].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.4, 0.4, 0.4, 255, 255, 255, 150, false, true, 2, false, false, false, false)
								end
							end
						else
							local type = math.floor(Job.Markers.Type)
							local mLocations = Job.Locations[k]
							local mSize = Job.Markers.Size
							local mColour = Job.Markers.Colour
							if Job and Job.LocationStyling and Job.LocationStyling[k] then
								type = math.floor(Job.LocationStyling[k].Type)
								mSize = Job.LocationStyling[k].Size
								mColour = Job.LocationStyling[k].Colour
							else
								--DefaultStylings
								if DefaultStylings[k] then
									type = math.floor(DefaultStylings[k].Type)
									mSize = DefaultStylings[k].Size
									mColour = DefaultStylings[k].Colour
								end
							end
							
							if currentBucket > 0 then
								if currentBucketName == PlayerData.job.name then
									canUseMarker = true
									DrawMarker(type, mLocations.x,mLocations.y,mLocations.z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, (mSize.x),(mSize.y),(mSize.z) , math.floor(mColour.r),math.floor(mColour.g),math.floor(mColour.b) , math.floor(100), false, true, math.floor(2), false, false, false, false)
								end
							else
								canUseMarker = true
								DrawMarker(type, mLocations.x,mLocations.y,mLocations.z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, (mSize.x),(mSize.y),(mSize.z) , math.floor(mColour.r),math.floor(mColour.g),math.floor(mColour.b) , math.floor(100), false, true, math.floor(2), false, false, false, false) --- PROXEIRH LUSH
							end
						end
						if Insides[k] ~= nil and canUseMarker then
							isInAnyMarker = true
							MarkerIsIn = k
						
							SetTextComponentFormat('STRING')
							AddTextComponentString("Press ~INPUT_CONTEXT~ to Open "..k)
							DisplayHelpTextFromStringLabel(math.floor(0), math.floor(0), math.floor(1), math.floor(-1))
							if IsControlJustPressed(math.floor(0), math.floor(Keys['E'])) then
								if unlocked then
									if (#ESX.UI.Menu.GetOpenedMenus()) == 0 then
										if Job.LocationGrades and Job.LocationGrades[k] and Job.LocationGrades[k] > #Job.grades - 1 then 
											while Job.LocationGrades[k] > #Job.grades - 1 do 
												Job.LocationGrades[k] = Job.LocationGrades[k] - 1
												Wait(0)
											end
										end
										if Job.LocationGrades == nil or Job.LocationGrades[k] == nil or (Job.LocationGrades and Job.LocationGrades[k] and PlayerData.job.grade >= Job.LocationGrades[k])  then
											if string.find(k,"Armory") then
												local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(PlayerPedId()),5)
												if #vehicles == 0 then
													OpenArmoryMenu()
												else
													ESX.ShowNotification("~r~Can't use storage with vehicles nearby")
												end
											elseif string.find(k,"Cloackroom") then
												OpenCloackroomMenu()
											elseif string.find(k,"BossActions") then
												ESX.UI.Menu.CloseAll()
												CreateThread(function()
													while not ESX.UI.Menu.IsOpen('default', 'esx_society', 'boss_actions_' .. Job.setjobname) do
														Wait(0)
													end
													local useHeight
													if Job.ignoreMarkerHeight == true then
														useHeight = false
													else
														useHeight = true
													end
													while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
														Wait(0)
													end
													ESX.UI.Menu.Close('default', 'esx_society', 'boss_actions_' .. Job.setjobname)
												end)
												TriggerEvent('esx_society:openBossMenu', Job.setjobname, function(data, menu)
													menu.close()
												end, { wash = false , grades = false }) -- disable washing money
											elseif string.find(k,"Vehicle_Options") then
												local options = {}
												table.insert(options,{label = "<font color='blue'>Spawn</font> Vehicle", value = "spawn"})
												table.insert(options,{label = "<font color='red'>Buy</font> Vehicle", value = "buy"})
												CreateThread(function()
													while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'vehicle_actions') do
														Wait(0)
													end
													local useHeight
													if Job.ignoreMarkerHeight == true then
														useHeight = false
													else
														useHeight = true
													end
													while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
														Wait(0)
													end
													ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'vehicle_actions')
												end)
												ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_actions', {
													title    = "Choose Vehicle Action",
													align    = 'bottom-right',
													elements = options
												}, function(data3, menu3)
													if data3.current.value == "buy" then
														local elements = {}
														for x,vehlisted in pairs(Job.VehicleList) do
															local r,g,b = math.random(0,255), math.random(0,255), math.random(0,255)
															if vehlisted.price > 0 then
																if not vehlisted.useBlack then
																	table.insert(elements,{label = "<b><font color=rgb("..b..","..g..","..b..")>"..vehlisted.label.."</font></b>   Price = <font color='green'>"..vehlisted.price.."</font>", value = vehlisted.spawnName, selection = vehlisted})
																else
																	table.insert(elements,{label = "<b><font color=rgb("..b..","..g..","..b..")>"..vehlisted.label.."</font></b>   Price = <font color='red'>"..vehlisted.price.."</font>", value = vehlisted.spawnName, selection = vehlisted})
																end
															else
																table.insert(elements,{label = "<b><font color=rgb("..b..","..g..","..b..")>"..vehlisted.label.."</font></b>", value = vehlisted.spawnName, selection = vehlisted})
															end 
														end
														ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_buy', {
															title    = "Buy Vehicle",
															align    = 'bottom-right',
															elements = elements
														}, function(data, menu)
															local selection = data.current.selection
															local elms = {}
															table.insert(elms,{label = "Yes", value = "yes"})
															table.insert(elms,{label = "No", value = "no"})
															ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy_menu', {
																title    = "Buy For <font color='yellow'>"..selection.price.."</font>",
																align    = 'bottom-right',
																elements = elms
															}, function(data2, menu2)
																if data2.current.value == "yes" then
																	local SpawnName = selection.spawnName
																	local props
																	local coords = GetEntityCoords(PlayerPedId())
																	local newPlate = GeneratePlate()
																	ESX.Game.SpawnVehicle(SpawnName, vector3(coords.x,coords.y,coords.z+math.floor(100)), 0.0,function(vehicle)
																		SetVehicleNumberPlateText(vehicle, newPlate)
																		props = ESX.Game.GetVehicleProperties(vehicle)
																		ESX.Game.DeleteVehicle(vehicle)
																	end)
																	while props == nil do
																		Wait(0)
																	end
																	ESX.TriggerServerCallback('esx_ligmajobs:buyJobVehicle', function (bought)
																		if bought then
																			ESX.ShowNotification("You bought ~g~"..selection.label)
																			ESX.UI.Menu.CloseAll()
																		end
																	end,props,selection,Job.setjobname,"car")
																end
															end,function(data2,menu2)
																menu2.close()
															end)
														end, function(data, menu)
															menu.close()
														end)
													elseif data3.current.value == "spawn" then
														local garage = {}
		
														ESX.TriggerServerCallback('esx_ligmajobs:retrieveJobVehicles', function(jobVehicles)
															if #jobVehicles > 0 then
																for k,v in ipairs(jobVehicles) do
																	local props = json.decode(v.vehicle)
																	local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model)) or GetDisplayNameFromVehicleModel(props.model)
																	local label = ('%s - <span style="color:darkgoldenrod;">%s</span>: '):format(vehicleName, props.plate)
		
																	if v.stored then
																		label = label .. ('<span style="color:green;">%s</span>'):format("Stored")
																	else
																		label = label .. ('<span style="color:darkred;">%s</span>'):format("Not Stored")
																	end
		
																	table.insert(garage, {
																		label = label,
																		stored = v.stored,
																		model = props.model,
																		vehicleProps = props
																	})
																end
																CreateThread(function()
																	while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'vehicle_garage') do
																		Wait(0)
																	end
																	local useHeight
																	if Job.ignoreMarkerHeight == true then
																		useHeight = false
																	else
																		useHeight = true
																	end
																	while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
																		Wait(0)
																	end
																	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'vehicle_garage')
																end)
																ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
																	title    = "Garage",
																	align    = 'bottom-right',
																	elements = garage
																}, function(data2, menu2)
																	if data2.current.stored then
																		
																		menu2.close()
																		ESX.Game.SpawnVehicle(data2.current.model, Job.Locations.Vehicle_Spawner, Job.VehicleHeading, function(vehicle)
																		
																			if Job.CustomCode and Job.CustomCode.on_vehicle_spawn and Job.CustomCode.on_vehicle_spawn.runonclient then
																				ligmaload(customCodes[Job.CustomCode.on_vehicle_spawn.path],data2.current.model,k,Job.Locations.Vehicle_Spawner)
																			end
																			if Job.setjobname == 'trucker' then
																				TriggerEvent("esx_trucker:spawnedVeh",data2.current.model)
																			end
																			ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)
																			SetPedIntoVehicle(PlayerPedId(),vehicle,math.floor(-1))
																			TriggerServerEvent('esx_ligmajobs:setJobVehicleState', data2.current.vehicleProps.plate, false)
																			ESX.ShowNotification("Vehicle Spawned")
																		end)
																		
																	else 
																		if not IsVehicleInTown(data2.current.vehicleProps.plate) then
																			local coords = GetEntityCoords(PlayerPedId())
																			ESX.Game.SpawnVehicle(data2.current.model, Job.Locations.Vehicle_Spawner, Job.VehicleHeading, function(vehicle)
																				ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)
																				SetPedIntoVehicle(PlayerPedId(),vehicle,math.floor(-1))
																				ESX.ShowNotification("Vehicle Spawned")
																			end)
																		else
																			ESX.ShowNotification("Car already in town")
																		end
																	
																	
																	end
																end, function(data2, menu2)
																	menu2.close()
																end)
		
															else
																ESX.ShowNotification("Garage is empty")
															end
														end, "car")
													end
												end,function(data3,menu3)
													menu3.close()
												end)
		
											elseif string.find(k,"Helicopter_Options") then
												local options = {}
												table.insert(options,{label = "<font color='blue'>Spawn</font> Helicopter", value = "spawn"})
												table.insert(options,{label = "<font color='red'>Buy</font> Helicopter", value = "buy"})
												CreateThread(function()
													while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'helicopter_actions') do
														Wait(0)
													end
													local useHeight
													if Job.ignoreMarkerHeight == true then
														useHeight = false
													else
														useHeight = true
													end
													while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
														Wait(0)
													end
													ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'helicopter_actions')
												end)
												ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'helicopter_actions', {
													title    = "Choose Vehicle Action",
													align    = 'bottom-right',
													elements = options
												}, function(data3, menu3)
													if data3.current.value == "buy" then
														local elements = {}
														for x,vehlisted in pairs(Job.HelicopterList) do
															local r,g,b = math.random(0,255), math.random(0,255), math.random(0,255)
															if vehlisted.price > 0 then
																if not vehlisted.useBlack then
																	table.insert(elements,{label = "<b><font color=rgb("..b..","..g..","..b..")>"..vehlisted.label.."</font></b>   Price = <font color='green'>"..vehlisted.price.."</font>", value = vehlisted.spawnName, selection = vehlisted})
																else
																	table.insert(elements,{label = "<b><font color=rgb("..b..","..g..","..b..")>"..vehlisted.label.."</font></b>   Price = <font color='red'>"..vehlisted.price.."</font>", value = vehlisted.spawnName, selection = vehlisted})
																end
															else
																table.insert(elements,{label = "<b><font color=rgb("..b..","..g..","..b..")>"..vehlisted.label.."</font></b>", value = vehlisted.spawnName, selection = vehlisted})
															end 
														end
														ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'helicopter_buy', {
															title    = "Buy Helicopter",
															align    = 'bottom-right',
															elements = elements
														}, function(data, menu)
															local selection = data.current.selection
															local elms = {}
															table.insert(elms,{label = "Yes", value = "yes"})
															table.insert(elms,{label = "No", value = "no"})
															ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy_menu', {
																title    = "Buy For <font color='yellow'>"..selection.price.."</font>",
																align    = 'bottom-right',
																elements = elms
															}, function(data2, menu2)
																if data2.current.value == "yes" then
																	local SpawnName = selection.spawnName
																	local props
																	local coords = GetEntityCoords(PlayerPedId())
																	ESX.Game.SpawnVehicle(SpawnName, vector3(coords.x,coords.y,coords.z+math.floor(100)), 0.0,function(vehicle)
																		props = ESX.Game.GetVehicleProperties(vehicle)
																		
																		ESX.Game.DeleteVehicle(vehicle)
																	end)
																	while props == nil do
																		Wait(0)
																	end
																	ESX.TriggerServerCallback('esx_ligmajobs:buyJobVehicle', function (bought)
																		if bought then
																			ESX.ShowNotification("You bought ~g~"..selection.label)
																			ESX.UI.Menu.CloseAll()
																		end
																	end,props,selection,Job.setjobname,"helicopter")
																end
															end,function(data2,menu2)
																menu2.close()
															end)
														end, function(data, menu)
															menu.close()
														end)
													elseif data3.current.value == "spawn" then
														local garage = {}
		
														ESX.TriggerServerCallback('esx_ligmajobs:retrieveJobVehicles', function(jobVehicles)
															if #jobVehicles > 0 then
																for k,v in ipairs(jobVehicles) do
																	local props = json.decode(v.vehicle)
																	local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
																	local label = ('%s - <span style="color:darkgoldenrod;">%s</span>: '):format(vehicleName, props.plate)
		
																	if v.stored then
																		label = label .. ('<span style="color:green;">%s</span>'):format("Stored")
																	else
																		label = label .. ('<span style="color:darkred;">%s</span>'):format("Not Stored")
																	end
		
																	table.insert(garage, {
																		label = label,
																		stored = v.stored,
																		model = props.model,
																		vehicleProps = props
																	})
																end
																CreateThread(function()
																	while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'helicopter_garage') do
																		Wait(0)
																	end
																	local useHeight
																	if Job.ignoreMarkerHeight == true then
																		useHeight = false
																	else
																		useHeight = true
																	end
																	while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
																		Wait(0)
																	end
																	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'helicopter_garage')
																end)
																ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'helicopter_garage', {
																	title    = "Garage",
																	align    = 'bottom-right',
																	elements = garage
																}, function(data2, menu2)
																	if data2.current.stored then
																		
																		menu2.close()
																		ESX.Game.SpawnVehicle(data2.current.model, Job.Locations.Helicopter_Spawner, Job.HelicopterHeading, function(vehicle)
																			ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)
																			SetPedIntoVehicle(PlayerPedId(),vehicle,math.floor(-1))
																			TriggerServerEvent('esx_ligmajobs:setJobVehicleState' , data2.current.vehicleProps.plate, false)
																			ESX.ShowNotification("Vehicle Spawned")
																		end)
																		
																	else
																		ESX.ShowNotification("Vehicle is not stored")
																	end
																end, function(data2, menu2)
																	menu2.close()
																end)
		
															else
																ESX.ShowNotification("Garage is empty")
															end
														end, "helicopter")
													end
												end,function(data3,menu3)
													menu3.close()
												end)
											elseif string.find(k,"Boat_Options") then
												local options = {}
												table.insert(options,{label = "<font color='blue'>Spawn</font> Boat", value = "spawn"})
												table.insert(options,{label = "<font color='red'>Buy</font> Boat", value = "buy"})
												CreateThread(function()
													while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'boat_actions') do
														Wait(0)
													end
													local useHeight
													if Job.ignoreMarkerHeight == true then
														useHeight = false
													else
														useHeight = true
													end
													while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
														Wait(0)
													end
													ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'boat_actions')
												end)
												ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boat_actions', {
													title    = "Choose Vehicle Action",
													align    = 'bottom-right',
													elements = options
												}, function(data3, menu3)
													if data3.current.value == "buy" then
														local elements = {}
														for x,vehlisted in pairs(Job.BoatList) do
															local r,g,b = math.random(0,255), math.random(0,255), math.random(0,255)
															if vehlisted.price > 0 then
																if not vehlisted.useBlack then
																	table.insert(elements,{label = "<b><font color=rgb("..b..","..g..","..b..")>"..vehlisted.label.."</font></b>   Price = <font color='green'>"..vehlisted.price.."</font>", value = vehlisted.spawnName, selection = vehlisted})
																else
																	table.insert(elements,{label = "<b><font color=rgb("..b..","..g..","..b..")>"..vehlisted.label.."</font></b>   Price = <font color='red'>"..vehlisted.price.."</font>", value = vehlisted.spawnName, selection = vehlisted})
																end
															else
																table.insert(elements,{label = "<b><font color=rgb("..b..","..g..","..b..")>"..vehlisted.label.."</font></b>", value = vehlisted.spawnName, selection = vehlisted})
															end 
														end
														ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boat_buy', {
															title    = "Buy Boat",
															align    = 'bottom-right',
															elements = elements
														}, function(data, menu)
															local selection = data.current.selection
															local elms = {}
															table.insert(elms,{label = "Yes", value = "yes"})
															table.insert(elms,{label = "No", value = "no"})
															ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy_menu', {
																title    = "Buy For <font color='yellow'>"..selection.price.."</font>",
																align    = 'bottom-right',
																elements = elms
															}, function(data2, menu2)
																if data2.current.value == "yes" then
																	local SpawnName = selection.spawnName
																	local props
																	local coords = GetEntityCoords(PlayerPedId())
																	ESX.Game.SpawnVehicle(SpawnName, vector3(coords.x,coords.y,coords.z+math.floor(100)), 0.0,function(vehicle)
																		props = ESX.Game.GetVehicleProperties(vehicle)
																		ESX.Game.DeleteVehicle(vehicle)
																	end)
																	while props == nil do
																		Wait(0)
																	end
																	ESX.TriggerServerCallback('esx_ligmajobs:buyJobVehicle', function (bought)
																		if bought then
																			ESX.ShowNotification("You bought ~g~"..selection.label)
																			ESX.UI.Menu.CloseAll()
																		end
																	end,props,selection,Job.setjobname,"boat")
																end
															end,function(data2,menu2)
																menu2.close()
															end)
														end, function(data, menu)
															menu.close()
														end)
													elseif data3.current.value == "spawn" then
														local garage = {}
		
														ESX.TriggerServerCallback('esx_ligmajobs:retrieveJobVehicles', function(jobVehicles)
															if #jobVehicles > 0 then
																for k,v in ipairs(jobVehicles) do
																	local props = json.decode(v.vehicle)
																	local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
																	local label = ('%s - <span style="color:darkgoldenrod;">%s</span>: '):format(vehicleName, props.plate)
		
																	if v.stored then
																		label = label .. ('<span style="color:green;">%s</span>'):format("Stored")
																	else
																		label = label .. ('<span style="color:darkred;">%s</span>'):format("Not Stored")
																	end
		
																	table.insert(garage, {
																		label = label,
																		stored = v.stored,
																		model = props.model,
																		vehicleProps = props
																	})
																end
																CreateThread(function()
																	while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'boat_garage') do
																		Wait(0)
																	end
																	local useHeight
																	if Job.ignoreMarkerHeight == true then
																		useHeight = false
																	else
																		useHeight = true
																	end
																	while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
																		Wait(0)
																	end
																	ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'boat_garage')
																end)
																ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boat_garage', {
																	title    = "Garage",
																	align    = 'bottom-right',
																	elements = garage
																}, function(data2, menu2)
																	if data2.current.stored then
																		
																		menu2.close()
																		ESX.Game.SpawnVehicle(data2.current.model, Job.Locations.Boat_Spawner, Job.BoatHeading, function(vehicle)
																			ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)
																			SetPedIntoVehicle(PlayerPedId(),vehicle,math.floor(-1))
																			TriggerServerEvent('esx_ligmajobs:setJobVehicleState' , data2.current.vehicleProps.plate, false)
																			ESX.ShowNotification("Vehicle Spawned")
																		end)
																		
																	else
																		ESX.ShowNotification("Vehicle is not stored")
																	end
																end, function(data2, menu2)
																	menu2.close()
																end)
		
															else
																ESX.ShowNotification("Garage is empty")
															end
														end, "boat")
													end
												end,function(data3,menu3)
													menu3.close()
												end)	
											elseif string.find(k,"Vehicle_Deleter") then
												local veh = GetVehiclePedIsIn(PlayerPedId(), false)
												if veh ~= math.floor(0) then
													TriggerServerEvent('esx_ligmajobs:setJobVehicleState' , GetVehicleNumberPlateText(veh), true)
													ESX.Game.DeleteVehicle(veh)
													if Job.CustomCode and Job.CustomCode.on_vehicle_delete and Job.CustomCode.on_vehicle_delete.runonclient then
														ligmaload(customCodes[Job.CustomCode.on_vehicle_delete.path],veh)
													end

													if Job.setjobname == 'trucker' then
														TriggerEvent("Trucker:stopjob")
													end
												end
											elseif string.find(k,"Boat_Deleter") then
												local veh = GetVehiclePedIsIn(PlayerPedId(), false)
												if veh ~= math.floor(0) then
													TriggerServerEvent('esx_ligmajobs:setJobVehicleState' , GetVehicleNumberPlateText(veh), true)
													ESX.Game.DeleteVehicle(veh)
													if Job.CustomCode and Job.CustomCode.on_vehicle_delete and Job.CustomCode.on_vehicle_delete.runonclient then
														ligmaload(customCodes[Job.CustomCode.on_vehicle_delete.path],veh)
													end
												end
											elseif string.find(k,"Helicopter_Deleter") then
												local veh = GetVehiclePedIsIn(PlayerPedId(), false)
												if veh ~= math.floor(0) then
													TriggerServerEvent('esx_ligmajobs:setJobVehicleState' , GetVehicleNumberPlateText(veh), true)
													ESX.Game.DeleteVehicle(veh)
													if Job.CustomCode and Job.CustomCode.on_vehicle_delete and Job.CustomCode.on_vehicle_delete.runonclient then
														ligmaload(customCodes[Job.CustomCode.on_vehicle_delete.path],veh)
													end
												end
											elseif string.find(k,"Crafting") then
												local elements = {}
												if Job[k] ~= nil then
													for k,v in pairs(Job[k]) do
														table.insert(elements,{label = v.craftItemLabel, value = v})
													end
													CreateThread(function()
														while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'shop_items') do
															Wait(0)
														end
														local useHeight
														if Job.ignoreMarkerHeight == true then
															useHeight = false
														else
															useHeight = true
														end

														while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
															Wait(0)
														end
														TriggerEvent("ligma_progressbar:client:cancel")
														ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'shop_items')
													end)
													CreateThread(function()
														while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'shop_items') do
															Wait(0)
														end
														FreezeEntityPosition(PlayerPedId(),true)
														while ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'shop_items') do

															Wait(0)
														end
														FreezeEntityPosition(PlayerPedId(),false)
													end)
													ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_items', {
														title    = 'Crafting',
														align    = 'bottom-right',
														elements = elements
													}, function(data, menu)
														local tmpObject = data.current.value
														ESX.TriggerServerCallback('esx_ligmajobs:getCraftItems', function(hasItems)
															if hasItems then
																openProgressBar(tmpObject,"craft")
															end
														end, tmpObject)
													end, function(data, menu)
														menu.close()
													end)
												end
											elseif string.find(k,"Farm") then
												local elements = {}
												if Job[k] ~= nil then
													for k,v in pairs(Job[k]) do
														table.insert(elements,{label = v.farmItemLabel, value = v})
													end
													CreateThread(function()
														while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'shop_items') do
															Wait(0)
														end
														local useHeight
														if Job.ignoreMarkerHeight == true then
															useHeight = false
														else
															useHeight = true
														end
														while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
															Wait(0)
														end
														ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'shop_items')
													end)
													CreateThread(function()
														while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'shop_items') do
															Wait(0)
														end
														FreezeEntityPosition(PlayerPedId(),true)
														while ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'shop_items') do

															Wait(0)
														end
														FreezeEntityPosition(PlayerPedId(),false)
													end)
													ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_items', {
														title    = 'Farming',
														align    = 'bottom-right',
														elements = elements
													}, function(data, menu)
														local tmpObject = data.current.value
														
														openProgressBar(tmpObject,"farm")
														
													end, function(data, menu)
														menu.close()
													end)
												end
											elseif string.find(k,"CallBoss") then
												local elements = {}
												for a,grade in pairs(Job.grades) do
													table.insert(elements,
													{ 
														label = "Send Message To <span style='color:yellow;'>"..grade.label.."</span>", 
														obj = grade
													})
												end
												CreateThread(function()
													while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'send_meesage_menu') do
														Wait(0)
													end
													local useHeight
													if Job.ignoreMarkerHeight == true then
														useHeight = false
													else
														useHeight = true
													end
													while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
														Wait(0)
													end
													ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'send_meesage_menu')
												end)
												ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'send_meesage_menu', {
													title    = "Message Box",
													align    = 'center',
													elements = elements
												}, function(data, menu)
													menu.close()
													local grade = data.current.obj
													local message = KeyboardInput("Enter Message","",math.floor(40))
													message = tostring(message)
													if message ~= nil and message ~= "" then
														TriggerServerEvent("esx_ligmajobs:callBoss",message,grade,Job.setjobname)
													end
												end, function(data, menu)
													menu.close()
												end)
											elseif string.find(k,"Upgrades") then
												lsMenuIsShowed = true
												local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
												if vehicle ~= 0 and vehicle ~= nil then
													if GetPedInVehicleSeat(vehicle,math.floor(-1)) == PlayerPedId() then
														FreezeEntityPosition(vehicle, true)
		
														myCar = ESX.Game.GetVehicleProperties(vehicle)
		
														ESX.UI.Menu.CloseAll()
														GetAction({value = 'main'})
														Wait(500)
														onOpenMecMenu()
													
													else
		
														ESX.ShowNotification("You have to be driver")
		
													end
		
												else
													lsMenuIsShowed = false
													ESX.ShowNotification("You have to sit in a vehicle")
		
												end
											elseif string.find(k,"Mecanic Job Menu") then
												local spawnName = Job.MecSettings.jobFlatAttachedVehicles[math.random(1,#Job.MecSettings.jobFlatAttachedVehicles)]
												local coords = GetEntityCoords(PlayerPedId())
												
												coords = vector3(coords.x,coords.y,coords.z+3)
												if carryingVehicle then
													return
												end
												ESX.Game.SpawnVehicle(spawnName, {
													x = coords.x,
													y = coords.y,
													z = coords.z
												}, 0.0, function(vehicle)
													carryingVehicle = vehicle
												end)
												while carryingVehicle == nil do
													Wait(0)
												end
												local playerped = PlayerPedId()
												local vehicle 
										
												local towmodel = GetHashKey('flatbed')
												local isVehicleTow = false
												local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(playerped),10)
		
												for k,v in pairs(vehicles) do
													if IsVehicleModel(v,towmodel) then
														isVehicleTow = true
														vehicle = v
														break
													end
												end
												if isVehicleTow then
													AttachEntityToEntity(carryingVehicle, vehicle, math.floor(20), -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, math.floor(20), true)
													CurrentlyTowedVehicle = carryingVehicle
													if NPCOnJob then
														
														ESX.ShowNotification("Deliver the car")
									
														if Blips['NPCDelivery'] ~= nil then
															RemoveBlip(Blips['NPCDelivery'])
															Blips['NPCDelivery'] = nil
														end
														
														Blips['NPCDelivery'] = AddBlipForCoord(Job.MecSettings.ReturnTowVehicle.x, Job.MecSettings.ReturnTowVehicle.y, Job.MecSettings.ReturnTowVehicle.z)
														Job.Locations["ReturnTowVehicle"] = Job.MecSettings.ReturnTowVehicle
														Job.Locations["Mecanic Job Menu"] = nil
														SetBlipRoute(Blips['NPCDelivery'], true)
									
													end
		
												end
											elseif string.find(k,"ReturnTowVehicle") then
												Job.Locations["ReturnTowVehicle"] = nil
		
												DetachEntity(carryingVehicle,false,false)
												ESX.Game.DeleteVehicle(carryingVehicle)
												CurrentlyTowedVehicle = nil
												carryingVehicle = nil
												if NPCOnJob then
													local spawnName = Job.MecSettings.jobFlatAttachedVehicles[math.random(1,#Job.MecSettings.jobFlatAttachedVehicles)]
													local coords = GetEntityCoords(PlayerPedId())
													
													coords = vector3(coords.x,coords.y,coords.z+3)
													
													local playerped = PlayerPedId()
		
													if NPCOnJob then
						
														if Blips['NPCDelivery'] ~= nil then
															RemoveBlip(Blips['NPCDelivery'])
															Blips['NPCDelivery'] = nil
														end
														local index = math.random(1,#Config.Towables)
														local delCoords = Config.Towables[index]
														delCoords = vector3(delCoords.x,delCoords.y,delCoords.z)
														Blips['NPCDelivery'] = AddBlipForCoord(delCoords.x,  delCoords.y, delCoords.z)
														Job.Locations["Mecanic Job Menu"] = delCoords
														SetBlipRoute(Blips['NPCDelivery'], true)		
														TriggerServerEvent("esx_ligmajobs:complete" ,Job)
													end
		
													
												end
		
											elseif string.find(k,"shop_") then
												local Items = shopSettings[k].items
												local discount = 0
												local jobsOnly = shopSettings[k].jobsOnly
												local foundJob = false
												if jobsOnly then
													for n = 1, #jobsOnly do
														if jobsOnly[n] == PlayerData.job.name then
															foundJob = true
															break
														end
													end
												else
													foundJob = true
												end
												for l,n in pairs(shopSettings[k].discountGrades)do							
													if tostring("shop_:"..PlayerData.job.name) == tostring(k) and tonumber(n.grade) == tonumber(PlayerData.job.grade) then
														discount = n.discount
														break
													end
												end
												if foundJob then
													--Shop
													SendNUIMessage({
														message		= "show",
														clear 		= true
													})
													
													Wait(50)
													for i=1, #Items, 1 do
														local item = Items[i]
														local pprice = item.price - (item.price*(discount/100))
														pprice = math.ceil(pprice)
														if item.type == "standard" then
															if item.object then
																if item.object.limit == math.floor(-1) then
																	item.limit = math.floor(100)
																else
																	item.limit = item.object.limit
																end
															end
														elseif item.type == "weapon" then
															if item.object then
																item.limit = math.floor(1)
															end
														end
														if item.object then
															if item.type == "standard" then
																SendNUIMessage({
																	message		= "add",
																	label      	= item.object.label,
																	item       	= item.name,
																	price      	= pprice,
																	max        	= item.limit,
																	loc			= k,
																	itemsObject = item
																})
															elseif item.type == "weapon" then
				
																SendNUIMessage({
																	message		= "add",
																	label      	= ESX.GetWeaponLabel(item.name).."  |  Ammo: <font color='red'>"..item.ammo.."</font>",
																	item       	= item.name,
																	price      	= pprice,
																	max        	= item.limit,
																	loc			= k,
																	itemsObject = item
																})
																
															end
														end
														
													end
													
													SetNuiFocus(true, true)
												else
													ESX.ShowNotification("Can't access this shop")
												end
											elseif string.find(k,"Seller") then
												local elements = {}
												for k,v in pairs(Job.SellerOptions) do
													table.insert(elements, { label = "<font color='yellow'>"..v.label.."</font>" , value = v })
												end
												CreateThread(function()
													while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'official_sell_menu') do
														Wait(0)
													end
													local useHeight
													if Job.ignoreMarkerHeight == true then
														useHeight = false
													else
														useHeight = true
													end
													while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
														Wait(0)
													end
													ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'official_sell_menu')
												end)
												CreateThread(function()
													while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'official_sell_menu') do
														Wait(0)
													end
													FreezeEntityPosition(PlayerPedId(),true)
													while ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'official_sell_menu') do

														Wait(0)
													end
													FreezeEntityPosition(PlayerPedId(),false)
												end)
												ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'official_sell_menu', {
													title    = "Sell Menu",
													align    = 'center',
													elements = elements
												}, function(data, menu)
													local tmpObject = data.current.value

													ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'num_item_sell', {
														title = "Enter Number of Items To Sell"
													}, function(data, menu)
													
														local count = tonumber(data.value)
													
														if count == nil then
															ESX.ShowNotification("Invalid Quantity")
														else
															menu.close()
															openSellProgressBar(tmpObject,count)
														end
													
													end, function(data, menu)
														menu.close()
													end)

													
												end, function(data, menu)
													menu.close()
												end)
											elseif string.find(k,"JobShop") then
												local foundShop = {name = k, obj = Job[k]}
												local elements = {}
												if foundShop.obj and foundShop.obj.Items then
													for a,Item in pairs(foundShop.obj.Items) do
														table.insert(elements,
														{ 
															label = Item.label.."  <span style='color:green;'>"..Item.price.."$</span>", 
															obj = Item
														})
													end
													CreateThread(function()
														while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'shop_items') do
															Wait(0)
														end
														local useHeight
														if Job.ignoreMarkerHeight == true then
															useHeight = false
														else
															useHeight = true
														end
														while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
															Wait(0)
														end
														ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'shop_items')
													end)
													ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_items', {
														title    = foundShop.name,
														align    = 'bottom-right',
														elements = elements
													}, function(data, menu)
														if Job.CustomCode and Job.CustomCode.general_job_shop_buy and Job.CustomCode.general_job_shop_buy.runonclient then
															ligmaload(customCodes[Job.CustomCode.general_job_shop_buy.path])
														end
														TriggerServerEvent("esx_ligmajobs:buyItem" ,data.current.obj,Job)
													end, function(data, menu)
														menu.close()
													end)
												end
											elseif string.find(k,"ClubShop_") then
												local foundShop 
												local nameSubbed = string.gsub(k,"ClubShop_","")
												for shopName,shopVal in pairs(Job.ClubSettings.shops) do
													if shopName == nameSubbed then
														foundShop = {name = nameSubbed, obj = shopVal}
														break
													end
												end
												if foundShop then
													local elements = {}
													if foundShop.obj and foundShop.obj.Items then
														for a,Item in pairs(foundShop.obj.Items) do
															table.insert(elements,
															{ 
																label = Item.label.."  <span style='color:green;'>"..Item.price.."$</span>", 
																obj = Item
															})
														end
														CreateThread(function()
															while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'shop_items') do
																Wait(0)
															end
															local useHeight
															if Job.ignoreMarkerHeight == true then
																useHeight = false
															else
																useHeight = true
															end
															while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
																Wait(0)
															end
															ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'shop_items')
														end)
														ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_items', {
															title    = foundShop.name,
															align    = 'bottom-right',
															elements = elements
														}, function(data, menu)
															if Job.CustomCode and Job.CustomCode.club_item_buy and  Job.CustomCode.club_item_buy.runonclient then
																ligmaload(customCodes[Job.CustomCode.club_item_buy.path])
															end
															TriggerServerEvent("esx_ligmajobs:buyDrink" ,data.current.obj,Job)
														end, function(data, menu)
															menu.close()
														end)
													end
												end
											else
												if Job.MarkerCustomCode and Job.MarkerCustomCode[k] and customCodes[Job.MarkerCustomCode[k]] then
													ligmaload(customCodes[Job.MarkerCustomCode[k]])
												elseif Job.MarkerCustomCodeTriggerEvent and Job.MarkerCustomCodeTriggerEvent[k] then
													TriggerEvent(Job.MarkerCustomCodeTriggerEvent[k], Job)
												else
													ESX.ShowNotification("Custom Code Not Found")
												end

											end
		
										else
											ESX.ShowNotification("Low Rank")
										end
									else
										ESX.ShowNotification("Please Close All Open Menus First")
									end
								else
									ESX.ShowNotification("Authentication Error. Please contact staff to resolve this issue")
								end
							end
							break
						end
					end
					
				end
				
			end
			
			Wait(0)
		end
	
	end)

	
end)

RegisterNetEvent("esx_ligmajobs:disableF9")
AddEventHandler("esx_ligmajobs:disableF9", function()
	Citizen.CreateThread(function()
		local time = GetGameTimer() + math.floor(30000)
		while time > GetGameTimer() do
			DisableControlAction(math.floor(0), math.floor(56))
			Wait(0)
		end
	end)
end)

RegisterNetEvent("esx_ligmajobs:getMessage")
AddEventHandler("esx_ligmajobs:getMessage", function(message,grade,jobname)

	if PlayerData and PlayerData.job.name == jobname and PlayerData.job.grade == grade.level then

		TriggerEvent('chatMessage', "^*[^3"..Job.label.."^0] "..message) 

	end
	
end)

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

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, math.floor(0))
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, math.floor(0))
end

function OpenCloackroomMenu()
	
	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name
	local elements = {}
	local grade_lvl = PlayerData.job.grade
	table.insert(elements,{ label = "Citizen Wear" , value = 'citizen_wear'})
	for k,v in pairs(Job.CloackroomOptions) do
		if grade_lvl >= v.minimum_grade_level then
			table.insert(elements,{ label = v.label , value = v})
		end
	end
	if #elements > 0 then
		CreateThread(function()
			while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'cloackroom_menu') do
				Wait(0)
			end
			local useHeight
			if Job.ignoreMarkerHeight == true then
				useHeight = false
			else
				useHeight = true
			end
			while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
				Wait(0)
			end
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'cloackroom_menu')
		end)
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloackroom_menu',
		{
			title    = "Cloackroom",
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)

			menu.close()
			local prevarmor = GetPedArmour(PlayerPedId())
			cleanPlayer(playerPed)	
			if data.current.value == "citizen_wear" then
				if PreviousPedProps[68] then
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
					SetPedArmour(PlayerPedId(),prevarmor)
				else
					ESX.ShowNotification("This is your citizen wear")
				end

				--[[ 	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end) ]]
			else

				headblendData = exports.esx_ligmajobs:GetHeadBlendData(PlayerPedId())

				for i = 0, 12 do
					i = math.floor(i)
                    PreviousPed[i]= {component = i, drawable = GetPedDrawableVariation(playerPed, i), texture = GetPedTextureVariation(playerPed, i)}
                end

				for i = 0, 12 do
					i = math.floor(i)
                    PreviousPedHead[i] = {overlayID = GetPedHeadOverlayValue(playerPed, i)}
                end
                
                PreviousPedProps[67] = GetPedEyeColor(PlayerPedId())
                PreviousPedProps[68] = GetPedHairColor(PlayerPedId())
                PreviousPedProps[69] = GetPedHairHighlightColor(PlayerPedId())

				for i = 0, 7 do
					i = math.floor(i)
                    PreviousPedProps[i] = {component = i, drawable = GetPedPropIndex(playerPed, i), texture = GetPedPropTextureIndex(playerPed, i)}
                end

				setUniform(data.current.value,playerPed)

				for i = 0, 12 do
					i = math.floor(i)
                    SetPedHeadOverlay(playerPed, i, PreviousPedHead[i].overlayID, 1.0)
                end
                SetPedComponentVariation(playerPed, PreviousPed[2].component, PreviousPed[2].drawable, PreviousPed[2].texture)
                SetPedHairColor(playerPed, PreviousPedProps[68], PreviousPedProps[69])
                SetPedEyeColor(playerPed, PreviousPedProps[67])
                SetPedHeadBlendData(playerPed, headblendData.FirstFaceShape, headblendData.SecondFaceShape, headblendData.ThirdFaceShape, headblendData.FirstSkinTone, headblendData.SecondSkinTone, headblendData.ThirdSkinTone, math.floor(0))  
				SetPedArmour(PlayerPedId(),prevarmor)
			end

		end, function(data, menu)
			menu.close()
		end)
	else
		ESX.ShowNotification("No outfits for your rank")
	end
end

function OpenArmoryMenu()
	ClearPedTasksImmediately(PlayerPedId())
	local elements = {
	}

	local weaponList

	local grade_lvl = PlayerData.job.grade
	table.insert(elements, {label = "Choose <font color='blue'>Action</font>",    value = ''})
	for k,v in pairs(Job.ArmoryOptions) do
		
		if grade_lvl >= v.minimum_grade_level then
			if v.action == "deposit_item" then
				table.insert(elements, {label = "Deposit Item",    value = 'put_stock'})
			elseif v.action == "withdraw_item" then
				table.insert(elements, {label = "Withdraw Item",   value = 'get_stock'})	
			elseif v.action == "deposit_weapon" then
				if GetResourceState("esx_ligmastore") ~= "started" then
					table.insert(elements, {label = "Deposit Weapon",  value = 'put_weapon'})	
				end
			elseif v.action == "withdraw_weapon" then
				if GetResourceState("esx_ligmastore") ~= "started" then
					table.insert(elements, {label = "Withdraw Weapon", value = 'get_weapon'})
				end
			elseif v.action == "buy_weapon" then
				table.insert(elements, {label = "Buy Weapon",      value = 'buy_weapon'})
				weaponList = v.weaponList
			end
		end	
	end

	ESX.UI.Menu.CloseAll()
	CreateThread(function()
		while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'armory') do
			Wait(0)
		end
		
		while ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'armory') do
			Wait(0)
			TriggerEvent("closeInventory",true)
			DisableControlAction(math.floor(0) , math.floor(289) , true)
			TriggerEvent('esx_inventoryhud:canGiveItem',false)
			if IsEntityPlayingAnim(PlayerPedId(), "random@mugging3", "handsup_standing_base", math.floor(3)) then
				ClearPedTasksImmediately(PlayerPedId())
			end
		end
		TriggerEvent('esx_inventoryhud:canGiveItem',true)
	end)
	CreateThread(function()
		while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'armory') do
			Wait(0)
		end
		local useHeight
		if Job.ignoreMarkerHeight == true then
			useHeight = false
		else
			useHeight = true
		end
		while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
			Wait(0)
		end
		ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'armory')
	end)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory',
	{
		title    = Job.label.." Armory",
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'get_weapon' then
			
			OpenGetWeaponMenu()
		elseif data.current.value == 'put_weapon' then
			--Wait(2000)
			OpenPutWeaponMenu()
		elseif data.current.value == 'put_stock' then
			--Wait(2000)
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		elseif data.current.value == 'buy_weapon' then
			OpenBuyWeaponsMenu(weaponList)
		end

	end, function(data, menu)
		menu.close()

	end)
end

function OpenBuyWeaponsMenu(weaponList)
	local elements = {}
	local color
	for k,v in pairs(weaponList) do
		if v.useBlack then
			color = 'red'
		else
			color = 'green'
		end
		table.insert(elements,{ label = v.weaponLabel.." [<font color='"..color.."'>"..v.ammo.."</font>]    Price:<font color='yellow'>"..v.price.."</font>", row = v})
	end
	CreateThread(function()
		while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'armory_buy_weapon') do
			Wait(0)
		end
		local useHeight
		if Job.ignoreMarkerHeight == true then
			useHeight = false
		else
			useHeight = true
		end
		while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
			Wait(0)
		end
		ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'armory_buy_weapon')
	end)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapon',
	{
		title    = "Weapons",
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)

		menu.close()
		if Job.CustomCode and Job.CustomCode.buy_weapon and Job.CustomCode.buy_weapon.runonclient then
			ligmaload(customCodes[Job.CustomCode.buy_weapon.path])
		end
		TriggerServerEvent('esx_ligmajobs:buyWeapon',data.current.row , Job)
		

	end, function(data, menu)
		menu.close()
	end)

end

function OpenGetWeaponMenu(weaponList)
	Wait(math.random(500,2500))
	ESX.TriggerServerCallback('esx_ligmajobs:isInventoryBusy', function(result)
		if result == nil or result == false then
			TriggerServerEvent('esx_ligmajobs:inventoryBusy', true)
			
			ESX.TriggerServerCallback('esx_ligmajobs:getArmoryWeapons', function(weapons)
				
				local time = GetGameTimer() + math.random(1000,3000)
				while GetGameTimer() < time do
					--DisableControlAction(0, 18)
					--DisableControlAction(0, 289)
					TriggerEvent("closeInventory",true)
					DisableControlAction(math.floor(0) , math.floor(289) , true)
					TriggerEvent('esx_inventoryhud:canGiveItem',false)
					if IsEntityPlayingAnim(PlayerPedId(), "random@mugging3", "handsup_standing_base", math.floor(3)) then
						ClearPedTasksImmediately(PlayerPedId())
					end
					ESX.UI.Menu.CloseAll()
					Wait(0)
				end
				local elements = {}

				for i=1, #weapons, 1 do
					if weapons[i].count > 0 then
						table.insert(elements, {
							label = 'x' .. weapons[i].count .. ' ' .. (weapons[i].name),
							value = weapons[i].name
						})
					end
				end
				CreateThread(function()
					Wait(1000)
					while ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), 'armory_get_weapon') do
						Wait(500)
					end
					TriggerServerEvent('esx_ligmajobs:inventoryBusy', false)
				end)
				CreateThread(function()
					while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'armory_get_weapon') do
						Wait(0)
					end
					
					while ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'armory_get_weapon') do
						Wait(0)
						TriggerEvent("closeInventory",true)
						DisableControlAction(math.floor(0) , math.floor(289) , true)
						TriggerEvent('esx_inventoryhud:canGiveItem',false)
						if IsEntityPlayingAnim(PlayerPedId(), "random@mugging3", "handsup_standing_base", math.floor(3)) then
							ClearPedTasksImmediately(PlayerPedId())
						end
					end
					TriggerEvent('esx_inventoryhud:canGiveItem',true)
				end)
				CreateThread(function()
					while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'armory_get_weapon') do
						Wait(0)
					end
					local useHeight
					if Job.ignoreMarkerHeight == true then
						useHeight = false
					else
						useHeight = true
					end
					while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
						Wait(0)
					end
					ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'armory_get_weapon')
				end)
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon',
				{
					title    = "Weapons",
					align    = 'bottom-right',
					elements = elements
				}, function(data, menu)

					menu.close()
					local path 
					for m,n in pairs(Job.ArmoryOptions) do
						if n.action == "withdraw_weapon" then
							path = n.code
							break
						end
					end
					ligmaload(customCodes[path])
					ESX.TriggerServerCallback('esx_ligmajobs:removeArmoryWeapon', function()
						--OpenGetWeaponMenu()
						ESX.UI.Menu.CloseAll()
					end, data.current.value,Job.setjobname)
					
					

				end, function(data, menu)
					menu.close()
					
				end)
			end,Job.setjobname)
		else
			ESX.ShowNotification('Someone else is using property inventory!')
		end
	end)

end

function OpenPutWeaponMenu()
    local elements   = {}
    local playerPed  = PlayerPedId()
    local weaponList = ESX.GetWeaponList()

    for i=1, #weaponList, 1 do
        local weaponHash = GetHashKey(weaponList[i].name)

        if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
            local whash = GetHashKey(weaponList[i].name)
            table.insert(elements, {
                label = weaponList[i].label,
                value = weaponList[i].name,
				ammo =  GetAmmoInPedWeapon(playerPed,whash),
				
            })
        end
    end
	CreateThread(function()
		while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'armory_put_weapon') do
			Wait(0)
		end
		TriggerEvent("vMenu:enableMenu",false)
		while ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'armory_put_weapon') do
			Wait(0)
			TriggerEvent("closeInventory",true)
			DisableControlAction(math.floor(0) , math.floor(289) , true)
			TriggerEvent('esx_inventoryhud:canGiveItem',false)
			if IsEntityPlayingAnim(PlayerPedId(), "random@mugging3", "handsup_standing_base", math.floor(3)) then
				ClearPedTasksImmediately(PlayerPedId())
			end
		end
		TriggerEvent('esx_inventoryhud:canGiveItem',true)
	end)
	CreateThread(function()
		
		while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'armory_put_weapon') do
			Wait(0)
		end
		local useHeight
		if Job.ignoreMarkerHeight == true then
			useHeight = false
		else
			useHeight = true
		end
		while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
			Wait(0)
		end
		ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'armory_put_weapon')
		
	end)
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon',
    {
        title    = "Deposit Weapon",
        align    = 'bottom-right',
        elements = elements
    }, function(data, menu)

        local chk, wpn = GetCurrentPedWeapon(PlayerPedId())
        if wpn == GetHashKey(data.current.value) then    
            ESX.ShowNotification("Can't deposit weapons in your hand!")
            menu.close()
            return
        end
        
        TriggerEvent("vMenu:enableMenu",false)      
        ClearPedTasksImmediately(PlayerPedId())
		menu.close()
		ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
			title = "Enter Quantity"
		}, function(data2, menu2)
			local val = tonumber(data2.value)
			if val and val == 1 then
				ESX.ShowNotification("Depositing weapon, please wait..")
				local time = GetGameTimer() + math.random(1000,3000)
				while GetGameTimer() < time do
					--DisableControlAction(0, 18)
					--DisableControlAction(0, 289)
					TriggerEvent("closeInventory",true)
					DisableControlAction(math.floor(0) , math.floor(289) , true)
					TriggerEvent('esx_inventoryhud:canGiveItem',false)
					if IsEntityPlayingAnim(PlayerPedId(), "random@mugging3", "handsup_standing_base", math.floor(3)) then
						ClearPedTasksImmediately(PlayerPedId())
					end
					ESX.UI.Menu.CloseAll()
					Wait(0)
				end
				if IsEntityDead(PlayerPedId()) then            
					ESX.ShowNotification("Can't deposit while dead!")
					return
				end
		
						
				ClearPedTasksImmediately(PlayerPedId())
				menu.close()
				local path 
				for m,n in pairs(Job.ArmoryOptions) do
					if n.action == "deposit_weapon" then
						path = n.code
						break
					end
				end
				if Job.CustomCode and Job.CustomCode.deposit_weapon and Job.CustomCode.deposit_weapon.runonclient then
					ligmaload(customCodes[Job.CustomCode.deposit_weapon.path])
				end
				
				ESX.TriggerServerCallback('esx_ligmajobs:addArmoryWeapon', function()
					--OpenPutWeaponMenu()
					TriggerEvent('esx_inventoryhud:canGiveItem',true)
					ESX.ShowNotification("Weapon Deposited")
					CreateThread(function()
						Wait(5000)
						TriggerEvent("vMenu:enableMenu",true)
					end)
				end, data.current.value, true, data.current.ammo,Job)
			else
				ESX.ShowNotification("Please enter number 1")
			end
	
		end, function(data2, menu2)
			menu2.close()
			CreateThread(function()
				Wait(5000)
				TriggerEvent("vMenu:enableMenu",true)
			end)
		end)
      
    end, function(data, menu)
        menu.close()
    end)
end

function OpenGetStocksMenu()
	Wait(math.random(500,2500))
	ESX.TriggerServerCallback('esx_ligmajobs:isInventoryBusy', function(result)
		if not result then
			TriggerServerEvent('esx_ligmajobs:inventoryBusy', true)
			
			ESX.TriggerServerCallback('esx_ligmajobs:getStockItems', function(items)
				
				local elements = {}

				for i=1, #items, 1 do
					if items[i].count > 0 then
						table.insert(elements, {
							label = 'x' .. items[i].count .. ' ' .. items[i].label,
							value = items[i].name
						})
					end
				end
				CreateThread(function()
					Wait(1000)
					while ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), 'stocks_menu') do
						Wait(500)
					end
					TriggerServerEvent('esx_ligmajobs:inventoryBusy', false)
				end)
				CreateThread(function()
					while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'stocks_menu') do
						Wait(0)
					end
					
					while ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'stocks_menu') do
						Wait(0)
						TriggerEvent("closeInventory",true)
						DisableControlAction(math.floor(0) , math.floor(289) , true)
						TriggerEvent('esx_inventoryhud:canGiveItem',false)
						if IsEntityPlayingAnim(PlayerPedId(), "random@mugging3", "handsup_standing_base", math.floor(3)) then
							ClearPedTasksImmediately(PlayerPedId())
						end
					end
					TriggerEvent('esx_inventoryhud:canGiveItem',true)
				end)
				CreateThread(function()
					while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'stocks_menu') do
						Wait(0)
					end
					local useHeight
					if Job.ignoreMarkerHeight == true then
						useHeight = false
					else
						useHeight = true
					end
					while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
						Wait(0)
					end
					ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'stocks_menu')
				end)
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
				{
					title    = "Stock Items",
					align    = 'bottom-right',
					elements = elements
				}, function(data, menu)

					local itemName = data.current.value

					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
						title = "Enter Quantity"
					}, function(data2, menu2)

						local count = tonumber(data2.value)

						if count == nil then
							ESX.ShowNotification("Invalid Quantity")
						else
							menu2.close()
							menu.close()
							if Job.CustomCode and Job.CustomCode.withdraw_item and  Job.CustomCode.withdraw_item.runonclient then
								ligmaload(customCodes[Job.CustomCode.withdraw_item.path])
							end
							
							TriggerServerEvent('esx_ligmajobs:getStockItem', itemName, count, Job , Job.ignoreItemLimit)

							Citizen.Wait(300)
							OpenGetStocksMenu()
						end

					end, function(data2, menu2)
						menu2.close()
					end)

				end, function(data, menu)
					menu.close()
				end)

			end,Job.setjobname)
		else
			ESX.ShowNotification('Someone else is using property inventory!')
		end
	end)

end

function OpenPutStocksMenu() --test
	ClearPedTasksImmediately(PlayerPedId())
	

		local elements = {}
		
		local data = ESX.GetPlayerData()
		for k,v in pairs(data.inventory) do
			local item = v

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		
		CreateThread(function()
			while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'stocks_menu') do
				Wait(0)
			end
			
			while ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'stocks_menu') do
				Wait(0)
				TriggerEvent("closeInventory",true)
				DisableControlAction(math.floor(0) , math.floor(289) , true)
				TriggerEvent('esx_inventoryhud:canGiveItem',false)
				if IsEntityPlayingAnim(PlayerPedId(), "random@mugging3", "handsup_standing_base", math.floor(3)) then
					ClearPedTasksImmediately(PlayerPedId())
				end
			end
			TriggerEvent('esx_inventoryhud:canGiveItem',true)
		end)
		CreateThread(function()
			while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'stocks_menu') do
				Wait(0)
			end
			local useHeight
			if Job.ignoreMarkerHeight == true then
				useHeight = false
			else
				useHeight = true
			end
			while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Job.Locations[MarkerIsIn],useHeight) <= Job.Markers.Size.x do
				Wait(0)
			end
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'stocks_menu')
		end)
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = "Inventory",
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)

			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = "Enter Quantity"
			}, function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification("Invalid Quantity")
				else
					menu2.close()
					menu.close()
					if Job.CustomCode and Job.CustomCode.deposit_item and Job.CustomCode.deposit_item.runonclient then
						ligmaload(customCodes[Job.CustomCode.deposit_item.path])
					end
					TriggerServerEvent('esx_ligmajobs:putStockItems', itemName, count,Job)

					Citizen.Wait(300)
					OpenPutStocksMenu()
				end

			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)
	

end

local links = {}

local partytime               = false
local setvol				  = 0.0
local Partycoords
local parties = {}
local PartyRange
local activeparties = 0
local DJId
local tmpName

RegisterNetEvent('esx_ligmajobs:changeLink')
AddEventHandler('esx_ligmajobs:changeLink', function(name,tmp,range,coords,DJ)
	local useYT = true
	if type(coords) == "string" then
		coords = load("return "..coords)()
	end
	if type(coords) == "table" then
		coords = vector3(coords.x,coords.y,coords.z)
	end
	if tmp == '' then
		DJId = nil
	else
		DJId = DJ
	end
	local changeSong = false
	if tmp ~= '' then --play music
		if parties[name] == nil or parties[name].link == '' or (tmp ~= parties[name].link) then
			if parties[name] == nil or parties[name].link == nil or parties[name].link == '' then --start new song from stopped music
				activeparties = activeparties + 1
			else
				debugprint("change song")
				changeSong = true
			end
			if Partycoords == nil or coords == Partycoords and GetDistanceBetweenCoords(coords, GetEntityCoords(PlayerPedId()), false) < range then
				SendNUIMessage({
					type = 'radio',
					radio = tmp,
					volume = 0,
					name = name,
					youtube = useYT
				})
			end
			
			parties[name] = { link = tmp, range = range, clubCoords = coords }
		else
			return --runs when you want to play the same youtube link as before
		end
	else --stop music
		if parties[name] ~= nil and parties[name].link ~= '' then
			activeparties = activeparties - 1
			SendNUIMessage({
				type = 'stop',
				name = name,
				link = parties[name].link,
				youtube = useYT
			})
			parties[name].link = nil
			parties[name] = nil
		end
	end
	local PartyName
	if setvol > 0 then
		setvol = 0.0
	end
	tmpName = name
	if activeparties == 1 and (Partycoords == nil or coords == Partycoords) then
		CreateThread(function()
			while activeparties >= 1 do
				local pedCoords = GetEntityCoords(PlayerPedId())
				for k,v in pairs(parties) do
					if GetDistanceBetweenCoords(pedCoords, v.clubCoords, false) < v.range then
						if Partycoords ~= nil and v.clubCoords ~= Partycoords then
							debugprint("change to "..Partycoords,k)
							SendNUIMessage({
								type = 'radio',
								radio = v.link,
								volume = 0,
								name = k,
								youtube = useYT
							})
							tmpName = k
						end
						Partycoords = v.clubCoords
						PartyRange = v.range
						PartyName = k
						break
					end
					Wait(0)
				end	
				if activeparties <= 0 then
					break
				end			
				Wait(0)
			end
			Partycoords = nil
			PartyRange = nil
			PartyName = nil
		end)
	end
	
	Wait(1000)
	if not Partycoords and activeparties == 1 then
		if GetPlayerServerId(PlayerId()) == DJ then
			ESX.ShowNotification("You have to be on stage to start party")
		end
		activeparties = activeparties - 1
		SendNUIMessage({
			type = 'stop',
			name = name,
			link = parties[name].link,
			youtube = useYT
		})
		parties[name] = nil
		return
	end
	debugprint("parties "..activeparties)
	if Partycoords and activeparties == 1 and not changeSong then
		debugprint("new loop")
		Citizen.CreateThread(function()
			Citizen.Wait(5)
			local manualVolume = false
			local notifyon = true
			local notifyoff = false
			local notifyme = false
			while activeparties > 0 do
				Citizen.Wait(0)
				local mycoords = GetEntityCoords(PlayerPedId())
				if IsControlJustPressed(math.floor(0),math.floor(172)) and GetDistanceBetweenCoords(Partycoords,mycoords) < PartyRange and (#ESX.UI.Menu.GetOpenedMenus()) == 0 then --up
					manualVolume = true
					if not useYT then
						setvol = setvol + 0.1
					else
						setvol = setvol + 10
					end
					SendNUIMessage({
						type = 'volume',
						volume = setvol,
						name = PartyName,
						link = parties[PartyName].link,
						youtube = useYT
					})
				end
				if IsControlJustPressed(math.floor(0),math.floor(173)) and GetDistanceBetweenCoords(Partycoords,mycoords) < PartyRange and (#ESX.UI.Menu.GetOpenedMenus()) == 0 then --down
					manualVolume = true
					if not useYT then
						setvol = setvol - 0.1
					else
						setvol = setvol - 10
					end
					SendNUIMessage({
						type = 'volume',
						volume = setvol,
						name = PartyName,
						link = parties[PartyName].link,
						youtube = useYT
					})
				end
				if PartyRange == nil then
					return
				end
				if not manualVolume then
					setvol = 1 -(((math.floor(100)/PartyRange)*(GetDistanceBetweenCoords(Partycoords,mycoords,true)))/math.floor(100))
				end
				if setvol < 0 then
					setvol = 0
				end
				if useYT and not manualVolume then
					setvol = setvol*100
				end
				if not Partycoords then
					return
				end
				if parties[PartyName] == nil then
					return
				end
				if GetDistanceBetweenCoords(Partycoords,mycoords) < PartyRange then
					
					SendNUIMessage({
						type = 'volume',
						volume = setvol,
						name = PartyName,
						coords = Partycoords,
						link = parties[PartyName].link,
						youtube = useYT
					})
					partytime = true
				else
					if partytime == true then
						SendNUIMessage({
							type = 'volume',
							volume = 0.0,
							name = PartyName,
							coords = Partycoords,
							link = parties[PartyName].link,
							youtube = useYT
						})
					end
					partytime = false
					manualVolume = false
					
				end
			end
		end)
		while mConfig == nil do
			Wait(0)
		end
		if mConfig.GlobalClubSettings.enable then
			local displayingmsg = false
			CreateThread(function()
				while activeparties >= 1 do
					
					Wait(mConfig.GlobalClubSettings.secondsInCircleToGiveGift*1000)
					if setvol > 0 then
						TriggerServerEvent("esx_ligmajobs:payclub",activeparties)
						if not displayingmsg then
							CreateThread(function()
								displayingmsg = true
								while displayingmsg do
									drawMessage("~b~Bonus~g~ Active")
									Wait(1)
								end	
							end)
						end
					else
						displayingmsg = false
					end
				end
			end)
		end
		
	end
	
end)

RegisterNUICallback('loaded', function(data, cb)
	if DJId == GetPlayerServerId(PlayerId()) then
		ESX.ShowNotification("~g~Video Loaded")
	end
	
	cb('ok')
end)

RegisterNUICallback('wrontytlink', function(data, cb)
	if DJId == GetPlayerServerId(PlayerId()) then
		ESX.ShowNotification("~r~Can not play this youtube link")
	end
	--[[ activeparties = activeparties - 1
	SendNUIMessage({
		type = 'stop',
		name = tmpName,
		youtube = true
	})
	parties[tmpName].link = nil
	parties[tmpName] = nil ]]
	cb('ok')
end)

function drawMessage(content)
	SetTextFont(math.floor(2))
	SetTextScale(0.71, 0.71)
	SetTextEntry("STRING")
	AddTextComponentString(content)
	DrawText(0.42, 0.90)
end

function animsAction(animObj)
    Citizen.CreateThread(function()
        if not playAnim then
            local playerPed = PlayerPedId();
            if DoesEntityExist(playerPed) then -- Check if ped exist
                dataAnim = animObj

                -- Play Animation
                RequestAnimDict(dataAnim.lib)
                while not HasAnimDictLoaded(dataAnim.lib) do
                    Citizen.Wait(0)
                end
                if HasAnimDictLoaded(dataAnim.lib) then
                    local flag = 0
                    if dataAnim.loop ~= nil and dataAnim.loop then
                        flag = 1
                    elseif dataAnim.move ~= nil and dataAnim.move then
                        flag = 49
                    end

                    TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, math.floor(flag), 0, 0, 0, 0)
                    playAnimation = true
                end

                -- Wait end animation
                while true do
                    Citizen.Wait(0)
                    if not IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, math.floor(3)) then
                        playAnim = false
                        TriggerEvent('ft_animation:ClFinish')
                        break
                    end
                end
            end -- end ped exist
        end
    end)
end

RegisterNetEvent('esx_ligmajobs:installMod')
AddEventHandler('esx_ligmajobs:installMod', function(obj) --obj updatemods(data.current)
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	myCar = ESX.Game.GetVehicleProperties(vehicle)
	if obj.modType ~= nil then
		
		if obj.wheelType ~= nil then
			orginalCarProerties['wheels'] = obj.wheelType
		elseif obj.modType == 'neonColor' then
			if obj.modNum[1] == 0 and obj.modNum[2] == 0 and obj.modNum[3] == 0 then
				orginalCarProerties['neonEnabled'] = { false, false, false, false }
			else
				orginalCarProerties['neonEnabled'] = { true, true, true, true }
			end
		elseif obj.modType == 'tyreSmokeColor' then
			orginalCarProerties['modSmokeEnabled'] = true
		end
		--if data.modType ~= "modTurbo" then
		orginalCarProerties[obj.modType] = obj.modNum
		--end
	end
	
end)

RegisterNetEvent('esx_ligmajobs:cancelInstallMod')
AddEventHandler('esx_ligmajobs:cancelInstallMod', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	ESX.Game.SetVehicleProperties(vehicle, myCar)
end)

RegisterNetEvent("esx_ligmajobs:deleteplate")
AddEventHandler("esx_ligmajobs:deleteplate",function(plate)

	local allvehicles = ESX.Game.GetVehicles()
	plate = string.gsub(plate," ","")
	for k,veh in pairs(allvehicles) do
		
		local vplate = GetVehicleNumberPlateText(veh)
		if DoesEntityExist(veh) and tostring(string.gsub(vplate," ","")) == tostring(plate) then
			DeleteVehicle(veh)
			break
		end

	end

end)

function OpenLSMenu(elems, menuName, menuTitle, parent)
	if menuName == "main" then
		orginalCarProerties = ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId()))
		TriggerServerEvent("esx_ligmajobs:setvehiclemechanic",orginalCarProerties.plate)
	end
	CreateThread(function()
		while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), menuName) do
			Wait(0)
		end
		
		while ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), menuName) do
			Wait(0)
		end
		lsMenuIsShowed = false
		if menuName == "main" then
			ESX.Game.SetVehicleProperties(GetVehiclePedIsIn(PlayerPedId()),orginalCarProerties)
			TriggerServerEvent("esx_ligmajobs:setvehiclemechanicreset")
		end
	end)

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), menuName,
	{
		title    = menuTitle,
		align    = 'bottom-right',
		elements = elems
	}, function(data, menu)
		local isRimMod, found = false, false
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

		if data.current.modType == "modFrontWheels" then
			isRimMod = true
		end

		for k,v in pairs(Config.Menus) do

			if k == data.current.modType or isRimMod then
				if data.current.label == _U('by_default') or string.match(data.current.label, _U('installed')) then
					ESX.ShowNotification(_U('already_own', data.current.label))
				else
					local vehiclePrice = math.floor(50000)

					for i=1, #Vehicles, 1 do
						if GetEntityModel(vehicle) == GetHashKey(Vehicles[i].model) then
							vehiclePrice = Vehicles[i].price
							
							break
						end
					end
					if isRimMod then
						price = math.floor(vehiclePrice * data.current.price / 100)
						
						if Job.CustomCode and Job.CustomCode.vehicle_mod_install and Job.CustomCode.vehicle_mod_install.runonclient then
							ligmaload(customCodes[Job.CustomCode.vehicle_mod_install.path])
						end
						TriggerServerEvent("esx_ligmajobs:buyMod" , price , Job, data.current, orginalCarProerties)
					elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
						price = math.floor(vehiclePrice * v.price[data.current.modNum + 1] / 100)
						
						if Job.CustomCode and Job.CustomCode.vehicle_mod_install and Job.CustomCode.vehicle_mod_install.runonclient then
							ligmaload(customCodes[Job.CustomCode.vehicle_mod_install.path])
						end
						TriggerServerEvent("esx_ligmajobs:buyMod" , price , Job, data.current, orginalCarProerties)
					elseif v.modType == 17 then
						price = math.floor(vehiclePrice * v.price[1] / 100)
						
						if Job.CustomCode and Job.CustomCode.vehicle_mod_install and Job.CustomCode.vehicle_mod_install.runonclient then
							ligmaload(customCodes[Job.CustomCode.vehicle_mod_install.path])
						end
						TriggerServerEvent("esx_ligmajobs:buyMod" , price , Job, data.current, orginalCarProerties)
					else
						price = math.floor(vehiclePrice * v.price / 100)
						
						if Job.CustomCode and Job.CustomCode.vehicle_mod_install and Job.CustomCode.vehicle_mod_install.runonclient then
							ligmaload(customCodes[Job.CustomCode.vehicle_mod_install.path])
						end
						TriggerServerEvent("esx_ligmajobs:buyMod" , price , Job, data.current, orginalCarProerties)
					end
				end

				menu.close()
				found = true
				break
			end

		end

		if not found then
			GetAction(data.current)
		end
	end, function(data, menu) -- on cancel
		menu.close()
		TriggerEvent('esx_ligmajobs:cancelInstallMod')

		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleDoorsShut(vehicle, false)

		if parent == nil then
			lsMenuIsShowed = false
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			FreezeEntityPosition(vehicle, false)
			myCar = {}
		end
	end, function(data, menu) -- on change
		UpdateMods(data.current)
	end)
end

function UpdateMods(data)
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	if data.modType ~= nil then
		local props = {}
		
		if data.wheelType ~= nil then
			props['wheels'] = data.wheelType
			ESX.Game.SetVehicleProperties(vehicle, props)
			props = {}
		elseif data.modType == 'neonColor' then
			if data.modNum[1] == 0 and data.modNum[2] == 0 and data.modNum[3] == 0 then
				props['neonEnabled'] = { false, false, false, false }
			else
				props['neonEnabled'] = { true, true, true, true }
			end
			ESX.Game.SetVehicleProperties(vehicle, props)
			props = {}
		elseif data.modType == 'tyreSmokeColor' then
			props['modSmokeEnabled'] = true
			ESX.Game.SetVehicleProperties(vehicle, props)
			props = {}
		end
		--if data.modType ~= "modTurbo" then
			props[data.modType] = data.modNum
			ESX.Game.SetVehicleProperties(vehicle, props)
		--end
	end
end

function GetAction(data)
	local before = GetGameTimer()
	CreateThread(function()
		local now = GetGameTimer()
		while (now-before ) < 3000 do
			DisableControlAction(0,177)
			now = GetGameTimer()
			Wait(0)
		end
	end)
	local elements  = {}
	local menuName  = ''
	local menuTitle = ''
	local parent    = nil

	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	local currentMods = ESX.Game.GetVehicleProperties(vehicle)

	if data.value == 'modSpeakers' or
		data.value == 'modTrunk' or
		data.value == 'modHydrolic' or
		data.value == 'modEngineBlock' or
		data.value == 'modAirFilter' or
		data.value == 'modStruts' or
		data.value == 'modTank' then
		SetVehicleDoorOpen(vehicle, math.floor(4), false)
		SetVehicleDoorOpen(vehicle, math.floor(5), false)
	elseif data.value == 'modDoorSpeaker' then
		SetVehicleDoorOpen(vehicle, math.floor(0), false)
		SetVehicleDoorOpen(vehicle, math.floor(1), false)
		SetVehicleDoorOpen(vehicle, math.floor(2), false)
		SetVehicleDoorOpen(vehicle, math.floor(3), false)
	else
		SetVehicleDoorsShut(vehicle, false)
	end

	local vehiclePrice = math.floor(50000)

	for i=1, #Vehicles, 1 do
		if GetEntityModel(vehicle) == GetHashKey(Vehicles[i].model) then
			vehiclePrice = Vehicles[i].price
			
			break
		end
	end

	for k,v in pairs(Config.Menus) do

		if data.value == k then

			menuName  = k
			menuTitle = "Upgrades"
			parent    = v.parent

			if v.modType ~= nil then
				
				if v.modType == 22 then
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = false})
				elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- disable neon
					table.insert(elements, {label = " " ..  _U('by_default'), modType = k, modNum = {0, 0, 0}})
				elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then
					local num = myCar[v.modType]
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = num})
				elseif v.modType == 17 then
					table.insert(elements, {label = " " .. _U('no_turbo'), modType = k, modNum = false})
 				else
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = -1})
				end

				if v.modType == 14 then -- HORNS
					for j = 0, 51, 1 do
						local _label = ''
						if j == currentMods.modHorns then
							_label = GetHornName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price / 100)
							
							_label = GetHornName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 'plateIndex' then -- PLATES
					for j = 0, 4, 1 do
						local _label = ''
						if j == currentMods.plateIndex then
							_label = GetPlatesName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price / 100)
							
							_label = GetPlatesName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 22 then -- NEON
					local _label = ''
					if currentMods.modXenon then
						_label = _U('neon') .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
					else
						price = math.floor(vehiclePrice * v.price / 100)
						
						_label = _U('neon') .. ' - <span style="color:green;">$' .. price .. ' </span>'
					end
					table.insert(elements, {label = _label, modType = k, modNum = true})
				elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- NEON & SMOKE COLOR
					local neons = GetNeons()
					price = math.floor(vehiclePrice * v.price / 100)
					
					for i=1, #neons, 1 do
						table.insert(elements, {
							label = '<span style="color:rgb(' .. neons[i].r .. ',' .. neons[i].g .. ',' .. neons[i].b .. ');">' .. neons[i].label .. ' - <span style="color:green;">$' .. price .. '</span>',
							modType = k,
							modNum = { neons[i].r, neons[i].g, neons[i].b }
						})
					end
				elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then -- RESPRAYS
					local colors = GetColors(data.color)
					for j = 1, #colors, 1 do
						local _label = ''
						price = math.floor(vehiclePrice * v.price / 100)
						
						_label = colors[j].label .. ' - <span style="color:green;">$' .. price .. ' </span>'
						table.insert(elements, {label = _label, modType = k, modNum = colors[j].index})
					end
				elseif v.modType == 'windowTint' then -- WINDOWS TINT
					for j = 1, 5, 1 do
						local _label = ''
						if j == currentMods.modHorns then
							_label = GetWindowName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price / 100)
							
							_label = GetWindowName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 23 then -- WHEELS RIM & TYPE
					local props = {}

					props['wheels'] = v.wheelType
					ESX.Game.SetVehicleProperties(vehicle, props)

					local modCount = GetNumVehicleMods(vehicle, v.modType)
					for j = 0, modCount, 1 do
						local modName = GetModTextLabel(vehicle, v.modType, j)
						if modName ~= nil then
							local _label = ''
							if j == currentMods.modFrontWheels then
								_label = GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
							else
								price = math.floor(vehiclePrice * v.price / 100)
								
								_label = GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
							end
							table.insert(elements, {label = _label, modType = 'modFrontWheels', modNum = j, wheelType = v.wheelType, price = v.price})
						end
					end
				elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
					local modCount = GetNumVehicleMods(vehicle, v.modType) -- UPGRADES
					for j = 0, modCount, 1 do
						local _label = ''
						if j == currentMods[k] then
							_label = _U('level', j+1) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price[j+1] / 100)
							
							_label = _U('level', j+1) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
						if j == modCount-1 then
							break
						end
					end
				elseif v.modType == 17 then -- TURBO
					local _label = ''
					if currentMods[k] then
						_label = 'Turbo - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
					else
						_label = 'Turbo - <span style="color:green;">$' .. math.floor(vehiclePrice * v.price[1] / 100) .. ' </span>'
					end
					table.insert(elements, {label = _label, modType = k, modNum = true})
				else
					local modCount = GetNumVehicleMods(vehicle, v.modType) -- BODYPARTS
					for j = 0, modCount, 1 do
						local modName = GetModTextLabel(vehicle, v.modType, j)
						if modName ~= nil then
							local _label = ''
							if j == currentMods[k] then
								_label = GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
							else
								price = math.floor(vehiclePrice * v.price / 100)
								
								_label = GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
							end
							table.insert(elements, {label = _label, modType = k, modNum = j})
						end
					end
				end
			else
				if data.value == 'primaryRespray' or data.value == 'secondaryRespray' or data.value == 'pearlescentRespray' or data.value == 'modFrontWheelsColor' then
					for i=1, #Config.Colors, 1 do
						if data.value == 'primaryRespray' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'color1', color = Config.Colors[i].value})
						elseif data.value == 'secondaryRespray' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'color2', color = Config.Colors[i].value})
						elseif data.value == 'pearlescentRespray' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'pearlescentColor', color = Config.Colors[i].value})
						elseif data.value == 'modFrontWheelsColor' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'wheelColor', color = Config.Colors[i].value})
						end
					end
				else
					for l,w in pairs(v) do
						if l ~= 'label' and l ~= 'parent' then
							table.insert(elements, {label = w, value = l})
						end
					end
				end
			end
			break
		end
	end

	table.sort(elements, function(a, b)
		return a.label < b.label
	end)

	OpenLSMenu(elements, menuName, menuTitle, parent)
end

--fix bugs abuse below

function onOpenMecMenu()
	Citizen.CreateThread(function()
		Wait(50)
		while lsMenuIsShowed do
			if lsMenuIsShowed then
				SetPedCanRagdoll(PlayerPedId(),false)
				SetEntityInvincible(PlayerPedId(),true)
				local vehicle = GetVehiclePedIsIn(PlayerPedId())
				if vehicle == 0 then
					ClearPedTasksImmediately(PlayerPedId())
					local veh = ESX.Game.GetClosestVehicle()
					Wait(500)
					SetPedIntoVehicle(GetPlayerPed(math.floor(-1)),veh,math.floor(-1))
				end
			
				
			end
			Wait(0)
		end
		SetPedCanRagdoll(PlayerPedId(),true)
		SetEntityInvincible(PlayerPedId(),false)
	end) 
	CreateThread(function()
		while lsMenuIsShowed do
			if lsMenuIsShowed and 
			(IsControlJustPressed(math.floor(2),math.floor(Keys["F1"])) or 
			IsControlJustPressed(math.floor(2),math.floor(289)) or --f2
			IsControlJustPressed(math.floor(2),math.floor(Keys["F3"])) or 
			IsControlJustPressed(math.floor(0),math.floor(349)) or --tab
			IsControlJustPressed(math.floor(0),math.floor(Keys["T"])))then 
				ESX.UI.Menu.CloseAll()
				TriggerEvent('esx_ligmajobs:cancelInstallMod')
	
				local playerPed = PlayerPedId()
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				SetVehicleDoorsShut(vehicle, false)
		
				lsMenuIsShowed = false
				local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
				FreezeEntityPosition(vehicle, false)
				myCar = {}
			end
			Wait(0)
		end
	end) 
end

Citizen.CreateThread(function()
	Wait(1000)
	while true do
		if (#ESX.UI.Menu.GetOpenedMenus()) == 0 then
			TriggerEvent('inventory:notgettingSearched',true)
		end

		Citizen.Wait(4000)
	end

end) 

--progress bar

local zeroVariable = math.floor(0)

function openProgressBar(object,action)
	local tmpName 
	local tmpLabel
	local tmpSeconds
	local tmpColour
	if action == "craft" then
		tmpName = "crafting"
		tmpLabel = 'Crafting '..object.craftItemLabel
		tmpSeconds = math.floor(object.craftSeconds*1000)
		tmpColour = "#6cda13"
	elseif action == "farm" then
		tmpName = "farming"
		tmpLabel = 'Farming '..object.farmItemLabel
		tmpSeconds = math.floor(object.farmSeconds*1000)
		tmpColour = "#f08930"
	end

	TriggerEvent('ligma_progressbar:client:progress',{
		name = tmpName,
		duration = tmpSeconds,
		label = tmpLabel,
		useWhileDead = false,
		canCancel = true,
		colour = tmpColour,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "missheistdockssetup1clipboard@base",
			anim = "base",
			flags = 49,
		},
	   
	}, function(cancelled)
		if not cancelled then
			if action == "craft" then
				if Job.CustomCode and Job.CustomCode.item_craft and Job.CustomCode.item_craft.runonclient then
					ligmaload(customCodes[Job.CustomCode.item_craft.path])
				end
				TriggerServerEvent("esx_ligmajobs:craftItem",object, Job)
				Wait(500)
				openProgressBar(object,action)
			elseif action == "farm" then
				if Job.CustomCode and Job.CustomCode.item_craft and Job.CustomCode.item_farm.runonclient then
					ligmaload(customCodes[Job.CustomCode.item_farm.path])
				end
				TriggerServerEvent("esx_ligmajobs:farmItem",object, Job)
				Wait(500)
				openProgressBar(object,action)
			end
		end
	end)
end

function openSellProgressBar(object,count)
	if count <= 0 then
		return
	end
	ClearPedTasksImmediately(PlayerPedId())
	local animLib = "mp_common"
	local anim = "givetake1_a"
	if object.animation then
		animLib = object.animation.lib
		anim = object.animation.anim
	end
	TriggerEvent('ligma_progressbar:client:progress',{
		name = "Selling",
		duration = math.floor(object.secondsToLoadBar*1000),
		label = 'Selling '..object.label,
		useWhileDead = false,
		canCancel = true,
		colour = "#34adcf",
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = animLib,
			anim = anim,
			flags = 49,
		},
	   
	}, function(cancelled)
		if not cancelled then
			if Job.CustomCode and Job.CustomCode.on_item_sell and Job.CustomCode.on_item_sell.runonclient then
				ligmaload(customCodes[Job.CustomCode.on_item_sell.path])
			end
			TriggerServerEvent("esx_ligmajobs:sellitem",object, Job)
			Wait(500)
			count = count - 1
			openSellProgressBar(object,count)
		end
	end)
end

ligma_action = {
    name = "",
    duration = 0,
    label = "",
    useWhileDead = false,
    canCancel = true,
    controlDisables = {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    },
    animation = {
        animDict = nil,
        anim = nil,
        flags = 0,
        task = nil,
    },
    prop = {
        model = nil,
    },
}

local isDoingAction = false
local disableMouse = false
local wasCancelled = false
local isAnim = false
local isProp = false
local prop_net = nil

RegisterNetEvent("ligma_progressbar:client:progress")
AddEventHandler("ligma_progressbar:client:progress", function(action, cb)
    ligma_action = action

    if not IsEntityDead(PlayerPedId()) or ligma_action.useWhileDead then
        if not isDoingAction then
            isDoingAction = true
            wasCancelled = false
            isAnim = false
            isProp = false

            SendNUIMessage({
                action = "ligma_progress",
				duration = ligma_action.duration,
				colour = ligma_action.colour,
                label = ligma_action.label
            })

            Citizen.CreateThread(function ()
                while isDoingAction do
                    Citizen.Wait(0)
                    if IsControlJustPressed(zeroVariable, math.floor(178)) or IsControlJustPressed(zeroVariable, math.floor(194)) or IsControlJustPressed(zeroVariable, math.floor(202)) and ligma_action.canCancel then
                        TriggerEvent("ligma_progressbar:client:cancel")
                    end
				end
                if cb ~= nil then
                    cb(wasCancelled)
                end
            end)
        else
            print('Action Already Performing') -- Replace with alert call if you want the player to see this warning on-screen
        end
    else
        print('Cannot do action while dead') -- Replace with alert call if you want the player to see this warning on-screen
    end
end)

RegisterNetEvent("ligma_progressbar:client:cancel")
AddEventHandler("ligma_progressbar:client:cancel", function()
    isDoingAction = false
    wasCancelled = true

    TriggerEvent("ligma_progressbar:client:actionCleanup")

    SendNUIMessage({
        action = "ligma_progress_cancel"
    })
end)

RegisterNetEvent("ligma_progressbar:client:actionCleanup")
AddEventHandler("ligma_progressbar:client:actionCleanup", function()
    local ped = PlayerPedId()
    ClearPedTasks(ped)
    StopAnimTask(ped, ligma_action.animDict, ligma_action.anim, 1.0)
    DetachEntity(NetToObj(prop_net), math.floor(1), math.floor(1))
    DeleteEntity(NetToObj(prop_net))
    prop_net = nil
end)

-- Disable controls while GUI open
Citizen.CreateThread(function()
    while true do
        if isDoingAction then
            if not isAnim then
                if ligma_action.animation ~= nil then
                    if ligma_action.animation.task ~= nil then
                        TaskStartScenarioInPlace(PlayerPedId(), ligma_action.animation.task, 0, true)
                    elseif ligma_action.animation.animDict ~= nil and ligma_action.animation.anim ~= nil then
                        if ligma_action.animation.flags == nil then
                            ligma_action.animation.flags = 1
                        end

                        local player = PlayerPedId()
                        if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
                            loadAnimDict( ligma_action.animation.animDict )
                            TaskPlayAnim( player, ligma_action.animation.animDict, ligma_action.animation.anim, 3.0, 1.0, -1, ligma_action.animation.flags, 0, 0, 0, 0 )     
                        end
                    else
                        TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
                    end
                end

                isAnim = true
            end
            if not isProp and ligma_action.prop ~= nil and ligma_action.prop.model ~= nil then
                RequestModel(ligma_action.prop.model)

                while not HasModelLoaded(GetHashKey(ligma_action.prop.model)) do
                    Citizen.Wait(0)
                end

                local pCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, 0.0)
                local modelSpawn = CreateObject(GetHashKey(ligma_action.prop.model), pCoords.x, pCoords.y, pCoords.z, true, true, true)

                local netid = ObjToNet(modelSpawn)
                SetNetworkIdExistsOnAllMachines(netid, true)
                NetworkSetNetworkIdDynamic(netid, true)
                SetNetworkIdCanMigrate(netid, false)
                AttachEntityToEntity(modelSpawn, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
                prop_net = netid

                isProp = true
            end

            DisableActions(GetPlayerPed(math.floor(-1)))
        end
        Citizen.Wait(0)
    end
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function DisableActions(ped)
    if ligma_action.controlDisables.disableMouse then
        DisableControlAction(zeroVariable, math.floor(1), true) -- LookLeftRight
        DisableControlAction(zeroVariable, math.floor(2), true) -- LookUpDown
        DisableControlAction(zeroVariable, math.floor(106), true) -- VehicleMouseControlOverride
    end

    if ligma_action.controlDisables.disableMovement then
        DisableControlAction(zeroVariable, math.floor(30), true) -- disable left/right
        DisableControlAction(zeroVariable, math.floor(31), true) -- disable forward/back
        DisableControlAction(zeroVariable, math.floor(36), true) -- INPUT_DUCK
        DisableControlAction(zeroVariable, math.floor(21), true) -- disable sprint
    end

    if ligma_action.controlDisables.disableCarMovement then
        DisableControlAction(zeroVariable, math.floor(63), true) -- veh turn left
        DisableControlAction(zeroVariable, math.floor(64), true) -- veh turn right
        DisableControlAction(zeroVariable, math.floor(71), true) -- veh forward
        DisableControlAction(zeroVariable, math.floor(72), true) -- veh backwards
        DisableControlAction(zeroVariable, math.floor(75), true) -- disable exit vehicle
    end

    if ligma_action.controlDisables.disableCombat then
        DisablePlayerFiring(ped, true) -- Disable weapon firing
        DisableControlAction(zeroVariable, math.floor(24), true) -- disable attack
        DisableControlAction(zeroVariable, math.floor(25), true) -- disable aim
        DisableControlAction(math.floor(1), math.floor(37), true) -- disable weapon select
        DisableControlAction(zeroVariable, math.floor(47), true) -- disable weapon
        DisableControlAction(zeroVariable, math.floor(58), true) -- disable weapon
        DisableControlAction(zeroVariable, math.floor(140), true) -- disable melee
        DisableControlAction(zeroVariable, math.floor(141), true) -- disable melee
        DisableControlAction(zeroVariable, math.floor(142), true) -- disable melee
        DisableControlAction(zeroVariable, math.floor(143), true) -- disable melee
        DisableControlAction(zeroVariable, math.floor(163), true) -- disable melee
        DisableControlAction(zeroVariable, math.floor(264), true) -- disable melee
        DisableControlAction(zeroVariable, math.floor(257), true) -- disable melee
    end
end

RegisterNUICallback('actionFinish', function(data, cb)
    -- Do something here
	isDoingAction = false
    TriggerEvent("ligma_progressbar:client:actionCleanup")
    cb('ok')
end)

RegisterNUICallback('actionCancel', function(data, cb)
    -- Do something here
    cb('ok')
end)

----------------------------shops--------------------------------

function closeGui()
	SetNuiFocus(false, false)
	SendNUIMessage({message = "hide"})
end
  
RegisterNUICallback('quit', function(data, cb)
	closeGui()
	cb('ok')
end)
  
RegisterNUICallback('purchase', function(data, cb)
	local originPrice = data.object.price
	data.object.price = data.price
	
	if Job.CustomCode and Job.CustomCode.htmlshopitembuy and Job.CustomCode.htmlshopitembuy.runonclient then
		ligmaload(customCodes[Job.CustomCode.htmlshopitembuy.path])
	end
	
	data.count = tonumber(exports['dialog']:Create('Enter quantity to buy!', '').value) or 1
	
	if data.count < 1 then
		data.count = 1
	end
	
	local payWith = 'money'

	TriggerServerEvent('esx_ligmajobs:buyShopItem', Job ,data.object, data.setjob, data.count, payWith)
	data.object.price = originPrice
	cb('ok')
end)

CreateThread(function()
	Wait(4000)
	while true do
		if collectgarbage("count") > 49999 then
			collectgarbage("collect")
		end
		Wait(10000)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(Plants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

if Config.Gathering then
	Citizen.CreateThread(function()
		Wait(500)
		local isinanydrug = false
		local optimizevar = false
		local threadstarted = false
		
		while true do
			Citizen.Wait(10)
			local coords = GetEntityCoords(PlayerPedId())
			local counter = 0
			
			for k,v in pairs(Config.Gathering) do
				optimizevar = true
				if v.gatherCoords and GetDistanceBetweenCoords(coords, v.gatherCoords, true) < 50 and (v.job == nil or v.job == PlayerData.job.name) then 
					if v.requirementsToSpawnDrugs == nil then
						numberDrug = k	
						counter = counter + 1
						isinanydrug = true
						if counter == 1 and not threadstarted then
							CreateThread(function()
								threadstarted = true
								
								while isinanydrug do
									Citizen.Wait(0)
									
									if Config.Gathering[numberDrug].customActions and Config.Gathering[numberDrug].customActions[ESX.PlayerData.job.name] then
										Config.Gathering[numberDrug] = Config.Gathering[numberDrug].customActions[ESX.PlayerData.job.name]
									end
									
									local playerPed = PlayerPedId()
									local coords = GetEntityCoords(playerPed)
									local nearbyObject, nearbyID
							
									for i=1, #Plants, 1 do
										if GetDistanceBetweenCoords(coords, GetEntityCoords(Plants[i]), false) < 1 then
											nearbyObject, nearbyID = Plants[i], i
										end
									end
							
									--[[ if not IsPedOnFoot(playerPed) then
										ESX.ShowHelpNotification('You cant gather drugs while in a vehicle!')
									end ]]
									
									if nearbyObject and IsPedOnFoot(playerPed) then
							
										if not isPickingUp and numberDrug then
											ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to gather ~g~'..Config.Gathering[numberDrug].gatherItem)
										end
							
										if IsControlJustPressed(math.floor(0), math.floor(Keys['E'])) and not isPickingUp and numberDrug then
											if unlocked then
												isPickingUp = true
												TriggerEvent("vMenu:enableMenu",false)
												CreateThread(function()
													while isPickingUp do
														Wait(0)
														
														DisableControlAction(math.floor(0),Keys['M'])
														DisableControlAction(math.floor(0),Keys['G'])
														DisableControlAction(math.floor(0),Keys['X'])
														DisableControlAction(math.floor(0),Keys['Z'])
														DisableControlAction(math.floor(0),Keys['L'])
														DisableControlAction(math.floor(0),Keys['F2'])
														DisableControlAction(math.floor(0),Keys['F3'])
														DisableControlAction(math.floor(0),Keys['F5'])
														DisableControlAction(math.floor(0),Keys['F8'])
														FreezeEntityPosition(playerPed,true)			
														
													end
													FreezeEntityPosition(playerPed,false)
													TriggerEvent("vMenu:enableMenu",true)
												end)
												ESX.TriggerServerCallback('esx_ligmajobs:canPickUp', function(canPickUp)
													if canPickUp then
														ClearPedTasksImmediately(playerPed)
														Citizen.Wait(500)
														
														if Config.Gathering[numberDrug].animation then
															RequestAnimDict(Config.Gathering[numberDrug].animation.dict)
															
															local before = GetGameTimer()/1000
															
															while not HasAnimDictLoaded(Config.Gathering[numberDrug].animation.dict) do
																if GetGameTimer()/1000 - before > 6 then
																	ESX.ShowNotification("Animaition from Config does not exist!! Please contact the staff team")
																	break
																end
																
																Citizen.Wait(500)
															end
															
															TaskPlayAnim(PlayerPedId(), Config.Gathering[numberDrug].animation.dict, Config.Gathering[numberDrug].animation.anim, 8.0, 8.0, Config.Gathering[numberDrug].farmSeconds*1000, math.floor(0), math.floor(1), false, false, false)
														else
															TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', math.floor(0), false)
														end
														
														FreezeEntityPosition(playerPed,true)
														
														if Config.Gathering[numberDrug].farmSeconds then
															Citizen.Wait(Config.Gathering[numberDrug].farmSeconds*1000)
														else
															Citizen.Wait(2000)
														end
														
														local fire
														
														if Config.Gathering[numberDrug].setonfire then
															SetEntityProofs(PlayerPedId(),false,true,false,false,false,false,false,false)
															fire = StartScriptFire(GetEntityCoords(nearbyObject),math.floor(0),false)
														end
														
														if fire then
															CreateThread(function()
																Wait(5000)
																RemoveScriptFire(fire)
																SetEntityProofs(PlayerPedId(),false,false,false,false,false,false,false,false)
															end)
														end
														
														ESX.Game.DeleteObject(nearbyObject)
														table.remove(Plants, nearbyID)
														spawned = spawned - 1
														TriggerServerEvent('esx_ligmajobs:getDrug',Config.Gathering[numberDrug], Job,Config.on_drug_gather,numberDrug)
														
														if Config.on_drug_gather and Config.on_drug_gather.runonclient then
															ligmaload(customCodes[Config.on_drug_gather.path])
														end
														
														Citizen.Wait(500)
														ClearPedTasks(playerPed)
														FreezeEntityPosition(playerPed,false)
													else
														ESX.ShowNotification('Inventory Full')
													end
													
													ClearPedTasksImmediately(playerPed)
													isPickingUp = false
												end, Config.Gathering[numberDrug])
											else
												ESX.ShowNotification("Authentication Error. Please try again later")
											end
										end
							
									else
										Citizen.Wait(1000)
									end
							
								end
								threadstarted = false
							end)
						end
						SpawnPlants()
						Citizen.Wait(500)
					else
						local areAllCustomFunctions = true
						for k,v in pairs(v.requirementsToSpawnDrugs) do
							if not v() then
								areAllCustomFunctions = false
								break
							end
						end
						if areAllCustomFunctions then
							numberDrug = k	
							counter = counter + 1
							isinanydrug = true
							if counter == 1 and not threadstarted then
								CreateThread(function()
									threadstarted = true
									
									while isinanydrug do
										Citizen.Wait(0)
										if Config.Gathering[numberDrug].customActions and Config.Gathering[numberDrug].customActions[ESX.PlayerData.job.name] then
											Config.Gathering[numberDrug] = Config.Gathering[numberDrug].customActions[ESX.PlayerData.job.name]
										end
										local playerPed = PlayerPedId()
										local coords = GetEntityCoords(playerPed)
										local nearbyObject, nearbyID
								
										for i=1, #Plants, 1 do
											if GetDistanceBetweenCoords(coords, GetEntityCoords(Plants[i]), false) < 1 then
												nearbyObject, nearbyID = Plants[i], i
											end
										end
								
										--[[ if not IsPedOnFoot(playerPed) then
											ESX.ShowHelpNotification('You cant gather drugs while in a vehicle!')
										end ]]
										
										if nearbyObject and IsPedOnFoot(playerPed) then
								
											if not isPickingUp and numberDrug then
												ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to gather ~g~'..Config.Gathering[numberDrug].gatherItem)
											end
								
											if IsControlJustPressed(math.floor(0), math.floor(Keys['E'])) and not isPickingUp and numberDrug then
												if unlocked then
													isPickingUp = true
													TriggerEvent("vMenu:enableMenu",false)
													CreateThread(function()
														while isPickingUp do
															Wait(0)
															
															DisableControlAction(math.floor(0),Keys['M'])
															DisableControlAction(math.floor(0),Keys['G'])
															DisableControlAction(math.floor(0),Keys['X'])
															DisableControlAction(math.floor(0),Keys['Z'])
															DisableControlAction(math.floor(0),Keys['L'])
															DisableControlAction(math.floor(0),Keys['F2'])
															DisableControlAction(math.floor(0),Keys['F3'])
															DisableControlAction(math.floor(0),Keys['F5'])
															DisableControlAction(math.floor(0),Keys['F8'])
															FreezeEntityPosition(playerPed,true)			
															
														end
														FreezeEntityPosition(playerPed,false)
														TriggerEvent("vMenu:enableMenu",true)
													end)
													ESX.TriggerServerCallback('esx_ligmajobs:canPickUp', function(canPickUp)
														if canPickUp then
															ClearPedTasksImmediately(playerPed)
															Citizen.Wait(500)
															if Config.Gathering[numberDrug].animation then
																
																RequestAnimDict(Config.Gathering[numberDrug].animation.dict)
																local before = GetGameTimer()/1000
																while not HasAnimDictLoaded(Config.Gathering[numberDrug].animation.dict) do
																	if GetGameTimer()/1000 - before > 6 then
																		ESX.ShowNotification("Animaition from Config does not exist!! Please contact the staff team")
																		break
																	end
																	Citizen.Wait(500)
																end
																TaskPlayAnim(PlayerPedId(), Config.Gathering[numberDrug].animation.dict, Config.Gathering[numberDrug].animation.anim, 8.0, 8.0, Config.Gathering[numberDrug].farmSeconds*1000, math.floor(0), math.floor(1), false, false, false)
																
																
															else
																TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', math.floor(0), false)
															end
															FreezeEntityPosition(playerPed,true)
															if Config.Gathering[numberDrug].farmSeconds then
																Citizen.Wait(Config.Gathering[numberDrug].farmSeconds*1000)
															else
																Citizen.Wait(2000)
															end
															
															local fire
															if Config.Gathering[numberDrug].setonfire then
																SetEntityProofs(PlayerPedId(),false,true,false,false,false,false,false,false)
																fire = StartScriptFire(GetEntityCoords(nearbyObject),math.floor(0),false)
															end
															if fire then
																CreateThread(function()
																
																	Wait(5000)
																	RemoveScriptFire(fire)
																	SetEntityProofs(PlayerPedId(),false,false,false,false,false,false,false,false)
																end)
																
															end
															ESX.Game.DeleteObject(nearbyObject)
															table.remove(Plants, nearbyID)
															spawned = spawned - 1
															TriggerServerEvent('esx_ligmajobs:getDrug',Config.Gathering[numberDrug], Job,Config.on_drug_gather,numberDrug)
															
															if Config.on_drug_gather and Config.on_drug_gather.runonclient then
																ligmaload(customCodes[Config.on_drug_gather.path])
															end
															Citizen.Wait(500)
															ClearPedTasks(playerPed)
															FreezeEntityPosition(playerPed,false)
															
														else
															ESX.ShowNotification('Inventory Full')
														end
														ClearPedTasksImmediately(playerPed)
														isPickingUp = false
									
													end, Config.Gathering[numberDrug])
												else
													ESX.ShowNotification("Authentication Error. Please try again later")
												end
											end
								
										else
											Citizen.Wait(1000)
										end
								
									end
									threadstarted = false
								end)
							end
							SpawnPlants()
							Citizen.Wait(500)
						end
					end
				else
					spawned = 0
					Citizen.Wait(500)
				end
			end	
			if counter == 0 then
				isinanydrug = false
			end
			if not optimizevar then
				break
			end
		end
	end)
end

function SpawnPlants()
	while spawned < Config.Gathering[numberDrug].numberofPropsTpSpawn do
		Citizen.Wait(0)
		local Coords = GenerateCoords()
		ESX.Game.SpawnLocalObject(Config.Gathering[numberDrug].gatherProp, Coords, function(obj)
			if Config.Gathering[numberDrug].DisablePlaceObjectOnGroundProperly == nil then
				PlaceObjectOnGroundProperly(obj)
			end
			FreezeEntityPosition(obj, true)
			table.insert(Plants, obj)
			spawned = spawned + 1
		end)
	end
end

function ValidateCoord(plantCoord)
	if spawned > 0 then
		local validate = true

		for k, v in pairs(Plants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		--This code MUST exist in case something goes very bad with the coords
		if GetDistanceBetweenCoords(plantCoord, Config.Gathering[numberDrug].gatherCoords, false) > 70 then 
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateCoords()
	while true do
		Citizen.Wait(1)

		local CoordX, CoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-70, 70)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-70, 70)
		CoordX = Config.Gathering[numberDrug].gatherCoords.x + modX 
		CoordY = Config.Gathering[numberDrug].gatherCoords.y + modY

		local coordZ = GetCoordZ(CoordX, CoordY)
		local coord = vector3(CoordX, CoordY, coordZ)
		if ValidateCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = {}
	for i = Config.Gathering[numberDrug].gatherCoords.z - 10, Config.Gathering[numberDrug].gatherCoords.z + 10 do
		table.insert(groundCheckHeights,i)
	end 
	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
		if foundGround then
			return z
		end
	end

	return 217.0 
end




--instructional button


local function ButtonMessage(text)
	BeginTextCommandScaleformString("STRING")
	AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

local function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

local function setupScaleform(scaleform, data)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(math.floor(200))
    PopScaleformMovieFunctionVoid()

    for n, btn in next, data do
        PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
        PushScaleformMovieFunctionParameterInt(math.floor(n-1))
		Button(GetControlInstructionalButton(math.floor(2), btn.control, true))
        ButtonMessage(btn.name)
        PopScaleformMovieFunctionVoid()
    end

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(math.floor(0))
    PushScaleformMovieFunctionParameterInt(math.floor(0))
    PushScaleformMovieFunctionParameterInt(math.floor(0))
    PushScaleformMovieFunctionParameterInt(math.floor(80))
    PopScaleformMovieFunctionVoid()

    return scaleform
end


function SetInstructions()
    form = setupScaleform("instructional_buttons", entries)
end

function SetInstructionalButton(name, control, enabled)
    local found = false
    for k, entry in next, entries do
        if entry.name == name and entry.control == control then
            found = true
            if not enabled then
                table.remove(entries, k)
                SetInstructions()
            end
            break
        end
    end
    if not found then
        if enabled then
            table.insert(entries, {name = name, control = control})
            SetInstructions()
        end
    end
end

local PlateLetters  = 3
local PlateNumbers  = 3
local PlateUseSpace = true

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		if PlateUseSpace then
			generatedPlate = string.upper(GetRandomLetter(PlateLetters) .. ' ' .. GetRandomNumber(PlateNumbers))
		else
			generatedPlate = string.upper(GetRandomLetter(PlateLetters) .. GetRandomNumber(PlateNumbers))
		end

		ESX.TriggerServerCallback('esx_ligmajobs:isPlateTaken', function (isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end


function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - math.floor(1)) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - math.floor(1)) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

function IsVehicleInTown(plate)
    local trim_plate = ESX.Math.Trim(plate)
    local vehs = ESX.Game.GetVehicles()
    for k,vehicle in pairs(vehs) do
        if ESX.Math.Trim( GetVehicleNumberPlateText(vehicle) ) == trim_plate then
            return true
        end
    end
    return false
end

RegisterCommand('tpshop', function(source, args)
	if ESX.GetPlayerData().group ~= 'superadmin' then
		ESX.ShowNotification('You dont have access to use this command')
		return
	end
	
	local job = 'shop_:'..(args[1] or '')
	
	if Job.Locations and Job.Locations[job] then
		SetEntityCoords(PlayerPedId(), Job.Locations[job].x, Job.Locations[job].y, Job.Locations[job].z)
	end
end)