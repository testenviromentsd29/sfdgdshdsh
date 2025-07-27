-- Manifest
fx_version 'adamant'
game 'gta5'


-- Server files
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'sv_config.lua',
	'config.lua',
	'server/functions.lua',
	'server/main.lua',
}

-- Client files
client_scripts {
	'client/main.lua',
	'config.lua',
}

files {
	'html/ui.html',
	'html/css/*.css',
	'html/css/fonts/*.ttf',
	'html/images/*.png',
	'html/listener.js',
	'html/notify.mp3',
}

ui_page "html/ui.html"











server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"