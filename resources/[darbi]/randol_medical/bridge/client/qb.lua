if GetResourceState('qb-core') ~= 'started' then return end

Config = require 'shared'
QBCore = exports['qb-core']:GetCoreObject()
PlayerData = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    SetTimeout(1000, function()
        onPlayerLoaded()
        initJobStuff()
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    onUnload()
    clearJobStuff()
end)

function hasPlyLoaded()
    return LocalPlayer.state.isLoggedIn
end

function DoNotification(text, nType)
    QBCore.Functions.Notify(text, nType)
end

function GetPlayerJob()
    return PlayerData.job.name
end

function GetJobGrade()
    return PlayerData.job.grade.level
end

function toggleFrameworkDeath(bool)
    -- can leave this empty for qb.
end

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

AddEventHandler('onResourceStart', function(res)
    if GetCurrentResourceName() ~= res or not hasPlyLoaded() then return end
    PlayerData = QBCore.Functions.GetPlayerData()
end)

if Config.Inventory == 'qb' then -- To handle locking players inventory when using heal items.
    AddStateBagChangeHandler('invBusy', ('player:%s'):format(cache.serverId), function(_, _, value)
        plyState:set('inv_busy', value, true)
    end)
end