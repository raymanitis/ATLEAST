if Config.Companies.Banking ~= 'renewed-banking' then return end

lib.callback.register('yseries:server:banking:get-balance', function(source)
    local player = Framework.GetPlayerFromId(source)
    local playerJob = player?.job.name
    local balance = exports['Renewed-Banking']:getAccountMoney(playerJob)

    return balance or 0
end)

lib.callback.register('yseries:server:banking:deposit', function(source, amount)
    local player = Framework.GetPlayerFromId(source)
    if not player then
        return false, 'Player not found'
    end

    local isboss = player.job.isboss or player.getJob().grade_name == 'boss'
    local accountName = player.job.name
    if not isboss then
        return false, 'Only the boss can deposit money'
    end

    local currentAmountPlayer = player.getAccount('bank').money
    if currentAmountPlayer < amount then
        return false, 'Insufficient funds'
    end

    local currentBalance = exports['Renewed-Banking']:getAccountMoney(accountName)
    if not currentBalance then
        return false, 'Failed to retrieve current balance'
    end

    local depositSuccess = exports['Renewed-Banking']:addAccountMoney(accountName, amount)
    if not depositSuccess then
        return false, 'Deposit failed'
    end

    player.removeAccountMoney('bank', amount, 'app-phone')
    exports['Renewed-Banking']:handleTransaction(
        accountName,
        'Deposit to work account',
        amount,
        'Deposit made to work account via phone app', 'Work System',
        player.getName(),
        'deposit'
    )

    return true
end)

lib.callback.register('yseries:server:banking:withdraw', function(source, amount)
    local player = Framework.GetPlayerFromId(source)
    if not player then
        return false, 'Player not found'
    end

    local isboss = player.job.isboss or player.getJob().grade_name == 'boss'
    local accountName = player.job.name
    if not isboss then
        return false, 'Only the boss can withdraw money'
    end

    local currentBalance = exports['Renewed-Banking']:getAccountMoney(accountName)
    if not currentBalance then
        return false, 'Failed to retrieve current balance'
    end
    if currentBalance < amount then
        return false, 'Insufficient funds'
    end

    local withdrawSuccess = exports['Renewed-Banking']:removeAccountMoney(accountName, amount)
    if not withdrawSuccess then
        return false, 'Withdrawal failed'
    end

    player.addAccountMoney('bank', amount, 'app-phone')
    exports['Renewed-Banking']:handleTransaction(
        accountName,
        'Withdrawal from work account',
        -amount,
        'Withdrawal made from work account via phone app',
        'Work System',
        player.getName(),
        'withdraw'
    )

    return true
end)
