function setBleedingOn(ped)

    SetEntityHealth(ped,GetEntityHealth(ped)-2)
    StartScreenEffect('Rampage', 0, true)
    ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
    InfoRanny("~r~You need medical help!")
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
    Wait(15000)
 
 end
 
 function setBleedingOff(ped)
    StopScreenEffect('Rampage')
    --SetPlayerHealthRechargeMultiplier(PlayerId(), 1.0)
 end
 
Citizen.CreateThread(function()
   while true do
      Wait(1000)
      local player = GetPlayerPed(-1)
      local Health = GetEntityHealth(player)

      if Health <= 119  then
         setBleedingOn(player)
         
      elseif Health > 120 then
         setBleedingOff(player)
      end
   end
end)
  
function InfoRanny(text)
   SetNotificationTextEntry("STRING")
   AddTextComponentString(text)
   DrawNotification(false, false)
end

Citizen.CreateThread(function()
   while true do
      Wait(100)
      SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
   end
end)