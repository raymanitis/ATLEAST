Config = Config or {}

Config.framework = 'qbx' -- qb, qbx, esx (need to change the export on the Config.core)
Config.core = exports['qb-core']:GetCoreObject() -- core export (for qb is exports['qb-core']:GetCoreObject()) (for esx is exports.es_extended:getSharedObject()) (for qbx you can just delete this line and add '@qbx_core/modules/playerdata.lua', to the fxmanifest.lua client_scripts)
Config.inventory = 'ox_inventory' -- ox_inventory, qb-inventory, qb-inventory-old, ... (Remember that only with ox_inventory you'll have the best usage of all script features!!)
Config.target = 'ox_target' -- ox_target, qb-target, interact, ...
Config.keys = 'Renewed-Vehiclekeys' -- qb-vehiclekesy, Renewed-Vehiclekeys, qbx_vehiclekeys, ... (can change at server/functions.lua)
Config.banking = 'Renewed-Banking' -- qb-banking, Renewed-Banking, ... (can change at server/functions.lua)

Config.locale = 'en' -- this is the locales that'll show on the script UI

Config.inventoryDirectory = 'ox_inventory/web/images/'

Config.debug = false -- if true it'll print some debug on F8/console and active all zones debug

Config.useOxInventoryCraft = true -- if true it'll use the ox_inventory crafting system on all crafts (only for ox_invntory, check docs for that)

Config.givePerformanceItems = true -- if true it'll give the performance installed items back when removing it

Config.toggleDutyZones = false -- if true the players duty will toggle when then join the zone

Config.useClasses = false -- if false it'll ignore the vehicle classes, make sure the update the configs/performance.lua to fix the multiple performance parts
Config.useQBSharedClasses = false -- if true it'll use the qb-core/shared/vehicles.lua file to get the added classes if false the vehicle and the class needs to be added to the configs/classes.lua
Config.classesCommand = 'class'

Config.times = {
    repairEngine = 5000,
    repairBody = 5000,
    repairTank = 5000,
    wash = 5000,
    installingMod = 5000,
    removingMod = 5000,
    installingCosmetic = 5000,
    askMission = 5000
}

Config.repairItems = {
    engine = { count = 1, item = 'metalscrap' },
    body = { count = 1, item = 'iron' },
    tank = { count = 1, item = 'plastic' },
}

Config.preview = {
    command = 'preview',
    lockJob = false
}