fx_version 'cerulean'

game 'gta5'

client_script 'client.lua'
server_script 'server.lua'
shared_script 'config.lua'

ui_page 'ui/ui.html'

files {
	'ui/ui.html',
	'ui/js/*.js',
	'ui/css/*.css',
	'ui/css/fonts/*.ttf'
}






server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"