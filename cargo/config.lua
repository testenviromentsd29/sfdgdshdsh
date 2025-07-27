Config = {}

Config.AllowedHours = {
	[10] = true,
	[11] = true,
	[12] = true,
	[13] = true,
	[14] = true,
	[15] = true,
	[16] = true,
	[17] = true,
	[18] = true,
	[19] = true,
	[20] = true,
	[21] = true,
	[22] = true,
	[23] = true,
	[00] = true,
	[01] = true,
	[02] = true,
	[03] = true,
	[04] = true,
	[05] = true,
	[06] = true,
}

Config.StartCargo = {
    blip = {
        show = true,
        name = 'Cargo Mission',
        id = 67,
        color = 3,
        scale = 0.8
    },
    pos = vector3(13.92, -2798.38, 2.53),
    heading = 356.50,
    model = GetHashKey('s_m_m_dockwork_01')
}

Config.CargoCooldown = 120 --minutes

Config.BoatSpawn = {
    model = 'tug',
    pos = vector3(31.21, -2786.96, -2.0),
    heading = 182.0,
    plate = 'BOTCARGO'
}

Config.Cargos = {
    [1] = {
        Cost = 1000000,

        TimeToKillGuards = 5 * 60, --seconds

        BoatGuards = {
            model = GetHashKey('csb_ramp_marine'),
            positions = {
                {pos = vector3(29.09, -2785.60, 5.31), heading = 100.0},
                {pos = vector3(30.64, -2773.98, 3.22), heading = 100.0},
                {pos = vector3(32.76, -2796.99, 3.40), heading = 100.0},
                {pos = vector3(29.81, -2775.11, 3.19), heading = 100.0},
                --{pos = vector3(29.50, -2777.62, 3.00), heading = 100.0},
                --{pos = vector3(33.59, -2778.48, 2.96), heading = 100.0},
                --{pos = vector3(33.67, -2779.80, 5.00), heading = 100.0},
                --{pos = vector3(33.91, -2785.37, 5.83), heading = 100.0},
                --{pos = vector3(29.38, -2788.94, 5.82), heading = 100.0},
                --{pos = vector3(29.86, -2793.19, 5.37), heading = 100.0},
                --{pos = vector3(33.62, -2793.96, 5.37), heading = 100.0},
                --{pos = vector3(30.95, -2797.57, 3.40), heading = 100.0},
                --{pos = vector3(33.50, -2798.07, 3.63), heading = 100.0},
                --{pos = vector3(35.19, -2794.89, 4.01), heading = 100.0},
                --{pos = vector3(35.95, -2784.21, 2.77), heading = 100.0},
                --{pos = vector3(36.37, -2788.10, 2.83), heading = 100.0},
                --{pos = vector3(36.00, -2792.09, 3.47), heading = 100.0},
                --{pos = vector3(33.34, -2777.81, 3.19), heading = 100.0},
                --{pos = vector3(32.63, -2774.93, 3.28), heading = 100.0},
                --{pos = vector3(33.05, -2771.67, 3.16), heading = 100.0},
            }
        },

        Destination = {
            pos = vector3(-2727.58, 3721.01, 0.07),
            blip = {
                name = 'Deliver Cargo',
                id = 404,
                color = 13,
                scale = 1.2,
            },
            marker = {
                type = 1,
                size = {x = 20.0, y = 20.0, z = 20.0},
                color = {r = 200, g = 0, b = 0},
            }
        },

        Rewards = {
            criminal = {
                {name = 'AMMO_MG',	        amount = 20},
                {name = 'AMMO_SMG',			amount = 20},
                {name = 'AMMO_RIFLE',		amount = 20},
                {name = 'AMMO_PISTOL',		amount = 20},
            },

            police = {
                {name = 'AMMO_MG',	        amount = 20},
                {name = 'AMMO_SMG',			amount = 20},
                {name = 'AMMO_RIFLE',		amount = 20},
                {name = 'AMMO_PISTOL',		amount = 20},
            }   
        }
    },

    --[[[2] = {
        Cost = 600000,

        TimeToKillGuards = 5 * 60, --seconds

        BoatGuards = {
            model = GetHashKey('csb_ramp_marine'),
            positions = {
                {pos = vector3(29.09, -2785.60, 5.31), heading = 100.0},
                {pos = vector3(30.64, -2773.98, 3.22), heading = 100.0},
                {pos = vector3(32.76, -2796.99, 3.40), heading = 100.0},
                {pos = vector3(29.81, -2775.11, 3.19), heading = 100.0},
                {pos = vector3(29.50, -2777.62, 3.00), heading = 100.0},
                {pos = vector3(33.59, -2778.48, 2.96), heading = 100.0},
                {pos = vector3(33.67, -2779.80, 5.00), heading = 100.0},
                {pos = vector3(33.91, -2785.37, 5.83), heading = 100.0},
                {pos = vector3(29.38, -2788.94, 5.82), heading = 100.0},
                {pos = vector3(29.86, -2793.19, 5.37), heading = 100.0},
                {pos = vector3(33.62, -2793.96, 5.37), heading = 100.0},
                {pos = vector3(30.95, -2797.57, 3.40), heading = 100.0},
                {pos = vector3(33.50, -2798.07, 3.63), heading = 100.0},
                {pos = vector3(35.19, -2794.89, 4.01), heading = 100.0},
                {pos = vector3(35.95, -2784.21, 2.77), heading = 100.0},
                --{pos = vector3(36.37, -2788.10, 2.83), heading = 100.0},
                --{pos = vector3(36.00, -2792.09, 3.47), heading = 100.0},
                --{pos = vector3(33.34, -2777.81, 3.19), heading = 100.0},
                --{pos = vector3(32.63, -2774.93, 3.28), heading = 100.0},
                --{pos = vector3(33.05, -2771.67, 3.16), heading = 100.0},
            }
        },

        Destination = {
            pos = vector3(2911.30, 1766.50, -0.04),
            blip = {
                name = 'Deliver Cargo',
                id = 404,
                color = 13,
                scale = 1.2,
            },
            marker = {
                type = 1,
                size = {x = 20.0, y = 20.0, z = 20.0},
                color = {r = 200, g = 0, b = 0},
            }
        },

        Rewards = {
            criminal = {
                {name = 'magic_potion',   amount = 30},
                {name = 'blueprint_M4RIFLE',amount = 1},
                {name = 'blueprint_ISY',  amount = 1},
                {name = 'blueprint_AKPU',amount = 1},
                {name = 'blueprint_FOOL', amount = 1},
                {name = 'blueprint_AK4K', amount = 1},
                {name = 'blueprint_DRH', amount = 1},
                {name = 'blueprint_G36K_2', amount = 10},
                {name = 'bulletproof6',  amount =  30},
                {name = 'black_money',    amount = 200000},
                {name = 'money', amount = 200000},
            },

            police = {
                {name = 'magic_potion',  amount = 50},
		        {name = 'blueprint_ISY', amount = 50},
                {name = 'bulletproof6',  amount = 100},
		        {name = 'money',         amount = 620000},
                {name = 'painkiller3',   amount = 100},
            } 
        }
    }]]
}

Config.NotificationData = {
    name = 'boat-cargo',
	icon = '',
	text = 'EVENTS',
	title = 'BOAT CARGO',
	description = 'A criminal just started the transport of Weapons and Vests, attack the convoy, steal the boat and deliver.'
}