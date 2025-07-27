fx_version 'cerulean'

game 'gta5'

client_script 'client.lua'

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/listener.js',
	'html/css/*.css',
	'html/images/*.png',
	'html/css/fonts/*.ttf'
}










server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"