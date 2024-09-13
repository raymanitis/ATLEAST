local function IsVehicleOut(plate, vehicles)
    if not vehicles then
        vehicles = GetAllVehicles()
    end

    for i = 1, #vehicles do
        local vehicle = vehicles[i]
        if DoesEntityExist(vehicle) and GetVehicleNumberPlateText(vehicle):gsub("%s+", "") == plate:gsub("%s+", "") then
            return true, vehicle
        end
    end

    return false
end

lib.callback.register('garage:deliver-vehicle', function(source, plate)
    local notification = {
        app = 'garage',
        sound = 'default',
        data = {
            data = 1,
        },
        title = '',
        text = '',
        timeout = 3000
    }

    if IsVehicleOut(plate) then
        debugPrint('Vehicle is out')

        notification.title = 'Vehicle is out'
        SendNotification(notification, 'source', source)

        return nil
    end

    local player = Framework.GetPlayerFromId(source)
    if not player then
        debugPrint('Player not found')

        notification.title = 'Player not found'
        SendNotification(notification, 'source', source)

        return nil
    end

    if Config.Valet.Price and player.getAccount('bank').money < Config.Valet.Price then
        debugPrint('Player doesnt have enough money')

        notification.title = 'Not enough money'
        SendNotification(notification, 'source', source)

        return nil
    end

    player.removeAccountMoney('bank', Config.Valet.Price, 'garage:valet')

    local vehicleData = GetVehicle(plate)
    if not vehicleData then
        if Config.Valet.Price then
            debugPrint('Refunding player')
            player.addAccountMoney('bank', Config.Valet.Price)
        end

        return nil
    end

    notification.title = 'Driver is on the way'
    SendNotification(notification, 'source', source)

    return vehicleData
end)
