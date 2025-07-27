Config = {}

Config.disableFirePositions = {
    {coords = vector3(-410.93, 1173.44, 325.64), radius = 150},
    {coords = vector3(2508.57, -383.85, 94.12), radius = 200},
    {coords = vector3(60.67, 3645.35, 39.71), radius = 150},
}

Config.Events = {
    ['enaevent'] = {
        inEvent = function() return exports['enaevent']:IsOnGMEvent() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            if ESX.GetPlayerData().subscription then
                return false

            else
                return true

            end

        end,
    },
    ['yacht_event'] = {
        inEvent = function() return exports['yacht_event']:InEvent() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return false
        end,
    },
    ['pvm_raids'] = {
        inEvent = function() return exports['pvm_raids']:InEvent() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return false
        end,
    },
    ['crate_night'] = {
        inEvent = function() return exports['crate_night']:InEvent() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return not revivedFromMedkit
        end,
    },
    ['cargo_night'] = {
        inEvent = function() return exports['cargo_night']:InEvent() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return not revivedFromMedkit
        end,
    },
    ['police_cargo_v2'] = {
        inEvent = function() return exports['police_cargo_v2']:InEvent() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return not revivedFromMedkit
        end,
    },
    ['all_cargo'] = {
        inEvent = function() return exports['all_cargo']:InEvent() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return not revivedFromMedkit
        end,
    },
    ['turf_wars'] = {
        inEvent = function() return exports['turf_wars']:InEvent() end,
        respawnTime = 15,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return not revivedFromMedkit
        end,
    },
    ['criminal_raids'] = {
        inEvent = function() return exports['criminal_raids']:InEvent() end,
        respawnTime = 15,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return not revivedFromMedkit
        end,
    },
    ['drugs_v2'] = {
        inEvent = function() return exports['drugs_v2']:InZone() end,
        respawnTime = 15,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return not revivedFromMedkit
        end,
    },
    ['submarine_event'] = {
        inEvent = function() return exports['submarine_event']:InEvent() end,
        respawnTime = 15,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return not revivedFromMedkit
        end,
    },
    ['bandana_wars'] = {
        inEvent = function() return exports['bandana_wars']:InEvent() end,
        respawnTime = 15,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return not revivedFromMedkit
        end,
    },
	['cratedrop_v2'] = {
		analyticsLog = '',
        inEvent = function() return GlobalState.inCratedropV2 end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return not revivedFromMedkit
        end,
    },
	['school_crate'] = {
		analyticsLog = '',
        inEvent = function() return exports['school_crate']:IsInEvent() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return not revivedFromMedkit
        end,
    },
	['atm_robberies'] = {
		analyticsLog = 'atm-masters',
        inEvent = function() return exports['atm_robberies']:IsInZone() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return not revivedFromMedkit
        end,
    },
	['kos'] = {
		analyticsLog = 'kos-masters',
        inEvent = function() return GlobalState.inKOS end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
	['ctm'] = {
		analyticsLog = 'ctm-masters',
        inEvent = function() return GlobalState.inCTM end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return not revivedFromMedkit
        end,
    },
	['military_cargo'] = {
		analyticsLog = 'military-cargo-masters',
        inEvent = function() return exports['military_cargo']:IsOnMilitaryCargo() end,
        respawnTime = 5,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
	['pubg_night'] = {
        inEvent = function() return GlobalState.inPubg end,
        respawnTime = 15,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
			if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return false
        end,
    },
	['fortnite'] = {
        inEvent = function() return GlobalState.inFortnite end,
        respawnTime = 15,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
			if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return false
        end,
    },
	['train_event'] = {
		analyticsLog = 'train-masters',
        inEvent = function() return exports['train_event']:IsOnTrainEvent() end,
        respawnTime = 5,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
	['farmzone'] = {
        inEvent = function() return exports['farmzone']:IsInZone() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
	['territories'] = {
		analyticsLog = 'territories-masters',
        inEvent = function() return exports['territories']:IsInEvent() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return not revivedFromMedkit
        end,
    },
    ['fPubg'] = {
        inEvent = function() return exports["fPubg"]:IsInEvent() end,
        respawnTime = 20,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
			if not revivedFromMedkit then
				local closestDist
				local pos
				for k,v in pairs(respawnPoints) do
					local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
					if closestDist == nil or dist < closestDist then
						closestDist = dist
						pos = k
					end
				end
				return respawnPoints[pos].coords
			end
        end,
        removeStuff = function(revivedFromMedkit)
            return false
        end,
    },
    ['killspackage'] = {
        inEvent = function() return exports['killspackage']:IsInZone() end,
        respawnTime = 30,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
            local closestDist
            local pos
            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
    ['raidFields'] = {
		analyticsLog = 'raidfields-masters',
        inEvent = function() return exports['raidFields']:IsOnRaidFields() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
            if not revivedFromMedkit then
                local closestDist
                local pos
                for k,v in pairs(respawnPoints) do
                    local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                    if closestDist == nil or dist < closestDist then
                        closestDist = dist
                        pos = k
                    end
                end
                return respawnPoints[pos].coords
            end
        end,
        removeStuff = function(revivedFromMedkit)
            return not revivedFromMedkit
        end,
    },
    ['customgames'] = {
        inEvent = function() return GlobalState.InCustomGame end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
            return nil
        end,
        removeStuff = function(revivedFromMedkit)
            return false
        end,
    },
    ['sentra'] = {
        inEvent = function() return exports['sentra']:IsInZone() end,
        respawnTime = 30,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
            if not revivedFromMedkit then
                return exports['sentra']:GetRespawnLocation()
            end
        end,
        removeStuff = function(revivedFromMedkit)
            return false
        end,
    },
    ['football_map'] = {
        inEvent = function() return exports['football_map']:IsInZone() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
            if not revivedFromMedkit then
                local closestDist
                local pos
                for k,v in pairs(respawnPoints) do
                    local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                    if closestDist == nil or dist < closestDist then
                        closestDist = dist
                        pos = k
                    end
                end
                return respawnPoints[pos].coords
            end
        end,
        removeStuff = function(revivedFromMedkit)
            return not revivedFromMedkit
        end,
    },
    ['fortFight'] = {
        analyticsLog = 'cayo-perico-masters',
        inEvent = function() return exports['fortFight']:IsInZone() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
            return exports['fortFight']:GetRespawnLocation()
        end,
        removeStuff = function(revivedFromMedkit)
            return exports['fortFight']:IsInFort()
        end,
    },
    ['job_raids'] = {
        inEvent = function() return GlobalState.IsInJobRaids end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
            local respawnCoords = {
                vector3(-890.33, -851.53, 20.57)
            }
            return respawnCoords[math.random(1, #respawnCoords)]
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
    ['battleRoyale'] = {
        inEvent = function() return exports['battleRoyale']:IsInEvent() end,
        respawnTime = 60,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
            if not revivedFromMedkit and exports['battleRoyale']:IsInEvent() then
                return exports['battleRoyale']:RespawnPoint()
            end
        end,
        removeStuff = function(revivedFromMedkit) 
            return false
        end,
    },
    ['drugCargo'] = {
        analyticsLog = 'drug-cargo-masters',
        inEvent = function() return exports['drugCargo']:IsOnDrugCargo() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            local closestDist
            local pos
            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit) 
            return true
        end,
    },
	['premiumCargo'] = {
        analyticsLog = 'premium-cargo-masters',
        inEvent = function() return exports['premiumCargo']:IsOnPremiumCargo() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            local closestDist
            local pos
            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit) 
            return true
        end,
    },
    ['cargo'] = {
        analyticsLog = 'boat-cargo-masters',
        inEvent = function() return exports['cargo']:IsOnBoatCargo() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            local respawnCoords = {
                vector3(4061.73, -4681.59, 4.18)
            }
            return respawnCoords[math.random(1, #respawnCoords)]
        end,
        removeStuff = function(revivedFromMedkit) 
            return true
        end,
    },
    ['gang_cargo'] = {
        analyticsLog = 'criminal-cargo-masters',
        inEvent = function() return exports['gang_cargo']:IsOnGangCargo() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            local closestDist
            local pos
            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit) 
            return true
        end,
    },
    ['police_cargo'] = {
		analyticsLog = 'police-cargo-masters',
        inEvent = function() return exports['police_cargo']:IsOnPoliceCargo() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            local closestDist
            local pos
            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit) 
            return true
        end,
    },
	['heli_cargo'] = {
		analyticsLog = 'heli-cargo-masters',
        inEvent = function() return GlobalState.inHeliCargo end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            local closestDist
            local pos
            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit) 
            return true
        end,
    },
    ['vangelico_rob'] = {
        analyticsLog = 'vangelico-masters',
        inEvent = function() return exports['vangelico_rob']:IsOnVangelicoCargo() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            local closestDist
            local pos
            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit) 
            return true
        end,
    },
    ['battleground'] = {
        analyticsLog = 'battlegrounds-masters',
        inEvent = function() return exports['battleground']:IsOnBattleground() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            local closestDist
            local pos
            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit) 
            return true
        end,
    },
    ['humane'] = {
        inEvent = function() return exports['humane']:IsOnHumane() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            return vector3(1837.75, 3666.11, 33.68)
        end,
        removeStuff = function(revivedFromMedkit) 
            return true
        end,
    },
    ['ghetto'] = {
        analyticsLog = 'ghetto-masters',
        inEvent = function() return exports['ghetto']:IsOnGhetto() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            return exports["ghetto"]:getRespawnCoords()
        end,
        removeStuff = function(revivedFromMedkit) 
            return false--exports.ghetto:hasGhettoStarted()
        end,
    },
    ['cj_CrateDrop'] = {
        analyticsLog = 'carolos-crate-masters',
        inEvent = function() return exports['cj_CrateDrop']:IsOnCrate() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            local closestDist
            local pos
            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit) 
            return true
        end,
    },
    ['cj_GroveDrop'] = {
        analyticsLog = 'groove-crate-masters',
        inEvent = function() return exports['cj_GroveDrop']:IsOnGroveCrate() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
            local closestDist
            local pos
            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
    ['cj_PaletoDrop'] = {
        analyticsLog = 'paleto-crate-masters',
        inEvent = function() return exports['cj_PaletoDrop']:IsOnPaletoCrate() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
            local closestDist
            local pos
            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit)
            return false
        end,
    },
	['cj_SandyDrop'] = {
        analyticsLog = 'sandy-crate-masters',
        inEvent = function() return exports['cj_SandyDrop']:IsOnSandyCrate() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
            local closestDist
            local pos
            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
    ['cratedrop'] = {
        analyticsLog = 'crate-night-masters',
        inEvent = function() return exports['cratedrop']:IsOnCrate() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            return vector3(1856.51, 2586.34, 45.67)
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
    ['cityKing'] = {
        analyticsLog = 'cityking-masters',
        inEvent = function() return exports['cityKing']:IsOnCityKing() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            local closestDist
            local pos
            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
    ['warzone'] = {
        analyticsLog = 'warzone-masters',
        inEvent = function() return exports['warzone']:IsOnWarzone() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            local closestDist
            local pos
            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
    ['captureTheFlag'] = {
        analyticsLog = 'capture-the-flag-masters',
        inEvent = function() return exports['captureTheFlag']:IsInCaptureTheFlag() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
            return vector3(-1734.35, 160.83, 64.37)
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
    ['policeRaid'] = {
        inEvent = function() return exports["policeRaid"]:inZone() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
            return exports["policeRaid"]:getRespawnCoords()
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
    ['pubg'] = {
        inEvent = function() return GlobalState.inPUBG end,
        respawnTime = 30,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
            if not revivedFromMedkit then
                local respawnCoords = {
                    vector3(-2295.41, 374.94, 174.47),
                    vector3(-1738.51, 160.54, 64.37),
                }
                return respawnCoords[math.random(1, #respawnCoords)]
            end
        end,
        removeStuff = function(revivedFromMedkit)
            return false
        end,
    },
    ['pubgvol2'] = {
        inEvent = function() return GlobalState.inPUBG2 end,
        respawnTime = 30,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
            if not revivedFromMedkit then
                local respawnCoords = {
                    vector3(-2295.41, 374.94, 174.47),
                    vector3(-1738.51, 160.54, 64.37),
                }
                return respawnCoords[math.random(1, #respawnCoords)]
            end
        end,
        removeStuff = function(revivedFromMedkit)
            return false
        end,
    },
    ['town_wars'] = {
        analyticsLog = 'town-wars-masters',
        inEvent = function() return GlobalState.IsInTownWars end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            return vector3(-55.91, -1222.03, 28.70)
        end,
        removeStuff = function(revivedFromMedkit)
            if revivedFromMedkit then
                GlobalState.inEvent = nil
            end
            return true
        end,
    },
    ['killzone'] = {
        analyticsLog = 'killzone-masters',
        inEvent = function() return GlobalState.inKillzone end,
        respawnTime = 20,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
            return exports["killzone"]:getRespawnCoords()
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
    ['gang_wars'] = {
        analyticsLog = 'gang-wars-masters',
        inEvent = function() return exports['gang_wars']:IsInGangWars() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            return vector3(-44.50, -1221.57, 29.29)
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
    ['raid_drugs'] = {
        inEvent = function() return GlobalState.IsInRaidDrugs end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            local closestDist
            local pos
            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
    ['raids'] = {
        inEvent = function() return GlobalState.inRaid end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            local closestDist
            local pos
            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
    ['centralbank'] = {
        analyticsLog = 'central-bank-masters',
        inEvent = function() return exports["centralbank"]:InOnCentralBank() end,
        respawnTime = 10,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            local respawnCoords = {
                vector3(612.65, 95.76, 92.48),
                vector3(-330.05, 272.82, 86.27),
            }
            return respawnCoords[math.random(1, #respawnCoords)]
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
    ['esx_drugdealer'] = {
        inEvent = function() return exports["esx_drugdealer"]:IsInDrugDealer() end,
        respawnTime = 30,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            local closestDist
            local pos
            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
    ['esx_blackweapondealer'] = {
		analyticsLog = 'blackmarket-masters',
        inEvent = function() return exports["esx_blackweapondealer"]:IsInGunDealer() end,
        respawnTime = 30,
        respawnPosition = function(respawnPoints, revivedFromMedkit)
            if not revivedFromMedkit then
                local closestDist
                local pos
                for k,v in pairs(respawnPoints) do
                    local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                    if closestDist == nil or dist < closestDist then
                        closestDist = dist
                        pos = k
                    end
                end
                return respawnPoints[pos].coords
            end
        end,
        removeStuff = function(revivedFromMedkit)
            return not revivedFromMedkit
        end,
    },
    ['drugs'] = {
        inEvent = function() return exports["drugs"]:IsInDrugField() end,
        respawnTime = 30,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            local closestDist
            local pos
            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit)
            return true
        end,
    },
    ['warzoneRobbery'] = {
        inEvent = function() return exports['warzoneRobbery']:isInEvent() end,
        respawnTime = 90,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            local closestDist
            local pos

            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end
            
            exports['warzoneRobbery']:forceExit()

            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit)
            return false
        end,
    },
    ['eventkillthemall'] = {
        inEvent = function() return exports['eventkillthemall']:isInEvent() end,
        respawnTime = 15,
        respawnPosition = function(respawnPoints, revivedFromMedkit) 
            local closestDist
            local pos

            for k,v in pairs(respawnPoints) do
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true)
                if closestDist == nil or dist < closestDist then
                    closestDist = dist
                    pos = k
                end
            end

            return respawnPoints[pos].coords
        end,
        removeStuff = function(revivedFromMedkit)
            return false
        end,
    },
}

Config.PayComservJailNpc = {
    blip = {
        show = true,
        name = 'Pay Comserv - Jail',
        id = 728,
        color = 0,
        scale = 0.8
    },
    pos = vector3(209.43, -949.49, 30.7),
    heading = 323.92,
    model = GetHashKey('cs_barry')
}

--THIS CONFIG NEEDS TO BE LAST
Config.TimeZones = {
    --[[ {coords = vector3(-640.76, -838.30, 37.04),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(-555.62, -638.84, 39.74),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(-697.42, -3.08, 82.18),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(-1306.54, -335.78, 42.46),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(-1172.74, -701.32, 47.86),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(-469.56, -1086.88, 47.86),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(-398.80, 437.30, 135.46),     radius = 250,       startTime = 7,        endTime = 21},
    {coords = vector3(-1016.64, 465.90, 111.08),     radius = 250,       startTime = 7,        endTime = 21},
    {coords = vector3(405.92, -840.06, 42.70),     radius = 150,       startTime = 7,        endTime = 21},
    {coords = vector3(-151.30, -590.16, 56.70),     radius = 100,       startTime = 7,        endTime = 21},
    {coords = vector3(483.74, -279.90, 46.82),     radius = 50,       startTime = 7,        endTime = 21},
    {coords = vector3(392.64, -97.50, 66.52),     radius = 150,       startTime = 7,        endTime = 21},
    {coords = vector3(-149.68, -378.86, 33.38),     radius = 100,       startTime = 7,        endTime = 21},
    {coords = vector3(-252.14, -646.10, 41.84),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(-62.84, -82.04, 81.46),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(131.86, -21.60, 86.14),     radius = 50,       startTime = 7,        endTime = 21},
    {coords = vector3(-15.12, -392.80, 69.82),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(496.86, -140.32, 69.82),     radius = 150,       startTime = 7,        endTime = 21},
    {coords = vector3(437.94, -359.14, 51.16),     radius = 50,       startTime = 7,        endTime = 21},
    {coords = vector3(241.92, -616.26, 44.18),     radius = 50,       startTime = 7,        endTime = 21},
    {coords = vector3(-1501.44, -255.18, 50.36),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(-1239.08, -1426.12, 23.22),     radius = 150,       startTime = 7,        endTime = 21},
    {coords = vector3(-866.70, -1198.32, 23.22),     radius = 150,       startTime = 7,        endTime = 21},
    {coords = vector3(-693.46, -947.10, 37.20),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(-1610.52, 95.86, 84.94),     radius = 150,       startTime = 7,        endTime = 21},
    {coords = vector3(-1728.58, -563.28, 72.58),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(-1301.34, -877.00, 72.58),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(-736.92, -1239.84, 50.98),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(334.94, -1121.80, 54.86),     radius = 150,       startTime = 7,        endTime = 21},
    {coords = vector3(130.00, -558.24, 49.00),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(172.92, -200.66, 74.38),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(-636.76, 713.16, 197.42),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(-1057.72, 696.28, 173.98),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(-1350.30, 629.10, 172.04),     radius = 200,       startTime = 7,        endTime = 1},
    {coords = vector3(-1326.64, 331.40, 105.62),     radius = 100,       startTime = 7,        endTime = 21},
    {coords = vector3(0.44, 618.48, 226.92),     radius = 150,       startTime = 7,        endTime = 21},
    {coords = vector3(-346.64, 246.38, 115.78),     radius = 200,       startTime = 7,        endTime = 21},
    {coords = vector3(-649.50, 112.02, 88.00),     radius = 100,       startTime = 7,        endTime = 1}, ]]
}
