lib.callback.register('mt-restaurants:server:getRecipes', function(source, job)
    return MySQL.query.await('SELECT * FROM `restaurants_recipes` WHERE job = ?', { job })
end)

lib.callback.register('mt-restaurants:server:createNewRecipe', function(source, recipeData)
    createLog(Config.logs.createRecipe, locale('logs_created_new_recipe'), locale('logs_created_new_recipe_desc', GetPlayerName(source), source, recipeData.label, recipeData.type, recipeData.price, recipeData.job, recipeData.image_url), recipeData.image_url)
    return MySQL.insert.await('INSERT INTO `restaurants_recipes` (label, description, image_url, ingredients, animation, type, stations, active, price, job) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', { recipeData.label, recipeData.description or '', recipeData.image_url, json.encode(recipeData.ingredients), recipeData.animation, recipeData.type, json.encode(recipeData.station), recipeData.active, recipeData.price, recipeData.job })
end)

lib.callback.register('mt-restaurants:server:editRecipe', function(source, recipeData)
    createLog(Config.logs.editRecipe, locale('logs_recipe_edited'), locale('logs_recipe_edited_desc', GetPlayerName(source), source, recipeData.label, recipeData.type, recipeData.price, recipeData.job, recipeData.recipeId, recipeData.image_url), recipeData.image_url)
    return MySQL.update.await('UPDATE `restaurants_recipes` SET label = ?, description = ?, image_url = ?, ingredients = ?, animation = ?, type = ?, stations = ?, active = ?, price = ?, job = ? WHERE id LIKE ?', { recipeData.label, recipeData.description or '', recipeData.image_url, json.encode(recipeData.ingredients), recipeData.animation, recipeData.type, json.encode(recipeData.station), recipeData.active, recipeData.price, recipeData.job, recipeData.recipeId })
end)

lib.callback.register('mt-restaurants:server:deleteRecipe', function(source, recipeId)
    createLog(Config.logs.deleteRecipe, locale('logs_recipe_deleted'), locale('logs_recipe_deleted_desc', GetPlayerName(source), source, recipeId))
    return MySQL.query.await('DELETE FROM `restaurants_recipes` WHERE id LIKE ?', { recipeId })
end)

lib.callback.register('mt-restaurants:server:getMenus', function(source, job)
    return MySQL.query.await('SELECT * FROM `restaurants_menus` WHERE job = ?', { job })
end)

lib.callback.register('mt-restaurants:server:editMenuImage', function(source, image_url, job)
    local menus = MySQL.query.await('SELECT * FROM `restaurants_menus` WHERE job = ?', { job })
    createLog(Config.logs.menuImageEdited, locale('logs_menu_image_edited'), locale('logs_menu_image_edited_desc', GetPlayerName(source), source, job, image_url), image_url)
    if menus and #menus >= 1 then
        return MySQL.update.await('UPDATE `restaurants_menus` SET image_url = ? WHERE id LIKE ?', { image_url, menus[1].id })
    else
        return MySQL.insert.await('INSERT INTO `restaurants_menus` (image_url, job) VALUES (?, ?)', { image_url, job })
    end
end)

for k, v in pairs(Config.restaurants) do
    TriggerEvent('esx_society:registerSociety', v.job, v.job, 'society_'..v.job, 'society_'..v.job, 'society_'..v.job, { type = 'public' })
end