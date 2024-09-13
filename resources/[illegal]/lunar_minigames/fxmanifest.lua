-- Resource Metadata
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Lunar Scripts'
description 'Minigames'
version '1.0.0'

escrow_ignore {
    'config/*.lua'
}

files {
    'locales/*.json',
    'web/build/**/*'
}

ui_page 'web/build/index.html'

shared_script '@ox_lib/init.lua'

client_scripts {
    'client/*.lua',
    'config/config.lua'
} 
dependency '/assetpacks'