local busy = false
local inAnimation = false
local targetPlayer = 0
local taskBarActive = false
local ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	
end)

RegisterCommand("erp", function()
    SendNUIMessage({
        action = "show"
    })
    SetNuiFocus(true, true)
end)

RegisterNUICallback('quit', function()
	SetNuiFocus(false,false)
end)

RegisterNUICallback('sex', function()
	SetNuiFocus(false,false)
    TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))

    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'id_selectr', {
        title = 'Select ID'
    }, function(data, menu)
        local id = tonumber(data.value)
        ExecuteCommand("p1 " .. id)
        menu.close()

    end,function(data,menu)
        menu.close()
    end)
end)

RegisterNUICallback('blowjob1', function()
	SetNuiFocus(false,false)
    TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))

    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'id_selectr', {
        title = 'Select ID'
    }, function(data, menu)
        local id = tonumber(data.value)
        ExecuteCommand("p2 " .. id)
        menu.close()

    end,function(data,menu)
        menu.close()
    end)
end)

RegisterNUICallback('blowjob2', function()
	SetNuiFocus(false,false)
    TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))

    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'id_selectr', {
        title = 'Select ID'
    }, function(data, menu)
        local id = tonumber(data.value)
        ExecuteCommand("p3 " .. id)
        menu.close()

    end,function(data,menu)
        menu.close()
    end)
end)

RegisterNUICallback('start-emote', function()
	SetNuiFocus(false,false)
    TriggerServerEvent('3dme:showCloseIds', GetEntityCoords(PlayerPedId()))

    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'id_selectr', {
        title = 'Select ID'
    }, function(data, menu)
        if data.value then
            local id = tonumber(data.value)
            ExecuteCommand("req " .. id)
            menu.close()
        end
    end,function(data,menu)
        menu.close()
    end)
end)

RegisterNUICallback('cancel-emote', function()
    SetNuiFocus(false,false)

        ExecuteCommand("erpcancel")
end)



Citizen.CreateThread(function()
    --TriggerEvent('chat:addSuggestion', '/erp', 'Sends E-RP Request to Player! / E-RP Commands: /p1, /p2, /p3, /erpcancel', {{ name="id", help="Player Server ID!"}})
    TriggerEvent('chat:addSuggestion', '/erpcancel', 'revokes the permission of the permitted player')
    TriggerEvent('chat:addSuggestion', '/p1', 'Sex position 1', {{ name="id", help="Player Server ID!"}})
    TriggerEvent('chat:addSuggestion', '/p2', 'Sex position 2 (Car)', {{ name="id", help="Player Server ID!"}})
    TriggerEvent('chat:addSuggestion', '/p3', 'Sex position 3 (Car)', {{ name="id", help="Player Server ID!"}})
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if inAnimation then
            DisableControlAction(0, 73, true)
            if IsDisabledControlJustReleased(0, 73) then
                clearAnim(true)
            end
        end
    end
end)

RegisterNetEvent('tgiann-erp:client:clear-anim')
AddEventHandler('tgiann-erp:client:clear-anim', function()
    clearAnim(false)
end)

RegisterNetEvent('tgiann-erp:izin')
AddEventHandler('tgiann-erp:izin', function(target)
    if not busy then
        busy = true
        showNotification("Player with "..target.." IDs asks for ERP Permission, Press the [Y] Key to Accept")
        local time = 1000
        while time > 0 do
            Citizen.Wait(1)
            time = time - 1
            if time == 0 then
                showNotification("Request Timed Out")
                TriggerServerEvent("tgiann-erp:cancel", target)
            end
            if IsControlJustPressed(0, 246) then
                time = 0
                showNotification("Request Accepted")
                TriggerServerEvent("tgiann-erp:ok", target)
            end
        end
        busy = false
    end
end)

RegisterNetEvent('tgiann-erp:animasyon')
AddEventHandler('tgiann-erp:animasyon', function(car, flag, dict, anim, konumZorla, target, x)
    if not inAnimation then
        taskBarActive = true
        local playerPed = PlayerPedId()
        local incar = true
        if not IsPedSittingInAnyVehicle(playerPed) and car then
            incar = false
            return
        end
        targetPlayer = target
        if incar then
            if anim == "bj_loop_prostitute" or anim == "f_blow_job_loop" then taskBarActive = false end
            inAnimation = true
            if konumZorla then
                SetEntityCollision(playerPed, false, false)
                FreezeEntityPosition(playerPed, true)
                local player = GetPlayerFromServerId(targetPlayer)
                local ped = GetPlayerPed(player)

                local playerheading = GetEntityHeading(ped)
                local playerlocation = GetEntityForwardVector(ped)
                local playerCoords = GetEntityCoords(ped)
                konumaldir(playerPed, playerlocation, playerheading, playerCoords, -0.23)
            end

            RequestAnimDictFunction(dict, function() 
                while inAnimation do
                    if not IsEntityPlayingAnim(PlayerPedId(), dict, anim, 1) then
                        TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, 8.0, -1, flag, 0.0, false, false, false)
                    end
                    Citizen.Wait(100)
                end
            end)
        else
            showNotification("You are not in the car!")
        end
    end
end)

function konumaldir(playerPed, playerlocation, playerheading, playerCoords, x)
    SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true) -- unarm player
    local x, y, z = table.unpack(playerCoords + playerlocation * x)
    SetEntityCoords(PlayerPedId(), x, y, z - 1.0)
    SetEntityHeading(PlayerPedId(), playerheading)
end

function clearAnim(targetClear)
    inAnimation = false
    local playerPed = PlayerPedId()
    if not IsPedSittingInAnyVehicle(playerPed) then
        SetEntityCollision(playerPed, true, true)
        FreezeEntityPosition(playerPed, false)
        ClearPedTasksImmediately(playerPed)
    else
        ClearPedTasks(playerPed)
    end
    if targetClear then
        TriggerServerEvent("tgiann-erp:clear-anim", targetPlayer)
    end
end

function showNotification(msg)
	BeginTextCommandThefeedPost('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandThefeedPostTicker(0,1)
end

function RequestAnimDictFunction(animDict, cb)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then cb() end
end

RegisterNetEvent('tgiann-erp:showNotification')
AddEventHandler('tgiann-erp:showNotification', function(msg)
    showNotification(msg)
end)