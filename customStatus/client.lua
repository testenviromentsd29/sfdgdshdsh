ESX = nil

local playerStatus = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	Wait(5000)

	ESX.TriggerServerCallback('customStatus:getOnlinePlayerStatus', function(status)
		playerStatus = status

		for k,v in pairs(playerStatus) do
			SendNUIMessage({
				action = 'decode',
				sid = k,
				text = v.text
			})
		end
	end)
end)

RegisterNetEvent('customStatus:updateOnlinePlayerStatus', function(sid, status)
	playerStatus[tostring(sid)] = status

	if status then
		SendNUIMessage({
			action = 'decode',
			sid = tostring(sid),
			text = status.text
		})
	end
end)

RegisterNetEvent('customStatus:editPlayerStatus', function(identifier, status)
	local elements = {
		{label = 'Text: '..status.text, value = 'text'},
		{label = 'Font: '..status.font, value = 'font'},
		{label = '<font color="green">Submit</font>', value = 'submit'},
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'edit_status', {
		title    = 'Edit Player Status',
		align    = 'bottom-right',
		elements = elements,
	},function(data, menu)
		local value = data.current.value
		if value == 'submit' then
			SendNUIMessage({
				action = 'encode',
				identifier = identifier,
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

Citizen.CreateThread(function()
	while true do
        local wait = 1000
		local playerCoords = GetEntityCoords(PlayerPedId())
		
		for _, target in pairs(GetActivePlayers()) do
			local sid = tostring(GetPlayerServerId(target))

			if playerStatus[sid] and playerStatus[sid].show == 1 then
				local targetPed = GetPlayerPed(target)
				local targetCoords = GetEntityCoords(targetPed)

				if #(playerCoords - targetCoords) < 30.0 and IsEntityVisible(targetPed) then
					wait = 0
					ESX.Game.Utils.DrawText3D(vector3(targetCoords.x, targetCoords.y, targetCoords.z + 1.5), playerStatus[sid].text, 1.2, playerStatus[sid].font)
				end
			end
		end

        Wait(wait)
    end
end)

RegisterNUICallback('decode', function(data)
	local sid = data.sid
	local text = data.text

	playerStatus[tostring(sid)].text = text
end)

RegisterNUICallback('encode', function(data)
	local identifier = data.identifier
	local status = data.status

	TriggerServerEvent('customStatus:savePlayerStatus', identifier, status)
end)