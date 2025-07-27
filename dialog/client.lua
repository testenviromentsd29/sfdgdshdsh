local answer
local antiSpam = 0
local onGoingDialog = false

function CreateDialog(title, desc, pricetxt, price, decision, submit, cancel)
	if antiSpam > GetGameTimer() then
		return false
	end
	
	antiSpam = GetGameTimer() + 250
	
	if onGoingDialog then
		answer = {action = 'cancel'}
		Wait(100)
	end
	
	onGoingDialog = true
	answer = nil
	
	local title = title or ''
	local desc = desc or ''
	local pricetxt = pricetxt or ''
	local price = price or ''
	
	SetNuiFocus(true, true)
	
	SendNUIMessage({
		action = 'show',
		title = title,
		desc = desc,
		pricetxt = pricetxt,
		price = price,
		decision = decision,
		submit = submit,
		cancel = cancel,
	})
	
	return true
end

RegisterNUICallback('submit', function(data, cb)
	SetNuiFocus(false, false)
	SendNUIMessage({action = 'hide'})
	
	answer = data
	onGoingDialog = false
	
	cb('ok')
end)

RegisterNUICallback('cancel', function(data, cb)
	SetNuiFocus(false, false)
	SendNUIMessage({action = 'hide'})
	
	answer = {action = 'cancel'}
	onGoingDialog = false
	
	cb('ok')
end)

exports('Create', function(title, desc, pricetxt, price, submit, cancel)
	if CreateDialog(title, desc, pricetxt, price, nil, submit, cancel) then
		while answer == nil do
			Wait(0)
		end
		
		return answer
	end
	
	return nil
end)

exports('Decision', function(title, desc, pricetxt, submit, cancel)
	if CreateDialog(title, desc, pricetxt, '', true, submit, cancel) then
		while answer == nil do
			Wait(0)
		end
		
		return answer
	end
	
	return nil
end)

exports('Close', function()
	SetNuiFocus(false, false)
	SendNUIMessage({action = 'hide'})
	
	answer = {action = 'cancel'}
	onGoingDialog = false
end)