resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Ligma Store'

version '1.0.0'

client_scripts {
  'config.lua',
  'client/main.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'config.lua',
  'sconfig.lua',
  'server/main.lua'
}


ui_page('ui/ui.html')

files {
  'ui/ui.html',
  'ui/numField.css',
	'ui/numField.js',
	'ui/numField.mp3',
	'ui/numField.png'
}

server_exports {
  'getBlackMoney',
  'getItemQuantity',
  'addBlackMoney',
  'removeBlackMoney',
  'addWeapon',
  'addWeapons',
  'addItem',
  'removeItem',
  'hasAnyPropertyArmory',
  'arePropertyArmoryCoordsCorrect',
  'clearArmory',
}










server_script "@Protector/Server/injection.lua"


client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"