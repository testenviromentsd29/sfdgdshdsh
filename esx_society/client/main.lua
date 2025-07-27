ESX = nil

local base64MoneyIcon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFoAAABaCAMAAAAPdrEwAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAAMAUExURQAAACmvPCmwPCuwPiywPi2wPy6xQC6xQS+yQTCxQTCyQTCyQjGyQzKyRDOzRTSzRTSzRjW0RjW0Rza0SDe0STi0STm1Sjq1Szq2Szu2TDy2TDy2TT22Tj63Tz+3UEC4UEG4UUG4UkK4U0O5VES5VEW6VUa6Vke6V0i7WEm7WUu8Wku8W0y8W028XE29XU++XlC9X1C+X1G+YFK+YVO/YlW/ZFXAZFfAZVfAZljBZlnBZ1rBaVvCaVvCalzDal7CbF/DbV/EbWHEbmLEb2LEcGTFcWfGdGjHdWrHd2vId2vIeGzIeW3JenHKfXLKfnPLf3TLgHXLgXXMgHXMgXbMgnjNg3nMhHrNhnrOhnzOiH7PiYLQjYPRjoTRjoTRj4XRkIXSkIfSkojSk4rUlYzUlo7VmJDWmpHWm5LXnJTXnZTXnpXYnpbYn5nZopzapJ3bpZ7bpp7bp6DcqKLcqqPcq6Tcq6TdrKberqjfr6jfsKnfsavgs6zgs6zgtK7hta/htrDit7LiuLLiubPjurTjurXju7bkvLbkvbnlv7rlwLrmwLzmwr3nw77nxMDnxcLox8PpyMTpycXpysXqysbqy8fqzMnrzcrrz8vsz8vs0Mzs0c3t0tHu1dHu1tPv19Tv2NXv2dXw2dbw2tfw29jw3Nnx3drx3t7z4d/z4uD04+H05OP15eP15uT15uT15+X16OX26Of26en36+r37Ov37er47Ov47ez47e347u347+758PD58fD68fD68vL69PT79fX79vb79/b89vb89/f8+Pj9+fn9+vr9+/v++/v+/Pz+/P3+/f3+/v7//wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALfZHJgAAAEAdFJOU////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////wBT9wclAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAAGHRFWHRTb2Z0d2FyZQBwYWludC5uZXQgNC4xLjb9TgnoAAAGdUlEQVRoQ7WZ93sURRiAFZO76O1eklt215OgBwqJgmgCRhAhRrAAiogBK4gBJEFEgWAEYiGIYEGp1kjXQECkiF0OWyjJ/k34zcy3db7Zu8fHe3/KTXnzPbPT56orRTEYAhMLUFgNKkeiGH8BNaV1KWSPVXveU9s3LW9pvhdoblm+afspTHZi5Wo1BnzpaOfcnFmWSBv29YBtpBNlZm5u59FLPDsmdJUaxQeXNugZw5IwMnrD0oO8iFKuUHNx/+bGZLWNMgm7Otm4uZ/LsVIEUs3F+Y5a3USNAlOv7cgr5ZSamQffyOnKgH1sPdfFi2PVILKaReEcmKwVIWbY2uQDvApW95HULIb+Ng0rFoXWxppcCjyqZuZjk4oNWWBrk44R7oiamXdkC3w9GTO7Q3aH1cy8OkWFnHtitstM4j/bqdWSO6Rm5nYdS4e5FbKQwxlMC6G3Q1bIHVQz8+IKLBphJLdydlRjWpiKxZAXdAfUPOak4gOO4FZOdxWmhbGTkbh9NTOvoVsDuGmAaxkdlZgWRV8Dub7bV0PyzhQWkqk5z7WMdjpqILUTslEXUEPQJ7Lq7pz9WXiBZ4iZUGBnTwTCdtVgvjgxpj+b3vTvTEteq5KbEy/6blcNVZapR3cmdc9Z4QV6Pnxzdr1GF9aWQQFUohqCPqQc3ZV17X3C6tP31kyL+Jy2dsgLW6jBPDgVc6OkR3XxCV/i9IqRRFedylxc6qk30L3DNF7ikz1Jft0oLOaT2hBSg/l8jmwOo24/amimYzkfOwfdlLtdNT1YjIaf0EFzgGhuNnB8teNcqCWDvs3vzSSLqC9Ze0F0EqaGoDeSQWt7UaHgXA0WDKFvFGEzNRS6mxot6VZhUNJNdm7zbsgSagj6UAKTQ5hnhEHJffRISIi+LdRLyNn9cTSoOExP3FZmiat2nIF66t9Xb0GFz8Df+AenVTEF2vUwAzM1BN1LfsTkcVS4bJs+fnRj84z3joqf+eFYUELvZWFzdSfZHjeeEwqXl6/myWaZ0bSVDf3uJP9NkOn01HPISXIMTJAB/hiB6WBPN+xxBpvxl4wxR6ihll8pSL1QupwLLhR22YL9ysVGrKRcfZJeAu4QSo+1yWA3rla2NGCeZGpoj13lmBJm1F/odDm+fv68phorU0l+miDlu6BFmLqbHDCWdhqVQQb/zPesW1inqxdoRqIb1SvSmBJG+wR1BF+/NkmLWUnTK1DdQq+i5gvoIbn85QPqtdRoQfU0TIgy4h/UKOi+gZ5DgGmonqIoob2CDhXHblE0ij2lgNo2YMcSy7fkhF2E2rIm/IoOFV/Q+78i1JkJheJ+jOzjnlr1GRk18swa4iC9t3U/o6LzCVLTP4dlVM14LBfC63yKIYOYeuMqcRoneZFqEW/IKAY6Q8xumla3YP2+PNnNt1Jqb6Arpifg5kXuHjNTaVi1s5/eJs0r+6gFUkxP6kkV2mKBs8UMZSYMdmAJcpxqTTGpqpcCEO1znCMTwlPFNbuF0uUs1UVwKYAWoRcwGDHsbNS/algwu+J1bvToI9TuAgZqetm1roPVk/FDazbhjaryr0SiSw/R1oFll94sWNnfsLrzS1eTkawyjKrE6HcwyeVtIix3s6Dc4ljzsTbnx74P1na83+uf8ZBn5cb0tjgsbHJjlvoMa8dxWT4XBDZmoCa3k7eH9yE0u4l9jr+dZN2P2ASnVorK8TwoVwxsglnYxNY9852oHMseogMEt+4QtnzgGDoTa8eRH4ulA4QOHCxs6ZhUBdNAIS7NIjp1+JgEaulwZzwsnXCjDDxPzB+Rwx1zS0fSoVZb/Mp4/lFqQxk5kjI1cZDWa179HTUEe8eRW9XoQZq5qeN/5fCFigWmd14VNRXLx3/et8lLC7N8XNtH0VP6mXfvV+z4iEsLFrbqqkXXho2Z8dynwgo8NdZK0SXpqxbmjrsgquhCsXrhgOYgL4h4k8Rca5VvFV7gTkySUVxrsbBjLuOGfMy1jCZFa6gv47hbeYU4ZA/XMmbRy13MFaJwqy4+Ez1cy3iSVsddfGLcdJvo33Ato5VcSeOva4WbvmQ2v+daxkrqfqXQJbNwk1fj9kOPuNwlZxdxNS7c5IW+MdRFMhd3oS/cpXmG4EOnRI8nAAt8sKsETz4AK1yahyqAy0vxvAaU7lEQcJ8yj9BPmUf+81MmR8iB//kBllOyZ2NOqR67XUAVABNjuXLlX2rCcoFjOcGoAAAAAElFTkSuQmCC'

local jobCache
local employeesCache
local logsCache
local privilegesCache

local cooldown = 0
local lastTimeMenuOpened = 0

local hasMenuOpen = false
local displayingWorkers = false

local meetingBlip = nil

local abilities = {}
local validAbilities = {}

for k,v in pairs(Config.Abilities) do
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

	RefreshBussHUD()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	RefreshBussHUD()
	
	if hasMenuOpen then
		Wait(100)
		SendNUIMessage({action = 'hide'})
	end
end)

RegisterNetEvent('esx_society:sendAbilities')
AddEventHandler('esx_society:sendAbilities', function(data)
	abilities = data or {}
end)

RegisterNetEvent('esx_society:setMeeting')
AddEventHandler('esx_society:setMeeting', function(caller, job, coords)
	if ESX.PlayerData.job.name == job then
		if DoesBlipExist(meetingBlip) then
			RemoveBlip(meetingBlip)
		end
		
		meetingBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
		SetBlipSprite(meetingBlip, math.floor(491))
		SetBlipColour(meetingBlip, math.floor(3))
		SetBlipRoute(meetingBlip, true)
		SetBlipRouteColour(meetingBlip, math.floor(3))
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Company Meeting')
		EndTextCommandSetBlipName(meetingBlip)
		
		ESX.ShowNotification('Check your GPS for the meeting point')
		
		Citizen.CreateThread(function()
			while DoesBlipExist(meetingBlip) and #(GetEntityCoords(PlayerPedId()) - coords) > 5.0 do
				Wait(100)
			end
			
			if DoesBlipExist(meetingBlip) then
				SetBlipRoute(meetingBlip, false)
			end
		end)
	end
end)

RegisterNetEvent('esx_society:endMeeting')
AddEventHandler('esx_society:endMeeting', function(job)
	if ESX.PlayerData.job.name == job then
		if DoesBlipExist(meetingBlip) then
			RemoveBlip(meetingBlip)
		end
		
		ESX.ShowNotification('Meeting has ended')
	end
end)

RegisterCommand('society', function(source, args)
	if lastTimeMenuOpened < GetGameTimer() then
		lastTimeMenuOpened = GetGameTimer() + math.floor(1000)
		
		ESX.TriggerServerCallback('esx_mMafia:isCriminal', function(isCriminal)
			if not isCriminal then
				hasMenuOpen = true
				
				ESX.TriggerServerCallback('esx_society:getJob', function(job)
					jobCache = job
					jobCache.epr = Config.ExperiencePerRank
					jobCache.apr = Config.AbilityPerRank
					jobCache.ppa = Config.PercentPerAbility
					
					SetNuiFocus(true, true)
					SendNUIMessage({action = 'show', job = jobCache})
				end, ESX.PlayerData.job.name)
			else
				TriggerEvent('esx_mMafia:openSocietyMenu')
			end
		end)
	else
		ESX.ShowNotification('Dont spam')
	end
end)

AddEventHandler('justreleased', function(label, key)
	if key == math.floor(56) and not hasMenuOpen then
		ExecuteCommand('society')
	end
end)

local myjobsCd = 0

RegisterCommand('myjobs', function(source, args)
	if myjobsCd < GetGameTimer() then
		myjobsCd = GetGameTimer() + 2000
		
		ESX.TriggerServerCallback('esx_society:getMyJobs', function(jobData)
			if jobData then
				if #jobData > math.floor(0) then
					SetNuiFocus(true, true)
					SendNUIMessage({action = 'myjobs', jobs = jobData})
				else
					ESX.ShowNotification('Not enough jobs')
				end
			else
				ESX.ShowNotification('Not enough jobs')
			end
		end)
	else
		ESX.ShowNotification('Dont spam')
	end
end)

local lastCall
RegisterNUICallback('change_job', function(job)
	SetNuiFocus(false, false)
	if lastCall == nil or GetGameTimer()/1000 - lastCall > 30 then
		lastCall = GetGameTimer()/1000
		local elements = {
			{label = 'Πρώτο Job', value = 1},
			{label = 'Δεύτερο Job', value = 2}
		}
		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'changng', {
			title    = 'Το θες ως πρώτο ή δεύτερο job?',
			align    = 'center',
			elements = elements,
		},function(data, menu)
			TriggerServerEvent('esx:changeJob', job, tonumber(data.current.value))
			menu.close()
		end,function(data, menu)
			menu.close()
		end)
	else
		ESX.ShowNotification("You need to wait 30 seconds to do this")
	end
end)

RegisterNUICallback('gps_location', function(job)
	SetNuiFocus(false, false)
	
	local coords = exports['teleport']:isExist(job)
	if coords then
		SetNewWaypoint(coords.x, coords.y)
	else
		ESX.ShowNotification('Cannot find coordinates')
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
	
	ESX.TriggerServerCallback('esx_society:rankUp', function(rank, experience)
		if rank > jobCache.rank then
			jobCache.rank = rank
			jobCache.experience = experience
			
			SendNUIMessage({action = 'show', job = jobCache})
			
			ESX.ShowNotification('Company ranked up!')
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
	
	if not DoesBlipExist(meetingBlip) then
		TriggerServerEvent('esx_society:setMeeting', GetEntityCoords(PlayerPedId()))
	else
		TriggerServerEvent('esx_society:endMeeting')
	end
end)

RegisterNUICallback('display_workers', function(data)
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
		return
	end
	
	if not displayingWorkers then
		displayingWorkers = true
		
		Citizen.CreateThread(function()
			local blips = {}
			
			while displayingWorkers do
				for _, target in pairs(GetActivePlayers()) do
					if target ~= PlayerId() and target ~= math.floor(-1) then
						local sid = GetPlayerServerId(target)
						
						if ESX.PlayerData.job.name == ESX.GetPlayerJob(sid).name and blips[sid] == nil then
							blips[sid] = AddBlipForEntity(GetPlayerPed(target))
							SetBlipSprite(blips[sid], math.floor(480))
							SetBlipColour(blips[sid], math.floor(2))
							SetBlipScale(blips[sid], 0.7)
							BeginTextCommandSetBlipName('STRING')
							AddTextComponentString('Company Worker')
							EndTextCommandSetBlipName(blips[sid])
						end
					end
					
					Wait(100)
				end
				
				for sid,v in pairs(blips) do
					local target = GetPlayerFromServerId(sid)
					
					if target == math.floor(-1) then
						if DoesBlipExist(v) then 
							RemoveBlip(v)
						end
						
						blips[sid] = nil
					end
					
					Wait(100)
				end
				
				Wait(0)
			end
			
			for k,v in pairs(blips) do
				if DoesBlipExist(v) then
					RemoveBlip(v)
				end
			end
		end)
	else
		displayingWorkers = false
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

RegisterNUICallback('police_abilities', function()
	if HasAccess('abilities') then
		SetCooldown(math.floor(500))
		SendNUIMessage({action = 'abilities', abilities = abilities, config = Config.Abilities})
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
	
	if exports['dialog']:Decision('Increase Rank', 'Buy 1 rank for '..Config.IncreaseRankCost..' DC', '', 'YES', 'NO').action == 'submit' then
		TriggerServerEvent('esx_society:buyRank', ESX.PlayerData.job.name)
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
	
	if exports['dialog']:Decision('Reset Abilities', 'Reset abilities for '..Config.ResetAbilitiesCost..' DC', '', 'YES', 'NO').action == 'submit' then
		TriggerServerEvent('esx_society:resetAbilities', ESX.PlayerData.job.name)
	end
end)

RegisterNUICallback('upgrade_ability', function(name)
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(math.floor(2000))
	
	if HasAccess('abilities') then
		ESX.TriggerServerCallback('esx_society:upgradeAbility', function(abilities)
			if abilities then
				SendNUIMessage({action = 'abilities', abilities = abilities, config = Config.Abilities})
			end
		end, ESX.PlayerData.job.name, name)
	else
		ESX.ShowNotification('You dont have access to use this option')
		Wait(100)
		SendNUIMessage({action = 'hide'})
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
		local data = exports['dialog']:Create('Deposit Money', 'Enter amount to deposit')
		local amount = tonumber(data.value)
		
		if amount and amount > 0 then
			TriggerServerEvent('esx_society:depositMoney', ESX.PlayerData.job.name, amount)
		else
			ESX.ShowNotification('Invalid amount')
		end
	else
		ESX.ShowNotification('You dont have access to use this option')
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
		local data = exports['dialog']:Create('Withdraw Money', 'Enter amount to withdraw')
		local amount = tonumber(data.value)
		
		if amount and amount > 0 then
			TriggerServerEvent('esx_society:withdrawMoney', ESX.PlayerData.job.name, amount)
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
				
				table.insert(data, {
					name		= GetPlayerName(players[i]),
					player		= GetPlayerServerId(players[i]),
					mugshot		= GetPedheadshotTxdString(mugshot),
					mugshotId	= mugshot
				})
			end
		end
		
		local playerIds = {}
		
		for i=1, #data do
			table.insert(playerIds, {player = data[i].player, level = 0})
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
		ESX.ShowNotification('There are too many players near you')
	end
end)

RegisterCommand('invitejob', function(source, args)
	local target = tonumber(args[1]) or -1

	if target > 0 then
		TriggerServerEvent('esx_society:inviteToJob', ESX.PlayerData.job.name, tonumber(target))
	end
end)

RegisterNUICallback('invite', function(target)
	if IsOnCooldown() then
		return
	end
	
	SetCooldown(1000)
	TriggerServerEvent('esx_society:inviteToJob', ESX.PlayerData.job.name, tonumber(target))
end)

RegisterNetEvent('esx_society:inviteTarget')
AddEventHandler('esx_society:inviteTarget', function(jobLabel)
	local data = exports['dialog']:Decision('Invite', 'You have been invited to join '..jobLabel)
	local answer = tonumber(data.value)
	
	if answer and answer == math.floor(1) then
		TriggerServerEvent('esx_society:acceptInvite')
	else
		ESX.ShowNotification('You declined the invite')
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
		local data = exports['dialog']:Create('Money Reward', 'Enter amount to give [1000-1000000]')
		local amount = tonumber(data.value)
		
		if amount and amount >= 1000 and amount <= 1000000 then
			TriggerServerEvent('esx_society:giveReward', ESX.PlayerData.job.name, identifier, amount)
		else
			ESX.ShowNotification('Amount must be [1000-1000000]')
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
		local data = exports['dialog']:Create('Money Reward', 'Enter amount to give [1000-1000000]</br>The final amount will be: amount*online workers')
		local amount = tonumber(data.value)
		
		if amount and amount >= 1000 and amount <= 1000000 then
			TriggerServerEvent('esx_society:giveMassReward', ESX.PlayerData.job.name, amount)
		else
			ESX.ShowNotification('Amount must be [1000-1000000]')
		end
	else
		ESX.ShowNotification('You dont have access to use this option')
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

RegisterNUICallback('company_logs', function(data)
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
		if logs then
			logsCache = logs
			table.sort(logsCache, function(a,b) return a.timestamp > b.timestamp end)
			
			SendNUIMessage({action = 'company_logs', logs = logs})
		else
			ESX.ShowNotification('You dont have access to use this option')
		end
	end, ESX.PlayerData.job.name)
end)

RegisterNUICallback('search_log', function(data)
	if data.shouldReset then
		SendNUIMessage({action = 'company_logs', logs = logsCache})
	else
		local tempLogs = {}
		local searchStr = data.searchStr:lower()
		
		for k,v in ipairs(logsCache) do
			if string.find(v.name:lower(), searchStr) then
				table.insert(tempLogs, v)
			end
		end
		
		SendNUIMessage({action = 'company_logs', logs = tempLogs})
	end
end)

RegisterNUICallback('company_privileges', function(data)
	ESX.TriggerServerCallback('esx_society:getJobPrivileges', function(privileges)
		if privileges then
			privilegesCache = SetupPrivileges(privileges)
			SendNUIMessage({action = 'company_privileges', privileges = privilegesCache, config = Config.Privileges})
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
			SendNUIMessage({action = 'company_privileges', privileges = privilegesCache, config = Config.Privileges})
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
			SendNUIMessage({action = 'company_privileges', privileges = privilegesCache, config = Config.Privileges})
		end
	end, ESX.PlayerData.job.name, tostring(data.grade))
end)

function SetupPrivileges(privileges)
	local temp = {}
	
	for _, gradeData in pairs(jobCache.grades) do
		local grade = tostring(gradeData.grade)
		
		if privileges[grade] == nil then
			privileges[grade] = {}
		end
		
		for k,v in ipairs(Config.Privileges) do
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

function RefreshBussHUD()
	DisableSocietyMoneyHUDElement()

	if ESX.PlayerData.job.grade_name == 'boss' then
		EnableSocietyMoneyHUDElement()

		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			UpdateSocietyMoneyHUDElement(money)
		end, ESX.PlayerData.job.name)
	end
end

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)
	if ESX and ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job.name == society then
		UpdateSocietyMoneyHUDElement(money)
	end
end)

function EnableSocietyMoneyHUDElement()
	local societyMoneyHUDElementTpl = '<div><img src="' .. base64MoneyIcon .. '" style="width:20px; height:20px; vertical-align:middle;">&nbsp;{{money}}</div>'

	if ESX.GetConfig().EnableHud then
		ESX.UI.HUD.RegisterElement('society_money', math.floor(3), math.floor(0), societyMoneyHUDElementTpl, {
			money = math.floor(0)
		})
	end

	TriggerEvent('esx_society:toggleSocietyHud', true)
end

function DisableSocietyMoneyHUDElement()
	if ESX.GetConfig().EnableHud then
		ESX.UI.HUD.RemoveElement('society_money')
	end

	TriggerEvent('esx_society:toggleSocietyHud', false)
end

function UpdateSocietyMoneyHUDElement(money)
	if ESX.GetConfig().EnableHud then
		ESX.UI.HUD.UpdateElement('society_money', {
			money = ESX.Math.GroupDigits(money)
		})
	end

	TriggerEvent('esx_society:setSocietyMoney', money)
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