CreateThread(function()
    if Config.Housing ~= 'your_housing' or Config.Framework ~= 'your_framework' then return end

    debugPrint("Using your_housing")

    lib.callback.register('yseries:server:home:get', function(source)
        local playerId = Framework.GetPlayerFromId(source)?.identifier

        if (not playerId) then
            debugPrint('Home: Could not get player id')
            return
        end

        -- * Implement your housing logic here.

        return {}
    end)

    lib.callback.register('yseries:server:home:get-key-holders-details', function(_, keyHolders)
        local charinfoData = {}

        return charinfoData
    end)

    lib.callback.register('yseries:server:home:remove-key-holder',
        function(_, data)
            -- * Implement your housing logic here.

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

        -- * Implement your housing logic here.

        return {
            success = true,
        }
    end)
end)
