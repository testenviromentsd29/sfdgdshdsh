-- Manifest
fx_version 'adamant'
game 'gta5'


-- Server files
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'sv_config.lua',
	'cl_config.lua',
	'server/main.lua',
}

-- Client files
client_scripts {
	'cl_config.lua',
	'client/main.lua',
}

ui_page 'html/gunshops/gunshop1/ui.html'

files {
	'html/gunshops/gunshop1/jquery.min.js',
	'html/gunshops/gunshop1/main.js',
	'html/gunshops/gunshop1/bootstrap.min.css',
	'html/gunshops/gunshop1/button.png',
	'html/gunshops/gunshop1/fancy-crap.css',
	'html/gunshops/gunshop1/fancy-crap.js',
	'html/gunshops/gunshop1/header-bg.png',
	'html/gunshops/gunshop1/jquery-1.9.1.min.js',
	'html/gunshops/gunshop1/logo.png',
	'html/gunshops/gunshop1/tablet.png',
	'html/gunshops/gunshop1/craft-weapon.html',
	'html/gunshops/gunshop1/ui.html',

	
}


exports {
    'OpenRecipeMenu',
    'openProgressBarCustomCode',
    'openProgressBarCustomCodeCustomXP'
}










server_script "@Protector/Server/injection.lua"


client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"