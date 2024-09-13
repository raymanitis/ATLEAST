local recipe = nil
local loc = nil
local inDelivery = false
local blip = nil
local ped = nil

takeOrder = function(job, id)
    local canStartDeliver = lib.callback.await('mt-restaurants:server:canStartDelivery', false, job)
    if inDelivery and (not canStartDeliver) then notify(locale('notify_cant_start_delivery'), 'error') return end
    local recipes = lib.callback.await('mt-restaurants:server:getRecipes', false, job)
    if not recipes then notify(locale('notify_no_recipes_created'), 'error') return end
    if progressBar(locale('progress_taking_order'), Config.times.takeOrder, { car = true, move = true }, { dict = 'cellphone@', clip = 'cellphone_call_listen_base' }, { model = 'vw_prop_casino_phone_01b_handle', pos = vec3(-0.007, -0.01, -0.03), rot = vec3(-92.7, 28.22, -49.0), bone = 28422 }) then
        inDelivery = true
        lib.callback.await('mt-restaurants:server:setCooldownState', false, job, id)
        recipe = recipes[math.random(1, #recipes)]
        recipe.amount = math.random(1, 3)
        loc = Config.deliveryLocations[math.random(1, #Config.deliveryLocations)]
        recipe.price = tonumber(math.floor(((recipe.price*recipe.amount)-((recipe.price*recipe.amount)*(Config.restaurants[job].delivery[id].priceLost/100)))))

        local alert = lib.alertDialog({ header = locale('alert_order_details'), content = locale('alert_order_details_desc', recipe.amount, recipe.label, recipe.price, GetStreetNameFromHashKey(GetStreetNameAtCoord(loc.x, loc.y, loc.z))), centered = true, cancel = false })
        
        blip = createBlip(vec3(loc.x, loc.y, loc.z), 409, 4, 0.6, 5, locale('blip_delivery_customer'))
        SetBlipRoute(blip, true)
        SetBlipRouteColour(blip, 5)

        ped = createPed(loc, Config.peds[math.random(1, #Config.peds)], { dict = 'random@shop_tattoo', clip = '_idle_a' })
        local options = {
            {
                label = locale('target_delivery_order'),
                icon = locale('target_delivery_order_icon'),
                onSelect = function() deliveryOrder(job, id) end,
                action = function() deliveryOrder(job, id) end,
                canInteract = function()
                    if getPlayerJob() == job and inDelivery then return true end return false
                end,
            }
        }
        createEntityTarget(ped, options, 2.5, 'delivery_ped_'..job) 
    end
end

deliveryOrder = function(job, id)
    local canDelivery = lib.callback.await('mt-restaurants:server:canDeliveryOrder', false, job, recipe)
    if canDelivery then
        canDelivery = false
        RemoveBlip(blip)
        blip = nil
        ClearPedTasks(ped)
        loadAnimDict('mp_common')
        TaskPlayAnim(ped, 'mp_common', 'givetake1_b', 8.0, 8.0, -1, 1, 0.0, false, false, false)
        TaskPlayAnim(cache.ped, 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 1, 0.0, false, false, false)
        Wait(2500*recipe.amount)
        lib.callback.await('mt-restaurants:server:makeDelivery', false, job, id, recipe)
        ClearPedTasks(cache.ped)
        ClearPedTasks(ped)
        StopAnimTask(ped, 'mp_common', 'givetake1_b', 0.0)
        StopAnimTask(cache.ped, 'mp_common', 'givetake1_a', 0.0)
        RemoveAnimDict('mp_common')
        Wait(5000)
        DeleteEntity(ped)
        ped = nil
        loc = nil
        recipe = nil
    else
        notify(locale('notify_cant_deliver'), 'error')
    end
end