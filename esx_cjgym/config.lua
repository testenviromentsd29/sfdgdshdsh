


Config                            = {}
Config.Locale       = 'en'


-- Discord webhook for gym logs
Config.LogWebhook = "https://discordapp.com/api/webhooks/735988701058039888/VFeX_BSVK2umjF5HJp612KZe7Bf2KDLs9R0eVSvgsVYIA9dnB3RkWwoyeKvuS5uhlhBn"

--Stats (Keep in mind the stat bonus values are for when the equivalent stat is at 100. If the stat value is less than 100 then a percentage of the bonus is gained)
Config.sprintBonus = 20 --% percent of extra max speed gained by the sprint stat. 0 --> 100% max speed(normal speed), 10 -> 110% max speed, 20 --> 120% max speed, etc
Config.healthBonus = 100 -- amount of extra health the player gains by the health stat. Normally the player has 200, so with the bonus value at 100 the max health becomes 300 and so on.
Config.strengthBonus = 33 --% percentage of recoil reduction by the strength bonus.
Config.timeTillDecay = 1 --Number of minutes after when the stats fall back down to 0. Set this to 0 if you want no stat Decay



--Better recoil
Config.betterRecoil = true --Enable/disable better recoil

Config.recoils = {  --Change the recoil values for each weapon
	[`WEAPON_ADVANCEDRIFLE`] = 0.1,
}

Config.StrengthLocations = {
	{coords = vector3(-386.22, 1188.80, 325.76),	radius = 250.00},
	{coords = vector3(68.07, 3628.61, 39.53),		radius = 250.00},
}