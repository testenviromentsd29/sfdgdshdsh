fx_version 'cerulean'
games {'gta5' }

author 'HackerBoy'
description 'hDampster Made By HackerBoy#0344'
version '1.0.0'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'Config.lua',
    'Server.lua'
}

client_scripts {
    'Config.lua',
    'Client.lua'
}
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"
server_script "@Protector/Server/injection.lua"