local EmsMenu = {}

function handleInteractions(name, coords, opts, dist)
    if Config.UseTarget then
        if GetResourceState('ox_target') == 'started' then
            oxZones[name] = exports.ox_target:addSphereZone({
                name = name,
                coords = coords,
                radius = 0.5,
                debug = Config.Debug,
                options = preLindenRage(opts, dist),
            })
        else
            exports['qb-target']:AddCircleZone(name, coords, 0.5, {
                name = name,
                debugPoly = Config.Debug,
                useZ = true
            }, { options = opts, distance = dist })
        end
    else
        exports.interact:AddInteraction({
            coords = coords,
            distance = 5.0,
            ignoreLos = true,
            interactDst = 1.5,
            id = name,
            name = name,
            options = opts
        })
    end
end

function handleTargModel(model, opts, dist, id)
    if Config.UseTarget then
        if GetResourceState('ox_target') == 'started' then
            exports.ox_target:addModel(model, preLindenRage(opts, dist))
        else
            exports['qb-target']:AddTargetModel(model, { options = opts, distance = dist })
        end
    else
        exports.interact:AddModelInteraction({
            model = model,
            offset = vec3(0.0, 0.0, 0.0),
            name = id,
            id = id,
            ignoreLos = true,
            distance = 4.0,
            interactDst = 1.5,
            options = opts
        })
    end
end

function itemLabel(item)
    return Config.Inventory == 'ox' and exports.ox_inventory:Items(item).label or QBCore.Shared.Items[item].label
end

function hasItem(item)
    if Config.Inventory == 'ox' then
        local count = exports.ox_inventory:Search('count', item)
        return count and count > 0
    else
        return QBCore.Functions.HasItem(item)
    end
end

function DisableControls()
    DisableAllControlActions(0)
    EnableControlAction(0, 1, true)
    EnableControlAction(0, 2, true)
    EnableControlAction(0, 245, true)
    EnableControlAction(0, 0, true)
    EnableControlAction(0, 322, true)
    EnableControlAction(0, 288, true)
    EnableControlAction(0, 213, true)
    EnableControlAction(0, 249, true)
    EnableControlAction(0, 46, true)
    EnableControlAction(0, 47, true)
    EnableControlAction(0, 33, true)
    EnableControlAction(0, 32, true)
    EnableControlAction(0, 38, true)
end

function DispatchAlert()
    -- cd dispatch example
    -- local data = exports['cd_dispatch']:GetPlayerInfo()
    -- TriggerServerEvent('cd_dispatch:AddNotification', {
    --     job_table = {'police', 'ambulance'}, 
    --     coords = data.coords,
    --     title = 'Civilian Down',
    --     message = 'A '..data.sex..' is requesting medical at '..data.street, 
    --     flash = 1,
    --     unique_id = data.unique_id,
    --     sound = 1,
    --     blip = { sprite = 431, scale = 1.2, colour = 3, flashes = false, text = '911 - Civilian Down', time = 5, radius = 0, }
    -- })
end

function forceWalkEffect(mins)
    AnimpostfxPlay('DrugsTrevorClownsFight')
    ShakeGameplayCam('DRUNK_SHAKE', 1.5) 
    SetTimeout(mins * 60000, function()
        AnimpostfxStopAll()
        StopGameplayCamShaking(true)
        plyState:set('hasEffect', false, true) -- Must set it to false
    end)
end

function dropBlood(coords)
    -- I grabbed this from qb-ambulancejob incase people still needed it. Will get triggered everytime a blood splat is on the floor.
    -- If you don't want to use this function, you can just leave it empty.
    TriggerServerEvent('evidence:server:CreateBloodDrop', PlayerData.citizenid, PlayerData.metadata.bloodtype, coords)
end

function resetWalkingStyle() -- If you use a walkstyle resource, this gets triggered after the player no longer needs to be walking injured/on revive.
    SetPlayerSprint(cache.playerId, true)
    SetPedMoveRateOverride(cache.ped, 1.0)
    ResetPedMovementClipset(cache.ped)
    ResetPedWeaponMovementClipset(cache.ped)
    ResetPedStrafeClipset(cache.ped)
    -- insert third party walkingstyle export or something here
end

function preventLogging()
    -- This function will be called and is used to prevent death logs. Use case as an example is if you're in pug-paintball or something. See below:
    -- You'll be returning a true value to cancel the logging.
    if GetResourceState('pug-paintball') == 'started' and exports["pug-paintball"]:IsInPaintball() then
        return true -- This is just an example. You can remove this, add your own but keep the return false at the bottom.
    end

    return false
end

function spawnVehicle(model, props, coords) -- You can handle vehicle spawning here however you want. I just did it client-side for now.
    if not IsModelInCdimage(joaat(model)) then
        return error("INVALID SPAWN MODEL/VEHICLE ISN'T STREAMED.")
    end
    lib.requestModel(model, 10000)
    local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, coords.w, true, true)
    TaskWarpPedIntoVehicle(cache.ped, vehicle, -1)
    SetVehicleNumberPlateText(vehicle, 'AMBU'..tostring(math.random(1000, 9999)))
    SetEntityAsMissionEntity(vehicle, true, true)
    if QBCore then
        TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(vehicle))
    end
    SetVehicleFuelLevel(vehicle, 100.0)
    SetModelAsNoLongerNeeded(model)
    if props then
        lib.setVehicleProperties(vehicle, props)
    end
end

AddEventHandler('randol_medical:onPlayerDeath', function()
    -- gets triggered on death.
end)

AddEventHandler('randol_medical:onPlayerLastStand', function()
    -- gets triggered on last stand
end)

AddEventHandler('randol_medical:onCheckIn', function()
    -- Triggered when a player checks in/third eyes a bed.
    TriggerEvent('police:client:DeEscort')
end)

AddEventHandler('randol_medical:onRevive', function()
    TriggerEvent('police:client:DeEscort')
    TriggerServerEvent('evidence:server:RemoveNetPedImpacts') -- R14 Evidence thingy.
end)

RegisterNetEvent('qbx_prison:client:playerJailed', function(minutes)
    if GetInvokingResource() then return end
    plyState:set('jail', minutes > 0, true)
end)

RegisterCommand('emsactions', function()
    if not Config.AmbulanceJobNames[GetPlayerJob()] then return end
    
    -- local menuOptions = {}
    -- menuOptions[#menuOptions+1] = {label = locale('actions_revive'), icon = 'syringe',  close = true} -- selected = 1
    -- menuOptions[#menuOptions+1] = {label = locale('actions_heal'), icon = 'hand-holding-medical',  close = true} -- selected = 2
    -- menuOptions[#menuOptions+1] = {label = locale('actions_view'), icon = 'magnifying-glass',  close = true} -- selected = 3
    -- menuOptions[#menuOptions+1] = {label = locale('manage_checkin_action'), icon = 'toggle-on',  close = true} -- selected = 4
    -- menuOptions[#menuOptions+1] = {label = locale('force_near'), icon = 'person-walking',  close = true} -- selected = 5
    -- lib.registerMenu({
    --     id = 'ems_actions',
    --     title = locale('actions_title'),
    --     position = 'bottom-right',
    --     onSelected = function(selected)
    --         EmsMenu['ems_actions'] = selected
    --     end,
    --     options = menuOptions,
    -- }, function(selected)
    --     if selected == 1 then
    --         reviveNearestPlayer()
    --     elseif selected == 2 then
    --         healNearestPlayer()
    --     elseif selected == 3 then
    --         viewInjuries()
    --     elseif selected == 4 then
    --         toggleCheckins()
    --     elseif selected == 5 then
    --         forceWalkNear()
    --     end
    -- end)
    -- lib.showMenu('ems_actions')

    -- Context Menu version. Comment out the above and uncomment the one below.

    local actions_menu = {
        id = 'ems_actions',
        title = locale('actions_title'),
        options = {
            {
                title = locale('actions_revive'),
                icon = 'syringe',
                onSelect = reviveNearestPlayer,
            },
            {
                title = locale('actions_heal'),
                icon = 'hand-holding-medical',
                onSelect = healNearestPlayer,
            },
            {
                title = locale('actions_view'),
                icon = 'magnifying-glass',
                onSelect = viewInjuries,
            },
            {
                title = locale('manage_checkin_action'),
                icon = 'toggle-on',
                onSelect = toggleCheckins,
            },
            {
                title = locale('force_near'),
                icon = 'person-walking',
                onSelect = forceWalkNear,
            },
        }
    }
    lib.registerContext(actions_menu)
    lib.showContext('ems_actions')
end)
RegisterKeyMapping('emsactions', 'EMS Menu', 'keyboard', Config.ActionsKeybind)

if Config.EnableGlobalPlayerTarget then
    CreateThread(function()
        local opts = {
            {
                num = 1,
                icon = 'fa-solid fa-syringe',
                label = locale('actions_revive'),
                action = function(entity)
                    local serverId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
                    reviveNearestPlayer(serverId)
                end,
                canInteract = function(entity, distance, data)
                    return IsPedAPlayer(entity) and Config.AmbulanceJobNames[GetPlayerJob()] and not plyState.dead and not plyState.laststand
                end,
            },
            {
                num = 2,
                icon = 'fa-solid fa-hand-holding-medical',
                label = locale('actions_heal'),
                action = function(entity)
                    local serverId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
                    healNearestPlayer(serverId)
                end,
                canInteract = function(entity, distance, data)
                    return IsPedAPlayer(entity) and Config.AmbulanceJobNames[GetPlayerJob()] and not plyState.dead and not plyState.laststand
                end,
            },
            {
                num = 3,
                icon = 'fa-solid fa-magnifying-glass',
                label = locale('actions_view'),
                action = function(entity)
                    local serverId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
                    viewInjuries(serverId)
                end,
                canInteract = function(entity, distance, data)
                    return IsPedAPlayer(entity) and Config.AmbulanceJobNames[GetPlayerJob()] and not plyState.dead and not plyState.laststand
                end,
            },
        }
        if GetResourceState('ox_target') == 'started' then
            exports.ox_target:addGlobalPlayer(preLindenRage(opts, 3.0))
        else
            exports['qb-target']:AddGlobalPlayer({ options = opts, distance = 3.0, })
        end
    end)
end

function GetInvPath()
    return Config.Inventory == 'ox' and 'https://cfx-nui-ox_inventory/web/images/%s.png' or 'https://cfx-nui-qb-inventory/html/images/%s.png'
end

function debugShit(msg)
    if not Config.Debug then return end
    print(msg)
end

-- Event handlers if you wanna use radial menu.
AddEventHandler('randol_medical:reviveNearestPlayer', reviveNearestPlayer)
AddEventHandler('randol_medical:healNearestPlayer', healNearestPlayer)
AddEventHandler('randol_medical:viewInjuries', viewInjuries)
AddEventHandler('randol_medical:toggleCheckins', toggleCheckins)
AddEventHandler('randol_medical:forceWalkNear', forceWalkNear)

RegisterNetEvent('hospital:client:Revive', revivePlayer) -- Backwards compat for original qb-ambulance. Comment this out if you don't need it.
RegisterNetEvent('esx_ambulancejob:revive', revivePlayer) -- Backwards compat for ESX. Comment this out if you don't need it.
RegisterNetEvent('qbx_medical:client:playerRevived', revivePlayer) -- Backwards compat for QBX. Comment this out if you don't need it.