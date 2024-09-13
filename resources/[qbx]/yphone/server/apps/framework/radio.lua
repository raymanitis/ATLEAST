local salty = exports["saltychat"]
local pma = exports["pma-voice"]
local mumble = exports["mumble-voip"]

RegisterNetEvent("yseries:server:radio:leave", function(channel)
    salty:RemovePlayerRadioChannel(source, channel)
end)

RegisterNetEvent('yseries:server:radio:player-joined', function(playerSrc)
    TriggerClientEvent('yseries:client:radio:player-joined', playerSrc)
end)

RegisterNetEvent('yseries:server:radio:player-left', function(playerSrc)
    TriggerClientEvent('yseries:client:radio:player-left', playerSrc)
end)

lib.callback.register("yseries:server:radio:get-participants", function(_, channel)
    if Config.Voice == "pma" then
        return pma:getPlayersInRadioChannel(channel)
    elseif Config.Voice == "mumble" then
        return mumble:getPlayersInRadioChannel(channel)
    elseif Config.Voice == "salty" then
        return salty:GetPlayersInRadioChannel(channel)
    elseif Config.Voice == "toko" then
        print('Implement toko voip get players in channel')
        return {}
    end
end)
