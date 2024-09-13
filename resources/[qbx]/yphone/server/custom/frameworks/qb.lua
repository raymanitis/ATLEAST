CreateThread(function()
    if Config.Framework ~= 'qb' then return end

    local QBCore = exports["qb-core"]:GetCoreObject()
    Framework = {
        GetPlayerFromId = function(source)
            local xPlayer = {}
            local qbPlayer = QBCore.Functions.GetPlayer(source)
            ---------
            if not qbPlayer then
                return nil
            end
            xPlayer.source = qbPlayer.PlayerData.source
            ---------
            xPlayer.identifier = qbPlayer.PlayerData.citizenid
            ---------
            local gradeName = "none"
            local gradeLevel = -1

            if qbPlayer.PlayerData.job.grade then
                gradeName = qbPlayer.PlayerData.job.grade.name
                gradeLevel = qbPlayer.PlayerData.job.grade.level
            end

            xPlayer.job = {
                name = qbPlayer.PlayerData.job.name,
                label = qbPlayer.PlayerData.job.label,
                grade = {
                    name = gradeName,
                    level = gradeLevel
                },
                isboss = qbPlayer.PlayerData.job.isboss
            }
            ---------
            xPlayer.playerData = qbPlayer.PlayerData
            ---------
            xPlayer.getJob = function()
                if not qbPlayer.PlayerData.job or not qbPlayer.PlayerData.job.grade then
                    return {
                        grade = 0,
                        grade_name = nil,
                        name = nil
                    }
                end

                if qbPlayer.PlayerData.job.grade then
                    gradeName = qbPlayer.PlayerData.job.grade.name
                    gradeLevel = qbPlayer.PlayerData.job.grade.level
                end

                return {
                    grade = gradeLevel,
                    grade_name = gradeName,
                    name = qbPlayer.PlayerData.job.name or "none"
                }
            end
            ---------
            xPlayer.getName = function()
                if qbPlayer.PlayerData.charinfo and qbPlayer.PlayerData.charinfo.firstname and qbPlayer.PlayerData.charinfo.lastname then
                    return qbPlayer.PlayerData.charinfo.firstname .. " " .. qbPlayer.PlayerData.charinfo.lastname
                else
                    return qbPlayer.PlayerData.name
                end
            end
            ---------
            xPlayer.addAccountMoney = function(type, money, reason)
                if type == "money" then
                    type = "cash"
                end
                qbPlayer.Functions.AddMoney(type, money, reason)
            end
            ---------
            xPlayer.getAccount = function(type)
                return {
                    money = qbPlayer.Functions.GetMoney(type) or 0
                }
            end
            ---------
            xPlayer.removeAccountMoney = function(type, money, reason)
                return qbPlayer.Functions.RemoveMoney(type, money, reason)
            end
            return xPlayer
        end,
        GetPlayerFromIdentifier = function(citizenid)
            local qbPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenid)
            if not qbPlayer then
                return nil
            end
            return Framework.GetPlayerFromId(qbPlayer.PlayerData.source)
        end,
    }

    function GetOfflineCharacterName(identifier)
        local playersTable = 'players'

        local result = MySQL.query.await([[
          SELECT
              JSON_VALUE(charinfo, '$.firstname') AS firstname,
              JSON_VALUE(charinfo, '$.lastname') AS lastname
          FROM `]] .. playersTable .. [[`
          WHERE citizenid = ?
      ]], { identifier })
        return result[1] and result[1].firstname .. ' ' .. result[1].lastname or "Unknown"
    end

    -- * Get an array of all players with a certain job.
    function GetEmployees(job)
        local employees = {}

        local players = QBCore.Functions.GetQBPlayers()
        for _, v in pairs(players) do
            if v?.PlayerData.job.name == job and v.PlayerData.job.onduty then
                employees[#employees + 1] = v.PlayerData.source
            end
        end

        return employees
    end

    -- * Refresh the online status of all companies.
    function RefreshCompanies()
        local openJobs = {}
        local players = QBCore.Functions.GetQBPlayers()
        for _, v in pairs(players) do
            if not v?.PlayerData.job.onduty then
                goto continue
            end

            local job = v.PlayerData.job.name
            if not openJobs[job] then
                openJobs[job] = true
            end

            ::continue::
        end

        for i = 1, #Config.Companies.Services do
            local jobData = Config.Companies.Services[i]


            if Config.Companies.Services[i].job == Config.Companies.PoliceJob and Config.Companies.PoliceAlwaysAvailable then
                Config.Companies.Services[i].open = true -- Always appear as online.
            else
                Config.Companies.Services[i].open = openJobs[jobData.job] or false
            end
        end
    end

    lib.callback.register('yseries:server:companies:get-employees-ids', function(_, job)
        local employees = {}

        local players = MySQL.query.await("SELECT citizenid FROM `players` WHERE JSON_EXTRACT(`job`, '$.name') = '" ..
            job .. "'")

        if players[1] then
            for _, value in pairs(players) do
                local employee = QBCore.Functions.GetPlayerByCitizenId(value.citizenid)

                if employee and employee.PlayerData.job.name == job then
                    employees[#employees + 1] = {
                        playerId = employee.PlayerData.citizenid,
                        source = employee.PlayerData.source,
                    }
                end
            end

            return employees
        end

        return nil
    end)

    -- * Toggle a player's duty status.
    lib.callback.register('yseries:server:companies:toggle-duty', function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return end

        if Player.PlayerData.job.onduty then
            Player.Functions.SetJobDuty(false)

            return false
        else
            Player.Functions.SetJobDuty(true)

            return true
        end
    end)
end)
