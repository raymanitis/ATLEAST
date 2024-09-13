-- Implement your own crypto price calculation
-- Config.Crypto.OverridePriceCalculation needs to be true
function GetCryptoPrice()
    return 1000
end

function GetLastCryptoPrice()
    return 1000
end

-- Player max warehouse count
---@param player Player
function CanPlayerBuy(player)
    if Config.MaxWarehouses == -1 then
        return true
    end

    local identifier = player:getIdentifier()
    local count = 0
    
    for _, warehouse in pairs(Warehouses.data) do
        if warehouse.identifier == identifier then
            count += 1
        end
    end

    return count < Config.MaxWarehouses
end

---@param source integer
---@param player Player
---@param amount integer
function WithdrawCrypto(source, player, amount)
    -- Add your code here if you're using withdrawing instead of selling crypto
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

function SendAlertToWebhook(webhook)
    local connect = {
        {
            ["color"] = "16073282",
            ["title"] = locale('warehouse_alarm'),
            ["description"] = locale('warehouse_alarm_desc'),
            ["footer"] = {
                ["text"] = os.date('%H:%M - %d. %m. %Y', os.time())
            },
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end,
        'POST', json.encode({ username = locale('alarm_system'), embeds = connect }), { ['Content-Type'] = 'application/json' })
end

MySQL.ready(function()
    MySQL.query([[
        CREATE TABLE IF NOT EXISTS `lunar_cryptomining` (
          `identifier` varchar(60) DEFAULT NULL,
          `name` varchar(20) DEFAULT NULL,
          `data` longtext DEFAULT NULL,
          UNIQUE KEY `identifier` (`identifier`,`name`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
    ]])
end)