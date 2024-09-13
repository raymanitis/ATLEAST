if Config.Framework ~= 'esx' then return end

ESX = exports["es_extended"]:getSharedObject()

TriggerCallback = ESX.TriggerServerCallback

function ShowNotification(text)
    ESX.ShowNotification(text)
end

function GetIdentifier()
    return ESX.PlayerData.identifier
end

function GetCharName()
    if ESX?.PlayerData?.firstName and ESX?.PlayerData?.lastName then
        return ('%s %s'):format(ESX.PlayerData.firstName, ESX.PlayerData.lastName)
    end

    local p = promise.new()
    TriggerCallback('tk_mdt:getCharName', function(name)
        p:resolve(name)
    end)
    return Citizen.Await(p)
end

function GetPhoneNumber()
    local p = promise.new()
    TriggerCallback('tk_mdt:getPhoneNumber', function(phone)
        p:resolve(phone)
    end)
    return Citizen.Await(p)
end

function GetDateOfBirth()
    return ESX?.PlayerData?.dateofbirth
end

function IsOnDuty()
    return true
end

function GetJobName()
    return ESX.PlayerData.job.name
end

function GetGradeId()
    return ESX.PlayerData.job.grade
end

function GetGradeLabel()
    return ESX.PlayerData.job.grade_label
end

function IsBoss(page)
    local grade = GetGradeId()
    local job = GetJobName()
    return Config.Jobs?[page]?[job] and grade >= Config.Jobs[page][job]
end

function GetItemLabel(item)
    local p = promise.new()
    TriggerCallback('tk_a:getItemLabel', function(label)
        p:resolve(label)
    end, item)
    return Citizen.Await(p)
end

function GetItemAmount(item)
    for _,v in pairs(ESX.GetPlayerData().inventory) do
        if v.name == item then
            return v.count or v.amount
        end
    end

    return 0
end

function GetClosestPlayer()
    return ESX.Game.GetClosestPlayer()
end

function OpenDialog(label)
    local p = promise.new()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialog', {
        title = label,
    }, function (data, menu)
        p:resolve(data.value)
        menu.close()
    end, function (data, menu)
        p:resolve(nil)
        menu.close()
    end)
    return Citizen.Await(p)
end

RegisterNetEvent('esx:playerLoaded', function(playerData)
    ESX.PlayerData = playerData
    PlayerLoaded()
end)

RegisterNetEvent('esx:setJob', function(job)
    Wait(500)
    ESX.PlayerData.job = job
    JobUpdated()
end)

CreateThread(function()
    repeat Wait(2000) until ESX and ESX.PlayerData and ESX.PlayerData.job

    frameworkLoaded = true
end)