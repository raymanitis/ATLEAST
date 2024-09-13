local QBCore = GetResourceState('qb-core') == 'started' and exports['qb-core']:GetCoreObject()
local ESX = GetResourceState('es_extended') == 'started' and exports.es_extended:getSharedObject()

-- Function to retrieve player name
local function PlayerName(src)
    if QBCore then 
        local Player = QBCore.Functions.GetPlayer(src)
        return Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
    elseif ESX then 
        local Player = ESX.GetPlayerFromId(src)
        local first, last
        if Player.get and Player.get('firstName') and Player.get('lastName') then
            first = Player.get('firstName')
            last = Player.get('lastName')
        else
            local name = MySQL.Sync.fetchAll('SELECT `firstname`, `lastname` FROM `users` WHERE `identifier`=@identifier', { ['@identifier'] = ESX.GetIdentifier(source) })
            first, last = name[1]?.firstname or ESX.GetPlayerName(source), name[1]?.lastname or ''
        end
        return first..' '..last
    end
end

-- Give Vehicle Keys
RegisterNetEvent('solos-rentals:server:GiveVehicleKey', function(plate)
    local src = source
    -- Give keys to player for the vehicle
    local success = exports['Renewed-Vehiclekeys']:addKey(src, plate)
    
    if success then
        print(('Successfully gave keys for vehicle [%s] to player [%s]'):format(plate, src))
    else
        print(('Failed to give keys for vehicle [%s] to player [%s]'):format(plate, src))
    end
    
    -- Notify player
    TriggerClientEvent('ox_lib:notify', src, {
        id = 'key_success',
        description = 'Transportlīdzekļa atslēgas piešķirtas',
        position = 'top-right',
        icon = 'key',
        iconColor = 'green'
    })
end)

-- Rent Vehicle and Deduct Money
RegisterNetEvent('solos-rentals:server:MoneyAmounts', function(vehiclename, price, location)
    local src = source
    local moneytype = 'bank'
    local price = tonumber(price)
    local bank, cash

    if QBCore then 
        local Player = QBCore.Functions.GetPlayer(src)
        bank = Player.PlayerData.money.bank
        cash = Player.PlayerData.money.cash
    elseif ESX then 
        local Player = ESX.GetPlayerFromId(src)
        bank = Player.getAccount('bank').money
        cash = Player.getAccount('money').money
    end

    -- Check if the player has enough money
    if bank < price then 
        moneytype = 'money'
        if cash < price then 
            TriggerClientEvent('ox_lib:notify', src, {
                id = 'not_enough_money',
                description = 'Nav pietiekami daudz līdzekļu',
                position = 'top-right',
                icon = 'ban',
                iconColor = '#C53030'
            })
            return 
        end
    end

    -- Deduct Money
    if QBCore then 
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.RemoveMoney(moneytype, price)
    elseif ESX then
        local Player = ESX.GetPlayerFromId(src)
        if moneytype == 'money' then
            Player.removeMoney(price)
        else
            Player.removeAccountMoney('bank', price)
        end
    end

    -- Notify and Spawn Vehicle
    TriggerClientEvent('ox_lib:notify', src, {
        id = 'rental_success',
        description = vehiclename:gsub("^%l", string.upper)..' noīrēja par $'..price..'.',
        position = 'top-right',
        icon = 'car',
        iconColor = 'white'
    })
    TriggerClientEvent('solos-rentals:client:SpawnVehicle', src, vehiclename, location)
end)
