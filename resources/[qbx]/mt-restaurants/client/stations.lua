haveStation = function(station, stations)
    for k, v in pairs(stations) do
        if v == station then return true end
    end
    return false
end

openStation = function(job, id)
    local station = 'station_'..job..'_'..id
    if Config.inventory == 'ox_inventory' and Config.useOxInventoryCraft then
        local items = {}
        local recipes = lib.callback.await('mt-restaurants:server:getRecipes', false, job)
        if recipes and #recipes >= 1 then
            for k, v in pairs(recipes) do
                if tonumber(v.active) == 1 then
                    if haveStation(station, json.decode(v.stations)) then
                        local ingredients = {}
                        local calories = 0
                        local customBuffs = {}
                        for a, b in pairs(json.decode(v.ingredients)) do
                            if a ~= 'no_ingredient' then
                                ingredients[a] = b
                                for x, y in pairs(Config.restaurants[job].ingredients) do
                                    if y.item == a then
                                        calories += (y.calories * b)
                                        if y.customBuffs then
                                            for o, p in pairs(y.customBuffs) do
                                                if customBuffs[o] ~= nil then customBuffs[o] += (p * b) else customBuffs[o] = (p * b) end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        items[#items+1] = { anim = Config.restaurants[job].stations[id].anim, prop = Config.restaurants[job].stations[id].prop, name = 'restaurant_food', count = 1, ingredients = ingredients, duration = Config.times.makeFood, metadata = { imageurl = v.image_url, label = v.label, description = v.description, calories = calories, restaurant = Config.restaurants[job].label, animation = v.animation, type = v.type, price = v.price, customBuffs = customBuffs } }
                    end
                end
            end
        end

        if items and #items >= 1 then
            lib.callback('mt-restaurants:server:registerCraft', false, function()
                exports.ox_inventory:openInventory('crafting', { id = station })
            end, station, items, Config.restaurants[job].stations[id].label)
        else
            notify(locale('notify_error_no_recipes_station'), 'error')
        end
    else
        local menu = { id = station, title = Config.restaurants[job].stations[id].label, options = {} }
        local recipes = lib.callback.await('mt-restaurants:server:getRecipes', false, job)
        if recipes and #recipes >= 1 then
            for k, v in pairs(recipes) do
                if tonumber(v.active) == 1 then
                    if haveStation(station, json.decode(v.stations)) then
                        local neededItems = ''
                        local disabled = true
                        local items = 0
                        local ingredients = {}
                        local tempIngredients = {}
                        local calories = 0

                        for a, b in pairs(json.decode(v.ingredients)) do
                            if a ~= 'no_ingredient' then
                                ingredients[#ingredients+1] = { item = tostring(a), count = tonumber(b) }
                                for x, y in pairs(Config.restaurants[job].ingredients) do
                                    if y.item == a then calories += (y.calories * b) end
                                end
                                tempIngredients[a] = b
                            end
                        end

                        for a, b in pairs(ingredients) do
                            if itemData(tostring(b.item)) then
                                if getItemCount(tostring(b.item)) >= tonumber(b.count) then
                                    neededItems = neededItems..locale('menu_prepare_needed_item_format_check', itemData(tostring(b.item)).label, tonumber(b.count))
                                    items += 1
                                else
                                    neededItems = neededItems..locale('menu_prepare_needed_item_format_error', itemData(tostring(b.item)).label, tonumber(b.count))
                                end
                            else
                                if Config.debug then print('^1Needed item: '..tostring(b.item)..' is not created!') end
                            end
                        end

                        if items == #ingredients then disabled = false end

                        menu.options[#menu.options+1] = { disabled = disabled, title = locale('menu_prepare_title', v.label), description = neededItems, icon = v.image_url, onSelect = function() prepareItemStation(job, id, Config.restaurants[job].stations[id].label, Config.restaurants[job].stations[id].anim, 'restaurant_food', { imageurl = v.image_url, label = v.label, description = v.description, calories = calories, restaurant = Config.restaurants[job].label, animation = v.animation, type = v.type, price = v.price, customBuffs = v.customBuffs }, tempIngredients) end }
                    end
                end
            end
        end
        if menu.options and #menu.options >= 1 then
            lib.registerContext(menu)
            lib.showContext(menu.id)
        else
            notify(locale('notify_error_no_recipes_station'), 'error')
        end
    end
end

prepareItemStation = function(job, id, label, anim, item, metadata, neededItems)
    local input = lib.inputDialog(label, {
        { type = 'slider', label = locale('input_prepare_quantity'), required = true, min = 1, max = Config.maxPreparesPerTime },
    })
    if input then
        local counter = 1
        :: redo ::
        local canCraft = lib.callback.await('mt-restaurants:server:canCraftItem', false, neededItems)
        if canCraft then
            counter += 1
            if progressBar(locale('progress_preparing_ingredient', metadata.label), Config.times.makeFood, { car = true, move = true }, anim, {}) then
                lib.callback.await('mt-restaurants:server:craftItem', false, item, 1, neededItems, metadata)
            else return openStation(job, id) end
            if counter <= input[1] then goto redo end
        else
            notify(locale('notify_error_no_needed_items'), 'error')
        end
    end
    openStation(job, id)
end