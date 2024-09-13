lib.callback.register('mt-restaurants:server:canCraftItem', function(source, nItems)
    local src = source
    local items = 0
    local neededItems = {}

    for k, v in pairs(nItems) do
        neededItems[#neededItems+1] = { item = tostring(k), count = tonumber(v) }
    end

    if Config.inventory == 'ox_inventory' then
        for k, v in pairs(neededItems) do
            if exports.ox_inventory:GetItemCount(src, v.item) >= v.count then items += 1 else break end
        end
    else
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player then return end
        for k, v in pairs(neededItems) do
            if Player.Functions.GetItemByName(v.item) and Player.Functions.GetItemByName(v.item).amount >= v.count then items += 1 else break end
        end
    end

    if items == #neededItems then return true end
    return false
end)

lib.callback.register('mt-restaurants:server:craftItem', function(source, item, count, neededItems, metadata)
    local src = source
    if Config.inventory == 'ox_inventory' then
        for k, v in pairs(neededItems) do
            exports.ox_inventory:RemoveItem(src, tostring(k), tonumber(v))
        end
        exports.ox_inventory:AddItem(src, item, count, metadata or {})
    elseif Config.inventory == 'codem-inventory' or Config.inventory == 'qs-inventory' then
        for k, v in pairs(neededItems) do
            exports[Config.inventory]:RemoveItem(src, tostring(k), tonumber(v))
        end
        exports[Config.inventory]:AddItem(src, item, count, nil, metadata or {})
    else
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player then return end
        for k, v in pairs(neededItems) do
            Player.Functions.RemoveItem(tostring(k), tonumber(v))
        end
        Player.Functions.AddItem(item, count, nil, metadata or {})
    end
    createLog(Config.logs.craftItem, locale('logs_item_crafted'), locale('logs_item_crafted_desc', GetPlayerName(src), src, item, count))
    return true
end)