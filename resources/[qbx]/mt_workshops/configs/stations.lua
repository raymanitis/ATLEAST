Config = Config or {}

Config.stations = {
    { -- La Mesa LS Customs
        label = "Autoserviss",
        job = false,
        checkMecs = true,
        price = 100,
        progress = 5000,
        blip = { enabled = true, color = 0, sprite = 446, display = 4, scale = 0.6 },
        type = 'zone', -- zone or prop
        zone = {
            points = {
                vec3(725.68, -1084.01, 22.10),
                vec3(724.72, -1091.28, 22.10),
                vec3(738.49, -1094.68, 22.10),
                vec3(737.25, -1084.05, 22.10)
            },
            thickness = 5
        }
    },
    { -- Route 68 Harmony
        label = "Autoserviss",
        job = false,
        checkMecs = true,
        price = 100,
        progress = 5000,
        blip = { enabled = true, color = 0, sprite = 446, display = 4, scale = 0.6 },
        type = 'zone', -- zone or prop
        zone = {
            points = {
                vec3(1171.92, 2645.99, 37.8),
                vec3(1178.87, 2644.73, 37.8),
                vec3(1178.01, 2635.96, 37.8),
                vec3(1172.33, 2635.59, 37.8)
            },
            thickness = 5
        }
    },
    { -- Beekers Garage
        label = "Autoserviss",
        job = false,
        checkMecs = true,
        price = 100,
        progress = 5000,
        blip = { enabled = true, color = 0, sprite = 446, display = 4, scale = 0.6 },
        type = 'zone', -- zone or prop
        zone = {
            points = {
                vec3(116.42, 6624.58, 31.8),
                vec3(113.01, 6621.05, 31.8),
                vec3(105.44, 6627.51, 31.8),
                vec3(109.25, 6631.74, 31.8)
            },
            thickness = 5
        }
    },
    { -- Misson Row LSPD
        label = "LSPD Repair Station",
        job = 'police',
        checkMecs = false,
        price = 100,
        progress = 5000,
        blip = { enabled = false, color = 0, sprite = 446, display = 4, scale = 0.6 },
        type = 'zone', -- zone or prop
        zone = {
            points = {
        		vec3(454.6212, -978.0367, 25.6998),
                vec3(454.6781, -973.4178, 25.6998),
                vec3(445.6171, -973.4445, 25.6998),
                vec3(445.5518, -978.0899, 25.6998),
            },
            thickness = 5
        }
    },
    -- { -- Route 68 BCSO
    --     label = "BCSO Repair Station",
    --     job = 'police',
    --     checkMecs = false,
    --     price = 100,
    --     progress = 5000,
    --     blip = { enabled = false, color = 0, sprite = 446, display = 4, scale = 0.6 },
    --     type = 'prop', -- zone or prop
    --     prop = {
    --         model = 'gr_prop_gr_bench_01b',
    --         radius = 5,
    --         coords = vec4(1050.85, 2746.15, 37.67, 178.12+180),
    --     }
    -- },
}