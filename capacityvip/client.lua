ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('capacityvip:showVips', function(vips)
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'christmas_vips', {
		title    = 'Capacity Vips',
		align    = 'center',
		elements = vips,
	},function(data, menu)
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'christmas_vips_delete', {
			title    = 'Delete vip?',
			align    = 'center',
			elements = {
				{label = 'Yes', value = 'yes'},
				{label = 'No', value = 'no'},
			},
		},function(data2, menu2)
			if data2.current.value == 'yes' then
				TriggerServerEvent('capacityvip:deleteVip', data.current.value)
			end
			menu2.close()
		end,function(data2, menu2)
			menu2.close()
		end)
	end,function(data, menu)
	   menu.close()
	end)
end)