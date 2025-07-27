
Citizen.CreateThread(function()

    for _,v in pairs(ConfigCL.locations) do
        RequestModel(GetHashKey(v[7]))
        while not HasModelLoaded(GetHashKey(v[7])) do
            Wait(1)
        end
    
        RequestAnimDict("mini@strip_club@idles@bouncer@base")
        while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
            Wait(1)
        end
        ped = CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
        SetEntityHeading(ped, v[5])
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
        TriggerEvent("esx_utilities:add","UAV" .. _,"Press E to talk to the ~y~UAV Trooper",38,30.0,1,vector3(v[1],v[2],v[3]),{x = 1.55, y = 1.55, z = 0.5},{r = 0, g = 250, b = 0},GetCurrentResourceName())

    end

end)
Citizen.CreateThread(function()
    for _,v in pairs(ConfigCL.locations) do
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                local pos = GetEntityCoords(GetPlayerPed(-1), true)
                x = v[1]
                y = v[2]
                z = v[3]
                if(Vdist(pos.x, pos.y, pos.z, x, y, z) < 20.0)then
                    DrawText3D(x,y,z+2.10, "~g~"..v[4], 1.2, 1)
                else
                    local amount = 100*Vdist(pos.x, pos.y, pos.z, x, y, z)
                    if amount > 5000 then
                        Wait(5000)
                    else
                        Wait(amount)
                    end
                end
            end
        end)
    end
end)

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