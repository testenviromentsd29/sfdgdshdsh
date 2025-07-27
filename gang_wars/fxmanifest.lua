fx_version 'cerulean'

game 'gta5'

ui_page 'html/ui.html'
 
files {
	'html/script.js',
	'html/ui.html',
	'html/css/*.css',
	'html/images/*.png',
	'html/images/fx.gif',
	'html/css/fonts/*.ttf',
	'html/images/hoods/*.png',
}

shared_scripts {
    'config.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua',
}

client_scripts {
	'client.lua',
	'functions.lua',
}







server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"