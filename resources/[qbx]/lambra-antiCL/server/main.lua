local QBCore = exports['qb-core']:GetCoreObject()
local citizensId = {}

AddEventHandler("playerDropped", function(reason)
    local src = source
    if not citizensId[src] then
        print("ID: ".. src.." not eligible for combat log ped")
        return
    end
    local coords = GetEntityCoords(GetPlayerPed(src))
    local heading = GetEntityHeading(GetPlayerPed(src))
    local name = GetPlayerName(src)
    local identifiers = GetPlayerIdentifiers(src)
    local result = MySQL.Sync.fetchAll('SELECT model, skin FROM playerskins WHERE citizenid = ? AND active = ?', { citizensId[src], 1 })
    local license
    for _, v in pairs(identifiers) do
        if string.find(v, 'license') then
            license = v
            break
        end
    end

    local pedData = {}
    pedData.id = src
    pedData.name = name

    pedData.license = license
    pedData.reason = reason or "Exiting"
    
    pedData.ped = {}
    pedData.ped.coords = coords
    pedData.ped.heading = heading
    pedData.ped.model = result[1].model
    pedData.ped.skin = result[1].skin

    TriggerClientEvent("lambra-antiCL:client:playerDropped", -1, pedData)
end)

RegisterNetEvent("lambra-antiCL:server:registerCitizen", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        citizensId[src] = Player.PlayerData.citizenid
    end
end)