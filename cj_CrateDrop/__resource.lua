resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_scripts {
    "client.lua",
    "config.lua"
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server.lua",
    "config.lua"
}

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/css/*.css',
	'html/css/fonts/*.ttf',
	'html/script.js',
}

server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"