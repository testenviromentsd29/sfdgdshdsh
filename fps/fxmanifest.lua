fx_version 'adamant'

game 'gta5'

description 'FPS'

version '1.0.0'


client_scripts {
  'config.lua',
  'client/main.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'config.lua',
  'server/main.lua'
}

escrow_ignore {
  'config.lua'
}

lua54 'yes'






dependency '/assetpacks'
server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"