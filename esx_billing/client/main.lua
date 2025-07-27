local Keys = {
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

ESX       = nil
local GUI = {}
GUI.Time  = 0
local menuOpened = false
local billsPerHours = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_billing:resetBillings')
AddEventHandler('esx_billing:resetBillings',function()
	Wait(1000*60*60)
	billsPerHours = 0
end)

RegisterNetEvent('esx_billing:confirm')
AddEventHandler('esx_billing:confirm',function(label, amount, policeCategory)
	if policeCategory and policeCategory == 0 then
		if billsPerHours > Config.MaxPoliceFinesPerHour then
			ESX.ShowNotification("Έχεις φτάσει το ωριαίο όριο προστίμων")
			TriggerServerEvent('esx_billing:decline')
			return
		end
	end
	
	SetNuiFocus(true, true)
	SendNUIMessage({money = amount, reason = label, title = Translation[Config.Locale]['invoice_title'], priceTitle = Translation[Config.Locale]['invoice_pricetitle'], reasonTitle = Translation[Config.Locale]['invoice_reasontitle'], signTitle = Translation[Config.Locale]['invoice_sign'], acceptTitle = Translation[Config.Locale]['invoice_accepttitle'],policeCategory = policeCategory})
end)

RegisterNUICallback('accept', function(data)
	if data.polCat and data.polCat == 0 then
		TriggerServerEvent('esx_policejob:addFine')
		billsPerHours = billsPerHours + 1
		if billsPerHours == 1 then
			TriggerEvent('esx_billing:resetBillings')
		end
	end
	TriggerServerEvent('esx_billing:payBill')
	SetNuiFocus(false, false)
end)

RegisterNUICallback('denied', function(data)
	TriggerServerEvent('esx_billing:decline')
	SetNuiFocus(false, false)
end)

RegisterNetEvent("esx_billing:notifycops")
AddEventHandler("esx_billing:notifycops",function(msg)
	local data = ESX.GetPlayerData()
	if data and data.job and (data.job.name == "police" or data.job.name == "police2") then
		ESX.ShowNotification(msg)
	end
end)

RegisterNetEvent('esx_billing:SetBillPercent')
AddEventHandler('esx_billing:SetBillPercent', function()

    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'bill_percent', {
        title = "Set Bill Percent",
    },
    function(data, menu)
        local percent = data.value
        percent = tonumber(percent)
        if percent >= 0 and percent <= 100 then
			menu.close()

			if exports['dialog']:Decision('', 'Company will take '..percent..'% of the bill, The '..(100-percent)..'% will go to the player', '', 'YES', 'NO').action == 'submit' then
            	TriggerServerEvent('esx_billing:setPercent', percent)
			end
        else
            ESX.ShowNotification("Percent must be between 0 and 100")
        end
    end,
    function(data, menu)
        menu.close()
    end)


end)