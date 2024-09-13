if GetResourceState('es_extended') ~= 'started' then return end

Config = require 'shared'
Server = require 'server/sv_config'

ESX = exports['es_extended']:getSharedObject()

function GetDbPlayersTable()
    return 'users'
end

function GetPlayer(id)
    return ESX.GetPlayerFromId(id)
end

function DoNotification(src, text, nType)
    TriggerClientEvent('ox_lib:notify', src, { type = nType, description = text })
end

function GetPlyIdentifier(xPlayer)
    return xPlayer.identifier
end

function GetByIdentifier(cid)
    return ESX.GetPlayerFromIdentifier(cid)
end

function GetSourceFromIdentifier(cid)
    local xPlayer = ESX.GetPlayerFromIdentifier(cid)
    return xPlayer and xPlayer.source or false
end

function GetPlayerSource(xPlayer)
    return xPlayer.source
end

function GetCharacterName(xPlayer)
    return xPlayer.getName()
end

function GetPlyLicense(xPlayer)
    return ('license:%s'):format(ESX.GetIdentifier(xPlayer.source))
end

function GetPlayerJob(xPlayer)
    return xPlayer.job.name
end

function GetDoctorCount()
    local amount = 0
    local players = ESX.GetExtendedPlayers()
    for i = 1, #players do 
        local xPlayer = players[i]
        if xPlayer and Config.AmbulanceJobNames[xPlayer.job.name] then
            amount += 1
        end
    end
    return amount
end

function setPlayerMeta(xPlayer, meta, value)
    if not xPlayer then return end
    if type(value) == 'boolean' then
        value = value == true and 1 or 0
    end
    xPlayer.setMeta(meta, value)
    -- Only really used to handle bleeding/stress if thats even a meta?
end

function refillHungerThirst(xPlayer)
    TriggerClientEvent('esx_status:set', xPlayer.source, 'hunger', 1000000)
	TriggerClientEvent('esx_status:set', xPlayer.source, 'thirst', 1000000)
end

function reduceStress(player, amount)
    -- Implement stress reduction for ESX here? QB example below.
    -- local currentStress = player.PlayerData.metadata.stress or 0
    -- local newStress = math.max(0, currentStress - amount)

    -- newStress = math.min(newStress, 100)

    -- player.Functions.SetMetaData('stress', newStress)
    -- TriggerClientEvent('hud:client:UpdateStress', player.PlayerData.source, newStress)
end

function addMoney(xPlayer, moneyType, amount)
    local account = moneyType == 'cash' and 'money' or moneyType
    xPlayer.addAccountMoney(account, amount)
end

function RemoveMoney(xPlayer, acc, amount)
    xPlayer.removeAccountMoney(acc, amount)
end

function updatePlayerStats(health, armor, cid)
    MySQL.update.await('UPDATE users SET health = ?, armor = ? WHERE identifier = ?', {health, armor, cid})
end

function updateDeathStates(state, value, cid)
    MySQL.update.await('UPDATE users SET ' .. state .. ' = ? WHERE identifier = ?', {value, cid})
end

function fetchPersistentData(cid)
    return MySQL.rawExecute.await('SELECT isdead, inlaststand, health, armor FROM users WHERE identifier = ?', {cid})
end

function fetchCharFromDatabase(cid)
    return MySQL.scalar.await('SELECT 1 FROM users WHERE identifier = ?', {cid})
end

function deleteCharFromDatabase(cid)
    MySQL.update.await('DELETE FROM users WHERE identifier = ?', {cid})
end

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    OnPlayerLoaded(playerId)
end)

AddEventHandler('esx:playerLogout', function(playerId)
    OnPlayerUnload(playerId)
end)

for _, v in pairs(Server.HealItems) do
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
end

if Config.EnableMedicalBag then
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
end

RegisterNetEvent('esx_ambulancejob:putInVehicle') -- From esx_ambulancejob
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
	end
end)