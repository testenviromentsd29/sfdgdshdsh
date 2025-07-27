radarCd = 0

local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local IsBusy = false
local spawnedVehicles, isInShopMenu = {}, false
local PlayerData = {}
local isCrafting = false

function OpenAmbulanceActionsMenu()
	local elements = {
		{label = _U('cloakroom'),		value = 'cloakroom'},
		{label = 'Βάλε αντικείμενο',	value = 'put_stock'}
    	--{label = 'Αφαίρεσε αντικείμενο', value = 'get_stock'}
	}

	if ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'seniorviceboss' or ESX.PlayerData.job.grade_name == 'viceboss' then
		table.insert(elements, {label = 'Αφαίρεσε αντικείμενο', value = 'get_stock'})
	end

	if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			OpenCloakroomMenu()
		elseif data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
				menu.close()
			end, {wash = false})
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenMobileAmbulanceActionsMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'bottom-right',
		elements = {
			{label = _U('ems_menu'),				value = 'citizen_interaction'},
			{label = "Έλεγξε το μέρος για νεκρούς",	value = 'dead_radar'},
		}
	}, function(data, menu)
		if data.current.value == 'dead_radar' then
			if radarCd < GetGameTimer() then
				radarCd = GetGameTimer() + 30000
				DeadRadar()
				menu.close()
			else
				ESX.ShowNotification('Πρέπει να περιμένεις '..math.ceil((radarCd - GetGameTimer())/1000)..' δευτερόλεπτα')
			end
		elseif data.current.value == 'citizen_interaction' then
			local elements = {
				{label = "Έλεγξε τον ασθενή",				value = 'check'},
				{label = _U('ems_menu_revive'),				value = 'revive'},
				--{label = "Βάλε νεκρό σε σακούλα",			value = 'deathbag'},
				--{label = "Στείλε τραυματία σε χειρουργείο",	value = 'surgery'},
				--{label = "Βάλε/Αφαίρεσε ηρεμιστική ένεση",	value = 'sedative'},
				--{label = "MDT Ambulance",					value = 'mdt'},
				--{label = "Ένεση Αδρεναλίνης",				value = 'remove_effect'},
				{label = "Wheelchair",						value = 'wheelchair'},
				{label = _U('ems_menu_small'),				value = 'small'},
				{label = _U('ems_menu_big'),				value = 'big'},
				{label = _U('billing'),						value = 'billing'},
			}

			if ESX.PlayerData.job.grade >= 4 and ESX.PlayerData.job.grade <= 6 then
				table.insert(elements, {label = "First Aid Kit", value = 'first_aid_kit'})
			end
			if ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'chief_doctor' or ESX.PlayerData.job.grade_name == 'doctor' or ESX.PlayerData.job.grade_name == 'viceboss' then
				--table.insert(elements, {label = 'Crafting', value = 'crafting_menu'})
			end
			if ESX.PlayerData.job.grade_name == 'boss' then
				table.insert(elements, {label = 'Employee Stats', value = 'stats'})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('ems_menu_title'),
				align    = 'bottom-right',
				elements = elements
			}, function(data, menu)
				if IsBusy then 
					return 
				end

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if data.current.value == 'crafting_menu' then
					local elements2 = {
			
						{label = 'Bandage',       value = 'craftingBandage'},
						{label = 'Medkit',        value = 'craftingMedikit'}
					}
				  
					
					ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'crafting_menu',
					{
						title    = 'Crafting Menu',
						align    = 'bottom-right',
						elements = elements2
						}, function(data2, menu2)
						local action = data2.current.value
						
						if action == 'craftingBandage' then
							if not isCrafting then
								isCrafting = true
								TriggerServerEvent('esx_ambulancejob:craftingBandage')
								local playerPed = GetPlayerPed(-1)
								TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
								Citizen.Wait(9000)
								ClearPedTasksImmediately(playerPed)
								isCrafting = false
							else
								ESX.ShowNotification('You are already crafting!')
							end
						elseif action == 'craftingMedikit' then
							if not isCrafting then
								isCrafting = true
								TriggerServerEvent('esx_ambulancejob:craftingMedikit')
								local playerPed = GetPlayerPed(-1)
								TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
								Citizen.Wait(9000)
								ClearPedTasksImmediately(playerPed)
								isCrafting = false
							else
								ESX.ShowNotification('You are already crafting!')
							end
						end
					
					end, function(data2, menu2)
						menu2.close()
					end)
				elseif data.current.value == 'stats' then
					local disabled = true
					
					if disabled then
						ESX.ShowNotification('This is currently disabled')
					end
				elseif data.current.value == 'mdt' then
					ESX.UI.Menu.CloseAll()
					ExecuteCommand('mdta')
					ExecuteCommand('e tablet')
				elseif data.current.value == 'remove_effect' then
					local myCoords = GetEntityCoords(PlayerPedId())
					
					TriggerServerEvent('3dme:showCloseIds',myCoords)
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'surgery_box', {
						title = 'ID of patient:'
					}, function(data70, menu70)
						if tonumber(GetPlayerServerId(PlayerId())) == tonumber(data70.value) then
							ESX.ShowNotification('Δεν μπορείς να το κάνεις αυτό στον εαυτό σου.')
						else
							local target = tonumber(data70.value)
							if GetPlayerFromServerId(target) ~= -1 and #(myCoords - GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) < 5.0 then
								ESX.TriggerServerCallback('esx_ambulancejob:getDeathState',function(result)
									if not result then
										TriggerServerEvent('esx_ambulancejob:removeEffect', data70.value)
									else
										ESX.ShowNotification('Ο παίκτης είναι νεκρός!')
									end
								end, data70.value)
							else
								ESX.ShowNotification('There is no player with that ID near you.')
							end
						end
						menu70.close()
					end, function(data70, menu70)
						ESX.UI.Menu.CloseAll()
					end)
				elseif data.current.value == 'first_aid_kit' then
					ESX.UI.Menu.CloseAll()
					
					local data = exports['dialog']:Create('Enter amount', 'The final price will be: amount*8000$')
					amount = tonumber(data.value)
					
					if amount and amount > 0 then
						TriggerServerEvent('esx_ambulancejob:buyFirstAid', amount)
					end
				elseif data.current.value == 'wheelchair' then
					local coords = GetEntityCoords(PlayerPedId()) + GetEntityForwardVector(PlayerPedId())
					TriggerServerEvent('esx_ambulancejob:spawnWheelchairMobile', coords)
				elseif data.current.value == 'surgery' then
					local elements = {
						{label = 'Μικρό χειρουργείο 3000$',		value = 3000},
						{label = 'Μεσαίο χειρουργείο 6500$',	value = 6500},
						{label = 'Μεγάλο χειρουργείο 12000$',	value = 12000},
					}
					
					ESX.UI.Menu.CloseAll()
					
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'surgery_select', {
						title    = 'Επιλογές χειρουργείου',
						align    = 'bottom-right',
						elements = elements,
					},
					function(data, menu)
						local myCoords = GetEntityCoords(PlayerPedId())
						
						if #(myCoords - Config.Hospitals['CentralLosSantos'].Blip.coords) < 100 or #(myCoords - Config.Hospitals['PaletoBay'].Blip.coords) < 100 then
							TriggerServerEvent('3dme:showCloseIds',myCoords)
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'surgery_box', {
								title = 'ID of patient:'
							}, function(data70, menu70)
								if tonumber(GetPlayerServerId(PlayerId())) == tonumber(data70.value) then
									ESX.ShowNotification('Δεν μπορείς να το κάνεις αυτό στον εαυτό σου.')
								else
									local target = tonumber(data70.value)
									if GetPlayerFromServerId(target) ~= -1 and #(myCoords - GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) < 5.0 then
										ESX.TriggerServerCallback('esx_ambulancejob:getDeathState',function(result)
											if not result then
												ESX.TriggerServerCallback('esx_ambulancejob:canPaySurgery',function(yes)
													if yes then
														TriggerServerEvent('esx_beds:gethelp', data70.value, data.current.value)
													else
														ESX.ShowNotification('Δεν έχει αρκετα χρήματα')
													end
												end, data70.value, data.current.value)
											else
												ESX.ShowNotification('Ο παίκτης είναι νεκρός!')
											end
										end, data70.value)
									else
										ESX.ShowNotification('There is no player with that ID near you.')
									end
								end
								menu70.close()
							end, function(data70, menu70)
								ESX.UI.Menu.CloseAll()
							end)
						else
							ESX.ShowNotification('You are too far away from the hospital!')
						end
					end,
					function(data, menu)
						menu.close()
					end)
				elseif data.current.value == 'sedative' then
					local myCoords = GetEntityCoords(PlayerPedId())
					
					TriggerServerEvent('3dme:showCloseIds', myCoords)
					
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sedative_box', {
						title = 'ID of patient:'
					}, function(data70, menu70)
						if tonumber(GetPlayerServerId(PlayerId())) == tonumber(data70.value) then
							ESX.ShowNotification('Δεν μπορείς να το κάνεις αυτό στον εαυτό σου.')
						else
							local target = tonumber(data70.value)
							if GetPlayerFromServerId(target) ~= -1 and #(myCoords - GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) < 5.0 then
								ESX.TriggerServerCallback('esx_ambulancejob:getDeathState',function(result)
									if not result then
										TriggerServerEvent('esx_ambulancejob:toggleSedative', data70.value)
									else
										ESX.ShowNotification('Ο παίκτης είναι νεκρός!')
									end
								end,data70.value)
							else
								ESX.ShowNotification('There is no player with that ID near you.')
							end
						end
						menu70.close()
					end, function(data70, menu70)
						ESX.UI.Menu.CloseAll()
					end)
				else
					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('no_players'))
					else
						if data.current.value == 'deathbag' then
							ESX.TriggerServerCallback('esx_ambulancejob:getDeadStatus',function(result)
								if result then
									if not result.dead then
										ESX.ShowNotification('Citizen is not dead')
									elseif result.dead then
										if result.checked then
											exports['progressBars']:startUI(10000, "Putting the body in the death bag..")
											ExecuteCommand("e mechanic3")
											Wait(10000)
											ExecuteCommand("e c")
											--ClearPedTasks(PlayerPedId())
											TriggerServerEvent('esx_ambulancejob:SetDeathBag',GetPlayerServerId(closestPlayer))
										else 
											ESX.ShowNotification('Citizen is not checked')
										end
									end
								end
							end,GetPlayerServerId(closestPlayer))
						elseif data.current.value == 'revive' then
							menu.close()
							if not IsBusy then
								IsBusy = true
								ESX.TriggerServerCallback('esx_ambulancejob:getDeadStatus',function(result)

									if not result or not result.dead then
										if ESX.DoIHaveItem('medikit',1) then
											
												local closestPlayerPed = GetPlayerPed(closestPlayer)

												if IsPedDeadOrDying(closestPlayerPed, 1) then
													local playerPed = PlayerPedId()

													ESX.ShowNotification(_U('revive_inprogress'))

													local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

													for i=1, 15, 1 do
														Citizen.Wait(900)
												
														ESX.Streaming.RequestAnimDict(lib, function()
															TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
														end)
													end

													TriggerServerEvent('esx_ambulancejob:revlve', GetPlayerServerId(closestPlayer))

													-- Show revive award?
													if Config.ReviveReward > 0 then
														ESX.ShowNotification(_U('revive_complete_award', Config.ReviveReward))
													else
														ESX.ShowNotification(_U('revive_complete'))
													end
												else
													ESX.ShowNotification(_U('player_not_unconscious'))
												end
												
										else
											ESX.ShowNotification(_U('not_enough_medikit'))
										end
										IsBusy = false
									elseif result and result.dead then
										--[[ if result.checked then
											ESX.ShowNotification('Citizen is already checked by a doctor!')
											Wait(2000)
										else
											ESX.ShowNotification('Citizen is dead, but you get a '..Config.DeathReward..'$ bonus for it!')
											TriggerServerEvent('esx_ambulancejob:DeathReward',GetPlayerServerId(closestPlayer))
											TriggerServerEvent('esx_ambulancejob:setTargetChecked',GetPlayerServerId(closestPlayer))
										end ]]
										if not result.checked then
											ESX.ShowNotification('Citizen is not checked.')
										else 
											ESX.ShowNotification('Citizen is dead.')
										end
										IsBusy = false
									end
									
								end,GetPlayerServerId(closestPlayer))
							end
						elseif action == 'med' then
							TriggerEvent('medSystem:med', GetPlayerServerId(closestPlayer))

							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

						elseif data.current.value == 'small' then

							if ESX.DoIHaveItem('bandage',1) then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									IsBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									IsBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_bandage'))
							
							end

						elseif data.current.value == 'big' then

							if ESX.DoIHaveItem('medikit',1) then
								
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									IsBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									IsBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							
								
							else
								ESX.ShowNotification(_U('not_enough_bandage'))
							end

						elseif data.current.value == 'billing' then
								ESX.UI.Menu.Open(
								'dialog', GetCurrentResourceName(), 'billing',
								{
									title = _U('invoice_amount')
								},
								function(data, menu)
									local amount = tonumber(data.value)
									if amount == nil or amount < 0 or amount > 500000 then
										ESX.ShowNotification(_U('amount_invalid'))
										else
										
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
										if closestPlayer == -1 or closestDistance > 4.0 then
											ESX.ShowNotification(_U('no_players_nearby'))
										else
											menu.close()
											TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))
											Wait(1000)
											local id = KeyboardInput("Enter Id","",math.floor(4))
											TriggerServerEvent('esx_billing:sendBiII', id, 'society_ambulance', _U('ambulance'), amount)
										end
									end
								end,
								function(data, menu)
								menu.close()
								end
								)
						elseif data.current.value == 'put_in_vehicle' then
							TriggerServerEvent('esx_ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))
						elseif data.current.value == 'check' then
							IsBusy = true
							
							TriggerServerEvent('medSystem:sendMeCustom', GetPlayerServerId(closestPlayer))
							
							ESX.TriggerServerCallback('esx_ambulancejob:getDeadStatus',function(result)
								if result then
									if result.dead then
										if not result.checked then
											ESX.ShowNotification('Citizen is dead, but you get a '..Config.DeathReward..'$ bonus for it!')
											TriggerServerEvent('esx_ambulancejob:DeathReward',GetPlayerServerId(closestPlayer))
											TriggerServerEvent('esx_ambulancejob:setTargetChecked',GetPlayerServerId(closestPlayer))
										end
									end
								end
							end,GetPlayerServerId(closestPlayer))
							
							IsBusy = false
						end
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end

	end, function(data, menu)
		menu.close()
	end)
end

function DeadRadar()
	ESX.ShowNotification('Radar ON')
	
	Citizen.CreateThread(function()
		local blips = {}
		
		for k, v in ipairs(GetActivePlayers()) do
			local coords = GetEntityCoords(PlayerPedId())
			local targetCoords = GetEntityCoords(GetPlayerPed(v))
			
			if #(coords - targetCoords) < 150.0 then
				if IsEntityDead(GetPlayerPed(v)) then
					local blip = AddBlipForCoord(targetCoords)
					
					SetBlipSprite (blip, 84)
					SetBlipDisplay(blip, 4)
					SetBlipScale  (blip, 1.0)
					SetBlipColour (blip, 1)
					
					BeginTextCommandSetBlipName('STRING')
					AddTextComponentString('Dead individual')
					EndTextCommandSetBlipName(blip)
					
					table.insert(blips, blip)
				end
			end
		end
		
		Wait(15000)
		ESX.ShowNotification('Radar OFF')
		
		for i = 1, #blips do
			if DoesBlipExist(blips[i]) then
				RemoveBlip(blips[i])
			end
		end
	end)
end

function FastTravel(coords, heading)
	local playerPed = PlayerPedId()

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Citizen.Wait(500)
	end

	ESX.Game.Teleport(playerPed, coords, function()
		DoScreenFadeIn(800)

		if heading then
			SetEntityHeading(playerPed, heading)
		end
	end)
end

-- Draw markers & Marker logic
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local letSleep, isInMarker, hasExited = true, false, false
		local currentHospital, currentPart, currentPartNum

		for hospitalNum,hospital in pairs(Config.Hospitals) do

			-- Ambulance Actions
			for k,v in ipairs(hospital.AmbulanceActions) do
				local distance = GetDistanceBetweenCoords(playerCoords, v, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < Config.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceActions', k
				end
			end

			 -- Pharmacies
			for k,v in ipairs(hospital.Pharmacies) do
				local distance = GetDistanceBetweenCoords(playerCoords, v, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < Config.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Pharmacies', k
				end
			end

			--[[ for k,v in ipairs(hospital.Armories) do
				local distance = GetDistanceBetweenCoords(coords, v, true)

				if distance < Config.DrawDistance then
					DrawMarker(21, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
					letSleep = false
				end

				if distance < Config.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Armory', k
				end
			end ]]

			-- Vehicle Spawners
			for k,v in ipairs(hospital.Vehicles) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Vehicles', k
				end
			end

			-- Helicopter Spawners
			for k,v in ipairs(hospital.Helicopters) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Helicopters', k
				end
			end

			-- Fast Travels
			for k,v in ipairs(hospital.FastTravels) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.From, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end


				if distance < v.Marker.x then
					FastTravel(v.To.coords, v.To.heading)
				end
			end

			-- Fast Travels (Prompt)
			for k,v in ipairs(hospital.FastTravelsPrompt) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.From, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'FastTravelsPrompt', k
				end
			end

		end

		-- Logic for exiting & entering markers
		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then

			if
				(LastHospital ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
				(LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
			then
				TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
				hasExited = true
			end

			HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum = true, currentHospital, currentPart, currentPartNum
			TriggerEvent('esx_inventoryhud:canGiveItem',false)
			TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentHospital, currentPart, currentPartNum)

		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_inventoryhud:canGiveItem',true)
			TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(hospital, part, partNum)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		if part == 'AmbulanceActions' then
			CurrentAction = part
			CurrentActionMsg = _U('actions_prompt')
			CurrentActionData = {}
		elseif part == 'Pharmacies' then
			CurrentAction = part
			CurrentActionMsg = _U('actions2_prompt')
			CurrentActionData = {}
		elseif part == 'Armory' then
	        CurrentAction     = 'menu_armory'
			CurrentActionMsg  = _U('open_armory')
			CurrentActionData = {hospital = hospital}
		elseif part == 'Vehicles' then
			CurrentAction = part
			CurrentActionMsg = _U('garage_prompt')
			CurrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'Helicopters' then
			CurrentAction = part
			CurrentActionMsg = _U('helicopter_prompt')
			CurrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'FastTravelsPrompt' then
			local travelItem = Config.Hospitals[hospital][part][partNum]

			CurrentAction = part
			CurrentActionMsg = travelItem.Prompt
			CurrentActionData = {to = travelItem.To.coords, heading = travelItem.To.heading}
		end
	end
end)

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(hospital, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then

				if CurrentAction == 'AmbulanceActions' then
					OpenAmbulanceActionsMenu()
				elseif CurrentAction == 'menu_armory' then
					OpenArmoryMenu(CurrentActionData.hospital)
				elseif CurrentAction == 'Pharmacies' then
					OpenPharmacyMenu()
				elseif CurrentAction == 'Vehicles' then
					OpenVehicleSpawnerMenu(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'Helicopters' then
					OpenHelicopterSpawnerMenu(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'FastTravelsPrompt' then
					FastTravel(CurrentActionData.to, CurrentActionData.heading)
				end

				CurrentAction = nil

			end

		elseif ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' and not IsDead then
			if IsControlJustReleased(0, Keys['F6']) then
				OpenMobileAmbulanceActionsMenu()
			end
		else
			Citizen.Wait(500)
		end
	end
end)
--[[ -- Draw markers & Marker logic
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local letSleep, isInMarker, hasExited = true, false, false
		local currentHospital, currentPart, currentPartNum

		for hospitalNum,hospital in pairs(Config.Hospitals) do

			-- Ambulance Actions
			for k,v in ipairs(hospital.AmbulanceActions) do
				TriggerEvent("esx_utilities:add","AmbulanceActions"..hospitalNum..k,"Press ~INPUT_CONTEXT~ to Open Ambulance Actions",38,Config.DrawDistance, Config.Marker.type,v,{x = Config.Marker.x, y = Config.Marker.y, z = Config.Marker.z},{r = Config.Marker.r, g = Config.Marker.g, b = Config.Marker.b},GetCurrentResourceName(),"ambulance")
			end
			-- Vehicle Spawners
			for k,v in ipairs(hospital.Vehicles) do
				TriggerEvent("esx_utilities:add","Vehicles"..hospitalNum..k,"Press ~INPUT_CONTEXT~ to Open Vehicle Spawner",38,Config.DrawDistance, v.Marker.type,v,{x = v.Marker.x, y = v.Marker.y, v.Marker.z,v.Marker.r, v.Marker.g, v.Marker.b,GetCurrentResourceName(),"ambulance")
			end

			-- Helicopter Spawners
			for k,v in ipairs(hospital.Helicopters) do
				TriggerEvent("esx_utilities:add","Helicopters"..hospitalNum..k,"Press ~INPUT_CONTEXT~ to Open Helicopter Spawner",38,Config.DrawDistance, v.Marker.type,v,v.Marker.x, v.Marker.y, v.Marker.z,v.Marker.r, v.Marker.g, v.Marker.b,GetCurrentResourceName(),"ambulance")
			end
		end
	end
end)

AddEventHandler("enteredmarker", function(markerlabel,MarkerObject)
	if MarkerObject.resource == GetCurrentResourceName() then
		TriggerEvent('esx_inventoryhud:canGiveItem',false)
	end
end)

AddEventHandler("exitedmarker", function(markerlabel,MarkerObject)
	if MarkerObject.resource == GetCurrentResourceName() then
		TriggerEvent('esx_inventoryhud:canGiveItem',true)

		ESX.UI.Menu.CloseAll()
	end
end)

AddEventHandler("pressedmarker", function(markerlabel,MarkerObject)
	if MarkerObject.resource == GetCurrentResourceName() then
		if string.find(markerlabel,'AmbulanceActions') then
			OpenAmbulanceActionsMenu()
		elseif string.find(markerlabel,"Vehicles") then
			local hospitalnum1, partnum1
			for i=1,#Config.Hospitals,1 do
				if string.find(markerlabel,Config.Hospitals[i]) then
					hospitalnum1 = Config.Hospitals[i]
				end
			end
			for i=1,#hospitalnum1.Vehicles,1 do
				if string.find(markerlabel, i) then
					partnum1 = i
				end
			end
			OpenVehicleSpawnerMenu(hospitalnum1,partnum1)
		elseif string.find(markerlabel,'Helicopters') then
			local hospitalnum1, partnum1
			for i=1,#Config.Hospitals,1 do
				if string.find(markerlabel,Config.Hospitals[i]) then
					hospitalnum1 = Config.Hospitals[i]
				end
			end
			for i=1,#hospitalnum1.Helicopters,1 do
				if string.find(markerlabel, i) then
					partnum1 = i
				end
			end
			OpenHelicopterSpawnerMenu(hospitalnum1,partnum1)
		end
	end
end)

AddEventHandler("justpressed",function(label,key)
    if label == "F6" and PlayerData.job.name == "ambulance" and not IsDead then
        if not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
            OpenMobileAmbulanceActionsMenu()
        end
    end
end)
 ]]

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)



function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_ambulancejob:getStockItems', function(items)
	  local elements = {}
  
	  for k,v in pairs(items) do
		table.insert(elements, {label = 'x' .. v.count .. ' ' .. v.label, value = v.name})
	  end
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'stocks_menu',
		{
		  title    = 'Stock',
		  align    = 'bottom-right',
		  elements = elements
		},
		function(data, menu)
  
		  local itemName = data.current.value
  
		  ESX.UI.Menu.Open(
			'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
			{
			  title = 'Quantity'
			},
			function(data2, menu2)
  
			  local count = tonumber(data2.value)
  
			  if count == nil then
				ESX.ShowNotification('Invalid Quantity')
			  else
				menu2.close()
				menu.close()
				TriggerServerEvent('esx_ambulancejob:getStockItem', itemName, count)
  
				Citizen.Wait(1000)
				OpenGetStocksMenu()
			  end
  
			end,
			function(data2, menu2)
			  menu2.close()
			end
		  )
  
		end,
		function(data, menu)
		  menu.close()
		end
	  )
  
	end)
  
  end
  

function OpenPutStocksMenu()
	ClearPedTasksImmediately(PlayerPedId())
	local inventory = ESX.GetPlayerData().inventory

		local elements = {}

		for k, v in pairs(inventory) do
			local item = v

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = 'Inventory',
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)

			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count1', {
				title = 'Quantity'
			}, function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification('Invalid Quantity')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_ambulancejob:putStockItems', itemName, count)

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

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

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
			end
		end
	end
end)

local headblendData
local PreviousPed             = {}
local PreviousPedHead             = {}
local PreviousPedProps        = {}
local playerPed = GetPlayerPed(-1)
local face

function OpenCloakroomMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'bottom-right',
		elements = {
			{label = _U('ems_clothes_civil'), value = 'citizen_wear'},
			{label = _U('ems_clothes_ems_carrier'), value = 'doctor_wear'},
			{label = _U('ems_clothes_ems'), value = 'ambulance_wear'},
		}
	}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			
			if Config.EnableNonFreemodePeds then
				--ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					-- local isMale = skin.sex == 0

					--TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
						-- ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							-- TriggerEvent('skinchanger:loadSkin', skin)
							-- TriggerEvent('esx:restoreLoadout')
						-- end)
						SetPedHairColor(playerPed, PreviousPedProps[68], PreviousPedProps[69])
						SetPedEyeColor(playerPed, PreviousPedProps[67])
						SetPedHeadBlendData(playerPed, headblendData.FirstFaceShape, headblendData.SecondFaceShape, headblendData.ThirdFaceShape, headblendData.FirstSkinTone, headblendData.SecondSkinTone, headblendData.ThirdSkinTone, 0)

						for i = 0, 12, 1 do
							SetPedComponentVariation(playerPed, PreviousPed[i].component, PreviousPed[i].drawable, PreviousPed[i].texture)
						end

						for i = 0, 12, 1 do
							SetPedHeadOverlay(playerPed, i, PreviousPedHead[i].overlayID, 1.0)
						end

						for i = 0, 7, 1 do
							ClearPedProp(playerPed, i)
						end

						for i = 0, 7, 1 do
							SetPedPropIndex(playerPed, PreviousPedProps[i].component, PreviousPedProps[i].drawable, PreviousPedProps[i].texture, true)
						end
					-- end)
				-- end)
			else
				
				SetPedHairColor(playerPed, PreviousPedProps[68], PreviousPedProps[69])
				SetPedEyeColor(playerPed, PreviousPedProps[67])
				SetPedHeadBlendData(playerPed, headblendData.FirstFaceShape, headblendData.SecondFaceShape, headblendData.ThirdFaceShape, headblendData.FirstSkinTone, headblendData.SecondSkinTone, headblendData.ThirdSkinTone, 0)

				for i = 0, 12, 1 do
					SetPedComponentVariation(playerPed, PreviousPed[i].component, PreviousPed[i].drawable, PreviousPed[i].texture)
				end

				for i = 0, 12, 1 do
					SetPedHeadOverlay(playerPed, i, PreviousPedHead[i].overlayID, 1.0)
				end

				for i = 0, 7, 1 do
					ClearPedProp(playerPed, i)
				end

				for i = 0, 7, 1 do
					SetPedPropIndex(playerPed, PreviousPedProps[i].component, PreviousPedProps[i].drawable, PreviousPedProps[i].texture, true)
				end
				-- ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					-- TriggerEvent('skinchanger:loadSkin', skin)
				-- end)
			end

			
		elseif data.current.value == 'ambulance_wear' or data.current.value == 'doctor_wear' then
			for i = 0, 12, 1 do
                PreviousPed[i]= {component = i, drawable = GetPedDrawableVariation(playerPed, i), texture = GetPedTextureVariation(playerPed, i)}
            end

            TriggerEvent("hbw:GetHeadBlendData", PlayerPedId(), function(data)
                headblendData = data
            end)

            local headblendData = exports.hbw:GetHeadBlendData(PlayerPedId())

            for i = 0, 12, 1 do
                PreviousPedHead[i] = {overlayID = GetPedHeadOverlayValue(playerPed, i)}
            end

            PreviousPedProps[67] = GetPedEyeColor(PlayerPedId())
            PreviousPedProps[68] = GetPedHairColor(PlayerPedId())
            PreviousPedProps[69] = GetPedHairHighlightColor(PlayerPedId())

            for i = 0, 7, 1 do
                PreviousPedProps[i] = {component = i, drawable = GetPedPropIndex(playerPed, i), texture = GetPedTextureVariation(playerPed, i)}
            end
        
            setUniform(data.current.value, playerPed)
            for i = 0, 12, 1 do
                SetPedHeadOverlay(playerPed, i, PreviousPedHead[i].overlayID, 1.0)
            end

            SetPedComponentVariation(playerPed, PreviousPed[2].component, PreviousPed[2].drawable, PreviousPed[2].texture)
            SetPedHairColor(playerPed, PreviousPedProps[68], PreviousPedProps[69])
            SetPedEyeColor(playerPed, PreviousPedProps[67])
            SetPedHeadBlendData(playerPed, headblendData.FirstFaceShape, headblendData.SecondFaceShape, headblendData.ThirdFaceShape, headblendData.FirstSkinTone, headblendData.SecondSkinTone, headblendData.ThirdSkinTone, 0)
		end

		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end
function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification('No outfit available')
			end
		else
			if Config.Uniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification('No outfit available')
			end
		end
	end)
end
function OpenVehicleSpawnerMenu(hospital, partNum)
	local playerCoords = GetEntityCoords(PlayerPedId())
	local elements = {
		--[[ {label = _U('garage_storeditem'), action = 'garage'},
		{label = _U('garage_storeitem'), action = 'store_garage'}, ]]
		{label = _U('garage_buyitem'), action = 'buy_vehicle'}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title    = _U('garage_title'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)

		if data.current.action == 'buy_vehicle' then
			local shopCoords = Config.Hospitals[hospital].Vehicles[partNum].InsideShop
			local shopElements = {}

			local authorizedVehicles = Config.AuthorizedVehicles[ESX.PlayerData.job.grade_name]

			if #authorizedVehicles > 0 then
				for k,vehicle in ipairs(authorizedVehicles) do
					table.insert(shopElements, {
						label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
						name  = vehicle.label,
						model = vehicle.model,
						price = vehicle.price,
						livery = vehicle.livery or nil,
						type  = 'car'
					})
				end
			else
				return
			end

			OpenShopMenu(shopElements, playerCoords, shopCoords)
		elseif data.current.action == 'garage' then
			local garage = {}

			ESX.TriggerServerCallback('d3x_vehicleshop:retrieveJobVehicles', function(jobVehicles)
				if #jobVehicles > 0 then
					for k,v in ipairs(jobVehicles) do
						print(v.plate,v.stored)
						local props = json.decode(v.vehicle)
						local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
						local label = ('%s - <span style="color:darkgoldenrod;">%s</span>: '):format(vehicleName, props.plate)

						if v.stored then
							label = label .. ('<span style="color:green;">%s</span>'):format(_U('garage_stored'))
						else
							label = label .. ('<span style="color:darkred;">%s</span>'):format(_U('garage_notstored'))
						end

						table.insert(garage, {
							label = label,
							stored = v.stored,
							model = props.model,
							vehicleProps = props
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
						title    = _U('garage_title'),
						align    = 'bottom-right',
						elements = garage
					}, function(data2, menu2)
						if data2.current.stored then
							local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(hospital, 'Vehicles', partNum)
							print('mpika')
							if foundSpawn then
								menu2.close()
								print('spawnarw')
								ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
									ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)
									print('triggara server event')
									TriggerServerEvent('d3x_vehicleshop:setJobVehicleState', data2.current.vehicleProps.plate, false)
									ESX.ShowNotification(_U('garage_released'))
								end)
							end
						else
							ESX.ShowNotification(_U('garage_notavailable'))
						end
					end, function(data2, menu2)
						menu2.close()
					end)

				else
					ESX.ShowNotification(_U('garage_empty'))
				end
			end, 'car')

		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end

	end, function(data, menu)
		menu.close()
	end)

end

function StoreNearbyVehicle(playerCoords)
	local vehicles, vehiclePlates = ESX.Game.GetVehiclesInArea(playerCoords, 30.0), {}

	if #vehicles > 0 then
		for k,v in ipairs(vehicles) do

			-- Make sure the vehicle we're saving is empty, or else it wont be deleted
			if GetVehicleNumberOfPassengers(v) == 0 and IsVehicleSeatFree(v, -1) then
				table.insert(vehiclePlates, {
					vehicle = v,
					plate = ESX.Math.Trim(GetVehicleNumberPlateText(v))
				})
			end
		end
	else
		ESX.ShowNotification(_U('garage_store_nearby'))
		return
	end

	ESX.TriggerServerCallback('esx_ambulancejob:storeNearbyVehicle', function(storeSuccess, foundNum)
		if storeSuccess then
			local vehicleId = vehiclePlates[foundNum]
			local attempts = 0
			ESX.Game.DeleteVehicle(vehicleId.vehicle)
			IsBusy = true

			Citizen.CreateThread(function()
				while IsBusy do
					Citizen.Wait(0)
					drawLoadingText(_U('garage_storing'), 255, 255, 255, 255)
				end
			end)

			-- Workaround for vehicle not deleting when other players are near it.
			while DoesEntityExist(vehicleId.vehicle) do
				Citizen.Wait(500)
				attempts = attempts + 1

				-- Give up
				if attempts > 30 then
					break
				end

				vehicles = ESX.Game.GetVehiclesInArea(playerCoords, 30.0)
				if #vehicles > 0 then
					for k,v in ipairs(vehicles) do
						if ESX.Math.Trim(GetVehicleNumberPlateText(v)) == vehicleId.plate then
							ESX.Game.DeleteVehicle(v)
							break
						end
					end
				end
			end

			IsBusy = false
			ESX.ShowNotification(_U('garage_has_stored'))
		else
			ESX.ShowNotification(_U('garage_has_notstored'))
		end
	end, vehiclePlates)
end

function GetAvailableVehicleSpawnPoint(hospital, part, partNum)
	local spawnPoints = Config.Hospitals[hospital][part][partNum].SpawnPoints
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		ESX.ShowNotification(_U('garage_blocked'))
		return false
	end
end

function OpenHelicopterSpawnerMenu(hospital, partNum)
	local playerCoords = GetEntityCoords(PlayerPedId())
	ESX.PlayerData = ESX.GetPlayerData()
	local elements = {
		{label = _U('helicopter_garage'), action = 'garage'},
		{label = _U('helicopter_store'), action = 'store_garage'},
		{label = _U('helicopter_buy'), action = 'buy_helicopter'}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'helicopter_spawner', {
		title    = _U('helicopter_title'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)

		if data.current.action == 'buy_helicopter' then
			local shopCoords = Config.Hospitals[hospital].Helicopters[partNum].InsideShop
			local shopElements = {}

			local authorizedHelicopters = Config.AuthorizedHelicopters[ESX.PlayerData.job.grade_name]

			if #authorizedHelicopters > 0 then
				for k,helicopter in ipairs(authorizedHelicopters) do
					table.insert(shopElements, {
						label = ('%s - <span style="color:green;">%s</span>'):format(helicopter.label, _U('shop_item', ESX.Math.GroupDigits(helicopter.price))),
						name  = helicopter.label,
						model = helicopter.model,
						price = helicopter.price,
						livery = helicopter.livery or nil,
						type  = 'helicopter'
					})
				end
			else
				ESX.ShowNotification(_U('helicopter_notauthorized'))
				return
			end

			OpenShopMenu(shopElements, playerCoords, shopCoords)
		elseif data.current.action == 'garage' then
			local garage = {}

			ESX.TriggerServerCallback('d3x_vehicleshop:retrieveJobVehicles', function(jobVehicles)
				if #jobVehicles > 0 then
					for k,v in ipairs(jobVehicles) do
						local props = json.decode(v.vehicle)
						local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
						local label = ('%s - <span style="color:darkgoldenrod;">%s</span>: '):format(vehicleName, props.plate)

						if v.stored then
							label = label .. ('<span style="color:green;">%s</span>'):format(_U('garage_stored'))
						else
							label = label .. ('<span style="color:darkred;">%s</span>'):format(_U('garage_notstored'))
						end

						table.insert(garage, {
							label = label,
							stored = v.stored,
							model = props.model,
							vehicleProps = props
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'helicopter_garage', {
						title    = _U('helicopter_garage_title'),
						align    = 'bottom-right',
						elements = garage
					}, function(data2, menu2)
						if data2.current.stored then
							local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(hospital, 'Helicopters', partNum)

							if foundSpawn then
								menu2.close()

								ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
									ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)
									print('triggara server event')
									TriggerServerEvent('d3x_vehicleshop:setJobVehicleState', data2.current.vehicleProps.plate, false)
									ESX.ShowNotification(_U('garage_released'))
								end)
							end
						else
							ESX.ShowNotification(_U('garage_notavailable'))
						end
					end, function(data2, menu2)
						menu2.close()
					end)

				else
					ESX.ShowNotification(_U('garage_empty'))
				end
			end, 'helicopter')

		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end

	end, function(data, menu)
		menu.close()
	end)

end

function OpenShopMenu(elements, restoreCoords, shopCoords)
	local playerPed = PlayerPedId()
	isInShopMenu = true

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
		title    = _U('vehicleshop_title'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if not WaitForVehicleToLoad(data.current.model) then
			return
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop_confirm', {
			title    = _U('vehicleshop_confirm'),
			align    = 'bottom-right',
			elements = {
				{ label = _U('confirm_no'), value = 'no' },
				{ label = _U('confirm_yes'), value = 'yes' }
			}
		}, function(data2, menu2)
			if data2.current.value == 'yes' then
				local newPlate = GeneratePlate() --8 psifeia
				local vehicle  = GetVehiclePedIsIn(playerPed, false)
				local props    = ESX.Game.GetVehicleProperties(vehicle)
				props.plate    = newPlate
				props.livery   = GetVehicleLivery(vehicle)
				ESX.TriggerServerCallback('esx_ambulancejob:buyJobVehicle', function (bought)
					if bought then
						ESX.ShowNotification(_U('vehicleshop_bought', data.current.name, ESX.Math.GroupDigits(data.current.price)))

						isInShopMenu = false
						ESX.UI.Menu.CloseAll()
				
						DeleteSpawnedVehicles()
						FreezeEntityPosition(playerPed, false)
						SetEntityVisible(playerPed, true)
				
						ESX.Game.Teleport(playerPed, restoreCoords)
					else
						ESX.ShowNotification(_U('vehicleshop_money'))
						menu2.close()
					end
				end, props, data.current.type)
			else
				menu2.close()
			end

		end, function(data2, menu2)
			menu2.close()
		end)

		end, function(data, menu)
		isInShopMenu = false
		ESX.UI.Menu.CloseAll()

		DeleteSpawnedVehicles()
		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)

		ESX.Game.Teleport(playerPed, restoreCoords)
	end, function(data, menu)
		DeleteSpawnedVehicles()

		if WaitForVehicleToLoad(data.current.model) then
			ESX.Game.SpawnLocalVehicle(data.current.model, shopCoords, 0.0, function(vehicle)
				table.insert(spawnedVehicles, vehicle)
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
				FreezeEntityPosition(vehicle, true)
				if data.current.model == 'kawasaki' then
					SetVehicleExtra(vehicle, 3, false)
					SetVehicleExtra(vehicle, 4, false)
					SetVehicleExtra(vehicle, 5, true)
					SetVehicleExtra(vehicle, 6, true)
				end
				if data.current.livery then
					SetVehicleModKit(vehicle, 0)
					SetVehicleLivery(vehicle, data.current.livery)
				end
			end)
		else
			ESX.ShowNotification('Model not found')
		end
	end)

	if WaitForVehicleToLoad(elements[1].model) then
		ESX.Game.SpawnLocalVehicle(elements[1].model, shopCoords, 0.0, function(vehicle)
			table.insert(spawnedVehicles, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
		end)
	else
		ESX.ShowNotification('Model not found')
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isInShopMenu then
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)

function DeleteSpawnedVehicles()
	while #spawnedVehicles > 0 do
		local vehicle = spawnedVehicles[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(spawnedVehicles, 1)
	end
end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if IsModelInCdimage(modelHash) then
		if not HasModelLoaded(modelHash) then
			RequestModel(modelHash)

			while not HasModelLoaded(modelHash) do
				Citizen.Wait(0)

				DisableControlAction(0, Keys['TOP'], true)
				DisableControlAction(0, Keys['DOWN'], true)
				DisableControlAction(0, Keys['LEFT'], true)
				DisableControlAction(0, Keys['RIGHT'], true)
				DisableControlAction(0, 176, true) -- ENTER key
				DisableControlAction(0, Keys['BACKSPACE'], true)
			--	DisableControlAction(0, 19, true) --alt 309
			--	DisableControlAction(0, 309, true) --t

				drawLoadingText(_U('vehicleshop_awaiting_model'), 255, 255, 255, 255)
			end
		end

		return true
	end

	return false
end

function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end

function OpenPharmacyMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pharmacy', {
		title    = 'Ambulance Menu',
		align    = 'bottom-right',
		elements = {
			--{label = 'Painkiller',		value = 'pausipono'},
			--{label = 'Bandage',			value = 'bandage'},
			{label = 'Get wheelchair',	value = 'wheelchair'},
		}
	}, function(data, menu)
		if data.current.value ~= 'wheelchair' then
			TriggerServerEvent('esx_ambulancejob:giveItem', data.current.value)
		else
			local vehicle, distance = ESX.Game.GetClosestVehicle(vector3(4939.25, -2007.72, 1999.20))

			if distance >= 3.0 then
				TriggerServerEvent('esx_ambulancejob:spawnWheelchair')
			else
				ESX.ShowNotification('Υπάρχει ήδη καροτσάκι')
			end
			
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function WarpPedInClosestVehicle(ped)
	local coords = GetEntityCoords(ped)

	local vehicle, distance = ESX.Game.GetClosestVehicle(coords)

	if distance ~= -1 and distance <= 5.0 then
		local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

		for i=maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat then
			TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
		end
	else
		ESX.ShowNotification(_U('no_vehicles'))
	end
end


RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = 200
	local maxHealthHalf = 50

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health +  maxHealthHalf))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'bandage' then
		maxHealth = 300
		maxHealthHalf = 75
		
		local health = GetEntityHealth(playerPed)
		
		if health < GetEntityMaxHealth(playerPed) then
			local newHealth = math.min(maxHealth, math.floor(health +  maxHealthHalf))
			
			SetEntityMaxHealth(playerPed, newHealth)
			SetPedMaxHealth(playerPed, newHealth)
			SetEntityHealth(playerPed, newHealth)
		end
	elseif healType == 'smallBandage2' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(200, math.floor(health +  (maxHealthHalf/2)))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'small/2' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(200, math.floor(health +  (maxHealthHalf/5)))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		ESX.ShowNotification(_U('healed'))
	end
end)

Citizen.CreateThread(function()
	while ESX == nil do
		Wait(100)
	end
	while true do 
	  while ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'armory') or ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'stocks_menu') do
		DisableControlAction(0, 289)
		DisableControlAction(0, 56)
		DisableControlAction(0, 73)
		Wait(0)
	  end
	  Wait(500)
	end
end)

function GeneratePlate()
	local generatedPlate
	local doBreak = false
	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		if true then
			generatedPlate = string.upper(GetRandomLetter(3) .. ' ' .. GetRandomNumber(3))
		else
			generatedPlate = string.upper(GetRandomLetter(3) .. GetRandomNumber(3))
		end

		ESX.TriggerServerCallback('esx_ambulancejob:isPlateTaken', function (isPlateTaken)
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

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end


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

RegisterNetEvent("esx_ambulancejob:removeEffect")
AddEventHandler("esx_ambulancejob:removeEffect", function()
	needsSurgery = false
	Wait(500)
	inSurgery = true
end)

RegisterNetEvent("esx_ambulancejob:deadam")
AddEventHandler("esx_ambulancejob:deadam", function()
	if not IsEntityDead(PlayerPedId()) then
		TriggerServerEvent("esx_ambulancejob:DeathReward2")
	end
end)

RegisterNetEvent("esx_ambulancejob:ambulancemenu")
AddEventHandler("esx_ambulancejob:ambulancemenu", function()
	local elements = {
		{label = "Έλεγξε τον ασθενή",				value = 'check'},
		{label = _U('ems_menu_revive'),				value = 'revive'},
		--{label = "Βάλε νεκρό σε σακούλα",			value = 'deathbag'},
		--{label = "Στείλε τραυματία σε χειρουργείο",	value = 'surgery'},
		--{label = "Βάλε/Αφαίρεσε ηρεμιστική ένεση",	value = 'sedative'},
		--{label = "MDT Ambulance",					value = 'mdt'},
		--{label = "Ένεση Αδρεναλίνης",				value = 'remove_effect'},
		{label = "First Aid Kit",					value = 'first_aid_kit'},
		{label = _U('ems_menu_small'),				value = 'small'},
		{label = _U('ems_menu_big'),				value = 'big'},
		{label = _U('billing'),						value = 'billing'},
		{label = 'Set Bill Percent',				value = 'setbillpercent'},
	}

	if ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'chief_doctor' or ESX.PlayerData.job.grade_name == 'doctor' or ESX.PlayerData.job.grade_name == 'viceboss' then
		--table.insert(elements, {label = 'Crafting', value = 'crafting_menu'})
	end
	if ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = 'Employee Stats', value = 'stats'})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
		title    = _U('ems_menu_title'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if IsBusy then 
			return 
		end

		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if data.current.value == 'crafting_menu' then
			local elements2 = {
	
				{label = 'Bandage',       value = 'craftingBandage'},
				{label = 'Medkit',        value = 'craftingMedikit'}
			}
		  
			
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'crafting_menu',
			{
				title    = 'Crafting Menu',
				align    = 'bottom-right',
				elements = elements2
				}, function(data2, menu2)
				local action = data2.current.value
				
				if action == 'craftingBandage' then
					if not isCrafting then
						isCrafting = true
						TriggerServerEvent('esx_ambulancejob:craftingBandage')
						local playerPed = GetPlayerPed(-1)
						TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
						Citizen.Wait(9000)
						ClearPedTasksImmediately(playerPed)
						isCrafting = false
					else
						ESX.ShowNotification('You are already crafting!')
					end
				elseif action == 'craftingMedikit' then
					if not isCrafting then
						isCrafting = true
						TriggerServerEvent('esx_ambulancejob:craftingMedikit')
						local playerPed = GetPlayerPed(-1)
						TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
						Citizen.Wait(9000)
						ClearPedTasksImmediately(playerPed)
						isCrafting = false
					else
						ESX.ShowNotification('You are already crafting!')
					end
				end
			
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'stats' then
			local disabled = true
			
			if disabled then
				ESX.ShowNotification('This is currently disabled')
			end
		elseif data.current.value == 'mdt' then
			ESX.UI.Menu.CloseAll()
			ExecuteCommand('mdta')
			ExecuteCommand('e tablet')
		elseif data.current.value == 'remove_effect' then
			local myCoords = GetEntityCoords(PlayerPedId())
			
			TriggerServerEvent('3dme:showCloseIds',myCoords)
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'surgery_box', {
				title = 'ID of patient:'
			}, function(data70, menu70)
				if tonumber(GetPlayerServerId(PlayerId())) == tonumber(data70.value) then
					ESX.ShowNotification('Δεν μπορείς να το κάνεις αυτό στον εαυτό σου.')
				else
					local target = tonumber(data70.value)
					if GetPlayerFromServerId(target) ~= -1 and #(myCoords - GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) < 5.0 then
						ESX.TriggerServerCallback('esx_ambulancejob:getDeathState',function(result)
							if not result then
								TriggerServerEvent('esx_ambulancejob:removeEffect', data70.value)
							else
								ESX.ShowNotification('Ο παίκτης είναι νεκρός!')
							end
						end, data70.value)
					else
						ESX.ShowNotification('There is no player with that ID near you.')
					end
				end
				menu70.close()
			end, function(data70, menu70)
				ESX.UI.Menu.CloseAll()
			end)
		elseif data.current.value == 'first_aid_kit' then
			ESX.UI.Menu.CloseAll()
			
			local data = exports['dialog']:Create('Enter amount', 'The final price will be: amount*8000$')
			amount = tonumber(data.value)
			
			if amount and amount > 0 then
				TriggerServerEvent('esx_ambulancejob:buyFirstAid', amount)
			end
		elseif data.current.value == 'surgery' then
			local elements = {
				{label = 'Μικρό χειρουργείο 3000$',		value = 3000},
				{label = 'Μεσαίο χειρουργείο 6500$',	value = 6500},
				{label = 'Μεγάλο χειρουργείο 12000$',	value = 12000},
			}
			
			ESX.UI.Menu.CloseAll()
			
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'surgery_select', {
				title    = 'Επιλογές χειρουργείου',
				align    = 'bottom-right',
				elements = elements,
			},
			function(data, menu)
				local myCoords = GetEntityCoords(PlayerPedId())
				
				if #(myCoords - Config.Hospitals['CentralLosSantos'].Blip.coords) < 100 or #(myCoords - Config.Hospitals['PaletoBay'].Blip.coords) < 100 then
					TriggerServerEvent('3dme:showCloseIds',myCoords)
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'surgery_box', {
						title = 'ID of patient:'
					}, function(data70, menu70)
						if tonumber(GetPlayerServerId(PlayerId())) == tonumber(data70.value) then
							ESX.ShowNotification('Δεν μπορείς να το κάνεις αυτό στον εαυτό σου.')
						else
							local target = tonumber(data70.value)
							if GetPlayerFromServerId(target) ~= -1 and #(myCoords - GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) < 5.0 then
								ESX.TriggerServerCallback('esx_ambulancejob:getDeathState',function(result)
									if not result then
										ESX.TriggerServerCallback('esx_ambulancejob:canPaySurgery',function(yes)
											if yes then
												TriggerServerEvent('esx_beds:gethelp', data70.value, data.current.value)
											else
												ESX.ShowNotification('Δεν έχει αρκετα χρήματα')
											end
										end, data70.value, data.current.value)
									else
										ESX.ShowNotification('Ο παίκτης είναι νεκρός!')
									end
								end, data70.value)
							else
								ESX.ShowNotification('There is no player with that ID near you.')
							end
						end
						menu70.close()
					end, function(data70, menu70)
						ESX.UI.Menu.CloseAll()
					end)
				else
					ESX.ShowNotification('You are too far away from the hospital!')
				end
			end,
			function(data, menu)
				menu.close()
			end)
		elseif data.current.value == 'sedative' then
			local myCoords = GetEntityCoords(PlayerPedId())
			
			TriggerServerEvent('3dme:showCloseIds', myCoords)
			
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sedative_box', {
				title = 'ID of patient:'
			}, function(data70, menu70)
				if tonumber(GetPlayerServerId(PlayerId())) == tonumber(data70.value) then
					ESX.ShowNotification('Δεν μπορείς να το κάνεις αυτό στον εαυτό σου.')
				else
					local target = tonumber(data70.value)
					if GetPlayerFromServerId(target) ~= -1 and #(myCoords - GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) < 5.0 then
						ESX.TriggerServerCallback('esx_ambulancejob:getDeathState',function(result)
							if not result then
								TriggerServerEvent('esx_ambulancejob:toggleSedative', data70.value)
							else
								ESX.ShowNotification('Ο παίκτης είναι νεκρός!')
							end
						end,data70.value)
					else
						ESX.ShowNotification('There is no player with that ID near you.')
					end
				end
				menu70.close()
			end, function(data70, menu70)
				ESX.UI.Menu.CloseAll()
			end)
		else
			if closestPlayer == -1 or closestDistance > 3.0 then
				ESX.ShowNotification(_U('no_players'))
			else
				if data.current.value == 'deathbag' then
					ESX.TriggerServerCallback('esx_ambulancejob:getDeadStatus',function(result)
						if result then
							if not result.dead then
								ESX.ShowNotification('Citizen is not dead')
							elseif result.dead then
								if result.checked then
									exports['progressBars']:startUI(10000, "Putting the body in the death bag..")
									ExecuteCommand("e mechanic3")
									Wait(10000)
									ExecuteCommand("e c")
									--ClearPedTasks(PlayerPedId())
									TriggerServerEvent('esx_ambulancejob:SetDeathBag',GetPlayerServerId(closestPlayer))
								else 
									ESX.ShowNotification('Citizen is not checked')
								end
							end
						end
					end,GetPlayerServerId(closestPlayer))
				elseif data.current.value == 'revive' then
					menu.close()
					if not IsBusy then
						IsBusy = true
						ESX.TriggerServerCallback('esx_ambulancejob:getDeadStatus',function(result)

							if not result or not result.dead then
								if ESX.DoIHaveItem('medikit',1) then
									
										local closestPlayerPed = GetPlayerPed(closestPlayer)

										if IsPedDeadOrDying(closestPlayerPed, 1) then
											local playerPed = PlayerPedId()

											ESX.ShowNotification(_U('revive_inprogress'))

											local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

											for i=1, 15, 1 do
												Citizen.Wait(900)
										
												ESX.Streaming.RequestAnimDict(lib, function()
													TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
												end)
											end

											TriggerServerEvent('esx_ambulancejob:revlve', GetPlayerServerId(closestPlayer))

											-- Show revive award?
											if Config.ReviveReward > 0 then
												ESX.ShowNotification(_U('revive_complete_award', Config.ReviveReward))
											else
												ESX.ShowNotification(_U('revive_complete'))
											end
										else
											ESX.ShowNotification(_U('player_not_unconscious'))
										end
										
								else
									ESX.ShowNotification(_U('not_enough_medikit'))
								end
								IsBusy = false
							elseif result and result.dead then
								--[[ if result.checked then
									ESX.ShowNotification('Citizen is already checked by a doctor!')
									Wait(2000)
								else
									ESX.ShowNotification('Citizen is dead, but you get a '..Config.DeathReward..'$ bonus for it!')
									TriggerServerEvent('esx_ambulancejob:DeathReward',GetPlayerServerId(closestPlayer))
									TriggerServerEvent('esx_ambulancejob:setTargetChecked',GetPlayerServerId(closestPlayer))
								end ]]
								if not result.checked then
									ESX.ShowNotification('Citizen is not checked.')
								else 
									ESX.ShowNotification('Citizen is dead.')
								end
								IsBusy = false
							end
							
						end,GetPlayerServerId(closestPlayer))
					end
				elseif action == 'med' then
					TriggerEvent('medSystem:med', GetPlayerServerId(closestPlayer))

					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				elseif data.current.value == 'small' then

					if ESX.DoIHaveItem('bandage',1) then
						local closestPlayerPed = GetPlayerPed(closestPlayer)
						local health = GetEntityHealth(closestPlayerPed)

						if health > 0 then
							local playerPed = PlayerPedId()

							IsBusy = true
							ESX.ShowNotification(_U('heal_inprogress'))
							TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
							Citizen.Wait(10000)
							ClearPedTasks(playerPed)

							TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
							ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
							IsBusy = false
						else
							ESX.ShowNotification(_U('player_not_conscious'))
						end
					else
						ESX.ShowNotification(_U('not_enough_bandage'))
					
					end

				elseif data.current.value == 'big' then

					if ESX.DoIHaveItem('medikit',1) then
						
						local closestPlayerPed = GetPlayerPed(closestPlayer)
						local health = GetEntityHealth(closestPlayerPed)

						if health > 0 then
							local playerPed = PlayerPedId()

							IsBusy = true
							ESX.ShowNotification(_U('heal_inprogress'))
							TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
							Citizen.Wait(10000)
							ClearPedTasks(playerPed)

							TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
							ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
							IsBusy = false
						else
							ESX.ShowNotification(_U('player_not_conscious'))
						end
					
						
					else
						ESX.ShowNotification(_U('not_enough_bandage'))
					end

				elseif data.current.value == 'billing' then
						ESX.UI.Menu.Open(
						'dialog', GetCurrentResourceName(), 'billing',
						{
							title = _U('invoice_amount')
						},
						function(data, menu)
							local amount = tonumber(data.value)
							if amount == nil or amount < 0 or amount > 10000 then
								ESX.ShowNotification(_U('amount_invalid'))
								else
								
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								if closestPlayer == -1 or closestDistance > 4.0 then
									ESX.ShowNotification(_U('no_players_nearby'))
								else
									menu.close()
									TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))
									Wait(1000)
									local id = KeyboardInput("Enter Id","",math.floor(4))
									TriggerServerEvent('esx_billing:sendBiII', id, 'society_ambulance', _U('ambulance'), amount)
								end
							end
						end,
						function(data, menu)
						menu.close()
						end
						)
				elseif data.current.value == 'setbillpercent' then
					TriggerEvent('esx_billing:SetBillPercent')
				elseif data.current.value == 'put_in_vehicle' then
					TriggerServerEvent('esx_ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))
				elseif data.current.value == 'check' then
					IsBusy = true
					
					TriggerServerEvent('medSystem:sendMeCustom', GetPlayerServerId(closestPlayer))
					
					ESX.TriggerServerCallback('esx_ambulancejob:getDeadStatus',function(result)
						if result then
							if result.dead then
								if not result.checked then
									ESX.ShowNotification('Citizen is dead, but you get a '..Config.DeathReward..'$ bonus for it!')
									TriggerServerEvent('esx_ambulancejob:DeathReward',GetPlayerServerId(closestPlayer))
									TriggerServerEvent('esx_ambulancejob:setTargetChecked',GetPlayerServerId(closestPlayer))
								end
							end
						end
					end,GetPlayerServerId(closestPlayer))
					
					IsBusy = false
				end
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent("esx_ambulancejob:deadradar")
AddEventHandler("esx_ambulancejob:deadradar", function()
	if radarCd < GetGameTimer() then
		radarCd = GetGameTimer() + 30000
		DeadRadar()
		menu.close()
	else
		ESX.ShowNotification('Πρέπει να περιμένεις '..math.ceil((radarCd - GetGameTimer())/1000)..' δευτερόλεπτα')
	end
end)

RegisterNetEvent("esx_ambulancejob:wheelchair")
AddEventHandler("esx_ambulancejob:wheelchair", function()
	local coords = GetEntityCoords(PlayerPedId()) + GetEntityForwardVector(PlayerPedId())
	TriggerServerEvent('esx_ambulancejob:spawnWheelchairMobile', coords)
end)