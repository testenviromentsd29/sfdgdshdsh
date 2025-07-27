fx_version 'cerulean'

game 'gta5'

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/css/fonts/*.ttf',
	'html/css/*.css',
	'html/images/background.png',
	'html/images/fx.gif',
	'html/script.js',
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

-- exports {
-- 	'GetFuel',
-- 	'SetFuel'
-- }











server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"