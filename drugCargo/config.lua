Config = {}

Config.Marker = {
    type = 1,
    size = {x = 5.0, y = 5.0, z = 1.0},
    color = {r = 200, g = 0, b = 0},
}

Config.StartCargo = {
    blip = {
        show = true,
        name = 'Drug Cargo',
        id = 499,
        color = 18,
        scale = 1.0
    },
    pos = vector3(1556.57, -2122.94, 77.31),
    heading = 90.00,
    model = GetHashKey('cs_floyd')
}

Config.EventBucket = 'drugcargo'

Config.RedzoneDuration = 2 * 60

Config.RedzoneRadius = 100.0

Config.CargoCooldown = 120 --minutes

Config.CargoSpawn = {
    model = 'journey',
    pos = vector3(1549.83, -2121.66, 77.20),
    heading = 200.00,
    plate = 'DRGCARGO'
}

Config.Cargos = {
    [1] = {
        Cost = 1000000,

        Locations = {
            vector3(1825.35, -1447.59, 122.24),
            vector3(1978.43, -922.24, 79.11),
            vector3(2491.84, -668.59, 61.77),
            vector3(2490.14, -92.22, 90.74),
            vector3(2622.65, 592.69, 95.19),
            vector3(2561.07, 1636.56, 29.10),
            vector3(2725.33, 1388.44, 24.50),
        },

        Rewards = {

			{name = 'mytia_cocainis',		amount = 100},
			{name = 'trifyllo_tsigaraki',	amount = 100},
			{name = 'magic_potion',			amount = 100},
			{name = 'painkiller4',			amount = 100},
        }
    },

    --[[[2] = {
        Cost = 500000,

        Locations = {
            vector3(-719.62, -1732.79, 28.78),
			vector3(-1464.39, -876.13, 10.05),
			vector3(-2233.06, 2304.93, 31.77),
			vector3(-1937.23, 1772.00, 173.50),
			vector3(-2146.20, 1025.56, 196.07),
        },

        Rewards = {                   
            {name = 'weed',                  amount = 5},
            {name = 'cocaine',               amount = 5},
            {name = 'crystalmeth',           amount = 5},
            {name = 'mytia_cocainis',        amount = 30},
			{name = 'adrenaline',            amount = 25},
			{name = 'AMMO_RIFLE',            amount = 25},
			{name = 'first_aid_kit',         amount = 25},
            {name = 'trifyllo_tsigaraki',    amount = 30},
            {name = 'weapon_powerup',        amount = 25},
			{name = 'super_potion',          amount = 50},
            {name = 'adrenaline',            amount = 50},
            {name = 'first_aid_kit',         amount = 50},
            {name = 'black_money',           amount = 700000},
        }
    },]]
}

Config.NotificationData = {
    name = 'drug-cargo',
	icon = '',
	text = 'EVENTS',
	title = 'DRUG CARGO',
	description = 'A criminal just started the transport of Weapons and Vests, attack the convoy, steal the cargo and deliver.'
}