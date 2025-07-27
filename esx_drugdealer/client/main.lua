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

local zones = {}

local isEventActive = false
local inRedzone = false
local cooldown = true

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	
	Wait(5000)
	ESX.PlayerData = ESX.GetPlayerData()
	
	TriggerServerEvent("esx_drugdealer:gimmeZonesPliz")
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx_drugdealer:eventStatus')
AddEventHandler('esx_drugdealer:eventStatus', function(status)
	isEventActive = status
end)

VehicleDensity = 0.1
PedDensity = 1.0

local near = {}

Citizen.CreateThread(function()
    for k,v in pairs(ConfigCL.Zones) do
        DrawTheMarkBrother("", k)
        makeNpc(k)
        
		Citizen.CreateThread(function()
            while true do
                Wait(1000)
                local dist = #(GetEntityCoords(PlayerPedId()) - ConfigCL.Zones[k].Center)
                if dist <= ConfigCL.Zones[k].Radius then --and ConfigCL.Zones[k].Status then
                    near[k] = true
                else
                    near[k] = nil
                    Wait(2000)
                end
            end
        end)
		
		Citizen.CreateThread(function()
            while true do
                Wait(1000)
				
				local coords = GetEntityCoords(PlayerPedId())
				local radius = ConfigCL.Zones[k].Radius
				local redzoneDist = #(vector2(coords.x, coords.y) - vector2(ConfigCL.Zones[k].Center.x, ConfigCL.Zones[k].Center.y))
				
				if redzoneDist < radius and redzoneDist > (radius - 10.0) then
					sleep = false
					
					if not inRedzone then
						if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
							print('trying to enter drugdealer')
							TriggerServerEvent('esx_drugdealer:enterRedzone', true)
							Wait(5000)
						else
							ESX.ShowNotification('Θα πρέπει να μπεις στην περιοχή χωρίς όχημα')
						end
					end
				elseif redzoneDist > radius then
					sleep = false
					
					if inRedzone then
						if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
							print('trying to exit drugdealer')
							TriggerServerEvent('esx_drugdealer:enterRedzone', false)
							Wait(5000)
						else
							ESX.ShowNotification('Θα πρέπει να μπεις στην περιοχή χωρίς όχημα')
						end
					end
				end
            end
        end)
    end
end)

RegisterNetEvent('esx_drugdealer:enterRedzone')
AddEventHandler('esx_drugdealer:enterRedzone', function(answer)
	inRedzone = answer
end)

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 370
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	DrawRect(_x,_y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 120)
end

Citizen.CreateThread(function()
	while true do
        Wait(9)
        for k,v in pairs(near) do
            if near[k] then
                local handle, ped = FindFirstPed()
                repeat
                    success, ped = FindNextPed(handle)
                    local pos = GetEntityCoords(ped)
                    local coords = GetEntityCoords(PlayerPedId())
                    local distance = #(vector3(pos.x, pos.y, pos.z) - vector3(coords['x'], coords['y'], coords['z']))
                    if not IsPedInAnyVehicle(playerPed) then
                        if DoesEntityExist(ped) and GetEntityModel(ped) ~= GetHashKey("g_m_y_salvaboss_01") then
                            if not IsPedDeadOrDying(ped) then
                                if not IsPedInAnyVehicle(ped) then
                                    local pedType = GetPedType(ped)
                                    if pedType ~= 28 and not IsPedAPlayer(ped) then
                                        currentped = pos
                                        if distance <= 2 and ped ~= playerPed and ped ~= oldped then
                                            DrawText3Ds(pos.x, pos.y, pos.z, "Press ~r~E ~w~to sell drugs.")
                                            if IsControlJustPressed(1, 86) then
                                                oldped = ped
                                                SetEntityHeading(ped, GetEntityHeading(PlayerPedId())-180)
                                                TaskLookAtCoord(ped, coords['x'], coords['y'], coords['z'], -1, 2048, 3)
                                                SetEntityAsMissionEntity(ped)
                                                local pos1 = GetEntityCoords(ped)
                                                Wait(1000)
                                                ESX.ShowNotification("Deal in progress.")
                                                TaskPlayAnim(ped,"mp_ped_interaction","handshake_guy_b",1.0,-1.0, -1, 1, 1, true, true, true)

                                                ExecuteCommand("e handshake2")
                                                Wait(2500)
                                                SetPedAsNoLongerNeeded(oldped)
                                                TriggerServerEvent("esx_drugdealer:sellDrug", k)
                                                
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                until not success
                EndFindPed(handle)
                
            end
        end
		
       

	end
end)

--[[ Citizen.CreateThread(function()
    while true do
        Wait(0)
        foundSomething = false
        SetGarbageTrucks(0)
        SetRandomBoats(0)
        for k,v in pairs(near) do
            if near[k] then
                foundSomething = true
                break
            end
        end
        if foundSomething then
            SetVehicleDensityMultiplierThisFrame(VehicleDensity)
            SetPedDensityMultiplierThisFrame(PedDensity)
            SetRandomVehicleDensityMultiplierThisFrame(VehicleDensity)
            SetScenarioPedDensityMultiplierThisFrame(PedDensity, PedDensity)
        else
            SetVehicleDensityMultiplierThisFrame(0.0)
            SetPedDensityMultiplierThisFrame(0.0)
            SetRandomVehicleDensityMultiplierThisFrame(0.0)
            SetParkedVehicleDensityMultiplierThisFrame(0.0)
            SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
        end
    end
end) ]]
local thatBlip = {}

function DrawTheMarkBrother(team,zone)
	if DoesBlipExist(thatBlip[zone]) then
		RemoveBlip(thatBlip[zone])
	end
	Wait(2000)
	thatBlip[zone] = AddBlipForRadius(vector3(ConfigCL.Zones[zone].Center.x, ConfigCL.Zones[zone].Center.y, ConfigCL.Zones[zone].Center.z), ConfigCL.Zones[zone].Radius)
	SetBlipHighDetail(thatBlip[zone], true)
    --SetBlipColour(thatBlip[zone], 1)
	SetBlipAlpha(thatBlip[zone], 128)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Safezone')
	EndTextCommandSetBlipName(thatBlip[zone])
	
	local blip = AddBlipForCoord(vector3(ConfigCL.Zones[zone].Center.x, ConfigCL.Zones[zone].Center.y, ConfigCL.Zones[zone].Center.z))
	
	SetBlipHighDetail(blip, true)
	SetBlipSprite(blip, 140)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, 1)
	SetBlipAsShortRange(blip, true)
	
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Drug Dealer')
	EndTextCommandSetBlipName(blip)
end

function makeNpc(zone)
    local choosenPed = "g_m_y_salvaboss_01"
    choosenPed = string.upper(choosenPed)
    RequestModel(GetHashKey(choosenPed))
    while not HasModelLoaded(GetHashKey(choosenPed)) or not HasCollisionForModelLoaded(GetHashKey(choosenPed)) do
        Wait(1)
    end
    local npc = CreatePed(4, GetHashKey(choosenPed), ConfigCL.Zones[zone].Center.x, ConfigCL.Zones[zone].Center.y, ConfigCL.Zones[zone].Center.z, 100.0, false, true)
    SetEntityHeading(npc, ConfigCL.Zones[zone].Heading)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    local name = "DrugZone_" .. tostring(zone)
    TriggerEvent("esx_utilities:add",name,"Press ~INPUT_CONTEXT~ to Capture",38,15.0,1,ConfigCL.Zones[zone].Center,{x=1.5, y=1.5, z=0.5},{r=250, g=0, b=0},GetCurrentResourceName())
end


AddEventHandler("pressedmarker", function(markerlabel,MarkerObject)
	if MarkerObject.resource == GetCurrentResourceName() then
		if string.find(markerlabel, "DrugZone_") then
            local given = string.gsub(markerlabel, "DrugZone_","")
            OpenMenu(given)
        end
	end
end)

function OpenMenu(givenZone)
    local options ={
        {label = "Claim Area", value = "claim"},
        {label = "Take Money", value = "takemoney"}
    }
    ESX.TriggerServerCallback("esx_drugdealer:howmuch", function(cb) 
        table.insert(options, {label = "Balance: <font color='green'>" .. cb .. "$", value = ""})
    end, givenZone)
    Wait(500)
    Citizen.CreateThread(function()
        local coords = GetEntityCoords(PlayerPedId())
        Wait(1000)

        while ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'esx_drugdealer_actions') do
            Wait(0)
            if #(GetEntityCoords(PlayerPedId()) - coords) > 2.0 then
        		ESX.UI.Menu.CloseAll()
                break
            end
        end
    end)
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'esx_drugdealer_actions', {
        title    = "Zone Actions",
        align    = 'bottom-right',
        elements = options
    }, function(data, menu)
        if data.current.value == "claim" then
            if cooldown then
                TriggerServerEvent("esx_drugdealer:capture", givenZone)
                Citizen.CreateThread(function()
                    cooldown = false
                    Citizen.Wait(5000)
                    cooldown = true
                end)
            else
                ESX.ShowNotification("Please wait!")
            end
            menu.close()
        elseif data.current.value == "takemoney" then

            if cooldown then
                Citizen.CreateThread(function()
                    cooldown = false
                    Citizen.Wait(5000)
                    cooldown = true
                end)
                local nowCooooords = GetEntityCoords(PlayerPedId())
                exports['progressBars']:startUI2(3000, "Claiming money..")
                Wait(3000)
                if #(nowCooooords - GetEntityCoords(PlayerPedId())) < 3.0 then
                    TriggerServerEvent("esx_drugdealer:claimMoney", givenZone)
                end
                
            else
                ESX.ShowNotification("Please wait!")
            end

           
            menu.close()
        end
    end,function(data,menu)
        menu.close()
    end)
end

RegisterNetEvent('esx_drugdealer:startCapture')
AddEventHandler('esx_drugdealer:startCapture', function()
    FreezeEntityPosition(PlayerPedId(), true)
    exports['progressBars']:startUI2(15000, "Capturing")
    Wait(15000)
    FreezeEntityPosition(PlayerPedId(), false)
end)

RegisterNetEvent('esx_drugdealer:update')
AddEventHandler('esx_drugdealer:update', function(zone, status)
    ConfigCL.Zones[zone].Status = status
    SetBlipColour(thatBlip[zone], 1)
end)




local pedModels = {
	"A_M_M_Hillbilly_02",
	"a_m_m_afriamer_01",
	"a_m_m_salton_02",
	"a_m_y_vindouche_01",
	"a_m_o_beach_01",
	"a_m_y_clubcust_01",
}

local walkStyles = {
	"anim_group_move_ballistic",
	"move_lester_CaneUp",
}

local spawnedPeds = 0
Citizen.CreateThread(function()
	Citizen.Wait(2000)
	while true do 
		inzoneToSpawn = false
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		for k,v in pairs(near) do
            if near[k] then
                if #(coords - ConfigCL.Zones[k].Center) <= ConfigCL.Zones[k].Radius then
                    inzoneToSpawn = true
                end
            end
		end
		if inzoneToSpawn then
			SpawnPedsAndAttack()
		end
		Citizen.Wait(5000)
	end
end)

function SpawnPedsAndAttack()
	if spawnedPeds > 20 then
		return
	end
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed, true)
	for i=1, 3, 1 do
		x, y, z = table.unpack(coords)
		choosenPed = pedModels[math.random(1, #pedModels)]
		choosenPed = string.upper(choosenPed)
		RequestModel(GetHashKey(choosenPed))
		while not HasModelLoaded(GetHashKey(choosenPed)) or not HasCollisionForModelLoaded(GetHashKey(choosenPed)) do
			Wait(1)
		end
		local newX 
		local newY 
		local newZ = z + 999.0
		while not newX do
			Citizen.Wait(0)
			local newXRandom = math.random(-20, 20)
			if newXRandom > 15 or newXRandom < -15 then
				newX = x + newXRandom
			end
		end
		while not newY do
			Citizen.Wait(0)
			local newYRandom = math.random(-20, 20)
			if newYRandom > 15 or newYRandom < -15 then
				newY = y + newYRandom
			end
		end
		_,newZ = GetGroundZFor_3dCoord(newX+.0,newY+.0,z, 1)
		local ped = CreatePed(4, GetHashKey(choosenPed), newX, newY, newZ, 0.0, false, true)
		spawnedPeds = spawnedPeds + 1
		
		SetPedConfigFlag(ped,100,1)
		--local random = math.random(1,100)
        local random = 100
        local coords22 = GetEntityCoords(ped)
        if random < 75 then
            local scenarios = {
                "WORLD_HUMAN_AA_COFFEE",
                "WORLD_HUMAN_DRUG_DEALER",
                "WORLD_HUMAN_DRINKING",
                "WORLD_HUMAN_SMOKING",
            }
            local randsec = math.random(1, #scenarios)
            TaskStartScenarioInPlace(ped, scenarios[randsec], 0, true)
        else
            TaskWanderInArea(ped, coords22.x, coords22.y, coords22.z, 40.0 ,0.0, 10000)
        end
		Citizen.CreateThread(function()
			while not IsEntityDead(ped) do
				local playerPed = PlayerPedId()
				local playerCoords = GetEntityCoords(playerPed)
				local pedCoords = GetEntityCoords(ped)
				if GetDistanceBetweenCoords(playerCoords,pedCoords, false) > 200 then
					DeleteEntity(ped)
					spawnedPeds = spawnedPeds - 1
					ped = nil
				end
				Wait(100)
			end
			if ped and IsEntityDead(ped) and GetDistanceBetweenCoords(playerCoords,pedCoords, false) <= 200 then
                DeleteEntity(ped)
                spawnedPeds = spawnedPeds - 1
                return
			end
		end)
	end
end

exports('IsInDrugDealer', function()
    return inRedzone
end)