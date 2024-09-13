Config.contracts.cargo = {
    ---@type ContractSettings
    settings = {
        disabled = false,
        chance = 10,
        price = 50,
        requiredExperience = 200,
        expiry = 23 * 60,
        timeToStart = 30,
        minMembers = 3,
        rewards = { crypto = 25, experience = 250 }, -- Other rewards such as items are listed below
        minPolice = 4
    },

    duration = 60, -- minutes before reset
    requiredItem = 'angle_grinder', -- Angle grinder

    dispatch = {
        enabled = true,
        code = '10-68',
        title = locale('dispatch_cargo_title'),
        message = locale('dispatch_cargo_message')
    },

    locations = {
        {
            coords = vector3(1116.1962, -3080.2793, 5.8324),
            radius = 15.0,
            image = './contracts/cargo.png',
            guards = {
                vector4(1124.1014, -3084.1204, 5.8183, 271.9666),
                vector4(1106.3300, -3072.3313, 15.9589, 181.7313),
                vector4(1108.2710, -3076.3901, 5.8731, 90.4178),
                vector4(1127.7551, -3082.4004, 23.0901, 90.9966),
            },
            containers = {
                vector4(1110.0966, -3075.1938, 5.8639, 0.0),
                vector4(1114.0966, -3075.1938, 5.8639, 0.0),
                vector4(1118.0966, -3075.1938, 5.8639, 0.0),
                vector4(1122.0966, -3075.1938, 5.8639, 0.0),

                vector4(1110.0966, -3085.1938, 5.8639, 180.0),
                vector4(1114.0966, -3085.1938, 5.8639, 180.0),
                vector4(1118.0966, -3085.1938, 5.8639, 180.0),
                vector4(1122.0966, -3085.1938, 5.8639, 180.0),
            }
        },
        {
            coords = vector3(173.7686, 2751.1084, 43.4264),
            radius = 22.5,
            image = './contracts/cargo2.png',
            guards = {
                vector4(173.1838, 2738.4460, 43.4235, 11.0092),
                vector4(175.9830, 2770.9551, 45.6696, 189.3591),
                vector4(181.7677, 2759.0039, 43.4264, 104.2862),
                vector4(211.0402, 2745.9006, 43.4263, 13.7229),
            },
            containers = {
                vector4(161.8156 + 2, 2763, 43.4050, 100.0),
                vector4(162.3156 + 2, 2759.5, 43.4050, 100.0),
                vector4(162.8156 + 2, 2756, 43.4050, 100.0),
                vector4(163.3156 + 2, 2752.5, 43.4050, 100.0),
                vector4(163.8156 + 2, 2749, 43.4050, 100.0),
                vector4(164.3156 + 2, 2745.5, 43.4050, 100.0),

                vector4(188.7571, 2751.9290, 43.4264, 280.0),
                vector4(182.7269, 2736.6575, 43.4263, 190.3909)
            },
        },
        {
            coords = vector3(2474.5300, 1586.3021, 32.7203),
            radius = 20.0,
            image = './contracts/cargo3.png',
            guards = {
                vector4(2491.1082, 1577.0811, 32.7203, 95.1091),
                vector4(2466.9712, 1572.5432, 32.7203, 34.8394),
                vector4(2471.5952, 1596.1582, 32.7203, 95.7627),
                vector4(2451.6267, 1583.8616, 32.7203, 90.6839)
            },
            containers = {
                vector4(2491.3191, 1595.0, 32.7203, 270.0),
                vector4(2491.3191, 1591.5, 32.7203, 270.0),
                vector4(2491.3191, 1588.0, 32.7203, 270.0),
                vector4(2491.3191, 1584.5, 32.7203, 270.0),
                vector4(2491.3191, 1581.0, 32.7203, 270.0),

                vector4(2469.0, 1600.1538, 32.7203, 0.0),
                vector4(2465.5, 1600.1538, 32.7203, 0.0),
                vector4(2462.0, 1600.1538, 32.7203, 0.0),
            }
        }
    },

    guards = {
        enabled = true,
        model = `csb_mweather`,
        attackPolice = false,
        accuracy = 20, -- from 0 - 100
        combatAbility = 100, -- from 0 - 100, peds can start to run away if less than 50
        blip = {
            name = locale('security_guard'),
            sprite = 57,
            size = 0.3,
            color = 1
        },
        looting = {
            enabled = true, -- Players can loot the guards
            progressDuration = 5000
        },
        weapons = {
            { name = 'weapon_carbinerifle', ammo = { name = 'ammo-rifle', min = 60, max = 180 } }
        },
    },

    blip = {
        name = locale('containers_area'),
        sprite = 456,
        size = 0.75,
        color = 1
    },

    loot = {
        count = { min = 3, max = 4 }, -- 3-4 of the provided locations are filled with loot
        progressDuration = 7500, -- progress bar duration
        types = {
            {
                itemCount = 3, -- 2 of the items below get randomly selected
                unique = true, -- Player cant loot the same the weapons from one loot spot
                ---@type { name: string, count: integer | { min: integer, max: integer }, metadata: any? }[]
                items = {
                    { name = 'weapon_carbinerifle', count = 1 },
                    { name = 'weapon_assaultrifle', count = 1 },
                    { name = 'weapon_smg', count = 1 },
                    { name = 'weapon_microsmg', count = { min = 1, max = 2 } },
                    { name = 'ammo-rifle', count = { min = 100, max = 200 } },
                    { name = 'ammo-rifle2', count = { min = 100, max = 200 } },
                    { name = 'ammo-45', count = { min = 100, max = 250 } },
                    { name = 'ammo-9', count = { min = 120, max = 250 } },
                }
            }
        }
    }
}