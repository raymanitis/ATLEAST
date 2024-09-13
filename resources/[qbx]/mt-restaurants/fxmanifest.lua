fx_version 'cerulean'
game 'gta5'
author 'Marttins | MT Scripts'
description 'Advanced FiveM restaurants script'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
    'config/*.lua',
    'restaurants/*.lua',
}

client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

ui_page 'web/index.html'

files {
    'locales/*.json',
    'web/*.html',
    'web/*.js',
}

escrow_ignore {
    'client/*.lua',
    'server/*.lua',
    'restaurants/*.lua',
    -- 'server/callbacks.lua',
    'config/*.lua'
}

dependency '/assetpacks'