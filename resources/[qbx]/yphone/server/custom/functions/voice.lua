local salty = exports["saltychat"]

RegisterNetEvent("voice:add-to-call", function(callId)
    local src = source
    if Config.Voice == "salty" then
        salty:AddPlayerToCall(tostring(callId), src)
    end
end)

RegisterNetEvent("voice:remove-from-call", function(callId)
    local src = source
    if Config.Voice == "salty" then
        salty:RemovePlayerFromCall(tostring(callId), src)
    end
end)

RegisterNetEvent("voice:toggle-speaker", function(enabled)
    local src = source
    if Config.Voice == "salty" then
        salty:SetPhoneSpeaker(src, enabled == true)
    end
end)
