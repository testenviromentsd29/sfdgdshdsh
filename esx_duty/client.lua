ESX = nil

local jobs = {}
local currentJob = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end
	
	ESX.PlayerData = ESX.GetPlayerData()
	
	InitDuty()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	
	InitDuty()
end)

function InitDuty()
	currentJob = nil
	Wait(3000)
	currentJob = ESX.PlayerData.job.name
	jobs = {}
	
	for k, v in pairs(Config.Zones) do
		for i, j in pairs(v.Jobs) do
			if string.find(i, currentJob) then
				table.insert(jobs, v)
			end
		end
	end
	
	CreateLogic()
end

function CreateLogic()
	Citizen.CreateThread(function()
		while currentJob ~= nil do
			Wait(0)
			
			local sleep = true
			local coords = GetEntityCoords(PlayerPedId())
			
			for k, v in pairs(jobs) do
				if #(coords - v.Pos) < Config.DrawDistance then
					sleep = false
					DrawMarker(0, v.Pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 150, 0, 150, 100, false, false, 2, false, false, false, false)
					
					if #(coords - v.Pos) < 1.5 then
						ESX.ShowHelpNotification('Press [E] to change job')
						
						if IsControlJustReleased(0, 38) then
							local key
							
							for i, j in pairs(v.Jobs) do
								if i == ESX.PlayerData.job.name then
									key = GetKeyFromValue(j, ESX.PlayerData.job.grade)
									
									if key ~= nil then
										TriggerServerEvent('esx_duty:changeJob', jobs[k], key)
										
										break
									end
								end
							end
							
							Wait(1000)
						end
					end
				end
			end
			
			if sleep then
				Wait(1500)
			end
		end
	end)
end

function GetKeyFromValue(t, value)
	for k, v in pairs(t) do
		if v == value then
			return k
		end
	end
	
	if t[1] == -1 then
		return -1
	end
	
	return nil
end