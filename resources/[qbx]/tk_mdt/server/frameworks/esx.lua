if Config.Framework ~= 'esx' then return end

ESX = exports["es_extended"]:getSharedObject()

RegisterCallback = ESX.RegisterServerCallback
CreateUsableItem = ESX.RegisterUsableItem

function ShowNotification(src, text, notifyType)
    TriggerClientEvent('esx:showNotification', src, text)
end

function GetPlayerFromId(playerId)
    return ESX.GetPlayerFromId(playerId)
end

function GetPlayerFromIdentifier(identifier)
    return ESX.GetPlayerFromIdentifier(identifier)
end

function GetSource(xPlayer)
    return xPlayer.source
end

function GetIdentifier(xPlayer)
    return xPlayer.identifier
end

function GetCurrentPlayers()
    return ESX.GetPlayers()
end

function IsAdmin(playerId)
    local xPlayer = GetPlayerFromId(playerId)
    return Config.AdminGroups[xPlayer.getGroup()]
end

function GetCharName(identifier)
    local xTarget = GetPlayerFromIdentifier(identifier)
    if xTarget then return xTarget.getName() end

	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users where identifier = ?', {identifier})
    local name = ('%s %s'):format(result?[1]?.firstname, result?[1]?.lastname)

    return name
end

function IsOnDuty(xPlayer)
    return true
end

function GetJob(xPlayer)
    return xPlayer.job
end

function GetJobName(xPlayer)
    return xPlayer.job.name
end

function GetGradeId(xPlayer)
    return xPlayer.job.grade
end

function SetJob(xPlayer, job, grade)
    xPlayer.setJob(job, grade)
end

function IsBoss(xPlayer, page)
    local grade = GetGradeId(xPlayer)
    local job = GetJobName(xPlayer)
    return Config.Jobs?[page]?[job] and grade >= Config.Jobs[page][job]
end

function GetAccountMoney(xPlayer, account)
    return xPlayer.getAccount(account).money
end

function AddAccountMoney(xPlayer, account, amount)
    xPlayer.addAccountMoney(account, amount)
end

function RemoveAccountMoney(xPlayer, account, amount)
    xPlayer.removeAccountMoney(account, amount)
end

function GetItemAmount(xPlayer, item)
    if Config.Inventory == 'default' and string.upper(string.sub(item, 0, 7)) == 'WEAPON_' then
        local has = xPlayer.getWeapon(item)
        return has
    end

    local xItem = xPlayer.getInventoryItem(item)
    return xItem?.count or xItem?.amount or 0
end

function AddItem(xPlayer, item, amount, metadata)
    if Config.Inventory == 'ox' then
        exports.ox_inventory:AddItem(GetSource(xPlayer), item, amount, metadata)
        return
    end

    if Config.Inventory == 'default' and string.upper(string.sub(item, 0, 7)) == 'WEAPON_' then
        xPlayer.addWeapon(item, amount)
        return
    end

    xPlayer.addInventoryItem(item, amount)
end

function RemoveItem(xPlayer, item, amount)
    if Config.Inventory == 'default' and string.upper(string.sub(item, 0, 7)) == 'WEAPON_' then
        xPlayer.removeWeapon(item, amount)
        return
    end

    xPlayer.removeInventoryItem(item, amount)
end

function GetItemLabel(item)
    if Config.Inventory == 'default' and string.upper(string.sub(item, 0, 7)) == 'WEAPON_' then
        return ESX.GetWeaponLabel(item) or item
    end

    return ESX.GetItemLabel(item) or item
end

function GetGradeLabels()
    local data = MySQL.Sync.fetchAll([[
        SELECT
            job_name,
            grade,
            label
        FROM
            job_grades
    ]])

    local labels = {}

    for _,v in ipairs(data) do
        if not labels[v.job_name] then labels[v.job_name] = {} end
        labels[v.job_name][v.grade] = v.label
    end

    return labels
end

function GetJobLabels()
    local data = MySQL.Sync.fetchAll([[
        SELECT
            name,
            label
        FROM
            jobs
    ]])

    local labels = {}
    for _,v in ipairs(data) do
        labels[v.name] = v.label
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
            CONCAT(firstname, ' ', lastname) AS name,
            identifier
        FROM
            users
    ]])

    return data
end

function GetProfiles(page)
    local data = {}

    if page == 'police' then
        data = MySQL.Sync.fetchAll([[
            SELECT
                users.identifier,
                CONCAT(firstname, ' ', lastname) AS name,
                dateofbirth as dob,
                tk_mdt_profiles.image,
                tk_mdt_profiles.tags
            FROM
                users
            LEFT JOIN
                tk_mdt_profiles ON BINARY users.identifier = tk_mdt_profiles.identifier 
        ]])
    else
        data = MySQL.Sync.fetchAll([[
            SELECT
                users.identifier,
                CONCAT(firstname, ' ', lastname) AS name,
                dateofbirth as dob,
                tk_mdt_ems_profiles.image,
                tk_mdt_ems_profiles.tags
            FROM
                users
            LEFT JOIN
                tk_mdt_ems_profiles ON BINARY users.identifier = tk_mdt_ems_profiles.identifier 
        ]])
    end

    for k,v in pairs(data) do
        data[k].sideBarData = {
            warrants = page == 'police' and GetWarrantsByIdentifier(v.identifier),
            tags = json.decode(v.tags) or {},
        }
        v.tags = nil
    end

    return data
end

function GetVehiclesByIdentifier(identifier)
    local data = MySQL.Sync.fetchAll([[
        SELECT
            plate,
            JSON_EXTRACT(vehicle, '$.model') AS model
        FROM
            owned_vehicles
        WHERE
            owner = ?
    ]], {identifier})

    return data
end

function GetLicenses(identifier)
    local licenses = {}
    local data = MySQL.Sync.fetchAll('SELECT type FROM user_licenses WHERE owner = ?', {identifier})

    for _,v in pairs(data) do
        local label = MySQL.Sync.fetchScalar('SELECT label FROM licenses WHERE type = ?', {v.type})
        if label then
            licenses[#licenses+1] = label
        end
    end

    return licenses
end

function GetProfileDataForPolice(identifier)
    local data = MySQL.Sync.fetchAll([[
        SELECT
            sex as gender,
            job,
            job_grade,
            tk_mdt_profiles.notes,
            tk_mdt_profiles.tags,
            tk_mdt_profiles.photos,
            tk_mdt_profiles.licenses,
            tk_mdt_profiles.linkedProfiles
        FROM
            users
        LEFT JOIN
            tk_mdt_profiles ON BINARY users.identifier = tk_mdt_profiles.identifier
        WHERE
            users.identifier = ?
    ]], {identifier})

    local profile = data[1]
    profile.phoneNumber = GetPhoneNumber(identifier)
    profile.gender = profile.gender == 'm' and 'male' or profile.gender == 'f' and 'female' or 'unknown'
    profile.jobs = profile.job and {('%s - %s'):format(jobLabels[profile.job], gradeLabels[profile.job][profile.job_grade])} or {'Unemployed'}
    profile.charges = GetChargesByIdentifier(identifier)
    profile.warrants = GetWarrantsByIdentifier(identifier)
    profile.points = Config.LicensePointsDuration and GetLicensePointsByIdentifier(identifier)
    profile.properties = GetPropertiesByIdentifier(identifier)
    profile.vehicles = GetVehiclesByIdentifier(identifier)
    profile.weapons = GetWeaponsByIdentifier(identifier)
    profile.linkedIncidents = GetIncidentsByIdentifier(identifier)
    profile.linkedReports = GetReportsByIdentifier(identifier)

    if Config.License == 'esx' then
        profile.licenses = GetLicenses(identifier) or {}
    end

    return profile
end

function GetProfileDataForAmbulance(identifier)
    local data = MySQL.Sync.fetchAll([[
        SELECT
            sex as gender,
            tk_mdt_ems_profiles.notes,
            tk_mdt_ems_profiles.tags,
            tk_mdt_ems_profiles.photos,
            tk_mdt_ems_profiles.linkedProfiles
        FROM
            users
        LEFT JOIN
            tk_mdt_ems_profiles ON BINARY users.identifier = tk_mdt_ems_profiles.identifier
        WHERE
            users.identifier = ?
    ]], {identifier})

    local profile = data[1]
    profile.phoneNumber = GetPhoneNumber(identifier)
    profile.gender = profile.gender == 'm' and 'male' or profile.gender == 'f' and 'female' or 'unknown'
    profile.linkedReports = GetReportsByIdentifier(identifier)

    return profile
end

function GetVehicles()
    local data = MySQL.Sync.fetchAll([[
        SELECT
            owned_vehicles.plate,
            JSON_EXTRACT(vehicle, '$.model') AS model,
            CONCAT(users.firstname, ' ', users.lastname) AS owner,
            tk_mdt_vehicles.image,
            tk_mdt_vehicles.tags
        FROM
            owned_vehicles
        LEFT JOIN
            tk_mdt_vehicles ON BINARY owned_vehicles.plate = BINARY tk_mdt_vehicles.plate
        LEFT JOIN
            users ON BINARY owned_vehicles.owner = BINARY users.identifier
    ]])

    for k,v in pairs(data) do
        data[k].sideBarData = {
            bolos = GetBOLOsByPlate(v.plate),
            tags = json.decode(v.tags) or {},
        }
        v.tags = nil
    end

    return data
end

function GetVehicle(plate)
    local query = [[
        SELECT
            JSON_EXTRACT(vehicle, '$.primaryColor') AS customColor,
            JSON_EXTRACT(vehicle, '$.color1') AS color,
            tk_mdt_vehicles.notes,
            tk_mdt_vehicles.tags,
            tk_mdt_vehicles.photos
    ]]

    if HasColumn('owned_vehicles', 'garage') then
        query = query .. ', garage'
    end

    query = query .. [[
        FROM
            owned_vehicles
        LEFT JOIN
            tk_mdt_vehicles ON BINARY owned_vehicles.plate = BINARY tk_mdt_vehicles.plate
        WHERE
            owned_vehicles.plate = ?
    ]]

    local data = MySQL.Sync.fetchAll(query, {plate})

    local vehicle = data[1]
    vehicle.color = vehicle?.customColor and ColorToName(json.decode(vehicle.customColor)) or Config.Colors[tonumber(vehicle.color)] or _U('unknown')
    vehicle.garage = vehicle?.garage or _U('unknown')
    vehicle.bolos = GetBOLOsByPlate(plate)
    vehicle.linkedIncidents = GetIncidentsByPlate(plate)
    vehicle.linkedReports = GetReportsByPlate(plate)

    return vehicle
end

function GetBusinesses()
    local data = MySQL.Sync.fetchAll(string.format([[
        SELECT
            jobs.name,
            label,
            tk_mdt_businesses.image
        FROM
            jobs
        LEFT JOIN
            tk_mdt_businesses ON BINARY jobs.name = tk_mdt_businesses.name
        WHERE
            jobs.name NOT IN ('%s')
    ]], table.concat(Config.ExcludedBusinesses, "','")))

    return data
end

function GetEmployeesByBusiness(name)
    local data = MySQL.Sync.fetchAll([[
        SELECT
            identifier,
            CONCAT(firstname, ' ', lastname) AS name,
            job_grade
        FROM
            users
        WHERE
            users.job = ?
    ]], {name})

    for k,v in pairs(data) do
        data[k].name = ('%s - %s'):format(v.name, gradeLabels[name][v.job_grade])
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
                CONCAT(users.firstname, ' ', users.lastname) AS traineeName
            FROM
                tk_mdt_training_reports
            LEFT JOIN
                users ON BINARY tk_mdt_training_reports.trainee = users.identifier
        ]])
    else
        data = MySQL.Sync.fetchAll([[
            SELECT
                tk_mdt_training_reports.id,
                tk_mdt_training_reports.title,
                tk_mdt_training_reports.trainee,
                tk_mdt_training_reports.date,
                tk_mdt_training_reports.creator,
                CONCAT(users.firstname, ' ', users.lastname) AS traineeName
            FROM
                tk_mdt_training_reports
            LEFT JOIN
                users ON BINARY tk_mdt_training_reports.trainee = users.identifier
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

    local data = MySQL.Sync.fetchAll([[
        SELECT
            users.identifier,
            CONCAT(firstname, ' ', lastname) AS name,
            job,
            job_grade as grade,
            tk_mdt_officers.image,
            tk_mdt_officers.callsign,
            tk_mdt_officers.status,
            tk_mdt_officers.licenses,
            tk_mdt_officers.notes
        FROM
            users
        LEFT JOIN
            tk_mdt_officers ON BINARY users.identifier = tk_mdt_officers.identifier
        WHERE
            job IN (?)
    ]], {policeJobs})

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
            users.identifier,
            CONCAT(firstname, ' ', lastname) AS name,
            job,
            job_grade as grade,
            tk_mdt_paramedics.image,
            tk_mdt_paramedics.callsign,
            tk_mdt_paramedics.status,
            tk_mdt_paramedics.licenses,
            tk_mdt_paramedics.notes
        FROM
            users
        LEFT JOIN
            tk_mdt_paramedics ON BINARY users.identifier = tk_mdt_paramedics.identifier
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

RegisterCallback('tk_mdt:getItemLabel', function(src, cb, item)
	cb(GetItemLabel(item))
end)

RegisterCallback('tk_mdt:getCharName', function(src, cb)
	cb(GetCharName(GetIdentifier(GetPlayerFromId(src))))
end)

RegisterCallback('tk_mdt:getPhoneNumber', function(src, cb)
	cb(GetPhoneNumber(GetIdentifier(GetPlayerFromId(src))))
end)

RegisterNetEvent('esx_identity:completedRegistration', function(src, data)
    RegisterCharacter(src, {
        name = ('%s %s'):format(data.firstname, data.lastname),
        dob = data.dateofbirth,
    })
end)

CreateThread(function()
    repeat Wait(100) until ESX

    frameworkLoaded = true
end)