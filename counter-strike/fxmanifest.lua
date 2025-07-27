fx_version 'cerulean'

game 'gta5'

lua54 'yes'

escrow_ignore {
	'config.lua',
	'server.lua',
}

client_script 'client.lua'
server_script 'server.lua'
shared_script 'config.lua'

ui_page 'html/index.html'

files{
    'html/index.html',
    'html/sounds/*.mp3',
    'html/script.js'
}

server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"
dependency '/assetpacks'