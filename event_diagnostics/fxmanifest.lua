fx_version 'cerulean'

game 'gta5'

client_scripts {
	'client.lua',
}

server_scripts {
	'server.lua',
}

shared_script 'config.lua'

server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"