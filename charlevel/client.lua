ESX = nil

local myLevel = 0
local playerLevels = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)

RegisterNetEvent('charlevel:playerLoaded')
AddEventHandler('charlevel:playerLoaded', function(tasks, level)
	myLevel = level
	
	ProcessShowLevels()
	
	for k,v in pairs(tasks) do
		if string.find(k, 'online_time') then
			Wait(1000)
			ProcessOnlineTime(k, Config.Tasks[k].need, v)
		elseif string.find(k, 'drive_veh') then
			Wait(1000)
			ProcessDriveVehicle(k, Config.Tasks[k].need, v)
		elseif string.find(k, 'stay_alive') then
			Wait(1000)
			ProcessStayAlive(k, Config.Tasks[k].need, v)
		end
	end
end)

RegisterNetEvent('charlevel:onTaskAdded')
AddEventHandler('charlevel:onTaskAdded', function(task, level)
	myLevel = level
	ESX.ShowNotification('New task added!</br>'..Config.Tasks[task].label)
	
	Wait(1000)
	
	if string.find(task, 'online_time') then
		ProcessOnlineTime(task, Config.Tasks[task].need, 0)
	elseif string.find(task, 'drive_veh') then
		ProcessDriveVehicle(task, Config.Tasks[task].need, 0)
	elseif string.find(task, 'stay_alive') then
		ProcessStayAlive(task, Config.Tasks[task].need, 0)
	end
end)

RegisterNetEvent('charlevel:sendPlayerLevels')
AddEventHandler('charlevel:sendPlayerLevels', function(data)
	playerLevels = data
end)

RegisterNetEvent('charlevel:updatePlayerLevel')
AddEventHandler('charlevel:updatePlayerLevel', function(sid, data)
	playerLevels[sid] = data
end)

RegisterNetEvent('charlevel:updateMyLevel')
AddEventHandler('charlevel:updateMyLevel', function(level)
	myLevel = level
end)

RegisterNetEvent('charlevel:show')
AddEventHandler('charlevel:show', function(data)
	SetNuiFocus(true, true)
	
	SendNUIMessage({
		action	= 'show',
		xp		= data.xp,
		level	= data.level,
		tasks	= SetupTasks(data.tasks),
		next_rw	= FindNextReward(data.level)
	})
end)

RegisterNUICallback('quit', function()
	SetNuiFocus(false, false)
end)

function ProcessOnlineTime(task, needed, done)
	TriggerServerEvent('charlevel:onlineTimeStart', task)
	
	local timestamp = GlobalState.date.timestamp + needed*60 - done*60
	
	Citizen.CreateThread(function()
		while timestamp > GlobalState.date.timestamp do
			Wait(1000)
		end
		
		Wait(1000)
		TriggerServerEvent('charlevel:onlineTimeEnd')
	end)
end

function ProcessDriveVehicle(task, needed, done)
	local timeleft = needed - done
	local drivingTimer = 0
	
	Citizen.CreateThread(function()
		while timeleft > 0 do
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			
			if DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
				if drivingTimer == 0 then
					drivingTimer = GetGameTimer()
					TriggerServerEvent('charlevel:driveVehicleStart', task)
					Wait(1000)
				else
					local minutes = math.floor((GetGameTimer() - drivingTimer)/60000)
					
					if minutes >= timeleft then
						TriggerServerEvent('charlevel:driveVehicleEnd')
						break
					end
				end
			else
				if drivingTimer ~= 0 then
					local minutes = math.floor((GetGameTimer() - drivingTimer)/60000)
					
					if minutes > 0 then
						timeleft = timeleft - minutes
					end
					
					TriggerServerEvent('charlevel:driveVehicleEnd')
					
					drivingTimer = 0
					Wait(1000)
				end
			end
			
			Wait(1000)
		end
	end)
end

function ProcessStayAlive(task, needed, done)
	local timeleft = needed - done
	local aliveTimer = 0
	
	Citizen.CreateThread(function()
		while timeleft > 0 do
			if not IsEntityDead(PlayerPedId()) then
				if aliveTimer == 0 then
					aliveTimer = GetGameTimer()
					TriggerServerEvent('charlevel:stayAliveStart', task)
					Wait(1000)
				else
					local minutes = math.floor((GetGameTimer() - aliveTimer)/60000)
					
					if minutes >= timeleft then
						TriggerServerEvent('charlevel:stayAliveEnd')
						break
					end
				end
			else
				if aliveTimer ~= 0 then
					local minutes = math.floor((GetGameTimer() - aliveTimer)/60000)
					
					if minutes > 0 then
						timeleft = timeleft - minutes
					end
					
					TriggerServerEvent('charlevel:stayAliveEnd')
					
					aliveTimer = 0
					Wait(1000)
				end
			end
			
			Wait(1000)
		end
	end)
end

function ProcessShowLevels()
	local drawTxt = {}
	local loopTimer = 0
	
	Citizen.CreateThread(function()
		while true do
			local wait = 1000
			local coords = GetEntityCoords(PlayerPedId())
			
			if loopTimer < GetGameTimer() then
				loopTimer = GetGameTimer() + 1500
				
				for _, target in pairs(GetActivePlayers()) do
					local sid = GetPlayerServerId(target)
					
					if playerLevels[sid] then
						local targetPed = GetPlayerPed(target)
						
						if IsEntityVisible(targetPed) and #(coords - GetEntityCoords(targetPed)) < 30.0 then
							drawTxt[sid] = {targetPed = targetPed, text = '🔥~r~Lev '..playerLevels[sid]}
						end
					end
				end
				
				for sid,v in pairs(drawTxt) do
					if playerLevels[sid] == nil or not DoesEntityExist(v.targetPed) then
						drawTxt[sid] = nil
					end
				end
			end
			
			for sid,v in pairs(drawTxt) do
				if IsEntityVisible(v.targetPed) then
					wait = 0
					local targetCoords = GetEntityCoords(v.targetPed)
					
					if #(coords - targetCoords) < 30.0 then
						ESX.Game.Utils.DrawText3D(vector3(targetCoords.x, targetCoords.y, targetCoords.z + 1.2), v.text, 1.0, 6)
					end
				end
			end
			
			Wait(wait)
		end
	end)
end

function SetupTasks(tasks)
	local temp = {}
	
	for k,v in pairs(tasks) do
		table.insert(temp, {
			label	= Config.Tasks[k].label,
			have	= v,
			need	= Config.Tasks[k].need,
			xp		= Config.Tasks[k].xp
		})
	end
	
	table.sort(temp, function(a,b) return a.label < b.label end)
	
	return temp
end

function FindNextReward(level)
	local lvl = nil
	local item = nil
	
	for k,v in pairs(Config.Rewards) do
		if level < k and k < (lvl or math.huge) then
			lvl = k
			item = v.item
		end
	end
	
	if lvl then
		return {level = lvl, item = item}
	end
	
	return nil
end

exports('GetMyLevel', function()
	return myLevel
end)

local debugMode = false

RegisterCommand('charlevel_debug', function(source, args)
	debugMode = not debugMode
	
	if debugMode then
		Citizen.CreateThread(function()
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
			
			while debugMode do
				local modifier = math.floor(myLevel/20)*0.05
				DrawText2(0.23, 0.40, 0.6, 'charlevel: '..modifier)
				
				Wait(0)
			end
		end)
	end
end)