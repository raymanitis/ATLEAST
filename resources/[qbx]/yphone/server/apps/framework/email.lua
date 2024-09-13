function ExportHandler(resource, name, cb)
    AddEventHandler(('__cfx_export_%s_%s'):format(resource, name), function(setCB)
        setCB(cb)
    end)
end

lib.callback.register('yseries:server:email:get', function(_, page, phoneImei)
    local totalMails = MySQL.scalar.await([[
        SELECT COUNT(*) AS totalMails
        FROM yphone_mails
        WHERE
            phone_imei = @phoneImei
    ]], { ["@phoneImei"] = phoneImei })

    if totalMails == 0 then
        return {
            mails = {},
            totalMails = 0
        }
    end

    local mails = MySQL.query.await([[
        SELECT
            id,
            title,
            sender,
            content,
            actions,
            timestamp,
            attachments,
            is_read as isRead,
            phone_imei as phoneImei,
            sender_display_name as senderDisplayName
        FROM yphone_mails
        WHERE
            phone_imei = @phoneImei
        ORDER BY `timestamp` DESC
        LIMIT @page, @perPage
    ]], {
        ['@phoneImei'] = phoneImei,
        ["@page"] = (page or 0) * 25,
        ["@perPage"] = 25
    })

    -- decode the actions
    for _, mail in pairs(mails) do
        if mail.actions then
            mail.actions = json.decode(mail.actions)
        end

        if mail.attachments then
            mail.attachments = json.decode(mail.attachments)
        end
    end

    return {
        mails = mails,
        totalMails = totalMails
    }
end)

local function insertEmailEntry(email)
    local insertId = MySQL.insert.await([[
        INSERT INTO yphone_mails
        (title, sender, content, phone_imei, sender_display_name, attachments, actions)
        VALUES (@title, @sender, @content, @phoneImei, @senderDisplayName, @attachments, @actions)
    ]], {
        ["@title"] = email.title,
        ["@sender"] = email.sender,
        ["@content"] = email.content,
        ["@phoneImei"] = email.phoneImei,
        ["@actions"] = json.encode(email.actions),
        ["@senderDisplayName"] = email.senderDisplayName,
        ["@attachments"] = json.encode(email.attachments)
    })

    return insertId
end

local function sendEmailNotification(email, insertId)
    local notification = {
        app = 'email',
        title = email.senderDisplayName,
        text = email.title,
        data = {
            emailId = insertId
        },
    }

    local received, _source = SendNotification(notification, 'phoneImei', email.phoneImei)
    return received, _source
end

local function sendEmail(email, toType, to)
    if toType == 'all' then
        local players = GetPlayers()

        local insertIds = {}

        for _, playerId in ipairs(players) do
            local citizenId = Framework.GetPlayerFromId(tonumber(playerId))?.identifier

            if not citizenId then
                return -1, false
            end

            local phoneImei = GetPhoneImeiByCitizenId(citizenId)
            if not phoneImei then
                return -1, false
            end

            email.phoneImei = phoneImei

            local insertId = insertEmailEntry(email)
            if insertId then -- if the email was inserted successfully
                table.insert(insertIds, insertId)
                sendEmailNotification(email, insertId)
            end
        end

        return insertIds, true
    elseif toType == 'phoneNumber' and to then
        local phoneImei = GetPhoneImeiByPhoneNumber(to)
        if not phoneImei then
            return -1, false
        end
        email.phoneImei = phoneImei
    elseif toType == 'phoneImei' and to then
        email.phoneImei = to
    elseif toType == 'source' and to then
        local citizenId = Framework.GetPlayerFromId(tonumber(to))?.identifier
        local phoneImei = GetPhoneImeiByCitizenId(citizenId)

        if not phoneImei then
            return -1, false
        end

        email.phoneImei = phoneImei
    end

    local insertId = insertEmailEntry(email)
    local received, recipientSource = sendEmailNotification(email, insertId)

    if received then
        TriggerClientEvent('yseries:client:mail:update-mails', recipientSource,
            email)
    end

    return insertId, received
end

exports('SendMail', function(email, toType, to) return sendEmail(email, toType, to) end)
ExportHandler('yseries', 'SendMail', function(email, toType, to) return sendEmail(email, toType, to) end)

--- Deletes an email with the given ID from the yphone_emails table.
--- @param id number The id of the email to delete.
--- @return boolean
local function deleteMail(id)
    local result = MySQL.query.await([[
        DELETE FROM yphone_mails
        WHERE id = @id
    ]], {
        ["@id"] = id
    })

    if result.affectedRows > 0 then
        return true
    else
        return false
    end
end
exports('DeleteMail', function(id) return deleteMail(id) end)
ExportHandler('yseries', 'DeleteMail', function(id) return deleteMail(id) end)

lib.callback.register('yseries:server:email:send', function(_, email, toType, to)
    return sendEmail(email, toType, to)
end)

lib.callback.register('yseries:server:email:delete', function(_, id)
    return deleteMail(id)
end)

lib.callback.register('yseries:server:email:read', function(_, id)
    local affectedRows = MySQL.update.await([[
        UPDATE yphone_mails
        SET is_read = 1
        WHERE id = @id
    ]], {
        ["@id"] = id
    })

    if affectedRows > 0 then
        return true
    else
        return false
    end
end)

-- lib.addCommand('=test-send-mail-all', {
--     restricted = 'group.god'
-- }, function(source)
--     TriggerClientEvent('yseries:client:mail:send-dummy-all', source)
-- end)
