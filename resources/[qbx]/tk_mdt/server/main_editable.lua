function Notify(src, text, notifyType)
    if Config.NotificationType == 'mythic' then
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = notifyType, text = text})
    else
        ShowNotification(src, text, notifyType)
    end
end

function Webhook(message)
    if not ConfigSV.WebhookLink or ConfigSV.WebhookLink == '' then return end

    local msg = {{["color"] = Config.WebhookColor, ["title"] = "**".. _U('webhook_title') .."**", ["description"] = message, ["footer"] = { ["text"] = os.date("%d.%m.%y Time: %X")}}}
    PerformHttpRequest(ConfigSV.WebhookLink, function(err, text, headers) end, 'POST', json.encode({embeds = msg}), { ['Content-Type'] = 'application/json' })
end

function GetProfileDataForCitizen(identifier)
    local data = MySQL.Sync.fetchAll([[
        SELECT
            licenses
        FROM
            tk_mdt_profiles
        WHERE
            identifier = ?
    ]], {identifier})

    local profile = data[1] or {}
    profile.charges = GetChargesByIdentifier(identifier)
    profile.warrants = GetWarrantsByIdentifier(identifier)
    profile.points = Config.LicensePointsDuration and GetLicensePointsByIdentifier(identifier)
    profile.properties = GetPropertiesByIdentifier(identifier)
    profile.vehicles = GetVehiclesByIdentifier(identifier)

    return profile
end

---Allows you to add additional data to the sidebar, remember to add the table keys to the locales file, also, remember to add they keys to Config.SidebarOrder
---@param id number | string
---@param page string
---@return table<string>|nil
function GetAdditionalSidebarData(id, page)
    if page == 'profile' then
        return {
            --bloodType = {'B-'},
            --pets = {'dog', 'cat'},
        }
    end

    return
end

function GetPhoneNumber(identifier)
    if Config.Phone == 'lb' then
        local phoneNumber = MySQL.Sync.fetchScalar([[
            SELECT
                phone_number
            FROM
                phone_phones
            WHERE
                id = ?
        ]], {identifier})

        return phoneNumber or _U('unknown')
    elseif Config.Phone == 'gks' then
        local phoneNumber = MySQL.Sync.fetchScalar([[
            SELECT
                phone_number
            FROM
                gksphone_settings
            WHERE
                identifier = ?
        ]], {identifier})

        return phoneNumber
    elseif Config.Phone == 'high' then
        local xPlayer = GetPlayerFromIdentifier(identifier)
        return xPlayer and exports.high_phone:getPlayerPhoneNumber(GetSource(xPlayer)) or _U('unknown')
    elseif Config.Phone == 'yseries' then
        return exports.yseries:GetPhoneNumberByIdentifier(identifier) or _U('unknown')
    elseif Config.Phone == 'okok' then
        local xPlayer = GetPlayerFromIdentifier(identifier)
        return xPlayer and exports.okokPhone:getPhoneNumberFromSource(GetSource(xPlayer)) or _U('unknown')
    elseif Config.Framework == 'qb' then
        local phoneNumber = MySQL.Sync.fetchScalar([[
            SELECT
                JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.phone')) AS phone_number
            FROM
                players
            WHERE
                citizenid = ?
        ]], {identifier})

        return phoneNumber or _U('unknown')
    elseif Config.Framework == 'esx' then
        local phoneNumber = MySQL.Sync.fetchScalar([[
            SELECT
                phone_number
            FROM
                users
            WHERE
                identifier = ?
        ]], {identifier})

        return phoneNumber or _U('unknown')
    end

    return _U('unknown')
end

function GetPropertiesByIdentifier(identifier)
    if Config.Housing == 'tk' then
        local data = MySQL.Sync.fetchAll([[
            SELECT
                id
            FROM
                owned_houses
            WHERE
                owner = ?
        ]], {identifier})

        for _,v in pairs(data) do
            v.name = _U('house')
        end

        return data
    elseif Config.Housing == 'qb' then
        local data = MySQL.Sync.fetchAll([[
            SELECT
                id
            FROM
                player_houses
            WHERE
                citizenid = ?
        ]], {identifier})

        for _,v in pairs(data) do
            v.name = _U('house')
        end

        return data
    elseif Config.Housing == 'qbx' then
        local data = MySQL.Sync.fetchAll([[
            SELECT
                id,
                property_name as name
            FROM
                properties
            WHERE
                owner = ?
        ]], {identifier})

        return data
    elseif Config.Housing == 'ps' then
        local data = MySQL.Sync.fetchAll([[
            SELECT
                property_id as id,
                street as name
            FROM
                properties
            WHERE
                owner_citizenid = ?
        ]], {identifier})

        return data
    elseif Config.Housing == 'loaf' then
        local data = MySQL.Sync.fetchAll([[
            SELECT
                id
            FROM
                loaf_properties
            WHERE
                owner = ?
        ]], {identifier})

        for _,v in pairs(data) do
            v.name = _U('house')
        end

        return data
    elseif Config.Housing == 'qs' then
        local data = MySQL.Sync.fetchAll([[
            SELECT
                player_houses.id,
                houselocations.label as name
            FROM
                player_houses
            LEFT JOIN
                houselocations ON player_houses.house = houselocations.name
            WHERE
                owner = ?
        ]], {identifier})

        return data
    elseif Config.Housing == 'cylex' then
        local houses = exports.cylex_housing:getOwnedHouses(identifier)

        local data = {}
        for _, v in pairs(houses) do
            data[#data+1] = {id = v.id, name = v.streetName}
        end

        return data
    elseif Config.Housing == 'nolag' then
        local houses = exports.nolag_properties:GetAllProperties(identifier, 'user')

        local data = {}
        for _, v in pairs(houses) do
            data[#data+1] = {id = v.id, name = v.label}
        end

        return data
    end

    return {}
end

function GetProperties()
    if Config.Housing == 'tk' then
        local data = MySQL.Sync.fetchAll([[
            SELECT
                owned_houses.id,
                owner,
                coords
            FROM
                owned_houses
            LEFT JOIN
                tk_mdt_properties ON owned_houses.id = tk_mdt_properties.id
            WHERE
                owner IS NOT NULL
        ]])

        for _,v in pairs(data) do
            local c = json.decode(v.coords)
            v.coords = {x = c.enterCoords.x, y = c.enterCoords.y}
            v.owner = v.owner and GetCharName(v.owner)
            v.name = _U('house')
        end

        return data
    elseif Config.Housing == 'qb' then
        local data = MySQL.Sync.fetchAll([[
            SELECT
                id,
                citizenid as owner
            FROM
                player_houses
            WHERE
                citizenid IS NOT NULL
        ]])

        for _,v in pairs(data) do
            v.owner = GetCharName(v.owner)
            v.name = _U('house')
        end

        return data
    elseif Config.Housing == 'qbx' then
        local data = MySQL.Sync.fetchAll([[
            SELECT
                id,
                owner,
                property_name as name
            FROM
                properties
            WHERE
                owner IS NOT NULL
        ]])

        for _,v in pairs(data) do
            v.owner = GetCharName(v.owner)
        end

        return data
    elseif Config.Housing == 'ps' then
        local data = MySQL.Sync.fetchAll([[
            SELECT
                property_id as id,
                street as name,
                owner_citizenid as owner
            FROM
                properties
            WHERE
                owner_citizenid IS NOT NULL
        ]])

        for _,v in pairs(data) do
            v.owner = GetCharName(v.owner)
        end

        return data
    elseif Config.Housing == 'loaf' then
        local data = MySQL.Sync.fetchAll([[
            SELECT
                id,
                owner
            FROM
                loaf_properties
            WHERE
                owner IS NOT NULL
        ]])

        for _,v in pairs(data) do
            v.owner = GetCharName(v.owner)
            v.name = _U('house')
        end

        return data
    elseif Config.Housing == 'qs' then
        local data = MySQL.Sync.fetchAll([[
            SELECT
                player_houses.id,
                player_houses.citizenid as owner,
                houselocations.label as name,
                houselocations.coords
            FROM
                player_houses
            LEFT JOIN
                houselocations ON player_houses.house = houselocations.name
            WHERE
                citizenid IS NOT NULL
        ]])

        for _,v in pairs(data) do
            local c = json.decode(v.coords)
            v.coords = {x = c.enter.x, y = c.enter.y}
            v.owner = GetCharName(v.owner)
        end

        return data
    elseif Config.Housing == 'cylex' then
        local houses = exports.cylex_housing:getHousesData()
        local data = {}

        for _, v in pairs(houses) do
            data[#data+1] = {
                id = v.id,
                name = v.streetName,
                coords = {x = v.enterCoords.x, y = v.enterCoords.y},
                owner = GetCharName(v.owner)
            }
        end

        return data
    elseif Config.Housing == 'nolag' then
        local houses = {}

        for _,profile in pairs(profiles) do
            local data = exports.nolag_properties:GetAllProperties(profile.identifier, 'user')
            for _,v in pairs(data) do
                houses[#houses+1] = {
                    id = v.id,
                    name = v.label,
                    owner = GetCharName(profile.identifier),
                }
            end
        end

        return houses
    end

    return {}
end

function GetProperty(id)
    local data = MySQL.Sync.fetchAll([[
        SELECT
            notes,
            tags,
            linkedProfiles,
            photos
        FROM
            tk_mdt_properties
        WHERE
            id = ?
    ]], {id})

    local property = data[1] or {}
    return property
end

function AddEmployee(playerId)
    local xPlayer = GetPlayerFromId(playerId)
    local jobName = GetJobName(xPlayer)
    local employeeData = Config.Jobs.police[jobName] and officers or Config.Jobs.ambulance[jobName] and paramedics
    if not employeeData then return end

    local gradeId = GetGradeId(xPlayer)
    local identifier = GetIdentifier(xPlayer)

    local employeeIndex = GetEmployeeIndexByIdentifier(identifier, employeeData)

    if employeeIndex then
        employeeData[employeeIndex].grade = GetGradeLabel(jobName, gradeId)
        employeeData[employeeIndex].gradeNumber = gradeId
    else
        employeeIndex = #employeeData + 1
        employeeData[employeeIndex] = {
            identifier = GetIdentifier(xPlayer),
            name = GetCharName(GetIdentifier(xPlayer)),
            job = jobName,
            grade = GetGradeLabel(jobName, gradeId),
            gradeNumber = gradeId,
            callsign = 'N/A',
            phoneNumber = GetPhoneNumber(identifier),
            licenses = {},
            status = Config.Status[1],
            image = '',
            notes = '',
        }
    end

    local players = Config.Jobs.police[jobName] and policePlayers or Config.Jobs.ambulance[jobName] and ambulancePlayers
    for i = 1, #players do
        TriggerClientEvent('tk_mdt:addEmployee', players[i], employeeData[employeeIndex])
    end
end

function SaveProfile(data)
    MySQL.Async.execute([[
        INSERT INTO
            tk_mdt_profiles (identifier, image, notes, tags, licenses, linkedProfiles, photos)
        VALUES
            (?, ?, ?, ?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE
            image = VALUES(image),
            notes = VALUES(notes),
            tags = VALUES(tags),
            licenses = VALUES(licenses),
            linkedProfiles = VALUES(linkedProfiles),
            photos = VALUES(photos)
    ]], {data.identifier, data.image, data.notes, json.encode(data.sideBarData.tags), json.encode(data.sideBarData.licenses), json.encode(data.sideBarData.linkedProfiles), json.encode(data.sideBarData.photos)})

    if Config.License == 'default' or type(data.sideBarData.licenses) ~= 'table' or type(Config.Licenses) ~= 'table' then return end

    local newLicenses = {}
    for _,v in pairs(data.sideBarData.licenses) do
        for name,label in pairs(Config.Licenses) do
            if v == label then
                newLicenses[name] = true
            end
        end
    end

    if Config.License == 'esx' then
        MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = ?', {data.identifier}, function(currentLicenses)
            local currentLicensesSet = {}
            for _,v in pairs(currentLicenses) do
                currentLicensesSet[v.type] = true
            end

            for _,v in pairs(currentLicenses) do
                if not newLicenses[v.type] then
                    MySQL.Sync.execute('DELETE FROM user_licenses WHERE type = ? AND owner = ?', {v.type, data.identifier})
                end
            end

            for k in pairs(newLicenses) do
                if not currentLicensesSet[k] then
                    MySQL.Sync.execute('INSERT IGNORE INTO user_licenses (type, owner) VALUES (?, ?)', {k, data.identifier})
                end
            end
        end)
    elseif Config.License == 'qb' then
        local xPlayer = GetPlayerFromIdentifier(data.identifier)
        if xPlayer then
            xPlayer.Functions.SetMetaData("licences", newLicenses)
        end

        local metadata = json.decode(MySQL.Sync.fetchScalar('SELECT metadata FROM players WHERE citizenid = ?', {data.identifier}))
        metadata.licences = newLicenses

        MySQL.Sync.execute('UPDATE `players` SET `metadata` = ? WHERE citizenid = ?', {json.encode(metadata), data.identifier})
    end
end

RegisterNetEvent('tk_mdt:jailPlayer', function(data)
    local src = source
    local xPlayer = GetPlayerFromId(src)
    local job = GetJobName(xPlayer)
    if not Config.Jobs.police[job] then return end

    local xTarget = GetPlayerFromIdentifier(data.targetIdentifier)
    if not xTarget then return end

    local targetId = GetSource(xTarget)
    exports.pickle_prisons:JailPlayer(targetId, data.time, 'default')
end)

if Config.Dispatch == 'tk' then
    RegisterServerEvent('tk_dispatch:addCall', function(data)
        for _,v in pairs(data.jobs) do
            if Config.Jobs.police[v] then
                exports.tk_mdt:addCall({title = data.title, coords = data.coords, location = data.location, time = data.removeTime, callsign = data.code, gender = data.gender, vehicle = data.vehicle, weapon = data.weapon, type = 'police'})
                return
            elseif Config.Jobs.ambulance[v] then
                exports.tk_mdt:addCall({title = data.title, coords = data.coords, location = data.location, time = data.removeTime, callsign = data.code, gender = data.gender, vehicle = data.vehicle, weapon = data.weapon, type = 'ambulance'})
                return
            end
        end
    end)
end

if Config.Dispatch == 'cd' then
    RegisterServerEvent('cd_dispatch:AddNotification', function(data)
        for _,v in pairs(data.job_table) do
            if Config.Jobs.police[v] then
                exports.tk_mdt:addCall({title = data.title, coords = data.coords, type = 'police'})
                return
            elseif Config.Jobs.ambulance[v] then
                exports.tk_mdt:addCall({title = data.title, coords = data.coords, type = 'ambulance'})
                return
            end
        end
    end)
end

if Config.Dispatch == 'qs' then
    RegisterServerEvent('qs-dispatch:server:CreateDispatchCall', function(data)
        for _,v in pairs(data.job) do
            if Config.Jobs.police[v] then
                exports.tk_mdt:addCall({title = data.message, callsign = data.callCode?.code, coords = data.callLocation, type = 'police'})
                return
            elseif Config.Jobs.ambulance[v] then
                exports.tk_mdt:addCall({title = data.message, callsign = data.callCode?.code, coords = data.callLocation, type = 'ambulance'})
                return
            end
        end
    end)
end

if Config.Dispatch == 'ps' then
    RegisterServerEvent('ps-dispatch:server:notify', function(data)
        for _,v in pairs(data.jobs) do
            if Config.Jobs.police[v] then
                exports.tk_mdt:addCall({title = data.message, callsign = data.code, coords = data.coords, location = data.street, gender = data.gender, weapon = data.weapon, vehicle = data.vehicle and {plate = data.plate, color = data.color, name = data.vehicle}, type = 'police'})
                return
            elseif Config.Jobs.ambulance[v] then
                exports.tk_mdt:addCall({title = data.message, callsign = data.code, coords = data.coords, location = data.street, gender = data.gender, weapon = data.weapon, vehicle = data.vehicle and {plate = data.plate, color = data.color, name = data.vehicle}, type = 'ambulance'})
                return
            end
        end
    end)
end

if Config.Dispatch == 'core' then
    RegisterServerEvent('core_dispatch:addMessage', function(data)
        local jobType = Config.Jobs.police[data.job] and 'police' or Config.Jobs.ambulance[data.job] and 'ambulance'
        if not jobType then return end

        exports.tk_mdt:addCall({title = data.message, coords = data.coords, type = jobType})
    end)
end

if Config.Dispatch == 'rcore' then
    RegisterServerEvent('rcore_dispatch:server:sendAlert', function(data)
        local jobType = Config.Jobs.police[data.job] and 'police' or Config.Jobs.ambulance[data.job] and 'ambulance'
        if not jobType then return end

        exports.tk_mdt:addCall({title = data.text, coords = data.coords, callsign = data.code, type = jobType})
    end)
end