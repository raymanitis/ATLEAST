function LockpickMinigame()
    if Config.Robbery.LockpickMinigame == 'normal' then
        return exports['lockpick']:startLockpick()
    elseif Config.Robbery.LockpickMinigame == 'quasar' then
        local p = promise.new()
        TriggerEvent('lockpick:client:openLockpick', function(success)
            p:resolve(success)
        end)
        return Citizen.Await(p)
    end
end

function HackingMinigame()
    if Config.Robbery.HackingMinigame == 'howdy-hackminigame' then
        return exports['howdy-hackminigame']:Begin(4, 5000)
    elseif Config.Robbery.HackingMinigame == 'quasar' then
        local p = promise.new()
        exports["memorygame"]:thermiteminigame(10, 3, 3, 10,
            function() -- success
                p:resolve(true)
            end,
            function() -- failure
                p:resolve(false)
            end
        )
        return Citizen.Await(p)
    end
end

local function isStarted(resourceName)
    return GetResourceState(resourceName) == 'started'
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
function GetInventoryIcon(itemName)
    if not path then
        warn('Inventory images path not set in cl_edit.lua!')
        return
    end

    return path:format(itemName) .. '?height=128'
end