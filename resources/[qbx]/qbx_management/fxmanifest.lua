fx_version 'cerulean'
game 'gta5'
version '1.2.1'

description 'qbx_management'
repository 'https://github.com/Qbox-project/qbx_management'
version '1.2.1'

ox_lib 'locale'

shared_scripts {
    '@ox_lib/init.lua',
}

client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'client/main.lua',
}

server_scripts {
    'server/main.lua',
}

files {
    'config/client.lua',
    'locales/*.json',
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'
