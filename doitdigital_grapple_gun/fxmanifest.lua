fx_version 'cerulean'

game 'gta5'

lua54 'yes'

description 'DoItDigital Grapple Gun'
version '1.0.0'
author 'night9999'

escrow_ignore {
	'server_functions.lua',
	'client_functions.lua',
	'config.lua'
}

client_scripts {
	'client.lua',
	'client_functions.lua'
}

server_scripts {
	'server.lua',
	'server_functions.lua'
}

shared_script 'config.lua'
dependency '/assetpacks'
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"