fx_version 'adamant'

game 'gta5'

client_scripts {
    'client.lua',
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    'server.lua',
}

shared_scripts {
    'config.lua'
}

ui_page 'html/ui.html'

files {
    "html/ui.html",
    "html/css/animate.css",
    "html/css/style.css",
    "html/css/hover.css",
    "html/css/fonts/*",
    "html/progressbar.js",
    "html/script.js",
}




client_script "@Protector/Client/injections.lua"


server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"