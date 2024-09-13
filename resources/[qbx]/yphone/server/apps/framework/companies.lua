local function GetCompanyInfo(company)
    for i = 1, #Config.Companies.Services do
        local service = Config.Companies.Services[i]
        if service.job == company then
            return service
        end
    end

    return nil
end

local lastRefresh = 0
lib.callback.register('yseries:server:companies:get', function()
    if (lastRefresh + Config.RefreshInterval) < os.time() and RefreshCompanies then
        RefreshCompanies()

        lastRefresh = os.time()
    end

    return Config.Companies.Services
end)

local function getChannel(company, phoneImei, phoneNumber, doNotMakeNew)
    local channelId = MySQL.scalar.await(
        "SELECT id FROM yphone_companies_channels WHERE company = ? AND phone_imei = ?",
        { company, phoneImei })

    if channelId then
        return channelId
    end

    if doNotMakeNew then
        return nil
    end

    local id = GenerateUid()
    MySQL.query.await(
        "INSERT INTO yphone_companies_channels (id, company, phone_imei, phone_number) VALUES (@id, @company, @phoneImei, @phoneNumber)",
        {
            ["@id"] = id,
            ["@company"] = company,
            ["@phoneImei"] = phoneImei,
            ["@phoneNumber"] = phoneNumber
        })

    return id
end

local function getDispatchChannel(company, phoneImei)
    local dispatchChannelId = MySQL.scalar.await(
        "SELECT id FROM yphone_companies_channels WHERE id LIKE ?",
        { '%:' .. company })

    if not dispatchChannelId then
        local id = GenerateUid()
        local _dispatchChannelId = id .. ':' .. company

        MySQL.query.await(
            "INSERT INTO yphone_companies_channels (id, company, phone_imei, phone_number) VALUES (@id, @company, @phoneImei, @phoneNumber)",
            {
                ["@id"] = _dispatchChannelId,
                ["@company"] = company,
                ["@phoneImei"] = phoneImei,
                ["@phoneNumber"] = company
            })

        return _dispatchChannelId
    end

    return dispatchChannelId
end

local function SendNotification(playerSource, notification)
    if playerSource then
        TriggerClientEvent('yseries:client:send-notification', playerSource,
            notification)

        local lastMessage = {
            channelId = notification.data.channelId,
            message = notification.data.message,
            sender = notification.data.sender,
            phoneImei = notification.data.phoneImei,
            id = notification.data.messageId,
            xPos = notification.data.xPos,
            yPos = notification.data.yPos,
            timestamp = notification.data.timestamp
        };

        TriggerClientEvent('yseries:client:companies:update-conversation', playerSource,
            lastMessage)
    end
end

local function sendMessage(source, channelId, company, message, anonymous, phoneImei, phoneNumber, showLocation)
    local _source = source
    local isDispatch = false

    if not phoneImei then
        return
    end

    if anonymous then
        phoneNumber = 'Anonymous'
        channelId = getChannel(company, phoneImei, phoneNumber)
    end

    if not channelId or channelId == '-' then
        channelId = getChannel(company, phoneImei, phoneNumber)
    elseif channelId == company then
        channelId = getDispatchChannel(company, phoneImei)
        isDispatch = true
    end

    local contacter = MySQL.scalar.await(
        "SELECT phone_imei FROM yphone_companies_channels WHERE id = @channelId", {
            ["@company"] = company,
            ["@channelId"] = channelId
        })
    local isContacter = contacter == phoneImei

    local x, y
    if isContacter or isDispatch then
        local coords = GetEntityCoords(GetPlayerPed(_source))
        x = coords.x
        y = coords.y
    end

    local messageId = GenerateUid()

    if showLocation then
        messageId = messageId .. ':location'

        if type(showLocation) == "table" then
            x = showLocation.x
            y = showLocation.y
        end
    end

    local messageResult = MySQL.query.await([[
    INSERT INTO yphone_companies_messages (id, channel_id, sender, message, x_pos, y_pos)
    VALUES (@id, @channelId, @sender, @message, @x, @y)
    ]], {
        ["@id"] = messageId,
        ["@channelId"] = channelId,
        ["@sender"] = phoneImei,
        ["@message"] = message,
        ["@x"] = x,
        ["@y"] = y
    })

    if messageResult then
        local timestampResult = MySQL.query.await(
            'SELECT `timestamp` FROM `yphone_messages_messages` WHERE `id` = ?',
            { messageId })
        local messageTimestamp = timestampResult[1]?.timestamp

        MySQL.query.await(
            "UPDATE yphone_companies_channels SET last_message = SUBSTRING(@message, 1, 50) WHERE id = @id", {
                ["@id"] = channelId,
                ["@message"] = message == '<LOCATION>' and 'Shared location' or message
            })

        local notification = {
            app = 'companies',
            sound = 'default',
            data = {
                channelId = channelId,
                messageId = messageId,
                message = message,
                timestamp = messageTimestamp,
            },
            text = message,
            timeout = 3000
        }

        if isContacter or isDispatch then
            -- alert all online employees
            local employees = GetEmployees(company)
            for i = 1, #employees do
                local employeeSourceId = employees[i]
                if not employeeSourceId then
                    goto continue
                end

                notification.data.sender = phoneNumber
                notification.data.phoneImei = phoneImei
                notification.data.xPos = x
                notification.data.yPos = y
                notification.title = "New Alert"

                SendNotification(employees[i], notification)

                ::continue::
            end
        else
            debugPrint("Companies: Alerting recipient")

            local recipientPlayer = GetPlayerByPhoneImei(contacter)
            local recipientSourceId = recipientPlayer?.sourceId
            if recipientSourceId then
                local service = GetCompanyInfo(company)
                if service then
                    notification.title = service.name
                else
                    notification.title = "Companies"
                end

                -- Alert the contacter
                SendNotification(recipientSourceId, notification)
            end
        end

        return {
            messageId = messageId,
            channelId = channelId,
            timestamp = messageTimestamp
        }
    end

    return {}
end

lib.callback.register("yseries:server:companies:send-message",
    function(source, messageData, phoneImei)
        local messageResult = sendMessage(
            source,
            messageData.channelId,
            messageData.company,
            messageData.message,
            messageData?.anonymous,
            phoneImei,
            messageData.phoneNumber,
            messageData.showLocation
        )

        return messageResult
    end)

lib.callback.register('yseries:server:companies:get-conversation', function(_, company, phoneImei)
    local channelId = getChannel(company, phoneImei, nil, true)

    if not channelId then
        return {
            messages = {},
            totalMessages = 0
        }
    end

    local totalMessages = MySQL.scalar.await([[
        SELECT COUNT(*) AS totalMessages
        FROM yphone_companies_messages
        WHERE channel_id = @channelId
    ]], { ["@channelId"] = channelId })

    if totalMessages == 0 then
        return {
            messages = {},
            totalMessages = 0
        }
    end

    local messages = MySQL.query.await([[
        SELECT
            id,
            sender,
            message,
            timestamp,
            x_pos as xPos,
            y_pos as yPos,
            channel_id as channelId
        FROM yphone_companies_messages
        WHERE channel_id = @channelId
        ORDER BY timestamp DESC
        LIMIT @page, @perPage
    ]],
        {
            ["@channelId"] = channelId,
            ["@page"] = 0,
            ["@perPage"] = 25
        }
    )

    local participants = {}
    for i = 1, #messages do
        local message = messages[i]

        if not message?.xPos and not message?.yPos or string.find(message.id, ":location$") ~= nil then
            local senderImei = message.sender

            if not participants[senderImei] then
                local citizenId = GetCitizenIdByPhoneImei(senderImei)

                if citizenId then
                    local characterName = GetOfflineCharacterName(citizenId)
                    if characterName then
                        participants[senderImei] = characterName

                        message.senderName = characterName
                    end
                end
            else
                message.senderName = participants[senderImei]
            end
        end
    end

    return {
        messages = messages,
        totalMessages = totalMessages
    }
end)

lib.callback.register('yseries:server:companies:get-conversation-by-channelId', function(_, data)
    local page = data?.page

    local totalMessages = MySQL.scalar.await([[
        SELECT COUNT(*) AS totalMessages
        FROM yphone_companies_messages
        WHERE channel_id = @channelId
    ]], { ["@channelId"] = data.channelId })

    if totalMessages == 0 then
        return {
            messages = {},
            totalMessages = 0
        }
    end

    local participants = {}

    local messages = MySQL.query.await([[
        SELECT
            id,
            sender,
            message,
            timestamp,
            x_pos as xPos,
            y_pos as yPos,
            channel_id as channelId
        FROM yphone_companies_messages
        WHERE
            channel_id = @channelId
        ORDER BY timestamp DESC
        LIMIT @page, @perPage
    ]],
        {
            ["@channelId"] = data.channelId,
            ["@page"] = (page or 0) * 25,
            ["@perPage"] = 25
        })

    for i = 1, #messages do
        local message = messages[i]

        if not message?.xPos and not message?.yPos or string.find(message.id, ":location$") ~= nil then
            local senderImei = message.sender

            if not participants[senderImei] then
                local citizenId = GetCitizenIdByPhoneImei(senderImei)

                if citizenId then
                    local characterName = GetOfflineCharacterName(citizenId)
                    if characterName then
                        participants[senderImei] = characterName

                        message.senderName = characterName
                    end
                end
            else
                message.senderName = participants[senderImei]
            end
        end
    end

    return {
        messages = messages,
        totalMessages = totalMessages
    }
end)

lib.callback.register('yseries:server:companies:get-company-conversations', function(_, company, page)
    local totalConversations = MySQL.scalar.await([[
        SELECT COUNT(*) AS totalMessages
        FROM yphone_companies_channels
        WHERE
            company = @company
    ]], { ["@company"] = company, })

    if totalConversations == 0 then
        return {
            conversations = {},
            totalConversations = 0
        }
    end

    local conversations = MySQL.query.await([[
        SELECT
            id,
            timestamp,
            phone_imei as phoneImei,
            phone_number as phoneNumber,
            last_message as lastMessage
        FROM yphone_companies_channels
        WHERE
            company = @company
        ORDER BY `timestamp` DESC
        LIMIT @page, @perPage
    ]], {
        ["@company"] = company,
        ["@page"] = (page or 0) * 25,
        ["@perPage"] = 25
    })

    return {
        conversations = conversations,
        totalConversations = totalConversations
    }
end)

lib.callback.register('yseries:server:companies:get-user-conversations', function(_, phoneImei, page)
    local totalConversations = MySQL.scalar.await([[
        SELECT COUNT(*) AS totalMessages
        FROM yphone_companies_channels
        WHERE phone_imei = @phoneImei AND id NOT LIKE '%:%'
    ]], { ["@phoneImei"] = phoneImei })

    if totalConversations == 0 then
        return {
            conversations = {},
            totalConversations = 0
        }
    end

    local conversations = MySQL.query.await([[
        SELECT
            id,
            company,
            timestamp,
            phone_imei as phoneImei,
            phone_number as phoneNumber,
            last_message as lastMessage
        FROM yphone_companies_channels
        WHERE
            phone_imei = @phoneImei AND id NOT LIKE '%:%'
        ORDER BY `timestamp` DESC
        LIMIT @page, @perPage
    ]], {
        ["@phoneImei"] = phoneImei,
        ["@page"] = (page or 0) * 25,
        ["@perPage"] = 25
    })

    return {
        conversations = conversations,
        totalConversations = totalConversations
    }
end)


lib.callback.register('yseries:server:companies:get-player-data', function(_, player)
    local xPlayer = Framework.GetPlayerFromId(player)
    return {
        name = xPlayer?.getName(),
        id = player,
        citizenId = xPlayer?.identifier,
    }
end)

lib.callback.register('yseries:server:companies:call-employee', function(_, phoneNumber, targetSource, callerNumber)
    debugPrint('Calling employee.. ', phoneNumber, targetSource, callerNumber)

    local canCall, isOnline = GetCallState(phoneNumber)

    local phoneImei = GetPhoneImeiByPhoneNumber(phoneNumber)
    local airplaneMode = GetPhoneAirplaneModeByImei(phoneImei)

    debugPrint('Can call: ', canCall, 'Is online: ', isOnline)
    if not canCall or not isOnline or airplaneMode then return false end

    local enabled = IsCompanyCallsEnabled(phoneImei)
    if enabled then
        debugPrint('Getting employee called')
        TriggerClientEvent('yseries:client:companies:get-employee-called', targetSource, callerNumber)
        return true
    end

    return false
end)

RegisterNetEvent('yseries:server:companies:cancel-call', function(employeeSrc)
    TriggerClientEvent('yseries:client:companies:cancel-call', employeeSrc)
end)
