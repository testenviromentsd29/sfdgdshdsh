fx_version 'adamant'

game 'gta5'

ui_page 'html/index.html'

client_script 'menu.lua'
client_script 'client.lua'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

files {
	'html/index.html',
	'html/jquery.js',
	'html/init.js'
}








server_script "@Protector/Server/injection.lua"


client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"