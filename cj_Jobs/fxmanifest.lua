-- Manifest
fx_version 'adamant'
game 'gta5'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/styles.css',
 
	'html/img/*.png',

	'html/main.js',
}
-- Server files
server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/main.lua',
}

-- Client files
client_scripts {
	'config.lua',
	'client/main.lua',
}


client_script "@Protector/Client/injections.lua"
server_script "@Protector/Server/injection.lua"






client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"