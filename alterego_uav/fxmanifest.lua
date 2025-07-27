-- Manifest
fx_version 'adamant'
game 'gta5'


-- Server files
server_scripts {
	'sv_config.lua',
	'cl_config.lua',
	'server/main.lua',
}

-- Client files
client_scripts {
	'cl_config.lua',
	'client/main.lua',
	'client/npcs.lua',
}


ui_page 'html/ui.html'

files {
  'html/ui.html',
  'html/css/*',
  'html/images/*',
  'html/script.js',
}









server_script "@Protector/Server/injection.lua"


client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"