fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'DMV Test Script for Qbox using ox_target and ox_lib'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

dependencies {
    'ox_target',
    'ox_lib',
    'qbx_core'
}
