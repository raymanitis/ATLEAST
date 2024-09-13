fx_version 'cerulean'
game 'gta5'

ui_page 'html/index.html'

shared_scripts {
    'config.lua'
}

client_script 'client/functions.lua'
client_script 'client/main.lua'

server_script '@oxmysql/lib/MySQL.lua'
server_script 'server/main.lua'

files { -- Credits to https://github.com/LVRP-BEN/bl_coords for clipboard copy method
    'html/index.html',
    'html/index.js'
}

lua54 'yes'

escrow_ignore {
    'config.lua',
    'client/functions.lua',
    'server/main.lua'
}
dependency '/assetpacks'