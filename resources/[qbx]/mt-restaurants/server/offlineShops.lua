lib.locale()
local onlineJobPlayers = {}
local isPlayerJobOnline = {}

if Config.inventory == 'ox_inventory' then
    for k, v in pairs(Config.restaurants) do
        exports.ox_inventory:RegisterStash('restaurants_offline_shop_stash_'..k, locale('inventory_stash_offline_shop'), 50, 100)
        
        exports.ox_inventory:registerHook('swapItems', function(payload)
            if payload.fromSlot.name == 'restaurant_food' then return true end
            return false
        end, { inventoryFilter = { 'restaurants_offline_shop_stash_'..k } })

        local hookId = exports.ox_inventory:registerHook('buyItem', function(payload)
            if payload.shopType == 'restaurants_offline_shop_'..k then
                addAccountMoney(k, (payload.price*payload.count))
                exports.ox_inventory:RemoveItem('restaurants_offline_shop_stash_'..k, payload.itemName, payload.count, payload.metadata)
            end
        end)
    end
end

lib.callback.register('mt-restaurants:server:setOnlineJobPlayers', function(source, job, action)
    if action == 'add' then
        if not isPlayerJobOnline[job] then isPlayerJobOnline[job] = {} end
        table.insert(isPlayerJobOnline[job], source)
        onlineJobPlayers[job] = (onlineJobPlayers[job] or 0) + 1
    elseif onlineJobPlayers[job] ~= nil then
        for job, players in pairs(isPlayerJobOnline) do
            for i = #players, 1, -1 do
                if players[i] == source then table.remove(players, i) break end
            end
        end
        onlineJobPlayers[job] -= 1
    end
    return onlineJobPlayers
end)

AddEventHandler('playerDropped', function(reason)
    for job, players in pairs(isPlayerJobOnline) do
        for i = #players, 1, -1 do
            if players[i] == source then
                onlineJobPlayers[job] -= 1
                table.remove(players, i)
                if onlineJobPlayers[job] <= 0 then TriggerClientEvent('mt-restaurants:client:updateSpawnedShopPeds', -1, job, 'spawn') end
                break
            end
        end
    end
end)

lib.callback.register('mt-restaurants:server:checkRestaurantOnline', function(source, job)
    if onlineJobPlayers[job] ~= nil and onlineJobPlayers[job] > 0 then return true end
    return false
end)

lib.callback.register('mt-restaurants:server:getStashItems', function(source, stashId)
    local items = MySQL.query.await('SELECT * FROM `'..Config.inventoriesDatabase or 'inventories'..'` WHERE stash = ?', { stashId })
    return json.decode(items[1].items)
end)

lib.callback.register('mt-restaurants:server:buyOfflineshopItem', function(source, job, stashId, item, slot, info, amount)
    local src = source
    local items = MySQL.query.await('SELECT * FROM `stashitems` WHERE stash = ?', { stashId })
    local stashItems = json.decode(items[1].items)
    if stashItems then
        for k, v in pairs(stashItems) do
            if v.slot == slot then
                if v.amount >= amount then
                    if Config.framework == 'qb' then
                        local Player = Config.core.Functions.GetPlayer(src)
                        if not Player then return end
                        local balance = (Player.Functions.GetMoney('cash') >= (v.info.price*amount))
                        if balance then
                            if (v.amount - amount) > 0 then stashItems[k].amount -= amount else stashItems[k] = nil end
                            if MySQL.update.await('UPDATE `stashitems` SET items = ? WHERE id LIKE ?', { items, items[1].id }) then
                                Player.Functions.RemoveMoney('cash', (v.info.price*amount))
                                if Config.inventory == 'codem-inventory' or Config.inventory == 'qs-inventory' then
                                    exports[Config.inventory]:AddItem(src, item, amount, nil, info)
                                else
                                    Player.Functions.AddItem(item, amount, nil, info)
                                end
                                addAccountMoney(job, (v.info.price*amount))
                                createLog(Config.logs.offlineShopItemBuy, locale('logs_item_bought'), locale('logs_item_bought_desc', GetPlayerName(src), src, amount, info.label, (v.info.price*amount), job, stashId), info.imageurl)
                                return true
                            end
                        else return false end
                    elseif Config.framework == 'esx' then
                        local Player = Config.core.GetPlayerFromId(src)
                        if not Player then return end
                        local balance = (Player.getAccount('money') >= (v.info.price*amount))
                        if balance then
                            if (v.amount - amount) > 0 then stashItems[k].amount -= amount else stashItems[k] = nil end
                            if MySQL.update.await('UPDATE `stashitems` SET items = ? WHERE id LIKE ?', { items, items[1].id }) then
                                Player.removeAccountMoney('money', (v.info.price*amount))
                                if Config.inventory == 'codem-inventory' or Config.inventory == 'qs-inventory' then
                                    exports[Config.inventory]:AddItem(src, item, amount, nil, info)
                                else
                                    Player.addInventoryItem(item, amount, nil, info)
                                end
                                addAccountMoney(job, (v.info.price*amount))
                                createLog(Config.logs.offlineShopItemBuy, locale('logs_item_bought'), locale('logs_item_bought_desc', GetPlayerName(src), src, amount, info.label, (v.info.price*amount), job, stashId), info.imageurl)
                                return true
                            end
                        else return false end
                    end
                else return false end
            end
        end
    end
    return false
end)

RegisterNetEvent('mt-restaurants:server:updateSpawnedShopPeds', function(id, action)
    if onlineJobPlayers?[id] <= 0 then TriggerClientEvent('mt-restaurants:client:updateSpawnedShopPeds', -1, id, action) end
end)