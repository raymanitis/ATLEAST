Config.workshops = Config.workshops or {}

-- This config is made to work with the Kiiya's LS Auto Shop MLO
-- Check: https://kiiya.tebex.io/package/5845981

Config.workshops.hayes = { -- Workshop ID, needs to be the same as the job!!
    enabled = true, -- enable the workshop or not
    label = 'TsyTunes', -- Label that will show on the map blip and etc
    job = 'hayes', -- Job that will be able to access everything in the workshop
    blip = { enabled = true, coords = vec3(-1417.6023, -446.4865, 35.9097), color = 26, scale = 0.8, display = 4, sprite = 446 }, -- map blip
    zone = { -- Workshop zone to toggle duty and access preview, use /zone poly to create it!
        points = {
            vec3(-1430.4170, -447.2003, 35.9373),
            vec3(-1423.9236, -457.7815, 36.3536),
            vec3(-1405.7273, -445.5088, 35.9097),
            vec3(-1412.4032, -435.3796, 35.9097)
        },
        thickness = 15
    },
    managements = { -- Workshop management locations
        { coords = vec3(-1426.9148, -458.4187, 35.7195), radius = 0.3 },
    },
    stashes = { -- Workshop stashes locations
        { coords = vec3(-1409.8931, -448.6481, 36.1762), radius = 0.45, slots = 50, weight = 1000 },
    },
    crafts = { -- Workshop crafts locations
        { coords = vec3(-1420.6851, -455.7330, 36.1919), radius = 0.45, categories = { 'performance', 'others' } },
    },
    shops = { -- Workshop shops locations
        { coords = vec3(-1415.2429, -452.3217, 36.1310), radius = 0.3, categories = { 'performance', 'others' } },
    },
    registers = { -- Workshop registers locations
        { coords = vec3(-1429.7000, -453.9287, 36.0904), radius = 0.3, comission = 10, playersRadius = 5.0 },
    },
    mission = { -- Workshop side mission locations
        { coords = vec3(-1428.7429, -459.6126, 35.8), radius = 0.2, prop = 'hei_prop_hei_bank_phone_01', propHeading = 139.31, minPayment = 100, maxPayment = 500, cooldown = 10 }
    },
    garage = { -- Workshop garage options
        {
            coords = vec4(-1416.7618, -460.8235, 33.4871, 212.6720+180),
            spawnCoords = vec4(-1413.2386, -462.7144, 34.4892, 297.8849),
            vehicles = {
                { icon = 'fas fa-truck', label = 'Flatbed', id = 'flatbed' },
                { icon = 'fas fa-truck', label = 'Tow truck', id = 'towtruck' },
            },
        },
    },
}