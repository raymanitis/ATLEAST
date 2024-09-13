CreateThread(function()
    if Config.Garages ~= 'qb-garages' or Config.Framework ~= 'qb' then return end

    local _Framework = exports['qb-core']:GetCoreObject()

    debugPrint("Using qb-garages")

    function GetPlayerVehicles(source)
        local vehicles = MySQL.query.await([[
            SELECT * FROM player_vehicles
            WHERE citizenid = @citizenid
        ]], {
            ['@citizenid'] = Framework.GetPlayerFromId(source)?.identifier
        })

        if not vehicles then
            return nil
        end

        local VehiclesData = {}
        for _, v in pairs(vehicles) do
            local state
            if v.state == 0 then
                state = "outOfGarage"        -- "Out of garage"
            elseif v.state == 1 then
                state = v.garage or "garage" -- "Garage"
            elseif v.state == 2 then
                state = "impounded"          -- "Impounded"
            end

            local vehicle = {
                plate = v.plate,
                type = _Framework.Shared.Vehicles[v.hash]?.category or "car",
                location = state,
                statistics = {
                    engine = math.floor(v.engine / 10 + 0.5),
                    body = math.floor(v.body / 10 + 0.5),
                    fuel = v.fuel
                },
            }

            vehicle.model = tonumber(v.hash)
            vehicle.vehicle = v.vehicle

            VehiclesData[#VehiclesData + 1] = vehicle
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

        local citizenId = Framework.GetPlayerFromId(src)?.identifier

        local vehicle = MySQL.query.await([[
            SELECT
                plate,
                mods,
                fuel,
                `hash`
            FROM player_vehicles
            WHERE citizenid = @citizenid AND plate = @plate AND state = 1
        ]],
            {
                ['@citizenid'] = citizenId,
                ['@plate'] = plate
            })

        if not vehicle then return nil end

        local vehicleData = vehicle[1]

        MySQL.query.await([[
            UPDATE player_vehicles
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
                    vehicles[i].location = 'Out of garage'
                end
            end
        end

        return vehicles
    end)

    lib.callback.register('yseries:server:garage:find-vehicle-by-plate', function(source, plate)
        local out, vehicle = IsVehicleOut(plate)
        if out and vehicle then
            return GetEntityCoords(vehicle)
        elseif not out then
            debugPrint(plate)
            local citizenId = Framework.GetPlayerFromId(source)?.identifier
            local allGarages = exports['qb-garages']:getAllGarages()
            local garageVehicle = MySQL.query.await([[
                SELECT
                    garage
                FROM player_vehicles
                WHERE citizenid = @citizenid AND plate = @plate
            ]],
                {
                    ['@citizenid'] = citizenId,
                    ['@plate'] = plate
                })

            local garageData = garageVehicle[1]

            for k, v in pairs(allGarages) do
                if v.name == garageData.garage then
                    return allGarages[k].takeVehicle
                end
            end
        else
            return false
        end
    end)
end)
