fx_version 'adamant'
game 'gta5'


server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"config.lua",
	"server/server.lua"
}

client_scripts {
	"config.lua",
	"client/utils.lua",
	"client/client.lua"
}

ui_page 'ui/ui.html'
files {
	'ui/ui.html',
	'ui/*.js',
	'ui/css/*.css',
	'ui/css/fonts/*.ttf',
	'ui/images/*.png',

}


server_exports {
	'isJailed'	
}






server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"