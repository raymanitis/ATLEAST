fx_version 'cerulean'
game 'gta5'

description 'Renewed-Vehiclekeys'
author 'Renewed Scripts | FjamZoo'
version '1.2.0'

lua54 'yes'
use_experimental_fxv2_oal 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    '@Renewed-Lib/init.lua'
}

client_script 'client/*.lua'

server_script 'server/*.lua'

provide 'qb-vehiclekeys'
provide 'qbx-vehiclekeys'
provide 'qbx_vehiclekeys'
provide 'wasabi_carlock'

data_file 'AUDIO_WAVEPACK' 'dlc_vehiclekeys'
data_file 'AUDIO_SOUNDDATA' 'data/dlcvehiclekeys_sounds.dat'

files {
    'locales/*.json',
    'data.lua',
    'utils/client.lua',
    'data/dlcvehiclekeys_sounds.dat54.rel',
	'dlc_vehiclekeys/vehiclekeys.awc'
}

dependencies {
	'/server:6279',
    '/gameBuild:2372',
	'/onesync',
    'oxmysql',
	'ox_lib',
    'Renewed-Lib',
    'ox_inventory'
}

escrow_ignore {
    'locales/*.json',
    'data.lua',
    'utils/*.lua',
}
dependency '/assetpacks'