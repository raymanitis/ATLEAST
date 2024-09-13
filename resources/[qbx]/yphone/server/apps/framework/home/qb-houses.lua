CreateThread(function()
    if Config.Housing ~= 'qb-houses' or Config.Framework ~= 'qb' then return end

    debugPrint("Using qb-houses")

    lib.callback.register('yseries:server:home:get', function(source)
        local playerId = Framework.GetPlayerFromId(source)?.identifier

        if (not playerId) then
            debugPrint('Home: Could not get player id')
            return
        end

        local propertiesResult = MySQL.query.await([[
            SELECT
                hl.id,
                hl.coords,
                hl.label,
                hl.name,
                hl.owned,
                hl.price,
                hl.tier,
                ph.citizenid,
                ph.identifier,
                ph.keyholders,
                ph.house
            FROM
                player_houses AS ph
            INNER JOIN houselocations AS hl
            ON
                ph.house = hl.name
            WHERE
                ph.citizenid = ?
            ]],
            { playerId })

        return propertiesResult
    end)

    lib.callback.register('yseries:server:home:get-key-holders-details', function(_, keyHolders)
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
    end)

    lib.callback.register('yseries:server:home:remove-key-holder',
        function(_, data)
            local affectedRows = MySQL.update.await('UPDATE player_houses SET `keyholders` = ? WHERE house = ?',
                { json.encode(data.newKeyHolders), data.house })

            if affectedRows > 0 then
                return true
            else
                return false
            end
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

        local affectedRows = MySQL.update.await('UPDATE player_houses SET `keyholders` = ? WHERE house = ?',
            { json.encode(keyholders), data.houseId })

        if affectedRows > 0 then
            return {
                success = true,
                newKeyholders = keyholders,
            }
        else
            return {
                success = false,
            }
        end
    end)
end)
