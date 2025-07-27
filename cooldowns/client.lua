RegisterNetEvent('cooldowns:sendCooldown')
AddEventHandler('cooldowns:sendCooldown', function(data, robberies)
	local temp = {}
	
	for k,v in pairs(data) do
		temp[k] = {name = Config.Events[k].name, expire = v, type = Config.Events[k].type, coords = tostring(Config.Events[k].coords) or 'vector3(0.0, 0.0, 0.0)'}
	end
	
	for k,v in pairs(robberies) do
		temp['robbery_'..k] = {name = 'Robbery '..k, expire = v.cooldown, type = 'robbery', coords = tostring(v.coords) or 'vector3(0.0, 0.0, 0.0)'}
	end
	
	SetNuiFocus(true, true)
	SendNUIMessage({cooldowns = temp})
end)

RegisterNUICallback('quit', function(data)
	SetNuiFocus(false, false)
end)

RegisterNUICallback('setwaypoint', function(data)
	local coords = load('return '..data.coords)()
	SetNewWaypoint(coords.x, coords.y)
end)