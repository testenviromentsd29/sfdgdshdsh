ESX = nil

local playerData = {}
local clothesData = {}
local myIdentifier = ''

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	while ESX.GetPlayerData().identifier == nil do
		Wait(100)
	end

	myIdentifier = ESX.GetPlayerData().identifier

	InitScript()
end)

RegisterNetEvent('clothes_wh:sendClothesData')
AddEventHandler('clothes_wh:sendClothesData', function(data)
	clothesData = data
end)

RegisterNetEvent('clothes_wh:sendPlayerData')
AddEventHandler('clothes_wh:sendPlayerData', function(data)
	playerData = data
end)

function InitScript()
	Citizen.CreateThread(function()
		while true do
			local model = GetEntityModel(PlayerPedId())
			local gender = model == GetHashKey('mp_m_freemode_01') and 'm' or model == GetHashKey('mp_f_freemode_01') and 'f' or 'unknown'

			if clothesData[gender] then
				for componentId,v in pairs(Config.Drawables) do
					if clothesData[gender][componentId] and clothesData[gender][componentId][tostring(v.get())] then
						if playerData[gender] == nil or playerData[gender][componentId] == nil or playerData[gender][componentId][tostring(v.get())] == nil then
							v.clear()
							ESX.ShowNotification('Cloth removed because is whitelisted')
							Wait(1000)
						end
					end
				end
			end

			Wait(1000)
		end
	end)
end