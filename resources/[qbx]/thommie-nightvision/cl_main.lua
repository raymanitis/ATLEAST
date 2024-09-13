local QBCore = exports[Config.CoreName]:GetCoreObject()
local nightVisionActive = false
local canToggle = false

RegisterCommand('toggleNV', function()
    if QBCore.Functions.HasItem(Config.NVItem) then
        if Config.CheckHelmet then
            if GetPedPropIndex(PlayerPedId(), 0) == 116 then
                canToggle = true
            else
                canToggle = false
            end
        else
            canToggle = true
        end

        if canToggle then
            if nightVisionActive then
                QBCore.Functions.Notify('Nightvision off!')
                SetNightvision(false)
                nightVisionActive = false
            else
                QBCore.Functions.Notify('Nightvision on!')
                SetNightvision(true)
                nightVisionActive = true
            end
        else
            QBCore.Functions.Notify('You are not wearing a nightvision helmet!', 'error')
        end
    end
end)

RegisterKeyMapping('toggleNV', 'Toggle nightvision', 'keyboard', Config.NVKey)

RegisterNetEvent('nightvision:toggleHelmet', function()
    if GetPedPropIndex(PlayerPedId(), 0) == 116 then
        SetPedPropIndex(PlayerPedId(), 0, 8, 0, true)
    else
        SetPedPropIndex(PlayerPedId(), 0, 116, 0, true)
    end
end)
