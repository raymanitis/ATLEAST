local cooldownActive = {}

lib.callback.register('mt-restaurants:server:canDeliveryOrder', function(source, job, recipe)
    local src = source
    local itemAmount = 0
    if Config.inventory == 'ox_inventory' then
        local playerItems = exports.ox_inventory:GetInventoryItems(src)
        for k, v in pairs(playerItems) do
            if v.name == 'restaurant_food' then
                if v.metadata.label == recipe.label then itemAmount += v.count end
            end
        end
    elseif Config.inventory == 'codem-inventory' then
        local playerItems = exports['codem-inventory']:GetItemsByName(src, 'restaurant_food')
        if playerItems then
            for k, v in pairs(playerItems) do
                if v.info.label == recipe.label then itemAmount += v.amount end
            end
        end
    elseif Config.inventory == 'qs-inventory' then
        local playerItems = exports['qs-inventory']:GetInventory(src)
        if playerItems then
            for k, v in pairs(playerItems) do
                if v.name == 'restaurant_food' then
                    if v.info.label == recipe.label then itemAmount += v.amount end
                end
            end
        end
    else
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player then return end
        local playerItems = Player.PlayerData.items
        for k, v in pairs(playerItems) do
            if v.name == 'restaurant_food' then
                if v.info.label == recipe.label then itemAmount += v.amount end
            end
        end
    end
    return (itemAmount >= recipe.amount)
end)

lib.callback.register('mt-restaurants:server:makeDelivery', function(source, job, id, recipe)
    local src = source
    if Config.inventory == 'ox_inventory' then
        local playerItems = exports.ox_inventory:GetInventoryItems(src)
        for k, v in pairs(playerItems) do
            if v.name == 'restaurant_food' then
                if v.count >= recipe.amount then
                    if v.metadata.label == recipe.label then
                        local payment = tonumber(math.floor(recipe.price*Config.restaurants[job].delivery[id].comission/100))
                        exports.ox_inventory:RemoveItem(src, v.name, recipe.amount, nil, v.slot)
                        if Config.framework == 'qb' then
                            local Player = Config.core.Functions.GetPlayer(src)
                            if not Player then return end
                            Player.Functions.AddMoney('cash', payment, 'restaurants-delivery-payment')
                        elseif Config.framework == 'qbx' then
                            local Player = exports.qbx_core:GetPlayer(src)
                            if not Player then return end
                            Player.Functions.AddMoney('cash', payment, 'restaurants-delivery-payment')
                        elseif Config.framework == 'esx' then
                            local Player = Config.core.GetPlayerFromId(src)
                            if not Player then return end
                            Player.addAccountMoney('cash', payment)
                        end
                        addAccountMoney(job, tonumber(recipe.price-payment))
                        return true
                    end
                end
            end
        end
    elseif Config.inventory == 'codem-inventory' then
        local playerItems = exports['codem-inventory']:GetItemsByName(src, 'restaurant_food')
        if playerItems then
            for k, v in pairs(playerItems) do
                if v.amount >= recipe.amount then
                    if v.info.label == recipe.label then
                        local payment = tonumber(math.floor(recipe.price*Config.restaurants[job].delivery[id].comission/100))
                        exports['codem-inventory']:RemoveItem(src, v.name, recipe.amount, v.slot)
                        if Config.framework == 'qb' then
                            local Player = Config.core.Functions.GetPlayer(src)
                            if not Player then return end
                            Player.Functions.AddMoney('cash', payment, 'restaurants-delivery-payment')
                        elseif Config.framework == 'qbx' then
                            local Player = exports.qbx_core:GetPlayer(src)
                            if not Player then return end
                            Player.Functions.AddMoney('cash', payment, 'restaurants-delivery-payment')
                        elseif Config.framework == 'esx' then
                            local Player = Config.core.GetPlayerFromId(src)
                            if not Player then return end
                            Player.addAccountMoney('cash', payment)
                        end
                        addAccountMoney(job, tonumber(recipe.price-payment))
                        return true
                    end
                end
            end
        end
    elseif Config.inventory == 'qs-inventory' then
        local playerItems = exports['qs-inventory']:GetInventory(src)
        if playerItems then
            for k, v in pairs(playerItems) do
                if v.name == 'restaurant_food' then
                    if v.amount >= recipe.amount then
                        if v.info.label == recipe.label then
                            local payment = tonumber(math.floor(recipe.price*Config.restaurants[job].delivery[id].comission/100))
                            exports['qs-inventory']:RemoveItem(src, v.name, recipe.amount, v.slot)
                            if Config.framework == 'qb' then
                                local Player = Config.core.Functions.GetPlayer(src)
                                if not Player then return end
                                Player.Functions.AddMoney('cash', payment, 'restaurants-delivery-payment')
                            elseif Config.framework == 'qbx' then
                                local Player = exports.qbx_core:GetPlayer(src)
                                if not Player then return end
                                Player.Functions.AddMoney('cash', payment, 'restaurants-delivery-payment')
                            elseif Config.framework == 'esx' then
                                local Player = Config.core.GetPlayerFromId(src)
                                if not Player then return end
                                Player.addAccountMoney('cash', payment)
                            end
                            addAccountMoney(job, tonumber(recipe.price-payment))
                            return true
                        end
                    end
                end
            end
        end
    else
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player then return end
        local playerItems = Player.PlayerData.items
        for k, v in pairs(playerItems) do
            if v.name == 'restaurant_food' then
                if v.amount >= recipe.amount then
                    if v.info.label == recipe.label then
                        Player.Functions.RemoveItem(v.name, recipe.amount, v.slot)
                        Player.Functions.AddMoney('cash', payment, 'restaurants-delivery-payment')
                        addAccountMoney(job, tonumber(recipe.price-payment))
                        return true
                    end
                end
            end
        end
    end
    return false
end)

lib.callback.register('mt-restaurants:server:canStartDelivery', function(source, job)
    return cooldownActive[job]
end)

lib.callback.register('mt-restaurants:server:setCooldownState', function(source, job, id)
    cooldownActive[job] = false
    Citizen.CreateThread(function()
        Wait(Config.restaurants[job].delivery[id].cooldown*60000)
        cooldownActive[job] = true
    end)
    return true
end)