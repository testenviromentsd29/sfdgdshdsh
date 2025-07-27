ESX = nil

local PlayerData = {}
local group = nil
local active = true

local chatsStatus = {
	["adv"] = true,
	["trade"] = true,
	["anon"] = true,
	["twt"] = true,
	["insta"] = true,
	["OOC"] = true,
	["dark"] = true,
	["rob"] = true,
	["ellas"] = true,
	["army"] = true,
	["army2"] = true,
	["ch_a"] = true,
}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
	
    while ESX.GetPlayerData().job == nil do
        Wait(100)
    end
	
    PlayerData = ESX.GetPlayerData()
	
	local chat_options = GetResourceKvpString('chat_options')
	
	if chat_options then
		chatsStatus = json.decode(chat_options)
	end

	SetTimeout(15000, function()
		if chatsStatus['insta'] == nil then
			chatsStatus['insta'] = true
		end
		TriggerEvent('gcPhone:updateInstaNotStatus', chatsStatus['insta'])
	end)
	
	Wait(15000)
	ESX.TriggerServerCallback('esx_rpchat:getGroup', function(user)
		group = user
	end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)


RegisterCommand('togglechat', function()

	if active then
		active = false
		ESX.ShowNotification("Απενεργοποιήσες το Chat")
	else
		active = true
		ESX.ShowNotification("Ενεργοποιήσες το Chat")
	end

end)

function getStatus(status)
	if status == true then
		return "<font color='green'>Enabled</font>"
	else
		return "<font color='red'>Disabled</font>"
	end
end

RegisterCommand("chat", function()
	openChatMen()
end)

function openChatMen()
	local elements = {
		{label = "Advertisments " .. getStatus(chatsStatus["adv"]), value = "adv"},
		{label = "Trade " .. getStatus(chatsStatus["trade"]), value = "trade"},
		{label = "Anon " .. getStatus(chatsStatus["anon"]), value = "anon"},
		{label = "Tweet " .. getStatus(chatsStatus["twt"]), value = "twt"},
		{label = "Instagram " .. getStatus(chatsStatus["insta"]), value = "insta"},
		{label = "OOC " .. getStatus(chatsStatus["OOC"]), value = "OOC"},
		{label = "Dark " .. getStatus(chatsStatus["dark"]), value = "dark"},
		{label = "Rob " .. getStatus(chatsStatus["rob"]), value = "rob"},
		{label = "Ellas " .. getStatus(chatsStatus["ellas"]), value = "ellas"},
		{label = "Army " .. getStatus(chatsStatus["army"]), value = "army"},
		{label = "Army2 " .. getStatus(chatsStatus["army2"]), value = "army2"},
		{label = "Cityhall " .. getStatus(chatsStatus["ch_a"]), value = "ch_a"},
	}
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), '',
	{
		title		= 'Chat Status',
		align		= 'bottom-right',
		elements	= elements
	}, function(data, menu)
		if chatsStatus[data.current.value] ~= nil then
			chatsStatus[data.current.value] = not chatsStatus[data.current.value]
		else
			chatsStatus[data.current.value] = false
		end
		
		SetResourceKvp('chat_options', json.encode(chatsStatus))

		if data.current.value == 'insta' then
			TriggerEvent('gcPhone:updateInstaNotStatus', chatsStatus[data.current.value])
		end

		openChatMen()
	end,function(data, menu)
		menu.close()
	end)

end
RegisterNetEvent('esx_rpchat:advMsg')
AddEventHandler('esx_rpchat:advMsg', function(msg, source, playerName)
	if group == nil then
		return
	end
	if not chatsStatus["adv"] then
		return
	end
	if group == 'user' then
		if active then
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 255, 0 , 0.6); border-radius: 3px;"> @{Advertisment}: {0}</div> ',
				args = { msg }
			})
		end
	else
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 255, 0, 0.6); border-radius: 3px;"> @{Advertisment}[{0}][{1}]: {2}</div> ',
			args = { playerName, source, msg }
		})
	end
end)

RegisterNetEvent('esx_rpchat:robMsg')
AddEventHandler('esx_rpchat:robMsg', function(msg, source, playerName)
	if group == nil then
		return
	end
	
	if not chatsStatus["rob"] then
		return
	end
	
	if group == 'user' then
		if active then
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 64, 0, 0.6); border-radius: 3px;"><img src="https://pngimg.com/uploads/balaclava/balaclava_PNG44.png" width="20" height="20"></img> @{Robbery}: {0}</div> ',
				args = { msg }
			})
		end
	else
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 64, 0, 0.6); border-radius: 3px;"><img src="https://pngimg.com/uploads/balaclava/balaclava_PNG44.png" width="20" height="20"></img> @{Robbery}[{0}][{1}]: {2}</div> ',
			args = { playerName, source, msg }
		})
	end
end)

RegisterNetEvent('esx_rpchat:oocMsg')
AddEventHandler('esx_rpchat:oocMsg', function(msg, source, playerName)
	if group == nil then
		return
	end
	
	if not chatsStatus["OOC"] then
		return
	end
	
	if group == 'user' then
		if active then
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(107, 107, 106, 0.6); border-radius: 3px;"> @{OOC}: {0}</div> ',
				args = { msg }
			})
		end
	else
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(107, 107, 106, 0.6); border-radius: 3px;"> @{OOC}[{0}][{1}]: {2}</div> ',
			args = { playerName, source, msg }
		})
	end
end)

RegisterNetEvent('esx_rpchat:mafiaMsg')
AddEventHandler('esx_rpchat:mafiaMsg', function(msg, source, playerName, job)
	if group == nil then
		return
	end
	
	if group == 'user' then
		if active then
			if (PlayerData.job.name == job or PlayerData.job2.name == job) then
				TriggerEvent('chat:addMessage', {
					template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(151, 156, 152, 0.5); border-radius: 23px;"><i class="fas fa-skull-crossbones"></i>  @{MAFIA}: {0}</div> ',
					args = { msg }
				})
			end
		end
	else
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(151, 156, 152, 0.5); border-radius: 23px;"><i class="fas fa-skull-crossbones"></i>  @{MAFIA}[{0}][{1}]: {2}</div> ',
			args = { playerName, source, msg }
		})
	end
end)

RegisterNetEvent('esx_rpchat:Territory2')
AddEventHandler('esx_rpchat:Territory2', function(job,money,site)
	if active then
		if PlayerData.job.name ~= 'police' or PlayerData.job.name ~= 'police2' then
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(199, 0, 0, 0.6); border-radius: 5px;"><b>[{0}]</b> {1} claimed {2}$ from {3}</div> ',
				args = {"Territories", job,money,site}
			})
		end
	end
end)

RegisterNetEvent('esx_rpchat:Territory')
AddEventHandler('esx_rpchat:Territory', function(job,site)
	if active then
		if PlayerData.job.name ~= 'police' or PlayerData.job.name ~= 'police2' then
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(199, 0, 0, 0.6); border-radius: 5px;"><b>[{0}]</b> {1} now owns {2}</div> ',
				args = {"Territories", job,site}
			})
		end
	end
end)

RegisterNetEvent('esx_rpchat:tradeMsg')
AddEventHandler('esx_rpchat:tradeMsg', function(msg, source, playerName)
	if group == nil then
		return
	end
	if not chatsStatus["trade"] then
		return
	end
	if group == 'user' then
		if active then
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(27,141,42, 0.6); border-radius: 3px;"><i class="far fa-handshake"></i> @{Trade}: {0}</div> ',
				args = { msg }
			})
		end
	else
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(27,141,42, 0.6); border-radius: 3px;"><i class="far fa-handshake"></i> @{Trade}[{0}][{1}]: {2}</div> ',
			args = { playerName, source, msg }
		})
	end
end)

RegisterNetEvent('esx_rpchat:anonMsg')
AddEventHandler('esx_rpchat:anonMsg', function(msg, source, playerName, jobLabel)
	if group == nil then
		return
	end
	if not chatsStatus["anon"] then
		return
	end
	if group == 'user' and (PlayerData.job.name ~= 'police' or PlayerData.job.name ~= 'police2') then
		if active then
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(222, 9, 9, 0.6); border-radius: 3px;"><img src="https://i.ibb.co/sy4Pf3d/unnamed.png" width="20" height="20"></img> @{0}: {1}</div> ',
				args = { jobLabel, msg }
			})
		end
	elseif group ~= 'user' then
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(222, 9, 9, 0.6); border-radius: 3px;"><img src="https://i.ibb.co/sy4Pf3d/unnamed.png" width="20" height="20"></img> @{Anon}[{0}][{1}]: {2}</div> ',
			args = { playerName, source, msg }
		})
	end
end)

RegisterNetEvent('esx_rpchat:darkMsg')
AddEventHandler('esx_rpchat:darkMsg', function(msg, source, playerName)
	if group == nil then
		return
	end
	if not chatsStatus["dark"] then
		return
	end
	if group == 'user' and (PlayerData.job.name ~= 'police' or PlayerData.job.name ~= 'police2') then
		if active then
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(56, 56, 56, 0.6); border-radius: 3px;"><img src="https://i.ibb.co/sy4Pf3d/unnamed.png" width="20" height="20"></img> @{Dark}: {0}</div> ',
				args = { msg }
			})
		end
	elseif group ~= 'user' then
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(56, 56, 56, 0.6); border-radius: 3px;"><img src="https://i.ibb.co/sy4Pf3d/unnamed.png" width="20" height="20"></img> @{Dark}[{0}][{1}]: {2}</div> ',
			args = { playerName, source, msg }
		})
	end
end)

RegisterNetEvent('esx_rpchat:avocatMsg')
AddEventHandler('esx_rpchat:avocatMsg', function(msg, source, playerName)
	if group == nil then
		return
	end
	if group == 'user' then
		if active then
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(52, 73, 227, 0.8); border-radius: 3px;">Δικαστικο Μεγαρο: {0}</div> ',
				args = { msg }
			})
		end
	else
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(52, 73, 227, 0.8); border-radius: 3px;">Δικαστικο Μεγαρο[{0}][{1}]: {2}</div> ',
			args = { playerName, source, msg }
		})
	end
end)

RegisterNetEvent('esx_rpchat:cityhallMsg')
AddEventHandler('esx_rpchat:cityhallMsg', function(msg, source, playerName)
	if group == nil then
		return
	end
	if group == 'user' then
		if active then
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(224, 124, 29, 0.8); border-radius: 3px;">Δημαρχείο: {0}</div> ',
				args = { msg }
			})
		end
	else
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(224, 124, 29, 0.8); border-radius: 3px;">Δημαρχείο[{0}][{1}]: {2}</div> ',
			args = { playerName, source, msg }
		})
	end
end)

RegisterNetEvent('esx_rpchat:cityhallMsg2')
AddEventHandler('esx_rpchat:cityhallMsg2', function(msg, source, playerName)
	if group == nil then
		return
	end
	if group == 'user' then
		if active then
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 135, 50, 0.8); border-radius: 3px;">Ανακοινώσεις Υπουργείου Οικονομικών: {0}</div> ',
				args = { msg }
			})
		end
	else
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 135, 50, 0.8); border-radius: 3px;">Ανακοινώσεις Υπουργείου Οικονομικών[{0}][{1}]: {2}</div> ',
			args = { playerName, source, msg }
		})
	end
end)

RegisterNetEvent('esx_rpchat:policeChat')
AddEventHandler('esx_rpchat:policeChat', function(msg, playerName)
	if group == nil then
		return
	end
	if active and PlayerData and PlayerData.job and (PlayerData.job.name == "police" or PlayerData.job.name == "police2") then
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(14, 14, 230, 0.8); border-radius: 3px;"><img src="https://upload.wikimedia.org/wikipedia/el/thumb/a/ac/Greek_police_logo.svg/1200px-Greek_police_logo.svg.png" width="20" height="20"></img> Κέντρο ΕΛ.ΑΣ - {0}: {1}</div> ',
			args = { playerName, msg }
		})
	end
end)

RegisterNetEvent('esx_rpchat:armyMsg')
AddEventHandler('esx_rpchat:armyMsg', function(msg, source, playerName)
	if group == nil then
		return
	end
	
	if not chatsStatus["army"] then
		return
	end
	
	if group == 'user' then
		if active then
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(2, 115, 14, 0.8); border-radius: 3px;"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/HellenicArmySeal.svg/1200px-HellenicArmySeal.svg.png" width="20" height="20"></img> Ανακοίνωση Στρατου: {0}</div> ',
				args = { msg }
			})
		end
	else
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(2, 115, 14, 0.8); border-radius: 3px;"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/HellenicArmySeal.svg/1200px-HellenicArmySeal.svg.png" width="20" height="20"></img> Ανακοίνωση Στρατου[{0}][{1}]: {2}</div> ',
			args = { playerName, source, msg }
		})
	end
end)
RegisterNetEvent('esx_rpchat:army2Msg')
AddEventHandler('esx_rpchat:army2Msg', function(msg, source, playerName)
	if group == nil then
		return
	end
	
	if not chatsStatus["army2"] then
		return
	end
	
	if group == 'user' then
		if active then
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(2, 115, 14, 0.8); border-radius: 3px;"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/HellenicArmySeal.svg/1200px-HellenicArmySeal.svg.png" width="20" height="20"></img> Ανακοίνωση Στρατου: {0}</div> ',
				args = { msg }
			})
		end
	else
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(2, 115, 14, 0.8); border-radius: 3px;"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/HellenicArmySeal.svg/1200px-HellenicArmySeal.svg.png" width="20" height="20"></img> Ανακοίνωση Στρατου[{0}][{1}]: {2}</div> ',
			args = { playerName, source, msg }
		})
	end
end)

RegisterNetEvent('esx_rpchat:ellasMsg')
AddEventHandler('esx_rpchat:ellasMsg', function(msg, source, playerName)
	if group == nil then
		return
	end
	
	if not chatsStatus["ellas"] then
		return
	end
	
	if group == 'user' then
		if active then
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(14, 14, 230, 0.8); border-radius: 3px;"><img src="https://upload.wikimedia.org/wikipedia/el/thumb/a/ac/Greek_police_logo.svg/1200px-Greek_police_logo.svg.png" width="20" height="20"></img> Ανακοίνωση ΕΛ.ΑΣ: {0}</div> ',
				args = { msg }
			})
		end
	else
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(14, 14, 230, 0.8); border-radius: 3px;"><img src="https://upload.wikimedia.org/wikipedia/el/thumb/a/ac/Greek_police_logo.svg/1200px-Greek_police_logo.svg.png" width="20" height="20"></img> Ανακοίνωση ΕΛ.ΑΣ[{0}][{1}]: {2}</div> ',
			args = { playerName, source, msg }
		})
	end
end)

RegisterNetEvent('esx_rpchat:sdoeMsg')
AddEventHandler('esx_rpchat:sdoeMsg', function(msg, source, playerName)
	if group == nil then
		return
	end
	if group == 'user' then
		if active then
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(14, 14, 230, 0.8); border-radius: 3px;"><img src="https://i.imgur.com/LyhtZoC.png" width="20" height="20"></img> Ανακοίνωση Σ.Δ.Ο.Ε.: {0}</div> ',
				args = { msg }
			})
		end
	else
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(14, 14, 230, 0.8); border-radius: 3px;"><img src="https://i.imgur.com/LyhtZoC.png" width="20" height="20"></img> Ανακοίνωση Σ.Δ.Ο.Ε.[{0}][{1}]: {2}</div> ',
			args = { playerName, source, msg }
		})
	end
end)

RegisterNetEvent('esx_rpchat:ekavMsg')
AddEventHandler('esx_rpchat:ekavMsg', function(msg, source, playerName)
	if group == nil then
		return
	end
	if group == 'user' then
		if active then
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(219, 230, 14, 0.8); border-radius: 3px;"><img src="https://upload.wikimedia.org/wikipedia/el/4/44/EKAB_logo.png" width="20" height="20"></img> Ανακοίνωση ΕΚΑΒ: {0}</div> ',
				args = { msg }
			})
		end
	else
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(219, 230, 14, 0.8); border-radius: 3px;"><img src="https://upload.wikimedia.org/wikipedia/el/4/44/EKAB_logo.png" width="20" height="20"></img> Ανακοίνωση ΕΚΑΒ[{0}][{1}]: {2}</div> ',
			args = { playerName, source, msg }
		})
	end
end)

RegisterNetEvent('esx_rpchat:twtMsg')
AddEventHandler('esx_rpchat:twtMsg', function(msg, source, playerName, rpName)
	if group == nil then
		return
	end
	if not chatsStatus["twt"] then
		return
	end
	if group == 'user' then
		if active then
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 200, 255, 0.6); border-radius: 3px;"><img src="https://i.ibb.co/dBFxFjM/twt.png" width="20" height="20"></img> @{0}: {1}</div> ',
				args = { rpName, msg }
			})
		end
	else
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 200, 255, 0.6); border-radius: 3px;"><img src="https://i.ibb.co/dBFxFjM/twt.png" width="20" height="20"></img> @{TWT}[{0}][{1}]: {2}</div> ',
			args = { playerName, source, msg }
		})
	end
end)