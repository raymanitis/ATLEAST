useFoodItem = function(data, item)
    local metadata = item.metadata or item.info
    local percent = tonumber(metadata.calories/10)
    if progressBar(locale('progress_eating_food', metadata.label), Config.times.eatFood, { car = false, move = false }, Config.foodAnimations[metadata.animation].anim, Config.foodAnimations[metadata.animation].prop) then
        addNeeds(metadata.type, percent)
        giveCustomBuffs(metadata.type, metadata.customBuffs)
        lib.callback.await('mt-restaurants:server:removeFoodItem', false, metadata, item.slot)
    end
end
exports("useFoodItem", useFoodItem)
RegisterNetEvent('mt-restaurants:client:useFoodItem', useFoodItem)