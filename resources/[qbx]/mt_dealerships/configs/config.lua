Config = Config or {}

-- For more info check: https://mt-scripts-documentations.gitbook.io/mt-script-documentation/

Config.debug = false -- if true it'll print some debug on F8/console and active all zones debug
Config.framework = 'qbx' -- qb, qbx, esx (need to change the export on the Config.core)
Config.core = exports['qb-core']:GetCoreObject() -- Your core export (for qb is exports['qb-core']:GetCoreObject()) (for esx is exports.es_extended:getSharedObject()) (for qbx you can just delete this line and add '@qbx_core/modules/playerdata.lua', to the fxmanifest.lua client_scripts)
Config.target = 'ox_target' -- ox_target, qb-target, interact, ...
Config.banking = 'Renewed-Banking' -- qb-banking, Renewed-Banking, (can change at server/functions.lua) ...
Config.keys = 'Renewed-vehiclekeys' -- qb-vehiclekeys, qbx_vehiclekeys, mk_vehiclekeys, qs-vehiclekeys
Config.locale = 'en'

Config.useTabletAnimation = true

Config.mInsurance = {
    enable = false, -- Enable use m-Insurance?
    inventory = "ox", -- "qb" or "ox" | If you use esx leave this "ox"
}

Config.webhooks = {
    vehicleImported = 'https://discord.com/api/webhooks/1261464248236642406/eeZEEr-klQUlpIqSm1lOCj7Ahp8PIhuA3wIL7LopQle1xm6asCjjdJU6Tbq9gRQtJF9x',
    vehicleBought = 'https://discord.com/api/webhooks/1261464334131920959/83_foR6ViR32RYK4CKZSgjuj3rFIWsN_HCFa0S8dBsvYWnLytRE98BJxPBdodwLpNein',
}

Config.commands = {
    addStock = { command = 'addstock', restricted = 'group.admin' },
    removeStock = { command = 'removestock', restricted = 'group.admin' },
}