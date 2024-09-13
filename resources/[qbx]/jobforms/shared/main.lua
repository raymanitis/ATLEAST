Config = {}

Config.UseTarget = true -- ox target support

-- Discord Log Settings
Config.ServerName = "Atleast.lv | Fivem RP"
Config.FooterText = "Atleast.lv | Fivem RP | Policijas pieteikums "
Config.FooterIconURL = ""
Config.ShowTime = true -- shows date in the footer
Config.ChangeBoolsToStrings = true -- changes True/False to Yes/No
Config.MakeAtbildesBold = true
Config.BotUsername = "Policijas pieteikums"
Config.BotAvatar = "https://r2.fivemanage.com/43z7Bt109UNYve2xRiuvK/myLogo.png"
Config.AuthorAvatar = "https://r2.fivemanage.com/43z7Bt109UNYve2xRiuvK/myLogo.png"

 --[[
    Question Types:
    input,
    number,
    checkbox,
    select,
    slider
    color
    multi-select
    date
    date-range 
    time
    textarea

    for more details, visit: https://overextended.github.io/docs/ox_lib/Interface/Client/input
    ]]

-- Main Settings

Config.Areas = {
    {
        label = "Policijas Pieteikums",
        webhook = "police",
        Coords = vector3(441.9232, -981.9336, 30.8694),
        Blip = {
            enabled = false,
            sprite = 1,
            size = 0.7,
            colour = 1,
        },
        TargetSettings = { --For when using OX-target
            radius =0.2,
            debug = false,
            icon = "fa-solid fa-list-check",
            label = "Policijas Pieteikums"
        },
        MarkerSettings = {
            DrawMarker = true,
            size = vec3(1, 1, 1),
            rotation = vec3(1, 1, 1),
            type = 21,
            Distance = 10.0,
            colour = {r = 50, g = 200, b = 50, a = 200},
            TextUI = "[E] -> Policijas Pieteikums"
        },
        Questions = {
            {
                type = "input",
                label = "Vārds Uzvārds",
                description = "Šis ir obligāts jautājums",
                placeholder = "Atbilde",
                required = true
            },
            {   
                type = "input",
                label = "Vecums",
                description = "Šis ir obligāts jautājums",
                placeholder = "Atbilde",
                required = true
            },
            {   
                type = "input",
                label = "Telefona nummurs",
                description = "Šis ir obligāts jautājums",
                placeholder = "Atbilde",
                required = true
            },
            {   
                type = "textarea",
                label = "Pastāsti par savu pieredzi policijas darbā ja tāda ir.",
                description = "Šis ir ļoti garš jautājums",
                placeholder = "Kas to lai zina?",
                max = 50,
                required = true
            },
            {   
                type = "textarea",
                label = "Pastāsti par sevi.",
                description = "max 50 vārdi",
                placeholder = "Esmu 21. gadus vecs vīrietis ar uzmanības trūkumu.",
                max = 50,
                required = true
            },
        }
    }
}


Config.ApplicationSettings = {
    Cooldown = {
        enabled = true,
        time = 5 * 60000 -- time in milliseconds (default: 5 mins)
    },
}
