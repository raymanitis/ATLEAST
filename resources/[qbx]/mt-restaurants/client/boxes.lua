takeBox = function(job, id)
    lib.callback.await('mt-restaurants:server:addRestaurantBox', false, job)
end

useBoxItem = function(data, item)
    local metadata = item.metadata or item.info
    openStash(metadata.id, locale('inventory_stash_restaurant_box'), Config.boxes.slots, Config.boxes.weigth)
end
exports("useBoxItem", useBoxItem)
RegisterNetEvent('mt-restaurants:client:useBoxItem', useBoxItem)