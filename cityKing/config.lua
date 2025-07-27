Config = {}

Config.DeclarePart = {
    city = {
        blip = {
            show = true,
            name = 'King of City',
            id = 439,
            color = 46,
            scale = 1.0
        },
        pos = vector3(-415.14, 1161.53, 325.86),
        heading = 346.73,
        model = GetHashKey('ig_josh')
    },

    sandy = {
        blip = {
            show = true,
            name = 'King of Sandy',
            id = 439,
            color = 46,
            scale = 1.0
        },
        pos = vector3(917.46, 3567.39, 33.77),
        heading = 275.76,
        model = GetHashKey('ig_josh')
    },

    paleto = {
        blip = {
            show = true,
            name = 'King of Paleto',
            id = 439,
            color = 46,
            scale = 1.0
        },
        pos = vector3(-700.83, 5436.10, 45.67),
        heading = 73.04,
        model = GetHashKey('ig_josh')
    },

    groove = {
        blip = {
            show = true,
            name = 'King of Groove',
            id = 439,
            color = 46,
            scale = 1.0
        },
        pos = vector3(-236.60, -1480.14, 31.40),
        heading = 18.97,
        model = GetHashKey('ig_josh')
    },
	
	perico = {
        blip = {
            show = true,
            name = 'King of Cayo Perico',
            id = 439,
            color = 46,
            scale = 1.0
        },
        pos = vector3(5330.28, -5270.48, 33.19),
        heading = 310.00,
        model = GetHashKey('ig_josh')
    },
	
	humane = {
        blip = {
            show = true,
            name = 'King Of Humane',
            id = 439,
            color = 46,
            scale = 1.0
        },
        pos = vector3(3576.59, 3717.86, 36.38),
        heading = 47.11,
        model = GetHashKey('ig_josh')
    },
	
	mc = {
        blip = {
            show = true,
            name = 'King Of MC',
            id = 439,
            color = 46,
            scale = 1.0
        },
        pos = vector3(73.24, 3644.60, 39.55),
        heading = 47.11,
        model = GetHashKey('ig_josh')
    },
}

Config.EventZone = {
    city = {
        label = 'City',
        pos = vector3(-415.14, 1161.53, 325.86),
        radius = 350.0
    },

    sandy = {
        label = 'Sandy',
        pos = vector3(917.46, 3567.39, 33.77),
        radius = 400.0
    },

    paleto = {
        label = 'Paleto',
        pos = vector3(-700.83, 5436.10, 45.67),
        radius = 400.0
    },

    groove = {
        label = 'Groove',
        pos = vector3(-236.60, -1480.14, 31.40),
        radius = 150.0
    },
	
	perico = {
        label = 'Perico',
        pos = vector3(5330.28, -5270.48, 33.19),
        radius = 150.0
    },
	
	humane = {
        label = 'Humane',
        pos = vector3(3576.59, 3717.86, 36.38),
        radius = 150.0
    },
	
	mc = {
        label = 'MC',
        pos = vector3(73.24, 3644.60, 39.55),
        radius = 150.0
    },
}

Config.NotificationData = {
    name = '',
	icon = '',
	text = 'EVENTS',
	title = '',
	description = ''
}

Config.PartCost = 5000

Config.MoneyReward = 2000000

Config.minRank = 0

Config.eventDuration = 60 --minutes

Config.MaxPropsPerPlayer = 5

Config.KingEmoji = "👑"

Config.AvailableProps = {
    [GetHashKey('prop_boxpile_07d')] = "Box",
}

Config.Hours = {
    city   = {day = 'Monday',       startHour = 20, startMinute = 00},
    sandy  = {day = 'Tuesday',      startHour = 20, startMinute = 00},
    paleto = {day = 'Wednesday',    startHour = 20, startMinute = 00},
    groove = {day = 'Thursday',     startHour = 20, startMinute = 00},
    perico = {day = 'Friday',       startHour = 20, startMinute = 00},
    humane = {day = 'Saturday',     startHour = 20, startMinute = 00},
    mc     = {day = 'Sunday',       startHour = 20, startMinute = 00},
}