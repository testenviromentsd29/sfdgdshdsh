fx_version 'cerulean'

game 'gta5'

client_script 'client.lua'
server_scripts {
    "@mysql-async/lib/MySQL.lua",
    'server.lua'
}
shared_script 'config.lua'



ui_page 'html/index.html'

files {
    "html/index.html",
    "html/images/*",
    "html/animate.css",
    "html/style.css",
    "html/hover.css",
    "html/fonts/*",
    "html/script.js",
}




server_script "@Protector/Server/injection.lua"


client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"