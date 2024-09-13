local Controller = require 'framework.client'
local Ox = require '@ox_core/lib/init.lua'


RegisterNetEvent('ox:setGroup', function(name, grade)
    local Player = Controller.getPlayer()

    if Player then
        Player.group[name] = grade
        TriggerEvent('Renewed-Lib:client:UpdateGroup', Player.group)
    end
end)


AddEventHandler('ox:playerLoaded', function()
    local currentPlayer = Ox.GetPlayer()

    Controller.createPlayer({
        Groups = currentPlayer.stateId,
        charId = currentPlayer.getGroups(),
        name = currentPlayer.name
    })
end)

AddEventHandler('ox:playerLogout', Controller.removePlayer())