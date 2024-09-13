local prop = nil
RegisterNUICallback('setUIFocus', function()
    SetNuiFocus(true, true)
    loadAnimDict('missfam4')
    TaskPlayAnim(cache.ped, 'missfam4', 'base', 8.0, 8.0, -1, 1, 0, false, false, false)
    loadModel('p_amb_clipboard_01')
    prop = CreateObject(GetHashKey('p_amb_clipboard_01'), 0.0, 0.0, 0.0, true, false, false)
    AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, 36029), 0.16, 0.08, 0.1, -130.0, -50.0, 0.0, false, true, false, false, true, true)
end)

RegisterNUICallback('unsetUIFocus', function()
    SetNuiFocus(false, false)
    ClearPedTasks(cache.ped)
    StopAnimTask(cache.ped, 'missfam4', 'base', 0.0)
    RemoveAnimDict('missfam4')
    DeleteEntity(prop)
end)

takeMenu = function(job)
    lib.callback.await('mt-restaurants:server:addRestaurantMenu', false, job)
end

openMenu = function(data, item)
    local metadata = item.metadata or item.info
    SendNUIMessage({ action = 'show', image_url = metadata.image_url })
end
exports("openMenu", openMenu)
RegisterNetEvent('mt-restaurants:client:openMenu', openMenu)