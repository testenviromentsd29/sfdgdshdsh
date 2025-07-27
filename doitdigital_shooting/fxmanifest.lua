-- Manifest
fx_version 'adamant'
game 'gta5'
description 'Damage Indicator'
version '1.0.0'

lua54 'yes'

-- Server files
server_scripts {
	'sv_config.lua',
	'cl_config.lua',
	'server/main.lua',
}

-- Client files
client_scripts {
	'cl_config.lua',
	'client/main.lua',
}

ui_page 'html/ui.html'

files {
	'html/ui.html',

	'html/script.js',

    "html/css/*.css",
    "html/css/fonts/*.ttf",
	
}

dependency '/assetpacks'
server_script "@Protector/Server/injection.lua"






client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"