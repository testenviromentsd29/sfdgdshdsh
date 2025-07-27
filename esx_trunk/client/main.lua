
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



local PlayerData                = {}

local ItemLabels 				= {}
local currentPlate				= ""
local currentVehicle			= nil
local lastPress 				= -50


ESX                             = nil



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

end)

RegisterNetEvent('esx_trunk:open')
AddEventHandler('esx_trunk:open', function()
	OpenPlateMenu()
end)

RegisterNetEvent('esx_trunk:closeVehTrunk')
AddEventHandler('esx_trunk:closeVehTrunk', function()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	if DoesEntityExist(vehicle) then
		TriggerServerEvent('vehicleDeleter:refresh', NetworkGetNetworkIdFromEntity(vehicle))
		SetVehicleDoorShut(vehicle, 5, false)
	end
end)

function OpenPlateMenu()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		ESX.ShowNotification("Can\'t do that while in vehicle!")
		return
	end

	local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
	local vehicle = nil
	if IsPedInAnyVehicle(playerPed, false) then
        vehicle = GetVehiclePedIsIn(playerPed, false)
    else
        vehicle = getVehicleInDirection(3.0)

        if not DoesEntityExist(vehicle) then
            vehicle = GetClosestVehicle(coords, 3.0, 0, 70)
        end
    end
	if DoesEntityExist(vehicle) then
		local lockStatus = GetVehicleDoorLockStatus(vehicle)
        if lockStatus == 0 or lockStatus == 1 then
			local trunkpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "boot"))
            local distanceToTrunk = GetDistanceBetweenCoords(coords, trunkpos, 1)
            if distanceToTrunk <= 5.0 or (trunkpos.x + trunkpos.y + trunkpos.z) == 0.0 then
				ClearPedTasksImmediately(PlayerPedId())
				currentVehicle = vehicle
				TriggerEvent(
                    "mythic_progressbar:client:progress",
                    {
                        name = "Open_Trunk",
                        duration = Config.OpenTime,
                        label = 'Opening Trunk..',
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true
                        }
                    },
                    function(status)
                        if not status then
							local plate = GetVehicleNumberPlateText(vehicle)
							SetVehicleDoorOpen(vehicle, 5, false, false)
							currentPlate = plate
							local content = getContent(plate)
							if content == "opened" then 
								ESX.ShowNotification("Trunk is opened by another player!!")
								return 
							end
							ClearPedTasksImmediately(PlayerPedId())
							startSecurity()
							TriggerServerEvent('vehicleDeleter:refresh', NetworkGetNetworkIdFromEntity(vehicle))
							exports['esx_inventoryhud_matza']:OpenShop(content, 'esx_trunk:Cb',"Trunk: "..plate.."<div id='capacity'>Capacity: "..getInventoryWeight(content).."/"..getVehicleWeight(vehicle,GetVehicleClass(vehicle),GetEntityModel(vehicle)).."</div>","trunk")

							
                        end
                    end
                )
			else
				ESX.ShowNotification("Please go the trunk")
			end
		else
			ESX.ShowNotification("Trunk is locked!")
		end
	end

	
end

RegisterNetEvent('esx_trunk:Cb')
AddEventHandler('esx_trunk:Cb', function(data,action)
	if action == "put" then 
		local item_obj = {}
		item_obj.count = data.item.count
		if data.item.type == "item_standard" then 
			item_obj.count = data.quantity
		end
		item_obj.name = data.item.name 
		item_obj.wid = data.item.wid
		item_obj.durability = data.item.durability
		item_obj.type = data.item.type
		item_obj.power = data.item.power
		ESX.TriggerServerCallback('esx_trunk:addItem', function()
			
			local content = getContent(currentPlate)
			if content == "opened" then 
				ESX.ShowNotification("Trunk is opened by another player!!")
				return 
			end
			startSecurity()
			exports['esx_inventoryhud_matza']:OpenShop(content, 'esx_trunk:Cb',"Trunk: "..currentPlate.."<div id='capacity'>Capacity: "..getInventoryWeight(content).."/"..getVehicleWeight(currentVehicle,GetVehicleClass(currentVehicle),GetEntityModel(currentVehicle)).."</div>","trunk")
			
		end,currentPlate,item_obj,GetEntityModel(currentVehicle),GetVehicleClass(currentVehicle))
		
	elseif action == "buy" then 
		local item_obj = {}
		item_obj.count = data.item.count
		if data.item.type == "standard_item" then 
			item_obj.count = data.quantity
		end
		item_obj.name = data.item.name 
		item_obj.wid = data.item.wid
		item_obj.durability = data.item.durability
		item_obj.type = data.item.type
		ESX.TriggerServerCallback('esx_trunk:removeItem', function()
			ESX.TriggerServerCallback('esx_trunk:getPlateContent', function(items)
				local content = getContent(currentPlate)
				if content == "opened" then 
					ESX.ShowNotification("Trunk is opened by another player!!")
					return 
				end
				startSecurity()
				exports['esx_inventoryhud_matza']:OpenShop(content, 'esx_trunk:Cb',"Trunk: "..currentPlate.."<div id='capacity'>Capacity: "..getInventoryWeight(content).."/"..getVehicleWeight(currentVehicle,GetVehicleClass(currentVehicle),GetEntityModel(currentVehicle)).."</div>","trunk")
			end,currentPlate,GetEntityModel(currentVehicle))
		end,currentPlate,item_obj,GetEntityModel(currentVehicle))
	elseif action == "takeall" then
		ESX.TriggerServerCallback('esx_trunk:removeAll', function()
			ESX.TriggerServerCallback('esx_trunk:getPlateContent', function(items)
				local content = getContent(currentPlate)
				if content == "opened" then 
					ESX.ShowNotification("Trunk is opened by another player!!")
					return 
				end
				startSecurity()
				exports['esx_inventoryhud_matza']:OpenShop(content, 'esx_trunk:Cb',"Trunk: "..currentPlate.."<div id='capacity'>Capacity: "..getInventoryWeight(content).."/"..getVehicleWeight(currentVehicle,GetVehicleClass(currentVehicle),GetEntityModel(currentVehicle)).."</div>","trunk")
			end,currentPlate,GetEntityModel(currentVehicle))
		end,currentPlate,GetEntityModel(currentVehicle))
	elseif action == "depositall" then
		ESX.TriggerServerCallback('esx_trunk:addAll', function()
			ESX.TriggerServerCallback('esx_trunk:getPlateContent', function(items)
				local content = getContent(currentPlate)
				if content == "opened" then 
					ESX.ShowNotification("Trunk is opened by another player!!")
					return 
				end
				startSecurity()
				exports['esx_inventoryhud_matza']:OpenShop(content, 'esx_trunk:Cb',"Trunk: "..currentPlate.."<div id='capacity'>Capacity: "..getInventoryWeight(content).."/"..getVehicleWeight(currentVehicle,GetVehicleClass(currentVehicle),GetEntityModel(currentVehicle)).."</div>","trunk")
			end,currentPlate,GetEntityModel(currentVehicle))
		end,currentPlate,GetEntityModel(currentVehicle),GetVehicleClass(currentVehicle))
	end
end)

function getContent(plate)
	local answer = nil 
	ESX.TriggerServerCallback('esx_trunk:getPlateContent', function(items)
		if items == nil  then 
			answer = "opened"
			return 
		elseif type(items) == "string" then 
			ESX.ShowNotification(items)
			return
		end
		local tmp = {}
		for item_name, obj in pairs(items) do 
			if string.find(item_name,"WEAPON_") then 
				table.insert(tmp, {
					label = ESX.GetWeaponLabel(item_name) or item_name,
					name = item_name,
					count = obj.count,
					durability = obj.extra_data.durability,
					power = obj.extra_data.power,
					id = obj.extra_data.wid
				})
			else
				table.insert(tmp, {
					label = item_name,
					name = item_name,
					count = obj.count,
					type = "standard_item"
				})
			end
		end
		answer = tmp
	end,plate,GetEntityModel(currentVehicle))
	while answer == nil do 
		Wait(0)
	end
	return answer
end

function startSecurity()
	if not exports.esx_inventoryhud_matza:isAnyUIOpen() then
		Wait(500)
		TriggerServerEvent("esx_trunk:setstatus", currentPlate,true)
		CreateThread(function()
			TriggerEvent('vMenu:enableMenu', false)
			while exports.esx_inventoryhud_matza:isAnyUIOpen() do 
				Wait(0)
				DisableControlAction(0, 289)
				ESX.UI.Menu.CloseAll()
				if IsEntityPlayingAnim(PlayerPedId(), "random@mugging3", "handsup_standing_base", 3) then
					ClearPedTasksImmediately(PlayerPedId())
				end
				if DoesEntityExist(currentVehicle) then
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(currentVehicle),false) > 3 then
						TriggerEvent("closeInventory")
					end
				else
					TriggerEvent("closeInventory")
				end
			end
			TriggerEvent('vMenu:enableMenu', true)
			TriggerServerEvent("esx_trunk:setstatus", currentPlate,false)
			SetVehicleDoorShut(currentVehicle, 5, false)
		end)

		
	end
end

function getVehicleInDirection(range)
    local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, range, 0.0)

    local rayHandle = CastRayPointToPoint(coordA.x, coordA.y, coordA.z, coordB.x, coordB.y, coordB.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end

function getInventoryWeight(content)
    local weight = 0
    for i,obj in pairs(content) do 
        if string.find(obj.name,"WEAPON_") then 
            weight = weight + Config.WeaponWeight 
        else
            weight = weight + obj.count
        end
    end
    return weight
end

function getVehicleWeight(vehicle,class,veh_model)
	local maxweight = Config.CustomTrunks[veh_model] or Config.VehicleTrunkLimit[class] or Config.DefaultTrunkCapacity
	
	if ESX.PlayerData.subscription then
		maxweight = maxweight + (Config.SubExtraCapacity[ESX.PlayerData.subscription] or 0)
	end



    return maxweight
end

AddEventHandler("justpressed",function(label,key)
    if label == Config.OpenKey then
		if GetGameTimer()/1000 - lastPress > 10 then 
			if GetVehiclePedIsIn(PlayerPedId()) == 0 then
				lastPress = GetGameTimer()/1000
				
				if not IsPedFalling(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
					OpenPlateMenu()
				end
			else
				ESX.ShowNotification("You can't use while in vehicle")
			end
		else
			ESX.ShowNotification("You need to wait to open the trunk again")
		end
	end
end)