CreateThread(function()
    if Config.Garages ~= 'esx_garage' or Config.Framework ~= 'esx' then return end

    debugPrint("Using esx_garage")

    function GetPlayerVehicles(source)
        local vehicles = MySQL.query.await("SELECT * FROM owned_vehicles WHERE owner = ?", {
            Framework.GetPlayerFromId(source)?.identifier
        })

        local VehiclesData = {}
        if not vehicles then
            return nil
        end

        for _, v in pairs(vehicles) do
            if type(v.stored) ~= "boolean" then
                v.stored = v.stored == 1
            end

            local currentVehicle = {
                plate = v.plate,
                type = v.type,
                location = v.stored and (v.parking or "garage") or "outOfGarage",
                statistics = {}
            }

            if v.damages then
                local damages = json.decode(v.damages)
                if damages?.engineHealth then
                    currentVehicle.statistics.engine = math.floor(damages.engineHealth / 10 + 0.5)
                end

                if damages?.bodyHealth then
                    currentVehicle.statistics.body = math.floor(damages.bodyHealth / 10 + 0.5)
                end
            end

            local vehicle = json.decode(v.vehicle)
            if vehicle.fuelLevel then
                currentVehicle.statistics.fuel = math.floor(vehicle.fuelLevel + 0.5)
            end
            if vehicle?.engineHealth then
                currentVehicle.statistics.engine = math.floor(vehicle.engineHealth / 10 + 0.5)
            end

            if vehicle?.bodyHealth then
                currentVehicle.statistics.body = math.floor(vehicle.bodyHealth / 10 + 0.5)
            end

            currentVehicle.model = vehicle.model

            VehiclesData[#VehiclesData + 1] = currentVehicle
        end

        return VehiclesData
    end

    local function IsVehicleOut(plate, vehicles)
        if not vehicles then
            vehicles = GetAllVehicles()
        end

        for i = 1, #vehicles do
            local vehicle = vehicles[i]
            if DoesEntityExist(vehicle) and GetVehicleNumberPlateText(vehicle):gsub('%s+', '') == plate:gsub('%s+', '') then
                return true, vehicle
            end
        end

        return false
    end

    function GetVehicle(plate)
        local src = source

        local ownerId = Framework.GetPlayerFromId(src)?.identifier

        local vehicle = MySQL.query.await([[
        SELECT
            plate,
            mods,
            fuel,
            `hash`
        FROM owned_vehicles
        WHERE owner = @owner and plate = @plate and stored = 1
        ]], {
            ['@owner'] = ownerId,
            ['@plate'] = plate
        })

        if not vehicle then return nil end

        local vehicleData = vehicle[1]

        MySQL.query.await([[
            UPDATE owned_vehicles
            SET state = 0
            WHERE plate = @plate
        ]],
            {
                ['@plate'] = plate
            })

        return vehicleData
    end

    lib.callback.register('yseries:server:garage:get-vehicles', function(source)
        local vehicles = GetPlayerVehicles(source)
        if vehicles and #vehicles > 0 then
            local allVehicles = GetAllVehicles()

            for i = 1, #vehicles do
                if IsVehicleOut(vehicles?[i].plate, allVehicles) then
                    vehicles[i].location = 'outOfGarage'
                end
            end
        end

        return vehicles
    end)

    lib.callback.register('yseries:server:garage:find-vehicle-by-plate', function(_, plate)
        local out, vehicle = IsVehicleOut(plate)
        if out and vehicle then
            return GetEntityCoords(vehicle)
        else
            return false
        end
    end)
end)
