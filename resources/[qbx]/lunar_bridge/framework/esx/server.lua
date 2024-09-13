---@diagnostic disable: duplicate-set-field
---@diagnostic disable: duplicate-doc-field

if GetResourceState('es_extended') ~= 'started' then return end

-- This file is loaded directly into other resources, so we need to fetch lunar_bridge's config differently
local function getConfig()
    if not lib then
        error('ox_lib not found! did you modify fxmanifest?')
    end
    
    local oldCfg = _G['Config']
    require '@lunar_bridge.config.config'
    local cfg = _G['Config']
    _G['Config'] = oldCfg

    return cfg
end

local Config = getConfig()

Framework = { name = 'es_extended' }
local sharedObject = exports['es_extended']:getSharedObject()
Framework.object = sharedObject
---@class Player
---@field source number
---@field xPlayer any
local player = {}

---@diagnostic disable-next-line: duplicate-set-field
Framework.getPlayerFromId = function(id)
    local player = setmetatable({}, { __index = player })
    player.xPlayer = sharedObject.GetPlayerFromId(id)
    
    if not player.xPlayer then return end
    
    player.source = id

    return player
end

function Framework.getPlayerFromIdentifier(identifier)
    local player = setmetatable({}, { __index = player })
    player.xPlayer = sharedObject.GetPlayerFromIdentifier(identifier)

    if not player.xPlayer then return end

    player.source = player.xPlayer.source

    return player
end

Framework.registerUsableItem = sharedObject.RegisterUsableItem

Framework.getPlayers = sharedObject.GetExtendedPlayers

local ox_inventory = GetResourceState('ox_inventory') == 'started'
local qs_inventory = GetResourceState('qs-inventory') == 'started'
local codemInventory = GetResourceState('codem-inventory') == 'started'

function Framework.getItemLabel(item)
    if ox_inventory then
        return exports.ox_inventory:Items()[item]?.label
    elseif qs_inventory then
        return exports['qs-inventory']:GetItemList()[item]?.label
    elseif codemInventory then
        return exports['codem-inventory']:GetItemList()[item]?.label
    end

    return sharedObject.GetItemLabel(item)
end

function Framework.getItems()
    if ox_inventory then
        return exports.ox_inventory:Items()
    elseif qs_inventory then
        return exports['qs-inventory']:GetItemList()
    elseif codemInventory then
        return exports['codem-inventory']:GetItemList()
    end

    return exports['es_extended']:getSharedObject().Items
end

function player:hasGroup(name)
    return self.xPlayer.getGroup() == name
end

function player:hasOneOfGroups(groups)
    return groups[self.xPlayer.getGroup()] or false
end

function player:addItem(name, count, metadata)
    count = count or 1

    if not self:canCarryItem(name, count) then
        return false
    end
    
    if codemInventory then
        return exports['codem-inventory']:AddItem(self.source, name, count, nil, metadata)
    elseif ox_inventory then
        return exports.ox_inventory:AddItem(self.source, name, count, metadata)
    else
        self.xPlayer.addInventoryItem(name, count)
        return true
    end
end

function player:removeItem(name, count)
    count = count or 1

    if codemInventory then
        exports['codem-inventory']:RemoveItem(self.source, name, count)
    else
        self.xPlayer.removeInventoryItem(name, count)
    end
end

function player:canCarryItem(name, count)
    return self.xPlayer.canCarryItem(name, count)
end

function player:getItemCount(name)
    if codemInventory then
        return exports['codem-inventory']:GetItemsTotalAmount(self.source, name)
    end

    return self.xPlayer.getInventoryItem(name)?.count or 0
end

function player:hasItem(name)
    return self:getItemCount(name) > 0
end

function player:getAccountMoney(account)
    if Config.BlackMoney and account == Config.BlackMoney.ItemName then
        if not Config.BlackMoney.UsesMetadata then
            return self:getItemCount(account)
        else
            error(('Disable Config.BlackMoney.UsesMetadata in lunar_bridge if you want to use %s as a fully functional account.'):format(account))
        end
    else
        return self.xPlayer.getAccount(account).money
    end
end

function player:addAccountMoney(account, amount)
    if Config.BlackMoney and account == Config.BlackMoney.ItemName then
        if Config.BlackMoney.UsesMetadata then
            self:addItem(account, 1, { worth = amount })
        else
            self:addItem(account, amount)
        end
    else
        self.xPlayer.addAccountMoney(account, amount)
    end
end

function player:removeAccountMoney(account, amount)
    if Config.BlackMoney and account == Config.BlackMoney.ItemName then
        if not Config.BlackMoney.UsesMetadata then
            return self:removeItem(account, amount)
        else
            error(('Disable Config.BlackMoney.UsesMetadata in lunar_bridge if you want to use %s as a fully functional account.'):format(account))
        end
    else
        self.xPlayer.removeAccountMoney(account, amount)
    end
end

function player:getJob()
    return self.xPlayer.getJob().name
end

function player:getJobGrade()
    return self.xPlayer.getJob().grade
end

function player:setJob(name, grade)
    return self.xPlayer.setJob(name, grade)
end

function player:getIdentifier()
    return self.xPlayer.getIdentifier()
end

function player:getFirstName()
    return self.xPlayer.get('firstName')
end

function player:getLastName()
    return self.xPlayer.get('lastName')
end