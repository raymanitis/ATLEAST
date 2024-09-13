local allowedApps = {
    ['y'] = true,
    ['instashots'] = true,
}

lib.addCommand('toggleVerified', {
    help = 'Toggle a user\'s verified status',
    params = {
        {
            name = 'app',
            type = 'string',
            help = 'The app name: options - (y, instashots)'
        },
        {
            name = 'username',
            type = 'string',
            help = 'The player username'
        },
        {
            name = 'verified',
            type = 'string',
            help = 'The verified status: options - (on/off)'
        }
    },
    restricted = 'group.admin'
}, function(source, args)
    local app, username, verified = args.app, args.username, args.verified

    if not allowedApps[app:lower()] then
        return
    end

    if not username then
        return
    end

    if not verified or not verified == 'on' or not verified == 'off' then
        return
    end

    ToggleVerified(source, app, username, verified)
end)

lib.addCommand('cellBroadcast', {
    help = 'Send a cell broadcast message',
    params = {
        {
            name = 'source',
            type = 'number',
            help = 'The player source id or -1 for all players'
        },
        {
            name = 'title',
            type = 'string',
            help = 'The title of the message'
        },
        {
            name = 'content',
            type = 'string',
            help = 'The content of the message'
        },
        {
            name = 'iconUrl',
            type = 'string',
            optional = true,
            help = '(optional) Custom icon URL'
        },
    },
    restricted = 'group.admin'
}, function(_, args)
    local source = args.source
    local title = args.title
    local content = args.content
    local iconUrl = args?.iconUrl

    if not source or not title or not content then
        return
    end

    TriggerClientEvent('yseries:client:cell-broadcast', source, title, content, iconUrl)
end)

lib.addCommand('resetPin', {
    help = 'Reset a device\'s pin by id',
    params = {
        {
            name = 'id',
            type = 'number',
            help = 'The device id in the db'
        },
        {
            name = 'pin',
            help = 'The new pin(MAX 4 digits)'
        }
    },
    restricted = 'group.admin'
}, function(_, args)
    local phoneId = args.id
    local newPin = args.pin

    if not phoneId or not newPin then
        return
    end

    if #tostring(newPin) > 4 then
        return
    end

    ResetPhonePin(phoneId, newPin)
end)

lib.addCommand('changePassword', {
    help = 'Change a user\'s password',
    params = {
        {
            name = 'app',
            type = 'string',
            help = 'The app name: options - (y, instashots)'
        },
        {
            name = 'username',
            type = 'string',
            help = 'The profile username'
        },
        {
            name = 'password',
            help = 'The new password. Min 6 symbols.'
        }
    },
    restricted = 'group.admin'
}, function(source, args)
    local app, username, password = args.app, args.username, args.password

    if not allowedApps[app:lower()] then
        return
    end

    if not username then
        return
    end

    if not password and string.len(tostring(password)) < 6 then
        return
    end

    ChangePassword(source, tostring(app), tostring(username), tostring(password))
end)

lib.addCommand('switchOS', {
    help = 'Switch phone OS(yos/humanoid)',
    params = {
        {
            name = 'imei',
            help = 'Phone\'s IMEI identifier'
        },
    },
    restricted = 'group.admin'
}, function(source, args)
    local imei = tostring(args.imei)
    debugPrint('Switching OS for phone with IMEI: ' .. imei)

    if not imei then return end

    SwitchOS(source, imei)
end)

lib.addCommand('recoverSimCard', {
    help = 'Recover Sim Card on a new phone',
    params = {
        {
            name = 'number',
            help = 'The Sim Card Number that you want to recover'
        },
        {
            name = 'imei',
            help = 'The IMEI of the new phone to assign the sim card number'
        },
    },
    restricted = 'group.admin'
}, function(source, args)
    local imei = tostring(args.imei)
    local number = tostring(args.number)

    debugPrint('Recovering Sim Card: ' .. number .. ' to phone with IMEI: ' .. imei)

    if not imei or not number then return end

    RecoverSimCard(source, imei, number)
end)

lib.addCommand('changeSimCard', {
    help = 'Change Sim Card number for a given phone',
    params = {
        {
            name = 'number',
            help = 'The Sim Card Number that you want to assign to the phone'
        },
        {
            name = 'imei',
            help = 'The IMEI of the new phone to assign the sim card number'
        },
    },
    restricted = 'group.admin'
}, function(source, args)
    local imei = tostring(args.imei)
    local number = tostring(args.number)

    debugPrint('Changing Sim Card: ' .. number .. ' for phone with IMEI: ' .. imei)

    if not imei or not number then return end

    ChangePhoneNumber(source, imei, number)
end)
