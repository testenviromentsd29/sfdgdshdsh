local ESX = nil
local PlayerData = nil
local currentIndex = 0

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Wait(100)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

local peds = {}

CreateThread(function()
	while true do
		Wait(4000)
		for k,v in pairs(Config.Shops) do
			if peds[k] and DoesEntityExist(peds[k]) then
				if #(GetEntityCoords(PlayerPedId()) - v.Pos) > 50 then
					DeleteEntity(peds[k])
                    peds[k] = nil

				end
			else
				if #(GetEntityCoords(PlayerPedId()) - v.Pos) < 30 then
					peds[k] = CreateNPC(v.Ped.model, v.Pos, v.Ped.heading)
				end
			end
		end
	end
end)

CreateThread(function()
    for k,v in pairs(Config.Shops) do
        if v.blip and v.blip.show then
            local blip = AddBlipForCoord(v.Pos)
            SetBlipSprite(blip, v.blip.sprite)
            SetBlipScale(blip, 1.0)
            SetBlipColour(blip, v.blip.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(v.blip.label)
            EndTextCommandSetBlipName(blip)
        end
    end

    while true do
        Wait(0)
        local sleep = true
        for k,v in pairs(Config.Shops) do
            if #(GetEntityCoords(PlayerPedId()) - v.Pos) < 15.0 then
                sleep = false
                --DrawText3D(v.Pos.x,v.Pos.y,v.Pos.z+1.3, "Press [~g~E~w~] To Sell Items", 1.0, 4)
                if #(GetEntityCoords(PlayerPedId()) - v.Pos) < 2.0 then
					ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to sell items')
                    if not isBusy then

						if IsControlJustReleased(0, 38) and not IsNuiFocused() then
							currentIndex = k
							openMainMenu(k)
                        end
                    end
                else
                    isBusy = false
                end
            end
        end
        if sleep then 
            Wait(1000)
        end
    end
end)

openMainMenu = function(index)
	-- local answers = {
	-- 	{label = 'I want to sell items.',		value = 1, code = [[TriggerEvent("agora:selectedOption", 1)]]},
	-- 	{label = 'I want to buy items.',		value = 2, code = [[TriggerEvent("agora:selectedOption", 2)]]},
	-- }
	
	-- TriggerEvent("mCore:startNPCCameraMenu", GetHashKey(Config.Shops[index].Ped.model), Config.Shops[index].shopLabel, "Welcome what do you want?", answers)
	TriggerEvent("agora:selectedOption", 1)
end

AddEventHandler("agora:selectedOption", function(opt)
	if opt == 1 then
		isBusy = true
        SetNuiFocus(true, true)
        SendNUIMessage({
            message		= "show",
            clear = true
        })
        local pdata = ESX.GetPlayerData()
        local inventory = pdata.inventory
        local loadout = pdata.loadout
        local havingWeapons = {}
		local itemsQuantities = {}
		for slot,obj in pairs(inventory) do 
			if obj.count > 0 then
				itemsQuantities[obj.name] = (itemsQuantities[obj.name]or 0) + obj.count
			end
		end
        for i,obj in pairs(loadout) do
            havingWeapons[obj.name] = true
        end

        for l,m in pairs(Config.Shops[currentIndex].Items) do
			--if m.jobs == nil or m.jobs[PlayerData.job.name] then
				local quantityOn = 0
				local addition = 0
				if itemsQuantities[l] then 
					quantityOn = itemsQuantities[l]
				end
				local price = m.sellPrice
				if GetResourceState('charstats') == 'started' then
					local isJobItem = m.job and m.job == pdata.job.name;
					if isJobItem then
						local level = exports.charstats:GetLevel(pdata.job.name:upper());
						local extra = 0.0;
						
						if level == 1 then
							extra = 35.0;
						elseif level == 2 then
							extra = 70.0;
						elseif level == 3 then
							extra = 100.0;
						end
						print(extra)
						price = math.floor(price + (price * extra / 100));
					end
				end
				
				if m.job == nil or m.job == pdata.job.name then
					SendNUIMessage({
						message	= "sell",
						item = l,
						label = ESX.GetItemLabel(l),
						price = price,
						quantity = quantityOn,
						useBlack = m.useBlack,
						loc = currentIndex,
						clear = true
					})
				end
			--end
        end
	elseif opt == 2 then
		ESX.TriggerServerCallback("agora:getItems", function(data)
			if data then
				SetNuiFocus(true, true)
				SendNUIMessage({
					message		= "show",
					clear 		= true
				})
				
				for l,m in pairs(Config.Shops[currentIndex].Items) do
					--if m.jobs == nil or m.jobs[PlayerData.job.name] then
						local quantityOn = 0

						local price = m.buyPrice
						price = math.floor(price)
						SendNUIMessage({
							message	= "buy",
							item = l,
							label = ESX.GetItemLabel(l),
							price = price,
							quantity = 0,
							stock = data[l],
							useBlack = m.useBlack,
							loc = currentIndex,
							clear = true
						})
					--end
				end
			end
		end)
	end
end)

RegisterNUICallback('addQuantityBuy', function(data, cb)
	local value = tonumber(exports['dialog']:Create('Buy', 'Enter Quantity').value)
	if value > 1 then
		data.count = value
	end
	TriggerServerEvent('agora:buyItem', data.item, data.count, currentIndex)
	closeGui()
    cb('ok')
end)

RegisterNUICallback('addQuantitySell', function(data, cb)
	local value = tonumber(exports['dialog']:Create('Sell', 'Enter Quantity').value)
	if value > 1 then
		data.count = value
	end
	TriggerServerEvent('agora:sellItem', currentIndex, data.item, data.count)
	closeGui()
    cb('ok')
end)

--[[RegisterNetEvent("agora:showBox", function()
	ExecuteCommand("e c")
	ExecuteCommand("e box")
end)]]

function DrawText3D(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function CreateNPC(model, coords, heading)
    local hashMonel = GetHashKey(model)
	RequestModel(hashMonel)
	
	while not HasModelLoaded(hashMonel) do
		Wait(10)
	end
	
	RequestAnim('mini@strip_club@idles@bouncer@base')
	
	local npc = CreatePed(5, hashMonel, coords.x, coords.y, coords.z - 1.0, heading, false, true)
	SetEntityHeading(npc, heading)
	FreezeEntityPosition(npc, true)
	SetEntityInvincible(npc, true)
	SetBlockingOfNonTemporaryEvents(npc, true)
	
	TaskPlayAnim(npc, 'mini@strip_club@idles@bouncer@base', 'base', 8.0, 0.0, -1, 1, 0, 0, 0, 0)
	
	SetModelAsNoLongerNeeded(hashMonel)
    return npc
end

function RequestAnim(anim)
	RequestAnimDict(anim)
	
	while not HasAnimDictLoaded(anim) do
		Wait(10)
	end
end

function closeGui()
    SetNuiFocus(false, false)
    isBusy = false
    SendNUIMessage({message = "hide"})
end

RegisterNUICallback('quit', function(data, cb)
    closeGui()
    cb('ok')
end)

RegisterNUICallback('sellItem', function(data, cb)
	--[[  closeGui() ]]
	TriggerServerEvent('agora:sellItem', data.zone, data.item, data.count)
	Wait(500)
	local pdata = ESX.GetPlayerData()
	local inventory = pdata.inventory
	local loadout = pdata.loadout
	local havingWeapons = {}
	local itemsQuantities = {}
	for slot,obj in pairs(inventory) do 
	   if obj.count > 0 then
		   itemsQuantities[obj.name] = (itemsQuantities[obj.name]or 0) + obj.count
	   end
	end
	SendNUIMessage({
	message	= "dd",})
	for i,obj in pairs(loadout) do
	   havingWeapons[obj.name] = true
	end

	for l,m in pairs(Config.Shops[currentIndex].Items) do
		if m.job == nil or m.job == pdata.job.name then
		   local quantityOn = 0
		   local addition = 0
		   if itemsQuantities[l] then 
			   quantityOn = itemsQuantities[l]
		   end
		   local price = m.sellPrice
		   SendNUIMessage({
			   message	= "sell",
			   item = l,
			   label = ESX.GetItemLabel(l),
			   price = price,
			   quantity = quantityOn,
			   useBlack = m.useBlack,
			   loc = currentIndex,
			   clear = true
		   })
		end
	end
	cb('ok')

end)

RegisterNUICallback('buyItem', function(data, cb)
    closeGui()
    cb('ok')

    TriggerServerEvent('agora:buyItem', data.item, data.count, currentIndex)
end)

RegisterNetEvent('agora:SetAgoraPercent')
AddEventHandler('agora:SetAgoraPercent', function()

    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'agora_percent', {
        title = "Set Agora Percent [1-100]",
    },
    function(data, menu)
        local percent = data.value
        percent = tonumber(percent)
        if percent >= 0 and percent <= 100 then 
            TriggerServerEvent('agora:setPercent', percent)
            menu.close()
        else
            ESX.ShowNotification("Percent must be between 0 and 100")
        end
    end,
    function(data, menu)
        menu.close()
    end)


end)