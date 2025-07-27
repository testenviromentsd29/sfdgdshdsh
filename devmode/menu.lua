
local createdMenus = false
local ESPEnabled = false
local RainbowVeh = false
local NoclipActive = false
local allMenus = {}
local hasFastRun = false
local hasVehicleDrift = false
local menus = {}
local hasSuperjump = false
Behavior = {
    Menu = {
        ArrowColor = "~w~",
        Width      = 0.225,
        titleColor = { r = 255, g = 255, b = 255, a = 200 },
        titleBackgroundColor = { r = 40, g = 110, b = 201, a = 200 } , --background color title
        menuTextColor = { r = 255, g = 255, b = 255, a = 200 },
        menuSubTextColor = { r = 255, g = 255, b = 255, a = 200 },
        menuFocusTextColor = { r = 0, g = 0, b = 0, a = 255 },
        menuFocusBackgroundColor = { r = 255, g = 255, b = 255, a = 180 },
        menuBackgroundColor = { r = 0, g = 0, b = 0, a = 220 },
        subTitleBackgroundColor = { r = 40, g = 110, b = 201, a = 200 } , --background color title
    },
    Nametags = {
        R = 255,
        G = 255,
        B = 255,
        TalkingR = 255,
        TalkingG = 0,
        TalkingB = 0,
        displayIDHeight = 1.0, --Height of ID above players head(starts at center body mass)
        playerNamesDist = 60
    },
    Blips = {
        Scale = 1.0,
        --[[ Normal ]]
        Sprite = 1,
        Colour = 4,
        --[[ In Vehicle ]]
        VehicleSprite = 1,
        VehicleColor = 3,
        --[[ Dead ]]
        DeadColor = 1,
    }
}
local MenuLogic = {}
MenuLogic.Settings = {}
MenuLogic.Settings.currentMenuX = 1
MenuLogic.Settings.selectedMenuX = 1
MenuLogic.Settings.currentMenuY = 1
MenuLogic.Settings.selectedMenuY = 1
MenuLogic.Settings.titleHeight = 0.07
MenuLogic.Settings.titleYOffset = 0.03
MenuLogic.Settings.titleScale = 1.0
MenuLogic.Settings.buttonHeight = 0.038
MenuLogic.Settings.buttonFont = 0
MenuLogic.Settings.buttonScale = 0.365
MenuLogic.Settings.buttonTextXOffset = 0.005
MenuLogic.Settings.buttonTextYOffset = 0.005
MenuLogic.Settings.showNameTags = false
MenuLogic.Settings.showCoords = false
MenuLogic.Settings.showMapInfo = false
MenuLogic.Settings.showBlips = false
MenuLogic.Settings.showVehicleInfo = false

local menuX = { 0.75, 0.025, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7 }
local menuY = { 0.1, 0.025, 0.2, 0.3, 0.425 }
local menus = { }

local keys = { up = 172, down = 173, left = 174, right = 175, select = 215, back = 194 }
local optionCount = 0


local currentKey = nil
local currentMenu = nil


function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

local function setMenuProperty(id, property, value)
    if id and menus[id] then
        menus[id][property] = value
    end
end

function MenuLogic.SetSpriteColor(id, r, g, b, a)
    setMenuProperty(id, 'spriteColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuBackgroundColor.a })
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
            SetTextWrap(menus[currentMenu].x, menus[currentMenu].x + menus[currentMenu].width - MenuLogic.Settings.buttonTextXOffset)
            SetTextRightJustify(true)
        end
    end

    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x, y)
end

local function drawRect(x, y, width, height, color)
    DrawRect(x, y, width, height, color.r, color.g, color.b, color.a)
end

local function drawTitle()
    if menus[currentMenu] then
        local x = menus[currentMenu].x + menus[currentMenu].width / 2
        local y = menus[currentMenu].y + MenuLogic.Settings.titleHeight / 2 
        if menus[currentMenu].titleBackgroundSprite then
            DrawSprite(menus[currentMenu].titleBackgroundSprite.dict, menus[currentMenu].titleBackgroundSprite.name, x, y, menus[currentMenu].width, MenuLogic.Settings.titleHeight, 0., 255, 255, 255, 255)
        else
            drawRect(x, y, menus[currentMenu].width, MenuLogic.Settings.titleHeight, menus[currentMenu].titleBackgroundColor)
        end

        drawText(menus[currentMenu].title, x, y - MenuLogic.Settings.titleHeight / 2 + MenuLogic.Settings.titleYOffset + 0.02, menus[currentMenu].titleFont, menus[currentMenu].titleColor, MenuLogic.Settings.titleScale, true)
    end
end

local function drawSubTitle()
    if menus[currentMenu] then
        local x = menus[currentMenu].x + menus[currentMenu].width / 2
        local y = menus[currentMenu].y + MenuLogic.Settings.titleHeight + MenuLogic.Settings.buttonHeight / 2

        local subTitleColor = { r = 223, g = 3, b = 252, a = 0 }

        drawRect(x, y, menus[currentMenu].width, MenuLogic.Settings.buttonHeight, menus[currentMenu].subTitleBackgroundColor)
        drawText(menus[currentMenu].subTitle, menus[currentMenu].x + MenuLogic.Settings.buttonTextXOffset, y - MenuLogic.Settings.buttonHeight / 2 + MenuLogic.Settings.buttonTextYOffset, MenuLogic.Settings.buttonFont, subTitleColor, MenuLogic.Settings.buttonScale, false)

        if optionCount > menus[currentMenu].maxOptionCount then
            drawText(tostring(menus[currentMenu].currentOption).." / "..tostring(optionCount), menus[currentMenu].x + menus[currentMenu].width, y - MenuLogic.Settings.buttonHeight / 2 + MenuLogic.Settings.buttonTextYOffset, MenuLogic.Settings.buttonFont, subTitleColor, MenuLogic.Settings.buttonScale, false, false, true)
        end
    end
end

local function drawButton(text, subText)
    local x = menus[currentMenu].x + menus[currentMenu].width / 2
    local multiplier = nil

    if menus[currentMenu].currentOption <= menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].maxOptionCount then
        multiplier = optionCount
    elseif optionCount > menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].currentOption then
        multiplier = optionCount - (menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount)
    end

    if multiplier then
        local y = menus[currentMenu].y + MenuLogic.Settings.titleHeight + MenuLogic.Settings.buttonHeight + (MenuLogic.Settings.buttonHeight * multiplier) - MenuLogic.Settings.buttonHeight / 2
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
            --shadow = true
        end
        
        drawRect(x, y, menus[currentMenu].width, MenuLogic.Settings.buttonHeight, backgroundColor)
        drawText(text, menus[currentMenu].x + MenuLogic.Settings.buttonTextXOffset, y - (MenuLogic.Settings.buttonHeight / 2) + MenuLogic.Settings.buttonTextYOffset, MenuLogic.Settings.buttonFont, textColor, MenuLogic.Settings.buttonScale, false, shadow)

        if subText then
            drawText(subText, menus[currentMenu].x + MenuLogic.Settings.buttonTextXOffset, y - MenuLogic.Settings.buttonHeight / 2 + MenuLogic.Settings.buttonTextYOffset, MenuLogic.Settings.buttonFont, subTextColor, MenuLogic.Settings.buttonScale, false, shadow, true)
        end
    end
end

function MenuLogic.CreateMenu(id, title)
    menus[id] = { }
    menus[id].title = title

    menus[id].visible = false

    menus[id].previousMenu = nil

    menus[id].aboutToBeClosed = false
    
    menus[id].x = 0.75  
    
    menus[id].y = 0.1
    menus[id].width = Behavior.Menu.Width
    if id == "Main Peds" or id == "Animals" or id == "Main Peds" or id == "Male Peds" or id == "Female Peds" or id == "Other Peds" then
        menus[id].width = 0.35
        menus[id].x = 0.6  
    end
    menus[id].currentOption = 1
    menus[id].maxOptionCount = 13

    menus[id].titleFont = 1
    menus[id].titleColor = Behavior.Menu.titleColor
    menus[id].titleBackgroundColor = Behavior.Menu.titleBackgroundColor
    menus[id].titleBackgroundSprite = nil

    menus[id].menuTextColor = Behavior.Menu.menuTextColor
    menus[id].menuSubTextColor = Behavior.Menu.menuSubTextColor
    menus[id].menuFocusTextColor = Behavior.Menu.menuFocusTextColor
    menus[id].menuFocusBackgroundColor = Behavior.Menu.menuFocusBackgroundColor
    menus[id].menuBackgroundColor = Behavior.Menu.menuBackgroundColor

    menus[id].subTitleBackgroundColor = Behavior.Menu.subTitleBackgroundColor

    menus[id].buttonPressedSound = { name = "SELECT", set = "HUD_FRONTEND_DEFAULT_SOUNDSET" }
end

function MenuLogic.CreateSubMenu(id, parent, subTitle)
    if menus[parent] then
        table.insert(allMenus,id)
        MenuLogic.CreateMenu(id, menus[parent].title)

        if subTitle then
            setMenuProperty(id, "subTitle", string.upper(subTitle))
        else
            setMenuProperty(id, "subTitle", string.upper(menus[parent].subTitle))
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
        if id == "Main Peds" or id == "Animals" or id == "Main Peds" or id == "Male Peds" or id == "Female Peds" or id == "Other Peds" then
            setMenuProperty(id, "width", 0.35)
            if menus[parent].x > 0.6 then
                setMenuProperty(id, "x", 0.6)
            end
        end
    else
    end
end

function MenuLogic.CurrentMenu()
    return currentMenu
end

function MenuLogic.IsMenuOpened(id)
    return isMenuVisible(id)
end

function MenuLogic.IsAnyMenuOpened()
    for id, _ in pairs(menus) do
        if isMenuVisible(id) then 
            return true 
        end
    end

    return false
end

function MenuLogic.IsMenuAboutToBeClosed()
    if menus[currentMenu] then
        return menus[currentMenu].aboutToBeClosed
    else
        return false
    end
end

function MenuLogic.CloseMenu()
    if menus[currentMenu] then
        if menus[currentMenu].aboutToBeClosed then
            menus[currentMenu].aboutToBeClosed = false
            setMenuVisible(currentMenu, false)
            PlaySoundFrontend(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
            optionCount = 0
            currentMenu = nil
            currentKey = nil
        else
            menus[currentMenu].aboutToBeClosed = true
        end
    end
end

function MenuLogic.Button(text, subText,object,cb)
    local buttonText = text
    if subText then
        buttonText = "{ "..tostring(buttonText)..", "..tostring(subText).." }"
    end

    if menus[currentMenu] then
        optionCount = optionCount + 1

        local isCurrent = menus[currentMenu].currentOption == optionCount

        drawButton(text, subText)

        if isCurrent then
            if currentKey == keys.select then
                PlaySoundFrontend(-1, menus[currentMenu].buttonPressedSound.name, menus[currentMenu].buttonPressedSound.set, true)
                if cb ~= nil then
                    cb(text,object)
                end
                return true
            elseif currentKey == keys.left or currentKey == keys.right then
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
            end
        end

        return false
    else

        return false
    end
end

function MenuLogic.MenuButton(text, id)
    if menus[id] then
        if MenuLogic.Button(text) then
            setMenuVisible(currentMenu, false)
            setMenuVisible(id, true, true)

            return true
        end
    else
    end

    return false
end

function OpenMenu(id)
    if id and menus[id] then
        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
        setMenuVisible(id, true)
    else
    end
end

function MenuLogic.CheckBox(text, checked, callback)
    if MenuLogic.Button(text, checked and "~r~~h~On" or "~h~~y~Off") then
        checked = not checked
        if callback then callback(checked) end

        return true
    end

    return false
end

function MenuLogic.ComboBox(text, items, currentIndex, selectedIndex, applyonchange, callback)
    local itemsCount = #items
    
    local selectedItem = items[currentIndex]
    local isCurrent = menus[currentMenu].currentOption == (optionCount + 1)
    --if itemsCount > 1 and isCurrent then
        selectedItem = "← "..tostring(selectedItem).." → / "..itemsCount
    --end
    if MenuLogic.Button(text, selectedItem) then
        selectedIndex = currentIndex
        callback(currentIndex, selectedIndex,true)
        return true
    elseif isCurrent then
        if currentKey == keys.left then
            if items[0] == nil then
                if currentIndex > 1 then currentIndex = currentIndex - 1 else currentIndex = itemsCount end
            else
                if currentIndex > 0 then currentIndex = currentIndex - 1 else currentIndex = itemsCount end
            end
            if applyonchange then
                callback(currentIndex, selectedIndex,true)
            end
        elseif currentKey == keys.right then
            if items[0] == nil then
                if currentIndex < itemsCount then currentIndex = currentIndex + 1 else currentIndex = 1 end
            else
                if currentIndex < itemsCount then currentIndex = currentIndex + 1 else currentIndex = 0 end
            end
            if applyonchange then
                callback(currentIndex, selectedIndex,true)
            end
        end
    else
        currentIndex = selectedIndex
    end
    if applyonchange ~= true then
        callback(currentIndex, selectedIndex)
    end
    return false
end

function MenuLogic.Display()
    if isMenuVisible(currentMenu) then
        if menus[currentMenu].aboutToBeClosed then
            MenuLogic.CloseMenu()
        else
            ClearAllHelpMessages()

            drawTitle()
            drawSubTitle()

            currentKey = nil

            if IsControlJustReleased(1, keys.down) then
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)

                if menus[currentMenu].currentOption < optionCount then
                    menus[currentMenu].currentOption = menus[currentMenu].currentOption + 1
                else
                    menus[currentMenu].currentOption = 1
                end
            elseif IsControlJustReleased(1, keys.up) then
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)

                if menus[currentMenu].currentOption > 1 then
                    menus[currentMenu].currentOption = menus[currentMenu].currentOption - 1
                else
                    menus[currentMenu].currentOption = optionCount
                end
            elseif IsControlJustReleased(1, keys.left) then
                currentKey = keys.left
            elseif IsControlJustReleased(1, keys.right) then
                currentKey = keys.right
            elseif IsControlJustReleased(1, keys.select) then
                currentKey = keys.select
            elseif IsControlJustReleased(1, keys.back) then
                if menus[menus[currentMenu].previousMenu] then
                    PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                    setMenuVisible(menus[currentMenu].previousMenu, true)
                else
                    MenuLogic.CloseMenu()
                end
            end

            optionCount = 0
        end
    end
end

function MenuLogic.SetMenuWidth(id, width)
    setMenuProperty(id, "width", width)
end

function MenuLogic.SetMenuX(id, x)
    setMenuProperty(id, "x", x)
end

function MenuLogic.SetMenuY(id, y)
    setMenuProperty(id, "y", y)
end

function MenuLogic.SetMenuMaxOptionCountOnScreen(id, count)
    setMenuProperty(id, "maxOptionCount", count)
end

function MenuLogic.SetTitle(id, title)
    setMenuProperty(id, "title", title)
end

function MenuLogic.SetTitleColor(id, r, g, b, a)
    setMenuProperty(id, "titleColor", { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].titleColor.a })
end

function MenuLogic.SetTitleBackgroundColor(id, r, g, b, a)
    setMenuProperty(id, "titleBackgroundColor", { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].titleBackgroundColor.a })
end

function MenuLogic.SetTitleBackgroundSprite(id, textureDict, textureName)
    RequestStreamedTextureDict(textureDict)
    setMenuProperty(id, "titleBackgroundSprite", { dict = textureDict, name = textureName })
end

function MenuLogic.SetSubTitle(id, text)
    setMenuProperty(id, "subTitle", string.upper(text))
end

function MenuLogic.SetMenuBackgroundColor(id, r, g, b, a)
    setMenuProperty(id, "menuBackgroundColor", { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuBackgroundColor.a })
end

function MenuLogic.SetMenuTextColor(id, r, g, b, a)
    setMenuProperty(id, "menuTextColor", { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuTextColor.a })
end

function MenuLogic.SetMenuSubTextColor(id, r, g, b, a)
    setMenuProperty(id, "menuSubTextColor", { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuSubTextColor.a })
end

function MenuLogic.SetMenuFocusColor(id, r, g, b, a)
    setMenuProperty(id, "menuFocusColor", { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuFocusColor.a })
end

function MenuLogic.SetMenuButtonPressedSound(id, name, set)
    setMenuProperty(id, "buttonPressedSound", { ["name"] = name, ["set"] = set })
end

function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end


function start_program()
    CreateThread(function()
        MenuLogic.CreateMenu("MainMenu", "OG Menu")
        createdMenus = true
    end)
end

start_program()

function createMainMenuThread()
    CreateThread(function()
        while MenuLogic.IsAnyMenuOpened() do
            if MenuLogic.IsMenuOpened("MainMenu") then
               --[[  MenuLogic.CheckBox("No Clip",NoclipActive,function(checked)
                    if hasTheMoney(1000) then
                        NoclipActive = checked
                        startNoclip()
                    end
                end) ]]
                MenuLogic.CheckBox("Drift Mode [LShift]",hasVehicleDrift,function(checked)
                    if hasTheMoney(1000) then
                        hasVehicleDrift = checked
                        startDrift()
                    end
                end)
                MenuLogic.CheckBox("Vehicle Jumping [Space]",hasVehicleGravity,function(checked)
                    if hasTheMoney(1000) then
                        hasVehicleGravity = checked
                        startNoGrav()
                    end
                end)
              --[[   MenuLogic.CheckBox("Fast Run",hasFastRun,function(checked)
                    if hasTheMoney(1000) then
                        hasFastRun = checked
                        startFastRun()
                    end
                end) ]]
                --[[ MenuLogic.CheckBox("ESP",ESPEnabled,function(checked)
                    if hasTheMoney(1000) then
                        ESPEnabled = checked
                        ToggleESP()
                    end
                end) ]]
                MenuLogic.CheckBox("Rainbow Vehicle",RainbowVeh,function(checked)
                    if hasTheMoney(1000) then
                        RainbowVeh = checked
                        startRainbow()
                    end
                end)
               --[[  MenuLogic.CheckBox("SuperJump",hasSuperjump,function(checked)
                    if hasTheMoney(1000) then

                        hasSuperjump = checked
                        startSuperJump()
                    end
                end) ]]
                --[[ if MenuLogic.Button("Teleport To Waypoint", "") then
					if hasTheMoney(5000000) then
                   		TPM()
					end
                end  ]]
            end
            MenuLogic.Display()
            Wait(0)
        end
    end)
end



































































function TPM()
    if IsWaypointActive() then
		TriggerServerEvent("devmode:paywaypoint")
        local WaypointHandle = GetFirstBlipInfoId(8)
        local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
        DoScreenFadeOut(10)
        for height = 1, 1000 do
            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)
    
            if foundGround then
                DoScreenFadeIn(1000)
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                ESX.ShowNotification("~g~Success:~w~ You have been Teleported")
                break
            end

            Citizen.Wait(5)
        end
    else
        ESX.ShowNotification("~r~Error:~w~ You didn't set a waypoint")
    end     
end     


Controls = {}

Controls.controls = {
	NextCamera = 0,
	LookLeftRight = 1,
	LookUpDown = 2,
	LookUpOnly = 3,
	LookDownOnly = 4,
	LookLeftOnly = 5,
	LookRightOnly = 6,
	CinematicSlowMo = 7,
	FlyUpDown = 8,
	FlyLeftRight = 9,
	ScriptedFlyZUp = 10,
	ScriptedFlyZDown = 11,
	WeaponWheelUpDown = 12,
	WeaponWheelLeftRight = 13,
	WeaponWheelNext = 14,
	WeaponWheelPrev = 15,
	SelectNextWeapon = 16,
	SelectPrevWeapon = 17,
	SkipCutscene = 18,
	CharacterWheel = 19,
	MultiplayerInfo = 20,
	Sprint = 21,
	Jump = 22,
	Enter = 23,
	Attack = 24,
	Aim = 25,
	LookBehind = 26,
	Phone = 27,
	SpecialAbility = 28,
	SpecialAbilitySecondary = 29,
	MoveLeftRight = 30,
	MoveUpDown = 31,
	MoveUpOnly = 32,
	MoveDownOnly = 33,
	MoveLeftOnly = 34,
	MoveRightOnly = 35,
	Duck = 36,
	SelectWeapon = 37,
	Pickup = 38,
	SniperZoom = 39,
	SniperZoomInOnly = 40,
	SniperZoomOutOnly = 41,
	SniperZoomInSecondary = 42,
	SniperZoomOutSecondary = 43,
	Cover = 44,
	Reload = 45,
	Talk = 46,
	Detonate = 47,
	HUDSpecial = 48,
	Arrest = 49,
	AccurateAim = 50,
	Context = 51,
	ContextSecondary = 52,
	WeaponSpecial = 53,
	WeaponSpecial2 = 54,
	Dive = 55,
	DropWeapon = 56,
	DropAmmo = 57,
	ThrowGrenade = 58,
	VehicleMoveLeftRight = 59,
	VehicleMoveUpDown = 60,
	VehicleMoveUpOnly = 61,
	VehicleMoveDownOnly = 62,
	VehicleMoveLeftOnly = 63,
	VehicleMoveRightOnly = 64,
	VehicleSpecial = 65,
	VehicleGunLeftRight = 66,
	VehicleGunUpDown = 67,
	VehicleAim = 68,
	VehicleAttack = 69,
	VehicleAttack2 = 70,
	VehicleAccelerate = 71,
	VehicleBrake = 72,
	VehicleDuck = 73,
	VehicleHeadlight = 74,
	VehicleExit = 75,
	VehicleHandbrake = 76,
	VehicleHotwireLeft = 77,
	VehicleHotwireRight = 78,
	VehicleLookBehind = 79,
	VehicleCinCam = 80,
	VehicleNextRadio = 81,
	VehiclePrevRadio = 82,
	VehicleNextRadioTrack = 83,
	VehiclePrevRadioTrack = 84,
	VehicleRadioWheel = 85,
	VehicleHorn = 86,
	VehicleFlyThrottleUp = 87,
	VehicleFlyThrottleDown = 88,
	VehicleFlyYawLeft = 89,
	VehicleFlyYawRight = 90,
	VehiclePassengerAim = 91,
	VehiclePassengerAttack = 92,
	VehicleSpecialAbilityFranklin = 93,
	VehicleStuntUpDown = 94,
	VehicleCinematicUpDown = 95,
	VehicleCinematicUpOnly = 96,
	VehicleCinematicDownOnly = 97,
	VehicleCinematicLeftRight = 98,
	VehicleSelectNextWeapon = 99,
	VehicleSelectPrevWeapon = 100,
	VehicleRoof = 101,
	VehicleJump = 102,
	VehicleGrapplingHook = 103,
	VehicleShuffle = 104,
	VehicleDropProjectile = 105,
	VehicleMouseControlOverride = 106,
	VehicleFlyRollLeftRight = 107,
	VehicleFlyRollLeftOnly = 108,
	VehicleFlyRollRightOnly = 109,
	VehicleFlyPitchUpDown = 110,
	VehicleFlyPitchUpOnly = 111,
	VehicleFlyPitchDownOnly = 112,
	VehicleFlyUnderCarriage = 113,
	VehicleFlyAttack = 114,
	VehicleFlySelectNextWeapon = 115,
	VehicleFlySelectPrevWeapon = 116,
	VehicleFlySelectTargetLeft = 117,
	VehicleFlySelectTargetRight = 118,
	VehicleFlyVerticalFlightMode = 119,
	VehicleFlyDuck = 120,
	VehicleFlyAttackCamera = 121,
	VehicleFlyMouseControlOverride = 122,
	VehicleSubTurnLeftRight = 123,
	VehicleSubTurnLeftOnly = 124,
	VehicleSubTurnRightOnly = 125,
	VehicleSubPitchUpDown = 126,
	VehicleSubPitchUpOnly = 127,
	VehicleSubPitchDownOnly = 128,
	VehicleSubThrottleUp = 129,
	VehicleSubThrottleDown = 130,
	VehicleSubAscend = 131,
	VehicleSubDescend = 132,
	VehicleSubTurnHardLeft = 133,
	VehicleSubTurnHardRight = 134,
	VehicleSubMouseControlOverride = 135,
	VehiclePushbikePedal = 136,
	VehiclePushbikeSprint = 137,
	VehiclePushbikeFrontBrake = 138,
	VehiclePushbikeRearBrake = 139,
	MeleeAttackLight = 140,
	MeleeAttackHeavy = 141,
	MeleeAttackAlternate = 142,
	MeleeBlock = 143,
	ParachuteDeploy = 144,
	ParachuteDetach = 145,
	ParachuteTurnLeftRight = 146,
	ParachuteTurnLeftOnly = 147,
	ParachuteTurnRightOnly = 148,
	ParachutePitchUpDown = 149,
	ParachutePitchUpOnly = 150,
	ParachutePitchDownOnly = 151,
	ParachuteBrakeLeft = 152,
	ParachuteBrakeRight = 153,
	ParachuteSmoke = 154,
	ParachutePrecisionLanding = 155,
	Map = 156,
	SelectWeaponUnarmed = 157,
	SelectWeaponMelee = 158,
	SelectWeaponHandgun = 159,
	SelectWeaponShotgun = 160,
	SelectWeaponSmg = 161,
	SelectWeaponAutoRifle = 162,
	SelectWeaponSniper = 163,
	SelectWeaponHeavy = 164,
	SelectWeaponSpecial = 165,
	SelectCharacterMichael = 166,
	SelectCharacterFranklin = 167,
	SelectCharacterTrevor = 168,
	SelectCharacterMultiplayer = 169,
	SaveReplayClip = 170,
	SpecialAbilityPC = 171,
	PhoneUp = 172,
	PhoneDown = 173,
	PhoneLeft = 174,
	PhoneRight = 175,
	PhoneSelect = 176,
	PhoneCancel = 177,
	PhoneOption = 178,
	PhoneExtraOption = 179,
	PhoneScrollForward = 180,
	PhoneScrollBackward = 181,
	PhoneCameraFocusLock = 182,
	PhoneCameraGrid = 183,
	PhoneCameraSelfie = 184,
	PhoneCameraDOF = 185,
	PhoneCameraExpression = 186,
	FrontendDown = 187,
	FrontendUp = 188,
	FrontendLeft = 189,
	FrontendRight = 190,
	FrontendRdown = 191,
	FrontendRup = 192,
	FrontendRleft = 193,
	FrontendRright = 194,
	FrontendAxisX = 195,
	FrontendAxisY = 196,
	FrontendRightAxisX = 197,
	FrontendRightAxisY = 198,
	FrontendPause = 199,
	FrontendPauseAlternate = 200,
	FrontendAccept = 201,
	FrontendCancel = 202,
	FrontendX = 203,
	FrontendY = 204,
	FrontendLb = 205,
	FrontendRb = 206,
	FrontendLt = 207,
	FrontendRt = 208,
	FrontendLs = 209,
	FrontendRs = 210,
	FrontendLeaderboard = 211,
	FrontendSocialClub = 212,
	FrontendSocialClubSecondary = 213,
	FrontendDelete = 214,
	FrontendEndscreenAccept = 215,
	FrontendEndscreenExpand = 216,
	FrontendSelect = 217,
	ScriptLeftAxisX = 218,
	ScriptLeftAxisY = 219,
	ScriptRightAxisX = 220,
	ScriptRightAxisY = 221,
	ScriptRUp = 222,
	ScriptRDown = 223,
	ScriptRLeft = 224,
	ScriptRRight = 225,
	ScriptLB = 226,
	ScriptRB = 227,
	ScriptLT = 228,
	ScriptRT = 229,
	ScriptLS = 230,
	ScriptRS = 231,
	ScriptPadUp = 232,
	ScriptPadDown = 233,
	ScriptPadLeft = 234,
	ScriptPadRight = 235,
	ScriptSelect = 236,
	CursorAccept = 237,
	CursorCancel = 238,
	CursorX = 239,
	CursorY = 240,
	CursorScrollUp = 241,
	CursorScrollDown = 242,
	EnterCheatCode = 243,
	InteractionMenu = 244,
	MpTextChatAll = 245,
	MpTextChatTeam = 246,
	MpTextChatFriends = 247,
	MpTextChatCrew = 248,
	PushToTalk = 249,
	CreatorLS = 250,
	CreatorRS = 251,
	CreatorLT = 252,
	CreatorRT = 253,
	CreatorMenuToggle = 254,
	CreatorAccept = 255,
	CreatorDelete = 256,
	Attack2 = 257,
	RappelJump = 258,
	RappelLongJump = 259,
	RappelSmashWindow = 260,
	PrevWeapon = 261,
	NextWeapon = 262,
	MeleeAttack1 = 263,
	MeleeAttack2 = 264,
	Whistle = 265,
	MoveLeft = 266,
	MoveRight = 267,
	MoveUp = 268,
	MoveDown = 269,
	LookLeft = 270,
	LookRight = 271,
	LookUp = 272,
	LookDown = 273,
	SniperZoomIn = 274,
	SniperZoomOut = 275,
	SniperZoomInAlternate = 276,
	SniperZoomOutAlternate = 277,
	VehicleMoveLeft = 278,
	VehicleMoveRight = 279,
	VehicleMoveUp = 280,
	VehicleMoveDown = 281,
	VehicleGunLeft = 282,
	VehicleGunRight = 283,
	VehicleGunUp = 284,
	VehicleGunDown = 285,
	VehicleLookLeft = 286,
	VehicleLookRight = 287,
	ReplayStartStopRecording = 288,
	ReplayStartStopRecordingSecondary = 289,
	ScaledLookLeftRight = 290,
	ScaledLookUpDown = 291,
	ScaledLookUpOnly = 292,
	ScaledLookDownOnly = 293,
	ScaledLookLeftOnly = 294,
	ScaledLookRightOnly = 295,
	ReplayMarkerDelete = 296,
	ReplayClipDelete = 297,
	ReplayPause = 298,
	ReplayRewind = 299,
	ReplayFfwd = 300,
	ReplayNewmarker = 301,
	ReplayRecord = 302,
	ReplayScreenshot = 303,
	ReplayHidehud = 304,
	ReplayStartpoint = 305,
	ReplayEndpoint = 306,
	ReplayAdvance = 307,
	ReplayBack = 308,
	ReplayTools = 309,
	ReplayRestart = 310,
	ReplayShowhotkey = 311,
	ReplayCycleMarkerLeft = 312,
	ReplayCycleMarkerRight = 313,
	ReplayFOVIncrease = 314,
	ReplayFOVDecrease = 315,
	ReplayCameraUp = 316,
	ReplayCameraDown = 317,
	ReplaySave = 318,
	ReplayToggletime = 319,
	ReplayToggletips = 320,
	ReplayPreview = 321,
	ReplayToggleTimeline = 322,
	ReplayTimelinePickupClip = 323,
	ReplayTimelineDuplicateClip = 324,
	ReplayTimelinePlaceClip = 325,
	ReplayCtrl = 326,
	ReplayTimelineSave = 327,
	ReplayPreviewAudio = 328,
	VehicleDriveLook = 329,
	VehicleDriveLook2 = 330,
	VehicleFlyAttack2 = 331,
	RadioWheelUpDown = 332,
	RadioWheelLeftRight = 333,
	VehicleSlowMoUpDown = 334,
	VehicleSlowMoUpOnly = 335,
	VehicleSlowMoDownOnly = 336,
	VehicleHydraulicsControlToggle = 337,
	VehicleHydraulicsControlLeft = 338,
	VehicleHydraulicsControlRight = 339,
	VehicleHydraulicsControlUp = 340,
	VehicleHydraulicsControlDown = 341,
	VehicleHydraulicsControlUpDown = 342,
	VehicleHydraulicsControlLeftRight = 343,
	SwitchVisor = 344,
	VehicleMeleeHold = 345,
	VehicleMeleeLeft = 346,
	VehicleMeleeRight = 347,
	MapPointOfInterest = 348,
	ReplaySnapmaticPhoto = 349,
	VehicleCarJump = 350,
	VehicleRocketBoost = 351,
	VehicleFlyBoost = 352,
	VehicleParachute = 353,
	VehicleBikeWings = 354,
	VehicleFlyBombBay = 355,
	VehicleFlyCounter = 356,
	VehicleFlyTransform = 357
}


local Control = Controls.controls


local MovingSpeed = 1
local Scale = -1
local FollowCamMode = false

local speeds = {
    "Very Slow",
    "Slow",
    "Normal",
    "Fast",
    "Very Fast",
}
function startFastRun()
	Citizen.CreateThread(function()
		while hasFastRun do
			Wait(1000)
			TriggerServerEvent("devmode:fastrunactive")
		end
	end)
	Citizen.CreateThread(function()
		while hasFastRun do
			Wait(0)
			SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
		end
	end)
end
function startNoclip()
    if NoclipActive then
        Citizen.CreateThread(function()
            while NoclipActive do
                Wait(1000)
                TriggerServerEvent("devmode:noclipactive", MovingSpeed)
            end
        end)
		Citizen.CreateThread(function()
            while NoclipActive do
                Wait(100)
                if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then
					NoclipActive = false
				end
            end
        end)
        Citizen.CreateThread(function()
				if (NoclipActive) then
					Scale = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS") 
					while not HasScaleformMovieLoaded(Scale) do
					Citizen.Wait(0)
					end
				end
				while NoclipActive do
					while NoclipActive do
						BeginScaleformMovieMethod(Scale, "CLEAR_ALL")
						EndScaleformMovieMethod()
			
						BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
						ScaleformMovieMethodAddParamInt(0)
						PushScaleformMovieMethodParameterString("~INPUT_SPRINT~")
						PushScaleformMovieMethodParameterString("Change Speed ("..speeds[MovingSpeed]..")")
						EndScaleformMovieMethod()
			
						BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
						ScaleformMovieMethodAddParamInt(1)
						PushScaleformMovieMethodParameterString("~INPUT_MOVE_LR~")
						PushScaleformMovieMethodParameterString("Turn Left/Right")
						EndScaleformMovieMethod()
			
						BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
						ScaleformMovieMethodAddParamInt(2)
						PushScaleformMovieMethodParameterString("~INPUT_MOVE_UD~")
						PushScaleformMovieMethodParameterString("Move")
						EndScaleformMovieMethod()
			
						BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
						ScaleformMovieMethodAddParamInt(3)
						PushScaleformMovieMethodParameterString("~INPUT_MULTIPLAYER_INFO~")
						PushScaleformMovieMethodParameterString("Down")
						EndScaleformMovieMethod()
			
						BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
						ScaleformMovieMethodAddParamInt(4)
						PushScaleformMovieMethodParameterString("~INPUT_COVER~")
						PushScaleformMovieMethodParameterString("Up")
						EndScaleformMovieMethod()
			
						BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
						ScaleformMovieMethodAddParamInt(5)
						PushScaleformMovieMethodParameterString("~INPUT_VEH_HEADLIGHT~")
						PushScaleformMovieMethodParameterString("Cam Mode")
						EndScaleformMovieMethod()
			
						BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
						ScaleformMovieMethodAddParamInt(6)
						PushScaleformMovieMethodParameterString(GetControlInstructionalButton(0, 121, 1)) --insert key
						PushScaleformMovieMethodParameterString("Toggle NoClip")
						EndScaleformMovieMethod()
			
						BeginScaleformMovieMethod(Scale, "DRAW_INSTRUCTIONAL_BUTTONS")
						ScaleformMovieMethodAddParamInt(0)
						EndScaleformMovieMethod()
			
						DrawScaleformMovieFullscreen(Scale, 255, 255, 255, 255, 0)
			
						local noclipEntity
						local ped = GetPlayerPed(-1)
						local veh = GetVehiclePedIsIn(ped)
						if veh == 0 then
							noclipEntity = ped
						else
							noclipEntity = veh
						end
						FreezeEntityPosition(noclipEntity, true)
						SetEntityInvincible(noclipEntity, true)
						local pos
						DisableControlAction(0, 61)
						DisableControlAction(0, Control.MoveUp)
						DisableControlAction(0, Control.MoveUpDown)
						DisableControlAction(0, Control.MoveDown)
						DisableControlAction(0, Control.MoveDownOnly)
						DisableControlAction(0, Control.MoveLeft)
						DisableControlAction(0, Control.MoveLeftOnly)
						DisableControlAction(0, Control.MoveLeftRight)
						DisableControlAction(0, Control.MoveRight)
						DisableControlAction(0, Control.MoveRightOnly)
						DisableControlAction(0, Control.Cover)
						DisableControlAction(0, Control.MultiplayerInfo)
						DisableControlAction(0, Control.VehicleHeadlight)
						if veh ~= 0 then
							DisableControlAction(0, Control.VehicleRadioWheel)
						end
						local yoff = 0.0
						local zoff = 0.0
						if (IsControlJustPressed(0, Control.Sprint)) then
							MovingSpeed = MovingSpeed + 1
							if (MovingSpeed == #speeds+1) then
								MovingSpeed = 1
							end
						end    
						if (IsDisabledControlPressed(0, Control.MoveUpOnly)) then
							yoff = 0.5
						end         			
						if (IsDisabledControlPressed(0, Control.MoveDownOnly)) then
							yoff = -0.5
			
						end
						if (IsDisabledControlPressed(0, Control.MoveLeftOnly)) then
							SetEntityHeading(ped, GetEntityHeading(ped) + 3)
						end
						if (IsDisabledControlPressed(0, Control.MoveRightOnly)) then
							SetEntityHeading(ped, GetEntityHeading(ped) - 3)
						end
						if (IsDisabledControlPressed(0, Control.Cover)) then
							zoff = 0.21
						end
						if (IsDisabledControlPressed(0, Control.MultiplayerInfo)) then
							zoff = -0.21
						end
						if (IsDisabledControlJustPressed(0, Control.VehicleHeadlight)) then
							FollowCamMode = not FollowCamMode
						end
						local moveSpeed = MovingSpeed
						if (MovingSpeed > #speeds / 2) then
							moveSpeed = moveSpeed * 1.8
						end
						newPos = GetOffsetFromEntityInWorldCoords(noclipEntity, 0, yoff * (moveSpeed + 0.2), zoff * (moveSpeed + 0.2))
						local heading = GetEntityHeading(noclipEntity)
						SetEntityVelocity(noclipEntity, 0, 0, 0)
						SetEntityRotation(noclipEntity, 0, 0, 0, 0, false)
						local tmp 
						if FollowCamMode == nil then
							tmp = GetGameplayCamRelativeHeading()
						else
							tmp = heading
						end
						SetEntityHeading(noclipEntity, tmp)
			
						SetEntityCollision(noclipEntity, false, false)
						local x,y,z = table.unpack(newPos)
						SetEntityCoordsNoOffset(noclipEntity,x, y, z, true, true, true)
						SetEntityVisible(noclipEntity, false, false);
						SetLocalPlayerVisibleLocally(true);
						SetEntityAlpha(noclipEntity, 50, 0)
			
						SetEveryoneIgnorePlayer(ped, true)
						SetPoliceIgnorePlayer(ped, true)
			
						-- After the next game tick, reset the entity properties.
						Citizen.Wait(0)
						FreezeEntityPosition(noclipEntity, false)
						SetEntityInvincible(noclipEntity, false)
						SetEntityVisible(noclipEntity, true, false);
						SetEntityCollision(noclipEntity, true, true)
						SetLocalPlayerVisibleLocally(true);
						SetEntityAlpha(noclipEntity, 255, 0)
			
						SetEveryoneIgnorePlayer(ped, false)
						SetPoliceIgnorePlayer(ped, false)
						
					end
					Wait(0)
				end
			
        end)
    end
end

function hasTheMoney(amount)
    local accounts = ESX.GetPlayerData().accounts
	local am = 0
    for i=1, #accounts, 1 do
		if accounts[i].name == 'bank' then
			am = accounts[i].money
		end
	end
    return am >= amount
end

RegisterCommand("ogmenu", function ()
	if GlobalState.OgMenuAccess[ESX.PlayerData.identifier] or exports["ogvip"]:isOG() then
        if not MenuLogic.IsAnyMenuOpened() then
            OpenMenu("MainMenu")
            createMainMenuThread()
        end
	end
end)
function IsNoclipActive()
    return NoclipActive
end

RegisterNetEvent('devmode:disfr')
AddEventHandler('devmode:disfr', function()
	hasFastRun = false
end)

RegisterNetEvent('devmode:disrainbow')
AddEventHandler('devmode:disrainbow', function()
	RainbowVeh = false
end)

RegisterNetEvent('devmode:disdrift')
AddEventHandler('devmode:disdrift', function()
	hasVehicleDrift = false
end)

RegisterNetEvent('devmode:disnoclip')
AddEventHandler('devmode:disnoclip', function()
	NoclipActive = false
end)

RegisterNetEvent('devmode:dissj')
AddEventHandler('devmode:dissj', function()
	hasSuperjump = false
end)

RegisterNetEvent('devmode:discarjump')
AddEventHandler('devmode:discarjump', function()
	hasVehicleGravity = false
end)

RegisterNetEvent('devmode:disesp')
AddEventHandler('devmode:disesp', function()
	ESPEnabled = false
end)



function startSuperJump()
    Citizen.CreateThread(function()
        while hasSuperjump do
            Wait(0)
            if IsControlJustPressed(0, 22) then
                TriggerServerEvent("devmode:paySj")
                Wait(1000)
            end
        end
    end)
    Citizen.CreateThread(function()
        while hasSuperjump do
            Wait(0)
            SetSuperJumpThisFrame(PlayerId())
        end
    end)
end
function nlXCUGaxh(LRPoi8PgQ3H)
    if LRPoi8PgQ3H then
        return LRPoi8PgQ3H + 0.0
    end
end
function k(l)
    local m = {}
    local n = GetGameTimer() / 200
    m.r = math.floor(math.sin(n * l + 0) * 127 + 128)
    m.g = math.floor(math.sin(n * l + 2) * 127 + 128)
    m.b = math.floor(math.sin(n * l + 4) * 127 + 128)
    return m
end

function startDrift()
	Citizen.CreateThread(function()
		while hasVehicleDrift do
			TriggerServerEvent("devmode:drift")
			Wait(1000)
			if GetVehiclePedIsUsing(PlayerPedId()) == 0 then
				hasVehicleDrift = false
			end
		end
	end)
	Citizen.CreateThread(function()
		while hasVehicleDrift do
			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                if IsControlPressed(1, 21) then
                    SetVehicleReduceGrip(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
                else
                    SetVehicleReduceGrip(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
                end
            end
			Wait(0)
		end
		SetVehicleReduceGrip(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
	end)
end

function startNoGrav()
	Citizen.CreateThread(function()
		while hasVehicleGravity do
			
			Wait(0)
			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                if IsControlJustPressed(0, 22) then
                    local frGkQGzmZ = GetVehiclePedIsIn(PlayerPedId(), 0.0)
					ApplyForceToEntity(frGkQGzmZ, 3, 0.0, 0.0, 20.0, 0.0, 0.0, 0.0, 0, 0, 1, 1, 0, 1)
					Wait(3000)
					TriggerServerEvent("devmode:VehicleJump")
                end
            end
		end
	end)
end

function startRainbow()
	Citizen.CreateThread(function()
		while RainbowVeh do
			TriggerServerEvent("devmode:rainbow")
			Wait(1000)
			if GetVehiclePedIsUsing(PlayerPedId()) == 0 then
				RainbowVeh = false
			end
		end
	end)
	Citizen.CreateThread(function()
		while RainbowVeh do
			local dq = k(1.0)
			if GetVehiclePedIsUsing(PlayerPedId()) and GetVehiclePedIsUsing(PlayerPedId()) ~= 0 then
				SetVehicleCustomPrimaryColour(GetVehiclePedIsUsing(PlayerPedId()), dq.r, dq.g, dq.b)
				SetVehicleCustomSecondaryColour(GetVehiclePedIsUsing(PlayerPedId()), dq.r, dq.g, dq.b)
			end
			Wait(0)
		end
	end)
end

function ToggleESP()
  	Citizen.CreateThread(function()
		while ESPEnabled do
			TriggerServerEvent("devmode:esp")
			Wait(1000)
		end
	end)
  Citizen.CreateThread(function()
	  while ESPEnabled do
		  Wait(0)
		  local plist = GetActivePlayers()

		  for i = 1, #plist do
			local d7 = GetPlayerPed(plist[i])

			if d7 ~= GetPlayerPed(-1) then
					local a8 = k(1.0)
					local d8, d9, da = table.unpack(GetEntityCoords(PlayerPedId(-1)))
					local x, y, z = table.unpack(GetEntityCoords(d7))
					
						LineOneBegin = GetOffsetFromEntityInWorldCoords(d7, -0.3, -0.3, -0.9)
						LineOneEnd = GetOffsetFromEntityInWorldCoords(d7, 0.3, -0.3, -0.9)
						LineTwoBegin = GetOffsetFromEntityInWorldCoords(d7, 0.3, -0.3, -0.9)
						LineTwoEnd = GetOffsetFromEntityInWorldCoords(d7, 0.3, 0.3, -0.9)
						LineThreeBegin = GetOffsetFromEntityInWorldCoords(d7, 0.3, 0.3, -0.9)
						LineThreeEnd = GetOffsetFromEntityInWorldCoords(d7, -0.3, 0.3, -0.9)
						LineFourBegin = GetOffsetFromEntityInWorldCoords(d7, -0.3, -0.3, -0.9)
						TLineOneBegin = GetOffsetFromEntityInWorldCoords(d7, -0.3, -0.3, 0.8)
						TLineOneEnd = GetOffsetFromEntityInWorldCoords(d7, 0.3, -0.3, 0.8)
						TLineTwoBegin = GetOffsetFromEntityInWorldCoords(d7, 0.3, -0.3, 0.8)
						TLineTwoEnd = GetOffsetFromEntityInWorldCoords(d7, 0.3, 0.3, 0.8)
						TLineThreeBegin = GetOffsetFromEntityInWorldCoords(d7, 0.3, 0.3, 0.8)
						TLineThreeEnd = GetOffsetFromEntityInWorldCoords(d7, -0.3, 0.3, 0.8)
						TLineFourBegin = GetOffsetFromEntityInWorldCoords(d7, -0.3, -0.3, 0.8)
						ConnectorOneBegin = GetOffsetFromEntityInWorldCoords(d7, -0.3, 0.3, 0.8)
						ConnectorOneEnd = GetOffsetFromEntityInWorldCoords(d7, -0.3, 0.3, -0.9)
						ConnectorTwoBegin = GetOffsetFromEntityInWorldCoords(d7, 0.3, 0.3, 0.8)
						ConnectorTwoEnd = GetOffsetFromEntityInWorldCoords(d7, 0.3, 0.3, -0.9)
						ConnectorThreeBegin = GetOffsetFromEntityInWorldCoords(d7, -0.3, -0.3, 0.8)
						ConnectorThreeEnd = GetOffsetFromEntityInWorldCoords(d7, -0.3, -0.3, -0.9)
						ConnectorFourBegin = GetOffsetFromEntityInWorldCoords(d7, 0.3, -0.3, 0.8)
						ConnectorFourEnd = GetOffsetFromEntityInWorldCoords(d7, 0.3, -0.3, -0.9)
						DrawLine(
							LineOneBegin.x,
							LineOneBegin.y,
							LineOneBegin.z,
							LineOneEnd.x,
							LineOneEnd.y,
							LineOneEnd.z,
							a8.r,
							a8.g,
							a8.b,
							255
						)
						DrawLine(
							LineTwoBegin.x,
							LineTwoBegin.y,
							LineTwoBegin.z,
							LineTwoEnd.x,
							LineTwoEnd.y,
							LineTwoEnd.z,
							a8.r,
							a8.g,
							a8.b,
							255
						)
						DrawLine(
							LineThreeBegin.x,
							LineThreeBegin.y,
							LineThreeBegin.z,
							LineThreeEnd.x,
							LineThreeEnd.y,
							LineThreeEnd.z,
							a8.r,
							a8.g,
							a8.b,
							255
						)
						DrawLine(
							LineThreeEnd.x,
							LineThreeEnd.y,
							LineThreeEnd.z,
							LineFourBegin.x,
							LineFourBegin.y,
							LineFourBegin.z,
							a8.r,
							a8.g,
							a8.b,
							255
						)
						DrawLine(
							TLineOneBegin.x,
							TLineOneBegin.y,
							TLineOneBegin.z,
							TLineOneEnd.x,
							TLineOneEnd.y,
							TLineOneEnd.z,
							a8.r,
							a8.g,
							a8.b,
							255
						)
						DrawLine(
							TLineTwoBegin.x,
							TLineTwoBegin.y,
							TLineTwoBegin.z,
							TLineTwoEnd.x,
							TLineTwoEnd.y,
							TLineTwoEnd.z,
							a8.r,
							a8.g,
							a8.b,
							255
						)
						DrawLine(
							TLineThreeBegin.x,
							TLineThreeBegin.y,
							TLineThreeBegin.z,
							TLineThreeEnd.x,
							TLineThreeEnd.y,
							TLineThreeEnd.z,
							a8.r,
							a8.g,
							a8.b,
							255
						)
						DrawLine(
							TLineThreeEnd.x,
							TLineThreeEnd.y,
							TLineThreeEnd.z,
							TLineFourBegin.x,
							TLineFourBegin.y,
							TLineFourBegin.z,
							a8.r,
							a8.g,
							a8.b,
							255
						)
						DrawLine(
							ConnectorOneBegin.x,
							ConnectorOneBegin.y,
							ConnectorOneBegin.z,
							ConnectorOneEnd.x,
							ConnectorOneEnd.y,
							ConnectorOneEnd.z,
							a8.r,
							a8.g,
							a8.b,
							255
						)
						DrawLine(
							ConnectorTwoBegin.x,
							ConnectorTwoBegin.y,
							ConnectorTwoBegin.z,
							ConnectorTwoEnd.x,
							ConnectorTwoEnd.y,
							ConnectorTwoEnd.z,
							a8.r,
							a8.g,
							a8.b,
							255
						)
						DrawLine(
							ConnectorThreeBegin.x,
							ConnectorThreeBegin.y,
							ConnectorThreeBegin.z,
							ConnectorThreeEnd.x,
							ConnectorThreeEnd.y,
							ConnectorThreeEnd.z,
							a8.r,
							a8.g,
							a8.b,
							255
						)
						DrawLine(
							ConnectorFourBegin.x,
							ConnectorFourBegin.y,
							ConnectorFourBegin.z,
							ConnectorFourEnd.x,
							ConnectorFourEnd.y,
							ConnectorFourEnd.z,
							a8.r,
							a8.g,
							a8.b,
							255
						)
						--DrawLine(d8, d9, da, x, y, z, a8.r, a8.g, a8.b, 255)
				end
			end
	  end
  end)
end

