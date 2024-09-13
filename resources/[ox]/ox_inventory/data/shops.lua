return {
        General = {
        name = '24/7 veikals',
        blip = {
            id = 59,
            colour = 69,
            scale = 0.8
        },
        inventory = {
            { name = 'burger', price = 60 },  -- Filling food item
            { name = 'water', price = 20 },  -- Basic necessity
            { name = 'tosti', price = 30 },  -- Quick snack
            { name = 'hotdog', price = 40 },  -- Fast food item
            { name = 'milk', price = 40 },  -- Common drink
            { name = 'coffee_black', price = 40 },  -- Popular beverage
            { name = 'orangotang', price = 30 },  -- Unique drink
            { name = 'papers', price = 5 }  -- Unique drink
        },
        locations = {
            vec3(25.8298, -1346.8016, 29.4970),
            vec3(-47.3182, -1758.6342, 29.4210),
            vec3(1163.3744, -323.8557, 69.2051),
            vec3(-707.5196, -914.6368, 19.2156),
            vec3(-3242.8064, 1001.7685, 12.8307),
            vec3(1961.1907, 3741.0125, 32.3437),
            vec3(1698.3065, 4924.8076, 42.0637),
            vec3(160.6070, 6635.0723, 31.6148),
            
        },
        targets = {
            { ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(24.1263, -1346.7344, 28.4970), heading = 267.3417 },
            { ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(-47.3182, -1758.6342, 28.4210), heading = 48.6788 },
            { ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(1165.0984, -323.0148, 68.2051), heading = 101.7054 },
            { ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(-1819.4143, 794.0446, 137.0790), heading = 138.1535 },
            { ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(-3244.0203, 999.8211, 11.8307), heading = 352.4716 },
            { ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(1958.9624, 3741.3154, 31.3437), heading = 297.2526 },
            { ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(1697.3754, 4922.9321, 41.0637), heading = 324.7401 },
            { ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(161.7490, 6636.2222, 30.5700), heading = 131.3539 },
            { ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(-705.9910, -914.6034, 18.2156), heading = 84.1514},
            { ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(372.9124, 327.9909, 102.5664), heading = 256.5027}

        }
    },



    Liquor = {
        name = 'Alkahola Veikals',
        blip = {
            id = 93,
            colour = 69,
            scale = 0.8
        },
        inventory = {
            { name = 'beer', price = 30 },  -- Cheap alcoholic drink
            { name = 'vodka', price = 80 }  -- Stronger alcohol
        },
        locations = {
            vec3(1135.808, -982.281, 46.415),
            vec3(-1222.915, -906.983, 12.326),
            vec3(-1487.553, -379.107, 40.163),
            vec3(-2968.243, 390.910, 15.043),
            vec3(1166.024, 2708.930, 38.157),
            vec3(1392.562, 3604.684, 34.980),
            vec3(-1393.409, -606.624, 30.319)
        },
        targets = {
            { ped = `a_m_m_skidrow_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(-1222.6284, -908.9138, 11.3263), heading = 28.9215 },
            { ped = `a_m_m_skidrow_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(-1486.82, -377.48, 39.16), heading = 130.89 },
            { ped = `a_m_m_skidrow_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(-2966.41, 391.62, 15.04), heading = 87.82 },
            { ped = `a_m_m_skidrow_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(1165.15, 2710.78, 38.16), heading = 177.96 },
            { ped = `a_m_m_skidrow_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(1134.3, -983.26, 46.42), heading = 276.3 },
            -- Fixed typo in ped model name (`a_m_m_skidrow_01` instead of `a_m_m_skidrow_011`)    -705.9910, -914.6034, 19.2156, 84.1514
        }
    },
	
	elektronik = {
        name = 'Digital Den',
        blip = {
            id = 521,
            colour = 29,
            scale = 0.8
        },
        inventory = {
            { name = 'phone', price = 300 },  -- Essential communication device
            { name = 'radio', price = 150 },  -- Basic communication device
            -- { name = 'contracts_tablet', price = 1500 },
        },
        locations = {
            vec3(1134.3616, -468.0359, 66.4859)
        },
        targets = {
            { ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(1134.3480, -467.9165, 65.4859), heading = 172.2415 }
        }
    },

    elektroniknelegal = {
        name = 'Digital Den',
        -- blip = {
        --     id = 521,
        --     colour = 29,
        --     scale = 0.8
        -- },
        inventory = {
            -- { name = 'phone', price = 300 },  -- Essential communication device
            -- { name = 'radio', price = 150 },  -- Basic communication device
            { name = 'contracts_tablet', price = 1500 },
            { name = 'racingtablet', price = 1000 },  -- Specialty device 
        },
        locations = {
            vec3(1130.6359, -467.8824, 62.8089)
        },
        targets = {
            { ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(1130.6359, -467.8824, 62.8089), heading = 258.0328 }
        }
    },

    YouTool = {
        name = 'Depo',
        blip = {
            id = 402,
            colour = 69,
            scale = 0.8
        },
        inventory = {
            { name = 'lockpick', price = 150 },  -- Tool for breaking locks
            { name = 'parachute', price = 700 },  -- Specialty safety equipment
            { name = 'lightarmor', price = 1200 },  -- Protective equipment
            { name = 'diving_gear', price = 1000 },  -- Specialized gear
            { name = 'advancedrepairkit', price = 400 },  -- High-end repair equipment
            { name = 'repairkit', price = 200 },  -- Standard repair equipment
            { name = 'backpack', price = 700 },  -- Storage item
            { name = 'watering_can', price = 50 },  -- Storage item
            { name = 'liquid_fertilizer', price = 100 },  -- Storage item 
            { name = 'fertilizer', price = 80 },  -- Storage item 
            { name = 'advanced_fertilizer', price = 150 },  -- Storage ite
            { name = 'contract', price = 100 }  -- kontrakts
        },
        locations = {
            vec3(46.6383, -1749.7086, 29.6331)
        },
        targets = {
            { ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(46.6383, -1749.7086, 28.6331), heading = 51.6567 }
        }
    },

    Ammunation = {
        name = 'Ierocu veikals',
        blip = {
            id = 110,
            colour = 1,
            scale = 0.8
        },
        inventory = {
            { name = 'ammo-9', price = 20, license = 'weapon' },  -- Ammunition
            { name = 'WEAPON_BAT', price = 600 },  -- Melee weapon
            { name = 'WEAPON_DP9', price = 12000, metadata = { registered = true }, license = 'weapon' }  -- Firearm
        },
        locations = {
            vec3(810.0980, -2157.0969, 29.6190),
            vec3(842.2111, -1033.6735, 28.1949),
            vec3(2567.8350, 294.2221, 108.7349),
            vec3(22.0579, -1107.1786, 29.7970),
            vec3(252.0247, -49.9151, 69.9411),
            vec3(-662.3184, -935.6370, 21.8292),
            vec3(-1305.8560, -394.1867, 36.6957),
            vec3(-1117.7325, 2698.4541, 18.5541),
            vec3(1693.7064, 3759.7244, 34.7053),
            vec3(-330.1150, 6083.7388, 31.4548),
        },
        targets = {
		{ ped = `a_m_m_prolhost_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(810.1276, -2159.3909, 28.6190), heading = 359.1352 },
            { ped = `a_m_m_prolhost_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(842.2433, -1035.5652, 27.1949), heading = 358.9177 },
            { ped = `a_m_m_prolhost_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(2567.8513, 292.2538, 107.7349), heading = 354.2662 },
            { ped = `a_m_m_prolhost_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(22.8365, -1105.3583, 28.7970), heading = 156.5734 },
            { ped = `a_m_m_prolhost_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(254.2571, -50.6253, 68.9411), heading = 71.7464 },
            { ped = `a_m_m_prolhost_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(-661.8913, -933.1772, 20.8292), heading = 177.3811 },
            { ped = `a_m_m_prolhost_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(-1303.9235, -395.1654, 35.6958), heading = 71.1348 },
            { ped = `a_m_m_prolhost_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(-1118.8757, 2700.1965, 17.5541), heading = 216.1799 },
            { ped = `a_m_m_prolhost_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(1692.3807, 3761.5872, 33.7053), heading = 222.5335 },
            { ped = `a_m_m_prolhost_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(-331.6114, 6085.4971, 30.4548), heading = 223.5180 },
        }
    },

    PoliceArmoury = {
        name = 'PD veikals',
        groups = shared.police,
        -- blip = {
        --     id = 110,
        --     colour = 84,
        --     scale = 0.8
        -- },
        inventory = {
            { name = 'ammo-9', price = 5, grade = 1 },
            { name = 'ammo-45', price = 5, grade = 6 },
            { name = 'ammo-rifle', price = 5, grade = 6 },
            { name = 'ammo-shotgun', price = 5, grade = 9 },
            { name = 'heavyarmor', price = 5, grade = 2 },
            { name = 'handcuffs', price = 5, grade = 3 },
            { name = 'WEAPON_FLASHLIGHT', price = 200, grade = 1 },
            { name = 'WEAPON_NIGHTSTICK', price = 100, grade = 1 },
            { name = 'WEAPON_STUNGUN', price = 500, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 1 },
            { name = 'WEAPON_GLOCK22', price = 500, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 4 },
            { name = 'WEAPON_MP9', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 6 },
            { name = 'WEAPON_AR15', price = 20000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 6 },
            { name = 'WEAPON_PUMPSHOTGUN_MK2', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 9 },
            { name = 'nightvision', price = 1500, metadata = { registered = true, serial = 'POL' }, grade = 7 },
            { name = 'police_stormram', price = 500, metadata = { registered = true, serial = 'POL' }, grade = 7 }
        },
        locations = {
            vec3(482.4188, -995.2802, 30.6896)
        },
        targets = {
            { loc = vec3(482.4188, -995.2802, 30.6896), length = 0.5, width = 3.0, heading = 270.0, minZ = 30.5, maxZ = 32.0, distance = 6 }
        }
    },

    Medicine = {
        name = 'Aptieka',
        blip = {
            id = 403,
            colour = 69,
            scale = 0.8
        },
        inventory = {
            { name = 'bandage', price = 40 },
        },
        locations = {
            vec3(317.9159, -1078.4050, 29.4785),
            vec3(91.9868, -231.0221, 54.6636),
        },
        targets = {
            { ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(317.9159, -1078.4050, 28.4785), heading = 353.2421 },
            { ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(91.9868, -231.0221, 53.6636), heading = 335.7821 }
        }
    },

    Cietums = {
        name = 'Cietuma veikals',
        -- blip = {
        --     id = 59,
        --     colour = 69,
        --     scale = 0.8
        -- },
        inventory = {
            { name = 'water', price = 10 },  -- Basic necessity
            { name = 'tosti', price = 10 },  -- Quick snack
        },
        locations = {
            -- vec3(25.8298, -1346.8016, 29.4970),
            -- vec3(-47.3182, -1758.6342, 29.4210),
            -- vec3(1163.3744, -323.8557, 69.2051),
            -- vec3(-707.5196, -914.6368, 19.2156),
            -- vec3(-3242.8064, 1001.7685, 12.8307),
            -- vec3(1961.1907, 3741.0125, 32.3437),
            -- vec3(1698.3065, 4924.8076, 42.0637),
            -- vec3(160.6070, 6635.0723, 31.6148),
        },
        targets = {
            { ped = `mp_m_shopkeep_01`, scenario = 'WORLD_HUMAN_AA_COFFEE', loc = vec3(1585.0719, 2541.2014, 45.9880), heading = 44.3146 },

        }
    },
    
    VendingMachineDrinks = {
        name = 'Vending Machine',
        inventory = {
            { name = 'coffee_black', price = 40 },
            { name = 'hotdog', price = 50 }
        },
        model = {
            `prop_vend_soda_02`, `prop_vend_fridge01`, `prop_vend_water_01`, `prop_vend_soda_01`
        }
    }
    
}
