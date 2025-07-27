ESX = nil

local playerStatus = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
    InitScript()
end)

RegisterCommand('anim_status_set', function(source, args)
	local text = exports['fDialog']:OpenDialog('Enter Animated Text', '')

	if text == nil then
		return
	end

	if string.len(text) == 0 or string.len(text) > 256 then
		TriggerEvent('esx:showNotification', 'Invalid text length [0-256]')
		return
	end

	local textTable = {}

	for line in text:gmatch('[^\r\n]+') do
		table.insert(textTable, line)
	end

	local font = tonumber(exports['dialog']:Create('Anim Status', 'Enter Font [0-7]').value) or -1

	if font < 0 or font > 7 then
		return
	end

	local target = tonumber(exports['dialog']:Create('Anim Status', 'Enter Player ID').value) or -1

	if target < 1 then
		return
	end

	TriggerServerEvent('anim_status:setText', target, textTable, font)
end)

RegisterNetEvent('anim_status:playerDataList')
AddEventHandler('anim_status:playerDataList', function(elements)
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_data_list', {
		title    = 'Player Data List',
		align    = 'center',
		elements = elements,
	}, function(data, menu)
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'delete_question', {
			title    = 'Delete status?',
			align    = 'center',
			elements = {
				{label = 'Yes', value = 'yes'},
				{label = 'No', value = 'no'},
			},
		}, function(data2, menu2)
			menu2.close()

			if data2.current.value == 'yes' then
				TriggerServerEvent('anim_status:deleteText', data.current.value)
			end
		end,function(data2, menu2)
			menu2.close()
		end)
	end,function(data, menu)
	   menu.close()
	end)
end)

RegisterNetEvent('anim_status:sendData')
AddEventHandler('anim_status:sendData', function(data)
	playerStatus = data
end)

RegisterNetEvent('anim_status:setPlayerStatus')
AddEventHandler('anim_status:setPlayerStatus', function(target, data)
	playerStatus[target] = data
end)

function InitScript()
	local drawTxt = {}
	local loopTimer = 0
	
	Citizen.CreateThread(function()
		while true do
			local wait = 1000
			local coords = GetEntityCoords(PlayerPedId())
			
			if loopTimer < GetGameTimer() then
				loopTimer = GetGameTimer() + 1000
				
				for _, target in pairs(GetActivePlayers()) do
					local sid = GetPlayerServerId(target)
					
					if playerStatus[sid] and not playerStatus[sid].hidden and drawTxt[sid] == nil then
						local targetPed = GetPlayerPed(target)
						
						if IsEntityVisible(targetPed) and #(coords - GetEntityCoords(targetPed)) < 30.0 then
							drawTxt[sid] = {
								targetPed	= targetPed,
								counter		= 0,
								text		= playerStatus[sid].text,
								font		= playerStatus[sid].font,
							}
						end
					end
				end
				
				for sid,v in pairs(drawTxt) do
					if playerStatus[sid] == nil or playerStatus[sid].hidden or not DoesEntityExist(v.targetPed) then
						drawTxt[sid] = nil
					else
						if #playerStatus[sid].text == v.counter then
							v.counter = 1
						else
							v.counter = v.counter + 1
						end
					end
				end
			end
			
			for sid,v in pairs(drawTxt) do
				if IsEntityVisible(v.targetPed) then
					wait = 0
					local targetCoords = GetEntityCoords(v.targetPed)
					
					if #(coords - targetCoords) < 30.0 then
						DrawText3D(targetCoords, v.text[v.counter], v.font)
					end
				end
			end
			
			Wait(wait)
		end
	end)
end

function DrawText3D(coords, text, font)
	local camCoords = GetGameplayCamCoord()
	local dist = #(coords - camCoords)
	
	local scale = 400 / (GetGameplayCamFov() * dist)
	
	SetTextColour(255, 255, 255, 255)
	SetTextScale(0.0, 0.4 * scale)
	SetTextFont(font)
	SetTextOutline()
	SetTextDropshadow(0, 0, 0, 0, 55)
	SetTextDropShadow()
	SetTextCentre(true)
	
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	SetDrawOrigin(coords.x, coords.y, coords.z + 1.0, 0)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end