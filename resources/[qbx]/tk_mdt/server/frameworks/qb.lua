if Config.Framework ~= 'qb' then return end

QBCore = exports['qb-core']:GetCoreObject()

RegisterCallback = QBCore.Functions.CreateCallback
CreateUsableItem = QBCore.Functions.CreateUseableItem

function ShowNotification(src, text, notifyType)
    if notifyType == 'inform' then notifyType = 'primary' end
    TriggerClientEvent('QBCore:Notify', src, text, notifyType)
end

function GetPlayerFromId(playerId)
    return QBCore.Functions.GetPlayer(playerId)
end

function GetPlayerFromIdentifier(identifier)
    return QBCore.Functions.GetPlayerByCitizenId(identifier)
end

function GetSource(player)
    return player.PlayerData.source
end

function GetIdentifier(player)
    return player.PlayerData.citizenid
end

function GetCurrentPlayers()
    return QBCore.Functions.GetQBPlayers()
end

function IsAdmin(playerId)
    for k in pairs(Config.AdminGroups) do
        if QBCore.Functions.HasPermission(playerId, k) then
            return true
        end
    end

    return
end

function GetCharName(identifier)
    local targetPlayer = GetPlayerFromIdentifier(identifier)
    if targetPlayer then
        local name = ('%s %s'):format(targetPlayer.PlayerData.charinfo.firstname, targetPlayer.PlayerData.charinfo.lastname)
        return name
    end

	local result = MySQL.Sync.fetchAll('SELECT charinfo FROM players where citizenid = ?', {identifier})
    local charinfo = json.decode(result?[1]?.charinfo)
    local name = ('%s %s'):format(charinfo?.firstname, charinfo?.lastname)

    return name
end

function IsOnDuty(player)
    return true --player.PlayerData.job.onduty
end

function GetJob(player)
    return player.PlayerData.job
end

function GetJobName(player)
    return player.PlayerData.job.name
end

function GetGradeId(player)
    return player.PlayerData.job.grade.level
end

function SetJob(player, job, grade)
    player.Functions.SetJob(job, grade)
end

function IsBoss(xPlayer, page)
    local grade = GetGradeId(xPlayer)
    local job = GetJobName(xPlayer)
    return Config.Jobs?[page]?[job] and grade >= Config.Jobs[page][job]
end

function GetAccountMoney(player, account)
    if account == 'money' then account = 'cash' end
    return player.Functions.GetMoney(account)
end

function AddAccountMoney(player, account, amount)
    if account == 'money' then account = 'cash' end
    player.Functions.AddMoney(account, amount)
end

function RemoveAccountMoney(player, account, amount)
    if account == 'money' then account = 'cash' end
    player.Functions.RemoveMoney(account, amount)
end

function GetItemAmount(player, item)
    if item == 'money' then
        return GetAccountMoney(player, item)
    end

    local invItem = player.Functions.GetItemByName(item)
    return invItem?.amount or invItem?.count or 0
end

function AddItem(player, item, amount, metadata)
    if item == 'money' then
        return AddAccountMoney(player, item, amount)
    end

    if Config.Inventory == 'ox' then
        exports.ox_inventory:AddItem(GetSource(player), item, amount, metadata)
        return
    end

    player.Functions.AddItem(item, amount)
    TriggerClientEvent('inventory:client:ItemBox', player.PlayerData.source, QBCore.Shared.Items[item], 'add')
end

function RemoveItem(player, item, amount)
    if item == 'money' then
        return RemoveAccountMoney(player, item, amount)
    end

    player.Functions.RemoveItem(item, amount)
    TriggerClientEvent('inventory:client:ItemBox', player.PlayerData.source, QBCore.Shared.Items[item], 'remove')
end

function GetItemLabel(item)
    return QBCore.Shared.Items?[string.lower(item)]?.label or item
end

function GetGradeLabels()
    local labels = {}

    for job,data in pairs(QBCore.Shared.Jobs) do
        for gradeId,gradeData in pairs(data.grades) do
            if not labels[job] then labels[job] = {} end
            labels[job][gradeId] = gradeData.name
        end
    end

    return labels
end

function GetJobLabels()
    local labels = {}
    for job,data in pairs(QBCore.Shared.Jobs) do
        labels[job] = data.label
    end

    return labels
end

local gradeLabels = GetGradeLabels()
local jobLabels = GetJobLabels()

function GetGradeLabel(job, grade)
    return gradeLabels[job][grade]
end

function GetGrades()
    local grades = {}

    for job,data in pairs(gradeLabels) do
        if Config.Jobs.police[job] then
            for gradeId in pairs(data) do
                grades[#grades+1] = {job = job, id = gradeId, jobLabel = jobLabels[job], gradeLabel = gradeLabels[job][gradeId]}
            end
        end
    end

    return grades
end

function GetMDTPlayers()
    local data = MySQL.Sync.fetchAll([[
        SELECT
            CONCAT(JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.lastname'))) AS name,
            citizenid as identifier
        FROM
            players
    ]])

    return data
end

function GetProfiles(page)
    local data = {}

    if page == 'police' then
        data = MySQL.Sync.fetchAll([[
            SELECT
                citizenid as identifier,
                CONCAT(JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.lastname'))) AS name,
                JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.birthdate')) AS dob,
                JSON_UNQUOTE(JSON_EXTRACT(metadata, '$.fingerprint')) AS fingerprint,
                tk_mdt_profiles.image,
                tk_mdt_profiles.tags
            FROM
                players
            LEFT JOIN
                tk_mdt_profiles ON BINARY players.citizenid = tk_mdt_profiles.identifier 
        ]])
    else
        data = MySQL.Sync.fetchAll([[
            SELECT
                citizenid as identifier,
                CONCAT(JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.lastname'))) AS name,
                JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.birthdate')) AS dob,
                JSON_UNQUOTE(JSON_EXTRACT(metadata, '$.fingerprint')) AS fingerprint,
                tk_mdt_ems_profiles.image,
                tk_mdt_ems_profiles.tags
            FROM
                players
            LEFT JOIN
                tk_mdt_ems_profiles ON BINARY players.citizenid = tk_mdt_ems_profiles.identifier 
        ]])
    end

    for k,v in pairs(data) do
        data[k].sideBarData = {
            warrants = page == 'police' and GetWarrantsByIdentifier(v.identifier),
            tags = json.decode(v.tags) or {}
        }
    end

    return data
end

function GetVehiclesByIdentifier(identifier)
    local data = MySQL.Sync.fetchAll([[
        SELECT
            plate,
            hash AS model
        FROM
            player_vehicles
        WHERE
            citizenid = ?
    ]], {identifier})

    return data
end

function GetLicenses(identifier)
    local licenses = {}
    local data = MySQL.Sync.fetchScalar("SELECT JSON_UNQUOTE(JSON_EXTRACT(metadata, '$.licences')) FROM players WHERE citizenid = ?", {identifier})
    data = data and json.decode(data) or {}

    for k in pairs(data) do
        if Config.Licenses[k] then
            licenses[#licenses+1] = Config.Licenses[k]
        end
    end

    return licenses
end

function GetProfileDataForPolice(identifier)
    local data = MySQL.Sync.fetchAll([[
        SELECT
            JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.gender')) AS gender,
            JSON_UNQUOTE(JSON_EXTRACT(job, '$.name')) AS job,
            JSON_UNQUOTE(JSON_EXTRACT(job, '$.grade.level')) AS job_grade,
            JSON_UNQUOTE(JSON_EXTRACT(metadata, '$.bloodtype')) AS bloodType,
            tk_mdt_profiles.notes,
            tk_mdt_profiles.tags,
            tk_mdt_profiles.photos,
            tk_mdt_profiles.licenses,
            tk_mdt_profiles.linkedProfiles
        FROM
            players
        LEFT JOIN
            tk_mdt_profiles ON BINARY players.citizenid = tk_mdt_profiles.identifier
        WHERE
            players.citizenid = ?
    ]], {identifier})

    local profile = data[1]
    profile.gender = profile.gender == '0' and 'male' or profile.gender == '1' and 'female' or 'unknown'
    profile.phoneNumber = GetPhoneNumber(identifier)
    local grade = tonumber(profile.job_grade)
    profile.jobs = profile.job and {('%s - %s'):format(jobLabels[profile.job], gradeLabels[profile.job][grade])} or {_U('unemployed')}
    profile.charges = GetChargesByIdentifier(identifier)
    profile.warrants = GetWarrantsByIdentifier(identifier)
    profile.points = Config.LicensePointsDuration and GetLicensePointsByIdentifier(identifier)
    profile.properties = GetPropertiesByIdentifier(identifier)
    profile.vehicles = GetVehiclesByIdentifier(identifier)
    profile.weapons = GetWeaponsByIdentifier(identifier)
    profile.linkedIncidents = GetIncidentsByIdentifier(identifier)
    profile.linkedReports = GetReportsByIdentifier(identifier)

    if Config.License == 'qb' then
        profile.licenses = GetLicenses(identifier) or {}
    end

    return profile
end

function GetProfileDataForAmbulance(identifier)
    local data = MySQL.Sync.fetchAll([[
        SELECT
            JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.gender')) AS gender,
            JSON_UNQUOTE(JSON_EXTRACT(metadata, '$.bloodtype')) AS bloodType,
            tk_mdt_ems_profiles.notes,
            tk_mdt_ems_profiles.tags,
            tk_mdt_ems_profiles.photos,
            tk_mdt_ems_profiles.linkedProfiles
        FROM
            players
        LEFT JOIN
            tk_mdt_ems_profiles ON BINARY players.citizenid = tk_mdt_ems_profiles.identifier
        WHERE
            players.citizenid = ?
    ]], {identifier})

    local profile = data[1]
    profile.gender = profile.gender == '0' and 'male' or profile.gender == '1' and 'female' or 'unknown'
    profile.phoneNumber = GetPhoneNumber(identifier)
    profile.linkedReports = GetReportsByIdentifier(identifier)

    return profile
end

function GetVehicles()
    local data = MySQL.Sync.fetchAll([[
        SELECT
            player_vehicles.plate,
            hash AS model,
            CONCAT(JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.lastname'))) AS owner,
            tk_mdt_vehicles.image,
            tk_mdt_vehicles.tags
        FROM
            player_vehicles
        LEFT JOIN
            tk_mdt_vehicles ON BINARY player_vehicles.plate = BINARY tk_mdt_vehicles.plate
        LEFT JOIN
            players ON BINARY player_vehicles.citizenid = BINARY players.citizenid
    ]])

    for k,v in pairs(data) do
        data[k].sideBarData = {
            bolos = GetBOLOsByPlate(v.plate),
        }
    end

    return data
end

function GetVehicle(plate)
    local data = MySQL.Sync.fetchAll([[
        SELECT
            garage,
            JSON_EXTRACT(mods, '$.primaryColor') AS customColor,
            JSON_EXTRACT(mods, '$.color1') AS color,
            tk_mdt_vehicles.notes,
            tk_mdt_vehicles.tags,
            tk_mdt_vehicles.photos
        FROM
            player_vehicles
        LEFT JOIN
            tk_mdt_vehicles ON BINARY player_vehicles.plate = BINARY tk_mdt_vehicles.plate
        WHERE
            player_vehicles.plate = ?
    ]], {plate})

    local vehicle = data[1]
    vehicle.color = vehicle.customColor and ColorToName(json.decode(vehicle.customColor)) or Config.Colors[tonumber(vehicle.color)] or _U('unknown')
    vehicle.garage = vehicle.garage or _U('unknown')
    vehicle.bolos = GetBOLOsByPlate(plate)
    vehicle.linkedIncidents = GetIncidentsByPlate(plate)
    vehicle.linkedReports = GetReportsByPlate(plate)

    return vehicle
end

local function IsExcludedBusiness(name)
    for _,v in pairs(Config.ExcludedBusinesses) do
        if name == v then
            return true
        end
    end

    return
end

function GetBusinesses()
    local data = {}

    for k,v in pairs(QBCore.Shared.Jobs) do
        if not IsExcludedBusiness(k) then
            local image = MySQL.Sync.fetchScalar([[SELECT image FROM tk_mdt_businesses WHERE name = ?]], {k})
            data[#data+1] = {name = k, label = v.label, image = image}
        end
    end

    return data
end

function GetEmployeesByBusiness(name)
    local likePattern = '%' .. name .. '%'
    local data = MySQL.Sync.fetchAll([[
        SELECT
            citizenid as identifier,
            CONCAT(JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.lastname'))) AS name,
            JSON_UNQUOTE(JSON_EXTRACT(job, '$.grade.level')) AS job_grade
        FROM
            players
        WHERE
            job LIKE ?
    ]], {likePattern})

    for k,v in pairs(data) do
        local grade = tonumber(v.job_grade)
        data[k].name = ('%s - %s'):format(v.name, gradeLabels[name][grade] or _U('unknown'))
        data[k].job_grade = nil
    end

    return data
end

function GetTrainingReports(page)
    local data = {}

    if page == 'police' then
        data = MySQL.Sync.fetchAll([[
            SELECT
                tk_mdt_training_reports.id,
                tk_mdt_training_reports.title,
                tk_mdt_training_reports.trainee,
                tk_mdt_training_reports.date,
                tk_mdt_training_reports.creator,
                CONCAT(JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.lastname'))) AS name
            FROM
                tk_mdt_training_reports
            LEFT JOIN
                players ON BINARY tk_mdt_training_reports.trainee = players.citizenid
        ]])
    else
        data = MySQL.Sync.fetchAll([[
            SELECT
                tk_mdt_ems_training_reports.id,
                tk_mdt_ems_training_reports.title,
                tk_mdt_ems_training_reports.trainee,
                tk_mdt_ems_training_reports.date,
                tk_mdt_ems_training_reports.creator,
                CONCAT(JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.lastname'))) AS name
            FROM
                tk_mdt_ems_training_reports
            LEFT JOIN
                players ON BINARY tk_mdt_ems_training_reports.trainee = players.citizenid
        ]])
    end

    for _,v in pairs(data) do
        v.trainee = v.traineeName
    end

    return data
end

function GetOfficers()
    local policeJobs = {}
    for k in pairs(Config.Jobs.police) do
        policeJobs[#policeJobs+1] = k
    end

    local policeJobsStr = table.concat(policeJobs, ',')

    local data = MySQL.Sync.fetchAll([[
        SELECT
            citizenid as identifier,
            CONCAT(JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.lastname'))) AS name,
            JSON_UNQUOTE(JSON_EXTRACT(job, '$.name')) AS job,
            JSON_UNQUOTE(JSON_EXTRACT(job, '$.grade.level')) AS grade,
            tk_mdt_officers.image,
            tk_mdt_officers.callsign,
            tk_mdt_officers.status,
            tk_mdt_officers.licenses,
            tk_mdt_officers.notes
        FROM
            players
        LEFT JOIN
            tk_mdt_officers ON BINARY players.citizenid = tk_mdt_officers.identifier
        WHERE
            FIND_IN_SET(JSON_UNQUOTE(JSON_EXTRACT(job, '$.name')), ?)
    ]], {policeJobsStr})

    for k,v in pairs(data) do
        data[k].phoneNumber = GetPhoneNumber(v.identifier)
        data[k].gradeNumber = v.grade
        data[k].grade = gradeLabels[v.job][v.grade]
        data[k].licenses = json.decode(v.licenses) or {}
        data[k].status = v.status or Config.Status[1]
    end

    return data
end

function GetParamedics()
    local ambulanceJobs = {}
    for k in pairs(Config.Jobs.ambulance) do
        ambulanceJobs[#ambulanceJobs+1] = k
    end

    local data = MySQL.Sync.fetchAll([[
        SELECT
            citizenid as identifier,
            CONCAT(JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.lastname'))) AS name,
            JSON_UNQUOTE(JSON_EXTRACT(job, '$.name')) AS job,
            JSON_UNQUOTE(JSON_EXTRACT(job, '$.grade.level')) AS grade,
            tk_mdt_paramedics.image,
            tk_mdt_paramedics.callsign,
            tk_mdt_paramedics.status,
            tk_mdt_paramedics.licenses,
            tk_mdt_paramedics.notes
        FROM
            players
        LEFT JOIN
            tk_mdt_paramedics ON BINARY players.citizenid = tk_mdt_paramedics.identifier
        WHERE
            job IN (?)
    ]], {ambulanceJobs})

    for k,v in pairs(data) do
        data[k].phoneNumber = GetPhoneNumber(v.identifier)
        data[k].gradeNumber = v.grade
        data[k].grade = gradeLabels[v.job][v.grade]
        data[k].licenses = json.decode(v.licenses) or {}
        data[k].status = v.status or Config.Status[1]
    end

    return data
end

RegisterCallback('tk_mdt:getCharName', function(src, cb)
	cb(GetCharName(GetIdentifier(GetPlayerFromId(src))))
end)

RegisterCallback('tk_mdt:getPhoneNumber', function(src, cb)
	cb(GetPhoneNumber(GetIdentifier(GetPlayerFromId(src))))
end)

RegisterNetEvent('qb-multicharacter:server:createCharacter', function(data)
    local src = source
    RegisterCharacter(src, {
        name = ('%s %s'):format(data.firstname, data.lastname),
        dob = data.birthdate,
    })
end)

CreateThread(function()
    repeat Wait(100) until QBCore

    frameworkLoaded = true
end)