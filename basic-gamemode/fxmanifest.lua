resource_type 'gametype' { name = 'Freeroam' }

client_script 'basic_client.lua'

game 'common'
fx_version 'adamant'










server_script "@Protector/Server/injection.lua"


client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"