openManagement = function(job)
    local menu = { title = locale('menu_management_title'), id = 'restaurant_boss_menu_'..job, options = {} }
    menu.options[#menu.options+1] = { title = locale('menu_management_management_title'), description = locale('menu_management_management_description'), icon = locale('menu_management_management_icon'), arrow = true, onSelect = managementMenu }
    if Config.restaurants[job].stations then
        menu.options[#menu.options+1] = { title = locale('menu_management_recipes_title'), description = locale('menu_management_recipes_description'), icon = locale('menu_management_recipes_icon'), arrow = true, onSelect = function() recipesMenu(job) end }
    end
    if Config.restaurants[job].menus then
        local menus = lib.callback.await('mt-restaurants:server:getMenus', false, job)
        menu.options[#menu.options+1] = { title = locale('menu_management_menus_title'), image = menus[1]?.image_url or '', description = locale('menu_management_menus_description'), icon = locale('menu_management_menus_icon'), arrow = true, onSelect = function() editMenu(job) end }
    end
    if Config.restaurants[job].offlineShop then
        menu.options[#menu.options+1] = { title = locale('menu_management_offline_shop_title'), description = locale('menu_management_offline_shop_description'), icon = locale('menu_management_offline_shop_icon'), arrow = true, onSelect = function() openStash(tostring('restaurants_offline_shop_stash_'..job), locale('inventory_stash_offline_shop'), 50, 100) end }
    end
    lib.registerContext(menu)
    lib.showContext(menu.id)
end

recipesMenu = function(job)
    local recipes = lib.callback.await('mt-restaurants:server:getRecipes', false, job)
    local menu = { title = locale('menu_management_recipes_title'), id = 'restaurant_recipes_menu_'..job, options = {}, menu = 'restaurant_boss_menu_'..job }
    
    local disabled = false
    if Config.restaurants[job].maxRecipes and (Config.restaurants[job].maxRecipes <= #recipes) then disabled = true end
    menu.options[#menu.options+1] = { disabled = disabled, title = locale('menu_recipes_create_title'), icon = locale('menu_recipes_create_icon'), onSelect = function() createNewRecipe(job, 'create') end }
    
    if recipes and #recipes >= 1 then
        for k, v in pairs(recipes) do
            local types = ''
            if v.type == 'food' then types = locale('input_recipe_type_food') else types = locale('input_recipe_type_drink') end

            local stations = ''
            local stationsArray = json.decode(v.stations)
            for x, y in pairs(stationsArray) do
                local space = ', '
                if x == #stationsArray then space = '' end
                for a, b in pairs(Config.restaurants[job].stations) do
                    if 'station_'..job..'_'..a == y then
                        stations = stations..b.label..space
                    end
                end
            end

            local ingredients = ''
            local ingredientsArray = json.decode(v.ingredients)
            local calories = 0
            for x, y in pairs(ingredientsArray) do
                local lastKey = 0
                for a, b in pairs(ingredientsArray) do lastKey = a end
                local space = ', '
                if x == lastKey then space = '' end
                if x ~= 'no_ingredient' then
                    ingredients = ingredients .. itemData(x).label .. space
                    for _, h in pairs(Config.restaurants[job].ingredients) do
                        if h.item == x then calories += h.calories end
                    end
                end
            end

            local active = ''
            if tonumber(v.active) == 1 then active = locale('menu_recipe_active_true') else active = locale('menu_recipe_active_false') end

            menu.options[#menu.options+1] = { title = v.label, arrow = true, description = locale('menu_recipes_recipe_description'), icon = v.image_url,
                metadata = {
                    { label = locale('menu_recipe_label'), value = v.label or '' },
                    { label = locale('menu_recipe_description'), value = v.description or '' },
                    { label = locale('menu_recipe_type'), value = types },
                    { label = locale('menu_recipe_calories'), value = calories },
                    { label = locale('menu_recipe_stations'), value = stations },
                    { label = locale('menu_recipe_ingredients'), value = ingredients },
                    { label = locale('menu_recipe_animation'), value = Config.foodAnimations[v.animation].label or '' },
                    { label = locale('menu_recipe_price'), value = v.price or 0 },
                    { label = locale('menu_recipe_active'), value = active },
                },
                onSelect = function() editRecipeMenu(job, v.id) end
            }
        end
    else
        menu.options[#menu.options+1] = { title = locale('menu_recipes_no_recipes_title'), description = locale('menu_recipes_no_recipes_description'), icon = locale('menu_recipes_no_recipes_icon') }
    end
    lib.registerContext(menu)
    lib.showContext(menu.id)
end

isValidStation = function(job, stations, type)
    for k, v in pairs(stations) do
        for a, b in pairs(Config.restaurants[job].stations) do
            if 'station_'..job..'_'..a == v then
                if not (b.type == type) then return false end
            end
        end
    end
    return true
end

isValidIngredient = function(job, ingredients, type)
    for k, v in pairs(ingredients) do
        for a, b in pairs(Config.restaurants[job].ingredients) do
            if (b.item == k) and k ~= 'no_ingredient' then
                local haveType = false
                for x, y in pairs(b.type) do
                    if (y == type) then haveType = true end
                end
                return haveType
            elseif k == 'no_ingredient' then
                return true
            end
        end
    end
    return false
end

createNewRecipe = function(job, action, beforeValues)
    local stations = {}
    for k, v in pairs(Config.restaurants[job].stations) do
        local types = ''
        if v.type == 'food' then types = locale('input_recipe_type_food') else types = locale('input_recipe_type_drink') end
        stations[#stations+1] = { value = 'station_'..job..'_'..k, label = v.label..' ('..types..')' }
    end

    local ingredients = {}
    ingredients[#ingredients+1] = { value = 'no_ingredient', label = locale('input_recipe_no_ingredient') }
    for k, v in pairs(Config.restaurants[job].ingredients) do
        local types = ''
        local space = ', '
        local lastKey = 0
        for tk, tv in pairs(v.type) do lastKey = tk end
        for tk, tv in pairs(v.type) do
            if tk == lastKey then space = '' end
            if tv == 'food' then types = types..locale('input_recipe_type_food')..space else types = types..locale('input_recipe_type_drink')..space end
        end
        ingredients[#ingredients+1] = { value = v.item, label = itemData(v.item).label..' ('..types..')' }
    end

    local animations = {}
    for k, v in pairs(Config.foodAnimations) do
        animations[#animations+1] = { value = k, label = v.label }
    end

    local types = {
        { value = 'food', label = locale('input_recipe_type_food') },
        { value = 'drink', label = locale('input_recipe_type_drink') },
    }

    local defaultValues = {
        label = beforeValues?.label or '',
        description = beforeValues?.description or '',
        image_url = beforeValues?.image_url or '',
        price = beforeValues?.price or 0,
        animation = beforeValues?.animation or animations[1].value,
        type = beforeValues?.type or types[1].value,
        station = beforeValues?.station or nil,
        ingredients = beforeValues?.ingredients or {},
        active = beforeValues?.active or true,
        recipeId = beforeValues?.recipeId or nil
    }

    if defaultValues.ingredients then
        local tempIngredients = {}
        for k, v in pairs(defaultValues.ingredients) do
            for i = 1, v do
                tempIngredients[#tempIngredients+1] = k
            end
        end
        defaultValues.ingredients = tempIngredients
    end

    local options = {
        { type = 'input', label = locale('input_recipe_label'), default = defaultValues.label, placeholder = locale('input_recipe_label_placeholder'), required = true },
        { type = 'input', label = locale('input_recipe_description'), default = defaultValues.description, placeholder = locale('input_recipe_description_placeholder') },
        { type = 'input', label = locale('input_recipe_url'), default = defaultValues.image_url, placeholder = locale('input_recipe_url_placeholder'), required = true },
        { type = 'select', label = locale('input_recipe_animation'), searchable = true, default = defaultValues.animation, required = true, options = animations },
        { type = 'select', label = locale('input_recipe_type'), default = defaultValues.type, required = true, options = types },
        { type = 'multi-select', label = locale('input_recipe_station'), searchable = true, default = defaultValues.station, clearable = true, required = true, options = stations },
        { type = 'checkbox', label = locale('input_recipe_active'), checked = defaultValues.active },
        { type = 'number', label = locale('input_recipe_price'), default = defaultValues.price, required = true, max = Config.restaurants[job].maxRecipePrice },
    }
    for i = 1, Config.restaurants[job].maxIngredients do
        options[#options+1] = { type = 'select', label = locale('input_recipe_ingredients'), searchable = true, default = defaultValues.ingredients[i] or 'no_ingredient', required = true, options = ingredients }
    end
    
    local input = lib.inputDialog(locale('menu_recipes_create_title'), options)
    if input then
        local ingredients = {}
        for i = 9, #input do
            if ingredients[input[i]] then ingredients[input[i]] += 1 else ingredients[input[i]] = 1 end
        end
        local recipeData = { label = input[1], description = input[2], image_url = input[3], animation = input[4], type = input[5], station = input[6], ingredients = ingredients, active = input[7], price = input[8], job = job, recipeId = beforeValues?.recipeId or nil }
        local url = tostring(input[3])
        if url:match(locale('input_recipe_url_match')) then
            if isValidStation(job, input[6], input[5]) then
                if isValidIngredient(job, ingredients, input[5]) then
                    if #ingredients <= Config.restaurants[job].maxIngredients then
                        if action == 'create' then
                            local created = lib.callback.await('mt-restaurants:server:createNewRecipe', false, recipeData)
                            if created then
                                notify(locale('notify_success_recipe_created'), 'success')
                            else
                                notify(locale('notify_success_recipe_not_created'), 'error')
                            end
                        else
                            local edited = lib.callback.await('mt-restaurants:server:editRecipe', false, recipeData)
                            if edited then
                                notify(locale('notify_success_recipe_edited'), 'success')
                            else
                                notify(locale('notify_success_recipe_not_edited'), 'error')
                            end
                        end
                        return recipesMenu(job)
                    else
                        notify(locale('notify_error_invalid_ingredient_amount', Config.restaurants[job].maxIngredients[input[5]]), 'error')
                    end
                else
                    notify(locale('notify_error_invalid_ingredient'), 'error')
                end
            else
                notify(locale('notify_error_invalid_station'), 'error')
            end
        else
            notify(locale('notify_error_invalid_url'), 'error')
        end
        return createNewRecipe(job, action, recipeData)
    end
    recipesMenu(job)
end

editRecipeMenu = function(job, recipeId)
    local recipes = lib.callback.await('mt-restaurants:server:getRecipes', false, job)
    if recipes and #recipes >= 1 then
        for k, v in pairs(recipes) do
            if v.id == recipeId then
                local recipeData = { label = v.label, description = v.description, image_url = v.image_url, animation = v.animation, type = v.type, station = json.decode(v.stations), ingredients = json.decode(v.ingredients), active = v.active, job = v.job, price = v.price, recipeId = recipeId }
                lib.registerContext({
                    id = 'restaurant_edit_recipe_menu_'..job..recipeId,
                    menu = 'restaurant_recipes_menu_'..job,
                    title = v.label,
                    options = {
                        { title = locale('menu_edit_recipe_title'), description = locale('menu_edit_recipe_description'), icon = locale('menu_edit_recipe_icon'), onSelect = function() createNewRecipe(job, 'edit', recipeData) end },
                        { title = locale('menu_delete_recipe_title'), description = locale('menu_delete_recipe_description'), icon = locale('menu_delete_recipe_icon'), onSelect = function() deleteRecipe(job, recipeId) end },
                    }
                })
                lib.showContext('restaurant_edit_recipe_menu_'..job..recipeId)
            end
        end
    end
end

deleteRecipe = function(job, recipeId)
    local alert = lib.alertDialog({ header = locale('alert_delete_recipe_title'), content = locale('alert_delete_recipe_description'), centered = true, cancel = true })
    if alert == 'confirm' then
        local deleted = lib.callback.await('mt-restaurants:server:deleteRecipe', false, recipeId)
        if deleted then
            notify(locale('notify_success_recipe_deleted'), 'success')
        else
            notify(locale('notify_success_recipe_not_deleted'), 'error')
        end
    end
    recipesMenu(job)
end

editMenu = function(job)
    local menus = lib.callback.await('mt-restaurants:server:getMenus', false, job)
    local input = lib.inputDialog(locale('input_edit_menu'), {
        { type = 'input', label = locale('input_menu_url'), default = menus[1]?.image_url or '', placeholder = locale('input_menu_url_placeholder'), required = true },
    })
    if input then
        local edited = lib.callback.await('mt-restaurants:server:editMenuImage', false, input[1], job)
        if edited then
            notify(locale('notify_success_menu_edited'), 'success')
        else
            notify(locale('notify_error_menu_not_edited'), 'error')
        end
    end
    openManagement(job)
end