--This function shows a notification to the player
--@message	message to send to the player

function ShowNotification(message)
	if Config.UseESX then
		ESX.ShowNotification(message)
	elseif Config.UseQBUS then
		QBCore.Functions.Notify(message)
	else
		print(message)
	end
end

--This event shows a notification to the player (see server_functions.lua)
--@message	message to send to the player

RegisterNetEvent('doitdigital_music:showNotification')
AddEventHandler('doitdigital_music:showNotification', function(message)
	ShowNotification(message)
end)