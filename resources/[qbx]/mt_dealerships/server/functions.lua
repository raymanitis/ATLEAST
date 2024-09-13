addAccountMoney = function(account, amount)
    if Config.banking == 'Renewed-Banking' then
        exports['Renewed-Banking']:addAccountMoney(account, amount)
    elseif Config.banking == 'esx_addonaccount' then
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..account, function(account)
            account.addMoney(amount)
        end)
    else
        exports[Config.banking]:AddMoney(account, amount)
    end
end

removeAccountMoney = function(account, amount)
    if Config.banking == 'Renewed-Banking' then
        exports['Renewed-Banking']:removeAccountMoney(account, amount)
    elseif Config.banking == 'esx_addonaccount' then
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..account, function(account)
            account.removeMoney(amount)
        end)
    else
        exports[Config.banking]:RemoveMoney(account, amount)
    end
end

getAccountMoney = function(account)
    local value = 0
    if Config.banking == 'Renewed-Banking' then
        value = exports['Renewed-Banking']:getAccountMoney(account)
    elseif Config.banking == 'esx_addonaccount' then
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..account, function(account)
            value = account.money
        end)
    elseif Config.branking == 'qb-management' then
        value = exports[Config.banking]:GetMoney(account)
    else
        value = exports[Config.banking]:GetAccountBalance(account)
    end
    return value
end

createLog = function(webhook, title, message, image)
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
        embeds = {
            {
                title = title,
                author = {
                    name = "MT Scripts - Dealerships",
                    icon_url = 'https://cdn.discordapp.com/attachments/1014907105733517442/1141400655450361916/Logo_PNG_8K.png?ex=66292c32&is=6616b732&hm=7f280578a3f1186b3778c2e828032df28d8f0b21debf468f126e0f5cb099e3d8&',
                    url = 'https://mt-scripts.tebex.io/',
                },
                color = '000000255',
                description = message,
                image = { url = image or '' },
                footer = { text = 'mt-scripts.tebex.io' },
            }
        }
    }), { ['Content-Type'] = 'application/json' })
end

addVehicleToGarage = function(PlayerData, model, mods, plate, dealership)
    local src = source
    if Config.framework == 'qb' or Config.framework == 'qbx' then
        MySQL.insert('INSERT INTO `player_vehicles` (license, citizenid, vehicle, hash, mods, plate) VALUES (?, ?, ?, ?, ?, ?)', { PlayerData.license, PlayerData.citizenid, model, GetHashKey(model), json.encode(mods), plate })

        if Config.mInsurance.enable then
            local info     = {}
            info.name      = PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname
            info.plate     = plate
            info.model     = vehicle

            if Config.mInsurance.inventory == "qb" then
                local Player = Config.core.Functions.GetPlayer(src)
                Player.Functions.AddItem('car_registration', 1, false, info)
            elseif Config.mInsurance.inventory == "ox" then
                local metadata = { description = 'Name: '..PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname..'   \nPlate: '..plate..'   \nModel: '..model }
                exports.ox_inventory:AddItem(src, 'car_registration', 1, metadata)
            end
        end
    elseif Config.framework == 'esx' then
        MySQL.insert('INSERT INTO `owned_vehicles` (owner, plate, vehicle) VALUES (?, ?, ?)', { PlayerData.identifier, plate, json.encode({model = joaat(model), plate = plate}) })

        if Config.mInsurance.enable then
            local xPlayer = ESX.GetPlayerFromId(src)
            local name = xPlayer.getName()

            local metadata = { description = 'Name: '..PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname..'   \nPlate: '..plate..'   \nModel: '..model }
            exports.ox_inventory:AddItem(src, 'car_registration', 1, metadata)
            
            MySQL.insert('INSERT INTO m_insurance_registration (plate, model, registration, identifier) VALUES (?, ?, ?, ?)', {plate, vehicle, 1, PlayerData.license})
        end
    end
end