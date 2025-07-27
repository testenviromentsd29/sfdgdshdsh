fx_version 'cerulean'

game 'gta5'

lua54 'yes'

client_scripts {
	'config.lua',
	'client.lua'
}

server_scripts {
	'config.lua',
	'server.lua'
}

server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"