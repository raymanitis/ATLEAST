fx_version 'adamant'

games { 'gta5' }

lua54 'yes'

client_scripts {
	'Client/Commands.lua',
	'Client/Functions.lua',
	'Client/Main.lua',
	'Client/Games/*.lua',
	'Client/Locales/*.lua',
}

server_scripts {
	'Server/Functions.lua',
	'Server/Main.lua',
	'Server/Games/*.lua'
}

shared_scripts {
	'config.lua'
}

ui_page 'ui/index.html'

files {
    "ui/index.html",
	"ui/style.css",
	"ui/*.js",
	"ui/games/**/*.js",
	"ui/games/**/*.css",
	"ui/imgs/**",
	"ui/fonts/**"
}

version '1.0'

escrow_ignore {
	'config.lua',
	'Client/Commands.lua',
	'Client/Functions.lua',
	'Client/Locales/*.lua',
	'Server/Functions.lua',
}

dependency '/assetpacks'
dependency '/assetpacks'