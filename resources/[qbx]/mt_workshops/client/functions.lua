createBlip = function(coords, sprite, display, scale, color, label)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipDisplay(blip, display)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, scale)
    SetBlipColour(blip, color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(label)
    EndTextCommandSetBlipName(blip)
    return blip
end

createSphereZoneTarget = function(coords, radius, options, distance, name)
    if Config.target == 'ox_target' then
        return exports.ox_target:addSphereZone({ debug = Config.debug, coords = coords, radius = radius, options = options })
    elseif Config.target == 'interact' then
        return exports.interact:AddInteraction({ coords = vec3(coords.x, coords.y, coords.z), distance = 1.0, interactDst = 1.0, id = name, name = name, options = options })
    else
        -- Here we use Box Zone cause qb-target Sphere Zone does not exists and the Circle Zone is the big shit ever made
        return exports[Config.target]:AddBoxZone(name, coords, radius, radius, { debugPoly = Config.debug, name = name, minZ = coords.z-radius, maxZ = coords.z+radius }, { options = options, distance = distance })
    end
end

createAddModelTarget = function(model, options, distance)
    if Config.target == 'ox_target' then
        return exports.ox_target:addModel(model, options)
    elseif Config.target == 'interact' then
        return exports.interact:AddModelInteraction({ model = model, distance = distance, options = options })
    else
        return exports[Config.target]:AddTargetModel(model, { options = options, distance = distance })
    end
end

createGlobalVehicleTarget = function(options, distance)
    if Config.target == 'ox_target' then
        return exports.ox_target:addGlobalVehicle(options)
    elseif Config.target == 'interact' then
        return exports.interact:AddGlobalVehicleInteraction({ distance = distance, options = options })
    else
        return exports[Config.target]:AddGlobalVehicle({ options = options, distance = options })
    end
end

createEntityTarget = function(entity, options, distance, name)
    if Config.target == 'ox_target' then
        return exports.ox_target:addLocalEntity(entity, options)
    elseif Config.target == 'interact' then
        return exports.interact:AddLocalEntityInteraction({ entity = entity, name = name, id = name, distance = 1.0, interactDst = 1.0, options = options })
    else
        return exports[Config.target]:AddTargetEntity(entity, { name = name, options = options, distance = distance })
    end
end

openStash = function(id, label, slots, weight)
    if Config.inventory == 'ox_inventory' then
        lib.callback('mt_workshops:server:registerStash', false, function()
            exports.ox_inventory:openInventory('stash', id)
        end, id, label, slots, (weight*1000))
    elseif Config.inventory == 'qb-inventory-old' then
        TriggerEvent("inventory:client:SetCurrentStash", id)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", id, { maxweight = (weight*1000), slots = slots })
    else
        lib.callback.await('mt_workshops:server:openStash', false, id, { maxweight = (weight*1000), slots = slots })
    end
end

openShop = function(id, label, passedItems)
    if Config.inventory == 'ox_inventory' then
        lib.callback('mt_workshops:server:registerShop', false, function()
            exports.ox_inventory:openInventory('shop', { type = id })
        end, id, label, passedItems)
    elseif Config.inventory == 'qb-inventory-old' then
        local items = {}
        for k, v in pairs(passedItems) do
            items[#items+1] = { name = v.name, price = tonumber(v.price), amount = tonumber(v.count), info = {}, slot = k }
        end
        local Item = { label = label, slots = #items, items = items }
        TriggerServerEvent("inventory:server:OpenInventory", "shop", id, Item)
    else
        local items = {}
        for k, v in pairs(passedItems) do
            items[#items+1] = { name = v.name, price = tonumber(v.price), amount = tonumber(v.count), info = {}, slot = k }
        end
        lib.callback.await('mt_workshops:server:openShop', false, items, id, label)
    end
end

getItemData = function(item)
   if Config.framework == 'qb' and Config.inventory ~= 'ox_inventory' then
        return Config.core.Shared.Items[item]
   else
        return exports.ox_inventory:Items(item)
   end
end

openCraft = function(id, label, items)
    if Config.inventory == 'ox_inventory' and Config.useOxInventoryCraft then
        lib.callback('mt_workshops:server:registerCraft', false, function()
            exports.ox_inventory:openInventory('crafting', { id = id })
        end, id, items, label)
    else
        local newItems = {}
        for k, v in pairs(items) do
            newItems[k] = { name = v.name, count = v.count, label = getItemData(v.name).label, duration = v.duration, ingredients = {} }
            for ik, iv in pairs(v.ingredients) do
                table.insert(newItems[k].ingredients, { name = ik, count = iv, label = getItemData(ik).label })
            end
        end
        SendNUI('craftingMenu', { id = id, label = label, items = newItems, oldItems = items, inventoryDirectory = Config.inventoryDirectory })
        ShowNUI('setVisibleCraftingMenu', true)
    end
end

managementMenu = function()
    if Config.framework == 'qb' then
        TriggerEvent('qb-bossmenu:client:OpenMenu')
    elseif Config.framework == 'qbx' then
        exports.qbx_management:OpenBossMenu('job')
    elseif Config.framework == 'esx' then
        TriggerEvent('esx_society:openBossMenu', getPlayerJob(), function(data, menu) menu.close() end, {wash = false})
    end
end

getPlayerJob = function()
    if Config.framework == 'qb' then
        local PlayerData = Config.core.Functions.GetPlayerData()
        return PlayerData.job.name
    elseif Config.framework == 'qbx' then
        return QBX.PlayerData.job.name
    elseif Config.framework == 'esx' then
        return lib.callback.await('mt_workshops:server:getPlayerJobESX', false)
    end
end

isPlayerJobBoss = function()
    if Config.framework == 'qb' then
        local PlayerData = Config.core.Functions.GetPlayerData()
        return PlayerData.job.isboss
    elseif Config.framework == 'qbx' then
        return QBX.PlayerData.job.isboss
    elseif Config.framework == 'esx' then
        return lib.callback.await('mt_workshops:server:getPlayerJobIsBossESX', false)
    end
end

onZoneEnter = function(job)
    if getPlayerJob() == job then
        insideZone[job] = true
        if Config.toggleDutyZones then
            if Config.framework == 'qb' then
                local PlayerData = Config.core.Functions.GetPlayerData()
                if not PlayerData.job.onduty then TriggerServerEvent("QBCore:ToggleDuty") end
            elseif Config.framework == 'qbx' then
                if not QBX.PlayerData.job.onduty then TriggerServerEvent("QBCore:ToggleDuty") end
            end
        end
    end
    insideZoneNoJob = true
end

onZoneExit = function(job)
    if getPlayerJob() == job then
        insideZone[job] = false
        if Config.toggleDutyZones then
            if Config.framework == 'qb' then
                local PlayerData = Config.core.Functions.GetPlayerData()
                if PlayerData.job.onduty then TriggerServerEvent("QBCore:ToggleDuty") end
            elseif Config.framework == 'qbx' then
                if QBX.PlayerData.job.onduty then TriggerServerEvent("QBCore:ToggleDuty") end
            end
        end
    end
    insideZoneNoJob = false
end

getClosestVehicle = function()
    return lib.getClosestVehicle(GetEntityCoords(cache.ped), 3.0)
end

notify = function(message, type)
    lib.notify({ description = message, type = type })
end

progressBar = function(label, duration, disable, anim, prop)
	return lib.progressBar({ label = label, duration = duration, position = Config.progressbarPos, useWhileDead = false, canCancel = true, disable = disable, anim = anim, prop = prop })
end

loadAnimDict = function(dict)
    if not HasAnimDictLoaded(dict) then
        while not HasAnimDictLoaded(dict) do
            RequestAnimDict(dict)
            Wait(5)
        end
    end
end

loadModel = function(model)
    local time = 1000
    if not HasModelLoaded(model) then
        while not HasModelLoaded(model) do
            if time > 0 then time = time - 1 RequestModel(model) else time = 1000 break end Wait(10)
        end
    end 
end

createProp = function(model, coords, heading)
    loadModel(model)
    local prop = CreateObject(GetHashKey(model), coords.x, coords.y, coords.z, false, false, false)
    SetEntityHeading(prop, heading)
    FreezeEntityPosition(prop, true)
    return prop
end

createPed = function(coords, model, anim)
    loadModel(model)
    local ped =  CreatePed(4, GetHashKey(model), coords.x, coords.y, coords.z, coords.w, false, true)
    SetEntityHeading(ped, coords.w)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    if anim.scenario then
        TaskStartScenarioInPlace(ped, anim.scenario, 0, true)
    elseif anim.dict and anim.clip then
        loadAnimDict(anim.dict)
        TaskPlayAnim(ped, anim.dict, anim.clip, 8.0, 0.0, -1, 1, 0.0, 0, 0, 0)
    end
    return ped
end

loadParticle = function(pack)
    if not HasNamedPtfxAssetLoaded(pack) then RequestNamedPtfxAsset(pack) end
    while not HasNamedPtfxAssetLoaded(pack) do Wait(1) end
    SetPtfxAssetNextCall(pack)
end

loadAnimDict = function(dict)
    if not HasAnimDictLoaded(dict) then
        while not HasAnimDictLoaded(dict) do RequestAnimDict(dict) Wait(5) end
    end
end

playAnim = function(animDict, animName, duration, flag)
	loadAnimDict(animDict)
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, flag, 1, false, false, false)
end

getVehicleMods = function(vehicle)
    return lib.getVehicleProperties(vehicle)
end

setVehicleMods = function(vehicle, mods)
    lib.setVehicleProperties(vehicle, mods)
end

getHasItem = function(item, count)
    if Config.inventory == 'ox_inventory' then
        return exports.ox_inventory:GetItemCount(item) >= count
    else
        return lib.callback.await('mt_workshops:server:GetItemCount', false, item) >= count
    end
end

getVehicleClass = function(vehicle)
    local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
    if Config.useQBSharedClasses and (Config.framework == 'qb' or Config.framework == 'qbx') then
        return Config.core.Shared.Vehicles[model].class or 'NONE'
    else
        return Config.vehicleClasses[model] or 'NONE'
    end
    return 'NONE'
end

showTextUI = function(text, icon)
    return lib.showTextUI(text, { position = "top-center", icon = icon or '' })
end

hideTextUI = function()
    return lib.hideTextUI()
end

getPlayersFromCoords = function(coords, distance)
    coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords or GetEntityCoords(cache.ped)
    local players = lib.getNearbyPlayers(coords, distance or 5, true)
    for i = 1, #players do players[i] = players[i].id end
    return players
end

spawnVehicle = function(model, coords)
    coords = vec4(coords.x, coords.y, coords.z, coords.w or GetEntityHeading(cache.ped))
    model = type(model) == 'string' and joaat(model) or model
    if not IsModelInCdimage(model) then return end
    loadModel(model)
    local veh = CreateVehicle(model, coords.x, coords.y, coords.z, coords.w, true, false)
    local netid = NetworkGetNetworkIdFromEntity(veh)
    SetVehicleHasBeenOwnedByPlayer(veh, true)
    SetNetworkIdCanMigrate(netid, true)
    SetVehicleNeedsToBeHotwired(veh, false)
    SetVehRadioStation(veh, 'OFF')
    SetVehicleFuelLevel(veh, 100.0)
    if Config.keys == 'Renewed-Vehiclekeys' then
        exports['Renewed-Vehiclekeys']:addKey(GetVehicleNumberPlateText(veh))
    else
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
    end
    SetModelAsNoLongerNeeded(model)
    return veh
end

removeVehicleKey = function(plate)
    if Config.keys == 'Renewed-Vehiclekeys' then
        exports['Renewed-Vehiclekeys']:removeKey(plate)
    end
end