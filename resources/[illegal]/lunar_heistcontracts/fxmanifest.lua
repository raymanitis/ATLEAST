-- Resource Metadata
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Lunar Scripts'
description 'Heist Contracts'
version '1.0.6'

-- What to run
escrow_ignore {
    'config/**/*.lua'
}

dependency {
    'lunar_bridge',
    'lunar_minigames'
}

files {
    'locales/*.json',
    'web/build/**/*'
}

ui_page 'web/build/index.html'

shared_scripts {
    '@ox_lib/init.lua',
    'init.lua',
    'config/config.lua',
    'config/contracts/*.lua'
}

client_scripts {
    '@lunar_bridge/framework/esx/client.lua',
    '@lunar_bridge/framework/qb/client.lua',
    '@mka-lasers/client/client.lua',
    'config/cl_edit.lua',
    'client/*.lua',
    'client/contracts/*.lua'
} 

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@lunar_bridge/framework/esx/server.lua',
    '@lunar_bridge/framework/qb/server.lua',
    'config/sv_config.lua',
    'config/sv_edit.lua',
    'server/*.lua',
    'server/contracts/*.lua'
}
dependency '/assetpacks'