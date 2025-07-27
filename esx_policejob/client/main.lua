ESX = nil

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

local PlayerData = {}


local HasAlreadyEnteredMarker = false
local LastStation, LastPart, LastPartNum, LastEntity
local CurrentAction = nil
local CurrentActionMsg  = ''
local CurrentActionData = {}
local IsHandcuffed = false
local HandcuffTimer = {}
local DragStatus = {}
DragStatus.IsDragged = false
local hasAlreadyJoined = false
local blipsCops = {}
local isDead = false
local onSuspension = false
local CurrentTask = {}
local playerInService = false
local spawnedVehicles, isInShopMenu = {}, false
local weaponStock = nil
local huntedList = {}
local textColor = "~r~"
local mpGamerTags = {}
local suspendedBlips = {}
local name
local surname
local license
local expire
local raw = 0
local obj_cooldown = 0

--gps tracker
local plates = {}
local enabled = false
local NoOfPlates = 0
local blips = {}

----
local showBlipsStatus = false
local Jobblips = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	
	while ESX.GetPlayerData().identifier == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	ESX.PlayerData = ESX.GetPlayerData()

	if ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'police2' then 
		showBlipsStatus = true
		showBlips()
	end
end)

local copBlips = {}
local oldCopData = {}

RegisterNetEvent('esx_policejob:sendCopData')
AddEventHandler('esx_policejob:sendCopData', function(copData)
	if PlayerData and PlayerData.job and (PlayerData.job.name == 'police' or PlayerData.job.name == 'police2') then
		if showBlipsStatus then
			for server_id,v in pairs(oldCopData) do
				if copData[server_id] == nil and DoesBlipExist(copBlips[server_id]) then
					RemoveBlip(copBlips[server_id])
				end
			end
			
			for server_id,v in pairs(copData) do
				local player = GetPlayerFromServerId(server_id)
				
				if player == -1 then
					if DoesBlipExist(copBlips[server_id]) then
						SetBlipCoords(copBlips[server_id], v.coords.x, v.coords.y, v.coords.z)
						SetBlipSprite(copBlips[server_id], (v.inVehicle and 225 or 1))
						SetBlipColour(copBlips[server_id], 3)
						BeginTextCommandSetBlipName('STRING')
						AddTextComponentString(v.name)
						EndTextCommandSetBlipName(copBlips[server_id])
					else
						local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
						SetBlipHighDetail(blip, true)
						SetBlipSprite(blip, (v.inVehicle and 225 or 1))
						SetBlipColour(blip, 3)
						SetBlipScale(blip, 1.0)
						BeginTextCommandSetBlipName('STRING')
						AddTextComponentString(v.name)
						EndTextCommandSetBlipName(blip)
						SetBlipCategory(blip, 7)
						
						copBlips[server_id] = blip
					end
				else
					if DoesBlipExist(copBlips[server_id]) then
						RemoveBlip(copBlips[server_id])
					end
				end
			end
			
			oldCopData = copData
		end
	end
end)

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function removeJobBlips()
    for k,v in pairs(GetActivePlayers()) do
        RemoveBlip(Jobblips[v])
    end
	
	for k,v in pairs(copBlips) do
		if DoesBlipExist(v) then
			RemoveBlip(v)
		end
	end
	
	copBlips = {}
	oldCopData = {}
end

function showBlips()
    if showBlipsStatus then
        CreateThread(function()
            local currentPlayer = PlayerId()
            
			while showBlipsStatus do
                for k,v in pairs(GetActivePlayers()) do
                    Wait(250)
					
					local sid = GetPlayerServerId(v)
					
					if sid > 0 then
						local targetjob = ESX.GetPlayerJob(sid)
						
						if targetjob and (targetjob.name == 'police' or targetjob.name == 'police2') then
							local playerPed = GetPlayerPed(v)
							local playerName = GetPlayerName(v)
							
							if (playerPed ~= GetPlayerPed(-1)) then
								local new_blip
								
								if GetBlipFromEntity(playerPed) < 1 then
									new_blip = AddBlipForEntity(playerPed)
									SetBlipNameToPlayerName(new_blip, v)

									if (not IsPedInAnyVehicle(playerPed)) then
										SetBlipSprite(new_blip, 1)
										if (IsPedDeadOrDying(playerPed, true) or IsEntityDead(playerPed)) then
											SetBlipColour(new_blip, 4)
										else
											SetBlipColour(new_blip, 3)
										end
									elseif (IsPedInAnyVehicle(playerPed)) then
										SetBlipSprite(new_blip, 225)
										if (IsPedDeadOrDying(playerPed, true) or IsEntityDead(playerPed)) then
											SetBlipColour(new_blip, 4)
										else
											SetBlipColour(new_blip, 3)
										end
									end

									SetBlipScale(new_blip, 1.0)

									SetBlipNameToPlayerName(new_blip, v)
									SetBlipCategory(new_blip, 7);
									SetBlipDisplay(new_blip, 6)
									SetBlipNameToPlayerName(new_blip, v)
									Jobblips[v] = new_blip
								else
									new_blip = GetBlipFromEntity(playerPed)			
								end
								
								if (not IsPedInAnyVehicle(playerPed)) then
									SetBlipSprite(new_blip, 1)
									
									if (IsPedDeadOrDying(playerPed, true) or IsEntityDead(playerPed)) then
										SetBlipColour(new_blip, 4)
									else
										SetBlipColour(new_blip, 3)
									end
								elseif (IsPedInAnyVehicle(playerPed)) then
									local class = GetVehicleClass(GetVehiclePedIsIn(playerPed, false))
									
									if class == 15 then
										SetBlipSprite(new_blip, 43)
									else
										SetBlipSprite(new_blip, 225)
									end
									
									if (IsPedDeadOrDying(playerPed, true) or IsEntityDead(playerPed)) then
										SetBlipColour(new_blip,4)
									else
										SetBlipColour(new_blip, 3)
									end
								end
								
								SetBlipNameToPlayerName(new_blip, v)
							end
						end
					end
                end
				
                Wait(100)
            end
			
            removeJobBlips()
        end)
    end
end

function setUniform(job, playerPed)
	local prevarmor = GetPedArmour(PlayerPedId())
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'officer_bullet' then
				SetPedArmour(playerPed, 100)
			elseif job == 'astifilakas_bullet' then
				SetPedArmour(playerPed, 100)
			elseif job == 'sergeant_bullet' then
				SetPedArmour(playerPed, 100)
			elseif job == 'anthipastinomos_bullet' then
				SetPedArmour(playerPed, 100)
			elseif job == 'ypastinomos_bullet' then
				SetPedArmour(playerPed, 100)
			elseif job == 'opke_wear' then
				SetPedArmour(playerPed, 100)
			elseif job == 'boss_opke_wear' then
				SetPedArmour(playerPed, 100)
			elseif job == 'lieutenant_bullet' then
				SetPedArmour(playerPed, 100)
			elseif job == 'chef_bullet' then
				SetPedArmour(playerPed, 100)
			elseif job == 'boss_bullet' then
				SetPedArmour(playerPed, 100)
			elseif job == 'dias_bullet' then
				SetPedArmour(playerPed, 100)
			elseif job == 'boss_dias_bullet' then
				SetPedArmour(playerPed, 100)
			end
			SetPedArmour(playerPed, 100)
		else
			if Config.Uniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'officer_bullet' then
				SetPedArmour(playerPed, 100)
			elseif job == 'astifilakas_bullet' then
				SetPedArmour(playerPed, 100)
			elseif job == 'sergeant_bullet' then
				SetPedArmour(playerPed, 100)
			elseif job == 'anthipastinomos_bullet' then
				SetPedArmour(playerPed, 100)
			elseif job == 'ypastinomos_bullet' then
				SetPedArmour(playerPed, 100)
			elseif job == 'opke_wear' then
				SetPedArmour(playerPed, 100)
			elseif job == 'boss_opke_wear' then
				SetPedArmour(playerPed, 100)
			elseif job == 'lieutenant_bullet' then
				SetPedArmour(playerPed, 100)
			elseif job == 'chef_bullet' then
				SetPedArmour(playerPed, 100)
			elseif job == 'boss_bullet' then
				SetPedArmour(playerPed, 100)
			elseif job == 'dias_bullet' then
				SetPedArmour(playerPed, 100)
			elseif job == 'boss_dias_bullet' then
				SetPedArmour(playerPed, 100)
			end
			SetPedArmour(playerPed, 100)
		end
	end)
end

function OpenCloakroomMenu()

	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade
	local elements = {
		{ label = _U('citizen_wear'), value = 'citizen_wear' },
	--	{ label = _U('gilet_wear'), value = 'gilet_wear' }
	}

	if grade == 0 then
		table.insert(elements, {label = "Αστυνομία - Μπλουζάκι", value = 'astifilakas_wear'})
	elseif grade >= 1 and grade ~= 10 and grade ~= 11 and grade ~= 12 and grade ~= 13 and grade ~= 16 and grade ~= 17  and grade ~= 18  and grade ~= 19  and grade ~= 20  and grade ~= 21 then
		table.insert(elements, {label = "Αστυνομία - Μπλουζάκι", value = 'astifilakas_wear'})
		table.insert(elements, {label = "Αστυνομία - Μακρυμάνικο", value = 'astifilakas_wearW'})
		table.insert(elements, {label = "Αστυνομία - Υπηρεσίας Κοντομανικο", value = 'astifilakas_wearYpiresias'})
		table.insert(elements, {label = "Αστυνομία - Υπηρεσίας Μακρυμάνικο", value = 'astifilakas_wearYpiresias2'})
		table.insert(elements, {label = "Αστυνομία - Αθλητικό", value = 'astifilakas_wearSport'})
		table.insert(elements, {label = "Αστυνομία - Πιλότος", value = 'astifilakas_wearPilot'})
	elseif grade == 16 or grade == 17 then
		table.insert(elements, {label = "ΔΙΑΣ - Μηχανής", value = 'dias_wear'})
		table.insert(elements, {label = "ΔΙΑΣ - Μπλούζα", value = 'dias_wearMplouza'})
	elseif grade == 18 or grade == 20 then
		table.insert(elements, {label = "ΟΠΚΕ - Μπλούζα", value = 'opke_wear'})
		table.insert(elements, {label = "ΟΠΚΕ - Μακρυμάνικο", value = 'opke_wear2'})
		table.insert(elements, {label = "ΟΠΚΕ - Φούτερ", value = 'opke_wear3'})
		table.insert(elements, {label = "ΟΠΚΕ - Αθλητικό Μακρυμάνικο", value = 'opke_wear4'})
		table.insert(elements, {label = "ΟΠΚΕ - Ζακέτα", value = 'opke_wear5'})
		table.insert(elements, {label = "ΟΠΚΕ - Αθλητικό", value = 'opke_wear6'})
		table.insert(elements, {label = "ΟΠΚΕ - Αθλητικό 2", value = 'opke_wear7'})
		table.insert(elements, {label = "ΟΠΚΕ - Επιχείρησης", value = 'opke_wear8'})
	elseif grade == 19 or grade == 21 then
		table.insert(elements, {label = "ΕΚΑΜ - Αθλητικό Μακρυμάνικο", value = 'ekam_wear'})
		table.insert(elements, {label = "ΕΚΑΜ - Επιχείρησης", value = 'ekam_wear2'})
	end
	
	if grade >= 24 then
		table.insert(elements, {label = "Αστυνομία - Ζακέτα", value = 'astifilakas_wearJacket'})
	end
	
	if grade == 25 then
		table.insert(elements, {label = "Αστυνομία - Φούτερ", value = 'astifilakas_wearF'})
	end

	if Config.EnableNonFreemodePeds then
		--table.insert(elements, {label = 'Sheriff wear', value = 'freemode_ped', maleModel = 's_m_y_sheriff_01', femaleModel = 's_f_y_sheriff_01'})
		--table.insert(elements, {label = 'Police wear', value = 'freemode_ped', maleModel = 's_m_y_cop_01', femaleModel = 's_f_y_cop_01'})
		--table.insert(elements, {label = 'Στολή Ε.Κ.Α.Μ', value = 'freemode_ped', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'})
		--table.insert(elements, {label = 'ΠΑΠΑΠ', value = 'freemode_ped', maleModel = 'u_m_m_spyactor', femaleModel = 'u_m_m_spyactor'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	{
		title    = _U('cloakroom'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)

		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then
			
			if Config.EnableNonFreemodePeds then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					local isMale = skin.sex == 0
					
					TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
							TriggerEvent('esx:restoreLoadout')
						end)
					end)

				end)
			else
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end


		end
		if
			data.current.value == 'recruit_wear' or
			data.current.value == 'recruit_wearW' or
			data.current.value == 'recruit_bullet' or
			--
			data.current.value == 'astifilakas_wear' or
			data.current.value == 'astifilakas_wearW' or
			data.current.value == 'astifilakas_wearF' or
			data.current.value == 'astifilakas_wearYpiresias' or
			data.current.value == 'astifilakas_wearYpiresias2' or
			data.current.value == 'astifilakas_wearSport' or
			data.current.value == 'astifilakas_wearPilot' or
			data.current.value == 'astifilakas_wearJacket' or
			--
			data.current.value == 'limeniko_wearJacket' or 
			data.current.value == 'limeniko_wearScuba' or 
			data.current.value == 'limeniko_wearLimenarxis' or 
			data.current.value == 'limeniko_wearJacket2' or 
			data.current.value == 'limeniko_wearJacket3' or 
			data.current.value == 'limeniko_wear' or 
			--
			data.current.value == 'dias_wear' or
			data.current.value == 'dias_wearMplouza' or
			data.current.value == 'dias_wear' or
			--
			data.current.value == 'opke_wear' or
			data.current.value == 'opke_wear2' or
			data.current.value == 'opke_wear3' or
			data.current.value == 'opke_wear4' or
			data.current.value == 'opke_wear5' or
			data.current.value == 'opke_wear6' or
			data.current.value == 'opke_wear7' or
			data.current.value == 'opke_wear8' or
			
			data.current.value == 'ekam_wear' or
			data.current.value == 'ekam_wear2' 
		then
			setUniform(data.current.value, playerPed)
		end

		if data.current.value == 'freemode_ped' then
			local modelHash = ''
			local prevarmor = GetPedArmour(PlayerPedId())
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					modelHash = GetHashKey(data.current.maleModel)
				else
					modelHash = GetHashKey(data.current.femaleModel)
				end

				ESX.Streaming.RequestModel(modelHash, function()
					SetPlayerModel(PlayerId(), modelHash)
					SetModelAsNoLongerNeeded(modelHash)

					TriggerEvent('esx:restoreLoadout')
					SetPedArmour(PlayerPedId(),prevarmor)
				end)
			end)

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end)
end

function OpenItemsMenu()
	ClearPedTasksImmediately(PlayerPedId())
	local elements = {
	}

	if Config.EnableArmoryManagement and (PlayerData.job.grade_name == 'boss' or PlayerData.job.grade == 21 or PlayerData.job.grade_name == 'canrestock') then
		table.insert(elements, {label = _U('remove_object'),  value = 'get_stock'})	
		table.insert(elements, {label = _U('deposit_object'), value = 'put_stock'})
	else

		table.insert(elements, {label = _U('deposit_object'), value = 'put_stock'})
	end

	ESX.UI.Menu.CloseAll()

	CreateThread(function()
		while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'armory') do
			Wait(0)
		end
		
		while ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'armory') do
			Wait(0)
			TriggerEvent("closeInventory",true)
			TriggerEvent('esx_inventoryhud:canGiveItem',false)
			DisableControlAction(0 , 289 , true)
		end
		TriggerEvent('esx_inventoryhud:canGiveItem',true)
	end)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory',
	{
		title    = _U('armory'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)

	
		if data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		end

	end, function(data, menu)
		menu.close()

		
	end)
end

function OpenArmoryMenu()
	ClearPedTasksImmediately(PlayerPedId())
	local elements = {}

	table.insert(elements, {label = _U('buy_weapons'),     value = 'buy_weapons'})
	
	if PlayerData.job.grade >= Config.BuyAttachmentsMinGrade then
		table.insert(elements, {label = _U('buy_attachments'),     value = 'buy_attachments'})
	end

	ESX.UI.Menu.CloseAll()

	CreateThread(function()
		while not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'armory') do
			Wait(0)
		end
		
		while ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'armory') do
			Wait(100)
			TriggerEvent("closeInventory",true)
			TriggerEvent('esx_inventoryhud:canGiveItem',false)
			DisableControlAction(0 , 289 , true)
		end
		TriggerEvent('esx_inventoryhud:canGiveItem',true)
	end)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory',
	{
		title    = _U('armory'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'buy_weapons' then
			OpenBuyWeaponsMenu()
		elseif data.current.value == 'buy_attachments' then
			OpenBuyAttachmentsMenu()
		end

	end, function(data, menu)
		menu.close()
	end)
end

function OpenStockArmoryMenu()
	ClearPedTasksImmediately(PlayerPedId())
	local elements = {
	}

	if weaponStock == nil then
		return
	end
	local elements = {}
	local playerPed = PlayerPedId()
	PlayerData = ESX.GetPlayerData()
	for k,v in ipairs(Config.AuthorizedWeapons[PlayerData.job.grade]) do
		if weaponStock[v.weapon] then
			local weaponNum, weapon = ESX.GetWeapon(v.weapon)
			if weapon == nil then
				print("Weapon : "..v.weapon.." doesn't exist in Config.weapon.lua in Resource: es_extended")
			else
				local components, label = {}

				local hasWeapon = HasPedGotWeapon(playerPed, GetHashKey(v.weapon), false)

			

				if hasWeapon and v.components then
					label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
				elseif hasWeapon and not v.components then
					label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_owned'))
				else
					if v.price > 0 then
						local wquantity = weaponStock[v.weapon].quantity
						label = weapon.label..': <span style="color:green;">'..--[[ .._U('armory_item', ESX.Math.GroupDigits(v.price)).. ]]' Stock: '..wquantity..'</span>'
					else
						label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_free'))
					end
				end

				table.insert(elements, {
					label = label,
					weaponLabel = weapon.label,
					name = weapon.name,
					components = components,
					price = v.price,
					hasWeapon = hasWeapon
				})
			end
		end
		
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons', {
		title    = _U('armory_weapontitle'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)

		if data.current.hasWeapon then
			if #data.current.components > 0 then
			end
		else
			ESX.TriggerServerCallback('esx_policejob:buyStockWeap0n', function(bought)
				if bought then
					--if data.current.price > 0 then
						ESX.ShowNotification(--[[ _U('armory_bought', data.current.weaponLabel, ESX.Math.GroupDigits(data.current.price)) ]]"Τράβηξες όπλο από την αποθήκη")
					--end

					menu.close()

				else
					ESX.ShowNotification(_U('armory_money'))
				end
			end, data.current.name, 1)
		end

	end, function(data, menu)
		menu.close()
	end)

end

function OpenVehicleSpawnerMenu(type,location)
	local playerCoords = GetEntityCoords(PlayerPedId())
	CreateThread(function()
		local startCoords = playerCoords
		Wait(1000)
		while ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'vehicle') do 
			Wait(500)
		end
		Wait(500)
		if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then 
			ESX.Game.Teleport(PlayerPedId(), startCoords)
		end
	end)
	PlayerData = ESX.GetPlayerData()
	local elements = {}
	if type == "helicopter" then
		elements = {
			{label = _U('garage_storeditem'), action = 'garage'},
			{label = _U('garage_storeitem'), action = 'store_garage'}, 
			{label = _U('garage_buyitem'), action = 'buy_vehicle'}
		}
	elseif type == "boat" then
		elements = {
			{label = _U('garage_storeditem'), action = 'garage'},
			{label = _U('garage_storeitem'), action = 'store_garage'}, 
			{label = _U('garage_buyitem'), action = 'buy_vehicle'}
		}
	else
		elements = {
			--[[ {label = _U('garage_storeditem'), action = 'garage'},
			{label = _U('garage_storeitem'), action = 'store_garage'}, ]]
			{label = _U('garage_buyitem'), action = 'buy_vehicle'}
		}
	end
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title    = _U('garage_title'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.action == 'buy_vehicle' then
			menu.close()
			local shopElements, shopCoords = {}

			if type == 'car' then
				shopCoords = Config.PoliceStations["LSPD"].Vehicles.InsideShop

				if location == 'Paleto' then
					shopCoords = Config.PoliceStations["LSPD"].Vehicles.InsideShopPaleto
				elseif location == 'Vespucci' then
					shopCoords = Config.PoliceStations["LSPD"].Vehicles.InsideShopVespucci
				elseif location == 'Police1' then
					shopCoords = Config.PoliceStations["LSPD"].Vehicles.InsideShopPolice1
				end

				if PlayerData.job.name == 'police2' then
					shopCoords = Config.PoliceStations['Police2'].Vehicles.InsideShop
				end

				local authorizedVehicles = Config.AuthorizedVehicles[PlayerData.job.grade]

				if #Config.AuthorizedVehicles['Shared'] > 0 then
					for k,vehicle in ipairs(Config.AuthorizedVehicles['Shared']) do
						table.insert(shopElements, {
							label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
							name  = vehicle.label,
							model = vehicle.model,
							price = vehicle.price,
							livery = vehicle.livery or nil,
							type  = 'car'
						})
					end
				end

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
					if #Config.AuthorizedVehicles['Shared'] == 0 then
						return
					end
				end
			elseif type == 'helicopter' then
				shopCoords = Config.PoliceStations["LSPD"].Helicopters.InsideShop

				if location == 'Paleto' then
					shopCoords = Config.PoliceStations["LSPD"].Helicopters.InsideShopPaleto
				elseif location == 'Vespucci' then
					shopCoords = Config.PoliceStations["LSPD"].Helicopters.InsideShopVespucci
				end

				if PlayerData.job.name == 'police2' then
					shopCoords = Config.PoliceStations['Police2'].Helicopters.InsideShop
				end

				local authorizedHelicopters = Config.AuthorizedHelicopters[PlayerData.job.grade]

				if #authorizedHelicopters > 0 then
					for k,vehicle in ipairs(authorizedHelicopters) do
						table.insert(shopElements, {
							label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
							name  = vehicle.label,
							model = vehicle.model,
							price = vehicle.price,
							livery = vehicle.livery or nil,
							type  = 'helicopter'
						})
					end
				else
					ESX.ShowNotification(_U('helicopter_notauthorized'))
					return
				end
			elseif type == 'boat' then
				shopCoords = Config.PoliceStations["LSPD"].Boats.InsideShop

				if PlayerData.job.name == 'police2' then
					shopCoords = Config.PoliceStations['Police2'].Boats.InsideShop
				end

				local authorizedBoats = Config.AuthorizedBoats[PlayerData.job.grade]

				if #authorizedBoats > 0 then
					for k,vehicle in ipairs(authorizedBoats) do
						table.insert(shopElements, {
							label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
							name  = vehicle.label,
							model = vehicle.model,
							price = vehicle.price,
							livery = vehicle.livery or nil,
							type  = 'boat'
						})
					end
				else
					ESX.ShowNotification(_U('boat_notauthorized'))
					return
				end
			end
			OpenShopMenu(shopElements, playerCoords, shopCoords)
		elseif data.current.action == 'garage' then
			local garage = {}

			ESX.TriggerServerCallback('esx_policejob:retrieveJobVehicles', function(jobVehicles)
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

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
						title    = _U('garage_title'),
						align    = 'bottom-right',
						elements = garage
					}, function(data2, menu2)
						if data2.current.stored then
							local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(type,location)

							if foundSpawn then
								menu2.close()
								ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
									ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)
								
									TriggerServerEvent('esx_policejob:setJobVehicleState' , data2.current.vehicleProps.plate, false)
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
			end, type)

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

	ESX.TriggerServerCallback('esx_policejob:storeNearbyVehicle', function(storeSuccess, foundNum)
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

function GetAvailableVehicleSpawnPoint(type,location)
	local points 
	if location == "Paleto" then
		points = "SpawnPointsPaleto"
	elseif location == "Vespucci" then
		points = "SpawnPointsVespucci"
	elseif location == "Police1" then
		points = "SpawnPointsPolice1"
	else
		points = "SpawnPoints"
	end
	local spawnPoints
	if type == 'boat' then
		spawnPoints = Config.PoliceStations["LSPD"]["Boats"][points]	
	elseif type == 'helicopter' then
		spawnPoints = Config.PoliceStations["LSPD"]["Helicopters"][points]	
	elseif type == 'car' then
		spawnPoints = Config.PoliceStations["LSPD"]["Vehicles"][points]	
	end
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
		ESX.ShowNotification(_U('vehicle_blocked'))
		return false
	end
end

function OpenShopMenu(elements, restoreCoords, shopCoords)
	local playerPed = PlayerPedId()
	isInShopMenu = true
	Citizen.CreateThread(function()
		while isInShopMenu do
			Citizen.Wait(0)
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end
	end)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
		title    = _U('vehicleshop_title'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if not WaitForVehicleToLoad(data.current.model) then
			return
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop_confirm',
		{
			title    = _U('vehicleshop_confirm', data.current.name, data.current.price),
			align    = 'bottom-right',
			elements = {
				{ label = _U('confirm_no'), value = 'no' },
				{ label = _U('confirm_yes'), value = 'yes' }
			}
		}, function(data2, menu2)

			if data2.current.value == 'yes' then
				local newPlate = GeneratePlate()
				local vehicle  = GetVehiclePedIsIn(playerPed, false)
				local props    = ESX.Game.GetVehicleProperties(vehicle)
				props.plate    = newPlate
				props.livery   = GetVehicleLivery(vehicle)

				ESX.TriggerServerCallback('esx_policejob:buyJobVehicle', function (bought)
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
			ESX.Game.SpawnLocalVehicle(data.current.model, vector3(shopCoords.x, shopCoords.y, shopCoords.z), shopCoords.w, function(vehicle)
				table.insert(spawnedVehicles, vehicle)
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
				FreezeEntityPosition(vehicle, true)

				if data.current.livery then
					SetVehicleModKit(vehicle, 0)
					SetVehicleLivery(vehicle, data.current.livery)
					SetVehicleColours(vehicle, 112,112)
				end
			end)
		else
			ESX.ShowNotification('Model not found')
		end
	end)

	if WaitForVehicleToLoad(elements[1].model) then
		ESX.Game.SpawnLocalVehicle(elements[1].model, vector3(shopCoords.x, shopCoords.y, shopCoords.z), shopCoords.w, function(vehicle)
			table.insert(spawnedVehicles, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)

			if elements[1].livery then
				SetVehicleModKit(vehicle, 0)
				SetVehicleLivery(vehicle,elements[1].livery)
				SetVehicleColours(vehicle, 112,112)
			end
		end)
	else
		ESX.ShowNotification('Model not found')
	end
end

function DeleteSpawnedVehicles()
	while #spawnedVehicles > 0 do
		local vehicle = spawnedVehicles[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(spawnedVehicles, 1)
	end
end

function TrimPlate(plate)
	if plate then
		local tmp = string.lower(plate)
		return string.gsub(tmp," ","")
	end
	
	return nil
end

function WaitForVehicleToLoad(modelHash)
	local before = GetGameTimer()/1000
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if IsModelInCdimage(modelHash) then
		if not HasModelLoaded(modelHash) then
			RequestModel(modelHash)

			while not HasModelLoaded(modelHash) do
				Citizen.Wait(0)
				local now = GetGameTimer()/1000
				if (now - before) > 30 then
					ESX.ShowNotification("~r~Failed to load Vehicle. Perhaps too slow internet Or vehicle doesn't exist")
					break
				end
				DisableControlAction(0, Keys['TOP'], true)
				DisableControlAction(0, Keys['DOWN'], true)
				DisableControlAction(0, Keys['LEFT'], true)
				DisableControlAction(0, Keys['RIGHT'], true)
				DisableControlAction(0, 176, true) -- ENTER key
				DisableControlAction(0, Keys['BACKSPACE'], true)

				drawLoadingText(_U('vehicleshop_awaiting_model').."  ("..math.floor(now - before).."/~r~30~w~)", 255, 255, 255, 255)
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

function OpenPoliceActionsMenu()
	ESX.UI.Menu.CloseAll()
	local elements = {
		{label = _U('citizen_interaction'),	value = 'citizen_interaction'},
		{label = _U('vehicle_interaction'),	value = 'vehicle_interaction'},
		{label = _U('object_spawner'),		value = 'object_spawner'},
		{label = "Panic Button",			value = 'panic_button'},
		--{label = "Police Dog",				value = 'poldog'},
		--[[ {label = "Shield",					value = 'shield'}, ]]
		{label = "CCTVs",					value = 'cctv_menu'},
		{label = "Start Patrol",			value = 'start_patrol'},
		{label = "Stop Patrol",				value = 'stop_patrol'},
		{label = "Set Bill Percent",		value = 'setbillpercent'},
	}
	if PlayerData.job.grade >= 23 or PlayerData.job.grade == 7 then
		table.insert(elements, {label = 'Άδεια Οπλοκατοχής', value = 'weapon_license'})
	end
	if PlayerData.job.grade >= 5 and PlayerData.job.grade ~= 8 and PlayerData.job.grade ~= 14 then
		--table.insert(elements, {label = 'Ληστείες', value = 'robbs'})
		table.insert(elements, {label = 'GPS Tracker', value = 'tracker'})
	end

	if PlayerData.job.grade == 24 or PlayerData.job.grade == 25 then
		table.insert(elements, {label = 'Ληστείες', value = 'robbs'})
	end


	if PlayerData.job.grade == 13 or PlayerData.job.grade == 14 then
		table.insert(elements, {label = 'Δες Λίστα Επικυρηγμένων',value = 'huntedlist'})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions_dafaw',
	{
		title    = 'Police',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'citizen_interaction' then
			local elements = {
				--{label = _U('id_card'),				value = 'identity_card'},
				--{label = _U('search'),				value = 'body_search'},
				{label = _U('handcuff'),			value = 'handcuff'},
				{label = _U('drag'),				value = 'drag'},
				{label = _U('put_in_vehicle'),		value = 'put_in_vehicle'},
				{label = _U('out_the_vehicle'),		value = 'out_the_vehicle'},
				{label = _U('fine'),				value = 'fine'},
				--{label = _U('jail'),				value = 'jail'},
				--{label = _U('Commmunity_service'),	value = 'communityservice'},
				{label = "Στείλε φυλακή",			value = 'jail'},
				{label = "Έλεγχος πόλιτη",			value = 'check_civilian'},
			}
		
			if Config.EnableLicenses and PlayerData.job.grade >= 1 then
				table.insert(elements, { label = _U('license_check'), value = 'license' })
			end
		

			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title    = _U('citizen_interaction'),
				align    = 'bottom-right',
				elements = elements
			}, function(data2, menu2)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					local action = data2.current.value

					if action == 'identity_card' then
						OpenIdentityCardMenu(closestPlayer)
					--[[ elseif action == 'body_search' then
						TriggerServerEvent('esx_policejob:message' , GetPlayerServerId(closestPlayer), _U('being_searched'))
						OpenBodySearchMenu(closestPlayer) ]]
					elseif action == 'check_civilian' then
						CheckCivilianMenu()
					elseif action == 'handcuff' then
						if GlobalState.inEvent ~= 'battleRoyale' then
							TriggerServerEvent('esx_policejob:handcuff' , GetPlayerServerId(closestPlayer))
						end
					elseif action == 'drag' then
						TriggerServerEvent('esx_policejob:drag' , GetPlayerServerId(closestPlayer))
					elseif action == 'put_in_vehicle' then
						TriggerServerEvent('esx_policejob:putInVehicle' , GetPlayerServerId(closestPlayer))
					elseif action == 'out_the_vehicle' then
						TriggerServerEvent('esx_policejob:OutVehicle' , GetPlayerServerId(closestPlayer))
					elseif action == 'fine' then
						OpenFineMenu(closestPlayer)
					elseif action == 'license' then
						ShowPlayerLicense(closestPlayer)
					elseif action == 'jail' then
						TriggerEvent('esx-qalle-jail:openJailMenu', "police")
					elseif action == 'communityservice' then
						TriggerServerEvent('3dme:showCloseIds',GetEntityCoords(PlayerPedId()))
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'comm_serv', {
							title = 'Choose ID'
						}, function(data70, menu70)
							if tonumber(GetPlayerServerId(PlayerId())) == tonumber(data70.value) then
								ESX.ShowNotification('You can\'t send yourself for community service!')
							else
								--local targetCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(data70.value)))

								--if GetDistanceBetweenCoords(targetCoords, vector3(932.43,-278.7,67.09),true) < 20 then
									SendToCommunityService(data70.value)
								--else
									--ESX.ShowNotification("Πρέπει να κάνεις μεταγωγή τον κρατούμενο για να τον στείλεις κοινωνική εργασία")
								--end
							end
							menu70.close()
						end, function(data70, menu70)
							ESX.UI.Menu.CloseAll()
						end)
					elseif action == 'jail' then
						TriggerServerEvent('3dme:showCloseIds',GetEntityCoords(PlayerPedId()))
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'comm_serv', {
							title = 'Choose ID'
						}, function(data71, menu71)
							if tonumber(GetPlayerServerId(PlayerId())) == tonumber(data71.value) then
								ESX.ShowNotification('You can\'t send yourself to jail!')
							else
								JailPlayer()
							end
							menu71.close()
						end, function(data71, menu71)
							ESX.UI.Menu.CloseAll()
						end)
					end

				else
					ESX.ShowNotification(_U('no_players_nearby'))
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'huntedlist' then
			OpenHuntedList()
		elseif data.current.value == 'poldog' then
			TriggerEvent('K9:OpenMenu')
		elseif data.current.value == 'cctv_menu' then
			ExecuteCommand('cctv')
		elseif data.current.value == 'shield' then
			TriggerEvent('Client:toggleShield')
		elseif data.current.value == 'start_patrol' then
			TriggerEvent('policePatrol:openMenu')
		elseif data.current.value == 'stop_patrol' then
			TriggerEvent('policePatrol:stopPatrol')
		elseif data.current.value == 'setbillpercent' then
			TriggerEvent('esx_billing:SetBillPercent')
		elseif data.current.value == 'vehicle_interaction' then
			local elements  = {}
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local vehicle   = ESX.Game.GetVehicleInDirection()
			
			if DoesEntityExist(vehicle) then
				table.insert(elements, {label = _U('pick_lock'),	value = 'hijack_vehicle'})
				table.insert(elements, {label = _U('fineVehicle'),			value = 'fineVehicle'})
				table.insert(elements, {label = _U('impound'),		value = 'impound'})
				table.insert(elements, {label = 'Δες Ιδιοκτήτη Οχήματος',		value = 'getVehOwner'})
				
			else
				ESX.ShowNotification("No Vehicle Nearby")
				return
			end
			

			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vehicle_interaction',
			{
				title    = _U('vehicle_interaction'),
				align    = 'bottom-right',
				elements = elements
			}, function(data, menu)
				coords  = GetEntityCoords(playerPed)
				vehicle = ESX.Game.GetVehicleInDirection()
				action  = data.current.value
				
				if action == 'search_database' then
					LookupVehicle()
				elseif DoesEntityExist(vehicle) then
					local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
					if action == 'vehicle_infos' then
						OpenVehicleInfosMenu(vehicleData)
					elseif action == 'fineVehicle' then
						OpenFineVehicleMenu(vehicle)
					elseif action == 'getVehOwner' then
						OpenGetVehicleOwnerMenu(vehicle)	
					elseif action == 'hijack_vehicle' then
						if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
							TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
							Citizen.Wait(20000)
							ClearPedTasksImmediately(playerPed)

							SetVehicleDoorsLocked(vehicle, 1)
							SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							ESX.ShowNotification(_U('vehicle_unlocked'))
						end
					elseif action == 'impound' then
					
						-- is the script busy?
						if CurrentTask.Busy then
							return
						end

						ESX.ShowHelpNotification(_U('impound_prompt'))
						
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
						
						CurrentTask.Busy = true
						CurrentTask.Task = ESX.SetTimeout(10000, function()
							ClearPedTasks(playerPed)
							ImpoundVehicle(vehicle)
							Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
						end)
						
						-- keep track of that vehicle!
						Citizen.CreateThread(function()
							while CurrentTask.Busy do
								Citizen.Wait(1000)
							
								vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
								if not DoesEntityExist(vehicle) and CurrentTask.Busy then
									ESX.ShowNotification(_U('impound_canceled_moved'))
									ESX.ClearTimeout(CurrentTask.Task)
									ClearPedTasks(playerPed)
									CurrentTask.Busy = false
									break
								end
							end
						end)
					end
				else
					ESX.ShowNotification(_U('no_vehicles_nearby'))
				end

			end, function(data, menu)
				menu.close()
			end)

		elseif data.current.value == 'object_spawner' then
			local objs = {
				--[[ 'prop_roadcone02a', ]]
				'prop_barrier_work05',
				'p_ld_stinger_s',
				'prop_boxpile_07d',
				'hei_prop_cash_crate_half_full'
			}
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title    = _U('traffic_interaction'),
				align    = 'bottom-right',
				elements = {
				--[[ 	{label = _U('cone'),		value = 'prop_roadcone02a'}, ]]
					{label = _U('barrier'),		value = 'prop_barrier_work05'},
					{label = _U('spikestrips'),	value = 'p_ld_stinger_s'},
					{label = _U('box'),			value = 'prop_boxpile_07d'},
					{label = _U('cash'),		value = 'hei_prop_cash_crate_half_full'},
					{label = 'Μάζεψε Αντικείμενο',		value = 'delete'}
				}
			}, function(data2, menu2)
				if data2.current.value == 'delete' then
					local playerPed = PlayerPedId()
					local coords    = GetEntityCoords(playerPed)

					local closestDistance = -1
					local closestEntity   = nil
					for i=1, #objs, 1 do
						local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(objs[i]), false, false, false)
			
						if DoesEntityExist(object) then
							local objCoords = GetEntityCoords(object)
							local distance  = GetDistanceBetweenCoords(coords, objCoords, true)
			
							if closestDistance == -1 or closestDistance > distance then
								closestDistance = distance
								closestEntity   = object
							end
						end
					end
					if closestEntity and closestDistance < 5 then
						SetEntityAsNoLongerNeeded(closestEntity)
                        ESX.Game.DeleteObject(closestEntity)
                        DeleteEntity(closestEntity)
					else
						ESX.ShowNotification('No object nearby')
					end
				else
					ESX.TriggerServerCallback('esx_policejob:object_limiter', function(cd) 
						obj_cooldown = cd
					end)
					
					Wait(1200)
					if obj_cooldown > 10 then
						ESX.ShowNotification('You cannot spawn more than 10 objects per restart')
						return
					end
					local model     = data2.current.value
					local playerPed = PlayerPedId()
					local coords    = GetEntityCoords(playerPed)
					local forward   = GetEntityForwardVector(playerPed)
					local x, y, z   = table.unpack(coords + forward * 1.0)

					if model == 'prop_roadcone02a' then
						z = z - 2.0
					end

					ESX.Game.SpawnObject(model, {
						x = x,
						y = y,
						z = z
					}, function(obj)
						SetEntityHeading(obj, GetEntityHeading(playerPed))
						PlaceObjectOnGroundProperly(obj)
					end)
				end

			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'panic_button' then
			TriggerServerEvent('esx_policejob:usePanicButton')
		elseif data.current.value == 'robbs' then
			
			local elements = {
				{label = "Απενεργοποίηση Ληστείων",	value = 'disable_robb'},
				{label = "Ενεργοποίηση Ληστείων",	value = 'enable_robb'},
			}

			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'robb_interaction',
			{
				title    = "Ληστείες",
				align    = 'bottom-right',
				elements = elements
			}, function(data2, menu2)
				local action = data2.current.value

				if action == 'disable_robb' then
					TriggerServerEvent('esx_policejob:setHold', true)
				elseif action == 'enable_robb' then
					TriggerServerEvent('esx_policejob:setHold', false)
				end
			end, function(data2, menu2)
				menu2.close()
			end)

		elseif data.current.value == 'weapon_license' then
			
			openLicenseMenu(name,surname,license,expire,month)
		elseif data.current.value == 'tracker' then
			local elements3 = {}
			table.insert(elements3,{ label = "Πρόσθεση το κοντινότερο όχημα", value = "add" } )
			table.insert(elements3,{ label = "Δες τη λίστα", value = "list" } )
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vehicle_gps_actions_lala1',
			{
				title    = "Επίλεξε",
				align    = 'bottom-right',
				elements = elements3
			}, function(data, menu)
				if data.current.value == "add" then
					local veh, distance = ESX.Game.GetClosestVehicle()
					if veh ~= 0 and veh ~= -1 and distance < 5 then
						ExecuteCommand("e kneel")
						exports['progressBars']:startUI2(10000, "Κατοχύρωση οχήματος...",function(state)
							if state then
								TriggerServerEvent("esx_policejob:addplate", GetVehicleNumberPlateText(veh))
								ClearPedTasksImmediately(PlayerPedId())
							end
						end) 
						
						
					else
						ESX.ShowNotification("Δεν υπάρχει όχημα κοντά σου")
					end
				elseif data.current.value == "list" then
					elements = {}
					for k,v in pairs(plates) do
						table.insert(elements,{ label = "Πινακίδα: "..k, value = k })
					end
					ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'plates_list',
					{
						title    = "Plates",
						align    = 'bottom-right',
						elements = elements
					}, function(data, menu)
						local plate = data.current.value
						elements = {}
						table.insert(elements,{ label = "ΟΧΙ", value = "no" } )
						table.insert(elements,{ label = "ΝΑΙ", value = "yes" } )
						ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'confirm_vehicle',
						{
							title    = "Είσαι Σίγουρος για τη διαγραφή?",
							align    = 'bottom-right',
							elements = elements
						}, function(data, menu)
							if data.current.value == "yes" then
								TriggerServerEvent("esx_policejob:deleteplate", plate)
								menu.close()
								ESX.UI.Menu.CloseAll()
							else
								menu.close()
							end
						end, function(data, menu)
							menu.close()
						end)

						
					end, function(data, menu)
						menu.close()
					end)
				end
			end, function(data, menu)
				menu.close()
			end)

		end

	end, function(data, menu)
		menu.close()
	end)
end



function  openLicenseMenu(name,surname,license,expire,month)

	local year, month, dayOfWeek, hour, minute = GetLocalTime()
	local elements = {}

			if name == nil then
				table.insert(elements, {label = "Όνομα : ", value = "name"})
			else
				table.insert(elements, {label = "Όνομα : "..name, value = 0})
			end
			if surname == nil then
				table.insert(elements, {label = "Επίθετο : ", value = "surname"})
			else
				table.insert(elements, {label = "Επίθετο : "..surname, value = 0})
			end
			if license == nil then
				table.insert(elements, {label = "Α.Τ. : ", value = "license"})
			else
				table.insert(elements, {label = "Α.Τ. : "..license, value = 0})
			end
			if expire == nil then
				table.insert(elements, {label = "Ημ/νία Λήξης : ", value = "expire"})
			else
				table.insert(elements, {label = "Ημ/νία Λήξης : "..expire.."/"..month, value = 0})
			end
			if expire ~= nil and license ~= nil and name ~= nil and surname ~= nil then
				table.insert(elements, {label = "Έκδοση Άδειας οπλοκατοχής ", value = "print"})
			end
			table.insert(elements, {label = "Διαγραφή λίστας", value = "delete"})
			
		

		
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'weaponlicense',
			{
				title    = "Άδεια Οπλοκατοχής",
				align    = 'bottom-right',
				elements = elements
			}, function(data, menu)
				local action = data.current.value

				if action == "name" then
					DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 15)
					while (UpdateOnscreenKeyboard() == 0) do
						DisableAllControlActions(0);
						Wait(0);
					end
					if (GetOnscreenKeyboardResult()) ~= "" then
						local temp = GetOnscreenKeyboardResult()
						if temp ~= '' then 
							name = temp
						end
						menu.close()
						Wait(100)
						openLicenseMenu(name,surname,license,expire,month)
					else 
						ESX.ShowNotification("~r~Πρέπει να γράψεις ένα όνομα!")
						return
					end
				elseif action == "surname" then
					DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 15)
					while (UpdateOnscreenKeyboard() == 0) do
						DisableAllControlActions(0);
						Wait(0);
					end
					if (GetOnscreenKeyboardResult()) ~= "" then
						local temp = GetOnscreenKeyboardResult()
						if temp ~= '' then 
							surname = temp
						end
						menu.close()
						Wait(100)
						openLicenseMenu(name,surname,license,expire,month)
					else 
						ESX.ShowNotification("~r~Πρέπει να γράψεις ένα επίθετο!")
						return
					end
				elseif action == "license" then
					DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 15)
					while (UpdateOnscreenKeyboard() == 0) do
						DisableAllControlActions(0);
						Wait(0);
					end
					if (GetOnscreenKeyboardResult()) ~= "" then
						local temp = GetOnscreenKeyboardResult()
						if temp ~= '' then 
							license = temp
						end
						menu.close()
						Wait(100)
						openLicenseMenu(name,surname,license,expire,month)
					else 
						ESX.ShowNotification("~r~Πρέπει να γράψεις τον αριθμό ταυτότητας")
						return
					end
				elseif action == "expire" then
					Wait(100)
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'expiring', {
						title    = "Ημ/νία Λήξης",
						align    = 'bottom-right',
						elements = {
							{ label = "3 Ημέρες", value = "3"},
							{ label = "7 Ημέρες", value = "7"},
							{ label = "10 Ημέρες", value = "10"},
						}
					}, function(data2, menu2)
						local action2 = data2.current.value
						if  action2 == "3" then
							raw = 3
							if dayOfWeek + 3 > 30 then
								local extra = dayOfWeek + 3
								expire = extra - 30
								month = month + 1
							else
								expire = dayOfWeek + 3
							end
							ESX.UI.Menu.CloseAll()
							Wait(200)
							openLicenseMenu(name,surname,license,expire,month)
						elseif action2 == "7" then
							raw = 7
							if dayOfWeek + 7 > 30 then
								local extra = dayOfWeek + 7
								expire = extra - 30
								month = month + 1
							else
								expire = dayOfWeek + 7	
							end
							ESX.UI.Menu.CloseAll()
							Wait(200)
							openLicenseMenu(name,surname,license,expire,month)
						elseif action2 == "10" then
							raw = 10
							if dayOfWeek + 10 > 30 then
								local extra = dayOfWeek + 10
								expire = extra - 30
								month = month + 1
							else
								expire = dayOfWeek + 10	
							end
							ESX.UI.Menu.CloseAll()
							Wait(200)
							openLicenseMenu(name,surname,license,expire,month)
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				elseif action == "print" then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						local text = "Στον παραπάνω αναφερόμενο : "..name.." "..surname..", με Αριθμό ταυτότητας : "..license..", παραχωρείται η άδεια οπλοκατοχής για "..raw.." ημέρες!"
						TriggerEvent('document:police',name,surname,license,raw,text)
						TriggerServerEvent('Police:sendLicense', GetPlayerServerId(closestPlayer))
						ESX.ShowNotification("Εκτύπωσες μια άδεια οπλοκατοχής για  \nΟνομ/νυμο:~y~ "..name.." "..surname.." ~w~\nΑ.Τ.: ~y~"..license.." ~w~\nΗμ/νία λήξης:~y~ "..expire.."/"..month)
						ESX.UI.Menu.CloseAll()
					end
				elseif action == "delete" then
					name = nil
					surname = nil
					license = nil
					expire = nil
					raw = 0
					ESX.UI.Menu.CloseAll()
					Wait(100)
				end
			end, function(data, menu)
				ESX.UI.Menu.CloseAll()
			end)
end

local suspensionAccess = {
	--
}

function CheckCivilianMenu()
	local jobGrade = PlayerData.job.grade
	
	local elements = {}
	
	table.insert(elements, {label = 'Φορές φυλάκισης',		value = 1})
	
	if jobGrade >= 20 then
		table.insert(elements, {label = 'Έλεγχος αναστολής',	value = 2})
		table.insert(elements, {label = 'Βάλε αναστολή',		value = 3})
		table.insert(elements, {label = 'Βγάλε αναστολή',		value = 4})
	end
	
	if jobGrade == 7 or jobGrade == 11 or jobGrade == 15 or jobGrade == 17 or jobGrade == 20 or jobGrade == 21 or jobGrade == 23 or jobGrade == 24 or jobGrade == 25 then
		table.insert(elements, {label = 'Έλεγχος κατοικίας', value = 5})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'check_civ', {
		title    = 'Έλεγχος πόλιτη',
		align    = 'bottom-right',
		elements = elements,
	},
	function(data, menu)
		TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))
		Wait(1000)
		local id = tonumber(KeyboardInput("Enter Id","",math.floor(4)))
		local targetId = GetPlayerFromServerId(id)
		
		if targetId ~= -1 and #(GetEntityCoords(GetPlayerPed(targetId)) - GetEntityCoords(PlayerPedId())) < 2.5 then
			if data.current.value == 1 then
				TriggerServerEvent('esx_policejob:checkJailTimes', id)
			elseif data.current.value == 2 then
				TriggerServerEvent('esx_policejob:checkSuspendDays', id)
			elseif data.current.value == 3 then
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'comm_serv', {
					title = 'Ημέρες [1-10]'
				}, function(data2, menu2)
					local days = tonumber(data2.value)
					
					if days ~= nil and days > 0 and days <= 10 then
						TriggerServerEvent('esx_policejob:putBracelet', id, days)
					else
						ESX.ShowNotification('Valid days [1-10]')
					end
					
					ESX.UI.Menu.CloseAll()
				end, function(data2, menu2)
					ESX.UI.Menu.CloseAll()
				end)
			elseif data.current.value == 4 then
				TriggerServerEvent('esx_policejob:removeBracelet', id)
			elseif data.current.value == 5 then
				ESX.TriggerServerCallback('esx_policejob:getOwnedProperties', function(data)
					if data and #data > 0 then
						ShowProperties(data)
					else
						ESX.ShowNotification('Δεν βρέθηκαν αποτελέσματα')
					end
				end, id)
				
				ESX.UI.Menu.CloseAll()
			end
		else
			ESX.ShowNotification(_U('no_players_nearby'))
		end
		
		menu.close()
	end,
	function(data, menu)
		menu.close()
	end)
end

function ShowProperties(data)
	local elements = {}
	
	for k, v in pairs(data) do
		TriggerEvent('esx_property:getProperty', v.name, function(houseData)
			table.insert(elements, {label = houseData.label, value = houseData.entering})
		end)
		
		Wait(250)
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'properties_civ', {
		title    = 'Κατοικίες',
		align    = 'bottom-right',
		elements = elements,
	},
	function(data, menu)
		local coords = data.current.value
		SetNewWaypoint(coords.x, coords.y)
		
		menu.close()
	end,
	function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('esx_policejob:putBracelet')
AddEventHandler('esx_policejob:putBracelet', function(days)
	onSuspension = true
	
	ESX.ShowNotification('Eίσαι σε αναστολή για '..days..' ημέρες')
	
	--[[ print('Eίσαι σε αναστολή για '..days..' ημέρες')
	
	while onSuspension do
		if GetEntityModel(PlayerPedId()) == `mp_m_freemode_01` then
			SetPedComponentVariation(PlayerPedId(), 7, 2, 0, 2)
		elseif GetEntityModel(PlayerPedId()) == `mp_f_freemode_01` then
			SetPedComponentVariation(PlayerPedId(), 7, 2, 0, 2)
		end
		
		Wait(1500)
	end
	
	if GetEntityModel(PlayerPedId()) == `mp_m_freemode_01` then
		SetPedComponentVariation(PlayerPedId(), 7, 0, 0, 2)
	elseif GetEntityModel(PlayerPedId()) == `mp_f_freemode_01` then
		SetPedComponentVariation(PlayerPedId(), 7, 0, 0, 2)
	end ]]
end)

RegisterNetEvent('esx_policejob:removeBracelet')
AddEventHandler('esx_policejob:removeBracelet', function()
	onSuspension = false
end)

RegisterNetEvent('esx_policejob:sendOnlineSuspended')
AddEventHandler('esx_policejob:sendOnlineSuspended', function(data)
	if suspendedBlips ~= nil then
		for k, v in pairs(suspendedBlips) do
			if DoesBlipExist(v) then
				RemoveBlip(v)
			end
		end
	end
	
	suspendedBlips = nil
	Wait(2000)
	suspendedBlips = {}
	
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'police2' then
		Citizen.CreateThread(function()
			while suspendedBlips ~= nil do
				for k, v in pairs(data) do
					targetId = GetPlayerFromServerId(v)
					
					if targetId ~= -1 then
						if not DoesBlipExist(suspendedBlips[k]) then
							local blip = AddBlipForCoord(GetEntityCoords(GetPlayerPed(targetId)))
							
							SetBlipHighDetail(blip, true)
							SetBlipSprite(blip, 1)
							SetBlipScale(blip, 1.0)
							SetBlipColour(blip, 1)
							SetBlipAsShortRange(blip, true)
							
							BeginTextCommandSetBlipName('STRING')
							AddTextComponentString('Suspended')
							EndTextCommandSetBlipName(blip)
							
							suspendedBlips[k] = blip
						else
							SetBlipCoords(suspendedBlips[k], GetEntityCoords(GetPlayerPed(targetId)))
						end
					else
						if DoesBlipExist(suspendedBlips[k]) then
							RemoveBlip(suspendedBlips[k])
						end
						
						suspendedBlips[k] = nil
					end
				end
				
				Wait(1000)
			end
		end)
	end
end)

AddEventHandler('esx_policejob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'police2') and IsPedOnFoot(playerPed) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('remove_prop')
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end
		end
	end
end)



-- Enter / Exit entity zone events
Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_barrier_work05',
		'p_ld_stinger_s',
		'prop_boxpile_07d',
		'hei_prop_cash_crate_half_full'
	}

	while true do
		Citizen.Wait(10)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('esx_policejob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		end

		if not IsPedInAnyVehicle(PlayerPedId(), false) then
			Wait(800)
		end 
	end
end)

function OpenFineVehicleMenu(vehicle)
	local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
	
	ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
		if retrivedInfo.owner == nil then
			ESX.ShowNotification("This vehicle has no registered owner.")
		else
			TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, false)
			exports['progressBars']:startUI(7500, "Issuing Ticket")
			FreezeEntityPosition(PlayerPedId(), true)
			Wait(7500)
			TriggerServerEvent('esx_policejob:sendVehicleFine' , vehicleData.plate)
			ESX.ShowNotification("Έκοψες πρόστιμο σε παρατημένο όχημα.")
			ClearPedTasksImmediately(PlayerPedId())
			FreezeEntityPosition(PlayerPedId(), false)
		end
	end, vehicleData.plate)
end

RegisterNetEvent('esx_policejob:sendVehFine')
AddEventHandler('esx_policejob:sendVehFine',function(one,two,three,four)
	TriggerServerEvent('esx_billing:sendBiII', one, two, three , four)
end)

function OpenGetVehicleOwnerMenu(vehicle)
	local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
	ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
		if retrivedInfo.owner == nil then
			ESX.ShowNotification("This vehicle has no registered owner.")
		else
			ESX.ShowNotification('The owner is: '..retrivedInfo.owner)
		end
	end, vehicleData.plate)
end

function OpenIdentityCardMenu(player)

	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)

		local elements			= {}
		local nameLabel			= _U('name', data.name)
		local jobLabel			= nil
		local sexLabel			= nil
		local dobLabel			= nil
		local heightLabel		= nil
		local idLabel			= nil
		local jailTimesLabel	= nil
	
		if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
			jobLabel = _U('job', data.job.label .. ' - ' .. data.job.grade_label)
		else
			jobLabel = _U('job', data.job.label)
		end
	
		if Config.EnableESXIdentity then
	
			nameLabel = _U('name', data.firstname .. ' ' .. data.lastname)
	
			if data.sex ~= nil then
				if string.lower(data.sex) == 'm' then
					sexLabel = _U('sex', _U('male'))
				else
					sexLabel = _U('sex', _U('female'))
				end
			else
				sexLabel = _U('sex', _U('unknown'))
			end
	
			if data.dob ~= nil then
				dobLabel = _U('dob', data.dob)
			else
				dobLabel = _U('dob', _U('unknown'))
			end
	
			if data.height ~= nil then
				heightLabel = _U('height', data.height)
			else
				heightLabel = _U('height', _U('unknown'))
			end
	
			if data.name ~= nil then
				idLabel = _U('id', data.name)
			else
				idLabel = _U('id', _U('unknown'))
			end
			
			if data.jailTimes ~= nil then
				jailTimesLabel = _U('jail_times', data.jailTimes)
			else
				jailTimesLabel = _U('jail_times', _U('unknown'))
			end
		end
	
		local elements = {
			{label = nameLabel, value = nil},
			{label = jobLabel,  value = nil},
		}
	
		if Config.EnableESXIdentity then
			table.insert(elements, {label = sexLabel, value = nil})
			table.insert(elements, {label = dobLabel, value = nil})
			table.insert(elements, {label = heightLabel, value = nil})
			table.insert(elements, {label = idLabel, value = nil})
		end
	
		if data.drunk ~= nil then
			table.insert(elements, {label = _U('bac', data.drunk), value = nil})
		end
	
		if data.licenses ~= nil then
	
			table.insert(elements, {label = _U('license_label'), value = nil})
	
			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label, value = nil})
			end
	
		end
	
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
		{
			title    = _U('citizen_interaction'),
			align    = 'bottom-right',
			elements = elements,
		}, function(data, menu)
	
		end, function(data, menu)
			menu.close()
		end)
	
	end, GetPlayerServerId(player))

end
--[[ 
function OpenBodySearchMenu(player)
	if IsEntityDead(GetPlayerPed(player)) then
		ESX.ShowNotification("Cannot rob dead people.")
		return
	end
	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)

		local elements = {}

		for i=1, #data.accounts, 1 do

			if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then

				table.insert(elements, {
					label    = _U('confiscate_dirty', ESX.Math.Round(data.accounts[i].money)),
					value    = 'black_money',
					itemType = 'item_account',
					amount   = data.accounts[i].money
				})

				break
			end

		end

		table.insert(elements, {label = _U('guns_label'), value = nil})

		for i=1, #data.weapons, 1 do
			table.insert(elements, {
				label    = _U('confiscate_weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
				value    = data.weapons[i].name,
				itemType = 'item_weapon',
				amount   = data.weapons[i].ammo
			})
		end

		table.insert(elements, {label = _U('inventory_label'), value = nil})

		for i=1, #data.inventory, 1 do
			if data.inventory[i].count > 0 then
				table.insert(elements, {
					label    = _U('confiscate_inv', data.inventory[i].count, data.inventory[i].label),
					value    = data.inventory[i].name,
					itemType = 'item_standard',
					amount   = data.inventory[i].count
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search',
		{
			title    = _U('search'),
			align    = 'bottom-right',
			elements = elements,
		},
		function(data, menu)

			local itemType = data.current.itemType
			local itemName = data.current.value
			local amount   = data.current.amount

			if data.current.value ~= nil then
				if IsEntityDead(GetPlayerPed(player)) then
					ESX.ShowNotification("Cannot rob dead people.")
					return
				else
					TriggerServerEvent('esx_policejob:confiscatePlayerIteM' , GetPlayerServerId(player), itemType, itemName, amount)
					OpenBodySearchMenu(player)
				end
			end

		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))

end ]]

function OpenFineMenu(player)
	local elements = {
		{label = _U('traffic_offense'), value = 0},
		{label = _U('minor_offense'),   value = 1},
		{label = _U('average_offense'), value = 2},
		{label = _U('major_offense'),   value = 3},
		{label = 'Έκδοση Ταυτότητας',   value = 4},
		{label = 'Άδεια Οπλοφορίας',   value = 5},
		{label = 'Open Up',   value = 6},
	}
	--[[if PlayerData.job.name == 'police' and PlayerData.job.grade >= 4 and PlayerData.job.grade <= 12 then
		table.insert(elements,{label = 'Πρόστιμα Λιμενικού',   value = 5})
	end]]
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine',
	{
		title    = _U('fine'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		OpenFineCategoryMenu(player, data.current.value)
	end, function(data, menu)
		menu.close()
	end)

end

function OpenFineCategoryMenu(player, category)

	ESX.TriggerServerCallback('esx_policejob:getFineList', function(fines)

		local elements = {}

		for i=1, #fines, 1 do
			table.insert(elements, {
				label     = fines[i].label .. ' <span style="color: green;">$' .. fines[i].amount .. '</span>',
				value     = fines[i].id,
				amount    = fines[i].amount,
				fineLabel = fines[i].label
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category',
		{
			title    = _U('fine'),
			align    = 'bottom-right',
			elements = elements,
		}, function(data, menu)

			local label  = data.current.fineLabel
			local amount = data.current.amount

			menu.close()

		--[[ 	if Config.EnablePlayerManagement then
				TriggerServerEvent('esx_billing:sendBiII', GetPlayerServerId(player), true ,_U('fine_total', label), amount,category)
				--TriggerServerEvent('esx_policejob:addFine',GetPlayerServerId(player),category)
			else
				TriggerServerEvent('esx_billing:sendBiII', GetPlayerServerId(player), false, _U('fine_total', label), amount,category)
				--TriggerServerEvent('esx_policejob:addFine',GetPlayerServerId(player),category)
			end ]]

			TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))
			Wait(1000)
			local id = KeyboardInput("Enter Id","",math.floor(4))

			TriggerServerEvent('esx_billing:sendBiII', id, true ,_U('fine_total', label), amount,category,"police",0.9)
			ESX.SetTimeout(300, function()
				OpenFineCategoryMenu(player, category)
			end)

		end, function(data, menu)
			menu.close()
		end)

	end, category)

end

function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle',
	{
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if data.value == nil or length < 2 or length > 13 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('esx_policejob:getVehicleFromPlate', function(owner, found)
				if found then
					ESX.ShowNotification(_U('search_database_found', owner))
				else
					ESX.ShowNotification(_U('search_database_error_not_found'))
				end
			end, data.value)
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function ShowPlayerLicense(player)
	local elements = {}
	local targetName
	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
		if data.licenses then
			for i=1, #data.licenses, 1 do
				if data.licenses[i].label and data.licenses[i].type then
					table.insert(elements, {
						label = data.licenses[i].label,
						type = data.licenses[i].type
					})
				end
			end
		end
		
		if Config.EnableESXIdentity then
			targetName = data.firstname .. ' ' .. data.lastname
		else
			targetName = data.name
		end
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license',
		{
			title    = _U('license_revoke'),
			align    = 'bottom-right',
			elements = elements,
		}, function(data, menu)
			if data.current.type == 'weapon' then
				ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
				TriggerServerEvent('esx_license:removeWeaponLicense', GetPlayerServerId(player))
			else
				ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
				TriggerServerEvent('esx_policejob:message' , GetPlayerServerId(player), _U('license_revoked', data.current.label))
				
				TriggerServerEvent('esx_license:removeLicense' , GetPlayerServerId(player), data.current.type)
				
				ESX.SetTimeout(300, function()
					ShowPlayerLicense(player)
				end)
			end
		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
end

function OpenVehicleInfosMenu(vehicleData)

	ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)

		local elements = {}

		table.insert(elements, {label = _U('plate', retrivedInfo.plate), value = nil})

		if retrivedInfo.owner == nil then
			table.insert(elements, {label = _U('owner_unknown'), value = nil})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner), value = nil})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos',
		{
			title    = _U('vehicle_info'),
			align    = 'bottom-right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)

	end, vehicleData.plate)

end

function OpenGetWeaponMenu(bypass)

    ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons, bypass)
        Citizen.CreateThread(function()
            Wait(Config.PropertyMenuTime)
            ESX.UI.Menu.CloseAll()
        end)
        local time = GetGameTimer() + math.random(1000,3000)
        while GetGameTimer() < time do
            --DisableControlAction(0, 18)
			--DisableControlAction(0, 289)
			TriggerEvent("closeInventory",true)
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

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon',
        {
            title    = _U('get_weapon_menu'),
            align    = 'bottom-right',
            elements = elements
        }, function(data, menu)

            menu.close()

            ESX.TriggerServerCallback('esx_policejob:removeArmoryWeapon', function()
                OpenGetWeaponMenu(true)
            end, data.current.value)

        end, function(data, menu)
            menu.close()
        end)
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
                ammo =  GetAmmoInPedWeapon(playerPed,whash)
            })
        end
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon',
    {
        title    = _U('put_weapon_menu'),
        align    = 'bottom-right',
        elements = elements
    }, function(data, menu)

        local chk, wpn = GetCurrentPedWeapon(PlayerPedId())
        if wpn == GetHashKey(data.current.value) then    
            ESX.ShowNotification("Can't deposit weapons in your hand!")
            menu.close()
            return
        end
        
                
        ClearPedTasksImmediately(PlayerPedId())
        menu.close()
        ESX.ShowNotification("Depositing weapon, please wait..")
        local time = GetGameTimer() + math.random(1000,3000)
        while GetGameTimer() < time do
            --DisableControlAction(0, 18)
			--DisableControlAction(0, 289)
			TriggerEvent("closeInventory",true)
            ESX.UI.Menu.CloseAll()
            Wait(0)
        end
        if IsEntityDead(PlayerPedId()) then            
            ESX.ShowNotification("Can't deposit while dead!")
            return
        end

                
        ClearPedTasksImmediately(PlayerPedId())
        menu.close()

        ESX.TriggerServerCallback('esx_policejob:addArmoryWeapon', function()
            --OpenPutWeaponMenu()
            ESX.ShowNotification("Weapon Deposited")
        end, data.current.value, true, data.current.ammo)

    end, function(data, menu)
        menu.close()
    end)
end

RegisterNetEvent("esx_policejob:stock")
AddEventHandler("esx_policejob:stock",function(stock)
	weaponStock = stock
end)

function OpenBuyAttachmentsMenu()
	local elements = {}
	
	for k,v in pairs(Config.BuyAttachments) do
		table.insert(elements, {label = v.label, value = k})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy_attachments', {
		title    = 'Buy Attachments',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		itemId = data.current.value
		menu.close()
		TriggerServerEvent('esx_policejob:buyAttachments', itemId)
	end,
	function(data, menu)
		menu.close()
	end)
end

function OpenBuyWeaponsMenu()
	local elements = {}
	local playerPed = PlayerPedId()
	PlayerData = ESX.GetPlayerData()
	
	for k,v in ipairs(Config.AuthorizedWeapons[PlayerData.job.grade]) do
			local weaponNum, weapon = ESX.GetWeapon(v.weapon)
			if weapon == nil then
				print("Weapon : "..v.weapon.." doesn't exist in Config.weapon.lua in Resource: es_extended")
			else
				local components, label = {}

				local hasWeapon = HasPedGotWeapon(playerPed, GetHashKey(v.weapon), false)

				if v.components then
					for i=1, #v.components do
						if v.components[i] then

							local component = weapon.components[i]
							local hasComponent = HasPedGotWeaponComponent(playerPed, GetHashKey(v.weapon), component.hash)

							if hasComponent then
								label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_owned'))
							else
								if v.components[i] > 0 then
									label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_item', ESX.Math.GroupDigits(v.components[i])))
								else
									label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_free'))
								end
							end

							table.insert(components, {
								label = label,
								componentLabel = component.label,
								hash = component.hash,
								name = component.name,
								price = v.components[i],
								hasComponent = hasComponent,
								componentNum = i
							})
						end
					end
				end

				if hasWeapon and v.components then
					label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
				elseif hasWeapon and not v.components then
					label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_owned'))
				else
					if v.price > 0 then
						label = weapon.label..': <span style="color:green;">'.._U('armory_item', ESX.Math.GroupDigits(v.price))..'</span>'
					else
						label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_free'))
					end
				end

				table.insert(elements, {
					label = label,
					weaponLabel = weapon.label,
					name = weapon.name,
					components = components,
					price = v.price,
					hasWeapon = hasWeapon
				})
			end
		
		
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons', {
		title    = _U('armory_weapontitle'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)

		if data.current.hasWeapon then
			if #data.current.components > 0 then
				OpenWeaponComponentShop(data.current.components, data.current.name, menu)
			end
		else
			ESX.TriggerServerCallback('esx_policejob:buyWeap0n', function(bought)
				if bought then
					if data.current.price > 0 then
						ESX.ShowNotification(_U('armory_bought', data.current.weaponLabel, ESX.Math.GroupDigits(data.current.price)))
					end

					menu.close()

					OpenBuyWeaponsMenu()
				else
					ESX.ShowNotification(_U('armory_money'))
				end
			end, data.current.name, 1)
		end

	end, function(data, menu)
		menu.close()
	end)

end

function OpenWeaponComponentShop(components, weaponName, parentShop)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons_components', {
		title    = _U('armory_componenttitle'),
		align    = 'bottom-right',
		elements = components
	}, function(data, menu)

		if data.current.hasComponent then
			ESX.ShowNotification(_U('armory_hascomponent'))
		else
			ESX.TriggerServerCallback('esx_policejob:buyWeap0n', function(bought)
				if bought then
					if data.current.price > 0 then
						ESX.ShowNotification(_U('armory_bought', data.current.componentLabel, ESX.Math.GroupDigits(data.current.price)))
					end

					menu.close()
					parentShop.close()

					OpenBuyWeaponsMenu()
				else
					ESX.ShowNotification(_U('armory_money'))
				end
			end, weaponName, 2, data.current.componentNum)
		end

	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetStocksMenu(bypass)
	ESX.TriggerServerCallback('esx_policejob:getStockItems', function(items, bypass)
	
		local elements = {}

		for i=1, #items, 1 do
			print(items[i].name)
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = _U('police_stock'),
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)

			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_policejob:getStockItem' , itemName, count)

					Citizen.Wait(300)
					OpenGetStocksMenu(true)
				end

			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)

	end)

end

function OpenPutStocksMenu()
	ClearPedTasksImmediately(PlayerPedId())
	local inventory = ESX.GetPlayerData().inventory

		local elements = {}

		for k,v in pairs(inventory) do
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
			title    = _U('inventory'),
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)

			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_policejob:putStockItems', itemName, count)

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

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

	if ESX.PlayerData.job.name ~= 'police' and job.name == 'police' then 
		showBlipsStatus = true
		showBlips()
	elseif ESX.PlayerData.job.name == 'police' and job.name ~= 'police' then 
		showBlipsStatus = false
		removeJobBlips()
	end

	if ESX.PlayerData.job.name ~= 'police2' and job.name == 'police2' then 
		showBlipsStatus = true
		showBlips()
	elseif ESX.PlayerData.job.name == 'police2' and job.name ~= 'police2' then 
		showBlipsStatus = false
		removeJobBlips()
	end

	ESX.PlayerData.job = job
	--unregisterTags()
	
	if suspendedBlips ~= nil then
		for k, v in pairs(suspendedBlips) do
			if DoesBlipExist(v) then
				RemoveBlip(v)
			end
		end
	end
	
	suspendedBlips = nil
	
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'police2' then
		ESX.TriggerServerCallback('esx_policejob:getOnlineSuspended', function(data)
			TriggerEvent('esx_policejob:sendOnlineSuspended', data)
		end)
		
		createTags()
		Wait(5000)
		for k,v in pairs(mpGamerTags) do
			SetMpGamerTagVisibility(v.tag, 0, true)
		end
	else
		for k,v in pairs(mpGamerTags) do
			SetMpGamerTagVisibility(v.tag, 0, false)
		end
	end
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('phone_police'),
		number     = 'police',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTVGcd/u3cfSXaTLEk2j80TCI8ECI9ABCyoiBqhBVQqVG2ppVKBQqUVgUl5OU7HKqNOHUHU0oHamZZWoGkVS6cWAR2JPJuAQBPy2ISEvLN57+v2u2E33e4k6Ngz85+9d++95/zP9/h/39GpqsqiRYsIGz8QZAq28/8PRfC+4HT4fMXFxeiH+GC54NeCbYLLATLpYe/ECx4VnBTsF0wWhM6lXY8VbBE0Ch4IzLcpfDFD2P1TgrdC7nMCZLRxQ9AkiAkQCn77DcH3BC2COoFRkCSIG2JzLwqiQi0RSmCD4JXbmNKh0+kc/X19tLtc9Ll9sk9ZS1yoU71YIk3xsbEx8QaDEc2ttxmaJSKC1ggSKBK8MKwTFQVXRzs3WzpJGjmZgvxcMpMtWIwqsjztvSrlzjYul56jp+46qSmJmMwR+P3+4aZ8TtCprRkk0DvUW7JjmV6lsqoKW/pU1q9YQOE4Nxkx4ladE7zd8ivuVmJQfXZKW5dx5EwPRw4fxNx2g5SUVLw+33AkzoRaQDP9SkFu6OKqz0uF8yaz7vsOL6ycQVLkcSg/BlWNsjuFoKE1knqDSl5aNnmPLmThrE0UvXqQqvJPyMrMGorEHwQfEha57/3P7mXS684GFjy8kreLppPUuBXfyd/ibeoS2kb0mWPANhJdYjb61AxUvx5PdT3+4y+Tb3mTd19ZSebE+VTXVGNQlHAC7w4VhH8TbA36vKq6ilnzlvPSunHw6Trc7XpZ14AyfgYeyz18crGN1Alz6e3qwNNQSv4dZox1h/BW9+O7eIaEsVv41Y4XeHJDG83Nl4mLTwzGhJYtx0PzNTjOB9KMTlc7Nkcem39YAGU7cbeBKVLMPGMVf296nMd2VbBq1wmizHoqqm/wrS1/Zf0+N19YN2PIu1fcIda4Vk66Zx/rVi+jo9eIX9wZGGcFXUMR6BHUa76/2ezioYcXMtpyAl91DSaTfDxlJbtLprHm2ecpObqPuTPzSNV9yKz4a4zJSuLo71/j8Q17ON69EmXiPIlNMe6FoyzOqWPW/MU03Lw5EFcyKghTrNDh7+/vw545mcJcWbTiGKpRdGPMXbx90sGmDaux6sXk+kimjU+BjnMkx3kYP34cXrFuZ+3nrHi6iDMt92JITcPjk3R3naRwZhpuNSqoD93DKaFVU7j2dhcF8+YzNlpErbIBTVh8toVccbaysPB+4pMcuPw25kwSsau7BIlmHpy3guaOPtISYyi/UkaJM5Lpc5agq5Xkcl6gIHkmqaMn0dtylcjIyPThCNyhaXyfR2W0I1our0v6qBii07ih5rDtGSOxNVdk1y4R2SR8jR/g7hQD9l1jUeY/WLJB5m39AlZN4GZyIQ1fFJNsEgt0duBIc5GRkcZF53mNwIzhXPDgQPoZIkiMkbTxtstDMVnmFA4cOsbz2/aKjSQjev4Mp9ZAg+hIpFhB3EH5Yal16+X+Kq3dGfxkzRY+KauBjBzREvGN0kNCTARu94AejBLMHorAQ7cEQMGs2cXvkWshYLDi6e9l728O8P1XW6hKeB2yv42q18tjj+iFTGoSi+X9jJM9RTxS9E+OHT0krhNiZqlbqraoT7RAU5bBGrEknEBhgJks7KXbLS8qERI0ErVqF/Y4K6NHZfLZB+/wzJvncacvFd91oXO3o/O40MfZKJOKu/rne+mRQByXM4lYreb1tUnkizVVA/0SpfpbWaCNBeEE5gb/UH19NLqEgDF+oNDQWcn41Cj0EXFEWqzkOIyYekslFkThsvMxpIyE2hIc6lXGZ6cPyK7Nnk5OipixRdxgUESAYmhq68VsGgy5CYKCUAJTg0+izApXne3CJFmUTwg4L3FProFxU+6krqmXu3MskkhSD2av41jLdzlnfFrSdCZxyqfMnppN6ZUa7pwt0h3fiK9DCt4IO9e7YqisvI7VYgmNv7mhBKKD/9psNi5dOMv5ZjukjsLdr0ffWsyTi6eSlfcA+dmiVyOXs+/sHNZu3M6PdxzgVO9GmDSHsSNqmTz/R6y6Xxqma4fwaS5Mn85n1ZE0Vl3CHBER3lUNEhiURpPJRFdTOcVnpUJnPIhR7cZXfoH5UYc5+E4RzRH3sfSnl9m2dSMjE+Tz9msse+o5dr7UwcQ5T3HwlWUkNuzG3dKFSTbsNs7m/Y8vExOlC29UWkMJlAxKoRQMR3IC7x85zOn6fHS50+U/2Untx2R1voinu5no+DQmz7yPXmMKZnsu0wrm0Oe3YhOVHdm8A09dBQYhTv4T7C+xUPrZh8Qn2MMr4qcDSRfoirWgKAvtgOpv1JI8Zi77X15G7L+fxeOUOiUFxZiULD5fSlNzNM62W+k1yq5gjajGX/ZHvOIyxd+Fkj+P092rWP/si0Qr7VisMaEWuCiYonXFwbAUTWWPYLV245NITnGkUXnpI9butLJn2y6iba+hlp7C09qBcvoN7FYL9mhxo1/y/LoEXK8Pv6qIC8WbBY/xr9YlPLf9dZT+OqKTUwfmDBm/GOw7ws4FWpuUP2gJEZvKqmocuXPZuWYJMzKuSsH+SNwh3bo0p6hao6HeEqwYEZ2M6aKWd3PwTCy7du/D0F1DsmzE6/WGLr5LsDF4LggnYBacCOboQLHQ3FFfR58SR+HCR1iQH8ukhA5s5o5AYZMwUqOp74nl8xvRHDlRTsnxYpJsUjtsceHt2C8Fm0MPJrphTkZvBc4It9RKLOFx91Pf0Igu0k7W2MmkOewS2QYJUJVWVz9VNbXUVVwkyuAmKTFJayrDo/4Jwe/CT0aGYTrWVYEeUfsgXssMRcpyenraQJa0VX9O3ZU+Ma1fax4xGxUsUVFkOUbcama1hf+7+LmA9juHWshwmwOE1iMmCFYEzg1jtIm1BaxW6wCGGoFdewPfvyE4ertTiv4rHC73B855dwp2a23bbd4tC1hvhOCbX7b4VyUQKhxrtSOaYKngasizvwi0RmOS4O1QZf2yYfiaR+73AvhTQEVf+rpn9/8IMAChKDrDzfsdIQAAAABJRU5ErkJggg=='
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

RegisterNetEvent("amIPoliceHandCuffed")
AddEventHandler("amIPoliceHandCuffed", function(cb)
	cb(IsHandcuffed)
end)

RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function()
	IsHandcuffed = not IsHandcuffed
	
	Citizen.CreateThread(function()
		Wait(100)
		if IsHandcuffed then
			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(100)
			end

			TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			--SetEnableHandcuffs(PlayerPedId(), true)
			DisablePlayerFiring(PlayerPedId(), true)
			SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(PlayerPedId(), false)
			--FreezeEntityPosition(PlayerPedId(), true)
			DisplayRadar(false)
			DisableControlAction(0, 44, true)
			DisableControlAction(0, 157, true)
			DisableControlAction(0, 158, true)
			DisableControlAction(0, 160, true)

			if Config.EnableHandcuffTimer then

				if HandcuffTimer.Active then
					ESX.ClearTimeout(HandcuffTimer.Task)
				end

				StartHandcuffTimer()
			end

		else
			if Config.EnableHandcuffTimer and HandcuffTimer.Active then
				ESX.ClearTimeout(HandcuffTimer.Task)
			end

			ClearPedSecondaryTask(PlayerPedId())
			--SetEnableHandcuffs(PlayerPedId(), false)
			DisablePlayerFiring(PlayerPedId(), false)
			SetPedCanPlayGestureAnims(PlayerPedId(), true)
			--FreezeEntityPosition(PlayerPedId(), false)
			DisplayRadar(true)
			EnableControlAction(0, 44, true)
			EnableControlAction(0, 157, true)
			EnableControlAction(0, 158, true)
			EnableControlAction(0, 160, true)
		end
	end)
	if IsHandcuffed then
		Citizen.CreateThread(function()
			while IsHandcuffed do
				Wait(100)
				TriggerEvent("vMenu:enableMenu", false)
				TriggerEvent("togglevMenu",false)
			end
			TriggerEvent("vMenu:enableMenu", true)
			Wait(1000)
			TriggerEvent("vMenu:enableMenu", true)
		end)
		CreateThread(function()
			TriggerEvent("closeInventoryHUD",2000)
			while IsHandcuffed do
				Wait(1)
				SetPlayerCanDoDriveBy(PlayerId(), false)
				--DisableControlAction(0, 1, true) -- Disable pan
				DisableControlAction(0, 2, true) -- Disable tilt
				DisableControlAction(0, 24, true) -- Attack
				DisableControlAction(0, 257, true) -- Attack 2
				DisableControlAction(0, 25, true) -- Aim
				DisableControlAction(0, 263, true) -- Melee Attack 1
				--DisableControlAction(0, Keys['W'], true) -- W
				--DisableControlAction(0, Keys['A'], true) -- A
				--DisableControlAction(0, 31, true) -- S (fault in Keys table!)
				--DisableControlAction(0, 30, true) -- D (fault in Keys table!)
				
				DisableControlAction(0, 30, true)	--movement
				DisableControlAction(0, 31, true)	--movement
				DisableControlAction(0, 32, true)	--movement
				DisableControlAction(0, 33, true)	--movement
				DisableControlAction(0, 34, true)	--movement
				DisableControlAction(0, 35, true)	--movement

				DisableControlAction(0, Keys['R'], true) -- Reload
				DisableControlAction(0, Keys['SPACE'], true) -- Jump
				DisableControlAction(0, Keys['Q'], true) -- Cover
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
				DisableControlAction(0, 75, true) -- Disable F

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

				if not IsPedRagdoll(PlayerPedId()) then
					if IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) ~= 1 then
						ESX.Streaming.RequestAnimDict('mp_arresting', function()
							TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
						end)
					end
				else
					ESX.Streaming.RequestAnimDict('mp_arresting', function()
						TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
					end)
				end
			end
			
			SetPlayerCanDoDriveBy(PlayerId(), true)
		end)
	end
	
	TriggerEvent('esx_policejob:cuffsState', IsHandcuffed)
end)

RegisterNetEvent('esx_policejob:unrestrain')
AddEventHandler('esx_policejob:unrestrain', function()
	if IsHandcuffed then
		local playerPed = PlayerPedId()
		IsHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		--SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)

		-- end timer
		if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end)
exports("IsHandcuffed", function ()
	return IsHandcuffed
end)
RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(copID)
	if not IsHandcuffed then
		return
	end

	DragStatus.IsDragged = not DragStatus.IsDragged
	DragStatus.CopId     = tonumber(copID)
	local playerPed
	local targetPed
	if DragStatus.IsDragged then
		Citizen.CreateThread(function()
			while DragStatus.IsDragged do
				Citizen.Wait(1)
				playerPed = PlayerPedId()
				targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))

				if not DoesEntityExist(targetPed) or playerPed == targetPed then
					DragStatus.IsDragged = false
					break
				end

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end
			end
			DetachEntity(playerPed, true, false)
		end)
	end
end)

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function()
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
				DragStatus.IsDragged = false
			end
		end
	end
end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

-- Create blips
Citizen.CreateThread(function()

	for k,v in pairs(Config.PoliceStations) do
		local blip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale  (blip, v.Blip.Scale)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('map_blip'))
		EndTextCommandSetBlipName(blip)
	end

end)

CreateThread(function()
	for k,v in pairs(Config.PoliceStations) do
		for i=1, #v.Cloakrooms, 1 do
			TriggerEvent("esx_utilities:add","Cloakrooms","Press ~INPUT_CONTEXT~ to Open Cloackroom",38,Config.DrawDistance ,Config.CloackroomMarkerType,v.Cloakrooms[i],Config.MarkerSize,Config.MarkerColor,GetCurrentResourceName(), (v.Job or 'police'))
		end

		for i=1, #v.Armories, 1 do
			TriggerEvent("esx_utilities:add","Armories","Press ~INPUT_CONTEXT~ to Open Armory", 38, Config.DrawDistance, Config.ArmoryMarkerType, v.Armories[i], { x = 1.0, y = 1.0, z = 0.5 }, { r = 255, g = 0, b = 0 }, GetCurrentResourceName(), (v.Job or 'police'))
		end

		--[[ for i=1, #v.Destroyer, 1 do
			TriggerEvent("esx_utilities:add","Destroyer","Press ~INPUT_CONTEXT~ to Open Destroyer",38,Config.DrawDistance , 1 ,v.Destroyer[i],{ x = 1.0, y = 1.0, z = 0.5 },{ r = 255, g = 0, b = 0 },GetCurrentResourceName(),"police")
		end ]]

		for i=1, #v.Items, 1 do
			TriggerEvent("esx_utilities:add","Items","Press ~INPUT_CONTEXT~ to Open Items", 38, Config.DrawDistance, Config.ArmoryMarkerType, v.Items[i], { x = 1.0, y = 1.0, z = 0.5 }, { r = 255, g = 0, b = 0 }, GetCurrentResourceName(), (v.Job or 'police'))
		end
		--[[ 
		for i=1, #v.StockArmories, 1 do
			TriggerEvent("esx_utilities:add","StockArmories","Press ~INPUT_CONTEXT~ to Open Stock Armory",38,Config.DrawDistance ,Config.ArmoryMarkerType,v.StockArmories[i],Config.MarkerSize,Config.MarkerColor,GetCurrentResourceName(),"police")
		end ]]
		
		TriggerEvent("esx_utilities:add","Vehicles","Press ~INPUT_CONTEXT~ to Open Vehicles", 38, Config.DrawDistance, Config.VehicleMarkerType, v.Vehicles.Spawner, { x = 1.0, y = 1.0, z = 1.0 }, Config.MarkerColor, GetCurrentResourceName(), (v.Job or 'police'))
		
		if v.Vehicles.SpawnerPaleto then
			TriggerEvent("esx_utilities:add","Vehicles_Paleto","Press ~INPUT_CONTEXT~ to Open Vehicles", 38, Config.DrawDistance, Config.VehicleMarkerType, v.Vehicles.SpawnerPaleto, { x = 1.0, y = 1.0, z = 1.0 }, Config.MarkerColor, GetCurrentResourceName(), 'police')		
		end

		if v.Vehicles.SpawnerVespucci then
			TriggerEvent("esx_utilities:add","Vehicles_Vespucci","Press ~INPUT_CONTEXT~ to Open Vehicles", 38, Config.DrawDistance, Config.VehicleMarkerType, v.Vehicles.SpawnerVespucci, { x = 1.0, y = 1.0, z = 1.0 },Config.MarkerColor,GetCurrentResourceName(), 'police')
		end

		if v.Vehicles.SpawnerPolice1 then
			TriggerEvent("esx_utilities:add","Vehicles_Police1","Press ~INPUT_CONTEXT~ to Open Vehicles", 38, Config.DrawDistance, Config.VehicleMarkerType, v.Vehicles.SpawnerPolice1, { x = 1.0, y = 1.0, z = 1.0 },Config.MarkerColor,GetCurrentResourceName(), 'police')
		end


		TriggerEvent("esx_utilities:add","Helicopters","Press ~INPUT_CONTEXT~ to Open Helicopters",38,Config.DrawDistance ,Config.HelicopterMarkerType,v.Helicopters.Spawner,{ x = 1.0, y = 1.0, z = 1.0 },Config.MarkerColor,GetCurrentResourceName(),(v.Job or 'police'))

		if v.Helicopters.SpawnerVespucci then
			TriggerEvent("esx_utilities:add","Helicopters_Vespucci","Press ~INPUT_CONTEXT~ to Open Helicopters",38,Config.DrawDistance ,Config.HelicopterMarkerType,v.Helicopters.SpawnerVespucci,{ x = 1.0, y = 1.0, z = 1.0 },Config.MarkerColor,GetCurrentResourceName(), 'police')
		end
		
		if v.Helicopters.SpawnerPaleto then
			TriggerEvent("esx_utilities:add","Helicopters_Paleto","Press ~INPUT_CONTEXT~ to Open Helicopters",38,Config.DrawDistance ,Config.HelicopterMarkerType,v.Helicopters.SpawnerPaleto,{ x = 1.0, y = 1.0, z = 1.0 },Config.MarkerColor,GetCurrentResourceName(), 'police')
		end

		TriggerEvent("esx_utilities:add","Boats","Press ~INPUT_CONTEXT~ to Open Boats", 38, Config.DrawDistance, Config.BoatMarkerType, v.Boats.Spawner, { x = 1.0, y = 1.0, z = 1.0 }, Config.MarkerColor, GetCurrentResourceName(), (v.Job or 'police'))
		
		if v.Boats.SpawnerPaleto then
			TriggerEvent("esx_utilities:add","Boats_Paleto","Press ~INPUT_CONTEXT~ to Open Boats",38,Config.DrawDistance ,Config.BoatMarkerType,v.Boats.SpawnerPaleto,{ x = 1.0, y = 1.0, z = 1.0 },Config.MarkerColor,GetCurrentResourceName(), 'police')
		end

		
		for i=1, #v.BossActions, 1 do
			TriggerEvent("esx_utilities:add","BossActions","Press ~INPUT_CONTEXT~ to Boss Actions",38,Config.DrawDistance ,21,v.BossActions[i],{ x = 0.7, y = 0.7, z = 0.5 },{ r = 0, g = 255, b = 0 },GetCurrentResourceName(),(v.Job or 'police'),"boss")
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
		
		if markerlabel == "Cloakrooms" then
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'cloakroom')
		elseif markerlabel == "Destroyer" then
		elseif markerlabel == "Armories" then
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'armory')
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'armory_buy_weapons')
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'stocks_menu')
		elseif markerlabel == "Items" then
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'armory')
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'armory_buy_weapons')
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'stocks_menu')
		--[[ elseif markerlabel == "StockArmories" then
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'armory')
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'armory_buy_weapons')
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'stocks_menu') ]]
		elseif markerlabel == "Vehicles" then
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'vehicle')
			--ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'vehicle_garage') --dont uncommment i will bug u
			
		elseif markerlabel == "Helicopters" then
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'vehicle')
		elseif markerlabel == "BossActions" then
			ESX.UI.Menu.Close('default', 'esx_society', 'boss_actions_police')
		end
	end
end)

AddEventHandler("pressedmarker", function(markerlabel,MarkerObject)
	if MarkerObject.resource == GetCurrentResourceName() then
		if markerlabel == "Cloakrooms" then
			OpenCloakroomMenu()
		elseif markerlabel == "Destroyer" then
			OpenDestroyerMenu()
		elseif markerlabel == "Armories" then
			OpenArmoryMenu()
		elseif markerlabel == "Items" then
			OpenItemsMenu()
		elseif markerlabel == "StockArmories" then
			ExecuteCommand("e leanbar2")
			OpenStockArmoryMenu()
		elseif markerlabel == "Vehicles" then
			OpenVehicleSpawnerMenu('car')
		elseif markerlabel == "Vehicles_Paleto" then
			OpenVehicleSpawnerMenu('car','Paleto')
		elseif markerlabel == "Vehicles_Vespucci" then
			OpenVehicleSpawnerMenu('car','Vespucci')
		elseif markerlabel == "Vehicles_Police1" then
			OpenVehicleSpawnerMenu('car','Police1')
		elseif markerlabel == "Helicopters" then
			OpenVehicleSpawnerMenu('helicopter')
		elseif markerlabel == "Helicopters_Paleto" then
			OpenVehicleSpawnerMenu('helicopter','Paleto')
		elseif markerlabel == "Helicopters_Vespucci" then
			OpenVehicleSpawnerMenu('helicopter','Vespucci')
		elseif markerlabel == "Boats" then
			OpenVehicleSpawnerMenu('boat')
		elseif markerlabel == "Boats_Paleto" then
			OpenVehicleSpawnerMenu('boat','Paleto')
		elseif markerlabel == "BossActions" then
			ESX.UI.Menu.CloseAll()
			TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
				menu.close()

				CurrentAction     = 'menu_boss_actions'
				CurrentActionMsg  = _U('open_bossmenu')
				CurrentActionData = {}
			end, { wash = false }) -- disable washing money
		end

	end
end)

function OpenDestroyerMenu()
	local elements = {}
	local posotita = 0
	local data = ESX.GetPlayerData()
	for k,v in pairs (data.inventory) do
		if v.count > 0 then
			table.insert(elements, {label = v.label.." - x"..v.count, value = 'item', item = v.name, count = v.count})
		end
	end

	for k,v in pairs (data.loadout) do 
		table.insert(elements, {label = v.label.." - x"..v.ammo, value = 'weapon', weapon = v.name, ammo = v.ammo})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Destroyer_menu", {
		title    = "Destroyer",
		align    = 'left',
		elements = elements
	}, function(data, menu)
		if data.current.value == "item" then
			DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 3)
			while (UpdateOnscreenKeyboard() == 0) do
				DisableAllControlActions(0);
				Wait(0);
			end
			if (GetOnscreenKeyboardResult()) ~= "" then
				local result1 = GetOnscreenKeyboardResult()
				result1 = tonumber(result1)
				if result1 <= data.current.count and result1 >= 1 and result1 ~= '' then 
					posotita = result1
				elseif result1 == '' or result1 > data.current.count  or result1 < 1 then
					ESX.ShowNotification("~r~You need to enter a Number! Max "..data.current.count)
					return
				end
			else 
				ESX.ShowNotification("~r~You need to enter a Number! Max "..data.current.count)
				return
			end
			Wait(100)
			TriggerServerEvent('esx_policejob:Delete',data.current.value,data.current.item,posotita)
			ESX.UI.Menu.CloseAll()
			Wait(1500)
			OpenDestroyerMenu()
		elseif data.current.value == 'weapon' then
			TriggerServerEvent('esx_policejob:Delete',data.current.value,data.current.weapon,data.current.ammo)
			ESX.UI.Menu.CloseAll()
			Wait(1500)
			OpenDestroyerMenu()
		end
	end, function(data, menu)
		menu.close()
	end)
end


AddEventHandler("justpressed",function(label,key)
    if label == "F6" and (PlayerData.job.name == "police" or PlayerData.job.name == "police2") then
        if not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
            OpenPoliceActionsMenu()
        end
    end
end)


AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('esx_policejob:unrestrain')
	
	if not hasAlreadyJoined then
		TriggerServerEvent('esx_policejob:spawned'  )
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_policejob:unrestrain')
		TriggerEvent('esx_phone:removeSpecialContact', 'police')


		if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end)

-- handcuff timer, unrestrain the player after an certain amount of time
function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and HandcuffTimer.Active then
		ESX.ClearTimeout(HandcuffTimer.Task)
	end

	HandcuffTimer.Active = true

	HandcuffTimer.Task = ESX.SetTimeout(Config.HandcuffTimer, function()
		ESX.ShowNotification(_U('unrestrained_timer'))
		TriggerEvent('esx_policejob:unrestrain')
		HandcuffTimer.Active = false
	end)
end

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded
function ImpoundVehicle(vehicle)
	ESX.Game.DeleteVehicle(vehicle) 
	
	if DoesEntityExist(vehicle) then
		DeleteVehicle(vehicle)
	end
	
	if DoesEntityExist(vehicle) then
		DeleteEntity(vehicle)
	end
	
	ESX.ShowNotification(_U('impound_successful'))
	CurrentTask.Busy = false
	
	TriggerServerEvent('esx:policejob:impound')
end

function JailPlayer()
	ESX.UI.Menu.Open(
		'dialog', GetCurrentResourceName(), 'jail_menu',
		{
			title = _U('jail_menu_info'),
		},
	function (data2, menu)
		local jailTime = tonumber(data2.value)
		if jailTime == nil then
			ESX.ShowNotification(_U('invalid_amount'))
		else
			TriggerServerEvent("esx-qalle-jail:openJailMenu" , "police")
			menu.close()
		end
	end,
	function (data2, menu)
		menu.close()
	end
	)
end

function SendToCommunityService(player)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Community Service Menu', {
		title = "Community Service Menu",
	}, function (data2, menu)
		local community_services_count = tonumber(data2.value)

		if community_services_count > 80 then
			community_services_count = 80
			ESX.ShowNotification('Swipes were set to 80!')
		end
		
		if community_services_count == nil then
			ESX.ShowNotification('Invalid services count.')
		else
			TriggerServerEvent("esx_communityservice:sendToCommunityService" ,player, community_services_count, 'By Police')
			menu.close()
		end
	end, function (data2, menu)
		menu.close()
	end)
end

--utils

Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

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
		if Config.PlateUseSpace then
			generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. ' ' .. GetRandomNumber(Config.PlateNumbers))
		else
			generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. GetRandomNumber(Config.PlateNumbers))
		end

		ESX.TriggerServerCallback('esx_policejob:isPlateTaken', function (isPlateTaken)
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

--[[ RegisterNUICallback("close", function(data)
	Wait(1000)
	SetNuiFocus(false, false)
end)
 ]]
 RegisterNetEvent('esx_policejob:getOnlineHunted')
 AddEventHandler('esx_policejob:getOnlineHunted',function(result, deletedId)
	 huntedList = result
	 --unregisterTags()
	 createTags(deletedId)
 end)
 
 
 function unregisterTags()
	 for k,v in pairs(mpGamerTags) do
		 RemoveMpGamerTag(v.tag)
	 end
 end
 


 function createTags(deletedId)

	Wait(10000)
	if deletedId then
		local deleted = GetPlayerFromServerId(deletedId)
		if mpGamerTags[deleted] then
			SetMpGamerTagVisibility(mpGamerTags[deleted].tag, 0, false)
			RemoveMpGamerTag(mpGamerTags[deleted].tag)
			mpGamerTags[deleted] = nil
			deletedId = nil
		end
	end
	for i = 1, #huntedList,1 do
		local Player = GetPlayerFromServerId(huntedList[i].id)
		if --[[ NetworkIsPlayerActive(Player) and ]] Player ~= PlayerId() then
			if mpGamerTags[Player] then
				--RemoveMpGamerTag(mpGamerTags[Player].tag)
	
				mpGamerTags[Player] = nil
			end
			local ped = GetPlayerPed(huntedList[i].id)
		
			-- change the ped, because changing player models may recreate the ped
			if not mpGamerTags[Player] or mpGamerTags[Player].ped ~= ped then
				local stars = ''
				for j=1, huntedList[i].wantedLevel, 1 do
					stars = stars.."⭐"
				end
				--[[ if mpGamerTags[Player] then
					--print('ekana remove~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
					RemoveMpGamerTag(mpGamerTags[Player].tag)
				end ]]
				--print('ftiaxnw tag')
				mpGamerTags[Player] = {
					tag = CreateMpGamerTagForNetPlayer(Player,stars.."\n 	WANTED", false, false, '', 0, 0, 0, 0),
					ped = ped
				}
			end
			--print('eftiaksa tags')
			--SetMpGamerTagVisibility(mpGamerTags[Player].tag, 0, true)
		--[[ elseif mpGamerTags[Player] then
			RemoveMpGamerTag(mpGamerTags[Player].tag)
	
			mpGamerTags[Player] = nil ]]
		end
	end
	showTags()
end


 local textColor = 6
 Citizen.CreateThread(function()
	 while huntedList[1] == nil do
		 Wait(100)
	 end
	 while true do
		 Wait(1000)
		 if PlayerData.job.name == 'police' or PlayerData.job.name == 'police2' then
			 if textColor == 6 then
				 textColor = 9
			 elseif textColor == 9 then
				 textColor = 6
			 end
			 for k,v in pairs(mpGamerTags) do
				 SetMpGamerTagColour(v.tag,0,textColor)
			 end
		 end
	 end
 end) 
 
 function OpenHuntedList()
	 while huntedList[1] == nil do
		 Wait(100)
	 end
	 local elements = {}
	 for i=1,#huntedList,1 do
		 table.insert(elements,{label = '<font color="cyan">Όνομα:</font> '..huntedList[i].firstName..' <font color="cyan">Επώνυμο:</font> '..huntedList[i].lastName..' <font color="cyan">Wanted Level:</font> '..huntedList[i].wantedLevel,value = 
		 {id = huntedList[i].id, steamid = huntedList[i].identifier, wantedLevel = huntedList[i].wantedLevel, mugshot = huntedList[i].mugshot,firstName = huntedList[i].firstName, lastName = huntedList[i].lastName,name = GetPlayerName(GetPlayerFromServerId(huntedList[i].id))}})
	 end
	 table.insert(elements,{label = '<font color="red">Κλείσε </font>αφίσα επικυρηγμένου',value = {id = 'close'}})
	 ESX.UI.Menu.CloseAll()
	 ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'hunted_list',
	 {
		 title		= '🚨Λίστα Επικυρηγμένων🚨',
		 align		= 'bottom-right',
		 elements	= elements
	 }, function(data8, menu8)
		 if data8.current.value.id == 'close' then
			 TriggerEvent('esx_outlawalert:hideMugshot')
		 else
			 TriggerEvent('esx_outlawalert:showMugshot',data8.current.value.mugshot,data8.current.value.wantedLevel,data8.current.value.name,data8.current.value.firstName,data8.current.value.lastName)
		 end
	 end,function(data8, menu8)
		 menu8.close()
	 end)
 end
 
 
 function showTags()
	 if PlayerData.job.name == 'police' or PlayerData.job.name == 'police2' then
		 for k,v in pairs(mpGamerTags) do
			 SetMpGamerTagVisibility(v.tag, 0, true)
		 end
	 else
		 for k,v in pairs(mpGamerTags) do
			 SetMpGamerTagVisibility(v.tag, 0, false)
		 end
	 end
 end
 
 
 Citizen.CreateThread(function()
	 while true do
		 Wait(10000)
		 createTags()
		 showTags()
	 end
 end)
 


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





RegisterNetEvent("esx_policejob:getplates")
AddEventHandler("esx_policejob:getplates",function(data)

	plates = data
	NoOfPlates = 0
	for k,v in pairs(plates) do
		NoOfPlates = NoOfPlates  + 1
	end
end)



RegisterNetEvent("esx_policejob:updateplates")
AddEventHandler("esx_policejob:updateplates",function(plate,action)
	if action == "add" then
		plates[plate] = true
		NoOfPlates = 0
		for k,v in pairs(plates) do
			NoOfPlates = NoOfPlates  + 1
		end
	elseif action == "remove" then
		plates[plate] = nil
		NoOfPlates = 0
		for k,v in pairs(plates) do
			NoOfPlates = NoOfPlates  + 1
		end
		removeBlips()
	end

end)

function removeBlips()
    for k,v in pairs(blips) do
        RemoveBlip(blips[k])
    end       
end

CreateThread(function()
	local time = 0
	while true do
		 
		if NoOfPlates == 0 or not enabled then
			time = 5000
		else
			time = 0
		end

		if NoOfPlates > 0 and enabled then
			for k,v in pairs(ESX.Game.GetVehicles()) do
                local veh = v
                local plate = TrimPlate(GetVehicleNumberPlateText(veh))
				if GetBlipFromEntity(veh) < 1 and plates[plate] then
					local new_blip = AddBlipForEntity(veh)
					SetBlipSprite(new_blip, Config.Blips.VehicleSprite)
                    SetBlipColour(new_blip, Config.Blips.VehicleColor)
				
					SetBlipScale(new_blip, Config.Blips.Scale) 
	
					SetBlipCategory(new_blip, 7);
					SetBlipDisplay(new_blip, 6)
					blips[v] = new_blip
				end
			end
		else
			removeBlips()
		end

		Wait(time)
	end

end)

RegisterNetEvent("esx_policejob:state")
AddEventHandler("esx_policejob:state",function(state)
	enabled = state
end)

RegisterNetEvent("esx_policejob:citizeninteraction")
AddEventHandler("esx_policejob:citizeninteraction",function()
	local elements = {
		--{label = _U('id_card'),				value = 'identity_card'},
		--{label = _U('search'),				value = 'body_search'},
		{label = _U('handcuff'),			value = 'handcuff'},
		{label = _U('drag'),				value = 'drag'},
		{label = _U('put_in_vehicle'),		value = 'put_in_vehicle'},
		{label = _U('out_the_vehicle'),		value = 'out_the_vehicle'},
		{label = _U('fine'),				value = 'fine'},
		--{label = _U('jail'),				value = 'jail'},
		--{label = _U('Commmunity_service'),	value = 'communityservice'},
		{label = "Στείλε φυλακή",			value = 'jail'},
		{label = "Έλεγχος πόλιτη",			value = 'check_civilian'},
	}

	if Config.EnableLicenses and PlayerData.job.grade >= 1 then
		table.insert(elements, { label = _U('license_check'), value = 'license' })
	end


	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'citizen_interaction',
	{
		title    = _U('citizen_interaction'),
		align    = 'bottom-right',
		elements = elements
	}, function(data2, menu2)
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 3.0 then
			local action = data2.current.value

			if action == 'identity_card' then
				OpenIdentityCardMenu(closestPlayer)
			--[[ elseif action == 'body_search' then
				TriggerServerEvent('esx_policejob:message' , GetPlayerServerId(closestPlayer), _U('being_searched'))
				OpenBodySearchMenu(closestPlayer) ]]
			elseif action == 'check_civilian' then
				CheckCivilianMenu()
			elseif action == 'handcuff' then
				if GlobalState.inEvent ~= 'battleRoyale' then
					TriggerServerEvent('esx_policejob:handcuff' , GetPlayerServerId(closestPlayer))
				end
			elseif action == 'drag' then
				TriggerServerEvent('esx_policejob:drag' , GetPlayerServerId(closestPlayer))
			elseif action == 'put_in_vehicle' then
				TriggerServerEvent('esx_policejob:putInVehicle' , GetPlayerServerId(closestPlayer))
			elseif action == 'out_the_vehicle' then
				TriggerServerEvent('esx_policejob:OutVehicle' , GetPlayerServerId(closestPlayer))
			elseif action == 'fine' then
				OpenFineMenu(closestPlayer)
			elseif action == 'license' then
				ShowPlayerLicense(closestPlayer)
			elseif action == 'jail' then
				TriggerEvent('esx-qalle-jail:openJailMenu', "police")
			elseif action == 'communityservice' then
				TriggerServerEvent('3dme:showCloseIds',GetEntityCoords(PlayerPedId()))
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'comm_serv', {
					title = 'Choose ID'
				}, function(data70, menu70)
					if tonumber(GetPlayerServerId(PlayerId())) == tonumber(data70.value) then
						ESX.ShowNotification('You can\'t send yourself for community service!')
					else
						local targetCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(data70.value)))

						if GetDistanceBetweenCoords(targetCoords, vector3(932.43,-278.7,67.09),true) < 20 then
							SendToCommunityService(data70.value)
						else
							ESX.ShowNotification("Πρέπει να κάνεις μεταγωγή τον κρατούμενο για να τον στείλεις κοινωνική εργασία")
						end
					end
					menu70.close()
				end, function(data70, menu70)
					ESX.UI.Menu.CloseAll()
				end)
			elseif action == 'jail' then
				TriggerServerEvent('3dme:showCloseIds',GetEntityCoords(PlayerPedId()))
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'comm_serv', {
					title = 'Choose ID'
				}, function(data71, menu71)
					if tonumber(GetPlayerServerId(PlayerId())) == tonumber(data71.value) then
						ESX.ShowNotification('You can\'t send yourself to jail!')
					else
						JailPlayer()
					end
					menu71.close()
				end, function(data71, menu71)
					ESX.UI.Menu.CloseAll()
				end)
			end

		else
			ESX.ShowNotification(_U('no_players_nearby'))
		end
	end, function(data2, menu2)
		menu2.close()
	end)
end)

RegisterNetEvent("esx_policejob:vehicleinteraction")
AddEventHandler("esx_policejob:vehicleinteraction",function()
	local elements  = {}
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local vehicle   = ESX.Game.GetVehicleInDirection()

	if DoesEntityExist(vehicle) then
		table.insert(elements, {label = _U('pick_lock'),	value = 'hijack_vehicle'})
		table.insert(elements, {label = _U('fineVehicle'),			value = 'fineVehicle'})
		table.insert(elements, {label = _U('impound'),		value = 'impound'})
		table.insert(elements, {label = 'Δες Ιδιοκτήτη Οχήματος',		value = 'getVehOwner'})
		
	else
		ESX.ShowNotification("No Vehicle Nearby")
		return
	end


	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'vehicle_interaction',
	{
		title    = _U('vehicle_interaction'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		coords  = GetEntityCoords(playerPed)
		vehicle = ESX.Game.GetVehicleInDirection()
		action  = data.current.value
		
		if action == 'search_database' then
			LookupVehicle()
		elseif DoesEntityExist(vehicle) then
			local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
			if action == 'vehicle_infos' then
				OpenVehicleInfosMenu(vehicleData)
			elseif action == 'fineVehicle' then
				OpenFineVehicleMenu(vehicle)
			elseif action == 'getVehOwner' then
				OpenGetVehicleOwnerMenu(vehicle)	
			elseif action == 'hijack_vehicle' then
				if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
					TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
					Citizen.Wait(20000)
					ClearPedTasksImmediately(playerPed)

					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ESX.ShowNotification(_U('vehicle_unlocked'))
				end
			elseif action == 'impound' then
			
				-- is the script busy?
				if CurrentTask.Busy then
					return
				end

				ESX.ShowHelpNotification(_U('impound_prompt'))
				
				TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
				
				CurrentTask.Busy = true
				CurrentTask.Task = ESX.SetTimeout(10000, function()
					ClearPedTasks(playerPed)
					ImpoundVehicle(vehicle)
					Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
				end)
				
				-- keep track of that vehicle!
				Citizen.CreateThread(function()
					while CurrentTask.Busy do
						Citizen.Wait(1000)
					
						vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
						if not DoesEntityExist(vehicle) and CurrentTask.Busy then
							ESX.ShowNotification(_U('impound_canceled_moved'))
							ESX.ClearTimeout(CurrentTask.Task)
							ClearPedTasks(playerPed)
							CurrentTask.Busy = false
							break
						end
					end
				end)
			end
		else
			ESX.ShowNotification(_U('no_vehicles_nearby'))
		end

	end, function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent("esx_policejob:objectspawner")
AddEventHandler("esx_policejob:objectspawner",function()
	local objs = {
		'prop_roadcone02a',
		'prop_barrier_work05',
		'p_ld_stinger_s',
		'prop_boxpile_07d',
		'hei_prop_cash_crate_half_full'
	}
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'citizen_interaction',
	{
		title    = _U('traffic_interaction'),
		align    = 'bottom-right',
		elements = {
			{label = _U('cone'),		value = 'prop_roadcone02a'},
			{label = _U('barrier'),		value = 'prop_barrier_work05'},
			{label = _U('spikestrips'),	value = 'p_ld_stinger_s'},
			{label = _U('box'),			value = 'prop_boxpile_07d'},
			{label = _U('cash'),		value = 'hei_prop_cash_crate_half_full'},
			{label = 'Μάζεψε Αντικείμενο',		value = 'delete'}
		}
	}, function(data2, menu2)
		if data2.current.value == 'delete' then
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)

			local closestDistance = -1
			local closestEntity   = nil
			for i=1, #objs, 1 do
				local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(objs[i]), false, false, false)

				if DoesEntityExist(object) then
					local objCoords = GetEntityCoords(object)
					local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

					if closestDistance == -1 or closestDistance > distance then
						closestDistance = distance
						closestEntity   = object
					end
				end
			end
			if closestEntity and closestDistance < 5 then
				SetEntityAsNoLongerNeeded(closestEntity)
				ESX.Game.DeleteObject(closestEntity)
				DeleteEntity(closestEntity)
			else
				ESX.ShowNotification('No object nearby')
			end
		else
			ESX.TriggerServerCallback('esx_policejob:object_limiter', function(cd) 
				obj_cooldown = cd
			end)
			
			Wait(1200)
			if obj_cooldown > 10 then
				ESX.ShowNotification('You cannot spawn more than 10 objects per restart')
				return
			end
			local model     = data2.current.value
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local forward   = GetEntityForwardVector(playerPed)
			local x, y, z   = table.unpack(coords + forward * 1.0)

			if model == 'prop_roadcone02a' then
				z = z - 2.0
			end

			ESX.Game.SpawnObject(model, {
				x = x,
				y = y,
				z = z
			}, function(obj)
				SetEntityHeading(obj, GetEntityHeading(playerPed))
				PlaceObjectOnGroundProperly(obj)
			end)
		end

	end, function(data2, menu2)
		menu2.close()
	end)
end)

RegisterNetEvent("esx_policejob:panicbutton")
AddEventHandler("esx_policejob:panicbutton",function()
	TriggerServerEvent('esx_policejob:usePanicButton')
end)

RegisterNetEvent('esx_policejob:usePanicButton')
AddEventHandler('esx_policejob:usePanicButton', function(coords)
	if PlayerData and PlayerData.job and (PlayerData.job.name == 'police' or PlayerData.job.name == 'police2') then
		local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
		SetBlipHighDetail(blip, true)
		SetBlipSprite(blip, 3)
		SetBlipScale(blip, 1.0)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Used Panic Button')
		EndTextCommandSetBlipName(blip)
		
		ESX.ShowNotification('A police officer used the panic button')
		
		Citizen.SetTimeout(10000, function()
			if DoesBlipExist(blip) then
				RemoveBlip(blip)
			end
		end)
	end
end)

RegisterNetEvent("esx_policejob:robbs")
AddEventHandler("esx_policejob:robbs",function()
	local elements = {
		{label = "Απενεργοποίηση Ληστείων",	value = 'disable_robb'},
		{label = "Ενεργοποίηση Ληστείων",	value = 'enable_robb'},
	}
	
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'robb_interaction',
	{
		title    = "Ληστείες",
		align    = 'bottom-right',
		elements = elements
	}, function(data2, menu2)
		local action = data2.current.value
	
		if action == 'disable_robb' then
			TriggerServerEvent('esx_policejob:setHold', true)
		elseif action == 'enable_robb' then
			TriggerServerEvent('esx_policejob:setHold', false)
		end
	end, function(data2, menu2)
		menu2.close()
	end)
end)

RegisterNetEvent("esx_policejob:weaponlicense")
AddEventHandler("esx_policejob:weaponlicense",function()
	openLicenseMenu(name,surname,license,expire,month)
end)

RegisterNetEvent("esx_policejob:tracker")
AddEventHandler("esx_policejob:tracker",function()
	local elements3 = {}
	table.insert(elements3,{ label = "Πρόσθεση το κοντινότερο όχημα", value = "add" } )
	table.insert(elements3,{ label = "Δες τη λίστα", value = "list" } )
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'vehicle_gps_actions_lala1',
	{
		title    = "Επίλεξε",
		align    = 'bottom-right',
		elements = elements3
	}, function(data, menu)
		if data.current.value == "add" then
			local veh, distance = ESX.Game.GetClosestVehicle()
			if veh ~= 0 and veh ~= -1 and distance < 5 then
				ExecuteCommand("e kneel")
				exports['progressBars']:startUI2(10000, "Κατοχύρωση οχήματος...",function(state)
					if state then
						TriggerServerEvent("esx_policejob:addplate", GetVehicleNumberPlateText(veh))
						ClearPedTasksImmediately(PlayerPedId())
					end
				end) 
				
				
			else
				ESX.ShowNotification("Δεν υπάρχει όχημα κοντά σου")
			end
		elseif data.current.value == "list" then
			elements = {}
			for k,v in pairs(plates) do
				table.insert(elements,{ label = "Πινακίδα: "..k, value = k })
			end
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'plates_list',
			{
				title    = "Plates",
				align    = 'bottom-right',
				elements = elements
			}, function(data, menu)
				local plate = data.current.value
				elements = {}
				table.insert(elements,{ label = "ΟΧΙ", value = "no" } )
				table.insert(elements,{ label = "ΝΑΙ", value = "yes" } )
				ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'confirm_vehicle',
				{
					title    = "Είσαι Σίγουρος για τη διαγραφή?",
					align    = 'bottom-right',
					elements = elements
				}, function(data, menu)
					if data.current.value == "yes" then
						TriggerServerEvent("esx_policejob:deleteplate", plate)
						menu.close()
						ESX.UI.Menu.CloseAll()
					else
						menu.close()
					end
				end, function(data, menu)
					menu.close()
				end)

				
			end, function(data, menu)
				menu.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent("esx_policejob:huntedlist")
AddEventHandler("esx_policejob:huntedlist",function()
	OpenHuntedList()
end)

CreateThread(function()
	while PlayerData.job == nil do
		Wait(500)
	end
	
	while true do
		if PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'police2' then
			local model = GetEntityModel(PlayerPedId())
			
			if Config.UniqueClothes[model] then
				for k,v in pairs(Config.Drawables) do
					if Config.UniqueClothes[model][k] and Config.UniqueClothes[model][k][v.get()] then
						v.clear()
						ESX.ShowNotification(k..' removed because you are not police officer')
						Wait(1000)
					end
				end
			end
		end
		
		Wait(5000)
	end
end)