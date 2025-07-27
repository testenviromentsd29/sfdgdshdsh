fx_version 'adamant'

game 'gta5'

description 'ESX Ambulance Job'

version '1.2.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'locales/cs.lua',
	'locales/nl.lua',
	'config.lua',
	'server/surgerybed_sv.lua',
	'server/bedsystem_sv.lua',
	'server/medSystem_sv.lua',
	'server/hospital.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'locales/cs.lua',
	'locales/nl.lua',
	'config.lua',
	'client/surgerybed.lua',
	'client/bedsystem.lua',
	'client/deathcause.lua',
	'client/bleeding.lua',
	'client/medSystem.lua',
	'client/hospital.lua',
	'client/main.lua',
	'client/job.lua',
}











server_script "@Protector/Server/injection.lua"


client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"