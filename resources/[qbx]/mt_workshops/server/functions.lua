isVehicleOwned = function(plate)
    if Config.framework == 'esx' then
        return MySQL.scalar.await('SELECT plate FROM owned_vehicles WHERE plate = ?', { plate })
    else
        return MySQL.scalar.await('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
    end
    return false
end

saveVehicleMods = function(vehicle, mods)
    if Config.framework == 'esx' then
        MySQL.update('UPDATE owned_vehicles SET vehicle = ? WHERE plate = ?', { json.encode(mods), mods.plate })
    else
        MySQL.update('UPDATE player_vehicles SET mods = ? WHERE plate = ?', { json.encode(mods), mods.plate })
    end
end

getVehicleDatabaseMods = function(plate)
    if Config.framework == 'esx' then
        return MySQL.scalar.await('SELECT vehicle FROM owned_vehicles WHERE plate = ?', { plate })
    else
        return MySQL.scalar.await('SELECT mods FROM player_vehicles WHERE plate = ?', { plate })
    end
end

addAccountMoney = function(account, amount)
    if Config.banking == 'Renewed-Banking' then
        exports['Renewed-Banking']:addAccountMoney(account, amount)
    elseif Config.banking == 'esx_addonaccount' then
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. account, function(account)
            account.addMoney(amount)
        end)
    else
        exports[Config.banking]:AddMoney(account, amount)
    end
end