------ JUST FUNCTIONS -------

Citizen.CreateThread(function()
	local craftCoords = vector3(-14.05, -1444.13, 30.75)
	
	local blip = AddBlipForCoord(craftCoords)
	SetBlipSprite(blip, 150)
	SetBlipScale(blip, 0.8)
	SetBlipColour(blip, 0)
	SetBlipDisplay(blip, 4)
	SetBlipAsShortRange(blip, true)
	
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Gang War Craft')
	EndTextCommandSetBlipName(blip)
	
	while ESX == nil do
		Wait(0)
	end
	
	while true do
		local wait = 1500
		local coords = GetEntityCoords(PlayerPedId())
		
		if #(coords - craftCoords) < 50.0 then
			wait = 0
			DrawMarker(21, craftCoords, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, false, false, false, false)
			
			if #(coords - craftCoords) < 1.0 then
				ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to craft your gang\'s weapon')
				
				if IsControlJustReleased(0, 38) then
					local elements = {}
					
					for k,v in pairs(Config.Craft) do
						table.insert(elements, {label = '['..string.gsub(v, 'blueprint_', '')..'] ['..string.gsub(k, 'gangwars', '')..']', value = k})
					end
					
					ESX.UI.Menu.CloseAll()
					
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'craft_menu', {
						title    = 'Craft Menu',
						align    = 'center',
						elements = elements,
					},
					function(data, menu)
						menu.close()
						TriggerServerEvent('gang_wars:craftWeapon', data.current.value)
					end,
					function(data, menu)
						menu.close()
					end)
				end
			end
		end
		
		Wait(wait)
	end
end)

function CreateBlips()
	for k,v in pairs(Config.GangAreas) do
		CreateBlip(v.bot.coords,v.blip)
	end
end

function CreateBlip(coords,data)
	local blip = AddBlipForCoord(data.coords or coords)

	SetBlipSprite(blip, data.sprite)
	SetBlipScale(blip, 0.8)
	SetBlipColour(blip, data.color)
	SetBlipDisplay(blip, 8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(data.name or "Gang War")
	EndTextCommandSetBlipName(blip)

	return blip
end

function CreateAreaBlip(coords)
	local blip = AddBlipForRadius(coords.x,coords.y,coords.z,Config.AreaRadius)
	SetBlipColour(blip, 2)
	SetBlipAlpha(blip, 100)
	return blip
end

---- UI Menu functions -------
MenuOpen = false

function OpenMenu(gang)
	local areaData = Config.GangAreas[gang]

	local options = {
		gang = gang,
		owner = areaData.owner,
		date = areaData.date
	}
	ESX.TriggerServerCallback('gang_wars:getparticipants',function(att,def,money,controlled,controlledName)
		options.attackers = {}
		options.defenders = {}
		options.money = money or 1000000
		options.controlledBy = controlledName or 'Greek Mafia'
		if controlled and (controlled == ESX.PlayerData.job.name or gang == ESX.PlayerData.job.name) then
			options.CanRespawnCar = true
			if ESX.PlayerData.job.grade_name == 'boss' then
				options.CanTakeMoney = true
			end
		end
		for k,v in pairs(att or {}) do
			table.insert(options.attackers,v)
		end
		for k,v in pairs(def or {}) do
			table.insert(options.defenders,v)
		end
		SendNUIMessage({
			action = "show",
			data = options
		})
		SetNuiFocus(true,true)
		MenuOpen = true
	end,gang)
end

function CloseMenu()
	SendNUIMessage({
		action = "onCloseMenu"
	})
	SetNuiFocus(false,false)
	MenuOpen = false
end


--------------------------------------------

function DrawText3D(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
	
    local scale = 300 / (GetGameplayCamFov() * dist)
	
    SetTextColour(255, 255, 255, 255)
	SetTextScale(0.0, 0.5 * scale)
	SetTextFont(0)
	SetTextDropshadow(0, 0, 0, 0, 55)
	SetTextDropShadow()
	SetTextCentre(true)
	
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	SetDrawOrigin(coords.x, coords.y, coords.z + 1, 0)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end


local peds = {}
function CreatePeds()
	Citizen.CreateThread(function()
		while true do
			Wait(4000)
			for k,v in pairs(Config.GangAreas) do
				if peds[k] and DoesEntityExist(peds[k]) then
					if #(GetEntityCoords(PlayerPedId()) - v.bot.coords) > 50 then
						DeleteEntity(peds[k])
						peds[k] = nil
					end
				else
					if #(GetEntityCoords(PlayerPedId()) - v.bot.coords) < 30 then
						peds[k] = CreateNPC(v.bot.model,v.bot.coords,v.bot.heading)
					end
				end
			end
		end
	end)
	


--[[ 	for k,v in pairs(Config.GangAreas) do
		CreateNPC(v.bot.model,v.bot.coords,v.bot.heading)
	end ]]
end

function CreateNPC(model, coords, heading)
	RequestModel(model)
	
	while not HasModelLoaded(model) do
		Wait(10)
	end
	
	RequestAnim('mini@strip_club@idles@bouncer@base')
	
	local npc = CreatePed(5, model, coords.x, coords.y, coords.z, heading, false, true)
	SetEntityHeading(npc, heading)
	FreezeEntityPosition(npc, true)
	SetPedDropsWeaponsWhenDead(npc,false)
	SetEntityInvincible(npc, true)
	SetBlockingOfNonTemporaryEvents(npc, true)
	
	TaskPlayAnim(npc, 'mini@strip_club@idles@bouncer@base', 'base', 8.0, 0.0, -1, 1, 0, 0, 0, 0)
	
	SetModelAsNoLongerNeeded(model)
	return npc
end


function RequestAnim(anim)
	RequestAnimDict(anim)
	
	while not HasAnimDictLoaded(anim) do
		Wait(10)
	end
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