if Config.inventory == 'ox_inventory' then
    lib.callback.register('mt_workshops:server:registerStash', function(source, id, label, slots, weight)
        return exports.ox_inventory:RegisterStash(id, label, slots, weight)
    end)

    lib.callback.register('mt_workshops:server:registerCraft', function(source, id, items, label)
        return exports.ox_inventory:RegisterCraftStation(id, { items = items, label = label })
    end)

    lib.callback.register('mt_workshops:server:registerShop', function(source, id, label, items)
        return exports.ox_inventory:RegisterShop(id, { name = label, inventory = items })
    end)
end

if Config.inventory ~= 'ox_inventory' and Config.framework == 'qb' then
    lib.callback.register('mt_workshops:server:GetItemCount', function(source, item)
        local src = source
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player then return end
        if Player.Functions.GetItemByName(item) then
            return Player.Functions.GetItemByName(item).amount
        end
        return 0
    end)

    lib.callback.register('mt_workshops:server:openShop', function(source, items, id, label)
        local src = source
        exports[Config.inventory]:CreateShop({ name = id, label = label, slots = #items, items = items })
        Wait(200)
        exports[Config.inventory]:OpenShop(src, id)
        return true
    end)

    lib.callback.register('mt_workshops:server:openStash', function(source, id, data)
        local src = source
        exports[Config.inventory]:OpenInventory(src, id, data)
        return true
    end)
end

if Config.framework == 'esx' then
    lib.callback.register('mt_workshops:server:getPlayerJobESX', function(source)
        local src = source
        local Player = Config.core.GetPlayerFromId(src)
        if not Player then return end
        return Player.getJob().name
    end)

    lib.callback.register('mt_workshops:server:getPlayerJobIsBossESX', function(source)
        local src = source
        local Player = Config.core.GetPlayerFromId(src)
        if not Player then return end
        return (Player.getJob().grade_name == 'boss')
    end)
end

lib.callback.register('mt_workshops:server:removeItem', function(source, item, count, slot)
    local src = source
    if Config.inventory == 'ox_inventory' then
        exports.ox_inventory:RemoveItem(src, item, count, nil, slot or nil)
    elseif Config.framework == 'qb' then
        local Player = Config.core.Functions.GetPlayer(src)
        Player.Functions.RemoveItem(item, count, slot or nil)
    end
end)

lib.callback.register('mt_workshops:server:addItem', function(source, item, count, metadata)
    local src = source
    if Config.inventory == 'ox_inventory' then
        exports.ox_inventory:AddItem(src, item, count, metadata)
    elseif Config.framework == 'qb' then
        local Player = Config.core.Functions.GetPlayer(src)
        Player.Functions.AddItem(item, count, nil, metadata)
    end
end)

lib.callback.register('mt_workshops:server:canCraftItem', function(source, ingredients)
    local src = source
    local haveCount = 0
    if Config.inventory == 'ox_inventory' then
        for k, v in pairs(ingredients) do
            if exports.ox_inventory:GetItemCount(src, v.name) >= v.count then haveCount += 1 end
        end
    elseif Config.framework == 'qb' then
        for k, v in pairs(ingredients) do
            local Player = Config.core.Functions.GetPlayer(src)
            local item = Player.Functions.GetItemByName(v.name)
            if item and item.amount >= v.count then haveCount += 1 end
        end
    end
    return (haveCount == #ingredients)
end)

lib.callback.register('mt_workshops:server:craftItem', function(source, item, count, ingredients)
    local src = source
    if Config.inventory == 'ox_inventory' then
        for k, v in pairs(ingredients) do
            exports.ox_inventory:RemoveItem(src, v.name, v.count)
        end
        exports.ox_inventory:AddItem(src, item, count)
    elseif Config.framework == 'qb' then
        local Player = Config.core.Functions.GetPlayer(src)
        for k, v in pairs(ingredients) do
            Player.Functions.RemoveItem(v.name, v.count)
        end
        Player.Functions.AddItem(item, count)
    end
    return true
end)

lib.callback.register('mt_workshops:server:setItemMetadata', function(source, item, slot, metadata)
    local src = source
    if Config.inventory == 'ox_inventory' then
        exports.ox_inventory:SetMetadata(src, slot, metadata)
    elseif Config.framework == 'qb' then
        local Player = Config.core.Functions.GetPlayer(src)
        Player.Functions.RemoveItem(item, slot)
        Player.Functions.AddItem(item, 1, slot, metadata)
    end
end)

lib.callback.register('mt_workshops:server:checkAllMetadataItemIsDone', function(source, plate)
    local src = source
    if Config.inventory == 'ox_inventory' then
        local items = exports.ox_inventory:GetInventoryItems(src)
        local counter = 0
        for k, v in pairs(items) do
            if v.name == 'mods_list' then
                if v.metadata.plate == plate then
                    for mk, mv in pairs(v.metadata.modsList) do
                        if mv.applied then counter += 1 end
                    end
                    return (counter == #v.metadata.modsList)
                end
            end
        end
    elseif Config.framework == 'qb' then
        local Player = Config.core.Functions.GetPlayer(src)
        local items = Player.PlayerData.items
        local counter = 0
        for k, v in pairs(items) do
            if v.name == 'mods_list' then
                if v.info.plate == plate then
                    for mk, mv in pairs(v.info.modsList) do
                        if mv.applied then counter += 1 end
                    end
                    return (counter == #v.info.modsList)
                end
            end
        end
    end
end)