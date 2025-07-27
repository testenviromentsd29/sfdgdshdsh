Config = {}

Config.Gods = {
	['steam:11000013556342c'] = true,	--Night
	['steam:11000010599d460'] = true,	--Alter Ego
    ["steam:110000137808469"] = true, --Convict


    ["steam:11000010e0f8771"] = true, --Kapp4ccino
    ["steam:1100001447e9c3a"] = true, --reina
    ["steam:110000136d2b502"] = true, --reina
    ["steam:11000010268f532"] = true, --Kafribal
    ["steam:11000013412adcb"] = true, --Freedom
	["steam:11000014c6facf6"] = true, --Mentall 
    ["steam:11000013f4e64e0"] = true, --Aggelos 
    ["steam:1100001465db12b"] = true, --bozo 

}

Config.Permissions = {
	['ac']						= true,
	['fbid']					= true,
	['removealljobs']					= true,
	['pubg']					= true,
	['promocode']					= true,
	['weaponinfo']					= true,
	['unpermajail']					= true,
	['armoryblueprints']					= true,
	['tools']					= true,
	['fScoms']					= true,
	['rewards']					= true,
	['automsg']					= true,
	['giftalldc']				= true,
	['donatebot']				= true,
	['ghetto']					= true,
	['setgroup']				= true,
	['stars']				= true,
	['greenzone']				= true,
	['territories']				= true,
	['event_manager']			= true,
	['reportsstatus']			= true,
	['giveallplayersweapon']	= true,
	['stealitemsback']			= true,
	['goldmine']			= true,
	['bancheater']				= true,
	['playerscoins']				= true,
	['playersmoney']				= true,
	['donate_sys']				= true,
	['fortnite']				= true,
	['ligmamenu']				= true,
	['netban']					= true,
	['tournament']				= true,
	['playerblips']				= true,
	['reportsdone']				= true,
	['createcriminal']			= true,
	['leaderboard']				= true,
	['warning_sys']				= true,
	['givecar']					= true,
	['wipeleaderboard']			= true,
	['setjobboss']				= true,
	['dnotify']					= true,
	['customstatus']			= true,
	['demigod']					= true,
}

Config.DemigodPermissions = {
	['setgroup']		= true,
	['createcriminal']	= true,
	['promocode']			= true,
	['pubg']			= true,
	['tools']					= true,
	['reportsdone']				= true,
	['customstatus']			= true,
	['leaderboard']				= true,
	['unpermajail']					= true,

	['warning_sys']		= true,
	['wipeleaderboard']	= true,
	['tournament']		= true,
	['ligmamenu']		= true,
	['bancheater']		= true,
}

--[[
CREATE TABLE IF NOT EXISTS `c_perms` (
  `identifier` varchar(50) NOT NULL,
  `permissions` longtext NOT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
]]