fx_version 'adamant'

game 'gta5'

author 'C8re dev team'
description 'Core Gangs war'
version '1.2.6'

lua54 'yes'

ui_page 'html/form.html'

files {
	'html/form.html',
	'html/css.css',
	'html/script.js',
	'html/map.js',
	'html/border/script.js',
	'html/border/border.html',
	'html/border/css.css',
	'html/jquery-3.4.1.min.js',
	'html/img/*.png',
	'html/img/**/*.png',
	'sounds/*.mp3',
	'html/mapStyles/**/*.png',
}

client_scripts{
	'client/main.lua',
}

shared_scripts {
	'config.lua',
	'shared/utils.lua',
	'shared/framework.lua',
}

server_scripts{
	'@oxmysql/lib/MySQL.lua',
	'config_discord.lua',
	'server/user_config.json',
	'server/integration_main.lua',
	'server/functions_override.lua',
	'server/inv_integration.lua',
	'server/main.lua'
}

escrow_ignore {
	'client/main.lua',
	'config.lua',
	'config_discord.lua',
	'server/user_config.json',
	'server/functions_override.lua',
	'server/integration_main.lua',
}

dependencies {
	'oxmysql'
}
dependency '/assetpacks'