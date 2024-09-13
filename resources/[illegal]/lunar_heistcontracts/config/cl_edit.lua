Editable = {}

local function isStarted(resourceName)
    return GetResourceState(resourceName) == 'started'
end

---Used to check if player is dead
---@param ped number
function Editable.isDead(ped)
    return IsEntityDead(ped)
        or IsEntityPlayingAnim(ped, 'dead', 'dead_a', 3)
end

Editable.minigames = {
    ['boosting'] = {
        signal = function()
            return exports.lunar_minigames:keys(18, 10)
        end,
        removeTracker = function()
            return exports.lunar_minigames:sort(5, 25, 25)
        end,
        lockpick = function()
            return exports.lunar_minigames:lockpick(4, 10)
        end
    },
    ['pacific'] = {
        keypad = function()
            return exports.lunar_minigames:pinCracker(4, 45)
        end,
        panelTerminal = function()
            return exports.lunar_minigames:keys(18, 10)
        end,
        computer = function()
            return exports.lunar_minigames:terminal(2, 3, 3, 30)
        end,
        unlockSideVault = function()
            return exports.lunar_minigames:words(20, 20)
        end
    },
    -- ['mazebank'] = {
    --     securityDoor = function()
    --         return exports.lunar_minigames:words(15, 20)
    --     end,
    --     generator = function()
    --         return exports.lunar_minigames:keys(18, 10)
    --     end,
    --     electricBox = function()
    --         return exports.lunar_minigames:sort(4, 16, 16)
    --     end,
    --     laptop = function()
    --         return exports.lunar_minigames:terminal(2, 3, 3, 30)
    --     end,
    --     terminal = function()
    --         return exports.lunar_minigames:terminal(3, 3, 3, 35)
    --     end,
    --     circuitOverload = function()
    --         return exports.lunar_minigames:sort(4, 16, 16)
    --     end,
    --     unlockSafe = function()
    --         return exports.lunar_minigames:lockpick(4, 10)
    --     end
    -- },
    -- ['laundromat'] = {
    --     cutGenerator = function()
    --         return exports.lunar_minigames:keys(18, 10)
    --     end,
    --     loot = function()
    --         return lib.skillCheck({ 'hard' })
    --     end,
    --     -- Door to office with safe
    --     disablePower = function()
    --         return exports.lunar_minigames:keys(18, 10)
    --     end,
    --     unlockSafe = function()
    --         return exports.lunar_minigames:lockpick(5, 15)
    --     end
    -- },
    -- ['cashexchange'] = {
    --     smartLock = function()
    --         return exports.lunar_minigames:keys(18, 10)
    --     end,
    --     electricBox = function()
    --         return exports.lunar_minigames:keys(18, 10)
    --     end,
    --     unlockVault = function()
    --         return exports.lunar_minigames:words(20, 20)
    --     end
    -- },
    ['paleto'] = {
        smartLocks = function()
            return exports.lunar_minigames:sort(4, 16, 16)
        end,
        unlockSurveilance = function()
            return exports.lunar_minigames:keys(18, 10)
        end,
        unlockOffice = function()
            return exports.lunar_minigames:terminal(3, 3, 3, 35)
        end,
        computer = function()
            return exports.lunar_minigames:terminal(2, 3, 3, 30)
        end,
        unlockVault = function()
            return exports.lunar_minigames:words(20, 20)
        end,
        unlockSafe = function()
            return exports.lunar_minigames:lockpick(4, 10)
        end
    },
    ['fleeca'] = {
        thermite = function()
            return exports.lunar_minigames:sort(4, 16, 16)
        end,
        unlockVault = function()
            return exports.lunar_minigames:words(20, 20)
        end,
        unlockInsideDoor = function()
            return exports.lunar_minigames:words(20, 20)
        end
    },
    ['bobcat'] = {
        thermite = function()
            return exports.lunar_minigames:sort(5, 25, 30)
        end,
        keypad = function()
            return exports.lunar_minigames:keys(18, 10)
        end,
    },
    -- ['artasylum'] = {
    --     keypad = function()
    --         return exports.lunar_minigames:pinCracker(4, 45)
    --     end,
    --     securityDoor = function()
    --         return exports.lunar_minigames:words(15, 20)
    --     end,
    --     electricBox = function()
    --         return exports.lunar_minigames:sort(4, 16, 16)
    --     end,
    --     activateDecryption = function()
    --         return exports.lunar_minigames:terminal(3, 3, 3, 30)
    --     end,
    --     decryptCode = function()
    --         return exports.lunar_minigames:sort(5, 25, 25)
    --     end,
    --     unlockSafe = function()
    --         return exports.lunar_minigames:lockpick(4, 10)
    --     end,
    --     noiseSensor = function()
    --         return exports.lunar_minigames:terminal(3, 3, 3, 30)
    --     end
    -- }
}

-- OTHER EDITABLE FUNCTIONS

function Editable.addKeys(plate)
    if GetResourceState('qb-vehiclekeys') == 'started' then
        TriggerEvent("vehiclekeys:client:SetOwner", plate)
    end
end

function Editable.draw3DText(coords, text)
    SetTextScale(0.4, 0.35)
    SetTextFont(4)
    SetTextProportional(true)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z, false)
    local factor = (string.len(text)) / 250
    DrawRect(0.0, 0.0125, 0.003 + factor, 0.03, 0, 0, 0, 150)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

-- Used mainly during minigames
function Editable.setInventoryBusy(busy)
    if isStarted('ox_inventory') then
        LocalPlayer.state:set('invBusy', busy, false)
    end
end

---@type string
local path

if isStarted('ox_inventory') then
    path = 'nui://ox_inventory/web/images/%s.png'
elseif isStarted('qb-inventory') then
    path = 'nui://qb-inventory/html/images/%s.png'
elseif isStarted('ps-inventory') then
    path = 'nui://ps-inventory/html/images/%s.png'
elseif isStarted('lj-inventory') then
    path = 'nui://lj-inventory/html/images/%s.png'
elseif isStarted('qs-inventory') then
    path = 'nui://qs-inventory/html/images/%s.png' -- Not really sure
end

---Returns the NUI path of an icon.
---@param itemName string
---@return string?
---@diagnostic disable-next-line: duplicate-set-field
function Editable.getInventoryIcon(itemName)
    if not path then
        warn('Inventory images path not set in cl_edit.lua!')
        return
    end

    return path:format(itemName) .. '?height=128'
end

---@param items ShopSellItem[]
---@return ShopSellItem[]
function Editable.filterItemsInInventory(items)
    local filtered = {}

    for i = 1, #items do
        local item = items[i]

        if Framework.hasItem(item.name) then
            filtered[#filtered + 1] = item
        end
    end

    return filtered
end