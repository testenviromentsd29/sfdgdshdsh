ESX = nil

local jobCache
local employeesCache
local logsCache
local privilegesCache

local cooldown = 0
local lastTimeMenuOpened = 0

local hasMenuOpen = false
local displayFriends = false

local backupBlip = nil

local abilities = {}
local validAbilities = {}

local activeTags = {}
local alliances = {}
local wars = {}

local shouldResetTags = false

for k,v in pairs(ConfigCL.Abilities) do
	validAbilities[v.name] = true
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	
	ESX.PlayerData = ESX.GetPlayerData()
	
	ProcessMark()
	--ProcessAbilities()
	ProcessAlliesEnemies()
end)

function ProcessMark()
	local markBlip = nil
	local markCoords = nil

	RegisterNetEvent('esx_mMafia:markLocation')
	AddEventHandler('esx_mMafia:markLocation', function(job, coords)
		if ESX.PlayerData.job.name == job then
			if DoesBlipExist(markBlip) then
				RemoveBlip(markBlip)
			end

			if markCoords and #(markCoords.xy - coords.xy) < 5.0 then
				markCoords = nil
				markBlip = nil

				return
			end

			markCoords = coords

			markBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
			SetBlipSprite(markBlip, math.floor(1))
			SetBlipColour(markBlip, math.floor(1))
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString('Marked Location')
			EndTextCommandSetBlipName(markBlip)
		end
	end)

	local function RotationToDirection(rotation)
		local adjustedRotation = 
		{ 
			x = (math.pi / 180) * rotation.x, 
			y = (math.pi / 180) * rotation.y, 
			z = (math.pi / 180) * rotation.z 
		}
		local direction = 
		{
			x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
			y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
			z = math.sin(adjustedRotation.x)
		}
		return direction
	end
	
	local function RayCastGamePlayCamera(distance)
		local cameraRotation = GetGameplayCamRot()
		local cameraCoord = GetGameplayCamCoord()
		local direction = RotationToDirection(cameraRotation)
		local destination = 
		{ 
			x = cameraCoord.x + direction.x * distance, 
			y = cameraCoord.y + direction.y * distance, 
			z = cameraCoord.z + direction.z * distance 
		}
		local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1,-1, -1))
		return b, c, e
	end

	local function DrawText2(x, y, scale, text)
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

	Citizen.CreateThread(function()
		local cooldown = 0

		while true do
			local wait = 500

			if not IsEntityDead(PlayerPedId()) and IsPedArmed(PlayerPedId(), 4) and IsPlayerFreeAiming(PlayerId()) then
				wait = 0

				if IsControlJustReleased(0, 38) then
					local hit, coords, entity = RayCastGamePlayCamera(1000.0)

					if hit == 1 then
						if cooldown < GetGameTimer() then
							cooldown = GetGameTimer() + 5000
							TriggerServerEvent('esx_mMafia:markLocation', coords)
						end
					end
				end
			end

			Wait(wait)
		end
	end)

	Citizen.CreateThread(function()
		local cooldown = 0

		while true do
			local wait = 500

			if markCoords then
				wait = 0
				DrawMarker(1, markCoords.x, markCoords.y, 0.0, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 9999.0, 255, 0, 0, 200, false, false, 2, false, false, false, false)
				local distance = math.ceil(#(GetEntityCoords(PlayerPedId()) - markCoords))
				DrawText2(0.45, 0.05, 0.7, distance..'m')
			end

			Wait(wait)
		end
	end)
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	
	if hasMenuOpen then
		Wait(100)
		SendNUIMessage({action = 'hide'})
	end
end)

RegisterNetEvent('esx_mMafia:sendAbilities')
AddEventHandler('esx_mMafia:sendAbilities', function(data)
	abilities = data or {}
end)

RegisterNetEvent('esx_mMafia:sendAlliances')
AddEventHandler('esx_mMafia:sendAlliances', function(data)
	alliances = data or {}
	shouldResetTags = true
end)

RegisterNetEvent('esx_mMafia:sendWars')
AddEventHandler('esx_mMafia:sendWars', function(data)
	wars = data or {}
	shouldResetTags = true
end)

--[[Citizen.CreateThread(function()
	while true do
		Wait(1000)
		
		local health = GetEntityHealth(PlayerPedId())
		local armor = GetPedArmour(PlayerPedId())
		
		local maxHealth = GetEntityMaxHealth(PlayerPedId())
		local maxArmor = GetPlayerMaxArmour(PlayerId())
		
		print('Health: '..health..'/'..maxHealth..' | Armor: '..armor..'/'..maxArmor)
	end
end)]]

--[[function ProcessAbilities()
	Citizen.CreateThread(function()
		while true do
			Wait(ConfigCL.AbilitiesInterval*1000)
			
			if abilities.speed then
				local multi = 1.0 + abilities.speed/math.floor(1000)
				SetRunSprintMultiplierForPlayer(PlayerId(), multi)
			else
				SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
			end
			
			if abilities.health and not IsEntityDead(PlayerPedId()) then
				local newHealth = GetEntityHealth(PlayerPedId()) + math.floor(abilities.health*10/100)
				
				if newHealth <= math.floor(300) then
					SetEntityHealth(PlayerPedId(), newHealth)
				end
			end
			
			if abilities.vest and not IsEntityDead(PlayerPedId()) then
				local curArmor = GetPedArmour(PlayerPedId())
				
				if curArmor > math.floor(0) then
					local newArmor = curArmor + math.floor(abilities.vest*10/100)
					
					if newArmor <= math.floor(100) then
						SetPedArmour(PlayerPedId(), newArmor)
					end
				end
			end
		end
	end)
end--]]

function ProcessAlliesEnemies()
	Citizen.CreateThread(function()
		while true do
			Wait(5000)
			
			if shouldResetTags then
				shouldResetTags = false
				
				for sid,v in pairs(activeTags) do
					RemoveMpGamerTag(v.tag)
				end
				
				activeTags = {}
			end
			
			local coords = GetEntityCoords(PlayerPedId())
			
			for k,v in pairs(GetActivePlayers()) do
				local sid = GetPlayerServerId(v)
				local targetPed = GetPlayerPed(v)
				
				if #(coords - GetEntityCoords(targetPed)) <= ConfigCL.DistanceToDrawTags and IsEntityVisible(targetPed) then
					if activeTags[sid] == nil then
						local targetJob = ESX.GetPlayerJob(sid).name or ''
						
						if IsAlly(targetJob) then
							--print('Creating [ALLY] tag for: '..sid)
							activeTags[sid] = {tag = CreateFakeMpGamerTagFunc(targetPed, ConfigCL.AllieText), job = targetJob}
						elseif IsEnemy(targetJob) then
							--print('Creating [ENEMY] tag for: '..sid)
							activeTags[sid] = {tag = CreateFakeMpGamerTagFunc(targetPed, ConfigCL.EnemyText), job = targetJob}
						end
					end
				else
					if activeTags[sid] then
						--print('Deleting tag for: '..sid..' [Far Away]')
						
						RemoveMpGamerTag(activeTags[sid].tag)
						activeTags[sid] = nil
					end
				end
				
				Wait(20)
			end
			
			for sid,v in pairs(activeTags) do
				local target = GetPlayerFromServerId(sid)
				
				if target == math.floor(-1) then
					--print('Deleting tag for: '..sid..' [-1]')
					
					RemoveMpGamerTag(v.tag)
					activeTags[sid] = nil
				else
					local targetJob = ESX.GetPlayerJob(sid).name or ''
					
					if v.job ~= targetJob then
						--print('Deleting tag for: '..sid..' [Changed job]')
						
						RemoveMpGamerTag(v.tag)
						activeTags[sid] = nil
					end
				end
				
				Wait(20)
			end
		end
	end)
end

AddEventHandler('esx_mMafia:openSocietyMenu', function() --gets called from esx_society
	ESX.TriggerServerCallback('esx_society:getJob', function(job)
		ESX.TriggerServerCallback('esx_mMafia:getMafiaPoints', function(experience, rank, locked, money)
			jobCache = job
			
			jobCache.rank = rank
			jobCache.experience = experience
			jobCache.epr = ConfigCL.ExperiencePerRank
			jobCache.apr = ConfigCL.AbilityPerRank
			jobCache.ppa = ConfigCL.PercentPerAbility
			jobCache.isArmoryLocked = locked
			jobCache.societyMoney = money
			
			hasMenuOpen = true
			
			SetNuiFocus(true, true)
			SendNUIMessage({action = 'show', job = jobCache})
		end)
	end, ESX.PlayerData.job.name)
end)

RegisterNetEvent('esx_mMafia:setMeeting')
AddEventHandler('esx_mMafia:setMeeting', function(caller, job, coords)
	if ESX.PlayerData.job.name == job then
		if DoesBlipExist(backupBlip) then
			RemoveBlip(backupBlip)
		end
		
		backupBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
		SetBlipSprite(backupBlip, math.floor(491))
		SetBlipColour(backupBlip, math.floor(1))
		SetBlipRoute(backupBlip, true)
		SetBlipRouteColour(backupBlip, math.floor(1))
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Need Backup')
		EndTextCommandSetBlipName(backupBlip)
		
		ESX.ShowNotification('Check your GPS for the backup point')
		
		Citizen.CreateThread(function()
			while DoesBlipExist(backupBlip) and #(GetEntityCoords(PlayerPedId()) - coords) > 5.0 do
				Wait(100)
			end
			
			if DoesBlipExist(backupBlip) then
				SetBlipRoute(backupBlip, false)
			end
		end)
	end
end)

RegisterNetEvent('esx_mMafia:endMeeting')
AddEventHandler('esx_mMafia:endMeeting', function(job)
	if ESX.PlayerData.job.name == job then
		if DoesBlipExist(backupBlip) then
			RemoveBlip(backupBlip)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for sid,v in pairs(activeTags) do
			RemoveMpGamerTag(v.tag)
		end
	end
end)

RegisterNUICallback('quit', function(data)
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
end)

RegisterNUICallback('rank_up', function(data)
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(2000))
	
	ESX.TriggerServerCallback('esx_mMafia:rankUp', function(rank, experience)
		if rank > jobCache.rank then
			jobCache.rank = rank
			jobCache.experience = experience
			
			SendNUIMessage({action = 'show', job = jobCache})
			
			ESX.ShowNotification('Mafia ranked up!')
		end
	end, ESX.PlayerData.job.name)
end)

RegisterNUICallback('meeting', function(data)
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(2000))
	
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
	
	if not DoesBlipExist(backupBlip) then
		TriggerServerEvent('esx_mMafia:setMeeting', GetEntityCoords(PlayerPedId()))
	else
		TriggerServerEvent('esx_mMafia:endMeeting')
	end
end)

RegisterNUICallback('change_boss', function()
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(2000))
	
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
	
	if HasAccess('og_boss') then
		TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))
		
		local data = exports['dialog']:Create('Change Job Boss', 'Enter target ID')
		local target = tonumber(data.value)
		
		if not target then
			ESX.ShowNotification('Target not found')
			return
		end
		
		local data = exports['dialog']:Decision('Change Job Boss', 'Are you sure?')
		local answer = tonumber(data.value)
		
		if answer and answer == 1 then
			TriggerServerEvent('esx_society:changeJobBoss', target)
		end
	else
		ESX.ShowNotification('Only the original boss can use this option')
	end
end)

RegisterNUICallback('change_viceboss', function()
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(2000))
	
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
	
	if HasAccess('og_boss') then
		TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))
		
		local data = exports['dialog']:Create('Change Job Viceboss', 'Enter target ID')
		local target = tonumber(data.value)
		
		if not target then
			ESX.ShowNotification('Target not found')
			return
		end
		
		local data = exports['dialog']:Decision('Change Job Viceboss', 'Are you sure?')
		local answer = tonumber(data.value)
		
		if answer and answer == 1 then
			TriggerServerEvent('esx_society:changeJobViceboss', target)
		end
	else
		ESX.ShowNotification('Only the original boss can use this option')
	end
end)

RegisterNUICallback('expel_viceboss', function()
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(2000))
	
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
	
	if HasAccess('og_boss') then
		local data = exports['dialog']:Decision('Expel Job Viceboss', 'Are you sure?')
		local answer = tonumber(data.value)
		
		if answer and answer == 1 then
			TriggerServerEvent('esx_society:kickJobViceboss')
		end
	else
		ESX.ShowNotification('Only the original boss can use this option')
	end
end)

RegisterNUICallback('display_members', function(data)
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(2000))
	
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
	
	if not HasAccess('display-workers') then
		ESX.ShowNotification('You dont have access to use this option')
		Wait(100)
		SendNUIMessage({action = 'hide'})
		
		return
	end
	
	if not displayFriends then
		displayFriends = true
		
		Citizen.CreateThread(function()
			local blips = {}
			
			while displayFriends do
				for _, target in pairs(GetActivePlayers()) do
					if target ~= PlayerId() then
						local sid = GetPlayerServerId(target)
						
						if blips[sid] == nil then
							local targetJob = ESX.GetPlayerJob(sid).name or ''
							
							if ESX.PlayerData.job.name == targetJob then
								blips[sid] = AddBlipForEntity(GetPlayerPed(target))
								SetBlipSprite(blips[sid], math.floor(480))
								SetBlipColour(blips[sid], math.floor(2))
								SetBlipScale(blips[sid], 0.7)
								BeginTextCommandSetBlipName('STRING')
								AddTextComponentString('Friend')
								EndTextCommandSetBlipName(blips[sid])
							elseif exports['esx_mMafia']:IsAlly(targetJob) then
								blips[sid] = AddBlipForEntity(GetPlayerPed(target))
								SetBlipSprite(blips[sid], math.floor(480))
								SetBlipColour(blips[sid], math.floor(3))
								SetBlipScale(blips[sid], 0.7)
								BeginTextCommandSetBlipName('STRING')
								AddTextComponentString('Friend')
								EndTextCommandSetBlipName(blips[sid])
							end
						end
					end
					
					Wait(100)
				end
				
				for sid,v in pairs(blips) do
					local target = GetPlayerFromServerId(sid)
					
					if target == math.floor(-1) then
						if DoesBlipExist(v) then RemoveBlip(v) end
						blips[sid] = nil
					end
					
					Wait(100)
				end
				
				Wait(0)
			end
			
			for k,v in pairs(blips) do
				if DoesBlipExist(v) then RemoveBlip(v) end
			end
		end)
	else
		displayFriends = false
	end
end)

RegisterNUICallback('deposit', function()
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(2000))
	
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
	
	if HasAccess('deposit') then
		local data = exports['dialog']:Create('Deposit Black Money', 'Enter amount to deposit')
		local amount = tonumber(data.value)
		
		if amount and amount > math.floor(0) then
			TriggerServerEvent('esx_mMafia:depositMoney', amount)
		else
			ESX.ShowNotification('Invalid amount')
		end
	else
		ESX.ShowNotification('You dont have access to use this option')
	end
end)

RegisterNUICallback('unlockables', function()
	if HasAccess('unlockables') then
		SetCooldown(math.floor(500))
		SendNUIMessage({action = 'unlockables', unlockables = ConfigCL.Unlockables})
	else
		ESX.ShowNotification('You dont have access to use this option')
		Wait(100)
		SendNUIMessage({action = 'hide'})
	end
end)

RegisterNUICallback('tasks', function()
	if HasAccess('tasks') then
		SetCooldown(math.floor(500))
		SendNUIMessage({action = 'tasks', tasks = myCurrentTasks or {}, config = ConfigCL.Tasks})
	else
		ESX.ShowNotification('You dont have access to use this option')
		Wait(100)
		SendNUIMessage({action = 'hide'})
	end
end)

RegisterNUICallback('mafia_abilities', function()
	if HasAccess('abilities') then
		SetCooldown(math.floor(500))
		SendNUIMessage({action = 'abilities', abilities = abilities, config = ConfigCL.Abilities})
	else
		ESX.ShowNotification('You dont have access to use this option')
		Wait(100)
		SendNUIMessage({action = 'hide'})
	end
end)

RegisterNUICallback('increase_rank', function()
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(1000))
	
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
	
	if exports['dialog']:Decision('Increase Rank', 'Buy 1 rank for '..ConfigCL.IncreaseRankCost..' DC', '', 'YES', 'NO').action == 'submit' then
		TriggerServerEvent('esx_mMafia:increaseRank', ESX.PlayerData.job.name)
	end
end)

RegisterNUICallback('reset_abilities', function()
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(1000))
	
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
	
	if exports['dialog']:Decision('Reset Abilities', 'Reset abilities for '..ConfigCL.ResetAbilitiesCost..' DC', '', 'YES', 'NO').action == 'submit' then
		TriggerServerEvent('esx_mMafia:resetAbilities', ESX.PlayerData.job.name)
	end
end)

RegisterNUICallback('upgrade_ability', function(name)
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(2000))
	
	if HasAccess('abilities') then
		ESX.TriggerServerCallback('esx_mMafia:upgradeAbility', function(abilities)
			if abilities then
				SendNUIMessage({action = 'abilities', abilities = abilities, config = ConfigCL.Abilities})
			end
		end, ESX.PlayerData.job.name, name)
	else
		ESX.ShowNotification('You dont have access to use this option')
		Wait(100)
		SendNUIMessage({action = 'hide'})
	end
end)

RegisterNUICallback('withdraw', function()
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(2000))
	
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
	
	if HasAccess('withdraw') then
		local data = exports['dialog']:Create('Withdraw Black Money', 'Enter amount to withdraw')
		local amount = tonumber(data.value)
		
		if amount and amount > math.floor(0) then
			TriggerServerEvent('esx_mMafia:withdrawMoney', amount)
		else
			ESX.ShowNotification('Invalid amount')
		end
	else
		ESX.ShowNotification('You dont have access to use this option')
	end
end)

RegisterNUICallback('fire', function(data)
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(2000))
	
	if HasAccess('company-workers') then
		if not data.isSecondJob then
			ESX.TriggerServerCallback('esx_society:setJob', function()
				RemoveIdentifierFromCache(data.identifier)
				SendNUIMessage({action = 'manage_employees', employees = employeesCache})
			end, data.identifier, 'unemployed', math.floor(0), 'fire', data.isPreviousJob)
		else
			ESX.TriggerServerCallback('esx_society:setJob2', function()
				RemoveIdentifierFromCache(data.identifier)
				SendNUIMessage({action = 'manage_employees', employees = employeesCache})
			end, data.identifier, 'unemployed', math.floor(0), 'fire', data.isPreviousJob)
		end
	else
		ESX.ShowNotification('You dont have access to use this option')
	end
end)

RegisterNUICallback('warehouse', function(data)
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(2000))
	
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
	
	TriggerServerEvent('esx_society:changeWarehouseStatus', data.status)
end)

RegisterNUICallback('hire', function()
	if not HasAccess('hire-worker') then
		ESX.ShowNotification('You dont have access to use this option')
		Wait(100)
		SendNUIMessage({action = 'hide'})
		
		return
	end
	
	local data = {}
	local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 5.0)
	
	if #players <= 8 then
		for i=1, #players, 1 do
			if players[i] ~= PlayerId() then
				local mugshot = RegisterPedheadshot(GetPlayerPed(players[i]))
				while not IsPedheadshotReady(mugshot) do Wait(0) end
				local name = GlobalState.PlayerRealIngameNames[GetPlayerServerId(players[i])] or GetPlayerName(players[i])
				table.insert(data, {
					name		= name,
					player		= GetPlayerServerId(players[i]),
					mugshot		= GetPedheadshotTxdString(mugshot),
					mugshotId	= mugshot
				})
			end
		end
		
		local playerIds = {}
		
		for i=1, #data do
			table.insert(playerIds, {player = data[i].player, level = math.floor(0)})
			UnregisterPedheadshot(data[i].mugshotId)
		end
		
		ESX.TriggerServerCallback('esx_society:getBattlepassLevels', function(playerIds)
			for i=1, #playerIds do
				data[i].level = playerIds[i].level
				data[i].hasAccess = playerIds[i].hasAccess
			end
			
			SendNUIMessage({action = 'hire', data = data})
		end, playerIds)
	else
		ESX.ShowNotification('You dont have access to use this option')
	end
end)

RegisterNUICallback('invite', function(target)
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(1000))
	TriggerServerEvent('esx_society:inviteToJob', ESX.PlayerData.job.name, tonumber(target))
end)

RegisterNUICallback('select_unlockable', function(id)
	SetCooldown(math.floor(2000))
	
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
	
	local id = tonumber(id)
	local amount = math.floor(1)
	
	if ConfigCL.Unlockables[id].dialog then
		local data = exports['dialog']:Create('Enter amount', 'The final price will be: amount*price')
		amount = tonumber(data.value)
	end
	
	if amount and amount > math.floor(0) then
		TriggerServerEvent('esx_mMafia:unlockables', id, amount)
	end
end)

RegisterNUICallback('select_rank', function(data)
	local grade = tonumber(data.grade)
	
	if GetGradeFromCache(data.identifier) == grade then
		ESX.ShowNotification('Target has already this grade')
		return
	end
	
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(2000))
	
	if HasAccess('company-workers') then
		if not data.isSecondJob then
			ESX.TriggerServerCallback('esx_society:setJob', function()
				EditGradeFromCache(data.identifier, grade)
				SendNUIMessage({action = 'manage_employees', employees = employeesCache})
			end, data.identifier, ESX.PlayerData.job.name, grade, 'promote')
		else
			ESX.TriggerServerCallback('esx_society:setJob2', function()
				EditGradeFromCache(data.identifier, grade)
				SendNUIMessage({action = 'manage_employees', employees = employeesCache})
			end, data.identifier, ESX.PlayerData.job.name, grade, 'promote')
		end
	else
		ESX.ShowNotification('You dont have access to use this option')
	end
end)

RegisterNUICallback('manage_employees', function(data)
	if (HasAccess('company-workers') and not data.isRewarding) or (HasAccess('single-reward') and data.isRewarding) then
		if employeesCache == nil then
			ESX.TriggerServerCallback('esx_society:getEmployees2', function(employees)
				employeesCache = employees
				table.sort(employeesCache, function(a,b) return a.id < b.id end)
				
				SendNUIMessage({action = 'manage_employees', employees = employeesCache, isRewarding = data.isRewarding})
			end, ESX.PlayerData.job.name)
		else
			SendNUIMessage({action = 'manage_employees', employees = employeesCache, isRewarding = data.isRewarding})
		end
	else
		ESX.ShowNotification('You dont have access to use this option')
		Wait(100)
		SendNUIMessage({action = 'hide'})
	end
end)

RegisterNUICallback('reward', function(identifier)
	if HasAccess('single-reward') then
		local data = exports['dialog']:Create('Black Money Reward', 'Enter amount to give [1000-10000]')
		local amount = tonumber(data.value)
		
		if amount and amount >= 1000 and amount <= 10000 then
			TriggerServerEvent('esx_mMafia:giveReward', ESX.PlayerData.job.name, identifier, amount)
		else
			ESX.ShowNotification('Amount must be [1000-10000]')
		end
	else
		ESX.ShowNotification('You dont have access to use this option')
		Wait(100)
		SendNUIMessage({action = 'hide'})
	end
end)

RegisterNUICallback('mass_reward', function(identifier)
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(2000))
	
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
	
	if HasAccess('mass-reward') then
		local data = exports['dialog']:Create('Black Money Reward', 'Enter amount to give [1000-10000]</br>The final amount will be: amount*mafia members')
		local amount = tonumber(data.value)
		
		if amount and amount >= 1000 and amount <= 10000 then
			TriggerServerEvent('esx_mMafia:giveMassReward', ESX.PlayerData.job.name, amount)
		else
			ESX.ShowNotification('Amount must be [1000-10000]')
		end
	else
		ESX.ShowNotification('You dont have access to use this option')
	end
end)

RegisterNUICallback('manage_allies', function()
	if HasAccess('allies-foe') then
		SetCooldown(math.floor(1000))
		
		ESX.TriggerServerCallback('esx_mMafia:getAllies', function(allies)
			SendNUIMessage({action = 'manage_allies', allies = allies})
		end, ESX.PlayerData.job.name)
	else
		ESX.ShowNotification('You dont have access to use this option')
		Wait(100)
		SendNUIMessage({action = 'hide'})
	end
end)

RegisterNUICallback('manage_enemies', function()
	if HasAccess('allies-foe') then
		SetCooldown(math.floor(1000))
		
		ESX.TriggerServerCallback('esx_mMafia:getEnemies', function(enemies)
			SendNUIMessage({action = 'manage_enemies', enemies = enemies})
		end, ESX.PlayerData.job.name)
	else
		ESX.ShowNotification('You dont have access to use this option')
		Wait(100)
		SendNUIMessage({action = 'hide'})
	end
end)

RegisterNUICallback('request_alliance', function(data)
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
	
	if exports['dialog']:Decision('Request Alliance', 'Send alliance request to '..data.label..'?', '', 'YES', 'NO').action == 'submit' then
		TriggerServerEvent('esx_mMafia:requestAlliance', data.jobname)
	end
end)

RegisterNUICallback('dissolve_alliance', function(data)
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
	
	if exports['dialog']:Decision('Dissolve/Cancel Alliance', 'Do you want to dissolve/cancel allience with the '..data.label..'?', '', 'YES', 'NO').action == 'submit' then
		TriggerServerEvent('esx_mMafia:dissolveAlliance', data.jobname)
	end
end)

RegisterNUICallback('accept_alliance', function(data)
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
	
	if exports['dialog']:Decision('Accept Alliance', 'Do you want to be allies with '..data.label..'?', '', 'YES', 'NO').action == 'submit' then
		TriggerServerEvent('esx_mMafia:acceptAlliance', data.jobname)
	end
end)

RegisterNUICallback('request_war', function(data)
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
	
	if exports['dialog']:Decision('Request War', 'Send war request to '..data.label..'?', '', 'YES', 'NO').action == 'submit' then
		TriggerServerEvent('esx_mMafia:requestWar', data.jobname)
	end
end)

RegisterNUICallback('stop_war', function(data)
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
	
	if exports['dialog']:Decision('Stop/Cancel War', 'Do you want to stop/cancel war with the '..data.label..'?', '', 'YES', 'NO').action == 'submit' then
		TriggerServerEvent('esx_mMafia:stopWar', data.jobname)
	end
end)

RegisterNUICallback('accept_war', function(data)
	SetNuiFocus(false, false)
	hasMenuOpen = false
	
	jobCache = nil
	employeesCache = nil
	
	if exports['dialog']:Decision('Accept War', 'Do you want to be in war with '..data.label..'?', '', 'YES', 'NO').action == 'submit' then
		TriggerServerEvent('esx_mMafia:acceptWar', data.jobname)
	end
end)

RegisterNUICallback('change_view', function(data)
	if data.action == 'online' then
		local tempEmployees = {}
		
		for k,v in pairs(employeesCache) do
			if v.isConnected then
				table.insert(tempEmployees, v)
			end
		end
		
		SendNUIMessage({action = 'manage_employees', employees = tempEmployees, isRewarding = data.isRewarding})
	elseif data.action == 'offline' then
		local tempEmployees = {}
		
		for k,v in pairs(employeesCache) do
			if not v.isConnected then
				table.insert(tempEmployees, v)
			end
		end
		
		SendNUIMessage({action = 'manage_employees', employees = tempEmployees, isRewarding = data.isRewarding})
	elseif data.action == 'everybody' then
		SendNUIMessage({action = 'manage_employees', employees = employeesCache, isRewarding = data.isRewarding})
	end
end)

RegisterNUICallback('search', function(data)
	local tempEmployees = {}
	local searchStr = data.searchStr:lower()
	
	for k,v in pairs(employeesCache) do
		if string.find(v.name:lower(), searchStr) then
			table.insert(tempEmployees, v)
		end
	end
	
	SendNUIMessage({action = 'manage_employees', employees = tempEmployees, isRewarding = data.isRewarding})
end)

RegisterNUICallback('mafia_logs', function(data)
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(2000))
	
	if not HasAccess('company-logs') then
		ESX.ShowNotification('You dont have access to use this option')
		Wait(100)
		SendNUIMessage({action = 'hide'})
		
		return
	end
	
	ESX.TriggerServerCallback('esx_society:getJobLogs', function(logs)
		logsCache = logs
		table.sort(logsCache, function(a,b) return a.timestamp > b.timestamp end)
		
		SendNUIMessage({action = 'mafia_logs', logs = logs})
	end, ESX.PlayerData.job.name)
end)

RegisterNUICallback('search_log', function(data)
	if data.shouldReset then
		SendNUIMessage({action = 'mafia_logs', logs = logsCache})
	else
		local tempLogs = {}
		local searchStr = data.searchStr:lower()
		
		for k,v in ipairs(logsCache) do
			if string.find(v.name:lower(), searchStr) then
				table.insert(tempLogs, v)
			end
		end
		
		SendNUIMessage({action = 'mafia_logs', logs = tempLogs})
	end
end)

RegisterNUICallback('search_mafias', function(data)
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(2000))
	
	local searchStr = data.searchStr:upper()
	
	ESX.TriggerServerCallback('esx_mMafia:searchMafias', function(mafias)
		SendNUIMessage({action = 'search_mafias', mafias = mafias, type = data.type})
	end, searchStr)
end)

RegisterNUICallback('mafia_privileges', function(data)
	ESX.TriggerServerCallback('esx_society:getJobPrivileges', function(privileges)
		if privileges then
			privilegesCache = SetupPrivileges(privileges)
			SendNUIMessage({action = 'mafia_privileges', privileges = privilegesCache, config = ConfigCL.Privileges})
		else
			ESX.ShowNotification('Only the original boss can use this option')
			SendNUIMessage({action = 'hide'})
		end
	end, ESX.PlayerData.job.name)
end)

RegisterNUICallback('save_privileges', function(data)
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(2000))
	
	ESX.TriggerServerCallback('esx_society:setJobPrivileges', function(privileges)
		if privileges then
			privilegesCache = SetupPrivileges(privileges)
			SendNUIMessage({action = 'mafia_privileges', privileges = privilegesCache, config = ConfigCL.Privileges})
		end
	end, ESX.PlayerData.job.name, tostring(data.grade), data.privileges)
end)

RegisterNUICallback('reset_privileges', function(data)
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(2000))
	
	ESX.TriggerServerCallback('esx_society:resetJobPrivileges', function(privileges)
		if privileges then
			privilegesCache = SetupPrivileges(privileges)
			SendNUIMessage({action = 'mafia_privileges', privileges = privilegesCache, config = ConfigCL.Privileges})
		end
	end, ESX.PlayerData.job.name, tostring(data.grade))
end)

RegisterNUICallback('event_times', function(data)
	SendNUIMessage({action = 'event_times', times = ConfigCL.Events})
end)

RegisterNUICallback('select_gps', function(coords)
	local coords = load('return '..coords)()
	SetNewWaypoint(coords.x, coords.y)
	
	SendNUIMessage({action = 'hide'})
end)

function SetupPrivileges(privileges)
	local temp = {}
	
	for _, gradeData in pairs(jobCache.grades) do
		local grade = tostring(gradeData.grade)
		
		if privileges[grade] == nil then
			privileges[grade] = {}
		end
		
		for k,v in ipairs(ConfigCL.Privileges) do
			if privileges[grade][v.name] == nil then
				privileges[grade][k] = false
			else
				privileges[grade][k] = privileges[grade][v.name]
			end
			
			privileges[grade][v.name] = nil
		end
		
		table.insert(temp, {grade = gradeData.grade, data = privileges[grade]})
	end
	
	table.sort(temp, function(a,b) return a.grade > b.grade end)
	
	return temp
end

function EditGradeFromCache(identifier, grade)
	for k,v in ipairs(employeesCache) do
		if v.identifier == identifier then
			local gradeData = jobCache.grades[grade + 1]
			
			employeesCache[k].job.grade = grade
			employeesCache[k].job.grade_name = gradeData.name
			employeesCache[k].job.grade_label = gradeData.label
			
			break
		end
	end
end

function GetGradeFromCache(identifier)
	for k,v in ipairs(employeesCache) do
		if v.identifier == identifier then
			return v.job.grade
		end
	end
	
	return nil
end

function RemoveIdentifierFromCache(identifier)
	for k,v in ipairs(employeesCache) do
		if v.identifier == identifier then
			table.remove(employeesCache, k)
			break
		end
	end
end

function SetCooldown(ms)
	cooldown = GetGameTimer() + ms
end

function IsOnCooldown()
	return cooldown > GetGameTimer()
end

function HasAccess(option)
	local hasAccess
	
	ESX.TriggerServerCallback('esx_society:hasAccess', function(result) hasAccess = result end, option)
	while hasAccess == nil do Wait(0) end
	
	return hasAccess
end

function getAbility(name)
	if validAbilities[name] then
		return (abilities[name] or math.floor(0))
	end
	
	return nil
end

function CreateFakeMpGamerTagFunc(targetPed, tag)
	local gamerTag = CreateFakeMpGamerTag(targetPed, tag, math.floor(0), math.floor(0), '', math.floor(0))
	SetMpGamerTagsVisibleDistance(ConfigCL.DistanceToDrawTags)
	SetMpGamerTagAlpha(gamerTag, math.floor(2), math.floor(255))
	SetMpGamerTagHealthBarColor(gamerTag, math.floor(18))
	SetMpGamerTagColour(gamerTag, math.floor(0), math.floor(9))
	
	return gamerTag
end

function IsAlly(job)
	for k,v in pairs(alliances) do
		if k == job then
			return true
		end
	end
	
	return false
end

function IsEnemy(job)
	for k,v in pairs(wars) do
		if k == job then
			return true
		end
	end
	
	return false
end

function GetAllies()
	return alliances
end

function GetEnemies()
	return wars
end

exports('IsDisplayMembersActive', function()
	return displayFriends
end)