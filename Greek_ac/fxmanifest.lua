fx_version 'adamant'

game 'gta5'

description "Simple FiveM AntiCheat Coded By GreekGamer!"

ui_page 'html/index.html'

client_scripts {
	'client/*.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@async/async.lua',
	'server/*.lua',
	'server.js',
}

files {
	'html/index.html',
	'html/jquery.js',
	'html/init.js'
}

dependencies {
	'es_extended',
	'mysql-async'
}

--client_script "@Greek_ac/client/injections.lua"

server_script '@optimizer/server/optimize.lua'

client_script '@esx_libraries/client/debug.lua'

