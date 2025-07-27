function AddTip(message, duration, isStaff)
	SendNUIMessage({
		action = "add-tip",
		message = message,
		duration = not isStaff and duration or 100000000000,
	})
end

function PlayerLoaded()
	Wait(2000);

	while GetEntityModel(PlayerPedId()) ~= `mp_m_freemode_01` and GetEntityModel(PlayerPedId()) ~= `mp_f_freemode_01` do
		Wait(1000);
	end

	ESX = exports['es_extended']:getSharedObject();
	while not ESX do
		Wait(1000);
	end

	while not ESX.IsPlayerLoaded() do
		Wait(1000);
	end

	while ESX.GetPlayerData().job == nil do
		Wait(1000);
	end


	AddTip("You can type /bf400", 5 * 60 * 1000);
	AddTip('You can type /spawn_mafia', 5 * 60 * 1000);
	AddTip('You can type /hideapartments', 5 * 60 * 1000);
	AddTip('You can type /hidegarages', 5 * 60 * 1000);
	AddTip('You can type /home', 5 * 60 * 1000);
	AddTip('You can type /openfps', 5 * 60 * 1000);	
	AddTip('You can type /togglejobblips', 5 * 60 * 1000);
end

exports('AddTip', AddTip);
CreateThread(PlayerLoaded);