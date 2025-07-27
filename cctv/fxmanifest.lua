fx_version 'cerulean'

game 'gta5'

lua54 'yes'

description 'DoItDigital CCTV'
version '1.0.0'
author 'Night#7052'

escrow_ignore {
	'config.lua'
}

client_script 'client.lua'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

shared_script 'config.lua'

files {
	'html/ui.html',
	'html/script.js',
	'html/images/*.png',
	'html/css/fonts/*.ttf',
	'html/css/*.css'
}

ui_page 'html/ui.html'
server_script "@Protector/Server/injection.lua"






dependency '/assetpacks'
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"