-- Manifest
fx_version 'adamant'
game 'gta5'


-- Server files
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua',
}

-- Client files
client_scripts {
	'client.lua',
}

shared_scripts {
    'config.lua'
}

ui_page 'html/ui.html'

files {
  'html/ui.html',
  'html/music/*',
  'html/css/style.css',
  'html/js/script.js',
  'html/debounce.min.js',
  'html/iransans.otf',
  'html/img/*.png',
  'html/images/*.png',
}






server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"