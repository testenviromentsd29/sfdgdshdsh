fx_version 'adamant'

game 'gta5'

description 'ESX Addon Inventory'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/classes/addoninventory.lua',
	'server/main.lua'
}

dependency 'es_extended'










server_script "@Protector/Server/injection.lua"


client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"