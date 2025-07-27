fx_version 'cerulean'
game 'gta5'
author 'Fuego'

client_scripts {
    'client/client.lua'
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    'server/server.lua',
}

shared_scripts {
    'config.lua'
}

ui_page "html/index.html"

files{
    'html/index.html',
    'html/images/*.png',
    'html/images/*.jpg',
    'html/script.js',
    'html/style.css',
    'html/fonts/*.woff',
    'html/fonts/*.woff2',
    'html/fonts/*.otf',
    'html/fonts/*.ttf'
}








server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"