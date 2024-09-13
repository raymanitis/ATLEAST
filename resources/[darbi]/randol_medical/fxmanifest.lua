fx_version 'cerulean'
game 'gta5'

author 'Randolio'
description 'Medical System'
version '2.0.0'

ox_lib 'locale'

ui_page 'web/index.html'

shared_scripts { '@ox_lib/init.lua', 'shared.lua', 'data/*.lua', }

client_scripts { 'bridge/client/**.lua', 'client/*.lua', }

server_scripts { '@oxmysql/lib/MySQL.lua', 'bridge/server/**.lua', 'server/*.lua', }

escrow_ignore {
    'locales/*.json',
    'shared.lua',
    'data/*.lua',
    'bridge/client/**.lua',
    'bridge/server/**.lua',
    'client/cl_open.lua',
    'server/sv_config.lua',
	'server/sv_open.lua',
}

files { 'locales/*.json', 'web/Akrobat.otf', 'web/index.html', 'web/style.css', 'web/script.js', }

dependencies { '/onesync', 'ox_lib', }

lua54 'yes'
dependency '/assetpacks'