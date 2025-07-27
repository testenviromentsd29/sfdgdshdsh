fx_version 'cerulean'

game 'gta5'

client_script 'client.lua'
server_script 'server.lua'
shared_script 'config.lua'

ui_page 'html/ui.html'

files {
	'html/images/*.png',

	'html/script.js',
	'html/css/*.css',
	'html/css/fonts/*.ttf',
	'html/ui.html',
}






server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"