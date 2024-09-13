AddEventHandler('txAdmin:events:healedPlayer', function(eventData)
    if GetInvokingResource() ~= 'monitor' or type(eventData) ~= 'table' or type(eventData.id) ~= 'number' then
        return
    end
    
    TriggerClientEvent('randol_medical:client:revivePlayer', eventData.id)
end)

function AllowedToPermaCharacters(cid)
    if not cid then return false end
    return Server.PermaWhitelistCids[cid]
end

function clearInventory(player, keep)
    local src = GetPlayerSource(player)
    if Config.Inventory == 'ox' then
        exports.ox_inventory:ClearInventory(src, keep)
    elseif Config.Inventory == 'qb' then
        exports[Config.InvResourceName]:ClearInventory(src, keep)
    end
end

function AddItem(src, item, amount, slot, info)
    if Config.Inventory == 'ox' then
        exports.ox_inventory:AddItem(src, item, amount, info, slot)
    elseif Config.Inventory == 'qb' then
        exports[Config.InvResourceName]:AddItem(src, item, amount, slot, info)
        if isNewQB then
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
        else
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
        end
    end
end

function RemoveItem(src, item, amount, slot)
    if Config.Inventory == 'ox' then
        exports.ox_inventory:RemoveItem(src, item, amount, nil, slot)
    elseif Config.Inventory == 'qb' then
        exports[Config.InvResourceName]:RemoveItem(src, item, amount, slot)
        if isNewQB then
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove', amount)
        else
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove', amount)
        end
    end
end

function itemLabel(item)
    return Config.Inventory == 'ox' and exports.ox_inventory:Items(item).label or QBCore.Shared.Items[item].label
end

function hasItem(src, item)
    if Config.Inventory == 'ox' then
        local count = exports.ox_inventory:Search(src, 'count', item)
        return count and count > 0
    else
        return QBCore.Functions.HasItem(src, item)
    end
end

function PayForRevive(src)
    -- You can use this to pay the player or send it to a business account.
    local player = GetPlayer(src)
    if not player then return end

    addMoney(player, 'bank', Server.PayPerRevive.amount)
    DoNotification(src, ('You received $%s for treating the patient.'):format(Server.PayPerRevive.amount))
end

function PayForHeal(src)
    -- You can use this to pay the player or send it to a business account.
    local player = GetPlayer(src)
    if not player then return end

    addMoney(player, 'bank', Server.PayPerHeal.amount)
    DoNotification(src, ('You received $%s for treating the patient.'):format(Server.PayPerHeal.amount))
end

RegisterNetEvent('prison:server:SetJailStatus', function(jailTime)
     -- [Experimental] Using this qb-prison server event to set player state for in prison so I can tell where to respawn them.
     -- May need to adapt to third party prison resources.
    local src = source
    if jailTime > 0 then
        Player(src).state:set('jail', true, true)
    else
        Player(src).state:set('jail', false, true)
    end
end)

lib.addCommand('kill', { help = 'Kill player.', params = { { name = 'target', type = 'playerId', help = 'ID of the player.', optional = true}}, restricted = 'group.admin'}, function(source, args)
    local src = source
    if args and args.target then
        local Player = GetPlayer(args.target)
        if Player then
            TriggerClientEvent('randol_medical:client:killPlayer', args.target)
        end
    else
        TriggerClientEvent('randol_medical:client:killPlayer', src)
    end
end)

lib.addCommand('revive', { help = 'Revive a player', params = { { name = 'target', type = 'playerId', help = 'ID of the player.', optional = true}}, restricted = 'group.admin'}, function(source, args)
    local src = source
    if args and args.target then
        local Player = GetPlayer(args.target)
        if Player then
            TriggerClientEvent('randol_medical:client:revivePlayer', args.target)
        end
    else
        TriggerClientEvent('randol_medical:client:revivePlayer', src)
    end
end)

lib.addCommand('reviveall', { help = 'Revive all players', restricted = 'group.admin', }, function(source, args)
    TriggerClientEvent('randol_medical:client:revivePlayer', -1)
end)

lib.addCommand('revivenear', { help = 'Revive nearby players', params = { { name = 'radius', type = 'number', help = 'Radius to revive.', optional = false}}, restricted = 'group.admin'}, function(source, args)
    local src = source
    if args and args.radius then
        local coords = GetEntityCoords(GetPlayerPed(src))
        local plys = getPlayersNearby(coords, args.radius)
        if #plys > 0 then
            for i = 1, #plys do
                TriggerClientEvent('randol_medical:client:revivePlayer', plys[i])
            end
        end
    end
end)

-- qbx_medical server exports compat.
AddEventHandler(('__cfx_export_%s_%s'):format('qbx_medical', 'Revive'), function(cb)
    cb(revivePlayer)
end)

AddEventHandler(('__cfx_export_%s_%s'):format('qbx_medical', 'Heal'), function(cb)
    cb(healWounds)
end)