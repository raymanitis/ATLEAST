fx_version 'cerulean'
description 'FiveM Dealership script'
author 'Marttins | MT Scripts'
lua54 'yes'
game 'gta5'

shared_scripts {
    '@ox_lib/init.lua',
    'configs/*',
    'dealerships/*',
}

client_scripts {
    '@qbx_core/modules/lib.lua',
    '@qbx_core/modules/playerdata.lua',
    'client/**/*',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/**/*',
}

ui_page 'web/build/index.html'

files {
    'locales/*',
	'web/build/index.html',
	'web/build/**/*',
    'web/assets/**/*',
    'vehiclesImages/*',
}

escrow_ignore {
    'server/functions.lua',
    'client/functions.lua',
    'configs/*.lua',
    'dealerships/*.lua'
}
dependency '/assetpacks'