Config = {
    Framework = "qb", -- Framework name (esx or qb)

    BotName = "Atleast.lv Reporti", -- Name of the bot that will send the reports to the discord channel
    Webhook = "https://discord.com/api/webhooks/1275987362106703997/CkyokIhJIDvDvGFe-pShq3rv9b4YAOS09XRO17jBJc0f0LCwPi_2N5B8-nNWzxTrRyhp", -- Discord webhook link

    Admins = { -- Discord IDs of the admins
        "discord:334637362401378305", -- raymans
        "discord:572849521843765249", -- veizpal
        "discord:905013541457756221", -- .mkz
        "discord:1028755972199559219", -- beltins 
        "discord:508366766116831243", -- krisjanis
    },

    Translations = {
        ["report"] = "Reports",
        ["report_alert"] = "Ir jauns reports!",
        ["sent"] = "Nosūtīts",
        ["report_sent"] = "Reports veiksmīgi nosūtīts.",
        ["deleted"] = "Izdzēsts",
        ["report_deleted"] = "Reports veiksmīgi izdzēsts.",
        ["bring"] = "Admins",
        ["admin_bringed"] = "Admins tevi pieaicināja.",
        ["goto"] = "Admins",
        ["admin_came"] = "Admins teleportējās, lai tev palīdzētu.",
        ["concluded"] = "Noslēgts",
    },
    

    Notification = function(title, message, msgType, length)
        -- Your notification here
    end
}