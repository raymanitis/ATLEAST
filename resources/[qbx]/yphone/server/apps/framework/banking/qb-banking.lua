if Config.Framework == 'qb' and Config.Companies.Banking == 'qb-banking' then
    local Framework = exports['qb-core']:GetCoreObject()

    lib.callback.register('yseries:server:banking:get-balance', function(source)
        local src = source
        local Player = Framework.Functions.GetPlayer(src)

        if not Player.PlayerData.job.isboss then return 0 end

        local balance = MySQL.query.await('SELECT account_balance FROM bank_accounts WHERE account_name = ?',
            { Player.PlayerData.job.name })

        return balance[1]?.account_balance or 0
    end)
end

