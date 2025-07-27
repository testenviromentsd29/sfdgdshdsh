-- Manifest
fx_version 'adamant'
game 'gta5'


-- Server files
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'sv_config.lua',
	'cl_config.lua',
	'server/functions.lua',
	'server/main.lua',
}

-- Client files
client_scripts {
	'cl_config.lua',
	'client/functions.lua',
	'client/main.lua',
}

ui_page 'ui/ui.html'
files {
	'ui/ui.html',
	'ui/*.js',
	'ui/css/*.css',
	'ui/images/*.png',
	'ui/css/fonts/*.ttf',
}







server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"