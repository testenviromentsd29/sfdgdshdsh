ESX = nil

local toDraw = {}
local jobStatus = {}
local hideStatus = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
	
    Wait(4000)
	
    ESX.TriggerServerCallback('customStatusJob:getData', function(status, hidden)
        jobStatus = status
		hideStatus = hidden
		
        for k,v in pairs(jobStatus) do
            SendNUIMessage({
                action = 'decode',
                job = k,
                text = v.text
            })
        end
		
		Wait(1000)
		
		StartDrawing()
    end)
end)

RegisterNetEvent('customStatusJob:updateJobStatus', function(job, status)
    jobStatus[job] = status
	
    if status then
        SendNUIMessage({
            action = 'decode',
            job = job,
            text = status.text
        })
    end
end)

RegisterNetEvent('customStatusJob:updateHiddenStatus', function(sid, state)
    hideStatus[sid] = state
	
	if toDraw[sid] and state == nil then
		toDraw[sid] = nil
	end
end)

RegisterNetEvent('customStatusJob:editjobStatus', function(job, status)
    local elements = {
        {label = 'Text: '..status.text, value = 'text'},
        {label = 'Font: '..status.font, value = 'font'},
        {label = '<font color="green">Submit</font>', value = 'submit'},
    }
	
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'edit_status', {
        title    = 'Edit Job Status',
        align    = 'bottom-right',
        elements = elements,
    },function(data, menu)
        local value = data.current.value
        
		if value == 'submit' then
            SendNUIMessage({
                action = 'encode',
                job = job,
                status = status,
            })

            menu.close()
        else
            local newStatus = exports['dialog']:Create('Enter '..value..'!', 'Enter '..value..'!').value
            status[value] = newStatus

            if value == 'text' then
                menu.setElement(1, 'label', 'Text: '..status[value])
            else
                menu.setElement(2, 'label', 'Font: '..status[value])
            end
			
            menu.refresh()
        end
    end,function(data, menu)
        menu.close()
    end)
end)

function StartDrawing()
	Citizen.CreateThread(function()
		Citizen.CreateThread(function()
			while true do
				local playerCoords = GetEntityCoords(PlayerPedId())
				
				for _, target in pairs(GetActivePlayers()) do
					local sid = GetPlayerServerId(target)
					
					if sid > 0 then
						local job = ESX.GetPlayerJob(sid)
						
						if job and jobStatus[job.name] and not hideStatus[sid] then
							local targetPed = GetPlayerPed(target)
							local targetCoords = GetEntityCoords(targetPed)
							
							if #(playerCoords - targetCoords) < 30.0 and IsEntityVisible(targetPed) then
								toDraw[sid] = {targetPed = targetPed, text = jobStatus[job.name].text, font = jobStatus[job.name].font}
							end
						end
					end
					
					Wait(0)
				end
				
				for sid,v in pairs(toDraw) do
					local target = GetPlayerFromServerId(sid)
					
					if target ~= -1 then
						local job = ESX.GetPlayerJob(sid)
						
						if job and jobStatus[job.name] and not hideStatus[sid] then
							if DoesEntityExist(v.targetPed) then
								if not IsEntityVisible(v.targetPed) then
									toDraw[sid] = nil
								end
							else
								toDraw[sid] = nil
							end
						else
							toDraw[sid] = nil
						end
					else
						toDraw[sid] = nil
					end
					
					Wait(0)
				end
				
				Wait(1000)
			end
		end)
		
		while true do
			for k,v in pairs(toDraw) do
				local coords = GetEntityCoords(v.targetPed)
				ESX.Game.Utils.DrawText3D(vector3(coords.x, coords.y, coords.z + 1.2), v.text, 1.2, v.font)
			end
			
			Wait(0)
		end
	end)
end

RegisterNUICallback('decode', function(data)
    local job = data.job
    local text = data.text
	
    jobStatus[job].text = text
end)

RegisterNUICallback('encode', function(data)
    local job = data.job
    local status = data.status
	
    TriggerServerEvent('customStatusJob:savejobStatus', job, status)
end)