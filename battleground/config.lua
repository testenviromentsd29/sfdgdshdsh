Config = {}

Config.areaColour = 38
Config.RewardPoints = 1500
Config.RewardsInterval = 10		--Minutes
Config.MaxTotalWeapons = 2

Config.TimeToResetNpcWeapons = 60 * 60

Config.Battlegrounds = {
    {
        pos = vector3(3578.24, 3718.86, 36.38),
        radius = 400.0,
        heading = 90.62,
        model = GetHashKey('a_m_m_soucent_04'),
        crates = {
            vector3(3605.39, 3771.58, 29.92),
            vector3(3448.85, 3797.96, 35.74),
            vector3(3484.25, 3682.83, 33.89),
            vector3(3603.35, 3660.87, 42.61),
            vector3(3642.62, 3684.77, 34.24),
            vector3(3609.15, 3720.00, 35.16),
            vector3(3482.12, 3808.18, 30.42),
            vector3(3391.18, 3647.23, 50.05),
            vector3(3570.73, 3661.23, 33.90),
            vector3(3585.17, 3885.57, 50.88),
        }
    },
}

Config.CrateRewards = {
    {name = 'magic_potion',             amount = 5},
    {name = 'cbd_water',                amount = 5},
    {name = 'painkiller3',              amount = 5},
    {name = 'bulletproof6',             amount = 5},
    {name = 'weaponkit',                amount = 5},
    
    --{name = 'black_money', amount = 500000},
}

Config.EventBucket = 'battleground'

Config.KillsToDropCrate = 50

Config.CrateCollectTimer = 30

Config.CaptureTime = 3 * 60 --seconds

Config.NotificationHours = {
    {hour = 10, minute = 00},
}

Config.NotificationData = {
    name = 'battlegrounds',
	icon = '',
	text = 'EVENTS',
	title = 'BATTLEGROUND',
	description = 'Battleground is open, capture the zone, loot your opponents weapons, and climb the leaderboard.'
}

Config.Weapons = {
	{name = 'blueprint_DRH',		label = 'DRH'},
	{name = 'blueprint_ANR15',		label = 'ANR15'},
	{name = 'blueprint_GRSR',		label = 'GRSR'},
	{name = 'blueprint_DKS501',		label = 'DKS501'},
}