local QBCore = exports['qb-core']:GetCoreObject()

--- Returns the amount of cops online and on duty
--- @return amount number - amount of cops
local GetCopCount = function()
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for _, Player in pairs(players) do
        if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    return amount
end

--- Calculates the amount of cash rolls to launder
--- @return retval number - amount
local GetLaunderAmount = function()
    local cops = GetCopCount()
    if cops > 10 then cops = 10 end -- cap at 10 cops for no insane returns
    local min = 300 + (cops * 100) -- 300 base + 100 per cop minimum
    local max = 600 + (cops * 190) -- 600 base + 190 per cop minimum
    local retval = math.random(min, max)
    return retval
end

lib.callback.register('qb-oxyruns:server:Reward', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        -- Cash
        local cash = math.random(250, 300)
        Player.Functions.AddMoney("cash", cash, "oxy-money")

        -- Launder
        local launder = math.random(100)
        local item = Player.Functions.GetItemByName(Config.LaunderItem)
        if item and launder <= Config.LaunderChance then
            local amount = item.amount
            local removeAmount = GetLaunderAmount()
            if removeAmount > amount then removeAmount = amount end
            Player.Functions.RemoveItem(Config.LaunderItem, removeAmount)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.LaunderItem], "remove", removeAmount)
            Wait(250)
            Player.Functions.AddMoney('cash', removeAmount, 'oxy-launder')
            TriggerClientEvent('QBCore:Notify', source, "Jūs esat atmazgājis daļu naudas..", "success", 2500)
        end

        -- Oxy
        local oxy = math.random(100)
        if oxy <= Config.OxyChance then
            Player.Functions.AddItem(Config.OxyItem, 1, false)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.OxyItem], "add", 1)
        end

        -- Rare loot
        local rareLoot = math.random(100)
        if rareLoot <= Config.RareLoot then
            Player.Functions.AddItem(Config.RareLootItem, 1, false)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.RareLootItem], "add", 1)
        end
        
        -- Callback with result if needed
        cb(true)
    else
        cb(false)
    end
end)


QBCore.Functions.CreateCallback('qb-oxyruns:server:StartOxy', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.money.cash >= Config.StartOxyPayment then
        local amount = GetCopCount()
        if amount >= Config.MinCops then
            Player.Functions.RemoveMoney('cash', Config.StartOxyPayment, "oxy start")
            cb(true)
        else
            TriggerClientEvent('QBCore:Notify', src, "Nav pietiekami policistu maiņā..", "error",  2500)
            cb(false)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Jums nav pietiekami daudz naudas, lai sāktu oxyrun..", "error",  3500)
        cb(false)
    end
end)
