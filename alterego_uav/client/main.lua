


Keys = {
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
ESX = nil
local staff = {}
local usedJammer = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	ESX.PlayerData = ESX.GetPlayerData()

	ESX.TriggerServerCallback('alterego_uav:getStaff', function(cb)
		staff = cb
	end)

	ESX.TriggerServerCallback('alterego_uav:getJammers', function(cb)
		usedJammer = cb
	end)
end)

RegisterNetEvent('alterego_uav:addStaff')
AddEventHandler('alterego_uav:addStaff', function(id)
	staff[id] = true
end)

RegisterNetEvent('alterego_uav:removeStaff')
AddEventHandler('alterego_uav:removeStaff', function(id)
	if staff[id] then
		staff[id] = nil
	end
end)

RegisterNetEvent('alterego_uav:addJammer')
AddEventHandler('alterego_uav:addJammer', function(id)
	usedJammer[id] = true
end)

RegisterNetEvent('alterego_uav:removeJammer')
AddEventHandler('alterego_uav:removeJammer', function(id)
	if usedJammer[id] then
		usedJammer[id] = nil
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local blips = {}
function removeBlips()
    for k,v in pairs(GetActivePlayers()) do
        RemoveBlip(blips[v])
    end       
end

local ConfBlips = {
	Scale = 1.0,
	Sprite = 1,
	Colour = 4,
}

function totime(ms)
	local secs = ms / 1000

	local minutes = math.floor(secs / 60)
	local seconds = math.floor(secs % 60)

	local final = string.format('%02.f', minutes)..':'..string.format('%02.f', math.floor(seconds))
	return final
end

RegisterNetEvent('uav:startBlips')
AddEventHandler('uav:startBlips', function(duration)
	if exports.esx_mMafia:IsDisplayMembersActive() then
		ESX.ShowNotification('Close display mafia members first!')
		return
	end

	local timenow = GetGameTimer()
	Citizen.CreateThread(function()
		while GetGameTimer() - timenow < duration do
			Wait(0)
			DrawClassicText(0.58, 1.15, 1.0, 1.0, 0.5, "~y~UAV ~g~Enabled\nTime Remaining " .. totime(duration-(GetGameTimer() - timenow)), 255, 1, 255, 255)
		end
	end)
	while GetGameTimer() - timenow < duration do
	
		Wait(0)
		for k,v in pairs(GetActivePlayers()) do
			Wait(250)
			local playerPed = GetPlayerPed(v)
			local playerName = GetPlayerName(v)
			if not IsEntityVisible(playerPed) or staff[GetPlayerServerId(v)] or usedJammer[GetPlayerServerId(v)] then
				if DoesBlipExist(blips[v]) then
					RemoveBlip(blips[v])
				end
			end
			if not staff[GetPlayerServerId(v)] and not usedJammer[GetPlayerServerId(v)] then
				if (playerPed ~= GetPlayerPed(-1)) and (GetBlipFromEntity(playerPed) < 1) and IsEntityVisible(playerPed) then
					local new_blip = AddBlipForEntity(playerPed)
					
					SetBlipSprite(new_blip, ConfBlips.Sprite)
					SetBlipColour(new_blip, ConfBlips.Color)
				
					SetBlipScale(new_blip, ConfBlips.Scale)
					

					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString("Enemy")
					EndTextCommandSetBlipName(new_blip)

					--SetBlipNameToPlayerName(new_blip, "Enemy")
					SetBlipCategory(new_blip, 7);
					SetBlipDisplay(new_blip, 6)
					blips[v] = new_blip
				end
			end
		end
	end
	removeBlips()
end)

RegisterCommand('resetsonarblips', function(source, args)
	for k,v in pairs(GetActivePlayers()) do
		local blip = GetBlipFromEntity(GetPlayerPed(v))

		if DoesBlipExist(blip) then
			RemoveBlip(blip)
		end
	end
end)

RegisterNetEvent('alterego_uav:showJammer')
AddEventHandler('alterego_uav:showJammer', function(duration)
	local timenow = GetGameTimer()
	while GetGameTimer() - timenow < duration do
		Wait(0)
		DrawClassicText(1.42, 1.25, 1.0, 1.0, 0.5, "~y~Jammer ~g~Enabled\nTime Remaining " .. totime(duration-(GetGameTimer() - timenow)), 255, 1, 255, 255)
	end
end)

function DrawClassicText(x,y ,width,height,scale,text, r,g,b,a)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour( 0,0,0, 255 )
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(x - width/2, y - height/2 + 0.005)
end