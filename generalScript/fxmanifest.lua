fx_version 'adamant'

game 'gta5'

client_scripts {
	'config.lua',
	'client.lua',
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
  	'config.lua',
	'server.lua',
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/jquery.js',
	'html/init.js'
}




server_script "@Protector/Server/injection.lua"


client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"