local utils = {}
local vehicleKeys = {}

local Config = require 'data'

function utils.formatPlate(string)
    return string and string:gsub('^%s*(.-)%s*$', '%1')
end

local keyRing = GetConvarInt('vehiclekeys_keyring', 0) == 1

--- Returns the entity from a netId
---@param plate string
---@return boolean
function utils.hasKey(plate)
    plate = utils.formatPlate(plate)


    if Config.useKeyItem then
        if keyRing then
            return lib.callback.await('Renewed-Vehiclekeys:server:hasKey', false, plate)
        else
            return exports.ox_inventory:GetItemCount('vehiclekey', { plate = plate }, true) > 0
        end
    end

    return vehicleKeys[plate]
end exports('hasKey', utils.hasKey)

function utils.setKeys(Keys)
    if not Config.useKeyItem and Keys and next(Keys) then
        vehicleKeys = Keys
    end
end

--- Sets the engine status of a vehicle and returns the new status
---@param vehicle number
---@return boolean
function utils.setEngineStatus(vehicle)
    if not vehicle then return false end

    local engineStatus = GetIsVehicleEngineRunning(vehicle)

    SetVehicleUndriveable(vehicle, not engineStatus)
    SetVehicleNeedsToBeHotwired(vehicle, false)

    if GetPedInVehicleSeat(vehicle, -1) > 0 then
        SetVehicleEngineOn(vehicle, engineStatus, false, true)
    else
        SetVehicleEngineOn(vehicle, engineStatus, true, true)
    end

    return engineStatus
end

--- Returns weather or not the player is allowed to lockpick this vehicle
---@param vehicle number
---@return boolean
function utils.canLockpick(vehicle)
    return true
end

--- Get the amount of peds inside of a vehicle
---@param vehicle number
---@return table
function utils.getPedsInCar(vehicle)
    local Peds = {}
    local pedAmt = 0

    if vehicle then
        for seat = -1, GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) - 2 do
            local pedInSeat = GetPedInVehicleSeat(vehicle, seat)

            if pedInSeat > 0 and not IsPedAPlayer(pedInSeat) then
                pedAmt += 1
                Peds[pedAmt] = pedInSeat
            end
        end
    end

    return Peds
end

function utils.getClosestKeyCar()
    local vehicles = lib.getNearbyVehicles(GetEntityCoords(cache.ped), 15)

    local closestKeyCar
    local closestKeyCoords = 15

    if not cache.vehicle then
        for i = 1, #vehicles do
            local vehicle = vehicles[i]
            local plate = GetVehicleNumberPlateText(vehicle.vehicle)
            local dist = #(GetEntityCoords(cache.ped) - GetEntityCoords(vehicle.vehicle))
            local class = GetVehicleClass(vehicle.vehicle)

            if not Config.vehicles[class].noLocks and dist <= closestKeyCoords then
                if HasEntityClearLosToEntityInFront(cache.ped, vehicle.vehicle) then
                    if utils.hasKey(plate) then
                        closestKeyCar = vehicle.vehicle
                        closestKeyCoords = dist
                    end
                end
            end
        end
    end

    return closestKeyCar
end

--- Makes allt he ped flee within that vehicle
---@param vehicle number
function utils.pedFlee(vehicle)
    local peds, amount = utils.getPedsInCar(vehicle)

    if amount == 0 then return end

    for i = 1, #peds do
        local pedInSeat = peds[i]
        TaskLeaveVehicle(pedInSeat, vehicle, 0)
        PlayPain(pedInSeat, 6, 0)
        Wait(1000)
        ClearPedTasksImmediately(pedInSeat)
        PlayPain(pedInSeat, math.random(7, 8), 0)
        SetPedFleeAttributes(pedInSeat, 0, 0)
        TaskReactAndFleePed(pedInSeat, cache.ped)
    end
end

---Displays TextUI on the players screen
---@param text string
function utils.textUi(text)
    lib.showTextUI(text, {
        position = 'left-center',
    })
end

function utils.hideTextUi()
    lib.hideTextUI()
end

function utils.notify(message, type)
    lib.notify({
        description = message,
        type = type
    })
end


--- Returns true/false depending if the player completed the skillcheck
---@param circles number
---@param time number
---@return boolean
function utils.lockpickGame(circles, time)
    local game = {}

    for i = 1, circles do
        game[i] = {areaSize = math.random(time, math.ceil(time * 1.5)), speedMultiplier = 1}
    end

    return lib.skillCheck(game, Config.keys)
end

function utils.stateBagWrapper(keyFilter, cb)
    return AddStateBagChangeHandler(keyFilter, '', function(bagName, _, value, _, replicated)
        local netId = tonumber(bagName:gsub('entity:', ''), 10)

        local loaded = netId and lib.waitFor(function()
            if NetworkDoesEntityExistWithNetworkId(netId) then return true end
        end, 'Timeout while waiting for entity to exist', 3500)

        local entity = loaded and NetToVeh(netId)

        if entity and not replicated then
            cb(entity, value)
        end
    end)
end

return utils