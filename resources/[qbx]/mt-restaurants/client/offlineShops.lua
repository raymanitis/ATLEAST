local offlineShopPed = {}

openOfflineShop = function(id, label, job)
    local shopStashItems = lib.callback.await('mt-restaurants:server:getInventoryItems', false, 'restaurants_offline_shop_stash_'..job)
    if Config.inventory == 'ox_inventory' then
        local filteredItems = {}
        for k, v in pairs(shopStashItems) do
            filteredItems[#filteredItems + 1] = { name = v.name, count = v.count, price = v.metadata.price, slot = v.slot, metadata = v.metadata }
        end
        openShop(id, label, filteredItems)
    elseif Config.framework == 'qb' then
        lib.callback('mt-restaurants:server:getStashItems', false, function(shopStashItems)
            local menu = { title = label, id = id, options = {} }
            if shopStashItems then
                for k, v in pairs(shopStashItems) do
                    if v.name == 'restaurant_food' then
                        menu.options[#menu.options+1] = {
                            title = v.info.label,
                            description = locale('menu_offlineshop_description', v.amount, v.info.price),
                            arrow = true,
                            icon = v.info.imageurl,
                            onSelect = function()
                                local input = lib.inputDialog(label, {
                                    { type = 'slider', label = locale('input_prepare_quantity'), required = true, min = 1, max = v.amount },
                                })
                                if input then
                                    local buyed = lib.callback.await('mt-restaurants:server:buyOfflineshopItem', false, job, 'restaurants_offline_shop_stash_'..job, v.name, v.slot, v.info, input[1])
                                    if not buyed then notify(locale('notify_error_offlineshop'), 'error') end
                                end
                            end
                        }
                    end
                end
            end
            lib.registerContext(menu)
            lib.showContext(menu.id)
        end, 'restaurants_offline_shop_stash_'..job)
    end
end

updateOfflineShop = function(id, action)
    if action == 'spawn' then
        if not playerInsideRestaurant then return end
        local online = lib.callback.await('mt-restaurants:server:checkRestaurantOnline', false, id)
        for a, b in pairs(Config.restaurants[id].offlineShop) do
            if (not online) and (not offlineShopPed[a]) then
                offlineShopPed[a] = createPed(b.coords, b.model, { scenario = b.scenario })
                local options = {
                    {
                        distance = 2.5,
                        label = locale('target_shop', b.label),
                        icon = locale('target_shop_icon'),
                        onSelect = function() openOfflineShop('restaurants_offline_shop_'..id, b.label, id) end,
                        action = function() openOfflineShop('restaurants_offline_shop_'..id, b.label, id) end,
                    }
                }
                createEntityTarget(offlineShopPed[a], options, 2.5, 'restaurants_offline_shop_'..a)
            end
        end
    else
        for a, b in pairs(Config.restaurants[id].offlineShop) do
            if offlineShopPed[a] then
                DeletePed(offlineShopPed[a])
                DeleteEntity(offlineShopPed[a])
                offlineShopPed[a] = nil
            end
        end
    end
end

RegisterNetEvent('mt-restaurants:client:updateSpawnedShopPeds', function(id, action)
    updateOfflineShop(id, action)
end)