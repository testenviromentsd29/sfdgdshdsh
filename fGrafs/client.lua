local PlayerData = {};
local recName = GetCurrentResourceName()..':';
local currentZone = nil;
local currentFont = 2;
local currentText = '';
local currentColour = '#00FF00';
local CachedScaleforms = {};
local CachedPads = {};
local isBusy = false;

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end
	
	PlayerData = ESX.GetPlayerData()
	ESX.UI.Menu.CloseAll()

	LoadAllSprayScaleforms();
    StartMain();

	CreateBlips();
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	local lastJob = PlayerData.job.name

	PlayerData.job = job

	if job.name ~= lastJob then
		CreateBlips()
	end
end)

local currentBucket = 0
local currentBucketName = "default"

AddEventHandler('buckets:onBucketChanged', function(bucketId, bucketName)
	currentBucket = bucketId
	currentBucketName = bucketName
end)

function LoadAllSprayScaleforms()
	for k,v in pairs(Config.Fonts)do
		RegisterFontFile(v);
		RegisterFontId(v);
	end

	for k,v in pairs(Config.Locations)do
		Wait(0)
        CachedScaleforms[k] = {};
	end
end

function ChangeFont(data)
	if (data.font) then
		currentFont = data.font;
	elseif (data.colour) then
		currentColour = data.colour;
	else
		currentText = data.text;
	end
end

function GeneratePadId()
	local validPads = {'01','02','03','04','05','06','07','08','09','10','11','12'};
	local id = validPads[math.random(1,#validPads)];
	while CachedPads[id] do
		Wait(200);
		id = validPads[math.random(1,#validPads)];
	end	
	print('Generated '..id)
	return id;
end

function CloseMenu()
	SetNuiFocus(false, false);
end

function OpenNUI()
	if not currentZone then
		return;
	end
	SetNuiFocus(true, true);
	SendNUIMessage({
		action = 'open';
	})
	local coords = Config.Locations[currentZone].coords;
	local rotation = Config.Locations[currentZone].rotation;
	CreateThread(function ()
		local ScaleformHandle = RequestScaleformMovie("PLAYER_NAME_13") 
		while not HasScaleformMovieLoaded(ScaleformHandle) do Wait(0)end
		while IsNuiFocused() and currentZone do
			Wait(0);
			PushScaleformMovieFunction(ScaleformHandle, "SET_PLAYER_NAME");
			PushScaleformMovieFunctionParameterString("<FONT color='"..currentColour.."' face = '"..Config.Fonts[currentFont].."'>" .. ''..currentText..'');
			PopScaleformMovieFunctionVoid();
			DrawScaleformMovie_3dSolid(ScaleformHandle,coords, rotation, 1.0, 1.0, 1.0, 3.0, 3.0,1.0,2); 
		end
		SendNUIMessage({
			action = 'close';
		})
	end)
end

function OnSpray(data)
	SetNuiFocus(false, false);

	if not currentZone or isBusy then
		return;
	end

	isBusy = true;
	
	PersistSpray(data);
	isBusy = false;
end

function OnClean()
	if not currentZone or isBusy then
		return;
	end

	local vec4 = Config.Locations[currentZone].sprayPoint;
	if not vec4 then
		return;
	end

	isBusy = true;

	SetEntityCoords(ped, vec4.x,vec4.y,vec4.z - 1.0);
	SetEntityHeading(ped, vec4.w);

	TaskStartScenarioInPlace(PlayerPedId(),"WORLD_HUMAN_MAID_CLEAN",-1,false)
	Wait(Config.Settings.CleaningTime * 1000);
	ClearPedTasksImmediately(PlayerPedId());
	TriggerServerEvent(recName..'OnClean', currentZone);
	isBusy = false;
end

function StartMain()
	CreateThread(function ()
		while true do
			Wait(0);
			local found = false;

			if not Config.Teams[PlayerData.job.name] and not Config.Teams[PlayerData.job2.name] then
				goto skip;
			end

			for k,v in pairs(Config.Locations)do
				local dist = #(GetEntityCoords(PlayerPedId()) - vector3(v.sprayPoint.x,v.sprayPoint.y,v.sprayPoint.z));
				if dist < 50.0 and CachedScaleforms[k] then
					DrawGraffity(k);
					found = true;
				elseif dist > 50.0 and CachedScaleforms[k].scaleform then
					RemoveGraffity(k);
				end
				if dist < 5.0 then
					found = true;
					currentZone = k;
					if GlobalState.Graffities[k] then
						ESX.ShowHelpNotification('Press ~INPUT_PICKUP~ to clean spray!');
						if IsControlJustReleased(0,38) then
							CreateThread(OnClean);
						end
					else
						ESX.ShowHelpNotification('Press ~INPUT_PICKUP~ to spray!');
						if IsControlJustReleased(0,38) then
							CreateThread(OpenNUI)
						end
					end
				end
			end

			::skip::

			if not found then
				Wait(2000);
				currentZone = nil;
			end
		end
	end)
end

function RemoveGraffity(index)
	if CachedScaleforms[index] then
		if CachedScaleforms[index].pad then
			print('Deleting '..CachedScaleforms[index].pad)
			CachedPads[CachedScaleforms[index].pad] = nil;
			CachedScaleforms[index] = {};
		end
	end
end

function DrawGraffity(index)
	if not CachedScaleforms[index].scaleform then
		local padId = GeneratePadId();
		CachedPads[padId] = true;
		CachedScaleforms[index].pad = padId;
		CachedScaleforms[index].scaleform = RequestScaleformMovieInteractive("PLAYER_NAME_"..padId);
		while not HasScaleformMovieLoaded(CachedScaleforms[index].scaleform) do
			Wait(500);
		end
	end
	if CachedScaleforms[index] and GlobalState.Graffities[index] then
		BeginScaleformMovieMethod(CachedScaleforms[index].scaleform, "SET_PLAYER_NAME")
		ScaleformMovieMethodAddParamTextureNameString("<FONT color='"..GlobalState.Graffities[index].colour.."' face = '"..GlobalState.Graffities[index].font.."'>" .. ''..GlobalState.Graffities[index].text..'');
		EndScaleformMovieMethod()
		DrawScaleformMovie_3dSolid(CachedScaleforms[index].scaleform,Config.Locations[index].coords, Config.Locations[index].rotation, 1.0, 1.0, 1.0, 3.0, 3.0,1.0,2); 
	elseif CachedScaleforms[index] and not GlobalState.Graffities[index] and not IsNuiFocused() and not isBusy then
		BeginScaleformMovieMethod(CachedScaleforms[index].scaleform, "SET_PLAYER_NAME")
		ScaleformMovieMethodAddParamTextureNameString("<FONT color='"..currentColour.."' face = '"..Config.Fonts[2].."'>" .. ''..Config.DefaultText..'');
		EndScaleformMovieMethod()
		DrawScaleformMovie_3dSolid(CachedScaleforms[index].scaleform,Config.Locations[index].coords, Config.Locations[index].rotation, 1.0, 1.0, 1.0, 3.0, 3.0,1.0,2); 
	end
end

function RemovalNotify(coords, enemyjob)
	TriggerEvent('devmode:eventannounce', 'Spray Cleaned', enemyjob..' are cleaning our sprays!', coords);
	SetNewWaypoint(coords.x, coords.y);
	
	--[[ExecuteCommand('e phonecall');
	local timer = GetGameTimer() + 5000;
	while timer > GetGameTimer() do
		ESX.ShowHelpNotification(enemyjob..' are cleaning our sprays!\n Press ~INPUT_PICKUP~ to set waypoint!');
		Wait(0);
		if IsControlJustReleased(0,38) then
			CreateThread(function()
				local counter = 60 --seconds
				
				local RadiusBlip = AddBlipForRadius(coords.x, coords.y, coords.z, 100.0)
				SetBlipColour(RadiusBlip, 1)
				SetBlipAlpha(RadiusBlip, 80)

				while counter > 0 do
					Wait(1000)
					counter = counter - 1
				end

				if DoesBlipExist(RadiusBlip) then
					RemoveBlip(RadiusBlip)
					RadiusBlip = nil
				end
			end)
			
			SetNewWaypoint(coords.x, coords.y);
			break;
		end
	end
	ExecuteCommand('e c');]]
end

-----------------------------------RCORE Functions-----------------------
function PersistSpray(data)
    local ped = PlayerPedId()

    local canPos = vector3(0.072, 0.041, -0.06)
    local canRot = vector3(33.0, 38.0, 0.0)
	local vec4 = Config.Locations[currentZone].sprayPoint;
	if not vec4 then
		return;
	end
	SetEntityCoords(ped, vec4.x,vec4.y,vec4.z - 1.0);
	SetEntityHeading(ped, vec4.w);

    local canObj = CreateObject(
        GetHashKey("ng_proc_spraycan01b"),
        0.0, 0.0, 0.0,
        true, false, false
    )
    AttachEntityToEntity(
        canObj, ped, 
        GetPedBoneIndex(ped, 57005), 
        canPos.x, canPos.y, canPos.z, 
        canRot.x, canRot.y, canRot.z, 
        true, true, false, true, 1, true
    )

    SprayEffects(data.color)

    local animDict, animName = 'anim@amb@business@weed@weed_inspecting_lo_med_hi@', 'weed_spraybottle_stand_spraying_01_inspector'
    while not HasAnimDictLoaded(animDict) do
        RequestAnimDict(animDict)
        Wait(100)
    end
    TaskPlayAnim(ped, animDict, animName, 1.0, 1.0, -1, 16, 0, 0, 0, 0 )
    for i =1,Config.Settings.SprayingTime,1 do
		SprayEffects(data.color)
		Wait(1000)
	end
    StopAnimTask(ped, animDict, animName, 1.0)

    ClearPedTasksImmediately(PlayerPedId());
    DeleteObject(canObj)
	TriggerServerEvent(recName..'OnSpray', currentZone, {
		colour = currentColour,
		font = currentFont,
		text = currentText,
	})
end

function SprayEffects(sprayColor)
    local dict = "scr_recartheft"
    local name = "scr_wheel_burnout"
    
    local ped = PlayerPedId()
    local fwd = GetEntityForwardVector(ped)
    local coords = GetEntityCoords(ped) + fwd * 0.5 + vector3(0.0, 0.0, -0.5)

	RequestNamedPtfxAsset(dict)
    -- Wait for the particle dictionary to load.
    while not HasNamedPtfxAssetLoaded(dict) do
        Wait(0)
	end

	local pointers = {}

    local heading = GetEntityHeading(ped)

    UseParticleFxAssetNextCall(dict)
    SetParticleFxNonLoopedColour(sprayColor.r / 255, sprayColor.g / 255, sprayColor.b / 255)
    SetParticleFxNonLoopedAlpha(1.0)
    local ptr = StartParticleFxNonLoopedAtCoord(
        name, 
        coords.x, coords.y, coords.z + 2.0, 
        0.0, 0.0, heading, 
        0.7, 
        0.0, 0.0, 0.0
    )
    --[[ local ptr = StartNetworkedParticleFxNonLoopedAtCoord(
        name, 
        coords.x, coords.y, coords.z + 2.0, 
        0.0, 0.0, heading, 
        0.7, 
        0.0, 0.0, 0.0
    ) ]]
    RemoveNamedPtfxAsset(dict)
end

function rgbToHex(rgb)
	local hexadecimal = ''

	for key, value in pairs(rgb) do
		local hex = ''

		while(value > 0)do
			local index = math.fmod(value, 16) + 1
			value = math.floor(value / 16)
			hex = string.sub('0123456789ABCDEF', index, index) .. hex			
		end

		if(string.len(hex) == 0)then
			hex = '00'

		elseif(string.len(hex) == 1)then
			hex = '0' .. hex
		end

		hexadecimal = hexadecimal .. hex
	end

	return hexadecimal
end
-----------------------------------RCORE Functions-----------------------

RegisterCommand('getr', function ()
	if PlayerData.group ~= 'superadmin' then
		return;
	end
	local rotation = GetEntityRotation(PlayerPedId());
	local coords = GetEntityCoords(PlayerPedId());
	local scaleform = RequestScaleformMovieInteractive("PLAYER_NAME_12");
	while not HasScaleformMovieLoaded(scaleform) do Wait(0) end

	while true do
		Wait(0);
		BeginScaleformMovieMethod(scaleform, "SET_PLAYER_NAME")
		ScaleformMovieMethodAddParamTextureNameString("<FONT>Press enter to take coords!");
		EndScaleformMovieMethod()
		DrawScaleformMovie_3dSolid(scaleform,coords, rotation, 1.0, 1.0, 1.0, 3.0, 3.0,1.0,2); 
		DisableControlAction(0, 34, true);
		DisableControlAction(0, 30, true);
		DisableControlAction(0, 33, true);
		DisableControlAction(0, 32, true);
		if IsControlPressed(0,27) then
			coords = coords + vector3(0,0,0.05)
			--rotation = rotation + vector3(0,1,0);
		elseif IsControlPressed(0, 173) then
			coords = coords - vector3(0,0,0.05)
			--rotation = rotation + vector3(0,0,1)
		elseif IsControlPressed(0, 174) then
			rotation = rotation + vector3(1,0,0);
		elseif IsControlPressed(0, 175) then
			rotation = rotation - vector3(1,0,0);
		elseif IsDisabledControlPressed(0, 34) then
			rotation = rotation - vector3(0,0,1);
		elseif IsDisabledControlPressed(0,30) then
			rotation = rotation + vector3(0,0,1);
		elseif IsDisabledControlPressed(0, 32) then
			coords = coords + vector3(0.05,0,0);
		elseif IsDisabledControlPressed(0 ,33) then
			coords = coords - vector3(0.05,0,0);
		elseif IsControlJustReleased(0, 18) then
			break;
		end
	end

	local text = 'coords = '..tostring(coords)..',\nrotation = '..tostring(rotation);
	exports['devmode']:copyText(text);
end)

local Blips = {}
function CreateBlips()
	for k,v in pairs(Blips) do
		if DoesBlipExist(v) then
			RemoveBlip(v)
		end
	end

	if Config.Teams[PlayerData.job.name] or Config.Teams[PlayerData.job2.name] then
		for k,v in pairs(Config.Locations) do
			Blips[k] = AddBlipForCoord(v.sprayPoint.x, v.sprayPoint.y, v.sprayPoint.z)
			SetBlipSprite(Blips[k], Config.Blip.Sprite)
			SetBlipDisplay(Blips[k], Config.Blip.Display)
			SetBlipScale(Blips[k], Config.Blip.Scale)
			SetBlipColour(Blips[k], Config.Blip.Color)
			SetBlipAsShortRange(Blips[k], true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Blip.Name)
			EndTextCommandSetBlipName(Blips[k])
		end
	end
end

RegisterNetEvent(recName..'RemovalNotify', RemovalNotify);
RegisterNUICallback('onspray', OnSpray);
RegisterNUICallback('close', CloseMenu);
RegisterNUICallback('ontype', ChangeFont);