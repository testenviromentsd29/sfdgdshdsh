ESX = nil

local blips = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	InitScript()
end)

RegisterNetEvent('coins_bank:sendLocations')
AddEventHandler('coins_bank:sendLocations', function(data)
	for k,v in pairs(data) do
		Config.Jobs[k] = v
		CreateBlip(k, v.coords)
	end
end)

RegisterNetEvent('coins_bank:addLocation')
AddEventHandler('coins_bank:addLocation', function(job, data)
	Config.Jobs[job] = data
	CreateBlip(job, data.coords)
end)

RegisterNetEvent('coins_bank:removeLocation')
AddEventHandler('coins_bank:removeLocation', function(job)
	Config.Jobs[job] = nil

	if DoesBlipExist(blips[job]) then
		RemoveBlip(blips[job])
	end

	blips[job] = nil
end)

function InitScript()
	local alpha = 0
	local toAdd = 1

	Citizen.CreateThread(function()
		while true do
			local wait = 1500
			local coords = GetEntityCoords(PlayerPedId())

			if alpha < 1 then
				toAdd = 1
			elseif alpha > 254 then
				toAdd = -1
			end

			alpha = alpha + toAdd

			for k,v in pairs(Config.Jobs) do
				local distance = #(coords - v.coords)

				if distance < 50.0 then
					wait = 0

					DrawMarker(29, v.coords, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 0, 128, 0, 0, 0, true)
					DrawMarker(1, v.coords.x, v.coords.y, v.coords.z - 1.0, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.0, 255, 215, 0, alpha, 0, 0, 0, 0)

					if distance < 1.2 then
						ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to use the ~y~coin bank')

						if IsControlJustReleased(0, 38) then
							SelectAction(k)
						end
					end
				end
			end

			Wait(wait)
		end
	end)
end

function SelectAction(job)
	ESX.TriggerServerCallback('coins_bank:getCoinsAndFee', function(coins, fee)
		local action

		if exports['dialog']:Decision('Select Action', 'Bank Fee: '..fee..'%</br>Your Coins: '..coins, '', 'Deposit', 'Withdraw').action == 'submit' then
			action = 'deposit'
		else
			action = 'withdraw'
		end

		local amount = tonumber(exports['dialog']:Create('Enter amount to '..action, 'Bank Fee: '..fee..'%</br>Your Coins: '..coins).value)

		if amount then
			TriggerServerEvent('coins_bank:'..action, job, amount)
		end
	end, job)
end

function CreateBlip(job, coords)
	if DoesBlipExist(blips[job]) then
		RemoveBlip(blips[job])
	end

	blips[job] = AddBlipForCoord(coords)
	SetBlipSprite(blips[job], 108)
	SetBlipDisplay(blips[job], 4)
	SetBlipScale(blips[job], 0.8)
	SetBlipColour(blips[job], 5)
	SetBlipAsShortRange(blips[job], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Coin Bank')
	EndTextCommandSetBlipName(blips[job])
end