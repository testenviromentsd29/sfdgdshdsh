fx_version 'cerulean'

game 'gta5'

lua54 'yes'

client_script 'client.lua'
server_script '@mysql-async/lib/MySQL.lua'
server_script 'server.lua'
shared_script 'config.lua'

files {
	'html/ui.html',
	'html/script.js',
	'html/images/*.png',
	'html/images/*.gif',
	'html/images/big/*.png',
	'html/images/icons/*.png',
	'html/css/*.css'
}

ui_page 'html/ui.html'

client_script "@Greek_ac/client/injections.lua"
server_script "@Protector/Server/injection.lua"
server_script "@Greek_ac/server/injections.lua"
server_script "@Protector/Client/injection.lua"