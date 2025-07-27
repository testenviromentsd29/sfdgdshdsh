local GlobalAnswer = nil;
local IsDialogOpen = false;

function OpenDialog(question, text)
	if IsDialogOpen then
		return nil;
	end

	IsDialogOpen = true;
	SendNUIMessage({
		action = 'open';
		question = question;
		text = text or ''
	})
	SetNuiFocus(true, true);

	while IsDialogOpen and GlobalAnswer == nil do
		Wait(0);
	end

	local answer = GlobalAnswer;
	GlobalAnswer = nil;

	return answer;
end

function OnSubmit(data)
	GlobalAnswer = data and data.val or nil;
	IsDialogOpen = false;
	SetNuiFocus(false, false);
end

RegisterNuiCallback('submit', OnSubmit);
exports('OpenDialog', OpenDialog);
