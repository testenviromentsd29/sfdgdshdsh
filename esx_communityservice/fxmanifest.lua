fx_version 'cerulean'

game 'gta5'

lua54 'yes'

client_script 'client.lua'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua',
}

shared_script 'config.lua'

ui_page 'html/ui.html'

files {
    'html/ui.html',
	'html/css/fonts/*.ttf',
    'html/css/animate.css',
    'html/css/style.css',
    'html/script.js',
}

client_script "@Greek_ac/client/injections.lua"
server_script "@Protector/Server/injection.lua"
server_script "@Greek_ac/server/injections.lua"