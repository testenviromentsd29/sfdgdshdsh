--[[ local Keys = {
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
 ]]
 local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,["F11"] = 344, ["BACKSPACE"] = 177, ["SPACE"] = 179,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83,
	["TAB"] = 37, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199,
	["CAPS"] = 137, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	 ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTALT"] = 19, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
	
}



local PlayerData                = {}
local Draws = {}
local Insides = {}
local MarkerIsIn = ''
local MarkerCounter = 0
local ActiveMarkers = {}
local MarkersCoordsBased = {}

ESX                             = nil


function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= math.floor(1) and UpdateOnscreenKeyboard() ~= math.floor(2) do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= math.floor(2) then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
	end
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	Draws = {}
end)

RegisterNetEvent("esx_utilities:add")
AddEventHandler("esx_utilities:add",function(name,message,key,draw,Type,pos,size,colour,resource,job,grade)
	if pos ~= nil and MarkersCoordsBased[pos] == nil then
		MarkersCoordsBased[pos] = true
	else
		return
	end
	Config.Markers[name..MarkerCounter] = {
        DrawDistance = draw,
        Pos = pos,
        Type = Type,
        Size  = size,
        Colour = colour,
        job = job,
        grade = grade,
		resource = resource,
		message = message,
		key = key,
		MarkerCounter = MarkerCounter
	}
	MarkerCounter = MarkerCounter + 1
end)

--TriggerEvent("esx_utilities:add","Matzaflokos","Press ~INPUT_CONTEXT~ to Open Matzaflokos",38,10.0,1,vector3(871.66,3170.9,39.6),{ x = 1.5, y = 1.5, z = 1.0 },{ r = 0, g = 204, b = 0},GetCurrentResourceName())
--TriggerEvent("esx_utilities:add","Matzaflokos","Press ~INPUT_CONTEXT~ to Open Matzaflokos",38,10.0,1,vector3(867.04,3168.64,39.81),{ x = 1.5, y = 1.5, z = 1.0 },{ r = 0, g = 204, b = 0},GetCurrentResourceName())

CreateThread(function()

	while ESX == nil do
		Citizen.Wait(0)
	end
	local isInAnyMarker = false
	while PlayerData.job == nil do
		Wait(0)
	end
	CreateThread(function()
		while true do
			for k,v in pairs(Config.Markers) do
				if ActiveMarkers[k] == nil then
					ActiveMarkers[k] = true
					CreateThread(function()
						while true do
							if v.job == nil or ( v.job == PlayerData.job.name ) then
								
								if v.grade == nil or (v.grade == PlayerData.job.grade_name) then
									
									local coords = GetEntityCoords(PlayerPedId())
									local distance = GetDistanceBetweenCoords(coords,v.Pos,true)
									if distance < v.DrawDistance then
										Draws[k] = v
									else
										Draws[k] = nil
									end
									if distance <= v.Size.x then
										if Insides[k] == nil then
											local label = string.gsub(k,tostring(v.MarkerCounter),"")
											TriggerEvent("enteredmarker",label,v)
										end
										Insides[k] = v
									else
										if Insides[k] ~= nil then
											local label = string.gsub(k,tostring(v.MarkerCounter),"")
											TriggerEvent("exitedmarker",label,v)
										end
										Insides[k] = nil
									end
								end
							end
								
							Wait(1000)
						end
					end)
				end
			end
			Wait(5000)
		end
	end)
	
	
	while true do
		isInAnyMarker = false
		if Draws then
			for k,v in pairs(Draws) do 
				if v.Pos then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Colour.r, v.Colour.g, v.Colour.b, (100), false, true, (2), false, false, false, false)
					if Insides[k] ~= nil then
						isInAnyMarker = true
						MarkerIsIn = k
						SetTextComponentFormat('STRING')
						AddTextComponentString(v.message)
						DisplayHelpTextFromStringLabel(math.floor(0), math.floor(0), math.floor(1), math.floor(-1))
						if IsControlJustPressed(math.floor(0),  math.floor(v.key)) then
							if (#ESX.UI.Menu.GetOpenedMenus()) == 0 then
								CreateThread(function()
									local label = string.gsub(k,tostring(v.MarkerCounter),"")
									TriggerEvent("pressedmarker",label,v)
								end)
							else
								ESX.ShowNotification("Please Close All Open Menus First")
							end
						end
					end
				end
			end
			
		end
		Wait(0)
	end
	
end)



CreateThread(function()
	while ESX == nil do
		Wait(0)
	end
	while true do
		for k,v in pairs(Keys) do
			if IsControlJustPressed(0,v) then
				CreateThread(function()
					TriggerEvent("justpressed",k,v)
				end)	
			end
			if IsDisabledControlJustPressed(0,v) then
				CreateThread(function()
					TriggerEvent("justpresseddisabled",k,v)
				end)	
			end
			if IsControlPressed(0, v) then
				CreateThread(function()
					TriggerEvent("pressed",k,v)
				end)
			end
			if IsControlJustReleased(0, v) then
				CreateThread(function()
					TriggerEvent("justreleased",k,v)
				end)
			end
			if IsDisabledControlJustReleased(0, v) then
				CreateThread(function()
					TriggerEvent("justreleaseddisabled",k,v)
				end)
			end
		end
		Wait(5)
	end
end)

AddEventHandler("justpressed",function(label,key)
	--print("just pressed a button")
end)


AddEventHandler("pressed",function(label,key)
	--print("Button is pressed: "..key)
end)

AddEventHandler("pressedmarker", function(markerlabel,MarkerObject)
	if MarkerObject.resource == GetCurrentResourceName() then
		print("Pressed Marker :"..markerlabel)
	end
end)

AddEventHandler("enteredmarker", function(markerlabel,MarkerObject)
	if MarkerObject.resource == GetCurrentResourceName() then
		print("Exited Marker :"..markerlabel)
	end
end)


AddEventHandler("exitedmarker", function(markerlabel,MarkerObject)
	if MarkerObject.resource == GetCurrentResourceName() then
		print("Exited Marker :"..markerlabel)
	end
end)

