CreateThread(function()
    if Config.Housing ~= 'flight-housing' or Config.Framework ~= 'qb' then return end

    debugPrint("Using flight-housing")

    lib.callback.register('yseries:server:home:get', function(source)
        local playerId = Framework.GetPlayerFromId(source)?.identifier

        if (not playerId) then
            debugPrint('Home: Could not get player id')
            return
        end

        local housesResult = MySQL.query.await([[
            SELECT p.id as id,
                   p.identifier as citizenid,
                   CONCAT('{"x":',JSON_EXTRACT(p.doorsdata, '$.coords.x'),', "y":',JSON_EXTRACT(p.doorsdata, '$.coords.y'),'}') as coords,
                   CONCAT('{"x":',JSON_EXTRACT(p.garageCoords, '$.x'),', "y":',JSON_EXTRACT(p.garageCoords, '$.y'),'}') as garage,
                   p.address AS house,
                   pl.license as identifier,
                   p.keydata as keyholders,
                   p.address as label,
                   p.address as name,
                   1 as owned,
                   p.price,
                   1 as tier
              FROM houses p
        INNER JOIN players pl
                ON p.identifier = pl.citizenid
             WHERE p.identifier = ?
               AND p.doorsdata != json_array()
        ]], { playerId })

        return housesResult
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

            local affectedRows = MySQL.update.await('UPDATE houses SET `keyholders` = ? WHERE id = ?',
                { json.encode(data.newKeyHolders), data.id })

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

        local affectedRows = MySQL.update.await('UPDATE houses SET `keyholders` = ? WHERE id = ?',
            { json.encode(keyholders), data.id })

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