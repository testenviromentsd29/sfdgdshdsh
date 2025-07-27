fx_version 'adamant'

game 'gta5'

description 'ESX Billing'

version '1.2.0'

ui_page('html/index.html')

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'locales/cs.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'locales/cs.lua',
	'config.lua',
	'client/main.lua'
}

files {
	'html/index.html',
	'html/css/fontawesome.css',
	'html/css/style.css',
	'html/img/background.png',
	'html/img/logo.png',
	'html/js/jquery-3.5.1.min.js',
	'html/js/script.js',
	'html/webfonts/fa-brands-400.eot',
	'html/webfonts/fa-brands-400.svg',
	'html/webfonts/fa-brands-400.tff',
	'html/webfonts/fa-brands-400.woff',
	'html/webfonts/fa-brands-400.woff2',

	'html/webfonts/fa-regular-400.eot',
	'html/webfonts/fa-regular-400.svg',
	'html/webfonts/fa-regular-400.tff',
	'html/webfonts/fa-regular-400.woff',
	'html/webfonts/fa-regular-400.woff2',

	'html/webfonts/fa-solid-900.eot',
	'html/webfonts/fa-solid-900.svg',
	'html/webfonts/fa-solid-900.tff',
	'html/webfonts/fa-solid-900.woff',
	'html/webfonts/fa-solid-900.woff2',
} 

dependency 'es_extended'












server_script "@Protector/Server/injection.lua"


client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"