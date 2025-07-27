function ShowTimer(text, time)
	SendNUIMessage({
		action = 'showTimer',
		text = text,
		time = time
	})
end

function ShowCommand(command, description)
	SendNUIMessage({
		action = 'showCommand',
		command = command,
		description = description
	})
end

function ShowKey(key, description)
	SendNUIMessage({
		action = 'showKey',
		key = key,
		description = description
	})
end

CreateThread(function ()
	local timer = GetGameTimer() + 3000;
	while timer > GetGameTimer() do
		Wait(0);
		ShowKey('F1', 'Open the menu');
	end
end)

exports('ShowTimer', ShowTimer);
exports('ShowCommand', ShowCommand);
exports('ShowKey', ShowKey);