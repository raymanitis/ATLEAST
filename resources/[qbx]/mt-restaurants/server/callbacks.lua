
if Config.inventory == 'ox_inventory' then
    lib.callback.register('mt-restaurants:server:registerStash', function(source, id, label, slots, weight)
        return exports.ox_inventory:RegisterStash(id, label, slots, weight)
    end)

    lib.callback.register('mt-restaurants:server:registerCraft', function(source, id, items, label)
        return exports.ox_inventory:RegisterCraftStation(id, { items = items, label = label })
    end)

    lib.callback.register('mt-restaurants:server:registerShop', function(source, id, label, items)
        return exports.ox_inventory:RegisterShop(id, { name = label, inventory = items })
    end)
end

if Config.inventory ~= 'ox_inventory' and Config.framework == 'qb' then
    lib.callback.register('mt-restaurants:server:GetItemCount', function(source, item)
        local src = source
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player then return end
        if Player.Functions.GetItemByName(item) then
            return Player.Functions.GetItemByName(item).amount
        end
        return 0
    end)

    lib.callback.register('mt-restaurants:server:openShop', function(source, items, id, label)
        local src = source
        exports[Config.inventory]:CreateShop({ name = id, label = label, slots = #items, items = items })
        Wait(200)
        exports[Config.inventory]:OpenShop(src, id)
        return true
    end)

    lib.callback.register('mt-restaurants:server:openStash', function(source, id, data)
        local src = source
        exports[Config.inventory]:OpenInventory(src, id, data)
        return true
    end)
end

if Config.inventory == 'codem-inventory' then
    lib.callback.register('mt-restaurants:server:GetItemCount', function(source, item)
        local src = source
        if exports['codem-inventory']:GetItemByName(src, item) then
            return exports['codem-inventory']:GetItemByName(src, item).amount
        end
        return 0
    end)
end

if Config.inventory == 'qs-inventory' then
    lib.callback.register('mt-restaurants:server:GetItemCount', function(source, item)
        local src = source
        local playerItems = exports['qs-inventory']:GetInventory(src)
        for k, v in pairs(playerItems) do
            if v.name == item then return v.amount end
        end
        return 0
    end)
end

lib.callback.register('mt-restaurants:server:addNeeds', function(source, thirst, hunger)
    return addNeeds(thirst, hunger)
end)

lib.callback.register('mt-restaurants:server:removeFoodItem', function(source, metadata, slot)
    local src = source
    if Config.inventory == 'ox_inventory' then
        exports.ox_inventory:RemoveItem(src, 'restaurant_food', 1, metadata, slot)
    elseif Config.inventory == 'codem-inventory' or Config.inventory == 'qs-inventory' then
        exports[Config.inventory]:RemoveItem(src, 'restaurant_food', 1, slot)
    else
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player then return end
        Player.Functions.RemoveItem('restaurant_food', 1, slot)
    end
    return true
end)

if Config.inventory == 'ox_inventory' then
    lib.callback.register('mt-restaurants:server:getInventoryItems', function(source, invId)
        return exports.ox_inventory:GetInventoryItems(invId)
    end)
end

lib.callback.register('mt-restaurants:server:addRestaurantBox', function(source, job)
    local src = source
    local info = { id = 'restaurants_food_box_'..job..'_'..math.random(1, 999999) }
    if Config.inventory == 'ox_inventory' then
        exports.ox_inventory:AddItem(src, 'restaurant_box', 1, info)
    elseif Config.inventory == 'codem-inventory' or Config.inventory == 'qs-inventory' then
        exports[Config.inventory]:AddItem(src, 'restaurant_box', 1, nil, info)
    else
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player then return end
        Player.Functions.AddItem('restaurant_box', 1, nil, info)
        TriggerClientEvent('inventory:client:ItemBox', src, Config.core.Shared.Items['restaurant_box'], "add", 1)
    end
    return true
end)

lib.callback.register('mt-restaurants:server:addRestaurantMenu', function(source, job)
    local src = source
    local menus = MySQL.query.await('SELECT * FROM `restaurants_menus` WHERE job = ?', { job })
    if not menus[1]?.image_url then return end
    local info = { job = job, imageurl = menus[1].image_url, image_url = menus[1].image_url, label = Config.restaurants[job].menus[1].label }
    if Config.inventory == 'ox_inventory' then
        exports.ox_inventory:AddItem(src, 'restaurant_menu', 1, info)
    elseif Config.inventory == 'codem-inventory' or Config.inventory == 'qs-inventory' then
        exports[Config.inventory]:AddItem(src, 'restaurant_menu', 1, nil, info)
    else
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player then return end
        Player.Functions.AddItem('restaurant_menu', 1, nil, info)
        TriggerClientEvent('inventory:client:ItemBox', src, Config.core.Shared.Items['restaurant_menu'], "add", 1)
    end
    return true
end)

if Config.framework == 'esx' then
    lib.callback.register('mt-restaurants:server:getPlayerJobESX', function(source)
        local src = source
        local Player = Config.core.GetPlayerFromId(src)
        if not Player then return end
        return Player.getJob().name
    end)

    lib.callback.register('mt-restaurants:server:getPlayerJobIsBossESX', function(source)
        local src = source
        local Player = Config.core.GetPlayerFromId(src)
        if not Player then return end
        return (Player.getJob().grade_name == 'boss')
    end)
end
