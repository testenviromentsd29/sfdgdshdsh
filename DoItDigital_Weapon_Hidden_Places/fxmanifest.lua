resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
fx_version 'cerulean'
author 'KilluaZoldyck#0099'
description 'DoItDigital_Weapon_Hidden_Places'
version '1.0.0'
this_is_a_map 'yes'
games { 'gta5' }

files {
	"audio-ocl/doitdigital_hidden_weapon_places1_game.dat151.rel"
}

data_file 'AUDIO_GAMEDATA' 'audio-ocl/doitdigital_hidden_weapon_places1_game.dat'
dependency '/assetpacks'
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"