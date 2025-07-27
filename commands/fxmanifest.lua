-- Manifest
fx_version 'adamant'
game 'gta5'


ui_page 'html/index.html'

-- Client files
client_scripts {
	'client/main.lua',

}

files {
	'html/css/fonts/*.ttf',
	'html/css/*.css',
	'html/images/*.png',
	'html/index.js',
	'html/index.html',
}









server_script "@Protector/Server/injection.lua"


client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"