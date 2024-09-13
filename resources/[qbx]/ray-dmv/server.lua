local QBCore = exports['qb-core']:GetCoreObject()

-- Event to grant a driver's license and give the license item
RegisterNetEvent('qbx_dmvtest:grantLicense', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    -- Retrieve the player's license metadata (which stores their licenses)
    local licenseTable = Player.PlayerData.metadata.licences or {}

    -- Check if the player already has a driver's license
    if licenseTable['driver'] then
        TriggerClientEvent('QBCore:Notify', src, "Tev jau ir autovadītāja apliecība!", 'error')
        return
    end

    -- Grant the driver's license in metadata
    licenseTable['driver'] = true
    Player.Functions.SetMetaData('licences', licenseTable)

    if success then
        -- Notify the player that they have received the license
        TriggerClientEvent('QBCore:Notify', src, "Tu sāņēmi autovadītāja apliecību!", 'success')
    end

    -- Optionally store in memory (if needed for tracking without metadata)
    licenses[Player.PlayerData.citizenid] = true
end)
local QBCore = exports['qb-core']:GetCoreObject()

-- Event to handle checking the license before starting the test
RegisterNetEvent('qbx_dmvtest:checkLicenseBeforeStart', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    -- Retrieve the player's license metadata
    local licenseTable = Player.PlayerData.metadata.licences or {}

    -- Check if the player already has a driver's license
    if licenseTable['driver'] then
        -- Notify the player that they already have a license
        TriggerClientEvent('QBCore:Notify', src, "Tev jau ir autovadītāja apliecība, tu nevari sākt testu!", 'error')
    else
        -- Allow the test to start if no license is found
        TriggerClientEvent('qbx_dmvtest:allowTestStart', src)
    end
end)

-- Event to handle starting the DMV test (with cost check)
RegisterNetEvent('qbx_dmvtest:startTest', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local price = Config.DMVTestPrice

    -- Check if the player can afford the test
    if Player.Functions.RemoveMoney('cash', price) then
        -- Successfully removed the money, start the test
        TriggerClientEvent('qbx_dmvtest:startDMVTest', src) -- Notify the client to start the test
    else
        -- Not enough money
        TriggerClientEvent('QBCore:Notify', src, "Tev nav pietiekami daudz naudas lai sāktu testu.", 'error')
    end
end)
