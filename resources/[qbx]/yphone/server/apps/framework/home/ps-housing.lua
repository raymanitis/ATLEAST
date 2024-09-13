CreateThread(function()
    if Config.Housing ~= 'ps-housing' or Config.Framework ~= 'qb' then return end

    debugPrint("Using ps-housing")

    lib.callback.register('yseries:server:home:get', function(source)
        local playerId = Framework.GetPlayerFromId(source)?.identifier

        if (not playerId) then
            debugPrint('Home: Could not get player id')
            return
        end

        local propertiesResult = MySQL.query.await([[
            SELECT p.property_id as id,
                   p.owner_citizenid as citizenid,
                   CONCAT('{"x":',JSON_EXTRACT(p.door_data, '$.x'),', "y":',JSON_EXTRACT(p.door_data, '$.y'),'}') as coords,
                   CONCAT('{"x":',JSON_EXTRACT(p.garage_data, '$.x'),', "y":',JSON_EXTRACT(p.garage_data, '$.y'),'}') as garage,
                   p.description AS house,
                   pl.license as identifier,
                   p.has_access as keyholders,
                   p.description as label,
                   p.description as name,
                   1 as owned,
                   p.price,
                   1 as tier
              FROM properties p
        INNER JOIN players pl
                ON p.owner_citizenid = pl.citizenid
             WHERE p.owner_citizenid = ?
               AND p.door_data != json_array()
        ]], { playerId })

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

            local affectedRows = MySQL.update.await('UPDATE properties SET `has_access` = ? WHERE property_id = ?',
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

        local affectedRows = MySQL.update.await('UPDATE properties SET `has_access` = ? WHERE property_id = ?',
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