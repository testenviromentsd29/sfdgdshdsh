ESX = nil

local currentJob = ''
local showBlipsStatus = false
local armyBlips = {}
local Jobblips = {}
local oldArmyData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Wait(0)
	end

	currentJob = ESX.GetPlayerData().job.name

	if currentJob == 'army' then 
		showBlipsStatus = true
		showBlips()
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if currentJob ~= 'army' and job.name == 'army' then 
		showBlipsStatus = true
		showBlips()
	elseif currentJob == 'army' and job.name ~= 'army' then 
		showBlipsStatus = false
		removeJobBlips()
	end

	currentJob = job.name
end)

RegisterNetEvent('army:sendArmyData')
AddEventHandler('army:sendArmyData', function(armyData)
	if currentJob == 'army' then
		if showBlipsStatus then
			for server_id,v in pairs(oldArmyData) do
				if armyData[server_id] == nil and DoesBlipExist(armyBlips[server_id]) then
					RemoveBlip(armyBlips[server_id])
				end
			end
			
			for server_id,v in pairs(armyData) do
				local player = GetPlayerFromServerId(server_id)
				
				if player == -1 then
					if DoesBlipExist(armyBlips[server_id]) then
						SetBlipCoords(armyBlips[server_id], v.coords.x, v.coords.y, v.coords.z)
						SetBlipSprite(armyBlips[server_id], (v.inVehicle and 225 or 1))
						SetBlipColour(armyBlips[server_id], 3)
						BeginTextCommandSetBlipName('STRING')
						AddTextComponentString(v.name)
						EndTextCommandSetBlipName(armyBlips[server_id])
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
						
						armyBlips[server_id] = blip
					end
				else
					if DoesBlipExist(armyBlips[server_id]) then
						RemoveBlip(armyBlips[server_id])
					end
				end
			end
			
			oldArmyData = armyData
		end
	end
end)

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
						
						if targetjob and targetjob.name == 'army' then
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

function removeJobBlips()
    for k,v in pairs(Jobblips) do
        RemoveBlip(v)
    end
	
	for k,v in pairs(armyBlips) do
		if DoesBlipExist(v) then
			RemoveBlip(v)
		end
	end
	
	armyBlips = {}
	oldArmyData = {}
end