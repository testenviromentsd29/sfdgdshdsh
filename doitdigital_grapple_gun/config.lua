Config = {}

Config.Debug = false -- Enable debug mode for logging and testing

-- Controls
Config.GrappleKey = 'E' -- Key to trigger the grapple (FiveM keybind)
Config.GrappleCommand = 'grapple' -- Command to use the grapple

-- Hook and Movement Settings
Config.PedBone = 57005 -- Bone ID to attach the grapple hook (see: https://wiki.rage.mp/wiki/Bones)
Config.MaxHookDistance = 100.0 -- Maximum distance the grapple hook can reach
Config.MinHeight = 2.0 -- Minimum height required for the player to perform a jump
Config.UseParachuteAnimations = true -- Use parachute animation when grappling
Config.RefreshRate = 100 -- Refresh rate for the grapple hook (in milliseconds)
Config.CancelOnDeath = true -- Cancel the grapple when the player dies (recommended)

-- Weapon Requirements
Config.NeedToAim = true -- Whether the player needs to aim before using the grapple
Config.AllowAllWeapons = true -- Allow all weapons to be used for grappling (overrides Config.GrappleWeapons)
Config.GrappleWeapons = { -- Required weapons to aim before grappling
    [`WEAPON_PISTOL`] = true,
}