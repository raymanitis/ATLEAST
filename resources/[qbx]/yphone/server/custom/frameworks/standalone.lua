CreateThread(function()
    if Config.Framework ~= 'standalone' then return end

    Framework = {
        GetPlayerFromId = function(source)
            local xPlayer = {}
            ---------
            xPlayer.source = source
            ---------
            xPlayer.identifier = function()
                for _, v in pairs(GetPlayerIdentifiers(source)) do
                    if v:sub(1, #"license:") == "license:" then
                        return v
                    end
                end
            end
            ---------
            xPlayer.getName = function()
                return GetPlayerName(source)
            end
            ---------
            xPlayer.addAccountMoney = function(type, money, reason)
            end
            ---------
            xPlayer.getAccount = function(type)
                return {
                    money = 0
                }
            end
            ---------
            xPlayer.removeAccountMoney = function(type, money, reason)
            end
            return xPlayer
        end,
        GetPlayerFromIdentifier = function(identifier)
            -- Iterate over all connected players
            for _, player in ipairs(GetPlayers()) do
                -- Get all identifiers for the current player
                local playerIdentifiers = GetPlayerIdentifiers(player)
                for _, id in pairs(playerIdentifiers) do
                    if id == identifier then
                        -- If the identifier matches, return the player's server ID (source)
                        return player
                    end
                end
            end

            return nil -- Return nil if no player with the given identifier is found
        end,
    }

    RegisterNetEvent('yseries:standalone:request-player-ident')
    AddEventHandler('yseries:standalone:request-player-ident', function()
        local playerSource = source

        local playerIdent = Framework.GetPlayerFromId(playerSource)?.identifier

        TriggerClientEvent('yseries:standalone:receive-player-ident', playerSource, playerIdent)
    end)

    function GetPlayerSourceFromIdentifier(identifier)
        -- Iterate over all connected players
        for _, player in ipairs(GetPlayers()) do
            -- Get all identifiers for the current player
            local playerIdentifiers = GetPlayerIdentifiers(player)
            for _, id in pairs(playerIdentifiers) do
                if id == identifier then
                    -- If the identifier matches, return the player's server ID (source)
                    return player
                end
            end
        end

        return nil -- Return nil if no player with the given identifier is found
    end

    -- Garage App
    function GetPlayerVehicles(source)
        return {}
    end

    -- Garage App


    function GetOfflineCharacterName()
        return 'Unknown'
    end

    -- * Get an array of all players with a certain job.
    function GetEmployees(job)
        return {}
    end

    -- * Refresh the online status of all companies.
    function RefreshCompanies()
        return {}
    end
end)
