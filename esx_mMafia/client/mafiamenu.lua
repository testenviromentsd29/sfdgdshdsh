Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

local mafiamenuopen = false
local PlayerData = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

function getReason(errorNumber)
	if errorNumber == 1 then
		reason = " dying" 
	elseif errorNumber == 2 then
		reason = " going to jail"
	elseif errorNumber == 3 then
		reason = " killing an enemy"
	end
	
	return reason
end

RegisterNetEvent("esx_mMafia:doYouWantToJoin")
AddEventHandler('esx_mMafia:doYouWantToJoin',function(mafianame)
	ESX.UI.Menu.CloseAll()
	local elements = {}
	table.insert(elements,{label = "Yes", value = "yes"})
	table.insert(elements,{label = "No", value = "no"})
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mafia_menu', {
		title    = 'Do you want to join the job?',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		local elements2 = {}
		table.insert(elements2,{label = PlayerData.job.label, value = "job1"})
		table.insert(elements2,{label = PlayerData.job2.label, value = "job2"})
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mafia_menu2s', {
			title    = 'Which job do you want to replace?',
			align    = 'bottom-right',
			elements = elements2
		}, function(data2, menu2)
				TriggerServerEvent("esx_mMafia:addPlayer", mafianame, data2.current.value)
				menu2.close()
				menu.close()

		end,function(data2,menu2)
			menu2.close()
		end)
	end,function(data,menu)
		menu.close()
	end)

end)

RegisterNetEvent('esx_mMafia:openMenu')
AddEventHandler('esx_mMafia:openMenu',function()

	ESX.TriggerServerCallback('esx_mMafia:getMafiaPoints', function(points,rank,anansweredwars,black_money)
		
		mafiamenuopen = true
		if points == nil then
			points = 0
		end
		if rank == nil then
			rank = 0
		end
	
		SetNuiFocus(true,true)
	
		SendNUIMessage({
			action = "enablemenu",
			points = points,
			rank = rank,
			job = PlayerData.job.label,
			black_money = black_money
		})
			
		
	end)
end)


RegisterCommand('skins', function()
	
	local elements = {}
	
    table.insert(elements, {label = 'Default Skin', value = 'default'})
    Wait(100)
    for i=1, #ConfigCL.Mafia.Data do
        if ConfigCL.Mafia.Data[i].job == PlayerData.job.name then
            table.insert(elements, {label = PlayerData.job.label..' Skin for '..ConfigCL.Mafia.Data[i].type, value = 'mafia', skin = ConfigCL.Mafia.Data[i].skin, clip = ConfigCL.Mafia.Data[i].clip}) 
        end
    end
    ESX.UI.Menu.CloseAll()
    Wait(100)
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'action', {
        title    = "Choose Action",
        align    = 'left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'default' then
            for i=1, #ConfigCL.Mafia.Data do
                if ConfigCL.Mafia.Data[i].job == PlayerData.job.name then
                    if HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), GetHashKey(ConfigCL.Mafia.Data[i].skin)) then
                        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), GetHashKey(ConfigCL.Mafia.Data[i].skin))
                    end
                    if HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), GetHashKey(ConfigCL.Mafia.Data[i].clip)) then
                        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), GetHashKey(ConfigCL.Mafia.Data[i].clip))
                    end
                end
            end
        elseif data.current.value == 'mafia' then
            if data.current.clip ~= nil then
                GiveWeaponComponentToPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), GetHashKey(data.current.skin))
                GiveWeaponComponentToPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), GetHashKey(data.current.clip))
            else
                GiveWeaponComponentToPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), GetHashKey(data.current.skin))
            end
        end
        menu.close()
    end, function(data, menu)
		menu.close()
	end)


end)

RegisterNUICallback("mafia_skins", function()
	SetNuiFocus(false,false)
	mafiamenuopen = false
	
	local elements = {}
	
    table.insert(elements, {label = 'Default Skin', value = 'default'})
    Wait(100)
    for i=1, #ConfigCL.Mafia.Data do
        if ConfigCL.Mafia.Data[i].job == PlayerData.job.name then
            table.insert(elements, {label = PlayerData.job.label..' Skin for '..ConfigCL.Mafia.Data[i].type, value = 'mafia', skin = ConfigCL.Mafia.Data[i].skin, clip = ConfigCL.Mafia.Data[i].clip}) 
        end
    end
    ESX.UI.Menu.CloseAll()
    Wait(100)
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'action', {
        title    = "Choose Action",
        align    = 'left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'default' then
            for i=1, #ConfigCL.Mafia.Data do
                if ConfigCL.Mafia.Data[i].job == PlayerData.job.name then
                    if HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), GetHashKey(ConfigCL.Mafia.Data[i].skin)) then
                        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), GetHashKey(ConfigCL.Mafia.Data[i].skin))
                    end
                    if HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), GetHashKey(ConfigCL.Mafia.Data[i].clip)) then
                        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), GetHashKey(ConfigCL.Mafia.Data[i].clip))
                    end
                end
            end
        elseif data.current.value == 'mafia' then
            if data.current.clip ~= nil then
                GiveWeaponComponentToPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), GetHashKey(data.current.skin))
                GiveWeaponComponentToPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), GetHashKey(data.current.clip))
            else
                GiveWeaponComponentToPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), GetHashKey(data.current.skin))
            end
        end
        menu.close()
    end, function(data, menu)
		menu.close()
	end)

end)

RegisterNUICallback("view_members", function()
	SetNuiFocus(false,false)
	mafiamenuopen = false
	TriggerEvent('esx_society:openBossMenu', PlayerData.job.name, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = "Open Boss Menu"
		CurrentActionData = {}
	end, { wash = false, withdraw = false, deposit = false, }) -- disable washing money
	--[[ ESX.TriggerServerCallback('esx_mMafia:getMafia', function(mafia)
		local members = {}
		for i=1, #mafia do
			
			if mafia[i].boss then
				table.insert(members, {label=mafia[i].name .. ' - ' .. 'Boss', value= mafia[i].identifier})
			else
				table.insert(members, {label=mafia[i].name, value= mafia[i].identifier})
			end
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mafia_menu_members', {
			title    = 'Mafia Members',
			align    = 'bottom-right',
			elements = members
		}, function(data2, menu2)
			local options = {}
			table.insert(options,{label = "Yes", value = "yes"})
			table.insert(options,{label = "No", value = "no"})
			local ident = data2.current.value
			menu2.close()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mafia_menu_members_fire', {
				title    = 'Are you sure you want to fire?',
				align    = 'bottom-right',
				elements = options
			}, function(data3, menu3)
				if data3.current.value == "yes" then
					TriggerServerEvent('esx_mMafia:firePlayer', ident)
				end
				menu3.close()
			end,
			function(data3,menu3)
				menu3.close()
			end)
		end,
		function(data2,menu2)
			menu2.close()
		end)
	end) ]]

end)

--[[RegisterNUICallback("add_members", function()
	SetNuiFocus(false,false)
	mafiamenuopen = false
	local coords = GetEntityCoords(GetPlayerPed(-1))
	local playersInArea = ESX.Game.GetPlayersInArea(coords, 10.0)
	local nearPlayers = {}
	for k,v in pairs(playersInArea) do
		if v ~= PlayerId() then
			table.insert(nearPlayers, {label=GetPlayerName(v), value=GetPlayerServerId(v)})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mafia_menu_members_add', {
		title    = 'Add Members',
		align    = 'bottom-right',
		elements = nearPlayers
	}, function(data2, menu2)
		local options = {}
		table.insert(options,{label = "Yes", value = "yes"})
		table.insert(options,{label = "No", value = "no"})
		local ident = data2.current.value
		menu2.close()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mafia_menu_members_addcheck', {
			title    = 'Are you sure you want to add?',
			align    = 'bottom-right',
			elements = options
		}, function(data3, menu3)
			if data3.current.value == "yes" then
				TriggerServerEvent('esx_mMafia:askPlayerToJoin', ident)
			end
			menu3.close()
		end,
		function(data3,menu3)
			menu3.close()
		end)
	end,
	function(data2,menu2)
		menu2.close()
	end)
end)]]

--[[RegisterNUICallback("check_members", function()
	SetNuiFocus(false,false)
	mafiamenuopen = false
	ESX.TriggerServerCallback('esx_mMafia:getMafia', function(mafia)
		local members = {}
		for i=1, #mafia do
			table.insert(members, {label=mafia[i].name, value = mafia[i].identifier})
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mafia_menu_members', {
			title    = 'Member Stats',
			align    = 'bottom-right',
			elements = members
		}, function(data2, menu2)
			ESX.TriggerServerCallback('esx_mMafia:getMafiaMemberInfo', function(mafiamemberstats)
				local memberStats = {}
				if mafiamemberstats[1] then
					table.insert(memberStats, {label = '<font color="green">'.. mafiamemberstats[1].name .. ' added ' .. mafiamemberstats[1].pointsEarned .. ' points', value = "" })
					table.insert(memberStats, {label = '<font color="red">'.. mafiamemberstats[1].name .. ' lost ' .. mafiamemberstats[1].pointsLost .. ' points', value = ""})
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mafia_menu_members', {
						title    = 'Member Stats',
						align    = 'bottom-right',
						elements = memberStats
					}, function(data3, menu3)
						menu3.close()
					end,
					function(data3,menu3)
						menu3.close()
					end)
				else
					ESX.ShowNotification("Stats don't exist")
				end
			end, data2.current.value)
		end,
		function(data2,menu2)
			menu2.close()
		end)
	end)
end)]]

--[[RegisterNUICallback("rank_up", function()
	SetNuiFocus(false,false)
	mafiamenuopen = false
	TriggerServerEvent("esx_mMafia:rankup") 
end)]]

--[[RegisterNUICallback("unlockables", function()
	SetNuiFocus(false,false)
	mafiamenuopen = false
	
	ESX.TriggerServerCallback('esx_mMafia:getJobData', function(data)
		local elements = {}
		
		for i=1, #ConfigCL.Unlockables, 1 do
			if data.rank >= ConfigCL.Unlockables[i].level then
				table.insert(elements, {label = '<font color="green">['..ConfigCL.Unlockables[i].level..'] '..ConfigCL.Unlockables[i].label..' <span style="float:right">$'..ConfigCL.Unlockables[i].price..'</span></font>',	value = i})
			else
				table.insert(elements, {label = '<font color="red">['..ConfigCL.Unlockables[i].level..'] '..ConfigCL.Unlockables[i].label..' <span style="float:right">$'..ConfigCL.Unlockables[i].price..'</span></font>'})
			end
		end
		
		ESX.UI.Menu.CloseAll()
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'unlockables', {
			title    = 'Unlockables',
			align    = 'center',
			elements = elements,
		},
		function(data, menu)
			local id = data.current.value
			
			if id then
				menu.close()
				TriggerServerEvent('esx_mMafia:unlockables', id)
			end
		end,
		function(data, menu)
			menu.close()
		end)
	end, PlayerData.job.name)
end)]]

--[[RegisterNUICallback("view_alliances", function()
	SetNuiFocus(false,false)
	mafiamenuopen = false
	ESX.TriggerServerCallback('esx_mMafia:getMafiaΑlliances', function(alliances)
		local allianceElements = {}

		for i=1, #alliances do
	
			if alliances[i].status == "awaiting" and alliances[i].caller==PlayerData.job.name then
				table.insert(allianceElements, {label=alliances[i].ally .. ' - <font color="orange">Awaiting for them', value={answer="confirm", mafia=alliances[i].ally}})
			elseif alliances[i].status == "awaiting" and alliances[i].ally==PlayerData.job.name then
				table.insert(allianceElements, {label=alliances[i].caller .. ' - <font color="orange">Awaiting for you', value={answer="confirm", mafia=alliances[i].caller}})
			elseif alliances[i].status == "active" and alliances[i].caller==PlayerData.job.name or alliances[i].ally==PlayerData.job.name then
				if alliances[i].ally==PlayerData.job.name then
					table.insert(allianceElements, {label=alliances[i].caller .. ' - <font color="orange">Active', value={answer="end", mafia=alliances[i].caller}})
				else
					table.insert(allianceElements, {label=alliances[i].ally .. ' - <font color="orange">Active', value={answer="end", mafia=alliances[i].ally}})
				end
			end
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mafia_menu_members', {
			title    = 'Mafia Alliances',
			align    = 'bottom-right',
			elements = allianceElements
		}, function(data2, menu2)
			local options = {}
			local answer = data2.current.value.answer
			local otherMafia = data2.current.value.mafia
			table.insert(options,{label = "Yes", value = "yes"})
			table.insert(options,{label = "No", value = "no"})
			menu2.close()
			title = "Do you want to confirm alliance with them?"
			if answer == "end" then
				title = "Are you sure you want to end the alliance?"
			end
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mafia_menu_members_fire', {
				title    = title,
				align    = 'bottom-right',
				elements = options
			}, function(data3, menu3)
				if data3.current.value == "yes" then
					if answer == "confirm" then
						TriggerServerEvent('esx_mMafia:confirAlliance',otherMafia)
					elseif answer == "end" then
						TriggerServerEvent('esx_mMafia:endAlliance', otherMafia)
					end
				elseif data3.current.value == "no" then
					if answer == "confirm" then
						TriggerServerEvent('esx_mMafia:endAlliance', otherMafia)
					end
				end
				menu3.close()
			end,
			function(data3,menu3)
				menu3.close()
			end)
		end,
		function(data2,menu2)
			menu2.close()
		end)
	
	end)
end)]]

--[[RegisterNUICallback("view_wars", function()
	SetNuiFocus(false,false);
	mafiamenuopen = false;
	--ESX.ShowNotification("Coming at 10-12-2021");
	ESX.TriggerServerCallback('esx_mMafia:getMafiawars', function(wars)
		local warElements = {}

		for i=1, #wars do
			if wars[i].status == "awaiting" and wars[i].caller==PlayerData.job.name then
				table.insert(warElements, {label=wars[i].enemy .. ' - <font color="orange">Awaiting for them', value={answer="confirm", mafia=wars[i].enemy}})
			elseif wars[i].status == "awaiting" and wars[i].enemy==PlayerData.job.name then
				table.insert(warElements, {label=wars[i].caller .. ' - <font color="orange">Awaiting for you', value={answer="confirm", mafia=wars[i].caller}})
			elseif wars[i].status == "active" and wars[i].caller==PlayerData.job.name or wars[i].enemy==PlayerData.job.name then
				if wars[i].enemy==PlayerData.job.name then
					table.insert(warElements, {label=wars[i].caller .. ' - <font color="orange">Active', value={answer="end", mafia=wars[i].caller}})
				else
					table.insert(warElements, {label=wars[i].enemy .. ' - <font color="orange">Active', value={answer="end", mafia=wars[i].enemy}})
				end
			end
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mafia_menu_members', {
			title    = 'Mafia Wars',
			align    = 'bottom-right',
			elements = warElements
		}, function(data2, menu2)
			local options = {}
			local answer = data2.current.value.answer
			local otherMafia = data2.current.value.mafia
			table.insert(options,{label = "Yes", value = "yes"})
			table.insert(options,{label = "No", value = "no"})
			menu2.close()
			title = "Do you want to confirm the war against them?"
			if answer == "end" then
				title = "Are you sure you want to end the war?"
			end
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mafia_menu_members_fire', {
				title    = title,
				align    = 'bottom-right',
				elements = options
			}, function(data3, menu3)
				if data3.current.value == "yes" then
					if answer == "confirm" then
						TriggerServerEvent('esx_mMafia:confirmWar', "yes",otherMafia)
					elseif answer == "end" then
						TriggerServerEvent('esx_mMafia:endWar', otherMafia)
					end
				elseif data3.current.value == "no" then
					if answer == "confirm" then
						TriggerServerEvent('esx_mMafia:confirmWar',"no", otherMafia)
					end
				end
				menu3.close()
			end,
			function(data3,menu3)
				menu3.close()
			end)
		end,
		function(data2,menu2)
			menu2.close()
		end)
	
	end)
end)]]

--[[RegisterNUICallback("create_war", function()
	SetNuiFocus(false,false)
	--ESX.ShowNotification("Coming at 10-12-2021");
	mafiamenuopen = false
	
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'job_for_war', {title = "ID of player:"}, function(data, menu)
		local target = tonumber(data.value)
		
		if target and target ~= tonumber(GetPlayerServerId(PlayerId())) then
			if GetPlayerFromServerId(target) ~= -1 and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) < 5.0 then
				TriggerServerEvent("esx_mMafia:startWar", target)
				menu.close()
			else
				ESX.ShowNotification('There is no player with that ID near you.')
			end
		end
	end, function (data, menu)
		menu.close()
	end)
end)]]

--[[RegisterNUICallback("create_alliance", function()
	SetNuiFocus(false,false)
	--ESX.ShowNotification("Coming at 10-12-2021");
	mafiamenuopen = false
	
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'job_for_war', {title = "ID of player:"}, function(data, menu)
		local target = tonumber(data.value)
		
		if target and target ~= tonumber(GetPlayerServerId(PlayerId())) then
			if GetPlayerFromServerId(target) ~= -1 and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) < 5.0 then
				TriggerServerEvent("esx_mMafia:startAlliance", target)
				menu.close()
			else
				ESX.ShowNotification('There is no player with that ID near you.')
			end
		end
	end, function (data, menu)
		menu.close()
	end)
end)]]

--[[RegisterNUICallback('withdraw_money', function()
	mafiamenuopen = false
	SetNuiFocus(false,false)
	
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_money', {
		title = 'Enter the amount you want to withdraw'
	},
	function(data, menu)
		local amount = tonumber(data.value) or -1
		menu.close()
		TriggerServerEvent('esx_mMafia:withdrawMoney', amount)
	end,
	function(data, menu)
		menu.close()
	end)
end)]]

--[[RegisterNUICallback('deposit_money', function()
	mafiamenuopen = false
	SetNuiFocus(false,false)
	
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_money', {
		title = 'Enter the amount you want to deposit'
	},
	function(data, menu)
		local amount = tonumber(data.value) or -1
		menu.close()
		TriggerServerEvent('esx_mMafia:depositMoney', amount)
	end,
	function(data, menu)
		menu.close()
	end)
end)]]

RegisterNUICallback("onCloseMenu", function() --to idio callback yparxei kai se allo client arxeio sto mMafia

	mafiamenuopen = false

end)

--[[RegisterNUICallback('withdraw_money', function()
	mafiamenuopen = false
	SetNuiFocus(false,false)
	
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_money', {
		title = 'Enter the amount you want to withdraw'
	},
	function(data, menu)
		local amount = tonumber(data.value) or -1
		menu.close()
		TriggerServerEvent('esx_mMafia:withdrawMoney', amount)
	end,
	function(data, menu)
		menu.close()
	end)
end)

RegisterNUICallback('deposit_money', function()
	mafiamenuopen = false
	SetNuiFocus(false,false)
	
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_money', {
		title = 'Enter the amount you want to deposit'
	},
	function(data, menu)
		local amount = tonumber(data.value) or -1
		menu.close()
		TriggerServerEvent('esx_mMafia:depositMoney', amount)
	end,
	function(data, menu)
		menu.close()
	end)
end)]]

RegisterNetEvent("esx_mMafias:createArmory")
AddEventHandler("esx_mMafias:createArmory", function()
    local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
    local elements = {}
    table.insert(elements, {label = "<font color='red'>ΟΧΙ</font>",  value = 'no'})    
    table.insert(elements, {label = "<font color='green'>NAI</font>", value = 'yes'})

    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_action',
    {
        title    = "Είσαι σίγουρος?",
        align    = 'center',
        elements = elements
    }, function(data, menu)

        if data.current.value == 'yes' then
            menu.close()
            ESX.UI.Menu.Open(
                'dialog', GetCurrentResourceName(), 'Search',
                {
                    title = "Enter Password",
                },
            function (data, menu)
                if data.value ~= nil and data.value ~= "" then
                    if tostring(tonumber(data.value)) == data.value then
                        TriggerServerEvent("esx_mMafia:createArmory", coords,data.value)
                        menu.close()
                    else
                        ESX.ShowNotification("Only numbers allowed")
                    end
                end
            end,
            function (data, menu)
                menu.close()
            end)
            
        end
    end, function(data, menu)
        menu.close()
    end)
end)

function GetAnswer(question)
	local answer
	
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), question, {
		title = question
	},
	function(data, menu)
		answer = data.value or ''
		menu.close()
	end,
	function(data, menu)
		answer = ''
		menu.close()
	end)
	
	while answer == nil do
		Wait(100)
	end
	
	return answer
end