Config = {}

Config.EventsHtml = {
	['kills']	= 'Kills',
	['time']    = 'Time',
}

Config.Events = {
    ['atm_robberies'] = {
        onServer = function(xKiller, xPlayer)
            if GlobalState.atmRobberyVehCoords and #(GlobalState.atmRobberyVehCoords-GetEntityCoords(GetPlayerPed(xKiller.source))) < 50.0 then
                return true
            end

            return false
        end,
        onClient = function()
            if GlobalState.atmRobberyVehCoords and #(GlobalState.atmRobberyVehCoords-GetEntityCoords(PlayerPedId())) < 50.0 then
                return true
            end

            return false
        end
    },
    ['territories'] = {
        onServer = function(xKiller, xPlayer)
            return exports['territories']:IsOnTerritories(xKiller.source)
        end,
        onClient = function()
            return exports['territories']:IsInEvent()
        end
    },
    ['warzone'] = {
        onServer = function(xKiller, xPlayer)
            return exports['warzone']:IsOnWarzone(xKiller.source)
        end,
        onClient = function()
            return exports['warzone']:IsOnWarzone()
        end
    },
    ['centralbank'] = {
        onServer = function(xKiller, xPlayer)
            return exports['centralbank']:InEvent(xKiller.source)
        end,
        onClient = function()
            return exports['centralbank']:InOnCentralBank()
        end
    },
    ['bandana_wars'] = {
        onServer = function(xKiller, xPlayer)
            return exports['bandana_wars']:InEvent(xKiller.source)
        end,
        onClient = function()
            return exports['bandana_wars']:InEvent()
        end
    },
    ['ghetto'] = {
        onServer = function(xKiller, xPlayer)
            return exports['ghetto']:IsOnGhetto(xKiller.source)
        end,
        onClient = function()
            return exports['ghetto']:IsOnGhetto()
        end
    },
    ['pubg_night'] = {
        onServer = function(xKiller, xPlayer)
            return exports['pubg_night']:IsInEvent(xKiller.source)
        end,
        onClient = function()
            return GlobalState.inPubg
        end
    },
    ['cityKing'] = {
        onServer = function(xKiller, xPlayer)
            return exports['cityKing']:IsOnCityKing(xKiller.source)
        end,
        onClient = function()
            return exports['cityKing']:IsOnCityKing()
        end
    },
    ['gang_wars'] = {
        onServer = function(xKiller, xPlayer)
            return exports['gang_wars']:IsOnGangWars(xKiller.source)
        end,
        onClient = function()
            return exports['gang_wars']:IsInGangWars()
        end
    },
	['cj_CrateDrop'] = {
        onServer = function(xKiller, xPlayer)
            return (exports['buckets']:getPlayerZone(xKiller.source) or 'default') == 'CrateDrop'
        end,
        onClient = function()
            return exports['cj_CrateDrop']:IsOnCrate()
        end
    },
	['cratedrop_v2'] = {
        onServer = function(xKiller, xPlayer)
            return exports['cratedrop_v2']:InZone(xKiller.source)
        end,
        onClient = function()
            return GlobalState.inCratedropV2
        end
    },
	['cargo'] = {
        onServer = function(xKiller, xPlayer)
            if GlobalState.boatCargoCoords and #(GlobalState.boatCargoCoords-GetEntityCoords(GetPlayerPed(xKiller.source))) < 50.0 then
                return true
            end

            return false
        end,
        onClient = function()
            if GlobalState.boatCargoCoords and #(GlobalState.boatCargoCoords-GetEntityCoords(PlayerPedId())) < 50.0 then
                return true
            end

            return false
        end
    },
	['drugCargo'] = {
        onServer = function(xKiller, xPlayer)
            if GlobalState.drugCargoCoords and #(GlobalState.drugCargoCoords-GetEntityCoords(GetPlayerPed(xKiller.source))) < 50.0 then
                return true
            end

            return false
        end,
        onClient = function()
            if GlobalState.drugCargoCoords and #(GlobalState.drugCargoCoords-GetEntityCoords(PlayerPedId())) < 50.0 then
                return true
            end

            return false
        end
    },
    ['premiumCargo'] = {
        onServer = function(xKiller, xPlayer)
            if GlobalState.premiumCargoCoords and #(GlobalState.premiumCargoCoords-GetEntityCoords(GetPlayerPed(xKiller.source))) < 50.0 then
                return true
            end

            return false
        end,
        onClient = function()
            if GlobalState.premiumCargoCoords and #(GlobalState.premiumCargoCoords-GetEntityCoords(PlayerPedId())) < 50.0 then
                return true
            end

            return false
        end
    },
	['car_cargo'] = {
        onServer = function(xKiller, xPlayer)
            if GlobalState.carcargoCoords and #(GlobalState.carcargoCoords-GetEntityCoords(GetPlayerPed(xKiller.source))) < 50.0 then
                return true
            end

            return false
        end,
        onClient = function()
            if GlobalState.carcargoCoords and #(GlobalState.carcargoCoords-GetEntityCoords(PlayerPedId())) < 50.0 then
                return true
            end

            return false
        end
    },
	['cayo_cargo'] = {
        onServer = function(xKiller, xPlayer)
            if GlobalState.cayoCargoCoords and #(GlobalState.cayoCargoCoords-GetEntityCoords(GetPlayerPed(xKiller.source))) < 50.0 then
                return true
            end

            return false
        end,
        onClient = function()
            if GlobalState.cayoCargoCoords and #(GlobalState.cayoCargoCoords-GetEntityCoords(PlayerPedId())) < 50.0 then
                return true
            end

            return false
        end
    },
	['police_cargo'] = {
        onServer = function(xKiller, xPlayer)
            if GlobalState.polcargoCoords and #(GlobalState.polcargoCoords-GetEntityCoords(GetPlayerPed(xKiller.source))) < 50.0 then
                return true
            end

            return false
        end,
        onClient = function()
            if GlobalState.polcargoCoords and #(GlobalState.polcargoCoords-GetEntityCoords(PlayerPedId())) < 50.0 then
                return true
            end

            return false
        end
    },
	['gang_cargo'] = {
        onServer = function(xKiller, xPlayer)
            if GlobalState.gngcargoCoords and #(GlobalState.gngcargoCoords-GetEntityCoords(GetPlayerPed(xKiller.source))) < 50.0 then
                return true
            end

            return false
        end,
        onClient = function()
            if GlobalState.gngcargoCoords and #(GlobalState.gngcargoCoords-GetEntityCoords(PlayerPedId())) < 50.0 then
                return true
            end

            return false
        end
    },
	['heli_cargo'] = {
        onServer = function(xKiller, xPlayer)
            if GlobalState.helicargoCoords and #(GlobalState.helicargoCoords-GetEntityCoords(GetPlayerPed(xKiller.source))) < 50.0 then
                return true
            end

            return false
        end,
        onClient = function()
            if GlobalState.helicargoCoords and #(GlobalState.helicargoCoords-GetEntityCoords(PlayerPedId())) < 50.0 then
                return true
            end

            return false
        end
    },
	['military_cargo'] = {
        onServer = function(xKiller, xPlayer)
            if GlobalState.milcargoCoords and #(GlobalState.milcargoCoords-GetEntityCoords(GetPlayerPed(xKiller.source))) < 50.0 then
                return true
            end

            return false
        end,
        onClient = function()
            if GlobalState.milcargoCoords and #(GlobalState.milcargoCoords-GetEntityCoords(PlayerPedId())) < 50.0 then
                return true
            end

            return false
        end
    },
}