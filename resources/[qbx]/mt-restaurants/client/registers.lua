openRegister = function(job, id)
    lib.callback('mt-restaurants:server:makePlayersList', false, function(onlineList)
        local nearbyList = {}

        if not onlineList then notify(locale('notify_error_register_no_nearby'), 'error') return end

        for _, v in pairs(getPlayersFromCoords(GetEntityCoords(cache.ped), Config.restaurants[job].registers[id].playersRadius)) do
            local dist = #(GetEntityCoords(GetPlayerPed(v)) - GetEntityCoords(cache.ped))
            for i = 1, #onlineList do
                if onlineList[i].value == GetPlayerServerId(v) then
                    nearbyList[#nearbyList+1] = { value = onlineList[i].value, label = tostring(onlineList[i].text..' ('..math.floor(dist+0.05)..'m)') }
                end
            end
        end
    
        local input = lib.inputDialog(Config.restaurants[job].registers[id].label, {
            { type = "select", icon = locale('input_register_player_icon'), required = true, label = locale('input_register_player'), default = nearbyList[1].value, options = nearbyList },
            { type = 'select', icon = locale('input_register_payment_type_icon'), required = true, label = locale('input_register_payment_type'), default = 'bank', options = { { value = "cash", label = locale('input_register_cash') }, { value = "bank", label = locale('input_register_bank') } } },
            { type = 'number', icon = locale('input_register_amount_icon'), required = true, label = locale('input_register_amount') },
        })
        if input then
            lib.callback.await('mt-restaurants:server:chargePlayer', false, input[1], tonumber(input[3]), input[2], job, id)
        end
    end)
end

lib.callback.register('mt-restaurants:client:registerConfirmPay', function(price, biller, type, job, id)
    local alert = lib.alertDialog({ header = locale('alert_register_confirm_register'), content = locale('alert_register_confirm_register_description', price, Config.restaurants[job].label), centered = true, cancel = true })
    if alert == 'confirm' then
        lib.callback.await('mt-restaurants:server:confirmPayment', false, price, biller, type, job, id)
    end
    return true
end)