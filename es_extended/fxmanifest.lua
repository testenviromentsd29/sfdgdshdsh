fx_version 'adamant'

game 'gta5'

description 'ES Extended'

version '1.2.0'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',

	'locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/fr.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'locales/cs.lua',
	'locales/sc.lua',
	'locales/tc.lua',

	'config.lua',
	'config.weapons.lua',

	'server/common.lua',
	'server/classes/player.lua',
	'server/functions.lua',
	'server/paycheck.lua',
	'server/main.lua',
	'server/commands.lua',
	'sConfig.lua',
	'common/modules/math.lua',
	'common/modules/table.lua',
	'common/functions.lua',
	'paycheckConfig.lua'
}

client_scripts {
	'locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/fr.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'locales/cs.lua',
	'locales/sc.lua',
	'locales/tc.lua',

	'config.lua',
	'config.weapons.lua',

	'client/common.lua',
	'client/entityiter.lua',
	'client/functions.lua',
	'client/wrapper.lua',
	'client/main.lua',
	'client/modules/death.lua',
	'client/modules/scaleform.lua',
	'client/modules/streaming.lua',

	'common/modules/math.lua',
	'common/modules/table.lua',
	'common/functions.lua',
	'paycheckConfig.lua'
}

ui_page {
	'html/ui.html'
}

files {
	'locale.js',
	'html/ui.html',

	'html/css/app.css',

	'html/js/mustache.min.js',
	'html/js/wrapper.js',
	'html/js/app.js',

	'html/fonts/pdown.ttf',
	'html/fonts/bankgothic.ttf',

	'html/img/accounts/bank.png',
	'html/img/accounts/black_money.png',
	'html/img/accounts/money.png'
}

exports {
	'getSharedObject'
}

server_exports {
	'getSharedObject',
	'getPlayedTimeBeetweenDates', --format: '2020-10-20 13:11:35'
	'getMinutesInLastDays',
	'canChangeDoubleJob',
	'SetJobOwner',
	'RemoveJobOwner',
	'SetJobViceboss',
	'RemoveJobViceboss',
}


dependencies {
	'mysql-async',
	'async'
}











server_script "@Protector/Server/injection.lua"


client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"