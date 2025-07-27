ESX = nil;

CreateThread(function()
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Wait(3000);
	if ESX == nil then
		CreateThread(function()
			ESX = exports["es_extended"]:getSharedObject();
		end)
	end
end)

run = false;

CreateThread(function()
	while Greek == nil do
		Wait(100)
	end
	run = true
	local title = "~s~AntiCheat Menu"
	local pedid = PlayerId(-1)
	local name = GetPlayerName(pedid)
	local showblip = false
	local showsprite = false
	local nameabove = true
	local Enabled = true

	RegisterNetEvent("AC:adminmenuenabley")
	AddEventHandler("AC:adminmenuenabley", function()
		Enabled = false
		showblip = false
		showsprite = false
		nameabove = false
		esp = true
	end)

	local GH = {}
	GH.debug = false

	local function RGBRainbow(frequency)
		local result = {}
		local curtime = GetGameTimer() / 2000
		result.r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
		result.g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
		result.b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)

		return result
	end

	local menus = {}
	local keys = {up = 172, down = 173, left = 174, right = 175, select = 176, back = 177}
	local optionCount = 0

	local currentKey = nil
	local currentMenu = nil

	local menuWidth = 0.21
	local titleHeight = 0.10
	local titleYOffset = 0.03
	local titleScale = 0.9
	local buttonHeight = 0.040
	local buttonFont = 0
	local buttonScale = 0.370
	local buttonTextXOffset = 0.005
	local buttonTextYOffset = 0.005
	local bytexd = "Greek-AntiCheat"
	local function debugPrint(text)
		if GH.debug then
			Citizen.Trace("[Greek-AntiCheat] "..tostring(text))
		end
	end

	local function setMenuProperty(id, property, value)
		if id and menus[id] then
			menus[id][property] = value
			debugPrint(id.." menu property changed: { "..tostring(property)..", "..tostring(value).." }")
		end
	end

	local function isMenuVisible(id)
		if id and menus[id] then
			return menus[id].visible
		else
			return false
		end
	end

	local function setMenuVisible(id, visible, holdCurrent)
		if id and menus[id] then
			setMenuProperty(id, "visible", visible)
			if not holdCurrent and menus[id] then
				setMenuProperty(id, "currentOption", 1)
			end
			if visible then
				if id ~= currentMenu and isMenuVisible(currentMenu) then
					setMenuVisible(currentMenu, false)
				end
				currentMenu = id
			end
		end
	end

	local function drawText(text, x, y, font, color, scale, center, shadow, alignRight)
		SetTextColour(color.r, color.g, color.b, color.a)
		SetTextFont(font)
		SetTextScale(scale, scale)
		if shadow then
			SetTextDropShadow(2, 2, 0, 0, 0)
		end
		if menus[currentMenu] then
			if center then
				SetTextCentre(center)
			elseif alignRight then
				SetTextWrap(menus[currentMenu].x, menus[currentMenu].x + menuWidth - buttonTextXOffset)
				SetTextRightJustify(true)
			end
		end
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(x, y)
	end

	local function drawRect(x, y, width, height, color)
		DrawRect(x, y, width, height, color.r, color.g, color.b, color.a)
	end

	local function drawTitle()
		if menus[currentMenu] then
			local x = menus[currentMenu].x + menuWidth / 2
			local y = menus[currentMenu].y + titleHeight / 2
			if menus[currentMenu].titleBackgroundSprite then
				DrawSprite(
					menus[currentMenu].titleBackgroundSprite.dict,
					menus[currentMenu].titleBackgroundSprite.name,
					x,
					y,
					menuWidth,
					titleHeight,
					0.,
					255,
					255,
					255,
					255
				)
			else
				drawRect(x, y, menuWidth, titleHeight, menus[currentMenu].titleBackgroundColor)
			end
			drawText(
				menus[currentMenu].title,
				x,
				y - titleHeight / 2 + titleYOffset,
				menus[currentMenu].titleFont,
				menus[currentMenu].titleColor,
				titleScale,
				true
			)
		end
	end

	local function drawSubTitle()
		if menus[currentMenu] then
			local x = menus[currentMenu].x + menuWidth / 2
			local y = menus[currentMenu].y + titleHeight + buttonHeight / 2
			local subTitleColor = {
				r = menus[currentMenu].titleBackgroundColor.r,
				g = menus[currentMenu].titleBackgroundColor.g,
				b = menus[currentMenu].titleBackgroundColor.b,
				a = 255
			}
			drawRect(x, y, menuWidth, buttonHeight, menus[currentMenu].subTitleBackgroundColor)
			drawText(
				menus[currentMenu].subTitle,
				menus[currentMenu].x + buttonTextXOffset,
				y - buttonHeight / 2 + buttonTextYOffset,
				buttonFont,
				subTitleColor,
				buttonScale,
				false
			)
			if optionCount > menus[currentMenu].maxOptionCount then
				drawText(
					tostring(menus[currentMenu].currentOption) .. " / " .. tostring(optionCount),
					menus[currentMenu].x + menuWidth,
					y - buttonHeight / 2 + buttonTextYOffset,
					buttonFont,
					subTitleColor,
					buttonScale,
					false,
					false,
					true
				)
			end
		end
	end

	local function drawButton(text, subText)
		local x = menus[currentMenu].x + menuWidth / 2
		local multiplier = nil
		if menus[currentMenu].currentOption <= menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].maxOptionCount then
			multiplier = optionCount
		elseif
			optionCount > menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount and
				optionCount <= menus[currentMenu].currentOption
		 then
			multiplier = optionCount - (menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount)
		end
		if multiplier then
			local y = menus[currentMenu].y + titleHeight + buttonHeight + (buttonHeight * multiplier) - buttonHeight / 2
			local backgroundColor = nil
			local textColor = nil
			local subTextColor = nil
			local shadow = false
			if menus[currentMenu].currentOption == optionCount then
				backgroundColor = menus[currentMenu].menuFocusBackgroundColor
				textColor = menus[currentMenu].menuFocusTextColor
				subTextColor = menus[currentMenu].menuFocusTextColor
			else
				backgroundColor = menus[currentMenu].menuBackgroundColor
				textColor = menus[currentMenu].menuTextColor
				subTextColor = menus[currentMenu].menuSubTextColor
				shadow = true
			end
			drawRect(x, y, menuWidth, buttonHeight, backgroundColor)
			drawText(
				text,
				menus[currentMenu].x + buttonTextXOffset,
				y - (buttonHeight / 2) + buttonTextYOffset,
				buttonFont,
				textColor,
				buttonScale,
				false,
				shadow
			)	
			if subText then
				drawText(
					subText,
					menus[currentMenu].x + buttonTextXOffset,
					y - buttonHeight / 2 + buttonTextYOffset,
					buttonFont,
					subTextColor,
					buttonScale,
					false,
					shadow,
					true
				)
			end
		end
	end

	function GH.CrateMenu(id, title)
		-- Default settings
		menus[id] = {}
		menus[id].title = title
		menus[id].subTitle = bytexd
		menus[id].visible = false
		menus[id].previousMenu = nil
		menus[id].aboutToBeClosed = false
		menus[id].x = 0.75
		menus[id].y = 0.19
		menus[id].currentOption = 1
		menus[id].maxOptionCount = 10
		menus[id].titleFont = 1
		menus[id].titleColor = {r = 255, g = 255, b = 255, a = 255}
		Citizen.CreateThread(
			function()
				while true do
					Citizen.Wait(0)
					local ra = RGBRainbow(1.0)
					menus[id].titleBackgroundColor = {r = ra.r, g = ra.g, b = ra.b, a = 105}
					menus[id].menuFocusBackgroundColor = {r = ra.r, g = ra.g, b = ra.b, a = 100} 
				end
			end)
		menus[id].titleBackgroundSprite = nil
		menus[id].menuTextColor = {r = 255, g = 255, b = 255, a = 255}
		menus[id].menuSubTextColor = {r = 189, g = 189, b = 189, a = 255}
		menus[id].menuFocusTextColor = {r = 255, g = 255, b = 255, a = 255}
		menus[id].menuBackgroundColor = {r = 0, g = 0, b = 0, a = 100}
		menus[id].subTitleBackgroundColor = {
			r = menus[id].menuBackgroundColor.r,
			g = menus[id].menuBackgroundColor.g,
			b = menus[id].menuBackgroundColor.b,
			a = 255
		}
		menus[id].buttonPressedSound = {name = "~h~~r~> ~s~SELECT", set = "HUD_FRONTEND_DEFAULT_SOUNDSET"}
		debugPrint(tostring(id) .. " menu created")
	end

	function GH.CreateSubMenu(id, parent, subTitle)
		if menus[parent] then
			GH.CrateMenu(id, menus[parent].title)
			if subTitle then
				setMenuProperty(id, "subTitle", (subTitle))
			else
				setMenuProperty(id, "subTitle", (menus[parent].subTitle))
			end
			setMenuProperty(id, "previousMenu", parent)
			setMenuProperty(id, "x", menus[parent].x)
			setMenuProperty(id, "y", menus[parent].y)
			setMenuProperty(id, "maxOptionCount", menus[parent].maxOptionCount)
			setMenuProperty(id, "titleFont", menus[parent].titleFont)
			setMenuProperty(id, "titleColor", menus[parent].titleColor)
			setMenuProperty(id, "titleBackgroundColor", menus[parent].titleBackgroundColor)
			setMenuProperty(id, "titleBackgroundSprite", menus[parent].titleBackgroundSprite)
			setMenuProperty(id, "menuTextColor", menus[parent].menuTextColor)
			setMenuProperty(id, "menuSubTextColor", menus[parent].menuSubTextColor)
			setMenuProperty(id, "menuFocusTextColor", menus[parent].menuFocusTextColor)
			setMenuProperty(id, "menuFocusBackgroundColor", menus[parent].menuFocusBackgroundColor)
			setMenuProperty(id, "menuBackgroundColor", menus[parent].menuBackgroundColor)
			setMenuProperty(id, "subTitleBackgroundColor", menus[parent].subTitleBackgroundColor)
		else
			debugPrint("Failed to create " .. tostring(id) .. " submenu: " .. tostring(parent) .. " parent menu doesn't exist")
		end
	end

	function GH.CurrentMenu()
		return currentMenu
	end

	function GH.OpenMenu(id)
		if id and menus[id] then
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
			setMenuVisible(id, true)
			if menus[id].titleBackgroundSprite then
				RequestStreamedTextureDict(menus[id].titleBackgroundSprite.dict, false)
				while not HasStreamedTextureDictLoaded(menus[id].titleBackgroundSprite.dict) do
					Citizen.Wait(0)
				end
			end
			debugPrint(tostring(id) .. " menu opened")
		else
			debugPrint("Failed to open " .. tostring(id) .. " menu: it doesn't exist")
		end
	end

	function GH.IsMenuOpened(id)
		return isMenuVisible(id)
	end

	function GH.IsAnyMenuOpened()
		for id, _ in pairs(menus) do
			if isMenuVisible(id) then
				return true
			end
		end

		return false
	end

	function GH.IsMenuAboutToBeClosed()
		if menus[currentMenu] then
			return menus[currentMenu].aboutToBeClosed
		else
			return false
		end
	end

	function GH.CloseMenu()
		if menus[currentMenu] then
			if menus[currentMenu].aboutToBeClosed then
				menus[currentMenu].aboutToBeClosed = false
				setMenuVisible(currentMenu, false)
				debugPrint(tostring(currentMenu) .. " menu closed")
				PlaySoundFrontend(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
				optionCount = 0
				currentMenu = nil
				currentKey = nil
			else
				menus[currentMenu].aboutToBeClosed = true
				debugPrint(tostring(currentMenu) .. " menu about to be closed")
			end
		end
	end

	function GH.Button(text, subText)
		local buttonText = text
		if subText then
			buttonText = "{ " .. tostring(buttonText) .. ", " .. tostring(subText) .. " }"
		end
		if menus[currentMenu] then
			optionCount = optionCount + 1
			local isCurrent = menus[currentMenu].currentOption == optionCount
			drawButton(text, subText)
			if isCurrent then
				if currentKey == keys.select then
					PlaySoundFrontend(-1, menus[currentMenu].buttonPressedSound.name, menus[currentMenu].buttonPressedSound.set, true)
					debugPrint(buttonText .. " button pressed")
					return true
				elseif currentKey == keys.left or currentKey == keys.right then
					PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
				end
			end
			return false
		else
			debugPrint("Failed to create " .. buttonText .. " button: " .. tostring(currentMenu) .. " menu doesn't exist")
			return false
		end
	end

	function GH.MenuButton(text, id)
		if menus[id] then
			if GH.Button(text) then
				setMenuVisible(currentMenu, false)
				setMenuVisible(id, true, true)
				return true
			end
		else
			debugPrint("Failed to create " .. tostring(text) .. " menu button: " .. tostring(id) .. " submenu doesn't exist")
		end
		return false
	end

	function GH.CheckBox(text, bool, callback)
		local checked = "~r~~h~OFF"
		if bool then
			checked = "~g~~h~ON"
		end
		if GH.Button(text, checked) then
			bool = not bool
			debugPrint(tostring(text) .. " checkbox changed to " .. tostring(bool))
			callback(bool)
			return true
		end
		return false
	end

	function GH.ComboBox(text, items, currentIndex, selectedIndex, callback)
		local itemsCount = #items
		local selectedItem = items[currentIndex]
		local isCurrent = menus[currentMenu].currentOption == (optionCount + 1)
		if itemsCount > 1 and isCurrent then
			selectedItem = '← '..tostring(selectedItem)..' →'
		end
		if GH.Button(text, selectedItem) then
			selectedIndex = currentIndex
			callback(currentIndex, selectedIndex)
			return true
		elseif isCurrent then
			if currentKey == keys.left then
				if currentIndex > 1 then
					currentIndex = currentIndex - 1
				else
					currentIndex = itemsCount
				end
			elseif currentKey == keys.right then
				if currentIndex < itemsCount then
					currentIndex = currentIndex + 1
				else
					currentIndex = 1
				end
			end
		else
			currentIndex = selectedIndex
		end
		callback(currentIndex, selectedIndex)
		return false
	end

	function ServerEvent(a,b,c,d,e,f,g,h,i,m)
		TriggerServerEvent(a,b,c,d,e,f,g,h,i,m)
	end

	function TE(a,b,c,d,e,f,g,h,i,m)
		TriggerEvent(a,b,c,d,e,f,g,h,i,m)
	end

	function GH.Display()
		if isMenuVisible(currentMenu) then
			if menus[currentMenu].aboutToBeClosed then
				GH.CloseMenu()
			else
				ClearAllHelpMessages()
				drawTitle()
				drawSubTitle()
				currentKey = nil
				if IsDisabledControlJustPressed(0, keys.down) then
					PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)

					if menus[currentMenu].currentOption < optionCount then
						menus[currentMenu].currentOption = menus[currentMenu].currentOption + 1
					else
						menus[currentMenu].currentOption = 1
					end
				elseif IsDisabledControlJustPressed(0, keys.up) then
					PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)

					if menus[currentMenu].currentOption > 1 then
						menus[currentMenu].currentOption = menus[currentMenu].currentOption - 1
					else
						menus[currentMenu].currentOption = optionCount
					end
				elseif IsDisabledControlJustPressed(0, keys.left) then
					currentKey = keys.left
				elseif IsDisabledControlJustPressed(0, keys.right) then
					currentKey = keys.right
				elseif IsDisabledControlJustPressed(0, keys.select) then
					currentKey = keys.select
				elseif IsDisabledControlJustPressed(0, keys.back) then
					if menus[menus[currentMenu].previousMenu] then
						PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
						setMenuVisible(menus[currentMenu].previousMenu, true)
					else
						GH.CloseMenu()
					end
				end
				optionCount = 0
			end
		end
	end

	function GH.SetMenuWidth(id, width)
		setMenuProperty(id, "width", width)
	end

	function GH.SetMenuX(id, x)
		setMenuProperty(id, "x", x)
	end

	function GH.SetMenuY(id, y)
		setMenuProperty(id, "y", y)
	end

	function GH.SetMenuMaxOptionCountOnScreen(id, count)
		setMenuProperty(id, "maxOptionCount", count)
	end

	function GH.SetTitleColor(id, r, g, b, a)
		setMenuProperty(id, "titleColor", {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].titleColor.a})
	end

	function GH.SetTitleBackgroundColor(id, r, g, b, a)
		setMenuProperty(
			id,
			"titleBackgroundColor",
			{["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].titleBackgroundColor.a}
		)
	end

	function GH.SetTitleBackgroundSprite(id, textureDict, textureName)
		setMenuProperty(id, "titleBackgroundSprite", {dict = textureDict, name = textureName})
	end

	function GH.SetSubTitle(id, text)
		setMenuProperty(id, "subTitle", (text))
	end


	function GH.SetMenuBackgroundColor(id, r, g, b, a)
		setMenuProperty(
			id,
			"menuBackgroundColor",
			{["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuBackgroundColor.a}
		)
	end

	function GH.SetMenuTextColor(id, r, g, b, a)
		setMenuProperty(id, "menuTextColor", {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuTextColor.a})
	end

	function GH.SetMenuSubTextColor(id, r, g, b, a)
		setMenuProperty(id, "menuSubTextColor", {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuSubTextColor.a})
	end

	function GH.SetMenuFocusColor(id, r, g, b, a)
		setMenuProperty(id, "menuFocusColor", {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuFocusColor.a})
	end

	function GH.SetMenuButtonPressedSound(id, name, set)
		setMenuProperty(id, "buttonPressedSound", {["name"] = name, ["set"] = set})
	end

	function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
		AddTextEntry("FMMC_KEY_TIP1", TextEntry .. ":")
		DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
		blockinput = true
		while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
			Citizen.Wait(0)
		end
		if UpdateOnscreenKeyboard() ~= 2 then
			AddTextEntry("FMMC_KEY_TIP1", "")
			local result = GetOnscreenKeyboardResult()
			Citizen.Wait(500)
			blockinput = false
			return result
		else
			AddTextEntry("FMMC_KEY_TIP1", "")
			Citizen.Wait(500)
			blockinput = false
			return nil
		end
	end

	function math.round(num, numDecimalPlaces)
		return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
	end

	function RGBRainbow(frequency)
		local result = {}
		local curtime = GetGameTimer() / 1000
		result.r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
		result.g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
		result.b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)
		return result
	end

	local mainMenu = "Greek";
	local MenuTitle = title;
	local adminMenu = "SelfMenu";
	local serverOptions = "serverOptions";
	local playerOptions = "playerOptions";
	local vehMenu = "VehicleMenu";

	local function repairvehicle()
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false);
		SetVehicleFixed(vehicle);
		SetVehicleDirtLevel(vehicle, 0.0);
		SetVehicleLights(vehicle, 0);
		SetVehicleBurnout(vehicle, false);
		SetVehicleHeadlightShadows(vehicle, 0);
		SetVehicleUndriveable(vehicle, false);
		SetVehicleDeformationFixed(vehicle);
	end

	onBanList = false;

	openBanList = function()
		onBanList = true;
		TriggerServerEvent("getAntiCheatBans");
	end
	
	whitelistIp = function()
		onIpList = true;
		TriggerServerEvent("getWhiteListIps");
	end
	
	acKeyboardInput = function(Label)
		globalValue = nil;
		ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'acbans', {
			title = Label
		}, function(data, menu)
			local msg = data.value;
			if msg == nil or msg == "" then
				ESX.ShowNotification("Invalid message");
				globalValue = "";
			else
				acSetValue(msg);
				menu.close();
			end
		end, function(data,menu)
			menu.close();
			globalValue = "";
		end)
		while (globalValue == nil) do
			Wait(150);
		end
		if globalValue ~= nil then
			return globalValue;
		end
	end

	acSetValue = function(val)
		globalValue = val;
	end

	RegisterNetEvent("openBansMenu", function(data)
		if data then
			local elements = {};
			table.insert(elements, {label = "Search By Name", value = "search_"});
			for k,v in pairs(data) do
				table.insert(elements, {label = v.targetplayername.." | "..v.reason, name = v.targetplayername, value = v.identifier});
			end
			ESX.UI.Menu.CloseAll();
			ESX.UI.Menu.Open("default", GetCurrentResourceName(), "greek",
			{
				title    = "AntiCheat Bans",
				align    = "bottom-right",
				elements = elements
			}, function(data, menu)
				local val = data.current.value;
				
				if val == "search_" then
					local name = acKeyboardInput("Type a name");
					
					if (name == "") or (name == nil) then
						ESX.UI.Menu.CloseAll();
						onBanList = false;
						ESX.ShowNotification("Χμμ.. ίσως την επόμενη φορά!");
						return;
					end
					
					TriggerServerEvent("openBansByName", name);
				else
					local elements2 = {}
					local steam = data.current.value;
					local name = data.current.name;
					table.insert(elements2, {label = "YES", value = "YES"});
					table.insert(elements2, {label = "NO", value = "NO"});
					ESX.UI.Menu.CloseAll();
					ESX.UI.Menu.Open("default", GetCurrentResourceName(), "greek",
					{
						title    = "Do you want to unban him?",
						align    = "bottom-right",
						elements = elements2
					}, function(data2, menu)
						if data2.current.value == "YES" then
							TriggerServerEvent("antiCheatUnban", steam, name);
							onBanList = false;
						else
							onBanList = false;
							ESX.UI.Menu.CloseAll();
						end
					end, function(data2, menu2)
						onBanList = false;
						menu2.close();
					end)
				end
			end, function(data, menu)
				onBanList = false;
				menu.close();
			end)
		else
			onBanList = false;
			ESX.ShowNotification("No bans detected on database");
		end
	end)
	
	RegisterNetEvent("openIpsMenu", function(data)
		if data then
			local elements = {};
			table.insert(elements, {label = "<font color='green'>Add IP</font>", value = "add"});
			for k,v in pairs(data) do
				table.insert(elements, {label = k.." | "..v, value = k});
			end
			ESX.UI.Menu.CloseAll();
			ESX.UI.Menu.Open("default", GetCurrentResourceName(), "greek",
			{
				title    = "Whitelist Ips",
				align    = "bottom-right",
				elements = elements
			}, function(data, menu)
				local val = data.current.value;
				
				if val ~= "add" then
					local elements2 = {};
					local ip = data.current.value;
					
					table.insert(elements2, {label = "Remove whitelist from: "..ip, value = "YES"});
					table.insert(elements2, {label = "<font color='red'>Cancel</font>", value = "NO"});
					ESX.UI.Menu.CloseAll();
					ESX.UI.Menu.Open("default", GetCurrentResourceName(), "greek",
					{
						title    = "Do you want to unban him?",
						align    = "bottom-right",
						elements = elements2
					}, function(data2, menu)
						if data2.current.value == "YES" then
							TriggerServerEvent("removeWhitelistIp", ip);
							onIpList = false;
							Wait(200);
							TriggerServerEvent("getWhiteListIps");
						else
							TriggerServerEvent("getWhiteListIps");
						end
					end, function(data2, menu2)
						onIpList = false;
						menu2.close();
					end)
				else
					local ip = acKeyboardInput("Type an ip");
					
					if (ip == "") or (ip == nil) then
						ESX.UI.Menu.CloseAll();
						onIpList = false;
						ESX.ShowNotification("Χμμ.. ίσως την επόμενη φορά!");
						return;
					end
					
					TriggerServerEvent("whitelistIp", ip);
					Wait(200);
					TriggerServerEvent("getWhiteListIps");
				end
			end, function(data, menu)
				onIpList = false;
				menu.close();
			end)
		else
			onIpList = false;
			ESX.ShowNotification("Failed to load ips!");
		end
	end)

	CreateThread(function()
		while greekGroup == nil do
			Wait(100)
		end
		if greekGroup == "user" then
			return
		end
		canOpen = false;
		for s,g in pairs(Greek.menuwhitelist) do
			if g == greekGroup then
				canOpen = true;
			end
		end
		if not canOpen then
			return
		end
		FreezeEntityPosition(entity, false);
		local playerIdxWeapon = 1;
		local showblip = false;
		local WeaponTypeSelect = nil
		local WeaponSelected = nil
		local ModSelected = nil
		local currentItemIndex = 1
		local selectedItemIndex = 1
		local powerboost = { 1.0, 2.0, 4.0, 10.0, 512.0, 9999.0 }
		local spawninside = false;
		GH.CrateMenu(mainMenu, MenuTitle)
		GH.CreateSubMenu(adminMenu, mainMenu, bytexd)
		GH.CreateSubMenu(serverOptions, mainMenu, bytexd)
		GH.CreateSubMenu(playerOptions, mainMenu, bytexd)
		GH.CreateSubMenu(vehMenu, mainMenu, bytexd)
		
		local enabled_ = false;
		RegisterCommand("acMenu", function(arg1, args2)
			GH.OpenMenu(mainMenu);
			GH.Display();
		end)
		
		while Enabled do
			if GH.IsMenuOpened(mainMenu) then
				if GH.MenuButton("~h~~p~#~s~ Admin Menu", adminMenu) then
					--
				elseif GH.MenuButton("~h~~p~#~s~ Vehicle Menu", vehMenu) then
					--
				elseif GH.MenuButton("~h~~p~#~s~ Server Options", serverOptions) then
					--
				elseif GH.MenuButton("~h~~p~#~s~ Player Options", playerOptions) then
				
				end
				GH.Display();
			elseif GH.IsMenuOpened(adminMenu) then
				if GH.Button("~y~Screenshot") then
					local id = KeyboardInput("Id", "", 5)
					if id ~= nil then
						TriggerServerEvent("screenshot:req", id)
					end
				elseif GH.Button("~r~AntiCheat BanList") then
					openBanList();
					while onBanList do
						Wait(1000);
					end
				elseif GH.Button("~b~Whitelist net ip") then
					whitelistIp();
					while onIpList do
						Wait(1000);
					end
				end
				GH.Display()
			elseif IsControlJustPressed(0, Greek.menuOpenKey)  then
				GH.OpenMenu(mainMenu)
				GH.Display()
				
	    	elseif GH.IsMenuOpened(vehMenu) then
	    		if GH.Button("~r~SetMe ~w~Driver") then
	    			local vehicle = ESX.Game.GetClosestVehicle();
					
					if IsVehicleSeatFree(vehicle,-1) then
						SetPedIntoVehicle(PlayerPedId(), vehicle, -1);
	    	    		notify("~g~You are Driving Closest Car~g~")
	    			end
	    		elseif GH.Button("~h~~r~Delete ~s~Vehicle") then
					DeleteEntity(GetVehiclePedIsUsing(PlayerPedId()))
				elseif GH.Button("~h~~g~Repair ~s~Vehicle") then
					repairvehicle()
				end
				GH.Display();
				
			elseif GH.IsMenuOpened(serverOptions) then
				if GH.Button("Prop logger", "~r~Entities") then
					if enabled_ == false then
						enabled_ = true
						TriggerServerEvent("props:log")
						ESX.ShowNotification("~g~Check F8 for Props")
					else
						enabled_ = false
						TriggerServerEvent("props:log")
						ESX.ShowNotification("~r~Logger Is Disabled")
					end
				elseif GH.Button("Prop List", "~r~Entities") then
					openPropList();
					while not ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "dddddd") do
						Wait(300);
					end
					--
					while ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "dddddd") or ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "ffffff") do
						Wait(300);
					end
				elseif GH.Button("Delete Objects", "~r~Entities") then
					local radius = KeyboardInput("Radius", "", 5);
					
					if radius then
						ExecuteCommand("clearobj "..radius);
					end
				elseif GH.Button("Delete Vehicles", "~r~Entities") then
					local radius = KeyboardInput("Radius", "", 5);
					
					if radius then
						ExecuteCommand("clearveh "..radius);
					end
				elseif GH.Button("Delete Peds", "~r~Entities") then
					local radius = KeyboardInput("Radius", "", 5);
					
					if radius then
						ExecuteCommand("clearpeds "..radius);
					end
				end
				GH.Display()
			elseif GH.IsMenuOpened(playerOptions) then
				if GH.Button("Get New Players", "~r~New players") then
					TriggerServerEvent("getNewPlayers");
				elseif GH.Button("Get New Discords", "~r~New discords") then
					TriggerServerEvent("getNewDiscords");
				end
				GH.Display()
	    	end
			Wait(0)
		end
	end)
	
	showNewPlayers = function(data)
		local elements = {}
		
		ESX.UI.Menu.CloseAll()
		elements = {
			head = {'ID', 'Name', 'Playtime (Hours)', 'Goto Player', 'Kick Player'},
			rows = {}
		}

		for k, v in pairs(data) do
			local gotoButton = '{{Goto|goto}}';
			local kickButton = '{{Kick|kick}}';
			local playTimeTxt = v.playTime;
			if tonumber(v.playTime) == 0 then
				playTimeTxt = "First Session";
			end

			table.insert(elements.rows, {
				data = v,
				cols = {
					v.id,
					v.name,
					playTimeTxt,
					gotoButton,
					kickButton,
				}
			})
		end

		ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'menu', elements, function(data, menu)
			if (data.value ~= nil) then
				
				if data.value == "goto" then
					ExecuteCommand("goto "..data.data.id);
				elseif data.value == "kick" then
					ExecuteCommand("kick "..data.data.id.." Kicked by staff");
				end
				
			else
				menu.close();
			end
		end, function(data, menu)
			menu.close();
		end)
	end

	RegisterNetEvent("showNewPlayers", showNewPlayers);

	showNewDiscords = function(data)
		local elements = {}
		
		ESX.UI.Menu.CloseAll()
		elements = {
			head = {'ID', 'Name', 'Discord ID', 'Creation Date', 'Goto Player', 'Kick Player'},
			rows = {}
		}

		for k, v in pairs(data) do
			local creationDate = v.creationDate;
			local gotoButton = '{{Goto|goto}}';
			local kickButton = '{{Kick|kick}}';

			table.insert(elements.rows, {
				data = v,
				cols = {
					v.id,
					v.name,
					v.discordID or 'N/A',
					v.creationLabel or 'N/A',
					gotoButton,
					kickButton,
				}
			})
		end

		ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'menu', elements, function(data, menu)
			if (data.value ~= nil) then
				if data.value == "goto" then
					ExecuteCommand("goto "..data.data.id);
				elseif data.value == "kick" then
					ExecuteCommand("kick "..data.data.id.." Kicked by staff");
				end
			else
				menu.close();
			end
		end, function(data, menu)
			menu.close();
		end)
	end

	RegisterNetEvent("showNewDiscords", showNewDiscords);
	
	openPropList = function()
		TriggerServerEvent("getServerProps");
	end
	
	openPropMenu = function(list)
		if list then
			local elements = {};
			for k,v in pairs(list) do
				table.insert(elements, {label = k, name = v.hash, value = v.coords});
			end
			ESX.UI.Menu.CloseAll();
			ESX.UI.Menu.Open("default", GetCurrentResourceName(), "dddddd",
			{
				title    = "Server Props",
				align    = "bottom-right",
				elements = elements
			}, function(data, menu)
				if data.current.value ~= nil then
					local elements2 = {}
					local coords = data.current.value;
					local name = data.current.label;
					
					table.insert(elements2, {label = "Goto Prop", value = "goto"});
					table.insert(elements2, {label = "Delete Prop", value = "delete"});
					
					--ESX.UI.Menu.CloseAll();
					ESX.UI.Menu.Open("default", GetCurrentResourceName(), "ffffff",
					{
						title    = "Prop Editing",
						align    = "bottom-right",
						elements = elements2
					}, function(data2, menu2)
						if data2.current.value == "goto" then
							SetEntityCoords(PlayerPedId(), load("return "..coords)());
						elseif data2.current.value == "delete" then
							TriggerServerEvent("deleteProp", name);
							menu2.close();
						else
							ESX.UI.Menu.CloseAll();
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				end
			end, function(data, menu)
				menu.close()
			end)
		end
	end
	
	RegisterNetEvent("openPropMenu", openPropMenu);

	RegisterNetEvent("AC:cleanareavehy")
	AddEventHandler("AC:cleanareavehy", function()
		for vehicle in EnumerateVehicles() do
			SetEntityAsMissionEntity(GetVehiclePedIsIn(vehicle, true), 1, 1)
			DeleteEntity(GetVehiclePedIsIn(vehicle, true))
		    SetEntityAsMissionEntity(vehicle, 1, 1)
			DeleteEntity(vehicle)
		end
	end)

	RegisterNetEvent("AC:cleanareaentityy")
	AddEventHandler("AC:cleanareaentityy", function()
		objst = 0
		for obj in EnumerateObjects() do
			objst = objst + 1
			DeleteEntity(obj)
		end
	end)

	RegisterNetEvent("AC:openmenuy")
	AddEventHandler("AC:openmenuy", function()
		GH.OpenMenu(mainMenu)
	end)

	function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
		AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
		DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
		blockinput = true 
		while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
			Citizen.Wait(0)
		end
		if UpdateOnscreenKeyboard() ~= 2 then
			local result = GetOnscreenKeyboardResult()
			Citizen.Wait(500)
			blockinput = false
			return result
		else
			Citizen.Wait(500)
			blockinput = false
			return nil
		end
	end

	function notify(text)
	    SetNotificationTextEntry("STRING")
	    AddTextComponentString(text)
	    DrawNotification(true, true)
	end

end)
