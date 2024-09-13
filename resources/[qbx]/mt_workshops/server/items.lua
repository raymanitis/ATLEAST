for k, v in pairs(Config.performance) do
    if Config.framework == 'qb' then
        Config.core.Functions.CreateUseableItem(v.item, function(source, item)
            local src = source
            local Player = Config.core.Functions.GetPlayer(src)
            if not Player.Functions.GetItemBySlot(item.slot) then return end
            lib.callback.await('mt_workshops:client:usePerformanceItem', src, v.modType, v.item, v.level, v.class)
        end)
    elseif Config.framework == 'qbx' then
        exports.qbx_core:CreateUseableItem(v.item, function(source, item)
            local src = source
            local Player = exports.qbx_core:GetPlayer(src)
            if not Player.Functions.GetItemBySlot(item.slot) then return end
            lib.callback.await('mt_workshops:client:usePerformanceItem', src, v.modType, v.item, v.level, v.class)
        end)
    elseif Config.framework == 'esx' then
        Config.core.RegisterUsableItem(v.item, function(source, item)
            local src = source
            lib.callback.await('mt_workshops:client:usePerformanceItem', src, v.modType, v.item, v.level, v.class)
        end)
    end
end

if Config.framework == 'qb' and Config.inventory ~= 'ox_inventory' then
    Config.core.Functions.CreateUseableItem('mods_list', function(source, item)
        local src = source
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player.Functions.GetItemBySlot(item.slot) then return end
        lib.callback.await('mt_workshops:client:useModsList', src, nil, item)
    end)

    Config.core.Functions.CreateUseableItem('mechanic_toolbox', function(source, item)
        local src = source
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player.Functions.GetItemBySlot(item.slot) then return end
        lib.callback.await('mt_workshops:client:openToolboxMenu', src)
    end)

    Config.core.Functions.CreateUseableItem('neons_controller', function(source, item)
        local src = source
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player.Functions.GetItemBySlot(item.slot) then return end
        lib.callback.await('mt_workshops:client:openLightsController', src)
    end)

    Config.core.Functions.CreateUseableItem('extras_controller', function(source, item)
        local src = source
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player.Functions.GetItemBySlot(item.slot) then return end
        lib.callback.await('mt_workshops:client:openExtrasMenu', src)
    end)

    Config.core.Functions.CreateUseableItem('engine_repair_kit', function(source, item)
        local src = source
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player.Functions.GetItemBySlot(item.slot) then return end
        lib.callback.await('mt_workshops:client:useRepairKit', src, 'engine')
    end)

    Config.core.Functions.CreateUseableItem('body_repair_kit', function(source, item)
        local src = source
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player.Functions.GetItemBySlot(item.slot) then return end
        lib.callback.await('mt_workshops:client:useRepairKit', src, 'body')
    end)
elseif Config.framework == 'qb' and Config.inventory == 'ox_inventory' then
    Config.core.Functions.CreateUseableItem('engine_repair_kit', function(source, item)
        local src = source
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player.Functions.GetItemBySlot(item.slot) then return end
        lib.callback.await('mt_workshops:client:useRepairKit', src, 'engine')
    end)

    Config.core.Functions.CreateUseableItem('body_repair_kit', function(source, item)
        local src = source
        local Player = Config.core.Functions.GetPlayer(src)
        if not Player.Functions.GetItemBySlot(item.slot) then return end
        lib.callback.await('mt_workshops:client:useRepairKit', src, 'body')
    end)
elseif Config.framework == 'qbx' then
    exports.qbx_core:CreateUseableItem('engine_repair_kit', function(source, item)
        local src = source
        local Player = exports.qbx_core:GetPlayer(src)
        if not Player.Functions.GetItemBySlot(item.slot) then return end
        lib.callback.await('mt_workshops:client:useRepairKit', src, 'engine')
    end)

    exports.qbx_core:CreateUseableItem('body_repair_kit', function(source, item)
        local src = source
        local Player = exports.qbx_core:GetPlayer(src)
        if not Player.Functions.GetItemBySlot(item.slot) then return end
        lib.callback.await('mt_workshops:client:useRepairKit', src, 'body')
    end)
elseif Config.framework == 'esx' then
    Config.core.RegisterUsableItem('engine_repair_kit', function(source, item)
        local src = source
        lib.callback.await('mt_workshops:client:useRepairKit', src, 'engine')
    end)

    Config.core.RegisterUsableItem('body_repair_kit', function(source, item)
        local src = source
        lib.callback.await('mt_workshops:client:useRepairKit', src, 'body')
    end)
end