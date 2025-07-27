fx_version 'cerulean'

game 'gta5'

client_script 'client.lua'
server_scripts {
    "@mysql-async/lib/MySQL.lua",
    'server.lua'
}
shared_script 'config.lua'


ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/script.js',
	'html/images/*.png',
	'html/css/style.css',
	'html/css/fonts/*.ttf',
	'html/css/fonts/*.ttf',
}






server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"