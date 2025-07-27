--clothes
local PreviousPed               = {}
local PreviousPedHead           = {}
local PreviousPedProps          = {}
local face
local headblendData


RegisterCommand("jailmenu", function(source, args)

	if PlayerData.job.name == "police" then
		OpenJailMenu()
	else
		ESX.ShowNotification("You are not an officer!")
	end
end)

function setUniform(v, playerPed)
	
	TriggerEvent('skinchanger:getSkin', function(skin)
		
		if skin.sex == math.floor(0) then
			if v.male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, v.male)
			else
				ESX.ShowNotification("No Outfit")
			end

			
		else
			if v.female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, v.female)
			else
				ESX.ShowNotification("No Outfit")
			end

			
		end
	end)
end

function LoadAnim(animDict)
	RequestAnimDict(animDict)

	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
end

function LoadModel(model)
	RequestModel(model)

	while not HasModelLoaded(model) do
		Citizen.Wait(10)
	end
end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
	HideHudComponentThisFrame(19)
end

local jailClothes = {
	male = {
		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 23,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 0,
		['pants_1'] = 19,   ['pants_2'] = 0,
		['bags_1'] = 0,
		['shoes_1'] = 12,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 4,    ['chain_2'] = 0
	},
	female = {
		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 23,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 0,
		['pants_1'] = 19,   ['pants_2'] = 0,
		['bags_1'] = 0,
		['shoes_1'] = 12,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 4,    ['chain_2'] = 0
	},
}

function dressAsPrisoner()
	--dress as prisoner

	headblendData = exports.esx_ligmajobs:GetHeadBlendData(PlayerPedId())

	for i = 0, 12 do
		i = math.floor(i)
		PreviousPed[i]= {component = i, drawable = GetPedDrawableVariation(PlayerPedId(), i), texture = GetPedTextureVariation(PlayerPedId(), i)}
	end

	for i = 0, 12 do
		i = math.floor(i)
		PreviousPedHead[i] = {overlayID = GetPedHeadOverlayValue(PlayerPedId(), i)}
	end
	
	PreviousPedProps[67] = GetPedEyeColor(PlayerPedId())
	PreviousPedProps[68] = GetPedHairColor(PlayerPedId())
	PreviousPedProps[69] = GetPedHairHighlightColor(PlayerPedId())

	for i = 0, 7 do
		i = math.floor(i)
		PreviousPedProps[i] = {component = i, drawable = GetPedPropIndex(PlayerPedId(), i), texture = GetPedPropTextureIndex(PlayerPedId(), i)}
	end

	setUniform(jailClothes,PlayerPedId())

	for i = 0, 12 do
		i = math.floor(i)
		SetPedHeadOverlay(PlayerPedId(), i, PreviousPedHead[i].overlayID, 1.0)
	end
	SetPedComponentVariation(PlayerPedId(), PreviousPed[2].component, PreviousPed[2].drawable, PreviousPed[2].texture)
	SetPedHairColor(PlayerPedId(), PreviousPedProps[68], PreviousPedProps[69])
	SetPedEyeColor(PlayerPedId(), PreviousPedProps[67])
	SetPedHeadBlendData(PlayerPedId(), headblendData.FirstFaceShape, headblendData.SecondFaceShape, headblendData.ThirdFaceShape, headblendData.FirstSkinTone, headblendData.SecondSkinTone, headblendData.ThirdSkinTone, math.floor(0))  

end

function Cutscene(jailID)
	DoScreenFadeOut(100)
	
	Citizen.Wait(250)
	
	dressAsPrisoner()
	-------------------------------------------------

	LoadModel(-1320879687)

	local PolicePosition = ConfigJail.Cutscene["PolicePosition"]
	local Police = CreatePed(5, -1320879687, PolicePosition["x"], PolicePosition["y"], PolicePosition["z"], PolicePosition["h"], false)
	TaskStartScenarioInPlace(Police, "WORLD_HUMAN_PAPARAZZI", 0, false)

	local PlayerPosition = ConfigJail.Cutscene["PhotoPosition"]
	local PlayerPed = PlayerPedId()
	SetEntityCoords(PlayerPed, PlayerPosition["x"], PlayerPosition["y"], PlayerPosition["z"] - 1)
	SetEntityHeading(PlayerPed, PlayerPosition["h"])
	FreezeEntityPosition(PlayerPed, true)

	Cam()

	Wait(1000)

	DoScreenFadeIn(100)

	Wait(10000)

	DoScreenFadeOut(250)
	
	local JailPosition = ConfigJail.Cells[jailID]
	SetEntityCoords(PlayerPed, JailPosition.x, JailPosition.y, JailPosition.z)
	DeleteEntity(Police)
	SetModelAsNoLongerNeeded(-1320879687)

	Wait(1000)

	DoScreenFadeIn(250)

	TriggerServerEvent("InteractSound_SV:PlayOnSource", "cell", 0.3)

	RenderScriptCams(false,  false,  0,  true,  true)
	FreezeEntityPosition(PlayerPed, false)
	DestroyCam(ConfigJail.Cutscene["CameraPos"]["cameraId"])
end

function restoreOutfit()

	if PreviousPedProps[68] then
		local playerPed = PlayerPedId()
		SetPedHairColor(playerPed, PreviousPedProps[68], PreviousPedProps[69])
		SetPedEyeColor(playerPed, PreviousPedProps[67])
		SetPedHeadBlendData(playerPed, headblendData.FirstFaceShape, headblendData.SecondFaceShape, headblendData.ThirdFaceShape, headblendData.FirstSkinTone, headblendData.SecondSkinTone, headblendData.ThirdSkinTone, math.floor(0));

		for i = 0, 12, 1 do
			i = math.floor(i)
			SetPedComponentVariation(playerPed, PreviousPed[i].component, PreviousPed[i].drawable, PreviousPed[i].texture)
		end

		for i = 0, 12, 1 do
			i = math.floor(i)
			SetPedHeadOverlay(playerPed, i, PreviousPedHead[i].overlayID, 1.0)
		end

		for i = 0, 7, 1 do
			i = math.floor(i)
			ClearPedProp(playerPed, i)
		end

		for i = 0, 7, 1 do
			i = math.floor(i)
			SetPedPropIndex(playerPed, PreviousPedProps[i].component, PreviousPedProps[i].drawable, PreviousPedProps[i].texture, true)
		end

	end

end

function Cam()
	local CamOptions = ConfigJail.Cutscene["CameraPos"]

	CamOptions["cameraId"] = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

    SetCamCoord(CamOptions["cameraId"], CamOptions["x"], CamOptions["y"], CamOptions["z"])
	SetCamRot(CamOptions["cameraId"], CamOptions["rotationX"], CamOptions["rotationY"], CamOptions["rotationZ"])

	RenderScriptCams(true, false, 0, true, true)
end

function TeleportPlayer(pos)

	local Values = pos

	if #Values["goal"] > 1 then

		local elements = {}

		for i, v in pairs(Values["goal"]) do
			table.insert(elements, { label = v, value = v })
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'teleport_jail',
			{
				title    = "Choose Position",
				align    = 'center',
				elements = elements
			},
		function(data, menu)

			local action = data.current.value
			local position = ConfigJail.Teleports[action]

			if action == "Boiling Broke" or action == "Security" then

				if PlayerData.job.name ~= "police" then
					ESX.ShowNotification("You don't have an key to go here!")
					return
				end
			end

			menu.close()

			DoScreenFadeOut(100)

			Wait(250)

			SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])

			Wait(250)

			DoScreenFadeIn(100)
			
		end,

		function(data, menu)
			menu.close()
		end)
	else
		local position = ConfigJail.Teleports[Values["goal"][1]]
		DoScreenFadeOut(100)
		Wait(250)
		SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])
		Wait(250)
		DoScreenFadeIn(100)
	end
end

CreateThread(function()
	local blip = AddBlipForCoord(ConfigJail.blipCoords)

    SetBlipSprite (blip, 188)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8)
    SetBlipColour (blip, 49)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(ConfigJail.blipName)
    EndTextCommandSetBlipName(blip)
end)