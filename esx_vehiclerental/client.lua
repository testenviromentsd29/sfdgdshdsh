ESX = nil

local AllLocations = nil
RegisterNetEvent('esx_vehiclerental:addCoords')
AddEventHandler('esx_vehiclerental:addCoords', function(coords)
	table.insert(AllLocations, {coords = coords,		spawnpoint = coords,	heading = 100.00,	model = 'bf400',	price = 150})
end)

CreateThread(function()
	Wait(5000)
	
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	ESX.TriggerServerCallback('esx_vehiclerental:getCustomCoords', function(data)
		Wait(math.random(0,5000))
		AllLocations = data
	end)

	while AllLocations == nil do Wait(100) end
	
	for k,v in pairs(AllLocations) do
		if v.blip then
			local blip = AddBlipForCoord(v.coords)
			SetBlipSprite(blip, v.blip.sprite)
			SetBlipScale(blip, v.blip.scale)
			SetBlipColour(blip, v.blip.color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString(v.blip.name)
			EndTextCommandSetBlipName(blip)
		end
	end
	
	while true do
		local wait = 5000
		
		for k,v in pairs(AllLocations) do
			if #(GetEntityCoords(PlayerPedId()) - v.coords) < 25.0 then
				wait = 0
				DrawMarker(Config.Markers[v.model], v.coords, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.8, 255, 0, 0, 150, true, true, 2, false, false, false, false)
				
				if #(GetEntityCoords(PlayerPedId()) - v.coords) < 1.0 then
					ESX.ShowHelpNotification('Press ~r~[E]~w~ to rent a '..v.model..' for ~p~['..v.price..'$]')
					
					if IsControlJustReleased(0, 38) then
						ESX.TriggerServerCallback('esx_vehiclerental:rentVehicle', function(yes)
							if yes then
								ESX.Game.SpawnVehicle(v.model, v.spawnpoint, v.heading, function(vehicle)
									TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
									if v.model ~= "kart3" then
										startCounter(vehicle)
									end
								end)
							end
						end, k)
						
						Wait(10000)
					end
				end
			end
		end
		
		Wait(wait)
	end
end)

function startCounter(vehicle)
	Wait(1000)
	local timer = 300
	
	Citizen.CreateThread(function()
		while timer ~= nil do
			Wait(1000)
			
			if timer ~= nil and timer > 0 then
				timer = timer - 1
			else
				break
			end
		end
		
		if DoesEntityExist(vehicle) then
			DeleteEntity(vehicle)
		end
		timer = nil
	end)
	
	Citizen.CreateThread(function()
		while timer ~= nil do
			local currvehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			if currvehicle and currvehicle == vehicle then
				DrawText2(0.01, 0.6, 0.5, '~r~Seconds Left: ~w~'..timer)
			else
				Wait(1000)
			end
			
			Wait(0)
		end
	end)
end

function DrawText2(x, y, scale, text)
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