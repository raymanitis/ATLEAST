local utils = {}

lib.locale()

local keyRing = GetConvarInt('vehiclekeys_keyring', 0) == 1

local useItems = require 'data'.useKeyItem
local ox_inventory = exports.ox_inventory

local playerKeys = {}

function utils.formatPlate(string)
    return string and string:gsub('^%s*(.-)%s*$', '%1')
end

function utils.getEntityFromNetId(netId)
    local entity = netId and NetworkGetEntityFromNetworkId(netId) or 0

    return DoesEntityExist(entity) and entity or 0
end

function utils.notify(source, notiType, message)
    TriggerClientEvent('ox_lib:notify', source, { type = notiType, description = message })
end

local function hasKeyInKeyRing(source, plate)
    local keyRingSlots = keyRing and exports.ox_inventory:GetSlotsWithItem(source, 'keyring')

    if keyRingSlots then
        for i = 1, #keyRingSlots do
            local item = keyRingSlots[i]

            local container = exports.ox_inventory:GetContainerFromSlot(source, item.slot)

            if container and next(container) then
                local hasKey = ox_inventory:GetItemCount(container.id, 'vehiclekey', { plate = plate }, true) > 0

                if hasKey then
                    return true
                end
            end
        end
    end

    return false
end

function utils.removeKey(source, plate)
    if not source or not plate then return end

    plate = utils.formatPlate(plate)

    if not useItems then
        local charId = Renewed.getCharId(source)

        if not charId then return false end

        if playerKeys[charId] and playerKeys[charId][plate] then
            playerKeys[charId][plate] = nil
        else
            return false
        end

        TriggerClientEvent('Renewed-Vehiclekeys:client:syncKeys', source, playerKeys[charId])

        return true
    end

    return ox_inventory:RemoveItem(source, 'vehiclekey', 1, { plate = plate })
end

exports('removeKey', utils.removeKey)


function utils.hasKey(source, plate)
    if not source or not plate then return end

    plate = utils.formatPlate(plate)

    if not useItems then
        local charId = Renewed.getCharId(source)

        if not charId then return false end

        return playerKeys[charId] and playerKeys[charId][plate] or false
    end

    return hasKeyInKeyRing(source, plate) or ox_inventory:GetItemCount(source, 'vehiclekey', { plate = plate }, true) > 0
end

exports('hasKey', utils.hasKey)


function utils.addKey(source, plate)
    if not source or not plate then return end

    plate = utils.formatPlate(plate)

    if not useItems then
        local charId = Renewed.getCharId(source)

        if charId then
            if not playerKeys[charId] then
                playerKeys[charId] = {}
            end

            utils.notify(source, 'success', locale('recieved_keys'))

            playerKeys[charId][plate] = true

            TriggerClientEvent('Renewed-Vehiclekeys:client:syncKeys', source, playerKeys[charId])

            return true
        end

        return false
    end

    return ox_inventory:AddItem(source, 'vehiclekey', 1, { plate = plate })
end

exports('addKey', utils.addKey)

function utils.getKeys(source)
    local charId = Renewed and Renewed.getCharId(source)

    return charId and playerKeys[charId] or {}
end

function utils.hasItem(source, item, slot)
    local invItem = ox_inventory:Search(source, 'slots', item)

    if not next(invItem) then return false end

    if slot then
        for i = 1, #invItem do
            if invItem[i].slot == slot then
                return invItem[i]
            end
        end
    end

    return invItem[1]
end

function utils.setDurability(source, slot, durability)
    ox_inventory:SetDurability(source, slot, durability)
end

function utils.removeItem(source, item, slot)
    ox_inventory:RemoveItem(source, item, 1, nil, slot)
end


return utils