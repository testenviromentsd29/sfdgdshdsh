ctrl = {}  
local lastVeh,lastData  
  
ctrl.update = function()    
    Wait(1000)    
    SendNUIMessage({var='onChange',value='http://carcontrol/posted'})     
end  

AddEventHandler("justreleased",function(label,key)
	
    if key == 246 then
        local ped = PlayerPedId()
        local inVeh = IsPedInAnyVehicle(ped,false)      
        if inVeh then        
            Wait(GetFrameTime()*10)          
            local veh = GetVehiclePedIsIn(ped)          
            if lastVeh and veh == lastVeh then            
                ctrl.display(lastData)          
            else           
                lastData = nil           
                ctrl.display()         
            end         
            lastVeh = veh       
        end
    end

end)

RegisterNetEvent('carcontrol:opencontrols')
AddEventHandler('carcontrol:opencontrols', function()
    local ped = PlayerPedId()
    local inVeh = IsPedInAnyVehicle(ped,false)      
    if inVeh then        
        Wait(GetFrameTime()*10)          
        local veh = GetVehiclePedIsIn(ped)          
        if lastVeh and veh == lastVeh then            
            ctrl.display(lastData)          
        else           
            lastData = nil           
            ctrl.display()         
        end         
        lastVeh = veh       
    end
end)

ctrl.display = function(data)   
    local enable,states = ctrl.getStates((data or nil))   
    ctrl.msg('SetEnabledOptions',enable)   
    ctrl.msg('SetCheckedOptions',states)   
    ctrl.msg('SetAlpha',{[0]=1})   
    ctrl.focus(true)  
end  

local gotOptions = false  
ctrl.refresh = function(options)  
    windows = {    [8]  = gotOptions['8'],    [9]  = gotOptions['9'],    [10] = gotOptions['10'],    [11] = gotOptions['11'],  }   
    local enable,states = ctrl.getStates(windows)  
    ctrl.msg('SetEnabledOptions',enable)  
    ctrl.msg('SetCheckedOptions',states)  
    gotOptions = false  
end  

ctrl.getStates = function(windows)   
    local veh = GetVehiclePedIsIn(GetPlayerPed(-1),false)   
    local driving = (GetPedInVehicleSeat(veh,-1) == GetPlayerPed(-1))   
    local inFront = (GetPedInVehicleSeat(veh,0) == GetPlayerPed(-1))    
    local states = {}    
    tick = 0   
    for i=tick,tick+3,1 do 
        states[i] = (GetPedInVehicleSeat(veh,i-tick-1) ~= 0 and true or false); 
    end    
    tick = tick + 4   
    for i=tick,tick+3,1 do     
        states[i] = (DoesVehicleHaveDoor(veh,i-tick) and GetVehicleDoorAngleRatio(veh,i-tick) ~= 0.0 or false);    
    end    
    tick = tick + 4   
    for i=tick,tick+3,1 do     
        local win = (windows and windows[i].checked)     
        if win == nil then 
            win = (RollUpWindow(veh,i-tick-1) and false); 
        end     
        states[i] = win;   
    end    
    tick = tick + 4   
    for i=tick,tick+3,1 do      
        states[i] = (DoesVehicleHaveDoor(veh,i-tick+4) and GetVehicleDoorAngleRatio(veh,i-tick+4) ~= 0.0 or false);    
    end     
    tick = tick + 3   
    states[tick] = GetIsVehicleEngineRunning(veh)   
    states[tick+1] = IsVehicleInteriorLightOn(veh)    
    local enable = {}   
    tick = 0   
    for i=tick,tick+3,1 do      
        if i-tick > 1 then       
            if not driving or not inFront then         
                enable[i] = (IsVehicleSeatFree(veh,i-tick-1) or false);        
            else         
                enable[i] = false        
            end     
        else       
            if driving or inFront then         
                enable[i] = (IsVehicleSeatFree(veh,i-tick-1) or false);       
            else         
                enable[i] = false        
            end     
        end    
    end    
    tick = tick + 4   
    for i=tick,tick+3,1 do      
        if i-tick > 1 then       
            if not driving or not inFront then         
                enable[i] = (DoesVehicleHaveDoor(veh,i-tick) or false);       
            else        
                enable[i] = false        
            end     
        else       
            if driving or inFront then         
                enable[i] = (DoesVehicleHaveDoor(veh,i-tick) or false);        
            else         
                enable[i] = false        
            end     
        end   
    end    
    tick = tick + 4   
    for i=tick,tick+3,1 do     
        local win = (windows and windows[i].enabled)     
        if win == nil then 
            win = (IsVehicleWindowIntact(veh,i-tick-1) or false); 
        end     
        if i-tick > 1 then       
            if not driving or not inFront then         
                enable[i] = (DoesVehicleHaveDoor(veh,i-tick) or false);        
            end     
        else       
            if driving or inFront then         
                enable[i] = (DoesVehicleHaveDoor(veh,i-tick) or false);       
            end     
        end   
    end    
    tick = tick + 4   
    for i=tick,tick+3,1 do     
        enable[i] = ((driving or inFront) and DoesVehicleHaveDoor(veh,i-tick+4) or false);    
    end   
    tick = tick + 3    
    enable[tick] = ((driving or inFront) and GetVehicleEngineHealth(veh) > 0 or false)   
    enable[tick+1] = true   
    return enable,states  
end  

ctrl.msg = function(f,a)   
    SendNUIMessage({     func = f,     args = a   })  
end  

ctrl.focus = function(f)   
    SetNuiFocus(f,f)  
end  

ctrl.setDoor = function(d,s)   
    local v = GetVehiclePedIsIn(GetPlayerPed(-1),false)   
    if s then     SetVehicleDoorOpen(v,d.door,false,false)   
    else     
        SetVehicleDoorShut(v,d.door,false,false)   
    end  
end  

ctrl.setSeat = function(d,s)   
    local v = GetVehiclePedIsIn(GetPlayerPed(-1),false)   
    if IsVehicleSeatFree(v,d.seat) then     
        TaskWarpPedIntoVehicle(GetPlayerPed(-1),v,d.seat)   
    end   
    lastData = gotOptions   
    gotOptions = false   
    SendNUIMessage({var='options',ret='http://carcontrol/gotOpts'})   
    while not gotOptions do Wait(0); end   
    ctrl.refresh(gotOptions); 
end   

ctrl.setWindow = function(d,s)   
    local v = GetVehiclePedIsIn(GetPlayerPed(-1),false)   
    if s then
        RollDownWindow(v,d.window)   
    else     
        RollUpWindow(v,d.window)   
    end   
    SendNUIMessage({var='options',ret='http://carcontrol/gotOpts'})  
end  

ctrl.setEngine = function(d,s)
    local v = GetVehiclePedIsIn(GetPlayerPed(-1),false)
    if GetIsVehicleEngineRunning(v) then
        TriggerEvent('esx:showNotification', 'Engine Off')
        SetVehicleEngineOn(v, false, false, true)
    else
        TriggerEvent('esx:showNotification', 'Engine On')
        SetVehicleEngineOn(v, true, false, false)
    end
end  

ctrl.setIntLight = function(d,s)   
    local v = GetVehiclePedIsIn(GetPlayerPed(-1),false)    
    SetVehicleInteriorlight(v,s) 
end  

ctrl.cbIds = {    [0] = {seat = -1, func = ctrl.setSeat},   [1] = {seat = 0, func = ctrl.setSeat},    [2] = {seat = 1, func = ctrl.setSeat},    [3] = {seat = 2, func = ctrl.setSeat},    [4] = {door = 0, func = ctrl.setDoor},    [5] = {door = 1, func = ctrl.setDoor},    [6] = {door = 2, func = ctrl.setDoor},    [7] = {door = 3, func = ctrl.setDoor},    [8] = {window = 0, func = ctrl.setWindow},    [9] = {window = 1, func = ctrl.setWindow},    [10] = {window = 2, func = ctrl.setWindow},    [11] = {window = 3, func = ctrl.setWindow},    [12] = {door = 4, func = ctrl.setDoor},    [13] = {door = 5, func = ctrl.setDoor},    [14] = {door = 6, func = ctrl.setDoor},    [15] = {func = ctrl.setEngine},    [16] = {func = ctrl.setIntLight}, }   

ctrl.posted = function(args)    
    local f = ctrl.cbIds[args.id]    
    f.func(f,args.checked)  
end   

ctrl.gotOpts = function(o)    
    lastData = {      [8] = o['8'],      [9] = o['9'],      [10] = o['10'],      [11] = o['11'],    }    
    if not gotOptions then 
        gotOptions = o 
    end  
end   

ctrl.close = function()    
    ctrl.focus(false)    
    ctrl.msg('SetAlpha',{[0]=0})  
end   

RegisterNUICallback('posted',ctrl.posted)  
RegisterNUICallback('gotOpts', ctrl.gotOpts)  
RegisterNUICallback('close', ctrl.close)   

RegisterNetEvent('carcontrol:open')
AddEventHandler('carcontrol:open', function()
    local ped = GetPlayerPed(-1)    
    local inVeh = IsPedInAnyVehicle(ped,false)    
    if inVeh then       
        local veh = GetVehiclePedIsIn(ped)      
        if lastVeh and lastData and veh == lastVeh then        
            ctrl.display(lastData)      
        else       
            lastData = nil       
            ctrl.display()     
        end     
        lastVeh = veh   
    end 
end)

exports('OpenUI', function(...)     
    local ped = GetPlayerPed(-1)    
    local inVeh = IsPedInAnyVehicle(ped,false)    
    if inVeh then       
        local veh = GetVehiclePedIsIn(ped)      
        if lastVeh and lastData and veh == lastVeh then        
            ctrl.display(lastData)      
        else       
            lastData = nil       
            ctrl.display()     
        end     
        lastVeh = veh   
    end 
end)  

exports('CloseUI', function(...)     
    ctrl.close() 
end)  

Citizen.CreateThread(ctrl.update)