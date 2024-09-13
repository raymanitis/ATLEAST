Config.contracts.bobcat = {
    ---@type ContractSettings
    settings = {
        disabled = false,
        chance = 10,
        price = 350,
        requiredExperience = 1250,
        expiry = 23 * 60,
        timeToStart = 30,
        minMembers = 5,
        rewards = { crypto = 400, experience = 750 }, -- Other rewards such as items are listed below
        minPolice = 5,
    },

    duration = 80, -- minutes before reset
    image = './contracts/bobcat.png',

    -- Blip shown to the players after the contract is started
    blip = {
        coords = vector3(909.7594, -2119.2791, 32.6185),
        name = locale('bobcat_security'),
        sprite = 1,
        size = 0.75,
        color = 1
    },
    
    alarm = {
        coords = vector3(887.5999, -2135.0095, 34.1518),
        duration = 60
    },

    dispatch = {
        enabled = true,
        code = '10-68',
        title = locale('dispatch_bobcat_title'),
        message = locale('dispatch_bobcat_message'),
    },

    entryDoor = {
        model = `v_ilev_rc_door2`,
        heading = 85.0,
        requiredItem = 'thermite',
        -- It's a double door thus there are two coords defined
        locations = {
            vector3(914.7787, -2121.2002, 31.4672),
            vector3(914.661682, -2122.483398, 31.464708)
        }
    },

    securityDoor = {
        model = `v_ilev_rc_door2`,
        coords = vector4(908.5502, -2120.6194, 31.4974, 85.0),
        requiredItem = 'thermite',
    },

    guardedArea = {
        keypad = {
            coords = vector4(904.8181, -2122.6772, 31.6189, 85.0),
            requiredItem = 'hack_usb',
            removeAfterUse = false
        },
        door = {
            { coords = vector3(904.776978, -2121.631836, 31.402826), model = `v_ilev_cd_door` },
            { coords = vector3(904.893860, -2120.293945, 31.376081), model = `v_ilev_cd_door` },
        },
        guards = {
            enabled = true,
            model = `s_m_m_chemsec_01`,
            ignorePolice = true,
            accuracy = 20, -- from 0 - 100
            combatAbility = 100, -- from 0 - 100, peds can start to run away if less than 50
            looting = {
                enabled = true, -- Players can loot the guards
                progressDuration = 5000
            },
            ---@type GuardWeapon[]
            weapons = {
                { name = 'weapon_carbinerifle', ammo = { name = 'ammo-rifle', min = 60, max = 180 } },
                { name = 'weapon_combatpistol', ammo = { name = 'ammo-9', min = 60, max = 180 } },
            },
            locations = {
                vector4(897.1977, -2125.6282, 31.2303, 333.7048),
                vector4(897.1118, -2133.0720, 31.2303, 350.3903),
                vector4(892.1490, -2135.2537, 31.2303, 324.2714),
                vector4(883.6339, -2132.0698, 31.2303, 250.1994),
                vector4(884.6443, -2134.7393, 31.2303, 271.3267),
                vector4(879.7808, -2125.6030, 31.2303, 195.8608),
                vector4(877.3607, -2111.5015, 31.2303, 192.0070),
            },
        },
        vault = {
            coords = vector4(888.454224, -2130.210693, 31.583565, 354.0),
            requiredItem = 'bomb_c4',
            explosion = {
                delay = 10, -- It blows up 10 seconds after it's planted
                type = 4,
                cameraShake = 5.0
            },
            ---@type LootData
            loot = {
                rewards = {
                    ['cash'] = { account = 'money', count = { pile = 72000, trolley = 112500 } },
                    ['gold'] = { item = 'gold_bar', count = { pile = 20, trolley = 45 } },
                },
                goldChance = 20,
                locations = {
                    {
                        coords = vector4(891.3170, -2120.5974, 31.2303, 108.1430),
                        type = 'trolley'
                    },
                    {
                        coords = vector4(891.1375, -2123.4812, 31.2303, 83.9241),
                        type = 'trolley'
                    },
                    {
                        coords = vector4(885.6264, -2128.3328, 31.2301, 282.9872),
                        type = 'trolley'
                    },
                    {
                        coords = vector4(885.6620, -2127.0476, 31.2302, 260.4858),
                        type = 'trolley'
                    },
                    {
                        coords = vector4(885.9533, -2122.7705, 31.2303, 348.2581),
                        type = 'trolley'
                    },
                }
            },
            ---@type { model: string | number, progressDuration: integer, items: { name: string, count: integer | { min: integer, max: integer }, chance: integer?, metadata: any? }[], locations: vector4[] }[]
            weaponsLoot = {
                {
                    model = `ex_prop_crate_ammo_sc`,
                    progressDuration = 7500,
                    items = {
                        { name = 'weapon_combatpistol', count = { min = 1, max = 3 } },
                        { name = 'weapon_smg', count = { min = 1, max = 3 }, chance = 75 },
                        { name = 'weapon_carbinerifle', count = { min = 1, max = 3 }, chance = 75 },
                        { name = 'ammo-pistol', count = { min = 50, max = 300 } },
                        { name = 'ammo-rifle', count = { min = 50, max = 300 } },
                        { name = 'at_suppressor_heavy', count = { min = 1, max = 2 }, chance = 50 },
                        { name = 'at_suppressor_light', count = { min = 1, max = 2 }, chance = 50 },
                    },
                    locations = {
                        vector4(886.7723, -2125.4385, 30.7302, 78.9541)
                    }
                },
                {
                    model = `gr_prop_gr_crates_weapon_mix_01a`,
                    progressDuration = 7500,
                    items = {
                        { name = 'weapon_carbinerifle', count = { min = 1, max = 3 } },
                        { name = 'weapon_assaultrifle', count = { min = 1, max = 2 }, chance = 75 },
                        { name = 'ammo-rifle', count = { min = 50, max = 300 } },
                        { name = 'ammo-rifle2', count = { min = 50, max = 300 } },
                        { name = 'at_clip_extended_rifle', count = { min = 1, max = 2 } },
                        { name = 'at_clip_extended_pistol', count = { min = 1, max = 2 } },
                        { name = 'at_suppressor_heavy', count = { min = 1, max = 2 }, chance = 50 },
                        { name = 'at_suppressor_light', count = { min = 1, max = 2 }, chance = 50 },
                    },
                    locations = {
                        vector4(891.3487, -2126.3196, 30.7302, 170.2303)
                    }
                }
            }
        }
    },

    removeProps = {
        { coords = vector3(891.336243, -2120.566895, 31.176243), model = `prop_cash_trolly` },
        { coords = vector3(891.273071, -2126.502197, 31.176243), model = `prop_cash_trolly` },
    }
}