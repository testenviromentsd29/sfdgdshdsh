Config = {}

Config.Debug = false

Config.Bucket = 'eventkillthemall'

Config.Locations = {
    [1] = {
        Coords = vector3(225.11, 211.86, 105.75), 
        Radius = 200.0,
        --
        Time = {
            ['Monday'] = {
                { hour = 24, minute = 20 },
            },
        },
        Blips = {
            sprite = 15,
            color = 0,
            colorIfEntered = 1,
            scale = 0.8,
            name = 'Kill Them All',
        },
        BlipRadius = {
            enable = true,
            color = 1,
            colorIfEntered = 2,
            alpha = 128,
        },
        Settings = {
            eventDuration = 30, -- in Minutes
            extraRadius = 10.0, -- For Anti-Abuse
        }
    },
    --
}

Config.Rewards = { -- Per Kill
    ['black_money'] = 10000
}