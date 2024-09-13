RegisterNetEvent('yseries:server:toggle-phone', function(state)
    debugPrint('RegisterNetEvent: yseries:client:toggle-phone', state)
    -- * A callback function that you can use as you want when the phone is toggled.
end)

-- Function to check if the phone number already exists in the database
local function checkPhoneNumberExists(phoneNumber)
    local exists = MySQL.scalar.await([[
        SELECT COUNT(*) FROM yphone_sim_cards WHERE sim_number = @phoneNumber
    ]], {
        ['@phoneNumber'] = phoneNumber
    })

    return exists > 0
end

local function getRandomValue(tbl)
    if #tbl == 0 then return nil end

    math.randomseed(os.time())

    -- Generate a random index and return the corresponding value
    local index = math.random(1, #tbl)
    return tbl[index]
end

function GeneratePhoneNumber()
    local phone = ""
    local exists = true

    while exists do
        phone = getRandomValue(Config.Calls.NumberPrefix) --[[@as string]]

        for _ = 1, Config.Calls.NumberLength do
            phone = phone .. tostring(math.random(0, 9))
        end

        -- Check if the generated number exists in the database
        exists = checkPhoneNumberExists(phone)
    end

    return phone
end

function SplitStr(inputstr, sep)
    sep = sep or ":"
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

RegisterNetEvent('yseries:server:update-users-phone-number', function(phoneNumber)
    local src = source
    local playerIdentifier = Framework.GetPlayerFromId(src)?.identifier

    if Config.Framework == 'esx' then
        MySQL.query.await([[
            UPDATE users
            SET phone_number = @phoneNumber
            WHERE identifier = @identifier]], {
            ['@phoneNumber'] = phoneNumber,
            ['@identifier'] = playerIdentifier
        })
    elseif Config.Framework == 'qb' then
        local _Framework = exports['qb-core']:GetCoreObject()

        if not _Framework then
            return
        end

        -- * Update the charinfo metadata with the new phone number.
        local Player = _Framework.Functions.GetPlayer(source)
        local charInfo = Player.PlayerData.charinfo
        charInfo.phone = phoneNumber

        Player.Functions.SetPlayerData('charinfo', charInfo)
    end
end)

RegisterNetEvent('yseries:server:y:new-tweet', function(data, playerIdentifier)
    debugPrint('Misc: New tweet added: RegisterNetEvent:yseries:server:twitter:new-tweet')

    local notification = {
        app = 'y',
        sound = 'custom',
        text = '',
        data = {
            creator = data.username,
        },
        timeout = 3000
    }

    if data.replyTo then
        TriggerEvent('yseries:server:logs:create', 'y', 'Y',
            '📢 New reply from ' .. data.username .. ' to ' .. data.ownerUsername, 'y', data.content,
            data?.attachments
            ?.photo, nil, nil, playerIdentifier)

        if (Config.Y.GlobalNotifications) then
            notification.data.type = 'newReply'
            notification.data.translateKey = 'newReplyLabel'
            notification.data.translateParams = { username = data.username, ownerUsername = data.ownerUsername }

            TriggerClientEvent('yseries:client:send-notification', -1, notification)
        end
    else
        TriggerEvent('yseries:server:logs:create', 'y', 'Y', '📢 New tweet from ' .. data.username, 'y',
            data.content, data?.attachments?.photo, nil, nil, playerIdentifier)

        if (Config.Y.GlobalNotifications) then
            notification.data.type = 'newPost'
            notification.data.translateKey = 'newPostLabel'
            notification.data.translateParams = { username = data.username }

            TriggerClientEvent('yseries:client:send-notification', -1, notification)
        end
    end
end)

RegisterNetEvent('yseries:server:instashots:on-new-post', function(data, playerIdentifier)
    debugPrint('Misc: New instashots post added: RegisterNetEvent:yseries:server:instashots:on-new-post')

    local imageUrl = nil -- Initialize as nil for no image

    -- Check if there is media data and it's a table
    if data.attachments?.media and type(data.attachments?.media) == 'table' then
        -- Check if the first media item has an image
        if data.attachments.media[1] and data.attachments.media[1].image then
            imageUrl = data.attachments.media[1].image
        end
    end

    TriggerEvent('yseries:server:logs:create', 'instashots', 'Instashots', '📸 New post from ' .. data.username,
        'instashots', data.caption,
        imageUrl, nil, nil, playerIdentifier)

    if (Config.Instashots.GlobalNotifications) then
        local notification = {
            app = 'instashots',
            sound = 'default',
            text = '',
            data = {
                type = 'newPost',
                translateKey = 'newPostLabelNotify',
                translateParams = { username = data.username },
                creator = data.username,
            },
            timeout = 3000
        }
        TriggerClientEvent('yseries:client:send-notification', -1, notification)
    end
end)

RegisterNetEvent('yseries:server:ypay:on-new-transfer', function(data, playerIdentifier)
    debugPrint('Misc: New YPay transfer added: RegisterNetEvent:yseries:server:ypay:on-new-transfer')

    local transferMessage = data.sender ..
        ' → ' .. data.recipient .. ' | Amount: ' .. data.amount .. Config.CurrencySymbol .. ' | Reason: ' ..
        data.reason

    TriggerEvent('yseries:server:logs:create', 'ypay', 'YPay', 'New transfer 💸', 'ypay', transferMessage,
        nil, nil, nil, playerIdentifier)
end)

RegisterNetEvent('yseries:server:ybuy:on-new-ad', function(data, playerIdentifier)
    debugPrint('Misc: New YBuy ad created: RegisterNetEvent:yseries:server:ybuy:on-new-ad')

    local adMessage = ''

    TriggerEvent('yseries:server:logs:create', 'ybuy', 'YBuy', 'New ad created 📃', 'ybuy', adMessage,
        json.decode(data.attachments)?.photos[1]?.image, false,
        data, playerIdentifier)

    if Config.YBuy.GlobalNotifications then
        local notification = {
            app = 'ybuy',
            sound = 'default',
            text = '',
            data = {
                type = 'newAd',
                creator = data.number,
            },
            timeout = 3000
        }
        TriggerClientEvent('yseries:client:send-notification', -1, notification)
    end
end)
