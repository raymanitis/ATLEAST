CreateThread(function()
    if Config.Garages ~= 'jg-advancedgarages' then return end

    local _Framework
    if Config.Framework == 'qb' then
        _Framework = exports['qb-core']:GetCoreObject()
    end

    debugPrint("Using jg-advancedgarages")

    function GetPlayerVehicles(source)
        if Config.Framework == 'qb' then
            local vehicles = MySQL.query.await([[
                SELECT * FROM player_vehicles WHERE citizenid = @citizenid AND job_vehicle = 0 AND gang_vehicle = 0
            ]], {
                ['@citizenid'] = Framework.GetPlayerFromId(source)?.identifier
            })

            if not vehicles then
                return nil
            end

            local VehiclesData = {}
            for _, v in pairs(vehicles) do
                local state
                local impound_reason
                if v.impound == 1 then
                    state = "impounded" -- "Impounded"
                    impound_reason = json.decode(v.impound_data).reason
                elseif v.in_garage then
                    state = v.garage_id or "garage" -- "Garage"
                else
                    state = "outOfGarage"           -- "Out of garage"
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

                vehicle.model = v.vehicle
                vehicle.vehicle = v.vehicle

                VehiclesData[#VehiclesData + 1] = vehicle
            end

            return VehiclesData
        elseif Config.Framework == 'esx' then
            local vehicles = MySQL.query.await([[
                SELECT * FROM owned_vehicles WHERE owner = @owner AND job_vehicle = 0 AND gang_vehicle = 0
            ]], {
                ['@owner'] = Framework.GetPlayerFromId(source)?.identifier
            })

            if not vehicles then
                return nil
            end

            local VehiclesData = {}
            for _, v in pairs(vehicles) do
                local state
                local impound_reason
                if v.impound == 1 then
                    state = "impounded" -- "Impounded"
                    impound_reason = json.decode(v.impound_data).reason
                elseif v.in_garage then
                    state = v.garage_id or "garage" -- "Garage"
                else
                    state = "outOfGarage"           -- "Out of garage"
                end

                local vehicle = {
                    plate = v.plate,
                    type = v.type,
                    location = state,
                    statistics = {
                        engine = math.floor(v.engine / 10 + 0.5),
                        body = math.floor(v.body / 10 + 0.5),
                        fuel = v.fuel
                    },
                }

                vehicle.model = json.decode(v.vehicle).model
                vehicle.vehicle = json.decode(v.vehicle).model

                VehiclesData[#VehiclesData + 1] = vehicle
            end

            return VehiclesData
        else
            return {}
        end
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
        local vehicleData

        if Config.Framework == 'qb' then
            vehicleData = MySQL.query.await([[
                SELECT plate, mods, fuel, `hash`
                FROM player_vehicles
                WHERE citizenid = @citizenid AND plate = @plate AND in_garage = 1
            ]], {
                ['@citizenid'] = citizenId,
                ['@plate'] = plate
            })
        elseif Config.Framework == 'esx' then
            vehicleData = MySQL.query.await([[
                SELECT plate, vehicle, fuel
                FROM owned_vehicles
                WHERE owner = @owner AND plate = @plate AND in_garage = 1
            ]], {
                ['@owner'] = citizenId,
                ['@plate'] = plate
            })
        end

        if not vehicleData or #vehicleData == 0 then
            return nil
        end

        if Config.Framework == 'qb' then
            MySQL.query.await([[UPDATE player_vehicles SET in_garage = 0 WHERE plate = @plate]], { ['@plate'] = plate })
        elseif Config.Framework == 'esx' then
            MySQL.query.await([[UPDATE owned_vehicles SET in_garage = 0 WHERE plate = @plate]], { ['@plate'] = plate })
        end

        return vehicleData[1]
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

    local function getGarageById(garageId)
        local allGarages = exports['jg-advancedgarages']:getAllGarages()
        for i = 1, #allGarages do
            if allGarages[i].label == garageId then
                return allGarages[i]
            end
        end
    end

    lib.callback.register('yseries:server:garage:find-vehicle-by-plate', function(_, plate)
        local out, vehicle = IsVehicleOut(plate)
        local tableName = nil

        if Config.Framework == 'qb' then
            tableName = 'player_vehicles'
        elseif Config.Framework == 'esx' then
            tableName =
            'owned_vehicles'
        end

        if out and vehicle then
            return GetEntityCoords(vehicle)
        else
            if tableName ~= nil then
                local vehicles

                if Config.Framework == 'qb' then
                    vehicles = MySQL.query.await([[SELECT garage_id FROM player_vehicles WHERE plate = @plate]], {
                        ['@plate'] = plate
                    })
                elseif Config.Framework == 'esx' then
                    vehicles = MySQL.query.await([[SELECT garage_id FROM owned_vehicles WHERE plate = @plate]], {
                        ['@plate'] = plate
                    })
                end

                if vehicles and vehicles[1] then
                    local garage = getGarageById(vehicles[1].garage_id)
                    return garage.takeVehicle
                end
            end
            return false
        end
    end)
end)
