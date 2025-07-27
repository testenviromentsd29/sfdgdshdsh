
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

--instructionals
local form = nil
local data = {}

local entries = {}

local isBusy = false
local createPrice = 0
----------------

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	
	ESX.PlayerData = ESX.GetPlayerData()
	
	CreateMafiaBot()
end)

--[[RegisterCommand('changemafiagradelabels', function(source, args)
	ESX.UI.Menu.CloseAll()
	
	local elements = {}
	
	for k,v in pairs(ConfigCL.JobGradeLabels) do
		table.insert(elements, {label = 'Type: '..k,	value = k})
	end
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cmtl', {
		title    = 'Select Type',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		local id = data.current.value
		menu.close()
		TriggerServerEvent('esx_mMafia:changeMafiaGradeLabel', id)
	end,
	function(data, menu)
		menu.close()
	end)
end)

RegisterCommand('mafiatype', function(source, args)
	ESX.UI.Menu.CloseAll()
	
	local elements = {}
	
	for k,v in pairs(ConfigCL.MafiaTypesMenu) do
		table.insert(elements, {label = 'Type: '..k,	value = k})
	end
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cmt', {
		title    = 'Select Type',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		local id = data.current.value
		menu.close()
		TriggerServerEvent('esx_mMafia:changeMafiaTypeByBoss', id)
	end,
	function(data, menu)
		menu.close()
	end)
end)]]

function DrawText2(x, y, scale, text)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(scale, scale)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry('STRING')
	AddTextComponentString(text)
	DrawText(x, y)
end

function GetMouseXY()
	local screenWidth, screenHeight = GetActiveScreenResolution()
	local x = GetDisabledControlNormal(2, 239)
	local y = GetDisabledControlNormal(2, 240)
	
	return screenWidth * x, screenHeight * y
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function OpenMafiaMenu()
	SetBusy()
	CreateJob()
end

RegisterNUICallback('onCloseMenu', function()
	SetBusy()
	SendNUIMessage({action = 'disable'})
	SetNuiFocus(false,false)
end)

RegisterNUICallback('createfamily', function(data)
	SetNuiFocus(false,false)
	
	ESX.TriggerServerCallback("esx_mMafia:canCreateMafia", function(canCreate) 
		if canCreate then
			SetBusy()
			TriggerServerEvent("esx_mMafias:startJobCreation", "family", data.jobname, {}, data.country, data.houseid)
		else
			ESX.ShowNotification("You dont have the necessary requirements")
		end
	end,{},data.jobname)
end)

RegisterNUICallback('focusplz', function()
	SetNuiFocus(false,false)
end)

RegisterNetEvent('esx_mMafia:getCreateMafiaPrice')
AddEventHandler('esx_mMafia:getCreateMafiaPrice', function(createMafiaPrice)
	createPrice = createMafiaPrice
end)

function CreateJob()
	local props = exports.nProperties:getOwnedProperties()
	SendNUIMessage({
		action = "enablecreatecriminal",
		properties = props,
		price = createPrice
	})
	SetNuiFocus(true, true)

	
end

function selectPlayers()
	
	local playersToSearch = {}
	local playersSize = 0
	local currentIndex = 1
	local selected = {}
	local finishedSelecting = false
	playersToSearch = ESX.Game.GetPlayersInArea(GetEntityCoords(GetPlayerPed(-1)), 15.0) 
	playersSize = #playersToSearch
	if playersSize == 0 then
		return {}
	end
	SetInstructionalButton("SELECT PLAYER", math.floor(Keys["SPACE"]), true)
	SetInstructionalButton("Change Player", math.floor(Keys["RIGHT"]), true)
	SetInstructionalButton("Change Player", math.floor(Keys["LEFT"]), true)
	SetInstructionalButton("APPLY", math.floor(Keys["BACKSPACE"]), true)
	CreateThread(function()
		while not finishedSelecting do
			playersToSearch = ESX.Game.GetPlayersInArea(GetEntityCoords(GetPlayerPed(-1)), 15.0) 
			playersSize = #playersToSearch
			Wait(1000)
		end
	end)
	CreateThread(function()
		while not finishedSelecting do
			if form then
				DrawScaleformMovieFullscreen(form, math.floor(255), math.floor(255), math.floor(255), math.floor(255), math.floor(0))
			end
			Wait(0)
		end
	end)
	CreateThread(function()
		while not finishedSelecting do
			if playersSize > 0 then
				
				if IsControlJustPressed(0,Keys["BACKSPACE"]) then
					finishedSelecting = true
				end
				if IsControlJustPressed(0,Keys["RIGHT"]) then
					currentIndex = currentIndex + 1
					if currentIndex > playersSize then
						currentIndex = 1
					end
					if currentIndex < 1 then
						currentIndex = playersSize
					end
				end
				if IsControlJustPressed(0,Keys["LEFT"]) then
					currentIndex = currentIndex - 1
					if currentIndex > playersSize then
						currentIndex = 1
					end
					if currentIndex < 1 then
						currentIndex = playersSize
					end
				end
				if IsControlJustPressed(0,Keys["SPACE"]) then
					if selected[playersToSearch[currentIndex]] == nil then
						selected[playersToSearch[currentIndex]] = true
					else
						selected[playersToSearch[currentIndex]] = nil
					end
					currentIndex = currentIndex + 1
					if currentIndex > playersSize then
						currentIndex = 1
					end
					if currentIndex < 1 then
						currentIndex = playersSize
					end
				end
				
			end
			Wait(0)
		end
	end)
	CreateThread(function()
		while not finishedSelecting do
			if playersSize > 0 then
				
				for k,v in pairs(selected) do
					local found = false
					for i = 1, #playersToSearch do
						if playersToSearch[i] == k then
							found = true
							break
						end
					end
					if not found then
						selected[k] = nil
					end
				end
				
			end
			Wait(0)
		end
	end)
	CreateThread(function()
		while not finishedSelecting do
			for i = 1,#playersToSearch do
				if NetworkIsPlayerActive(playersToSearch[i]) then
					local coords = GetEntityCoords(GetPlayerPed(playersToSearch[i]))
					local x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed(playersToSearch[i]), true ) )
					local takeaway = 0.95
					if i == currentIndex then
						DrawMarker(0,x1, y1, z1 + 1.2, 0, 0, 0, 0, 0, 180, 0.5, 0.5, 0.2, 0, 132, 8, 105, 1, 1, 2, 1, 0, 0, 0)
					end
					if selected[playersToSearch[i]] then
						DrawMarker(1,x1, y1, z1 - takeaway, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.3, 0, 132, 200, 105, 0, 0, 2, 0, 0, 0, 0)
					end

				end
			end
			Wait(0)
		end
	end)
	while not finishedSelecting do
		Wait(0)
	end

	return selected

end

function selectPlayer(onlyInVehicles)
	
	local playersToSearch = {}
	local playersSize = 0
	local currentIndex = 1
	local selected = nil
	local finishedSelecting = false
	playersToSearch = ESX.Game.GetPlayersInArea(GetEntityCoords(GetPlayerPed(-1)), 15.0) 
	
	local filter = {}
	for i = 1, #playersToSearch do 
		if onlyInVehicles then
			if GetVehiclePedIsIn(GetPlayerPed(playersToSearch[i]), false) ~= 0 and playersToSearch[i] ~= PlayerId() then 
				table.insert(filter,playersToSearch[i])
			end
		else
			if playersToSearch[i] ~= PlayerId() then 
				table.insert(filter,playersToSearch[i])
			end
		end
	end
	playersToSearch = filter
	playersSize = #playersToSearch
	if playersSize == 0 then
		return 
	end
	SetInstructionalButton("SELECT PLAYER", math.floor(Keys["SPACE"]), true)
	SetInstructionalButton("Change Player", math.floor(Keys["RIGHT"]), true)
	SetInstructionalButton("Change Player", math.floor(Keys["LEFT"]), true)
	SetInstructionalButton("APPLY", math.floor(Keys["BACKSPACE"]), true)
	CreateThread(function()
		while not finishedSelecting do
			playersToSearch = ESX.Game.GetPlayersInArea(GetEntityCoords(GetPlayerPed(-1)), 15.0) 
			local filter = {}
			for i = 1, #playersToSearch do 
				if onlyInVehicles then
					if GetVehiclePedIsIn(GetPlayerPed(playersToSearch[i]), false) ~= 0 and playersToSearch[i] ~= PlayerId() then 
						table.insert(filter,playersToSearch[i])
					end
				else
					if playersToSearch[i] ~= PlayerId() then 
						table.insert(filter,playersToSearch[i])
					end
				end
			end
			playersToSearch = filter
			playersSize = #playersToSearch
			Wait(1000)
		end
	end)
	CreateThread(function()
		while not finishedSelecting do
			if form then
				DrawScaleformMovieFullscreen(form, math.floor(255), math.floor(255), math.floor(255), math.floor(255), math.floor(0))
			end
			Wait(0)
		end
	end)
	CreateThread(function()
		while not finishedSelecting do
			if playersSize > 0 then
				
				if IsControlJustPressed(0,Keys["BACKSPACE"]) then
					finishedSelecting = true
				end
				if IsControlJustPressed(0,Keys["RIGHT"]) then
					currentIndex = currentIndex + 1
					if currentIndex > playersSize then
						currentIndex = 1
					end
					if currentIndex < 1 then
						currentIndex = playersSize
					end
				end
				if IsControlJustPressed(0,Keys["LEFT"]) then
					currentIndex = currentIndex - 1
					if currentIndex > playersSize then
						currentIndex = 1
					end
					if currentIndex < 1 then
						currentIndex = playersSize
					end
				end
				if IsControlJustPressed(0,Keys["SPACE"]) then
					if selected == nil then
						selected = playersToSearch[currentIndex]
						finishedSelecting = true
					else
						selected = nil
					end
					currentIndex = currentIndex + 1
					if currentIndex > playersSize then
						currentIndex = 1
					end
					if currentIndex < 1 then
						currentIndex = playersSize
					end
				end
				
			end
			Wait(0)
		end
	end)
	
	CreateThread(function()
		while not finishedSelecting do
			for i = 1,#playersToSearch do
				if NetworkIsPlayerActive(playersToSearch[i]) then
					local coords = GetEntityCoords(GetPlayerPed(playersToSearch[i]))
					local x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed(playersToSearch[i]), true ) )
					local takeaway = 0.95
					if i == currentIndex then
						DrawMarker(0,x1, y1, z1 + 1.2, 0, 0, 0, 0, 0, 180, 0.5, 0.5, 0.2, 0, 132, 8, 105, 1, 1, 2, 1, 0, 0, 0)
					end
					if selected == playersToSearch[i] then
						DrawMarker(1,x1, y1, z1 - takeaway, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.3, 0, 132, 200, 105, 0, 0, 2, 0, 0, 0, 0)
					end

				end
			end
			Wait(0)
		end
	end)
	while not finishedSelecting do
		Wait(0)
	end

	return selected

end


----instructional button


local function ButtonMessage(text)
	BeginTextCommandScaleformString("STRING")
	AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

local function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

local function setupScaleform(scaleform, data)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(math.floor(200))
    PopScaleformMovieFunctionVoid()

    for n, btn in next, data do
        PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
        PushScaleformMovieFunctionParameterInt(math.floor(n-1))
		Button(GetControlInstructionalButton(math.floor(2), btn.control, true))
        ButtonMessage(btn.name)
        PopScaleformMovieFunctionVoid()
    end

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(math.floor(0))
    PushScaleformMovieFunctionParameterInt(math.floor(0))
    PushScaleformMovieFunctionParameterInt(math.floor(0))
    PushScaleformMovieFunctionParameterInt(math.floor(80))
    PopScaleformMovieFunctionVoid()

    return scaleform
end


function SetInstructions()
    form = setupScaleform("instructional_buttons", entries)
end

function SetInstructionalButton(name, control, enabled)
    local found = false
    for k, entry in next, entries do
        if entry.name == name and entry.control == control then
            found = true
            if not enabled then
                table.remove(entries, k)
                SetInstructions()
            end
            break
        end
    end
    if not found then
        if enabled then
            table.insert(entries, {name = name, control = control})
            SetInstructions()
        end
    end
end

RegisterNetEvent("esx_mMafia:showJobNotification")
AddEventHandler("esx_mMafia:showJobNotification",function(msg,jobs)

    if jobs then
		for k,v in pairs(jobs) do
        	if ESX.PlayerData.job.name == v then
				ESX.ShowNotification(msg)
				break
			end
		end
    else
        ESX.ShowNotification(msg)
    end

end)

RegisterNetEvent("esx_mMafia:showcartelitemsmenu")
AddEventHandler("esx_mMafia:showcartelitemsmenu",function(items)

   	local elements = {}
	for k,v in pairs(items) do
		table.insert(elements, { label = v.label.." <font color='red'>"..v.price.."</font>" , object = v } )
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy_cartel_item',
	{
		title    = 'Buy Cartel Items',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)

		local item = data.current.object
		ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'buy_cartel_item_dialog',
		{
			title = "Enter Amount"
		},
		function(data, menu)
			local count = data.value
			
			if count ~= nil and tonumber(count) > 0 then
				menu.close()
				count = tonumber(count)
				TriggerServerEvent("esx_mMafia:buyCartelItem",item,count)
			else
				ESX.ShowNotification("Wrong Number")
			end			
		end,
		function(data, menu)
			menu.close()
		end)

	end,function(data,menu)
		menu.close()
	end)

end)

RegisterNetEvent('esx_mMafia:onVehicleUnlockable')
AddEventHandler('esx_mMafia:onVehicleUnlockable', function(plate, model)
	local coords = GetEntityCoords(PlayerPedId())
	
	ESX.Game.SpawnLocalVehicle(model, vector3(coords.x, coords.y, coords.z - 10.0), 0.0, function(vehicle)
		SetVehicleNumberPlateText(vehicle, plate)
		local vehicleProps = exports['tp-garages']:GetVehicleProperties(vehicle)
		DeleteEntity(vehicle)
		TriggerServerEvent('esx_mMafia:onVehicleUnlockable', plate, vehicleProps)
	end)
end)

local CreateCriminalLocation = ConfigCL.CreateCriminal

--[[Citizen.CreateThread(function()
	Citizen.Wait(2000)
	TriggerEvent("esx_utilities:add","CreateCriminal","Press ~INPUT_CONTEXT~ to Open Create Criminal Menu",38,5.0 ,1,CreateCriminalLocation,{x=3.0,y=3.0,z=1.0},{r=0,g=200,b=150},GetCurrentResourceName())
end)]]

local nearCreateCriminalCoords = false
CreateThread(function()
	while true do
		local coords = GetEntityCoords(PlayerPedId())
		if #(coords - CreateCriminalLocation) < 38 then
			if not nearCreateCriminalCoords then
				nearCreateCriminalCoords = true
				CreateThread(function()
					while nearCreateCriminalCoords do

						ESX.Game.Utils.DrawText3D(vector3(CreateCriminalLocation.x,CreateCriminalLocation.y,CreateCriminalLocation.z + 3), "Press [~g~E~w~] to Create Free ~r~Mafia", 4, 4)
						Wait(0)
					end
				end)
			end
		else
			nearCreateCriminalCoords = false
		end
		Wait(4000)
	end
end)

AddEventHandler("pressedmarker", function(markerlabel,MarkerObject)
	if MarkerObject.resource == GetCurrentResourceName() then
		if markerlabel == "CreateCriminal" then
			if not isBusy then
				OpenMafiaMenu()
			else
				ESX.ShowNotification('Please dont spam')
			end
		end
	end
end)


function crmafiaped()
	RequestModel(ConfigCL.CreateMafiaNpcHash)
	while not HasModelLoaded(ConfigCL.CreateMafiaNpcHash) do
		Wait(1)
	end

	local CreateMafiaCoords = { x = ConfigCL.CreateCriminal.x, y = ConfigCL.CreateCriminal.y, z = ConfigCL.CreateCriminal.z }
	local createmafiaped = CreatePed(1, ConfigCL.CreateMafiaNpcHash, CreateMafiaCoords.x, CreateMafiaCoords.y, CreateMafiaCoords.z, ConfigCL.CreateMafiaNpcHeading, false, true)
	SetBlockingOfNonTemporaryEvents(createmafiaped, true)
	SetPedDiesWhenInjured(createmafiaped, false)
	SetPedCanPlayAmbientAnims(createmafiaped, true)
	SetPedCanRagdollFromPlayerImpact(createmafiaped, false)
	SetEntityInvincible(createmafiaped, true)
	FreezeEntityPosition(createmafiaped, true)

	return createmafiaped
	
end



local peds = {}

Citizen.CreateThread(function()
	while true do
		Wait(4000)
		
		if peds["createMafia"] and DoesEntityExist(peds["createMafia"]) then
			if #(GetEntityCoords(PlayerPedId()) - ConfigCL.CreateCriminal) > 50 then
				DeleteEntity(peds["createMafia"])
				peds["createMafia"] = nil
			end
		else
			if #(GetEntityCoords(PlayerPedId()) - ConfigCL.CreateCriminal) < 30 then
				peds["createMafia"] = crmafiaped()
			end
		end
	end
end)

function SetBusy(msecs)
	if not isBusy then
		isBusy = true
		
		local msecs = msecs or 2000
		
		CreateThread(function()
			Wait(msecs)
			isBusy = false
		end)
	end
end

function CreateMafiaBot()
	local botCoords = vector3(206.46, -922.13, 30.69)
	local botDrawText = vector3(botCoords.x, botCoords.y, botCoords.z + 1.0)
	
	--[[local blip = AddBlipForCoord(botCoords)
	SetBlipSprite(blip, 675)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, 5)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('FREE CRIMINAL JOB')
	EndTextCommandSetBlipName(blip)]]
	
--[[ 	Citizen.CreateThread(function()
		while true do
			local wait = 1500
			local coords = GetEntityCoords(PlayerPedId())
			
			if #(coords - botCoords) < 25.0 then
				wait = 0
				
				ESX.Game.Utils.DrawText3D(botDrawText, 'FREE CRIMINAL JOB', 4, 4)
				DrawMarker(30, botCoords, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, false, 2, true, false, false, false)
				
				if #(coords - botCoords) < 1.5 then
					ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to create your criminal job')
					
					if IsControlJustReleased(0, 38) then


						CreateCriminalProcess()
					end
				end
			end
			
			Wait(wait)
		end
	end) ]]
end

function CreateCriminalProcess()
	local label = string.lower(exports['dialog']:Create('Your criminal job name?', 'Only numbers and letters allowed').value or '')
	
	if not string.match(label, '^[A-Za-z0-9%s]+$') then
		ESX.ShowNotification('Name contains invalid characters')
		return
	end
	
	if string.len(label) < 3 or string.len(label) > 32 then
		ESX.ShowNotification('Name too small or too big')
		return
	end
	
	if string.sub(label, 1, 1) == ' ' then
		ESX.ShowNotification('Name must not start with space')
		return
	end

	TriggerServerEvent('esx_mMafia:requestCreateCriminal', label)
	
	--[[local toInvite = {}
	local foundNear = 0
	local coords = GetEntityCoords(PlayerPedId())
	
	for k,v in pairs(GetActivePlayers()) do
		if PlayerId() ~= v and #(coords - GetEntityCoords(GetPlayerPed(v))) < 10.0 then
			local sid = GetPlayerServerId(v)
			
			if sid > 0 then
				toInvite[sid] = true
				foundNear = foundNear + 1
			end
		end
	end
	
	if foundNear < 2 then
		ESX.ShowNotification('Not enough players near you to invite')
		return
	end
	
	TriggerServerEvent('esx_mMafia:requestCreateCriminal', label, toInvite)]]
end

RegisterNetEvent('esx_mMafia:requestJoinMember')
AddEventHandler('esx_mMafia:requestJoinMember', function(label, caller)
	if exports['dialog']:Decision('Wanna be part of '..label, 'Are you sure?', '', 'YES', 'NO').action == 'submit' then
		TriggerServerEvent('esx_mMafia:acceptJoinMember', caller)
	end
end)

RegisterNetEvent('esx_mMafia:mafiaRequests')
AddEventHandler('esx_mMafia:mafiaRequests', function(mafiaRequests)
	ESX.UI.Menu.CloseAll()
	
	local elements = {}
	
	for k,v in pairs(mafiaRequests) do
		if v.status == 'pending' then
			table.insert(elements, {label = v.name..' ['..v.identifier..'] ['..v.label..']', value = k})
		end
	end
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mafia_requests', {
		title    = 'Mafia Requests',
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		print(data.current.value)
		CheckMafiaRequest(data.current.value, mafiaRequests[data.current.value])
	end,function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('esx_mMafia:checkMyRequests')
AddEventHandler('esx_mMafia:checkMyRequests', function(requests)
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'my_requests', {
		title    = 'Mafia Requests',
		align    = 'center',
		elements = requests,
	},
	function(data, menu)
		menu.close()
	end,function(data, menu)
		menu.close()
	end)
end)

function CheckMafiaRequest(id, requestData)
	local elements = {}
	
	table.insert(elements, {label = 'Create', value = 'create'})
	table.insert(elements, {label = 'Delete', value = 'delete'})
	
	for k,v in pairs(requestData.members) do
		table.insert(elements, {label = v.name..' ['..k..']', value = 'member'})
	end
	
	local title = requestData.name..' ['..id..'] ['..requestData.label..']'
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'check_mafia', {
		title    = title,
		align    = 'center',
		elements = elements,
	},
	function(data, menu)
		if data.current.value == 'create' then
			menu.close()
			ProcessRecycleMafia(id, requestData.label)
		elseif data.current.value == 'delete' then
			menu.close()
			TriggerServerEvent('esx_mMafia:deleteRequest', id)
		end
	end,function(data, menu)
		menu.close()
	end)
end

function ProcessRecycleMafia(id, label)
	local job = exports['dialog']:Create('Enter setjob to recycle', '').value
	local label = exports['dialog']:Create('Enter setjob label', 'Requested label: '..label).value
	
	if job and label then
		TriggerServerEvent('esx_mMafia:recycleMafia', id, job, label)
	end
end