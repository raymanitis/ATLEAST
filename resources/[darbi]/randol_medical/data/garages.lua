return {
    -- Default Pillbox
    {
        points = { -- Form a poly around the area. All z coords must match.
            vec3(301.53, -604.45, 43.3),
            vec3(293.45, -601.3, 43.3),
            vec3(290.03, -610.85, 43.3),
            vec3(297.6, -613.65, 43.3),
        },
        type = 'vehicle', -- type: 'vehicle' | 'heli' | 'boat'
        coords = vec4(295.36, -606.84, 43.33, 70.09), -- Vehicle spawn coords.
        label = 'Pillbox Garage',
        icon = 'fa-solid fa-car',
    },
    {
        points = { vec3(348.34, -579.06, 74.17), vec3(361.62, -583.76, 74.17), vec3(355.89, -598.63, 74.17), vec3(341.45, -593.08, 74.17), },
        type = 'heli',
        coords = vec4(351.76, -587.9, 74.17, 208.87),
        label = 'Pillbox Roof',
        icon = 'fa-solid fa-helicopter-symbol',
    },

    -- Gabz Pillbox
    -- {
    --     points = { -- Form a poly around the area. All z coords must match.
    --         vec3(301.53, -604.45, 43.3),
    --         vec3(293.45, -601.3, 43.3),
    --         vec3(290.03, -610.85, 43.3),
    --         vec3(297.6, -613.65, 43.3),
    --     },
    --     type = 'vehicle', -- type: 'vehicle' | 'heli' | 'boat'
    --     coords = vec4(295.36, -606.84, 43.33, 70.09), -- Vehicle spawn coords.
    --     label = 'Pillbox Garage',
    --     icon = 'fa-solid fa-car',
    -- },
    -- {
    --     points = { vec3(348.34, -579.06, 74.17), vec3(361.62, -583.76, 74.17), vec3(355.89, -598.63, 74.17), vec3(341.45, -593.08, 74.17), },
    --     type = 'heli',
    --     coords = vec4(351.76, -587.9, 74.17, 208.87),
    --     label = 'Pillbox Roof',
    --     icon = 'fa-solid fa-helicopter-symbol',
    -- },

    -- Central Medical G&N
    -- {
    --     points = { vec3(309.19, -1422.7, 29.92), vec3(303.46, -1428.93, 29.92), vec3(312.55, -1436.66, 29.92), vec3(318.26, -1430.3, 29.92), },
    --     type = 'vehicle',
    --     coords = vec4(311.04, -1429.07, 29.92, 135.95),
    --     label = 'Central Garage',
    --     icon = 'fa-solid fa-car',
    -- },
    -- {
    --     points = { vec3(305.77, -1465.66, 46.51), vec3(312.5, -1457.42, 46.51), vec3(321.29, -1464.21, 46.51), vec3(314.2, -1472.82, 46.51), },
    --     type = 'heli',
    --     coords = vec4(313.38, -1465.05, 46.51, 144.55),
    --     label = 'Central Roof',
    --     icon = 'fa-solid fa-helicopter-symbol',
    -- },

    -- Paleto Medical G&N
    -- {
    --     points = { vec3(-240.68, 6338.19, 32.43), vec3(-243.72, 6334.81, 32.43), vec3(-238.28, 6329.53, 32.43), vec3(-234.95, 6332.57, 32.43), },
    --     type = 'vehicle',
    --     coords = vec4(-239.31, 6334.03, 32.41, 222.36),
    --     label = 'Paleto Garage',
    --     icon = 'fa-solid fa-car',
    -- },
    -- {
    --     points = { vec3(-245.85, 6330.82, 37.62), vec3(-237.73, 6323.33, 37.62), vec3(-245.93, 6315.18, 37.62), vec3(-253.83, 6323.07, 37.62), },
    --     type = 'heli',
    --     coords = vec4(-245.83, 6323.31, 37.62, 314.02),
    --     label = 'Pillbox Roof',
    --     icon = 'fa-solid fa-helicopter-symbol',
    -- },
}