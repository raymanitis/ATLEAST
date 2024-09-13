Config = Config or {}

Config.Logs = {}         -- The webhook that will be used to send the posts to the discord channel.
Config.Logs.Timeout = 30 -- The amount of time in seconds that the logs will be queued before being sent to the discord channel.
Config.Logs.Webhooks = { -- The webhook that will be used to send the posts to the discord channel.
    ['instashots'] = 'https://discord.com/api/webhooks/1268269649565454539/rKHb4LC4Ff6ecv-ySplrL1Z47_ffUNOj2yR689JJH_k0D68fyIf1R-XEyKTt1JdPHfrB',
    ['y'] = 'https://discord.com/api/webhooks/1246134188311318538/SrBBgfBPiErYjeqPU3y0ekmVVYrOeo1iNWSe5QvmPssTHVC-cnqfWCOqbBkxRe1v-R6w',
    ['ypay'] = 'https://discord.com/api/webhooks/1268269771716034707/a7vm1b1iI9B7C9Elq-smAp-pFkeS_Nz05R-5EVeIpUXXfZVjMwJi4BGfEk74D_HsnUCj',
    ['ybuy'] = 'https://discord.com/api/webhooks/1268269838027985031/fPe4O2tE7T5rOW_ZK8in6xNpguDW1_CWsbz_6g2GCumnunhrbo2jrVte7-CZa8g5bm4a',
    ['companies'] = '',
}
Config.Logs.Avatars = { -- The avatar for the bot that will be used to send the posts to the discord channel.
    ['instashots'] = '',
    ['y'] = '',
    ['ypay'] = '',
    ['ybuy'] = '',
    ['companies'] = '',
}

Config.Logs.Colors = { -- https://www.spycolor.com/
    ['instashots'] = 15884387,
    ['companies'] = 1940464,
    ['default'] = 14423100,
    ['lightgreen'] = 65309,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['white'] = 16777215,
    ['pink'] = 16761035,
    ['ybuy'] = 15020857,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['ypay'] = 431319,
    ['y'] = 1940464,
    ['black'] = 0,
}
