Config.contracts.fleeca = {
    ---@type ContractSettings
    settings = {
        disabled = false,
        chance = 10,
        price = 250,
        requiredExperience = 1000,
        expiry = 23 * 60,
        timeToStart = 30,
        minMembers = 1,
        rewards = { crypto = 125, experience = 750 }, -- Other rewards such as items are listed below
        minPolice = 0
    },

    duration = 120, -- minutes before reset
    alarmDuration = 45,

    -- Blip shown to the players after the contract is started
    blip = {
        name = locale('fleeca_bank'),
        sprite = 1,
        size = 0.75,
        color = 1
    },

    dispatch = {
        enabled = true,
        code = '10-68',
        title = locale('dispatch_fleeca_title'),
        message = locale('dispatch_fleeca_message'),
    },

    doors = {
        entry = {
            model = `xm_prop_iaa_base_door_01`,
            requiredItem = 'thermite',
            offset = vector4(3.35255003, -1.51019967, -0.06079865, 90.0)
        },
        vault = {
            model = `v_ilev_gb_vauldr`,
            offset = vector3(-0.53442669, -1.50575030, -0.09355068),
            openAngleDiff = -90.0,
            openDelay = 10 -- seconds
        },
        inside = {
            model = `v_ilev_gb_vaubar`,
            offset = vector3(-3.04553461, -0.12364487, 0.01667404),
            unlocks = 'back' -- Unlocks the vault back for the loot instance
        }
    },

    panels = {
        model = `v_corp_bk_secpanel`,
        requiredItem = 'hack_card',
        removeAfterUse = false,
        offset = vector3(-1.72191715, -0.37155154, 0.01645660) -- offset of the inside panel
    },

    loot = {
        rewards = {
            ['cash'] = { account = 'money', count = { pile = 72000, trolley = 112500 } },
            ['gold'] = { item = 'gold_bar', count = { pile = 20, trolley = 45 } },
        },
        goldChance = 20,
        locations = {
            {
                coords = vector4(-4.15483332, -1.32051313, -0.20012951, -90.54205322),
                type = 'trolley',
            },
            {
                coords = vector4(-1.09726119, 3.31316924, -0.20012951, -231.93424988),
                type = 'trolley',
                requires = 'back'
            },
            {
                coords = vector4(-1.19558799, 0.63045835, -0.20012951, 45.33004761),
                type = 'trolley',
                requires = 'back'
            },
            {
                coords = vector4(-3.18608308, 3.52774024, -0.20012951, -180.54205322),
                type = 'trolley',
                requires = 'back'
            },
            {
                coords = vector4(-4.49074354, 2.01884556, -0.2562885, 89.45794678),
                type = 'pile',
                requires = 'back'
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
            vector4(-0.53724456, 1.98195720, 0.12397003, -90.54205322),
            vector4(-2.37841201, -2.73317814, 0.12497139, -180.54205322),
        }
    },

    props = {
        { coords = vector4(-4.62180853, 1.98183489, -0.20012951, 90.0), model = `h4_prop_h4_table_isl_01a` }
    },

    -- MLO Props that are removed because they are useless
    removeProps = {
        { coords = vector3(-4.14793825, 2.89802003, -0.56009102), model = `v_corp_cashtrolley_2`,  },
        { coords = vector3(-4.29339170, 1.31317520, -0.56009102), model = `v_corp_cashtrolley_2`,  },
        { coords = vector3(-1.50950301, 2.81285167, -0.55828094), model = `v_corp_cashtrolley`,  },
        { coords = vector3(-4.02510691, -1.79512274, -0.97770786), model = `v_corp_banktrolley`,  }
    },

    -- Everything is offseted from the vault panel
    locations = {
        vector4(-2956.232910, 481.636047, 15.897129, 267.542053),
        vector4(146.721329, -1046.367432, 29.568117, 159.846176),
        vector4(-1210.685181, -336.880463, 37.981075, 206.863739),
        vector4(311.053406, -284.734100, 54.364830, 159.865952),
        vector4(-354.006104, -55.598770, 49.236618, 160.859818),
        vector4(1176.077148, 2713.191895, 38.288074, 0.000000)
    },

    -- The images for each location
    images = {
        './contracts/fleeca.png',
        './contracts/fleeca2.png',
        './contracts/fleeca3.png',
        './contracts/fleeca4.png',
        './contracts/fleeca5.png',
        './contracts/fleeca6.png',
    }
}