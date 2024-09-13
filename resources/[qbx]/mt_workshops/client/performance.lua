openPerformanceMenu = function()
    if not insideZone[getPlayerJob()] then notify(locale('notify_error_inside_zone'), 'error') return end
    local vehicle = getClosestVehicle()
    if not vehicle then notify(locale('notify_error_no_vehicle'), 'error') return end
    local installedParts = {}
    for km, vm in pairs(Config.performance) do
        if (Config.useClasses and (getVehicleClass(vehicle) == vm.class)) or (not Config.useClasses) then
            SetVehicleModKit(vehicle, 0)
            local modLevel = (vm.level == 'max') and (GetNumVehicleMods(vehicle, vm.modType) - 1) or vm.level
            if GetVehicleMod(vehicle, vm.modType) == modLevel or (vm.modType == 18 and IsToggleModOn(vehicle, 18)) then
                installedParts[#installedParts + 1] = { item = vm.item, label = getItemData(vm.item).label, mod = vm.modType }
            end
        end
    end
    SendNUI('performanceMenu', { installedParts = installedParts, inventoryDirectory = Config.inventoryDirectory })
    ShowNUI('setVisiblePerformanceMenu', true)
end

lib.callback.register('mt_workshops:client:usePerformanceItem',  function(modType, item, level, class)
    if not insideZone[getPlayerJob()] then notify(locale('notify_error_inside_zone'), 'error') return end
    local vehicle = getClosestVehicle()
    if not vehicle then notify(locale('notify_error_no_vehicle'), 'error') return end
    if not ((Config.useClasses and (getVehicleClass(vehicle) == class)) or (not Config.useClasses)) then notify(locale('notify_error_wrong_class'), 'error') return end
    loadAnimDict("rcmnigel3_trunk")
    TaskPlayAnim(cache.ped, "rcmnigel3_trunk", "out_trunk_trevor", 8.0, 8.0, 2000, 1, 0.0, 0, 0, 0)
    Wait(2000)
    SetVehicleDoorOpen(vehicle, 4, true, true)
    if progressBar(locale('progress_mod'), Config.times.installingMod, { car = true, walk = true }, { dict = 'mini@repair', clip = 'fixing_a_ped', flag = 6 }, { model = `w_me_wrench`, pos = vec3(0.071, -0.017, 0.036), rot = vec3(-121.24, -10.43, 6.64) }) then
        SetVehicleModKit(vehicle, 0)
        local modLevel = (level == 'max') and (GetNumVehicleMods(vehicle, modType) - 1) or level
        TriggerServerEvent('mt_workshops:server:setVehicleMod', VehToNet(vehicle), modType, modLevel, cache.serverId)
        lib.callback.await('mt_workshops:server:removeItem', false, item, 1)
        notify(locale('notify_installed_mod'), 'success')
    end
    loadAnimDict("rcmepsilonism8")
    TaskPlayAnim(cache.ped, "rcmepsilonism8", "bag_handler_close_trunk_walk_left", 8.0, 8.0, 2500, 1, 0.0, 0, 0, 0)
    Wait(2500)
    SetVehicleDoorShut(vehicle, 4, true)
end)

RegisterNuiCallback('removePerformance', function(data, cb)
    ShowNUI('setVisiblePerformanceMenu', false)
    local vehicle = getClosestVehicle()
    if not vehicle then notify(locale('notify_error_no_vehicle'), 'error') cb(true) return end
    loadAnimDict("rcmnigel3_trunk")
    TaskPlayAnim(cache.ped, "rcmnigel3_trunk", "out_trunk_trevor", 8.0, 8.0, 2000, 1, 0.0, 0, 0, 0)
    Wait(2000)
    SetVehicleDoorOpen(vehicle, 4, true, true)
    if progressBar(locale('progress_remove_mod'), Config.times.removingMod, { car = true, walk = true }, { dict = 'mini@repair', clip = 'fixing_a_ped', flag = 6 }, { model = `w_me_wrench`, pos = vec3(0.071, -0.017, 0.036), rot = vec3(-121.24, -10.43, 6.64) }) then
        TriggerServerEvent('mt_workshops:server:setVehicleMod', VehToNet(vehicle), data.mod, -1, cache.serverId)
        if Config.givePerformanceItems then lib.callback.await('mt_workshops:server:addItem', false, data.item, 1) end
    end
    loadAnimDict("rcmepsilonism8")
    TaskPlayAnim(cache.ped, "rcmepsilonism8", "bag_handler_close_trunk_walk_left", 8.0, 8.0, 2500, 1, 0.0, 0, 0, 0)
    Wait(2500)
    SetVehicleDoorShut(vehicle, 4, true)
    openPerformanceMenu()
    cb(true)
end)

RegisterNetEvent('mt_workshops:client:setVehicleMod', function(vehicle, modType, modLevel, player)
    if not NetworkDoesEntityExistWithNetworkId(vehicle) then return end
    if modType == 18 then
        ToggleVehicleMod(NetToVeh(vehicle), modType, (modLevel ~= -1) and true or false)
    else
        SetVehicleMod(NetToVeh(vehicle), modType, modLevel, false)
    end
    if cache.serverId == player then
        lib.callback.await('mt_workshops:server:saveVehicleMods', false, NetToVeh(vehicle), getVehicleMods(NetToVeh(vehicle)))
    end
end)