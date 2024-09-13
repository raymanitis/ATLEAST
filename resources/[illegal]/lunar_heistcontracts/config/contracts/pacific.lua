Config.contracts.pacific = {
    ---@type ContractSettings
    settings = {
        disabled = false,
        chance = 5,
        price = 750,
        requiredExperience = 1500,
        expiry = 23 * 60,
        timeToStart = 30,
        minMembers = 6,
        rewards = { crypto = 325, experience = 2500 },
        minPolice = 10
    },

    duration = 120, -- The bank will reset after 120 minutes
    image = './contracts/pacific.png',

    blip = {
        coords = vector3(245.7451, 225.3596, 108.5957),
        name = locale('pacific'),
        sprite = 1,
        size = 0.75,
        color = 1
    },

    dispatch = {
        enabled = true,
        code = '10-68',
        title = locale('dispatch_pacific_title'),
        message = locale('dispatch_pacific_message'),
    },

    -- All of the doors that are only for the authorized personnel
    genericDoors = {
        requiredItem = 'hack_usb',
        removeAfterUse = false,
        model = `gabz_sm_pb_door_04`,
        locations = {
            vector3(256.3750, 229.2106, 106.4739),
            vector3(269.9966, 220.7880, 106.4360),
            vector3(267.4929, 213.8889, 106.4344),
            vector3(251.6495, 216.2077, 106.4263),
            vector3(272.1811, 206.6532, 106.4470),
            vector3(278.2116, 223.3664, 106.4406),
        },
        terminal = {
            model = `ch_prop_fingerprint_scanner_01e`,
            coords = vector4(274.1140, 218.2591, 110.6568, 70.0),
        }
    },

    offices = {
        requiredItem = 'hack_usb',
        removeAfterUse = false,
        doors = {
            model = `gabz_sm_pb_door_01`,
            locations = {
                vector3(259.435211, 230.096237, 110.314186),
                vector3(268.809692, 226.684357, 110.349998),
                vector3(262.778870, 210.176163, 110.308998),
                vector3(253.357315, 213.606430, 110.306702),
            }
        },
        keypads = {
            vector4(260.6960, 229.5393, 110.55, -20.0),
            vector4(270.1783, 226.0881, 110.55, -20.0),
            vector4(261.4712, 210.7533, 110.55, 160.0),
            vector4(252.0538, 214.1809, 110.55, 160.0),
        },
        computers = {
            vector3(261.7008, 234.8204, 110.1204),
            vector3(270.3853, 231.6552, 110.1260),
            vector3(260.5027, 205.4535, 110.1204),
            vector3(251.8486, 208.6142, 110.1247),
        }
    },

    mainOffice = {
        door = {
            model = `gabz_sm_pb_door_03`,
            -- Double door
            locations = {
                vector3(272.951385, 216.384293, 110.349480),
                vector3(272.588989, 215.374023, 110.292305),
            }
        },
        keypad = vector4(272.1448, 214.3928, 110.55, 250.0),
        safe = vector3(278.7393, 217.5260, 110.2156)
    },

    basement = {
        centre = vector3(257.0252, 221.5320, 97.1172), -- Used for zone checking etc.
        enterance = {
            securityPanel = {
                keycard = 'blue_keycard',
                model = `hei_prop_hei_securitypanel`,
                offset = vector3(-0.09, 0.0, 0.0),
                locations = {
                    vector3(267.6489, 213.2155, 97.5378),
                    vector3(270.5834, 221.2575, 97.5304),
                },
            },
            doors = {
                model = `gabz_sm_pb_door_08`,
                locations = {
                    vector3(271.992126, 220.151901, 97.264359),
                    vector3(269.528534, 213.113403, 97.275108)
                }
            }
        },
        sideVaults = {
            securityPanel = {
                model = `hei_prop_hei_securitypanel`,
                requiredItem = 'hack_card', -- Required for the hack
                removeAfterUse = false,
                locations = {
                    vector3(241.8674, 218.7116, 97.5588),
                    vector3(247.309082, 233.651184, 97.542374)
                }
            },
            doors = {
                model = `gabz_sm_pb_door_08`,
                locations = {
                    vector3(243.8966, 217.1626, 97.2760),
                    vector3(249.999100, 233.580795, 97.302551)
                }
            },
        },
        mainVault = {
            securityPanel = {
                keycard = 'purple_keycard',
                model = `hei_prop_hei_securitypanel`,
                offset = vector3(-0.09, 0.0, 0.0),
                coords = vector3(236.429047, 231.750092, 97.512711)
            },
            door = {
                coords = vector3(235.802979, 229.435440, 97.585968),
                heading = { open = 300.0, closed = 70.0 },
                model = `v_ilev_bk_vaultdoor`
            },
        },
        guards = {
            enabled = true,
            count = 4,
            model = `mp_s_m_armoured_01`,
            accuracy = 20, -- from 0 - 100
            combatAbility = 100, -- from 0 - 100, peds can start to run away if less than 50
            ignorePolice = true, -- Ignores players with law enforcement jobs, can be configured in lunar_bridge/config/cl_edit.lua
            looting = {
                enabled = true, -- Players can loot the guards
                progressDuration = 5000
            },
            locations = {
                vector4(263.4592, 225.5760, 97.1171, 157.9721),
                vector4(249.0877, 231.5089, 97.1172, 159.6592),
                vector4(244.7647, 219.1730, 97.1172, 330.3628),
                vector4(239.9383, 221.1626, 97.1172, 352.0163),
                vector4(236.8019, 226.1504, 97.1172, 346.3024),
                vector4(258.8959, 213.9931, 97.1172, 331.6351),
            },
            -- One random weapon will get chosen
            ---@type GuardWeapon[]
            weapons = {
                { name = 'weapon_carbinerifle', ammo = { name = 'ammo-rifle', min = 60, max = 180 } },
                { name = 'weapon_combatpistol', ammo = { name = 'ammo-9', min = 60, max = 180 } },
            },
        },
        props = {
            { coords = vector4(240.9999, 214.2390, 97.1172, 250.0), model = `h4_prop_h4_table_isl_01a` },
            { coords = vector4(244.3078, 213.1551, 97.1172, 70.0), model = `h4_prop_h4_table_isl_01a` },
            { coords = vector4(249.6554, 238.1066, 97.1170, 250.0), model = `h4_prop_h4_table_isl_01a` },
            { coords = vector4(253.1743, 237.0625, 97.1170, 70.0), model = `h4_prop_h4_table_isl_01a` },
        },
        ---@type LootData
        loot = {
            rewards = {
                ['cash'] = { account = 'money', count = { pile = 72000, trolley = 112500 } },
                ['gold'] = { item = 'gold_bar', count = { pile = 20, trolley = 45 } },
            },
            goldChance = 20,
            locations = {
                -- Left side vault
                {
                    coords = vector4(240.9952, 213.6891, 97.0623, 70.0),
                    type = 'pile',
                    requires = 'sideVault1'
                },
                {
                    coords = vector4(241.3261, 214.6775, 97.0623, 70.0),
                    type = 'pile',
                    requires = 'sideVault1'
                },
                {
                    coords = vector4(244.0132, 212.7282, 97.0623, 250.0),
                    type = 'pile',
                    requires = 'sideVault1'
                },
                {
                    coords = vector4(244.3166, 213.7032, 97.0623, 250.0),
                    type = 'pile',
                    requires = 'sideVault1'
                },
                
                -- Right side vault
                {
                    coords = vector4(249.6082, 237.6150, 97.0621, 70.0),
                    type = 'pile',
                    requires = 'sideVault2'
                },
                {
                    coords = vector4(249.9554, 238.6165, 97.0621, 70.0),
                    type = 'pile',
                    requires = 'sideVault2'
                },
                {
                    coords = vector4(253.2250, 237.6163, 97.0621, 250.0),
                    type = 'pile',
                    requires = 'sideVault2'
                },
                {
                    coords = vector4(252.8350, 236.6179, 97.0621, 250.0),
                    type = 'pile',
                    requires = 'sideVault2'
                },

                -- Main vault
                {
                    coords = vector4(225.9311, 226.1756, 97.0632, 0.0),
                    type = 'trolley',
                    alreadySpawned = 'gold',
                    requires = 'mainVault'
                },
                {
                    coords = vector4(224.6845, 226.6598, 97.0632, 0.0),
                    type = 'trolley',
                    alreadySpawned = 'gold',
                    requires = 'mainVault'
                },
                {
                    coords = vector4(229.1462, 225.0331, 97.0632, 0.0),
                    type = 'trolley',
                    alreadySpawned = 'gold',
                    requires = 'mainVault'
                },
                {
                    coords = vector4(227.9036, 225.4657, 97.0632, 0.0),
                    type = 'trolley',
                    alreadySpawned = 'gold',
                    requires = 'mainVault'
                },
                {
                    coords = vector4(227.8575, 234.9807, 97.0578, 180.0),
                    type = 'trolley',
                    alreadySpawned = 'cash',
                    requires = 'mainVault'
                },
                {
                    coords = vector4(232.3271, 233.4299, 97.0566, 180.0),
                    type = 'trolley',
                    alreadySpawned = 'cash',
                    requires = 'mainVault'
                },
                {
                    coords = vector4(227.1993, 233.5815, 97.1171, 250.0),
                    type = 'trolley',
                    requires = 'mainVault'
                },
                {
                    coords = vector4(226.4101, 231.3449, 97.1171, 250.0),
                    type = 'trolley',
                    requires = 'mainVault'
                },
                {
                    coords = vector4(230.8233, 228.6706, 97.1171, 70.0),
                    type = 'trolley',
                    requires = 'mainVault'
                }
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
                vector4(241.2718, 209.7381, 97.5355, 160.0),
                vector4(252.5793, 240.8896, 97.5355, 340.0)
            }
        }
    }
}