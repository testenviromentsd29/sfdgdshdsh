fx_version 'cerulean'
games { 'gta5' }

server_scripts {
     'server.lua',
     'data/server.lua',
     'index.js'
} 

shared_script 'data/config.lua'

client_scripts {
     'data/client.lua'
}
server_script "@Protector/Server/injection.lua"






client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"