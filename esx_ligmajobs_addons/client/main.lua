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
ESX = nil
isJob = false
inMarker = false



Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    
	while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end
	
    ESX.PlayerData = ESX.GetPlayerData()
    
	
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

cooldown = false

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

CreateThread(function()
	Citizen.Wait(1000)
	while true do	
		Citizen.Wait(0)
		if ESX.PlayerData.job.name == "vitioforo" then
			local coords = GetEntityCoords(GetPlayerPed(-1))
			if GetDistanceBetweenCoords(coords, 4181.6, 5358.0, 1.0, true) < 100.0 then
				inMarker = true
				DisplayHelpText("Press ~INPUT_CONTEXT~ to harvest fuel")
				--DrawMarker(1, 4181.6, 5358.0, 1.0, 0, 0, 0, 0, 0, 0, 100.0, 100.0, 9.0, 0, 3, 0, 155, false, false, 2, false, false, false, false)
			elseif GetDistanceBetweenCoords(coords,- 4181.6, 5358.0 , 1.0, true) < 500.0 then
				--DrawMarker(1,  4181.6, 5358.0, 1.0, 0, 0, 0, 0, 0, 0, 100.0, 100.0, 9.0, 0, 3, 0, 155, false, false, 2, false, false, false, false)
				farming = false
			else
				inMarker = false
				farming = false
				Citizen.Wait(1000)
			end
		else
			Citizen.Wait(1000)
			farming = false

			inMarker = false
		end
	end
end)

CreateThread(function()
	while true do	
		Citizen.Wait(0)
		if IsControlJustPressed(0, Keys["E"]) and inMarker and not cooldown then
			farm()

		elseif IsControlJustPressed(0, Keys["F6"]) and string.find(ESX.PlayerData.job.name,'ammunation') then
			local playerJob = ESX.PlayerData.job.name

			ESX.UI.Menu.CloseAll()
			local elements = {}
			table.insert(elements,{label = "Κόψε Απόδειξη", value = "billing"})
			--table.insert(elements,{label = "Επιδιόρθωσε όπλο", value = "repair"})

			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'gunshop1_actions',
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
									TriggerServerEvent('esx_billing:sendBiII', result, 'society_'..playerJob, playerJob , amount)
								end,"Enter Id","",math.floor(4))
							end
						end
					end, function(data, menu)
						menu.close()
					end
					)
				elseif data.current.value == "repair" then
					if ESX.PlayerData.job.name == 'ammunation1' then
						if GetDistanceBetweenCoords(vector3(1191.40, 5834.16, -110.97),GetEntityCoords(PlayerPedId()),true) > 50 then
							ESX.ShowNotification("Πρέπει να είσαι στη βάση σου για να πραγματοποιήσεις αυτή την ενέργεια")
							return
						end
					end
					if ESX.PlayerData.job.name == 'ammunation2' then
						if GetDistanceBetweenCoords(vector3(-4256.53, 8957.66, 2001.00),GetEntityCoords(PlayerPedId()),true) > 50 then
							ESX.ShowNotification("Πρέπει να είσαι στη βάση σου για να πραγματοποιήσεις αυτή την ενέργεια")
							return
						end
					end
					if ESX.PlayerData.job.name == 'ammunation3' then
						if GetDistanceBetweenCoords(vector3(1236.99,-3291.74,5.50),GetEntityCoords(PlayerPedId()),true) > 50 then
							ESX.ShowNotification("Πρέπει να είσαι στη βάση σου για να πραγματοποιήσεις αυτή την ενέργεια")
							return
						end
					end
					if ESX.PlayerData.job.name == 'ammunation4' then
						if GetDistanceBetweenCoords(vector3(-2997.36,8737.86,2000.01),GetEntityCoords(PlayerPedId()),true) > 50 then
							ESX.ShowNotification("Πρέπει να είσαι στη βάση σου για να πραγματοποιήσεις αυτή την ενέργεια")
							return
						end
					end
					if ESX.PlayerData.job.name == 'ammunation5' then
						if GetDistanceBetweenCoords(vector3(-3592.96, 8843.01, 2000.00),GetEntityCoords(PlayerPedId()),true) > 50 then
							ESX.ShowNotification("Πρέπει να είσαι στη βάση σου για να πραγματοποιήσεις αυτή την ενέργεια")
							return
						end
					end
					if ESX.PlayerData.job.name == 'ammunation6' then
						if GetDistanceBetweenCoords(vector3(-3504.37, 8827.27, 2000.00),GetEntityCoords(PlayerPedId()),true) > 50 then
							ESX.ShowNotification("Πρέπει να είσαι στη βάση σου για να πραγματοποιήσεις αυτή την ενέργεια")
							return
						end
					end
					if ESX.PlayerData.job.name == 'ammunation7' then
						if GetDistanceBetweenCoords(vector3(-3462.75, 8819.89, 2001.00),GetEntityCoords(PlayerPedId()),true) > 50 then
							ESX.ShowNotification("Πρέπει να είσαι στη βάση σου για να πραγματοποιήσεις αυτή την ενέργεια")
							return
						end
					end
					if ESX.PlayerData.job.name == 'ammunation8' then
						if GetDistanceBetweenCoords(vector3(-3409.21, 8810.59, 2000.00),GetEntityCoords(PlayerPedId()),true) > 50 then
							ESX.ShowNotification("Πρέπει να είσαι στη βάση σου για να πραγματοποιήσεις αυτή την ενέργεια")
							return
						end
					end
					if ESX.PlayerData.job.name == 'ammunation9' then
						if GetDistanceBetweenCoords(vector3(-3364.08, 8804.84, 2000.00),GetEntityCoords(PlayerPedId()),true) > 50 then
							ESX.ShowNotification("Πρέπει να είσαι στη βάση σου για να πραγματοποιήσεις αυτή την ενέργεια")
							return
						end
					end
					if ESX.PlayerData.job.name == 'ammunation10' then
						if GetDistanceBetweenCoords(vector3(-3231.23,8778.99,2000.01),GetEntityCoords(PlayerPedId()),true) > 50 then
							ESX.ShowNotification("Πρέπει να είσαι στη βάση σου για να πραγματοποιήσεις αυτή την ενέργεια")
							return
						end
					end
					if ESX.PlayerData.job.name == 'ammunation11' then
						if GetDistanceBetweenCoords(vector3(-3151.67,8765.19,2000.01),GetEntityCoords(PlayerPedId()),true) > 50 then
							ESX.ShowNotification("Πρέπει να είσαι στη βάση σου για να πραγματοποιήσεις αυτή την ενέργεια")
							return
						end
					end
					if ESX.PlayerData.job.name == 'ammunation12' then
						if GetDistanceBetweenCoords(vector3(-3099.62, 8755.90, 2000.00),GetEntityCoords(PlayerPedId()),true) > 50 then
							ESX.ShowNotification("Πρέπει να είσαι στη βάση σου για να πραγματοποιήσεις αυτή την ενέργεια")
							return
						end
					end
					if ESX.PlayerData.job.name == 'ammunation13' then
						if GetDistanceBetweenCoords(vector3(-4569.11, 9686.26, 2000.77),GetEntityCoords(PlayerPedId()),true) > 50 then
							ESX.ShowNotification("Πρέπει να είσαι στη βάση σου για να πραγματοποιήσεις αυτή την ενέργεια")
							return
						end
					end
					if ESX.PlayerData.job.name == 'ammunation14' then
						if GetDistanceBetweenCoords(vector3(-2047.42, 12974.05, 2000.00),GetEntityCoords(PlayerPedId()),true) > 50 then
							ESX.ShowNotification("Πρέπει να είσαι στη βάση σου για να πραγματοποιήσεις αυτή την ενέργεια")
							return
						end
					end
					if ESX.PlayerData.job.name == 'ammunation16' then
						if GetDistanceBetweenCoords(vector3(9170.95, 6591.96, 2000.25),GetEntityCoords(PlayerPedId()),true) > 50 then
							ESX.ShowNotification("Πρέπει να είσαι στη βάση σου για να πραγματοποιήσεις αυτή την ενέργεια")
							return
						end
					end
					local daweapons = {}
					ESX.PlayerData = ESX.GetPlayerData()
					weapons = ESX.PlayerData.loadout
					for key, value in pairs(weapons) do
						local playerPed = PlayerPedId()
						if weapons[key].name ~= "WEAPON_UNARMED" and weapons[key].name ~= "WEAPON_PETROLCAN" then
							table.insert(daweapons,{label = weapons[key].label, value = weapons[key].name})
						end
					end
		
					ESX.UI.Menu.CloseAll()
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), '',
					{
						title		= 'Επισκευή Όπλων',
						align		= 'bottom-right',
						elements	= daweapons
					}, function(data, menu)
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'repair_amount', {
							title = 'Πόσο τοις εκατό θες να επισκευάσεις;'
						}, function (data2, menu2)
							local amount = tonumber(data2.value)
							local itemname = data.current.value
							if amount > 100 then
								return
							end
							menu2.close()
							menu.close()
							local coords = GetEntityCoords(GetPlayerPed(-1))
							exports['progressBars']:startUI(28000, "Επιδιορθώνεις το όπλο..")
		
							ExecuteCommand("e petting")
							Citizen.Wait(30000)
							ClearPedTasksImmediately(GetPlayerPed(-1))
							if GetDistanceBetweenCoords(coords, GetEntityCoords(GetPlayerPed(-1)), true) > 2.0 then
								return
							end
							TriggerServerEvent("esx_ligmajobs_addons:repairWeapon", ESX.PlayerData.job.name, itemname, amount)
							
						end,function (data2, menu2)
							menu2.close()
						end)
					end,function(data, menu)
						menu.close()
					end)
				end
			end, function(data, menu)
				menu.close()
			end)


		elseif IsControlJustPressed(0, Keys["F6"]) and ESX.PlayerData.job.name == 'avocat' then
			local playerJob = ESX.PlayerData.job.name
			ESX.UI.Menu.CloseAll()
			local elements = {}
			table.insert(elements,{label = "Κόψε Απόδειξη", value = "billing"})
			local PlayerData = ESX.GetPlayerData()
			if ESX.PlayerData.job.name == 'avocat' and ESX.PlayerData.job.grade_name == 'boss' then
				table.insert(elements,{label = "Πρόστιμο Απουσίας από το Δικαστήριο", value = "courtbilling"})
				table.insert(elements,{label = "Πρόσθεσε Επικυρηγμένο στη Λίστα", value = "hunted" })
				table.insert(elements,{label = "Αφαίρεσε Επικυρηγμένο από τη Λίστα", value = "huntedoff" })
			end
			if ESX.PlayerData.job.grade == 1 then
				table.insert(elements,{label = "Βάλε/Βγάλε Χειροπέδες", value = "handcuff" })
				table.insert(elements,{label = "Βγάλε από το όχημα", value = "outofvehicle" })
				table.insert(elements,{label = "Βάλε στο όχημα", value = "put_in_vehicle" })
			end
			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'avocat'..'_actions',
				{
					title    = "Actions",
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
									TriggerServerEvent('esx_billing:sendBiII', result, 'society_'..playerJob, playerJob , amount)
								end,"Enter Id","",math.floor(4))
							end
						end
					end, function(data, menu)
						menu.close()
					end
					)
				elseif data.current.value == 'courtbilling' then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification("No players nearby")
					else
						menu.close()
						TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))
						Wait(1000)
						TriggerEvent('esx_ligmajobs_addons:KeyboardInput',function(result)
							TriggerServerEvent('esx_billing:sendBiII', result, 'society_'..playerJob, playerJob , 10000)
						end,"Enter Id","",math.floor(4))
					end
				elseif data.current.value == 'huntedoff' then
					ESX.TriggerServerCallback('esx_policejob:returnOfflineHuntedList', function(result)
						local elements = {}
						for i=1,#result,1 do
							table.insert(elements,{label = "Όνομα: <font color='red'>"..result[i].firstName.."</font> Επώνυμο: <font color='red'>"..result[i].lastName.."</font>".." Αστέρια: <font color='yellow'>"..result[i].wantedLevel.."</font>",value = result[i].steamid})
						end
						ESX.UI.Menu.CloseAll()
						ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'person_choose_delete',
						{
							title    = "Choose Person",
							align    = "bottom-right",
							elements = elements
						},
						function(data5, menu5)
							local elements2 = {
								{label = 'Yes',value = 'yes'},
								{label = 'No',value = 'no'}
							}
							ESX.UI.Menu.CloseAll()
							ESX.UI.Menu.Open(
							'default', GetCurrentResourceName(), 'person_choose_delete',
							{
								title    = "Choose Person",
								align    = "bottom-right",
								elements = elements2
							},
							function(data8, menu8)
								if data8.current.value == 'yes' then
									TriggerServerEvent('esx_policejob:deleteHuntedFromList',data5.current.value)
									ESX.UI.Menu.CloseAll()
								else
									ESX.UI.Menu.CloseAll()
								end
							end, function(data8, menu8)
								ESX.UI.Menu.CloseAll()
							end)
						end, function(data5, menu5)
							ESX.UI.Menu.CloseAll()
						end)
					end)
				elseif data.current.value == 'hunted' then
					local elms = {
						{label = 'Αναζήτηση με Ονοματεπώνυμο',value = 'firstLastName'},
						{label = 'Αναζήτηση με Ψευδώνυμο',value = 'steamname'},
						{label = 'Αναζήτηση με Αριθμό Ταυτότητας',value = 'am'}
					}
					ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'person_choose_method',
					{
						title    = "Choose Search Method",
						align    = "bottom-right",
						elements = elms
					},
					function(data5, menu5)
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'search', {
							title = 'Search'
						}, function(data2, menu2)
							if data2.value ~= nil and data2.value ~= "" then
								menu2.close()
								ESX.TriggerServerCallback('esx_policejob:SearchDbForName', function(names)
									if names ~= nil and #names > 0 then
										local elements = {}
										for i=1,#names,1 do
											if names[i].firstName and names[i].lastName then
												table.insert(elements,{label = "Αρ.Ταυτότητας:  <font color='red'>"..names[i].idnumber.."</font> Ψευδώνυμο: <font color='red'>"..names[i].name.."</font> Όνομα: <font color='red'>"..names[i].firstName.."</font> Επώνυμο: <font color='red'>"..names[i].lastName.."</font>", value = {steamid = names[i].identifier, firstName = names[i].firstName, lastName = names[i].lastName}})
											end
										end
										ESX.UI.Menu.CloseAll()
										ESX.UI.Menu.Open(
										'default', GetCurrentResourceName(), 'person_choose',
										{
											title    = "Choose Person",
											align    = "bottom-right",
											elements = elements
										},
										function(data3, menu3)
											if data3.current.value then
												ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'wanted_level', {
													title = 'Set Wanted Level (1-5)'
												}, function(data4, menu4)
													if data4.value ~= nil and data4.value ~= "" then
														menu4.close()
														local result = tonumber(data4.value)
														if result >= 1 and result <= 5 then
															TriggerServerEvent('esx_policejob:addHuntedToList',data3.current.value.steamid,data3.current.value.firstName,data3.current.value.lastName,result)
														else
															ESX.ShowNotification('Number has to be between 1 and 5')
														end
													end
													menu3.close()
												end, function(data4, menu4)
													ESX.UI.Menu.CloseAll()
												end)
											end
										end, function(data3, menu3)
											menu3.close()
										end)
									end
								end,tostring(data2.value),data5.current.value)
						
							else
								ESX.ShowNotification("Please Enter a valid search")
							end    
						end, function(data2, menu2)
							ESX.UI.Menu.CloseAll()
						end)
					end, function(data5, menu5)
						ESX.UI.Menu.CloseAll()
					end)
				elseif data.current.value == 'handcuff' then
					local closestPlayer, distance = ESX.Game.GetClosestPlayer()
					if closestPlayer ~= -1 and distance < 3 then

						TriggerServerEvent('esx_policejob:handcuff',  GetPlayerServerId(closestPlayer))	

					end
				elseif data.current.value == "outofvehicle" then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						TriggerServerEvent('esx_policejob:OutVehicle' , GetPlayerServerId(closestPlayer))
					end
				elseif data.current.value == "put_in_vehicle" then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						TriggerServerEvent('esx_policejob:putInVehicle' , GetPlayerServerId(closestPlayer))
					end
				
				end
			end, function(data, menu)
				menu.close()
			end)
		end
	end
end)



RegisterNetEvent('esx:setattr')
AddEventHandler('esx:setattr', function(key,val)
	ESX.PlayerData.attributes[key] = val
end)


function farm()
	if IsPedInAnyVehicle(PlayerPedId()) then
		return
	end
	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		return
	end
	cooldown = true
	local duration = 4000
	if ESX.PlayerData.attributes["xp_vitioforo"] and ESX.PlayerData.attributes["xp_vitioforo"] > 750 then
		duration = 4000
	else
		duration = 6000
	end
	--ExecuteCommand("e mechanic")
	local coords = GetEntityCoords(PlayerPedId())
	TriggerEvent('mythic_progressbar:client:progress',{
		name = "laodingvitio",
		duration = duration,
		label = "Εξόρυξη..",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = true,
			disableCombat = true,
		},
		animation = {
			animDict = "mini@repair",
			anim = "fixing_a_ped",
		},
	}, function(cancelled)
		if not cancelled then
			if GetDistanceBetweenCoords(coords, GetEntityCoords(GetPlayerPed(-1)), true) > 7.0 then
				return
			end
			TriggerServerEvent("esx_ligmajobs_addons:farm", "megalo_mpitoni", "vitioforo", "personal")
			Wait(300)
			TriggerEvent('mNotify:sendtheNotification', 'Επιτυχία', 'Πήρες 1 μεγάλο μπιτόνι', "left", "mid", false)
			Wait(100)
			farm()
		else
			ClearPedTasksImmediately(GetPlayerPed(-1))
		end
	end)
	
	cooldown = false

end



CreateThread(function()
	TriggerEvent("esx_utilities:add","Buy","Press ~INPUT_CONTEXT~ to buy trash",38,25.5 ,22,vector3(-4499.93,5560.89,2000.98),{ x = 1.5, y = 1.5, z = 1.0 },{ r = 50, g = 250, b = 50 },GetCurrentResourceName(),"ergostasio_anakiklosis")
	TriggerEvent("esx_utilities:add","Buy","Press ~INPUT_CONTEXT~ to buy trash",38,25.5 ,22,vector3(525.48, 5217.56, 120.99),{ x = 1.5, y = 1.5, z = 1.0 },{ r = 50, g = 250, b = 50 },GetCurrentResourceName(),"ergostasio_anakiklosis2")
	TriggerEvent("esx_utilities:add","Buy","Press ~INPUT_CONTEXT~ to buy trash",38,25.5 ,22,vector3(-601.55, -1599.53, 30.41),{ x = 1.5, y = 1.5, z = 1.0 },{ r = 50, g = 250, b = 50 },GetCurrentResourceName(),"ergostasio_anakiklosis3")
	TriggerEvent("esx_utilities:add","Buy","Press ~INPUT_CONTEXT~ to buy trash",38,25.5 ,22, vector3(-4502.51,6320.58,2000.98),{ x = 1.5, y = 1.5, z = 1.0 },{ r = 50, g = 250, b = 50 },GetCurrentResourceName(),"ergostasio_gialiou") 
	TriggerEvent("esx_utilities:add","Buy","Press ~INPUT_CONTEXT~ to buy trash",38,25.5 ,22, vector3(-4500.74,5788.27,2000.98),{ x = 1.5, y = 1.5, z = 1.0 },{ r = 50, g = 250, b = 50 },GetCurrentResourceName(),"ergostasio_plastikou")	
	TriggerEvent("esx_utilities:add","Buy","Press ~INPUT_CONTEXT~ to buy trash",38,25.5 ,22, vector3(-4500.98, 5618.59, 2000.98),{ x = 1.5, y = 1.5, z = 1.0 },{ r = 50, g = 250, b = 50 },GetCurrentResourceName(),"ergostasio_plastikou2")	
	
	--TriggerEvent("esx_utilities:add","BuyPharmacy","Press ~INPUT_CONTEXT~ to buy",38,25.5,27, vector3(7353.7, 7570.3, 120.0),{ x = 1.5, y = 1.5, z = 0.5 },{ r = 50, g = 250, b = 50 },GetCurrentResourceName())
	--TriggerEvent("esx_utilities:add","BuyPharmacy2","Press ~INPUT_CONTEXT~ to buy",38,25.5,27, vector3(-6652.7,3478.53,119.95),{ x = 1.5, y = 1.5, z = 0.5 },{ r = 50, g = 250, b = 50 },GetCurrentResourceName())
	--TriggerEvent("esx_utilities:add","BuyPharmacy3","Press ~INPUT_CONTEXT~ to buy",38,25.5,27, vector3(7409.2,5448.82,119.93),{ x = 1.5, y = 1.5, z = 0.5 },{ r = 50, g = 250, b = 50 },GetCurrentResourceName())
end)

local weapons

RegisterNetEvent('esx:setItems')
AddEventHandler('esx:setItems', function(sinventory, sloadout)
    ESX.PlayerData.loadout = sloadout
    weapons = ESX.PlayerData.loadout
end)

AddEventHandler("pressedmarker", function(markerlabel,MarkerObject)
	local PlayerData = ESX.GetPlayerData()
	if MarkerObject.resource == GetCurrentResourceName() then
		if markerlabel == "Buy" then
			local itemsForErgostasio = {}
			table.insert(itemsForErgostasio, {label="Σκουπίδια - 100$", value="skoupidia"})
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), '',
			{
				title		= 'Αγορά Αντικειμένων',
				align		= 'bottom-right',
				elements	= itemsForErgostasio
			}, function(data, menu)
				TriggerServerEvent("esx_ligmajobs_addons:buyItems", data.current.value)
			end,function(data, menu)
				menu.close()
			end)
		elseif string.find(markerlabel,"Repair") then
			local daweapons = {}
			ESX.PlayerData = ESX.GetPlayerData()
			weapons = ESX.PlayerData.loadout
			for key, value in pairs(weapons) do
				local playerPed = PlayerPedId()
				if weapons[key].name ~= "WEAPON_UNARMED" then
					table.insert(daweapons,{label = weapons[key].label, value = weapons[key].name})
				end
			end

			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), '',
			{
				title		= 'Επισκευή Όπλων',
				align		= 'bottom-right',
				elements	= daweapons
			}, function(data, menu)
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'repair_amount', {
					title = 'Πόσο τοις εκατό θες να επισκευάσεις;'
				}, function (data2, menu2)
					local amount = tonumber(data2.value)
					local itemname = data.current.value
					if amount > 100 then
						return
					end
					menu2.close()
					menu.close()
					local coords = GetEntityCoords(GetPlayerPed(-1))
					exports['progressBars']:startUI(28000, "Επιδιορθώνεις το όπλο..")

					ExecuteCommand("e petting")
					Citizen.Wait(30000)
					ClearPedTasksImmediately(GetPlayerPed(-1))
					if GetDistanceBetweenCoords(coords, GetEntityCoords(GetPlayerPed(-1)), true) > 2.0 then
						return
					end
					local society = nil
					if GetDistanceBetweenCoords(vector3(1191.40, 5834.16, -110.97),GetEntityCoords(PlayerPedId()),true) < 10.0 then
						society = "ammunation1"
					elseif GetDistanceBetweenCoords(vector3(-4254.05, 8959.39, 2000.00),GetEntityCoords(PlayerPedId()),true) < 10.0 then
						society = "ammunation2"
					elseif GetDistanceBetweenCoords(vector3(1236.99,-3291.74,5.50),GetEntityCoords(PlayerPedId()),true) < 10.0 then
						society = "ammunation3"
					elseif GetDistanceBetweenCoords(vector3(-2997.36,8737.86,2000.01),GetEntityCoords(PlayerPedId()),true) < 10.0 then
						society = "ammunation4"
					elseif GetDistanceBetweenCoords(vector3(-3592.96, 8843.01, 2000.00),GetEntityCoords(PlayerPedId()),true) < 10.0 then
						society = "ammunation5"
					elseif GetDistanceBetweenCoords(vector3(-3504.37, 8827.27, 2000.00),GetEntityCoords(PlayerPedId()),true) < 10.0 then
						society = "ammunation6"
					elseif GetDistanceBetweenCoords(vector3(-3462.75, 8819.89, 2000.00),GetEntityCoords(PlayerPedId()),true) < 10.0 then
						society = "ammunation7"
					elseif GetDistanceBetweenCoords(vector3(-3409.21, 8810.59, 2000.00),GetEntityCoords(PlayerPedId()),true) < 10.0 then
						society = "ammunation8"
					elseif GetDistanceBetweenCoords(vector3(-3364.08, 8804.84, 2000.00),GetEntityCoords(PlayerPedId()),true) < 10.0 then
						society = "ammunation9"
					elseif GetDistanceBetweenCoords(vector3(-3231.23,8778.99,2000.01),GetEntityCoords(PlayerPedId()),true) < 10.0 then
						society = "ammunation10"
					elseif GetDistanceBetweenCoords(vector3(-3151.67,8765.19,2000.01),GetEntityCoords(PlayerPedId()),true) < 10.0 then
						society = "ammunation11"
					elseif GetDistanceBetweenCoords(vector3(-3099.62, 8755.90, 2000.00),GetEntityCoords(PlayerPedId()),true) < 10.0 then
						society = "ammunation12"
					elseif GetDistanceBetweenCoords(vector3(-4569.11, 9686.26, 2000.77),GetEntityCoords(PlayerPedId()),true) < 10.0 then
						society = "ammunation13"
					elseif GetDistanceBetweenCoords(vector3(-2047.42, 12974.05, 2000.00),GetEntityCoords(PlayerPedId()),true) < 10.0 then
						society = "ammunation14"
					elseif GetDistanceBetweenCoords(vector3(9170.95, 6591.96, 2000.25),GetEntityCoords(PlayerPedId()),true) < 10.0 then
						society = "ammunation16"
					end

					TriggerServerEvent("esx_ligmajobs_addons:repairWeapon", society, itemname, amount)
					
				end,function (data2, menu2)
					menu2.close()
				end)
			end,function(data, menu)
				menu.close()
			end)
		end
	end

	
end)

AddEventHandler("exitedmarker", function(markerlabel,MarkerObject)
	if MarkerObject.resource == GetCurrentResourceName() then
		ESX.UI.Menu.CloseAll()
	end
end)

RegisterNetEvent("esx_ligmajobs_addons:instuctions")
AddEventHandler("esx_ligmajobs_addons:instuctions",function(action)
	if action then
		SetNuiFocus(true,true)
	else
		SetNuiFocus(false,false)
	end
	SendNUIMessage({
		action = action,
	})

end)

RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false, false)
end)

RegisterNetEvent('esx_ligmajobs_addons:KeyboardInput')
AddEventHandler('esx_ligmajobs_addons:KeyboardInput',function(cb,TextEntry, ExampleText, MaxStringLenght)
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
		cb(result) --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
	end
end)

local ObjectInFront = function(ped, pos)
	local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.5, 0.0)
	local car = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, ped, 0)
	local _, _, _, _, result = GetRaycastResult(car)
	return result
end



RegisterNetEvent('nk_repair:MettiCrick')
AddEventHandler('nk_repair:MettiCrick', function()

	local dict
	local model = 'prop_carjack'
	
	local ped = PlayerPedId()
	local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, -2.0, 0.0)
	local coords = GetEntityCoords(ped)
	local headin = GetEntityHeading(ped)
	local veh = ObjectInFront(ped, coords)
	SetEntityAsMissionEntity(veh, true, true)
	local vehicle   = ESX.Game.GetClosestVehicle()
	FreezeEntityPosition(vehicle, true)
	local vehpos = GetEntityCoords(vehicle)
	dict = 'mp_car_bomb'
	RequestAnimDict(dict)
	RequestModel(model)
	while not HasAnimDictLoaded(dict) or not HasModelLoaded(model) do
		Citizen.Wait(1)
	end
	--TriggerServerEvent('mechanic:removeFixTool',1)

	
	--local vehjack = CreateObject(GetHashKey(model), vehpos.x, vehpos.y, vehpos.z - 0.5, true, true, true)
	--exports['progressBars']:startUI(9250, "Ανέβασμα στο γρύλο") -- TRANSLATE THIS, THAT SAY WHEN YOU PUT THE CRIC
	--AttachEntityToEntity(vehjack, veh, 0, 0.0, 0.0, -1.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
	Citizen.Wait(1250)
	--SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	--SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	--SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	--SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	--SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	--SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	--SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	dict = 'move_crawl'
	Citizen.Wait(1000)
	--[[ SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
	 ]]
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	--SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.5, true, true, true)
	--SetEntityCollision(vehicle, false, false)
	TaskPedSlideToCoord(ped, offset, headin, 1000)
	Citizen.Wait(1000)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(500)
	end
	Wait(500) --wait for progress bar loop to break
	exports['progressBars']:startUI(11000, "Επισκευή") -- TRANSLATE THIS - THAT SAY WHEN YOU REPAIR THE VEHICLE
	TaskPlayAnimAdvanced(ped, dict, 'onback_bwd', coords, 0.0, 0.0, headin - 180, 1.0, 0.5, 3000, 1, 0.0, 1, 1)
	dict = 'amb@world_human_vehicle_mechanic@male@base'
	Citizen.Wait(3000)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
	TaskPlayAnim(ped, dict, 'base', 8.0, -8.0, 5000, 1, 0, false, false, false)
	dict = 'move_crawl'
	Citizen.Wait(5000)
	local coords2 = GetEntityCoords(ped)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
	TaskPlayAnimAdvanced(ped, dict, 'onback_fwd', coords2, 0.0, 0.0, headin - 180, 1.0, 0.5, 2000, 1, 0.0, 1, 1)
	Citizen.Wait(3000)
	dict = 'mp_car_bomb'
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
	if IsVehicleSeatFree(vehicle, -1) then
		--SetPedIntoVehicle(PlayerPedId(),vehicle,math.floor(-1))
		ClearPedTasksImmediately(ped)
		Wait(500)
	else
		ESX.ShowNotification("Πρέπει να μην έχει οδηγό το αμάξι")
		return
	end
	SetVehicleFixed(vehicle)
	SetVehicleDeformationFixed(vehicle)
	SetVehicleUndriveable(vehicle, false)
	SetVehicleEngineOn(vehicle, true, true)
	--ClearPedTasksImmediately(playerPed)
	Wait(500) --wait for progress bar loop to break
	--[[ exports['progressBars']:startUI(8250, "Κατέβασμα από το γρύλο") -- TLANSTALE THIS - THAT SAY WHEN YOU LEAVE THE CRIC
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
	Citizen.Wait(1250)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	dict = 'move_crawl'
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z, true, true, true) ]]
	FreezeEntityPosition(vehicle, false)
	--DeleteObject(vehjack)
	SetEntityCollision(vehicle, true, true)
end)

RegisterNetEvent('esx_ligmajobs_addons:showstaff')
AddEventHandler('esx_ligmajobs_addons:showstaff', function(staffs)

	ESX.UI.Menu.CloseAll()
	local elements = {}
	for i=1, #(staffs) do
		table.insert(elements,{label = staffs[i].label, value = ""})
	end
	if #(elements) < 1 then
		return
	end
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'staff_online',
		{
			title    = "Type: "..staffs[1].job..", Count: "..#(elements),
			align    = "left",
			elements = elements
		},
	function(data, menu)
	end,function(data, menu)
		menu.close()
	end)

end)

local repairCd = 0
RegisterCommand('repair', function(source, args)
	RepairVehicle()
end)
--[[RegisterCommand('repair2', function(source, args)
	local vehicle, distance = ESX.Game.GetClosestVehicle()
	if vehicle ~= -1 and distance < 6 then
		RepairVehicle()
	end
end)

RegisterKeyMapping('repair2', 'Repair Vehicle', 'keyboard', 'TAB')]]

function RepairVehicle()
	--[[ local function IsInCargo()
		local currentEvent = string.lower(GlobalState.inEvent or '')
	
		if string.find(currentEvent, 'cargo') or currentEvent == 'vangelico_rob' then
			return true
		end
	
		return false
	end

	if IsInCargo() then
		ESX.ShowNotification('You can\'t repair a vehicle while in an event')
		return
	end ]]

	if repairCd > GetGameTimer() then
		ESX.ShowNotification('Please wait some seconds')
		return
	end
	local vehicle, distance = ESX.Game.GetClosestVehicle()
    if IsEntityPositionFrozen(vehicle) then
		return
	end
	repairCd = GetGameTimer() + 10000
	
	
	if vehicle ~= -1 and distance < 6 then
		if GetEntitySpeed(vehicle) > 0.1 then
			ESX.ShowNotification('Stop the vehicle first')
			return
		end
		
		local answer
		
		ESX.TriggerServerCallback('esx_ligmajobs_addons:canRepairVehicle', function(cb) answer = cb end)
		while answer == nil do Wait(100) end
		
		repairCd = GetGameTimer() + 5000

		if not answer then
			ESX.ShowNotification('Not enough money')
			return
		end

		FreezeEntityPosition(vehicle, true)

		local npcCoords = GetEntityCoords(vehicle) + GetEntityForwardVector(vehicle) * 2.5
		RequestModel(GetHashKey('ig_car3guy2'))
		while not HasModelLoaded(GetHashKey('ig_car3guy2')) do
			Wait(10)
		end
		
		local spawnCoords = GenerateMechanicCoords(npcCoords)
		
		local mechanicNPC = CreatePed(5, GetHashKey('ig_car3guy2'), spawnCoords.x, spawnCoords.y, spawnCoords.z, 0.0, true, true)
		SetBlockingOfNonTemporaryEvents(mechanicNPC, true)
		SetEntityInvincible(mechanicNPC, true)
		
		SetModelAsNoLongerNeeded(GetHashKey('ig_car3guy2'))

		--TaskGoToCoordAnyMeans(mechanicNPC, npcCoords.x, npcCoords.y, npcCoords.z, 1.0, 0, 0, 786603, 0xbf800000)
		local heading = GetEntityHeading(vehicle)
		if heading >= 180.0 then
			heading = heading - 180.0
		else
			local dif = 180.0 - heading
			heading = 360.0 - dif
		end
		TaskPedSlideToCoord(mechanicNPC, npcCoords.x, npcCoords.y, npcCoords.z, heading, 0.1)
		
		local timeout = GetGameTimer() + 12000
		
		while #(GetEntityCoords(mechanicNPC) - npcCoords) > 1.0 and timeout > GetGameTimer() do
			Wait(100)
		end

		Wait(1500)

		SetVehicleDoorOpen(vehicle, 4, false, false)

		RequestAnimDict('mini@repair')
		while not HasAnimDictLoaded('mini@repair') do Wait(10) end
		
		TaskPlayAnim(mechanicNPC, 'mini@repair', 'fixing_a_ped', 1.0,-1.0, 8000, 1, 1, true, true, true)
		Wait(5000)
		ClearPedTasks(mechanicNPC)
		TaskWanderStandard(mechanicNPC, 10.0, 10)
		SetTimeout(5000, function()
			DeleteEntity(mechanicNPC)
		end)
		Wait(1000)
		SetVehicleDoorShut(vehicle, 4, false, false)

		SetVehicleTyreFixed(vehicle,0)
		SetVehicleTyreFixed(vehicle,1)
		SetVehicleTyreFixed(vehicle,2)
		SetVehicleTyreFixed(vehicle,3)
		SetVehicleTyreFixed(vehicle,4)
		SetVehicleTyreFixed(vehicle,5)
		SetVehicleTyreFixed(vehicle,45)
		SetVehicleTyreFixed(vehicle,47)
		
		SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
		SetVehicleUndriveable(vehicle, false)
		SetVehicleEngineOn(vehicle, true, true)
		
		SetVehicleEngineHealth(vehicle, 1000.0)
		TriggerEvent("rvf:setenginehealth",1000.0)
		SetVehicleDirtLevel(vehicle, math.floor(0))

		FreezeEntityPosition(vehicle, false)

		ESX.ShowNotification("To αμάξι επισκευάστηκε μηχανικά και εξωτερικά")
	else
		ESX.ShowNotification('No vehicles nearby')
	end
end

function GenerateMechanicCoords(coords)
	math.randomseed(GetGameTimer())
	
	local x = coords.x + math.random(-8, 8)
	local y = coords.y + math.random(-8, 8)
	local z = coords.z
	
	for height = coords.z - 10, coords.z + 20, 1.0 do
		local foundGround, tempZ = GetGroundZFor_3dCoord(x, y, height)
		
		if foundGround then
			z = tempZ
			break
		end
	end
	
	return vector3(x, y, z)
end

RegisterNetEvent("esx_data:getData")
AddEventHandler("esx_data:getData", function(data,amount)
	local elements = {}
	for k,v in pairs(data) do
		if v.lefta ~= nil then
			if v.type == 'black_money' then
				if v.lefta >= amount then
					table.insert(elements, {label = "Type: "..v.type.." | Value: "..v.lefta, steamid = v.steamid,})
				end
			elseif v.type == 'money' then
				if v.lefta >= amount then
					table.insert(elements, {label = "Type: "..v.type.." | Value: "..v.lefta, steamid = v.steamid,})
				end
			elseif v.type == 'bank' then
				if v.lefta >= amount then
					table.insert(elements, {label = "Type: "..v.type.." | Value: "..v.lefta, steamid = v.steamid,})
				end
			end
		end
	end


	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'datainfos', {
        title    = "Database",
        align    = 'bottom-right',
        elements = elements
    }, function(data, menu)
    	if data.current.steamid then
			TriggerServerEvent('esx_data:showTheName',data.current.steamid)
		end
    end, function(data, menu)
        menu.close()
    end)
end)

function openProgressBarCustomCodeCustomXP(object,quantity,job,xp,neededMoney,isWeapon)
    local tmpName 
    local tmpLabel
    local tmpSeconds
    local tmpColour
	local name
	if isWeapon then
		name = ESX.GetWeaponLabel(object.value.name)
	else
		name = ESX.GetItemLabel(object.value.name)
	end
    tmpName = "crafting"
    tmpLabel = 'Crafting '..name
    tmpSeconds = math.floor(object.value.craftSeconds*1000)
    tmpColour = "#6cda13"

    ExecuteCommand("e mechanic4")
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
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 49,
        },
       
    }, function(cancelled)
        ClearPedTasks(PlayerPedId())
        if not cancelled then
			if neededMoney then
				if isWeapon then
					TriggerServerEvent('esx_ligmajobs_addons:craftWeaponswithMoney',  object.value.name, object.value.neededItems,  "society_"..job, xp, "society", object.value.moneyType, object.value.neededMoney)
				else
					TriggerServerEvent('esx_ligmajobs_addons:craftItemswithMoney', object.value.name,  object.value.neededItems, "society_"..job, xp,"society", object.value.moneyType, object.value.neededMoney)
				end
			else
				if isWeapon then
					TriggerServerEvent('esx_ligmajobs_addons:craftWeapons', object.value.name, object.value.neededItems, "society_"..job, "society")
				else
					TriggerServerEvent("esx_ligmajobs_addons:craftItemsWithSingleXP" , object.value.name, object.value.numberToCraft, object.value.neededItems, "society_"..job, "society", xp)
				end
			end
            
            Wait(500)
			
            openProgressBarCustomCodeCustomXP(object,quantity,job,xp,neededMoney,isWeapon)
        end
    end)
end


function OpenRecipeMenu(itemTable,setjob,craftCode)
	local PlayerData = ESX.GetPlayerData()
	local elements = {}
	local CraftingElements = itemTable
	
	elements = {
		head = {'Επίπεδο', 'Προϊόν', 'Εικόνα', 'Συστατικά','Δημιουργία'},
		rows = {}
	}
	
	for i=1, #CraftingElements do
		if CraftingElements[i].value ~= "locked" and CraftingElements[i].value ~= "recipes" then
			local recipe = ""
			local button = '{{' .. 'Craft' .. '|craft}} '..' {{' .. 'Trade' .. '|trade}}'
			
			for j=1,#CraftingElements[i].value.neededItems,1 do 
				recipe = recipe..tostring(ESX.GetItemLabel(CraftingElements[i].value.neededItems[j].value)).." x"..CraftingElements[i].value.neededItems[j].amount.."<br>"
			end
			
			if CraftingElements[i].value.neededMoney then
				recipe = recipe..CraftingElements[i].value.neededMoney.."<font color = green>$</font><br>"
			end
			
			local name 
			
			if CraftingElements[i].value.isWeapon then
				name = ESX.GetWeaponLabel(CraftingElements[i].value.name)
			else
				name = ESX.GetItemLabel(CraftingElements[i].value.name)
			end
			
			table.insert(elements.rows, {
				data = CraftingElements[i],
				cols = {
					CraftingElements[i].value.rank,
					name,
					"<img src='nui://esx_inventoryhud_matza/html/img/items/"..CraftingElements[i].value.name..".png' style='width:60px;height:60px;padding:8px;border-radius:50%;border:1px solid #ff1f1f;background:#161616'>",
					recipe,
					button
				}
			})
		end
	end
	
	ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'recipe_list_' .. setjob, elements, function(data, menu)
		if data.value == 'craft' then
			local first = data.data
			local second = data.data.value.numberToCraft
			local third = setjob
			local fourth = data.data.value.xpToGive
			local neededMoney = data.data.value.neededMoney
			local isWeapon = data.data.value.isWeapon

			openProgressBarCustomCodeCustomXP(first,second,third,fourth,neededMoney,isWeapon)
		elseif data.value == 'trade' then
			TriggerEvent('esx_ligmajobs_addons:KeyboardInput',function(result)
				TriggerServerEvent('esx_ligmajobs_addons:trade',data,result,setjob)
			end,"Enter Quantity","",math.floor(6))
		end
		
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end