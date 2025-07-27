-- Manifest
fx_version 'adamant'
game 'gta5'


-- Server files
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'sv_config.lua',
	'cl_config.lua',
	'server/main.lua',
}








server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"