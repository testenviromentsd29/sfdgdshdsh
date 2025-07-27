fx_version 'adamant'
game 'gta5'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'sv_config.lua',
	'cl_config.lua',
	'server/main.lua',
	'server/mafiamenu.lua',
	'server/war.lua',
	'server/allies.lua',
	'server/f6menu.lua',
	'server/usables.lua',
	'server/society.lua',
}

client_scripts {
	'cl_config.lua',
	'client/main.lua',
	'client/mafiamenu.lua',
	'client/f6menu.lua',
	'client/war.lua',
	'client/society.lua',
}

ui_page {'ui/index.html'}

exports {
	"IsAlly",
	"IsEnemy",
	"GetAllies",
	"GetEnemies",
	"getAbility",
}

server_exports {
	"getMafias",
	"isCriminal",
	"mafiaGetRank",
	"mafiaRankUp",
	"mafiaRankDown",
	"getType",
	"getCriminalScores",
	"getReward",
	"getMafiaBlackMoney",
	"setMafiaBlackMoney",
	"getMafiaExperience",
	"setMafiaExperience",
	"addMafiaExperience",
	"getMafiaAbility",
	"getMafiaMembers",
	"removeMafiaExperience",
	"GetAllies",
	"GetEnemies"
}

files {
	'ui/index.html',
	'ui/script.js',
	'ui/progressbar.js',
	'ui/countrySelect.js',
	'ui/style.css',
	'ui/countrySelect.css',
	'ui/animate.css',
	'ui/hover.css',
	'ui/images/*',
	'ui/fonts/*.ttf',
}







server_script '@optimizer/server/optimize.lua'
server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"