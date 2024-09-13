if GetResourceState('qb-core') ~= 'started' then return end

Config = require 'shared'
Server = require 'server/sv_config'

QBCore = exports['qb-core']:GetCoreObject()

function GetDbPlayersTable()
    return 'players'
end

function GetPlayer(id)
    return QBCore.Functions.GetPlayer(id)
end

function DoNotification(src, text, nType)
    TriggerClientEvent('QBCore:Notify', src, text, nType)
end

function GetPlyIdentifier(Player)
    return Player.PlayerData.citizenid
end

function GetByIdentifier(cid)
    return QBCore.Functions.GetPlayerByCitizenId(cid)
end

function GetSourceFromIdentifier(cid)
    local Player = QBCore.Functions.GetPlayerByCitizenId(cid)
    return Player and Player.PlayerData.source or false
end

function GetPlayerSource(Player)
    return Player.PlayerData.source
end

function GetCharacterName(Player)
    return Player.PlayerData.charinfo.firstname.. ' ' ..Player.PlayerData.charinfo.lastname
end

function GetPlyLicense(Player)
    return Player.PlayerData.license
end

function GetPlayerJob(Player)
    return Player.PlayerData.job.name
end

function GetDoctorCount()
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for _, Player in pairs(players) do
        if Player and Config.AmbulanceJobNames[Player.PlayerData.job.name] and Player.PlayerData.job.onduty then
            amount += 1
        end
    end
    return amount
end

function setPlayerMeta(player, meta, value)
    if not player then return end
    player.Functions.SetMetaData(meta, value)
    if meta == 'stress' then
        TriggerClientEvent('hud:client:UpdateStress', player.PlayerData.source, value)
    end
end

function refillHungerThirst(player)
    player.Functions.SetMetaData('hunger', 100)
    player.Functions.SetMetaData('thirst', 100)
    TriggerClientEvent('hud:client:UpdateNeeds', player.PlayerData.source, 100, 100)
end

function reduceStress(player, amount)
    local currentStress = player.PlayerData.metadata.stress or 0
    local newStress = math.max(0, currentStress - amount)

    newStress = math.min(newStress, 100)

    player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', player.PlayerData.source, newStress)
end

function addMoney(player, acc, amount)
    player.Functions.AddMoney(acc, amount)
end

function RemoveMoney(player, acc, amount)
    player.Functions.RemoveMoney(acc, amount)
end

function updatePlayerStats(health, armor, cid)
    MySQL.update.await('UPDATE players SET health = ?, armor = ? WHERE citizenid = ?', {health, armor, cid})
end

function updateDeathStates(state, value, cid)
    MySQL.update.await('UPDATE players SET ' .. state .. ' = ? WHERE citizenid = ?', {value, cid})
end

function fetchPersistentData(cid)
    return MySQL.rawExecute.await('SELECT isdead, inlaststand, health, armor FROM players WHERE citizenid = ?', {cid})
end

function fetchCharFromDatabase(cid)
    return MySQL.scalar.await('SELECT 1 FROM players WHERE citizenid = ?', {cid})
end

function deleteCharFromDatabase(cid)
    MySQL.update.await('DELETE FROM players WHERE citizenid = ?', {cid})
end

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
    OnPlayerLoaded(source)
end)

RegisterNetEvent('QBCore:Server:OnPlayerUnload', function(source)
    OnPlayerUnload(source)
end)

for _, v in pairs(Server.HealItems) do
    if Config.Inventory == 'ox' then
        exports(v.item, function(event, item, inventory, slot, data)
            if event == 'usingItem' then
                local src = inventory.id
                local player = GetPlayer(src)
                
                local success = lib.callback.await('randol_medical:useHealItem', src, v)
                if success then
                    RemoveItem(src, v.item, 1, slot)
                end
            
                return
            end
        end)
    else
        QBCore.Functions.CreateUseableItem(v.item, function(source, item)
            local src = source
            local Player = GetPlayer(src)
            if Player.Functions.GetItemByName(v.item) then
                lib.callback('randol_medical:useHealItem', src, function(success)
                    if success then RemoveItem(src, v.item, 1, item.slot) end
                end, v)
            end
        end)
    end
end

if Config.EnableMedicalBag then
    if Config.Inventory == 'ox' then
        exports(Server.MedBagItem, function(event, item, inventory, slot, data)
            if event == 'usingItem' then
                local src = inventory.id
                local player = GetPlayer(src)
                if not Config.AmbulanceJobNames[GetPlayerJob(player)] then return end
            
                local cid = GetPlyIdentifier(player)
                if not medBagItems[cid] then
                    medBagItems[cid] = lib.table.deepclone(Server.MedBagItemDefaults)
                end
            
                local success = lib.callback.await('randol_medical:client:useBag', src)
                if success then
                    RemoveItem(src, item.name, 1, item.slot)
                end
    
                return
            end
        end)
    else
        QBCore.Functions.CreateUseableItem(Server.MedBagItem, function(source, item)
            local src = source
            local player = GetPlayer(src)
            if not Config.AmbulanceJobNames[GetPlayerJob(player)] then return end
        
            local cid = GetPlyIdentifier(player)
            if not medBagItems[cid] then
                medBagItems[cid] = lib.table.deepclone(Server.MedBagItemDefaults)
            end
        
            local success = lib.callback.await('randol_medical:client:useBag', src)
            if success then
                RemoveItem(src, item.name, 1, item.slot)
            end
        end)
    end
end