fx_version 'cerulean'

game 'gta5'
ui_page 'html/index.html'

files {
    'html/css/*',
    'html/css/fonts/*',
    'html/images/*',
    'html/*',
}


client_script 'client.lua'
server_script 	'@mysql-async/lib/MySQL.lua'

server_script 'server.lua'
shared_script 'config.lua'

server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"