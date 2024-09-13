RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent("lambra-antiCL:server:registerCitizen") --This will make the player eligible for the ped creation
end)

function loadClothes(clothes, ped)
    TriggerEvent('qb-clothing:client:loadPlayerClothing', json.decode(clothes), ped)
end

function hasPerms()
    --You can code here if you want to restrict the COPY INFORMATION for admins or something
    return true
end