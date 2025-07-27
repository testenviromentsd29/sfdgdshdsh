fx_version 'cerulean'

game 'gta5'

client_script 'client.lua'
shared_script 'config.lua'
server_script 'server.lua'

files {
	'html/index.html',
	'html/script.js',
	'html/images/*.png',
	'html/css/*.css',
	'html/css/fonts/*.ttf',
}

ui_page 'html/index.html'






shared_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"