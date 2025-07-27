fx_version 'cerulean'

game 'gta5'

lua54 'yes'

client_script 'client.lua'
client_script 'client_functions.lua'
server_script 'server.lua'
shared_script 'config.lua'

ui_page 'html/index.html'

files{
    'html/index.html',
    'html/images/*.png',
    'html/sounds/*.mp3',
    'html/script.js',
    'html/*.css',
    'html/fonts/*.otf',
    'html/fonts/*.ttf',
}

server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"