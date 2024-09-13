Config.contracts.paleto = {
    ---@type ContractSettings
    settings = {
        disabled = false,
        chance = 5,
        price = 1000,
        requiredExperience = 1400,
        expiry = 23 * 60,
        timeToStart = 30,
        minMembers = 6,
        rewards = { crypto = 500, experience = 2500 },
        minPolice = 10
    },

    duration = 120, -- The bank will reset after 120 minutes
    image = './contracts/paleto.png',

    blip = {
        coords = vector3(-105.0369, 6472.6025, 31.6334),
        name = locale('paleto'),
        sprite = 1,
        size = 0.75,
        color = 1
    },

    alarm = {
        coords = vector3(-105.3907, 6468.1455, 36.5674),
        duration = 30, -- seconds
        delay = 3, -- minutes after turning off smart locks
    },

    dispatch = {
        enabled = true,
        code = '10-68',
        title = locale('dispatch_paleto_title'),
        message = locale('dispatch_paleto_message'),
    },

    --- Generic doors for personnel only
    authorized = {
        --- Players need to turn the smart locks off here
        electricBox = {
            model = `h4_prop_h4_elecbox_01a`,
            coords = vector4(-101.7319, 6479.4779, 31.6397, 315.0),
            requiredItem = false,
            removeAfterUse = false
        },
        doors = {
            {
                coords = vector3(-96.243095, 6473.657715, 31.802307),
                model = `v_ilev_ct_doorl`
            },
            {
                coords = vector3(-99.664024, 6473.896484, 31.873024),
                model = `xm_prop_iaa_base_door_01`
            },
            {
                coords = vector3(-116.104332, 6479.435059, 31.845369),
                model = `v_ilev_ct_doorl`
            },
            {
                coords = vector3(-111.519333, 6474.855957, 31.807945),
                model = `gabz_paletobank_officedoors03`
            }
        }
    },

    surveilanceRoom = {
        --- Players need to unlock the room here
        panel = {
            coords = vector4(-92.6768, 6469.72, 32.1975, 315.0),
            requiredItem = 'hack_usb',
            removeAfterUse = false
        },
        door = {
            coords = vector3(-92.729889, 6468.514648, 31.892067),
            model = `xm_prop_iaa_base_door_01`
        },
        cameras = {
            coords = vector3(-91.755249, 6464.897461, 31.523540),
            options = {
                {
                    title = locale('cam_main_office'),
                    coords = vector4(-105.8802, 6480.9897, 33.3104, 194.7833)
                },
                {
                    title = locale('cam_credits_office_1'),
                    coords = vector4(-97.3619, 6464.7148, 33.3122, 11.4366)
                },
                {
                    title = locale('cam_credits_office_2'),
                    coords = vector4(-101.7132, 6460.5811, 33.2887, 89.1926)
                },
                {
                    title = locale('cam_lobby_1'),
                    coords = vector4(-102.2373, 6475.6465, 33.3259, 176.3831)
                },
                {
                    title = locale('cam_lobby_2'),
                    coords = vector4(-108.0906, 6461.0796, 33.3064, 353.2885)
                },
                {
                    title = locale('cam_lobby_3'),
                    coords = vector4(-99.8880, 6465.3887, 33.6798, 98.5249)
                },
                {
                    title = locale('cam_lobby_4'),
                    coords = vector4(-114.8700, 6470.7485, 33.2916, 279.4297)
                },
                {
                    title = locale('cam_hallway'),
                    coords = vector4(-99.9045, 6476.7808, 34.3152, 218.2760)
                }
            }
        }
    },

    terminal = {
        prop = vector4(-117.575516, 6470.605957, 31.996962, 135.0),
        coords = vector4(-117.5240, 6470.6597, 31.8795, 135.0),
        requiredItem = 'hack_card',
        removeAfterUse = false
    },

    offices = {
        doors = {
            {
                model = `gabz_paletobank_officedoors01a`,
                coords = vector3(-100.172287, 6468.453613, 31.783480),
            },
            {
                model = `gabz_paletobank_officedoors01b`,
                coords = vector3(-105.283539, 6463.336426, 31.766390),
            },
            {
                model = `gabz_paletobank_officedoors02`,
                coords = vector3(-104.231003, 6474.380859, 31.789318),
            },
        },
        computers = {
            requiredItem = 'hack_usb',
            removeAfterUse = false,
            locations = {
                vector3(-98.153351, 6466.069824, 31.468622),
                vector3(-103.800880, 6460.391602, 31.468622),
                vector3(-104.784363, 6479.369141, 31.468618)
            }
        },
        paintings = {
            item = 'painting',
            locations = {
                {
                    vector4(-96.1182, 6469.8320, 32.3123, 315.0),
                    vector4(-95.1231, 6468.8374, 32.3123, 315.0),
                },
                {
                    vector4(-105.7313, 6458.3208, 32.3123, 135.0),
                    vector4(-106.7721, 6459.3613, 32.3123, 135.0),
                },
                {
                    vector4(-105.8694, 6474.6372, 32.3123, 135.0),
                    vector4(-107.0358, 6475.8037, 32.3123, 135.0),
                    vector4(-108.2468, 6477.0049, 32.3123, 135.0),
                }

            }
        },
        safe = {
            model = `ch_prop_ch_arcade_safe_door`,
            coords = vector3(-105.262085, 6480.699219, 32.021912),
            ---@type { item: string?, account: string?, count: integer | { min: integer, max: integer }, chance: integer?, metadata: any? }[]
            rewards = {
                { account = 'money', count = { min = 20000, max = 40000 } },
                { item = 'classified_docs', count = { min = 3, max = 5 } },
                { item = 'rare_coins', count = { min = 1, max = 2 }, chance = 50 },
                { item = 'luxurious_watch', count = { min = 1, max = 2 }, chance = 50 },
                { item = 'WEAPON_PISTOL', count = 1, chance = 25 }
            }
        }
    },
    
    vault = {
        panel = {
            model = `hei_prop_hei_securitypanel`,
            coords = vector4(-101.948784, 6462.896484, 32.091091, 188.9452),
            requiredItem = 'hack_card',
            removeAfterUse = false
        },
        door = {
            model = `ch_prop_ch_vault_d_door_01a`,
            coords = vector3(-100.835602, 6463.907715, 31.876242)
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
                    type = 'trolley',
                    coords = vector4(-98.8913, 6464.6240, 31.6341, 183.0)
                },
                {
                    type = 'trolley',
                    coords = vector4(-101.5190, 6461.9878, 31.6341, 273.0)
                },
                {
                    type = 'trolley',
                    coords = vector4(-95.6838, 6461.3633, 31.6341, 95.0)
                },
                {
                    type = 'trolley',
                    coords = vector4(-98.2572, 6458.8018, 31.6341, 5.0)
                },

                {
                    type = 'trolley',
                    coords = vector4(-97.6791 - 0.2, 6462.0620 - 0.3, 31.6341, 225.0)
                },
                {
                    type = 'trolley',
                    coords = vector4(-98.4695 - 0.2, 6461.2969 - 0.3, 31.6341, 225.0)
                },
                {
                    type = 'trolley',
                    coords = vector4(-98.0964 - 0.2, 6462.4932 - 0.3, 31.6341, 45.0),
                },
                {
                    type = 'trolley',
                    coords = vector4(-98.8868 - 0.2, 6461.7280 - 0.3, 31.6341, 45.0),
                },
            }
        },
        drilling = {
            requiredItem = 'large_drill',
            -- Supports metadata
            rewards = {
                { account = 'money', count = { min = 20000, max = 30000 } },
                { item = 'classified_docs', count = { min = 1, max = 3 }, chance = 75 },
                { item = 'rare_coins', count = { min = 1, max = 3 }, chance = 75 },
                { item = 'diamonds_box', count = { min = 1, max = 2 }, chance = 50 },
                { item = 'diamond_necklace', count = { min = 1, max = 2 }, chance = 50 },
                { item = 'diamond_ring', count = { min = 1, max = 3 }, chance = 50 },
                { item = 'luxurious_watch', count = { min = 1, max = 2 }, chance = 50 },
                { item = 'weapon_pistol', count = 1, chance = 25 },
            },
            locations = {
                vector4(-96.6484, 6463.3125, 32.0388, 315.0),
                vector4(-96.6594, 6459.5078, 32.0418, 225.0),
                vector4(-100.4668, 6460.1064, 32.0365, 135.0),
            }
        }
    },

    -- Remove useless props in the MLO
    removeProps = {
        { coords = vector3(-98.154854, 6459.076660, 31.274216), model = `v_corp_cashtrolley_2` },
        { coords = vector3(-98.858292, 6464.380859, 31.274216), model = `v_corp_cashtrolley_2` },
        { coords = vector3(-98.000122, 6461.784668, 31.579306), model = `prop_cash_trolly` },
        { coords = vector3(-98.000122, 6461.784668, 31.579306), model = `prop_money_bag_01` },
        { coords = vector3(-97.885147, 6462.006348, 30.998928), model = `prop_money_bag_01` },
        { coords = vector3(-98.922707, 6460.848145, 31.579252), model = `prop_gold_trolly` },
        { coords = vector3(-98.708824, 6460.918457, 31.638206), model = `bkr_prop_money_counter` },
        { coords = vector3(-98.798409, 6460.637207, 31.727295), model = `bkr_prop_moneypack_01a` },
        { coords = vector3(-98.798409, 6460.637207, 31.727295), model = `bkr_prop_moneypack_01a` },
        { coords = vector3(-98.798409, 6460.637207, 31.727295), model = `bkr_prop_moneypack_01a` },
        { coords = vector3(-98.798409, 6460.637207, 31.727295), model = `bkr_prop_moneypack_01a` },
        { coords = vector3(-98.798409, 6460.637207, 31.727295), model = `bkr_prop_moneypack_01a` },
        { coords = vector3(-98.798409, 6460.637207, 31.727295), model = `bkr_prop_moneypack_01a` },
        { coords = vector3(-106.203217, 6458.830566, 32.606075), model = `vw_prop_vw_wallart_141a` },
        { coords = vector3(-95.608322, 6469.293457, 32.653568), model = `vw_prop_vw_wallart_143a` },
        { coords = vector3(-106.337608, 6475.130859, 32.653664), model = `vw_prop_vw_wallart_140a` },
        { coords = vector3(-108.132271, 6476.925781, 32.673431), model = `vw_prop_vw_wallart_142a` },
        { coords = vector3(-102.813835, 6464.034180, 31.259228), model = `v_corp_bk_filedraw` },
        { coords = vector3(-103.065399, 6464.158691, 31.704393), model = `v_res_paperfolders` },
        { coords = vector3(-102.606117, 6463.612305, 31.755749), model = `prop_folder_02` },
        { coords = vector3(-102.997665, 6463.745605, 31.693466), model = `prop_folder_02` },
    }
}