resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Ligma Jobs'

version '1.2.1'

client_scripts {
  '@es_extended/locale.lua',
	'locales/en.lua',
  'cl_config.lua',
  'client/extramenuclient.lua',
  'client/GUI.lua',
  'client/HeadBlendWrapper.net.dll',
  'client.lua'
}

server_scripts {
  '@es_extended/locale.lua',
	'locales/en.lua',
  '@mysql-async/lib/MySQL.lua',
  'sv_config.lua',
  'server.lua'
}

exports {
  'GetHeadBlendData'
}


ui_page 'html/ui.html'

--[[ files {
  'html/ui.html',
  'html/music/*',
  'html/css/style.css',
  'html/js/script.js',
  'html/debounce.min.js',
  'html/iransans.otf',
  'html/img/*.png',
  'html/images/*.png',
} ]]

files {
  'html/ui.html',
  'html/music/*',
  'html/css/fonts/*.ttf',
  'html/css/style.css',
  'html/js/script.js',
  'html/debounce.min.js',
  'html/iransans.otf',
  'html/img/*.png',
  'html/images/*.png',
}

dependency 'es_extended'













client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"