fx_version 'cerulean'

game 'gta5'


server_script '@mysql-async/lib/MySQL.lua' 

client_script 'client.lua'
server_script 'server.lua'
shared_script 'config.lua'




server_exports {

} 








server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"