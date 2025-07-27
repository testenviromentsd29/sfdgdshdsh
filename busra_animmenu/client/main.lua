CreateThread(function()
    IsInAnimation = false
    local loaded = false

    RegisterNetEvent('busra_animmenu:client:openMenu', function()
        openMenu(true)
    end)
    
    RegisterCommand('emotemenu_doit', function()
        openMenu(not state)
    end)
    
    RegisterCommand('fixmouse', function()
        SetNuiFocus(false, false)
    end)
    
    RegisterKeyMapping('emotemenu_doit', 'Animasyon menüsünü açar', 'keyboard', Config.OpenKey)
    
    CreateThread(function()
        while not loaded do 
            Wait(5000)
        end
        while not NetworkIsSessionStarted() do 
            Wait(1000)
        end
        Wait(5000)
        SendNUIMessage({
            action = "setData",
            animations = Config.animations
        })
    end)

    RegisterNUICallback("callAnim", function(data, cb)
        -- print("Calling anim")
        local anim = data.anim
        if not anim then return print("no anim found", json.encode(data)) end
        local ped = PlayerPedId()
        if not anim.sharedAnim then
            -- print("solo anim")
            onAnimTriggered(anim)
        else
            -- print("shared anim")
            target, distance = GetClosestPlayer()
            if (distance ~= -1 and distance < 3) then
                TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), anim)
                SimpleNotify(Config.Languages[lang]['sentrequestto'] .. GetPlayerName(target))
            else
                SimpleNotify(Config.Languages[lang]['nobodyclose'])
            end
        end 
    end)

    RegisterNUICallback("callShared", function(data, cb)
        -- print("Calling shared")
        local anim = data.anim
        if not anim then return print("no shared anim found", json.encode(data)) end
        target, distance = GetClosestPlayer()
        if (distance ~= -1 and distance < 3) then
            TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), anim)
            SimpleNotify(Config.Languages[lang]['sentrequestto'] .. GetPlayerName(target))
        else
            SimpleNotify(Config.Languages[lang]['nobodyclose'])
        end
    end)

    CreateThread(function()
        while true do 
            if state then
                if IsDisabledControlJustPressed(0, 200) then
                    DisableControlAction(0, 200, true) --esc
                    DisableControlAction(0, 202, true) --esc
                    DisableControlAction(0, 322, true) --esc
                    DisableControlAction(0, 177, true) --esc
                    Wait(0)
                    openMenu(false)
                end
            else
                Wait(500)
            end
            Wait(1)
        end
    end)

    CreateThread(function()
        while true do 
            if state then
                DisableControlAction(0, 0, true)
                DisableControlAction(0, 1, true)
                DisableControlAction(0, 2, true)

                DisableControlAction(0, 200, true) --esc
                DisableControlAction(0, 202, true) --esc
                DisableControlAction(0, 322, true) --esc
                DisableControlAction(0, 177, true) --esc

                DisableControlAction(0, 156, true)
                DisableControlAction(0, 245, true) --chat

                DisableControlAction(0, 199, true) --chat
                DisableControlAction(0, 156, true) --chat

                DisableControlAction(0, 24, true) -- INPUT_ATTACK
                DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
                DisableControlAction(0, 70, true) -- INPUT_VEH_ATTACK2
                DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
                DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
                DisableControlAction(0, 257, true) -- INPUT_ATTACK2
                DisableControlAction(0, 331, true) -- INPUT_VEH_FLY_ATTACK2

                DisableControlAction(0, 6, true) --right click
                DisableControlAction(0, 13, true) --right click
                DisableControlAction(0, 25, true) --right click

                DisablePlayerFiring(PlayerId(), true)
            else
                Wait(500)
            end
            Wait(1)
        end
    end)

    RegisterNUICallback("close", function(data, cb)
        openMenu(false)
    end)

    RegisterNUICallback("stopAnim", function(data, cb)
        EmoteCancel()
    end)

    CreateThread(function()
        while DP == nil do 
            Wait(1000)
        end
        while next(DP) == nil do 
            Wait(1000)
        end
        if not Config.SharedEmotes then
            DP['Shared'] = nil
        end
        if not Config.WalkingStyles then 
            DP['Walks'] = nil
        else
            for k, v in pairs(DP['Walks']) do 
                v[2] = k:lower()
            end
        end
        for categ, va in pairs(DP) do 
            if not Config.animations[categ] then 
                Config.animations[categ] = {}
            end
            for animTag, v in pairs(va) do 
                local animDict = v[1]
                local animName = v[2] or animTag
                local label = v[3] or animTag
                local options = v.AnimationOptions

                local id = #Config.animations[categ]+1
                Config.animations[categ][id] = {
                    dict = animDict,
                    name = animName,
                    label = label,
                    AnimationOptions = options,
    

                    sharedAnim = v[4],
                    id = id,
                    categ = categ,
                    animName = animTag,
                }
            end
        end

        for categ, va in pairs(Config.animations) do 
            for animTag, v in pairs(va) do 
                if DoesAnimDictExist(v.dict) then
                    if not v.id then
                        v.id = animTag
                    end
                    if not v.animName then
                        v.animName = animTag
                    end
                    if not v.categ then
                        v.categ = categ
                    end
                else
                    if categ ~= "Walks" and not v.dict:match("Scenario") and categ ~= "Expressions" then
                        print("NO ANIM FOUND BY NAME", v.dict, DoesAnimDictExist(v.dict))
                        v = nil
                    end
                end
            end
        end
        loaded = true
    end)
end)

local emob1 = ""
local emob2 = ""
local emob3 = ""
local emob4 = ""
local emob5 = ""
local emob6 = ""
local keyb1 = ""
local keyb2 = ""
local keyb3 = ""
local keyb4 = ""
local keyb5 = ""
local keyb6 = "" 
local Initialized = false
local KeybindKeys = {
    ['num4'] = 108,
    ['num5'] = 110,
    ['num6'] = 109,
    ['num7'] = 117,
    ['num8'] = 111,
    ['num9'] = 118
}

RegisterCommand('keybind', function(source, args)
    if not KeybindKeys[args[1]] then 
        print("Invalid keybind") 
        return 
    end

    if not args[2] then 
        print("Invalid emote") 
        return 
    end

    TriggerServerEvent('busra_animmenu:ServerKeybindUpdate', args[1], args[2])
end)

CreateThread(function()
    Wait(2000)
    while true do
        if NetworkIsPlayerActive(PlayerId()) and not Initialized then
            if not Initialized then
                TriggerServerEvent("busra_animmenu:ServerKeybindExist")
                Wait(5000)
            end
        end

        if not IsPedSittingInAnyVehicle(PlayerPedId()) then
            for k, v in pairs(KeybindKeys) do
                if IsControlJustReleased(0, v) then
                    if k == keyb1 then if emob1 ~= "" then EmoteCommandStart(nil, {emob1, 0}) end end
                    if k == keyb2 then if emob2 ~= "" then EmoteCommandStart(nil, {emob2, 0}) end end
                    if k == keyb3 then if emob3 ~= "" then EmoteCommandStart(nil, {emob3, 0}) end end
                    if k == keyb4 then if emob4 ~= "" then EmoteCommandStart(nil, {emob4, 0}) end end
                    if k == keyb5 then if emob5 ~= "" then EmoteCommandStart(nil, {emob5, 0}) end end
                    if k == keyb6 then if emob6 ~= "" then EmoteCommandStart(nil, {emob6, 0}) end end
                    Wait(1000)
                end
            end
        else
            Wait(500)
        end

        Wait(1)
    end
end)
  
RegisterNetEvent("busra_animmenu:ClientKeybindExist")
AddEventHandler("busra_animmenu:ClientKeybindExist", function(does)
    if does then
        TriggerServerEvent("busra_animmenu:ServerKeybindGrab")
    else
        TriggerServerEvent("busra_animmenu:ServerKeybindCreate")
    end
end)

RegisterNetEvent("busra_animmenu:ClientKeybindGet")
AddEventHandler("busra_animmenu:ClientKeybindGet", function(k1, e1, k2, e2, k3, e3, k4, e4, k5, e5, k6, e6)
    keyb1 = k1 emob1 = e1 keyb2 = k2 emob2 = e2 keyb3 = k3 emob3 = e3 keyb4 = k4 emob4 = e4 keyb5 = k5 emob5 = e5 keyb6 = k6 emob6 = e6
    Initialized = true
end)

RegisterNetEvent("busra_animmenu:ClientKeybindGetOne")
AddEventHandler("busra_animmenu:ClientKeybindGetOne", function(key, e)
    if key == "num4" then emob1 = e keyb1 = "num4" elseif key == "num5" then emob2 = e keyb2 = "num5" elseif key == "num6" then emob3 = e keyb3 = "num6" elseif key == "num7" then emob4 = e keyb4 = "num7" elseif key == "num8" then emob5 = e keyb5 = "num8" elseif key == "num9" then emob6 = e keyb6 = "num9" end
end)