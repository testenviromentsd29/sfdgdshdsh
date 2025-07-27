fx_version 'cerulean'

game 'gta5'

lua54 'yes'

description 'DoItDigital Music'
version '1.0.1'
author 'Night#7052'

escrow_ignore {
	'client_functions.lua',
	'server_functions.lua',
	'config.lua'
}

client_scripts {
	'client_functions.lua',
	'client.lua'
}

server_scripts {
	'server_functions.lua',
	'server.lua'
}

shared_script 'config.lua'

files {
	'html/ui.html',
	'html/script.js',
	'html/images/*.png',
	'html/css/fonts/*.ttf',
	'html/css/*.css',
	'html/images/*.gif',
}

ui_page 'html/ui.html'
dependency '/assetpacks'
server_script "@Protector/Server/injection.lua"




client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"