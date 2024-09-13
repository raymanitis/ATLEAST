CreateThread(function()
    if Config.Garages ~= 'your_garage' or Config.Framework ~= 'your_framework' then return end

    debugPrint("Using your_garage")

    function GetPlayerVehicles(source)
        -- * Implement your garage logic here.

        return {}
    end

    local function IsVehicleOut(plate, vehicles)
        -- * Implement your garage logic here.

        return false
    end

    lib.callback.register('yseries:server:garage:get-vehicles', function(source)
        -- * Implement your garage logic here.

        return {}
    end)

    lib.callback.register('yseries:server:garage:find-vehicle-by-plate', function(_, plate)
        -- * Implement your garage logic here.

        return false
    end)
end)
