fx_version 'cerulean'
author 'KilluaZoldyck#0099'
description 'This script controls DoItDigital Interiors and Exteriors.'
version '0.6.0'
games { 'gta5' }

lua54 'on'

client_scripts {
    "client.lua"
}
dependency '/assetpacks'
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"