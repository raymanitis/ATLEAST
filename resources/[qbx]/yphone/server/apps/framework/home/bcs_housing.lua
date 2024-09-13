CreateThread(function()
    if Config.Housing ~= 'bcs_housing' then return end

    debugPrint("Using bcs_housing")

    lib.callback.register('yseries:server:home:get', function(source)
        local ownedHomes = {}
        local playerId = Framework.GetPlayerFromId(source)?.identifier
        local result = exports.bcs_housing:GetOwnedHomes(playerId)
        for _, v in pairs(result) do
            local keys = {}
            local holders = exports.bcs_housing:GetKeyHolders(v.identifier)
            for _, v in pairs(holders) do
                table.insert(keys, v.identifier)
            end
            table.insert(ownedHomes, {
                id = v.identifier,
                citizenid = v.owner,
                coords = { enter = v.entry },
                house = v.identifier,
                identifier = v.owner,
                keyholders = keys,
                label = v.name,
                name = v.name,
                owned = true,
                price = v.price,
                tier = v.type,
            })
        end
        return ownedHomes
    end)

    lib.callback.register('yseries:server:home:get-key-holders-details', function(_, keyHolders)
        if (Config.Framework == 'qb') then
            local charinfoData = {}

            for _, citizenid in ipairs(keyHolders) do
                local query = MySQL.query.await('SELECT charinfo FROM players WHERE citizenid = ?', { citizenid })

                if query[1]?.charinfo then
                    local charInfo = json.decode(query[1].charinfo)

                    table.insert(charinfoData, {
                        citizenid = citizenid,
                        name = charInfo?.firstname .. ' ' .. charInfo?.lastname,
                    })
                end
            end

            return charinfoData
        elseif Config.Framework == 'esx' then
            local charinfoData = {}

            for _, citizenid in ipairs(keyHolders) do
                local query = MySQL.single.await('SELECT firstname, lastname FROM users WHERE identifier = ?',
                    { citizenid })

                if query and query.firstname then
                    table.insert(charinfoData, {
                        citizenid = citizenid,
                        name = query.firstname .. ' ' .. query.lastname,
                    })
                end
            end

            return charinfoData
        end
    end)

    lib.callback.register('yseries:server:home:remove-key-holder',
        function(_, data)
            local holders = exports.bcs_housing:GetKeyHolders(data.house)
            local TargetIdentifier
            for _, v in pairs(holders) do
                local found = false
                for _, val in pairs(data.newKeyHolders) do
                    if v.identifier == val then
                        found = true
                        break
                    end
                end
                if not found then
                    TargetIdentifier = v.identifier
                    break
                end
            end
            exports.bcs_housing:RemoveKey(data.house, TargetIdentifier)
            return true
        end)

    lib.callback.register('yseries:server:home:add-key-holder', function(_, data)
        local targetSource = tonumber(data.targetSource)
        local playerId = Framework.GetPlayerFromId(targetSource)?.identifier

        if (not playerId) then
            debugPrint('Home: Could not get player id')
            return false
        end

        -- Check if the player already exists in the array
        for _, id in ipairs(data.currentKeyholders) do
            if id == playerId then
                return {
                    success = false,
                }
            end
        end

        local keyholders = data.currentKeyholders
        keyholders[#keyholders + 1] = playerId

        exports.bcs_housing:GiveKey(data.houseId, targetSource)

        return {
            success = true,
            newKeyholders = keyholders,
        }
    end)
end)
