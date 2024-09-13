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

loadModel = function(model)
    local time = 1000
    if not HasModelLoaded(model) then
        while not HasModelLoaded(model) do
            if time > 0 then time = time - 1 RequestModel(model) else time = 1000 break end Wait(10)
        end
    end 
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

createEntityTarget = function(entity, options, distance, name)
    if Config.target == 'ox_target' then
        return exports.ox_target:addLocalEntity(entity, options)
    elseif Config.target == 'interact' then
        return exports.interact:AddLocalEntityInteraction({ entity = entity, name = name, id = name, distance = 1.0, interactDst = 1.0, options = options })
    else
        return exports[Config.target]:AddTargetEntity(entity, { name = name, options = options, distance = distance })
    end
end

managementMenu = function()
    if Config.framework == 'qb' then
        TriggerEvent('qb-bossmenu:client:OpenMenu')
    elseif Config.framework == 'qbx' then
        exports.qbx_management:OpenBossMenu('job')
    elseif Config.framework == 'esx' then
        TriggerEvent('esx_society:openBossMenu', getPlayerJob(), false, {wash = false})
    end
end

notify = function(message, type)
    lib.notify({ description = message, type = type })
end

showTextUI = function(text, pos, icon)
    return lib.showTextUI(text, { position = pos or 'right-center', icon = icon or '' })
end

hideTextUI = function()
    return lib.hideTextUI()
end

spawnVehicle = function(model, coords, plate)
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
    SetVehicleNumberPlateText(veh, plate or 'PDM')
    SetModelAsNoLongerNeeded(model)
    if Config.keys == 'qs-vehiclekeys' then
        exports['qs-vehiclekeys']:GiveKeys(GetVehicleNumberPlateText(veh), GetDisplayNameFromVehicleModel(GetEntityModel(veh)), true)
    elseif Config.keys == 'mk_vehiclekeys' then
        exports[Config.keys]:AddKey(veh)
    else
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
    end
    return veh
end

createShowroomVehicle = function(model, coords, color)
    loadModel(model)
    Wait(100)
    local veh = CreateVehicle(model, coords.x, coords.y, coords.z, coords.w, false, false)
    Wait(500)
    SetModelAsNoLongerNeeded(model)
    SetEntityInvincible(veh, true)
    SetVehicleDirtLevel(veh, 0.0)
    SetVehicleDoorsLocked(veh, 3)
    FreezeEntityPosition(veh, true)
    SetVehicleNumberPlateText(veh, 'PDM')
    SetVehicleColours(veh, color, color)
    SetVehicleExtraColours(veh, color, 0)
    return veh
end

getPlayerJob = function()
    if Config.framework == 'qb' then
        local PlayerData = Config.core.Functions.GetPlayerData()
        return PlayerData.job.name
    elseif Config.framework == 'qbx' then
        return QBX.PlayerData.job.name
    elseif Config.framework == 'esx' then
        return lib.callback.await('mt_dealerships:server:getPlayerJobESX', false)
    end
end

isPlayerJobBoss = function()
    if Config.framework == 'qb' then
        local PlayerData = Config.core.Functions.GetPlayerData()
        return PlayerData.job.isboss
    elseif Config.framework == 'qbx' then
        return QBX.PlayerData.job.isboss
    elseif Config.framework == 'esx' then
        return lib.callback.await('mt_dealerships:server:getPlayerJobIsBossESX', false)
    end
end

openMenu = function(menu)
    lib.registerContext(menu)
    lib.showContext(menu.id)
end

generatePlate = function()
    local plate = ""
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    for i = 1, 8 do
        local randIndex = math.random(1, #chars)
        plate = plate..chars:sub(randIndex, randIndex)
    end
    return plate
end

getPlayersFromCoords = function(coords, distance)
    coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords or GetEntityCoords(cache.ped)
    local players = lib.getNearbyPlayers(coords, distance or 5, true)
    for i = 1, #players do players[i] = players[i].id end
    return players
end