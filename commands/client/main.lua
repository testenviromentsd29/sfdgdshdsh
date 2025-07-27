RegisterCommand("commands", function()
	SetNuiFocus(true, true)
	SendNUIMessage({action = "show"})
end)

RegisterNUICallback("quit", function()
	SetNuiFocus(false, false)
end)

RegisterNUICallback("send", function(data)
	SetNuiFocus(false, false)
	Wait(500)
	ExecuteCommand(data)
end)