local defaultSpawn = require 'config.shared'.defaultSpawn
local characterDataTables = require 'config.server'.characterDataTables

---@param request InsertBanRequest
---@return boolean success
---@return ErrorResult? errorResult
local function insertBan(request)
    if not request.discordId and not request.ip and not request.license then
        return false, {
            code = 'no_identifier',
            message = 'discordId, ip, or license required in the ban request'
        }
    end

    MySQL.insert.await('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        request.name,
        request.license,
        request.discordId,
        request.ip,
        request.reason,
        request.expiration,
        request.bannedBy,
    })
    return true
end

---@param request GetBanRequest
---@return string column in storage
---@return string value of the id
local function getBanId(request)
    if request.license then
        return 'license', request.license
    elseif request.discordId then
        return 'discord', request.discordId
    elseif request.ip then
        return 'ip', request.ip
    else
        error('no identifier provided', 2)
    end
end

---@param request GetBanRequest
---@return BanEntity?
local function fetchBan(request)
    local column, value = getBanId(request)
    local result = MySQL.single.await('SELECT expire, reason FROM bans WHERE ' ..column.. ' = ?', { value })
    return result and {
        expire = result.expire,
        reason = result.reason,
    } or nil
end

---@param request GetBanRequest
local function deleteBan(request)
    local column, value = getBanId(request)
    MySQL.query.await('DELETE FROM bans WHERE ' ..column.. ' = ?', { value })
end

---@param request UpsertPlayerRequest
local function upsertPlayerEntity(request)
    MySQL.insert.await('INSERT INTO players (citizenid, cid, license, name, money, charinfo, job, gang, position, metadata, last_logged_out) VALUES (:citizenid, :cid, :license, :name, :money, :charinfo, :job, :gang, :position, :metadata, :last_logged_out) ON DUPLICATE KEY UPDATE name = :name, money = :money, charinfo = :charinfo, job = :job, gang = :gang, position = :position, metadata = :metadata, last_logged_out = :last_logged_out', {
        citizenid = request.playerEntity.citizenid,
        cid = request.playerEntity.charinfo.cid,
        license = request.playerEntity.license,
        name = request.playerEntity.name,
        money = json.encode(request.playerEntity.money),
        charinfo = json.encode(request.playerEntity.charinfo),
        job = json.encode(request.playerEntity.job),
        gang = json.encode(request.playerEntity.gang),
        position = json.encode(request.position),
        metadata = json.encode(request.playerEntity.metadata),
        last_logged_out = os.date('%Y-%m-%d %H:%M:%S', request.playerEntity.lastLoggedOut)
    })
end

---@param citizenId string
---@return PlayerSkin?
local function fetchPlayerSkin(citizenId)
    return MySQL.single.await('SELECT * FROM playerskins WHERE citizenid = ? AND active = 1', {citizenId})
end

local function convertPosition(position)
    local pos = json.decode(position)
    local actualPos = (not pos.x or not pos.y or not pos.z) and defaultSpawn or pos
    return vec4(actualPos.x, actualPos.y, actualPos.z, actualPos.w or defaultSpawn.w)
end

---@param license2 string
---@param license? string
---@return PlayerEntity[]
local function fetchAllPlayerEntities(license2, license)
    ---@type PlayerEntity[]
    local chars = {}
    ---@type PlayerEntityDatabase[]
    local result = MySQL.query.await('SELECT citizenid, charinfo, money, job, gang, position, metadata, UNIX_TIMESTAMP(last_logged_out) AS lastLoggedOutUnix FROM players WHERE license = ? OR license = ? ORDER BY cid', {license, license2})
    for i = 1, #result do
        chars[i] = result[i]
        chars[i].charinfo = json.decode(result[i].charinfo)
        chars[i].money = json.decode(result[i].money)
        chars[i].job = result[i].job and json.decode(result[i].job)
        chars[i].gang = result[i].gang and json.decode(result[i].gang)
        chars[i].position = convertPosition(result[i].position)
        chars[i].metadata = json.decode(result[i].metadata)
        chars[i].lastLoggedOut = result[i].lastLoggedOutUnix
    end

    return chars
end

---@param citizenId string
---@return PlayerEntity?
local function fetchPlayerEntity(citizenId)
    ---@type PlayerEntityDatabase
    local player = MySQL.single.await('SELECT citizenid, license, name, charinfo, money, job, gang, position, metadata, UNIX_TIMESTAMP(last_logged_out) AS lastLoggedOutUnix FROM players WHERE citizenid = ?', { citizenId })
    local charinfo = json.decode(player.charinfo)
    return player and {
        citizenid = player.citizenid,
        license = player.license,
        name = player.name,
        money = json.decode(player.money),
        charinfo = charinfo,
        cid = charinfo.cid,
        job = player.job and json.decode(player.job),
        gang = player.gang and json.decode(player.gang),
        position = convertPosition(player.position),
        metadata = json.decode(player.metadata),
        lastLoggedOut = player.lastLoggedOutUnix
    } or nil
end

---Checks if a table exists in the database
---@param tableName string
---@return boolean
local function doesTableExist(tableName)
    local tbl = MySQL.single.await(('SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_NAME = \'%s\' AND TABLE_SCHEMA in (SELECT DATABASE())'):format(tableName))
    return tbl['COUNT(*)'] > 0
end

---deletes character data using the characterDataTables object in the config file
---@param citizenId string
---@return boolean success if operation is successful.
local function deletePlayer(citizenId)
    local query = 'DELETE FROM %s WHERE %s = ?'
    local queries = {}

    for i = 1, #characterDataTables do
        local data = characterDataTables[i]
        local tableName = data[1]
        local columnName = data[2]
        if doesTableExist(tableName) then
            queries[#queries + 1] = {
                query = query:format(tableName, columnName),
                values = {
                    citizenId,
                }
            }
        else
            warn(('Table %s does not exist in database, please remove it from qbx_core/config/server.lua or create the table'):format(tableName))
        end
    end

    local success = MySQL.transaction.await(queries)
    return not not success
end

---checks the storage for uniqueness of the given value
---@param type UniqueIdType
---@param value string|number
---@return boolean isUnique if the value does not already exist in storage for the given type
local function fetchIsUnique(type, value)
    local typeToColumn = {
        citizenid = 'citizenid',
        AccountNumber = "JSON_VALUE(charinfo, '$.account')",
        PhoneNumber = "JSON_VALUE(charinfo, '$.phone')",
        FingerId = "JSON_VALUE(metadata, '$.fingerprint')",
        WalletId = "JSON_VALUE(metadata, '$.walletid')",
        SerialNumber = "JSON_VALUE(metadata, '$.phonedata.SerialNumber')",
    }

    local result = MySQL.single.await('SELECT COUNT(*) as count FROM players WHERE ' .. typeToColumn[type] .. ' = ?', { value })
    return result.count == 0
end

---@param citizenid string
---@param type GroupType type
---@param group string
---@param grade integer
local function addToGroup(citizenid, type, group, grade)
    MySQL.insert('INSERT INTO player_groups (citizenid, type, `group`, grade) VALUES (:citizenid, :type, :group, :grade) ON DUPLICATE KEY UPDATE grade = :grade', {
        citizenid = citizenid,
        type = type,
        group = group,
        grade = grade,
    })
end

---@param citizenid string
---@param group string
---@param grade integer
local function addPlayerToJob(citizenid, group, grade)
    addToGroup(citizenid, GroupType.JOB, group, grade)
end

---@param citizenid string
---@param group string
---@param grade integer
local function addPlayerToGang(citizenid, group, grade)
    addToGroup(citizenid, GroupType.GANG, group, grade)
end

---@param citizenid string
---@return table<string, integer> jobs
---@return table<string, integer> gangs
local function fetchPlayerGroups(citizenid)
    local groups = MySQL.query.await('SELECT `group`, type, grade FROM player_groups WHERE citizenid = ?', {citizenid})
    local jobs = {}
    local gangs = {}
    for i = 1, #groups do
        local group = groups[i]
        local validGroup = group.type == GroupType.JOB and GetJob(group.group) or GetGang(group.group)
        if not validGroup then
            lib.print.warn(('Invalid group %s found in player_groups table, Does it exist in shared/%ss.lua?'):format(group.group, group.type))
        elseif not validGroup.grades?[group.grade] then
            lib.print.warn(('Invalid grade %s found in player_groups table for %s %s, Does it exist in shared/%ss.lua?'):format(group.grade, group.type, group.group, group.type))
        elseif group.type == GroupType.JOB then
            jobs[group.group] = group.grade
        elseif group.type == GroupType.GANG then
            gangs[group.group] = group.grade
        end
    end
    return jobs, gangs
end

---@param group string
---@param type GroupType
---@return table<string, integer> players
local function fetchGroupMembers(group, type)
    return MySQL.query.await("SELECT citizenid, grade FROM player_groups WHERE `group` = ? AND `type` = ?", {group, type})
end

---@param citizenid string
---@param type GroupType
---@param group string
local function removeFromGroup(citizenid, type, group)
    MySQL.query.await('DELETE FROM player_groups WHERE citizenid = ? AND type = ? AND `group` = ?', {citizenid, type, group})
end

---@param citizenid string
---@param group string
local function removePlayerFromJob(citizenid, group)
    removeFromGroup(citizenid, GroupType.JOB, group)
end

---@param citizenid string
---@param group string
local function removePlayerFromGang(citizenid, group)
    removeFromGroup(citizenid, GroupType.GANG, group)
end

---Copies player's primary job/gang to the player_groups table. Works for online/offline players.
---Idempotent
RegisterCommand('convertjobs', function(source)
	if source ~= 0 then return warn('This command can only be executed using the server console.') end

    local players = MySQL.query.await('SELECT citizenid, JSON_VALUE(job, \'$.name\') AS jobName, JSON_VALUE(job, \'$.grade.level\') AS jobGrade, JSON_VALUE(gang, \'$.name\') AS gangName, JSON_VALUE(gang, \'$.grade.level\') AS gangGrade FROM players')
    for i = 1, #players do
        local player = players[i]
        local success, err = pcall(AddPlayerToJob, player.citizenid, player.jobName, tonumber(player.jobGrade))
        if not success then lib.print.error(err) end
        success, err = pcall(AddPlayerToGang, player.citizenid, player.gangName, tonumber(player.gangGrade))
        if not success then lib.print.error(err) end
    end

    lib.print.info('Converted jobs and gangs successfully')
    TriggerEvent('qbx_core:server:jobsconverted')
end, true)

---Removes invalid groups from the player_groups table.
local function cleanPlayerGroups()
    local groups = MySQL.query.await('SELECT DISTINCT `group`, type, grade FROM player_groups')
    for i = 1, #groups do
        local group = groups[i]
        local validGroup = group.type == GroupType.JOB and GetJob(group.group) or GetGang(group.group)
        if not validGroup then
            MySQL.query.await('DELETE FROM player_groups WHERE `group` = ? AND type = ?', {group.group, group.type})
            lib.print.info(('Remove invalid %s %s from player_groups table'):format(group.type, group.group))
        elseif not validGroup.grades?[group.grade] then
            MySQL.query.await('DELETE FROM player_groups WHERE `group` = ? AND type = ? AND grade = ?', {group.group, group.type, group.grade})
            lib.print.info(('Remove invalid %s %s grade %s from player_groups table'):format(group.type, group.group, group.grade))
        end
    end

    lib.print.info('Removed invalid groups from player_groups table')
end

RegisterCommand('cleanplayergroups', function(source)
	if source ~= 0 then return warn('This command can only be executed using the server console.') end
    cleanPlayerGroups()
end, true)

CreateThread(function()
    for _, data in pairs(characterDataTables) do
        local tableName = data[1]
        if not doesTableExist(tableName) then
            warn(('Table \'%s\' does not exist in database, please remove it from qbx_core/config/server.lua or create the table'):format(tableName))
        end
    end
    if GetConvar('qbx:cleanPlayerGroups', 'false') == 'true' then
        cleanPlayerGroups()
    end
end)

return {
    insertBan = insertBan,
    fetchBan = fetchBan,
    deleteBan = deleteBan,
    upsertPlayerEntity = upsertPlayerEntity,
    fetchPlayerSkin = fetchPlayerSkin,
    fetchPlayerEntity = fetchPlayerEntity,
    fetchAllPlayerEntities = fetchAllPlayerEntities,
    deletePlayer = deletePlayer,
    fetchIsUnique = fetchIsUnique,
    addPlayerToJob = addPlayerToJob,
    addPlayerToGang = addPlayerToGang,
    fetchPlayerGroups = fetchPlayerGroups,
    fetchGroupMembers = fetchGroupMembers,
    removePlayerFromJob = removePlayerFromJob,
    removePlayerFromGang = removePlayerFromGang,
}
