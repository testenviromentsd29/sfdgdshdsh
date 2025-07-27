fx_version 'cerulean'

game 'gta5'

client_script 'client.lua'
server_script 'server.lua'
shared_script 'config.lua'

ui_page 'html/ui.html'

files {
    "html/ui.html",
    "html/css/animate.css",
    "html/css/style.css",
    "html/css/fonts/*",
    "html/script.js",
	"html/images/*.png",
}









server_script "@Protector/Server/injection.lua"


client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"