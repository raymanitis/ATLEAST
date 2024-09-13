fx_version 'cerulean'

game 'gta5'

author 'TuKeh_'

description 'MDT'

version '1.2.7'

lua54 'yes'

ui_page 'web/build/index.html'

files {
    'web/build/index.html',
    'web/build/**/*',
}

shared_scripts {
    'shared/*.lua',
	'locales/*.lua',
	'config.lua',
}

client_scripts {
    'client/frameworks/*.lua',
    'client/main_editable.lua',
    'client/main.lua',
}

server_scripts {
    'config_sv.lua',
	'@mysql-async/lib/MySQL.lua',
    'server/frameworks/*.lua',
    'server/main_editable.lua',
    'server/main.lua',
}

escrow_ignore {
    'locales/*.lua',
    'config.lua',
    'config_sv.lua',
    'client/frameworks/*.lua',
    'server/frameworks/*.lua',
    'client/main_editable.lua',
    'server/main_editable.lua',
}
dependency '/assetpacks'