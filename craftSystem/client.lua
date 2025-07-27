ESX = nil
local PlayerData = nil
local currentZone
local currentId

local processBlip = nil

local currentBucket = math.floor(0)
local currentBucketName = "default"

AddEventHandler('buckets:onBucketChanged', function(bucketId, bucketName)
	currentBucket = bucketId
	currentBucketName = bucketName
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	print(1)
	while ESX.GetPlayerData().job == nil do
		Wait(100)
	end
	print(2)
	PlayerData = ESX.GetPlayerData()
	
	Wait(5000)
	print(3)
	ESX.TriggerServerCallback('craftSystem:getData', function(result, result2, result3, result4)
		print(4)
		for k,v in pairs(result) do
			if string.find(v.job, 'omilos') then
				table.insert(Config.JobsZones.nojob, {
					job			= v.job,
					discount	= Config.PreconfigOmilos[v.type].discount,
					coords		= Config.PreconfigOmilos[v.type].coords,
					items		= Config.ItemTypes[v.type]
				})
			else
				table.insert(Config.JobsZones.nojob, {
					job			= v.job,
					discount	= Config.Preconfig[v.type].discount,
					coords		= Config.Preconfig[v.type].coords,
					items		= Config.ItemTypes[v.type]
				})
			end
		end

		for k,v in pairs(result2 or {}) do
			local craft = json.decode(v.craft)
			local items = {}
	
			for k,v in pairs(craft.items) do
				table.insert(items, {
					name = k,
					quantity = 1,
					needed = {
						{ name = "wheel_factory", amount = 4 },
						{ name = "door_factory", amount = 4 },
						{ name = "bonnet_factory", amount = 2 },
						{ name = "trunk_factory", amount = 1 },
						{ name = "engine_factory", amount = 1 },
						{ name = "brake_factory", amount = 4 },
						{ name = "glass_factory", amount = 4 },
						{ name = "exhaust_factory", amount = 1 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				})
			end
	
			table.insert(Config.JobsZones.nojob, {
				job			= v.job,
				discount	= 0.0,
				coords		= vector3(craft.coords.x, craft.coords.y, craft.coords.z),
				items		= items
			})
		end

		for k,v in pairs(result3 or {}) do
			local craft = json.decode(v.craft)
			local items = {}
	
			for k,v in pairs(craft.items) do
				table.insert(items, {
					name = k,
					quantity = 1,
					needed = {
						{ name = "cock_factory", amount = 4 },
						{ name = "spring_factory", amount = 4 },
						{ name = "barrel_factory", amount = 4 },
						{ name = "grip_factory", amount = 4 },
						{ name = "bank", label = 'Cash', amount = 3500000 },
					},
					duration = 4, 
					animation = {command = 'mechanic'}
				})
			end
	
			table.insert(Config.JobsZones.nojob, {
				job			= v.job,
				discount	= 0.0,
				coords		= vector3(craft.coords.x, craft.coords.y, craft.coords.z),
				items		= items
			})
		end

		for k,v in pairs(result4 or {}) do
			local craft = json.decode(v.craft)
			local items = {}
			local setjobName = mysplit(v.job, '-')[1]
			local craftType = mysplit(v.job, '-')[2]

			for a,v in pairs(GlobalState.UFCrafts[craftType]) do
				table.insert(items, {
					name = a,
					quantity = 1,
					needed = GlobalState.UFCrafts[craftType][a] ,
					duration = 4, 
					animation = {command = 'mechanic'}
				})
				

			end
			table.insert(Config.JobsZones.nojob, {
				job			= setjobName,
				discount	= 0.0,
				coords		= vector3(craft.coords.x, craft.coords.y, craft.coords.z),
				items		= items
			})

			
		end
		CreateItemLabels()
		InitScript()
	end)
end)
function mysplit(inputstr, sep)
	if sep == nil then
	  sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
	  table.insert(t, str)
	end
	return t
  end
  
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	CreateProcessBlip()
end)

RegisterCommand('tpcraft', function(source, args)
	if ESX.GetPlayerData().group == 'superadmin' then
		local setjob = args[1] or ''

		if Config.JobsZones[setjob] then
			SetEntityCoords(PlayerPedId(), Config.JobsZones[setjob][1].coords)
		end
	end
end)

function CreateItemLabels()
	for job, positions in pairs(Config.JobsZones) do
		for i=1,#positions do
			if positions[i].items then
				for j=1,#positions[i].items do
					positions[i].items[j].label = ESX.GetItemLabel(positions[i].items[j].name)
					for k=1,#positions[i].items[j].needed do
						if positions[i].items[j].needed[k].name ~= 'money' and positions[i].items[j].needed[k].name ~= 'bank' and positions[i].items[j].needed[k].name ~= 'black_money' and positions[i].items[j].needed[k].name ~= 'coin' then
							positions[i].items[j].needed[k].label = ESX.GetItemLabel(positions[i].items[j].needed[k].name)
						else
							positions[i].items[j].needed[k].label = positions[i].items[j].needed[k].label or ESX.GetItemLabel(positions[i].items[j].needed[k].name)
						end
					end
				end
			end
		end
	end
end

function InitScript()
	CreateProcessBlip()

	while true do
		local wait = math.floor(1000)
		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.JobsZones) do
			if k == 'nojob' or k == PlayerData.job.name then
				for i=1, #v do
					if v[i].job == nil or ((currentBucketName == 'default' or currentBucketName == v[i].job) and v[i].job == PlayerData.job.name) or (string.find(currentBucketName, 'omilos') and v[i].job == PlayerData.job.name) then
						local dist = #(coords - v[i].coords)
						
						if dist < 15.0 then
							wait = math.floor(0)
							DrawMarker(0, v[i].coords.x, v[i].coords.y, v[i].coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.2, 1.2, 0.8, 255, 0, 0, 100, false, false, 2, true, false, false, false)

							if dist < 1.0 then
								ESX.ShowHelpNotification('Press ~INPUT_PICKUP~ to open Crafting')
								if IsControlJustReleased(math.floor(0), math.floor(38)) then
									TriggerEvent('craftSystem:openMenu', {id = i, zone = k})
									Wait(2000)
								end
							end
						end
					end
				end
			end
		end
		Wait(wait)
	end
end

RegisterNetEvent('craftSystem:openMenu', function(args)
	currentZone = args.zone
	currentId = args.id
	print(ESX.DumpTable(Config.JobsZones[currentZone][currentId].items))
	print(currentZone, currentId)
	if currentZone ~= 'nojob' and currentZone ~= PlayerData.job.name then return end
	if not Config.JobsZones[currentZone] then return end
	if not Config.JobsZones[currentZone][currentId] then return end
	
	local inventory = ESX.GetPlayerData().inventory
	
	for k,v in pairs(ESX.GetPlayerData().accounts) do
		inventory[v.name] = {name = v.name, label = v.label, count = v.money}
	end
	
	inventory['coin'] = {name = 'coin', label = 'Coins', count = ESX.GetPlayerData().attributes.donate_coins or 0}

	local discount = PlayerData.job.name == (Config.JobsZones[currentZone][currentId].job or 'none') and Config.JobsZones[currentZone][currentId].discount or 0.0

	print(discount, PlayerData.job.name, Config.JobsZones[currentZone][currentId].job)

	SetNuiFocus(true, true)
	SendNUIMessage({
		action = "show",
		items = Config.JobsZones[currentZone][currentId].items,
		inventory = inventory,
		discount = discount,
		job = Config.JobsZones[currentZone][currentId].job
	})
end)

RegisterNUICallback("quit", function ()
	SetNuiFocus(false, false)
	currentZone = nil
	currentId = nil
end)

RegisterNUICallback("craft", function (data)
	SetNuiFocus(false, false)
	if data and currentZone and currentId then
		for i=1,#Config.JobsZones[currentZone][currentId].items do
			if Config.JobsZones[currentZone][currentId].items[i].name == data.selectedItem then
				craftItem(data.selectedItem, data.quantity, i)
				break
			end
		end
	end
end)

function craftItem(item, quantity, itempos)
	local faceCoords = Config.JobsZones[currentZone][currentId].coords

	TaskTurnPedToFaceCoord(PlayerPedId(), faceCoords.x, faceCoords.y, faceCoords.z, math.floor(1250))
    Wait(1250)

	ESX.TriggerServerCallback('craftSystem:craftItem', function(success)
		if success then
			FreezeEntityPosition(PlayerPedId(), true)

			local item = Config.JobsZones[currentZone][currentId].items[itempos]
			TriggerEvent('closeInventoryHUD', item.duration * 1000)
			if item.animation and item.animation.command then
				ExecuteCommand('e '..item.animation.command)
			elseif item.animation and item.animation.dict then
				RequestAnimDict(item.animation.dict)

				while not HasAnimDictLoaded(item.animation.dict) do
					Wait(10)
				end

				TaskPlayAnim(PlayerPedId(), item.animation.dict, item.animation.name, 8.0, 0.0, math.floor(-1), math.floor(1), math.floor(0), math.floor(0), math.floor(0), math.floor(0))
			end

			Wait(item.duration * 1000)

			ClearPedTasks(PlayerPedId())

			FreezeEntityPosition(PlayerPedId(), false)

			if string.find(Config.JobsZones[currentZone][currentId].job, 'veh_factory') then
				TriggerEvent('veh_factory:playScene', Config.JobsZones[currentZone][currentId].job, item.name)
			end
		end

		currentZone = nil
		currentId = nil
	end, item, quantity, currentZone, currentId)
end

function CreateProcessBlip()
	if DoesBlipExist(processBlip) then
		RemoveBlip(processBlip)
	end

	if string.find(PlayerData.job.name, 'company') then
		for k,v in pairs(Config.JobsZones.nojob) do
			if v.job == PlayerData.job.name then
				processBlip = AddBlipForCoord(v.coords)
				SetBlipSprite(processBlip, 501)
				SetBlipScale(processBlip, 0.7)
				SetBlipColour(processBlip, 3)
				SetBlipAsShortRange(processBlip, true)
				BeginTextCommandSetBlipName('STRING')
				AddTextComponentString('Process')
				EndTextCommandSetBlipName(processBlip)

				break
			end
		end
	end
end