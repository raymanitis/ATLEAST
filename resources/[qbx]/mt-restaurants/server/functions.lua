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

if Config.inventory ~= 'ox_inventory' and Config.framework == 'qb' then
    Config.core.Functions.CreateUseableItem('restaurant_food', function(source, item)
        local src = source
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player then return end
        if Player.Functions.GetItemBySlot(item.slot) ~= nil then
            TriggerClientEvent('mt-restaurants:client:useFoodItem', src, {}, item)
        end
    end)

    Config.core.Functions.CreateUseableItem('restaurant_box', function(source, item)
        local src = source
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player then return end
        if Player.Functions.GetItemBySlot(item.slot) ~= nil then
            TriggerClientEvent('mt-restaurants:client:useBoxItem', src, {}, item)
        end
    end)

    Config.core.Functions.CreateUseableItem('restaurant_menu', function(source, item)
        local src = source
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player then return end
        if Player.Functions.GetItemBySlot(item.slot) ~= nil then
            TriggerClientEvent('mt-restaurants:client:openMenu', src, {}, item)
        end
    end)
end

if Config.inventory ~= 'ox_inventory' and Config.framework == 'esx' then
    Config.core.RegisterUsableItem('restaurant_food', function(source, item)
        local src = source
        TriggerClientEvent('mt-restaurants:client:useFoodItem', src, {}, item)
    end)

    Config.core.RegisterUsableItem('restaurant_box', function(source, item)
        local src = source
        TriggerClientEvent('mt-restaurants:client:useBoxItem', src, {}, item)
    end)

    Config.core.RegisterUsableItem('restaurant_menu', function(source, item)
        local src = source
        TriggerClientEvent('mt-restaurants:client:openMenu', src, {}, item)
    end)
end

addNeeds = function(thirst, hunger)
    local src = source
    if Config.framework == 'qb' then
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player then return end
        thirst = Player.PlayerData.metadata.thirst + thirst
        hunger = Player.PlayerData.metadata.hunger + hunger
        Player.Functions.SetMetaData('thirst', thirst)
        Player.Functions.SetMetaData('hunger', hunger)
        TriggerClientEvent('hud:client:UpdateNeeds', src, hunger, thirst)
    elseif Config.framework == 'qbx' then
        local Player = exports.qbx_core:GetPlayer(src)
        if not Player then return end
        thirst = Player.PlayerData.metadata.thirst + thirst
        hunger = Player.PlayerData.metadata.hunger + hunger
        Player.Functions.SetMetaData('thirst', thirst)
        Player.Functions.SetMetaData('hunger', hunger)
        TriggerClientEvent('hud:client:UpdateNeeds', src, hunger, thirst)
    elseif Config.framework == 'esx' then
        TriggerClientEvent('esx_status:add', src, 'hunger', (hunger * 10000))
        TriggerClientEvent('esx_status:add', src, 'thirst',  (thirst * 10000))
    end
end

createLog = function(webhook, title, message, image)
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
        embeds = {
            {
                title = title,
                author = {
                    name = "MT Scripts - Restaurants",
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