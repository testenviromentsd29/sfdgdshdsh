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
local PlayerData = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData()
end)






RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

local jobs = {}
local myEnemies
local myAllies
local jInWar = {}
local jInAlliance = {}
local swordsStarted = false
local shieldsStarted = false
local showSwords = true
local showShields = true
local playersWithSwords = {}

RegisterCommand("toggleswords", function()

	showSwords = not showSwords
	if showSwords then
		ESX.ShowNotificatin("Swords Enabled")
	else
		ESX.ShowNotificatin("Swords Disabled")
	end

end, false)

RegisterCommand("toggleshields", function()

	showShields = not showShields
	if showShields then
		ESX.ShowNotificatin("Shields Enabled")
	else
		ESX.ShowNotificatin("Shields Disabled")
	end

end, false)

RegisterNetEvent("esx_mMafia:getJobs")
AddEventHandler("esx_mMafia:getJobs",function(data)

	jobs = data
	if jobs == nil then
		jobs = {}
	end
	
	for k,v in pairs(jInWar) do
		for x,y in pairs(jobs) do
			if y == v then
				ids[x] = true
			end
		end

	end
	myEnemies = ids
	local ids1 = {}
	for k,v in pairs(jInAlliance) do
		for x,y in pairs(jobs) do
			if y == v then
				ids1[x] = true
			end
		end
	end
	myAllies = ids1
	startSwords()
	startShields()
end)

RegisterNetEvent("esx_mMafia:getEnemies")
AddEventHandler("esx_mMafia:getEnemies",function(jobFor,jobsInWar)
	Wait(1000)
	if PlayerData.job.name == jobFor then
		jInWar = jobsInWar
	end

end)

RegisterNetEvent("esx_mMafia:clearenemies")
AddEventHandler("esx_mMafia:clearenemies",function()
	myEnemies = nil
	
end)


RegisterNetEvent("esx_mMafia:getAllies")
AddEventHandler("esx_mMafia:getAllies",function(jobFor,jobsInAlliance)
	Wait(1000)
	if PlayerData.job.name == jobFor then
		jInAlliance = jobsInAlliance
	end

end)

RegisterNetEvent("esx_mMafia:clearallies")
AddEventHandler("esx_mMafia:clearallies",function()
	myAllies = nil
end)



function DrawText3D(x,y,z, text)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    if dist < 65 then
		local scale = (1/dist)*20
		--local fov = (1/GetGameplayCamFov())*70
		local scale = scale--[[ *fov ]]
		SetTextScale(0.0*scale, 0.2*scale)
		
		SetTextFont(0)
		SetTextProportional(1)
		-- SetTextScale(0.0, 0.55)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		SetDrawOrigin(x,y,z, 0)
		DrawText(0.0, 0.0)
		ClearDrawOrigin()
	end
end

function createEnemyTags()
	
	for k,v in pairs(myEnemies or {}) do
		local Player = GetPlayerFromServerId(tonumber(k))
		if NetworkIsPlayerActive(Player) and Player ~= PlayerId() then
			
			local len = string.len("⚔️")/2
			local space = ''
			for i = 1, len do
				space = space..' '
			end
			local tag_text = space.."⚔️"
			local ped = GetPlayerPed(Player)
			if playersWithSwords[tonumber(k)] == nil then 
				playersWithSwords[tonumber(k)] = CreateFakeMpGamerTag(ped, tag_text, 0, 0, "", 0) 
				SetMpGamerTagsVisibleDistance(50.0)
				--SetMpGamerTagAlpha(playersWithSwords[tonumber(k)], 2, 255)
				SetMpGamerTagColour(playersWithSwords[tonumber(k)], 0, 9)
				SetMpGamerTagVisibility(playersWithSwords[tonumber(k)], 2, 1)
			end

		end

	
		
	end

	for k,v in pairs(playersWithSwords) do 
		if myEnemies[tostring(k)] == nil then 
			if IsMpGamerTagActive(v) then
				--remove sword
				RemoveMpGamerTag(v)
			end
		end
	end

end

function startSwords()
	if not swordsStarted then
		swordsStarted = true
		CreateThread(function()
		
			while true do
				createEnemyTags()
				Wait(5000)
			end
			swordsStarted = false
		end)
	end
end

function createAllyTags()
	if myAllies and showShields then
		for k,v in pairs(myAllies) do
			local Player = GetPlayerFromServerId(tonumber(k))
			if NetworkIsPlayerActive(Player) and Player ~= PlayerId() then

				local ped = GetPlayerPed(Player)
				local stars = ''
				local coords = GetEntityCoords(ped)		
				DrawText3D(coords['x'], coords['y'], coords['z']+1.5,"🛡️")	

			end

		end
	end

end

function startShields()
	if not shieldsStarted then
		shieldsStarted = true
		CreateThread(function()
		
			while myAllies do
				createAllyTags()
				Wait(0)
			end
			shieldsStarted = false
		end)
	end
end



RegisterNetEvent("esx_mMafia:declarewarnotify")
AddEventHandler("esx_mMafia:declarewarnotify",function(job)

	TriggerServerEvent('esx_addons_gcphone:startCall', job, "Μόλις σας κύρηξαν πόλεμο!!!")

end)