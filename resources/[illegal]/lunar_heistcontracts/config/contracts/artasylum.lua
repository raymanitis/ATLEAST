Config.contracts.artasylum = {
    ---@type ContractSettings
    settings = {
        disabled = false,
        chance = 5,
        price = 1000,
        requiredExperience = 2000,
        expiry = 23 * 60,
        timeToStart = 30,
        minMembers = 8,
        rewards = { crypto = 625, experience = 3500 },
        minPolice = 10
    },

    duration = 120, -- The bank will reset after this duration (minutes)
    image = './contracts/artasylum.png',
    
    blip = {
        coords = vector3(128.1247, -147.6834, 59.4991),
        name = locale('artasylum'),
        sprite = 1,
        size = 0.75,
        color = 1
    },

    dispatch = {
        enabled = true,
        code = '10-68',
        title = locale('dispatch_artasylum_title'),
        message = locale('dispatch_artasylum_message'),
    },

    alarm = {
        coords = vector3(128.4986, -149.0472, 58.9057),
        duration = 60, -- seconds
        silentDelay = 2 -- minutes after the main vault door is opened
    },
    
    securityDoors = {
        requiredItem = 'hack_card',
        removeAfterUse = false,
        locations = {
            {
                model = `3dp_heist_gallery_prop_door_02b_ex`,
                coords = vector3(140.964508, -131.161942, 54.996834)
            },
            {
                model = `3dp_heist_gallery_prop_door_02a`,
                coords = vector3(137.140747, -132.179214, 54.998432)
            },
            {
                {
                    model = `3dp_heist_gallery_prop_door_02a`,
                    coords = vector3(135.290604, -137.009918, 54.997040)
                },
                {
                    model = `3dp_heist_gallery_prop_door_03a`,
                    coords = vector3(135.713257, -135.838684, 55.009556)
                }
            },
            {
                {
                    model = `3dp_heist_gallery_prop_door_02a_ex`,
                    coords = vector3(127.181412, -127.078438, 55.015099)
                },
                {
                    model = `3dp_heist_gallery_prop_door_03a_ex`,
                    coords = vector3(127.623566, -125.874809, 55.017155)
                }
            },
            {
                model = `3dp_heist_gallery_prop_door_02b_ex`,
                coords = vector3(111.307632, -138.808014, 54.999001)
            },
            {
                model = `3dp_heist_gallery_prop_door_02a`,
                coords = vector3(120.694481, -141.098129, 55.032227)
            },
            /* Example:
            { 
                model = `3dp_heist_mb_door_03a`,
                coords = vector3(-1306.282959, -802.649170, 17.699638),
            },
            {
                {
                    model = `3dp_heist_mb_door_03c`,
                    coords = vector3(-1304.760376, -813.675903, 16.993603)
                },
                {
                    model = `3dp_heist_mb_door_03d`,
                    coords = vector3(-1305.718384, -814.404358, 17.008446)
                }
            },
            */
        }
    },

    -- The doors you get access to by hacking the laptops
    keypadDoors = {
        requiredItem = 'hack_usb',
        removeAfterUse = false,
        locations = {
            {
                model = `3dp_heist_gallery_prop_door_01a`,
                door = vector3(116.790337, -141.424759, 55.014645),
                keypads = {
                    vector4(116.589912, -142.319473, 55.313919, 102.7664),
                    vector4(116.413773, -142.246429, 55.313919, 229.9762)
                }
            },
            {
                model = `3dp_heist_gallery_prop_door_01a`,
                door = vector3(115.741714, -144.458267, 55.011131),
                keypads = {
                    vector4(115.944801, -143.534897, 55.313282, 290.4124),
                    vector4(116.120895, -143.608063, 55.319527, 51.4945)
                }
            },
            {
                model = `3dp_heist_gallery_prop_door_01a`,
                door = vector3(123.818680, -143.955551, 55.009617),
                keypads = {
                    vector4(123.662468, -144.847916, 55.310829, 102.7664),
                    vector4(123.397537, -144.755630, 55.317081, 229.9762)
                }
            },
            {
                model = `3dp_heist_gallery_prop_door_01a`,
                door = vector3(126.253311, -131.643265, 60.681131),
                keypads = {
                    vector4(126.087814, -132.566498, 60.920589, 102.0)
                }
            },
            {
                model = `3dp_heist_gallery_prop_door_01a`,
                door = vector3(123.759628, -128.393997, 60.641220),
                keypads = {
                    vector4(122.861893, -128.141464, 60.916012, 12.0)
                }
            },
            {
                model = `3dp_heist_gallery_prop_door_01a`,
                doors = {
                    vector3(149.304764, -141.383148, 50.390614),
                    vector3(148.870453, -142.574173, 50.388298),
                },
                keypads = {
                    vector4(148.373672, -143.462311, 50.716557, 224.8605)
                }
            },
        }
    },

    -- Doors locked centrally, they have to hack the electric box to disable the locks
    genericDoors = {
        electricBox = {
            model = `h4_prop_h4_elecbox_01a`,
            coords = vector4(124.6146, -140.9312, 54.7990, 70.6978),
            requiredItem = false,
        },
        locations = {
            {
                {
                    model = `3dp_heist_gallery_prop_door_01a`,
                    coords = vector3(133.695938, -132.008331, 54.999752)
                },
                {
                    model = `3dp_heist_gallery_prop_door_01a`,
                    coords = vector3(134.879333, -132.438522, 54.996384)
                }
            },
            {
                {
                    model = `3dp_heist_gallery_prop_door_01a`,
                    coords = vector3(134.856583, -132.383667, 60.621384)
                },
                {
                    model = `3dp_heist_gallery_prop_door_01a`,
                    coords = vector3(133.674469, -131.945740, 60.651703)
                },
            },
            {
                {
                    model = `3dp_heist_gallery_prop_door_01a`,
                    coords = vector3(126.689346, -156.159164, 60.600670)
                },
                {
                    model = `3dp_heist_gallery_prop_door_01a`,
                    coords = vector3(125.553062, -155.745605, 60.641682)
                },
            },
            {
                {
                    model = `3dp_heist_gallery_prop_door_01a`,
                    coords = vector3(140.401199, -161.149872, 60.604805)
                },
                {
                    model = `3dp_heist_gallery_prop_door_01a`,
                    coords = vector3(139.180176, -160.705460, 60.595940)
                },
            },
            {
                {
                    model = `3dp_heist_gallery_prop_door_01a`,
                    coords = vector3(150.124542, -139.119766, 60.636395)
                },
                {
                    model = `3dp_heist_gallery_prop_door_01a`,
                    coords = vector3(149.700424, -140.285034, 60.668137)
                },
            },
            {
                {
                    model = `3dp_heist_gallery_prop_door_01a`,
                    coords = vector3(120.304131, -153.457275, 55.018009)
                },
                {
                    model = `3dp_heist_gallery_prop_door_01a`,
                    coords = vector3(119.876122, -154.642639, 54.991257)
                },
            },
            {
                {
                    model = `3dp_heist_gallery_prop_door_01a`,
                    coords = vector3(133.738861, -132.021835, 49.577751)
                },
                {
                    model = `3dp_heist_gallery_prop_door_01a`,
                    coords = vector3(134.868561, -132.433121, 49.582230)
                },
            },
        }
    },

    lights = {
        -- It is rendered when you're 25 meters close so that we save resmon for players that are not near
        render = {
            coords = vector3(134.4716, -149.8713, 54.5463),
            radius = 25.0,
            debug = false
        },
        ---@type ({ coords: vector3, lightRadius: number, interval: number } | { centre: vector3, radius: number, lightRadius: number, interval: number } | { startCoords: vector3, endCoords: vector3, lightRadius: number, interval: number })[]
        locations = {
            -- Bottom floor
            {
                centre = vector3(130.1731, -136.3600, 50.1114),
                radius = 3.5,
                lightRadius = 1.25,
                interval = 8000 -- milliseconds
            },
            {
                centre = vector3(127.4756, -144.9451, 50.0157),
                radius = 3.5,
                lightRadius = 1.0,
                interval = 10000 -- milliseconds
            },
            {
                startCoords = vector3(126.7592, -138.9825, 49.4010),
                endCoords = vector3(145.9444, -145.8975, 49.3940),
                lightRadius = 1.0,
                interval = 10000
            },
            {
                coords = vector3(127.8028, -145.0966, 51.1160),
                lightRadius = 2.0,
                interval = 20000
            },
            {
                coords = vector3(131.3226, -151.5842, 49.4009),
                lightRadius = 2.0,
                interval = 10000
            },
            {
                coords = vector3(132.9550, -146.9116, 49.7883),
                lightRadius = 5.0,
                interval = 25000
            },

            -- Mid floor
            {
                startCoords = vector3(129.7475, -144.5055, 54.7990),
                endCoords = vector3(133.5319, -134.6560, 54.7990),
                lightRadius = 1.50,
                interval = 8000
            },
            {
                startCoords = vector3(122.5887, -155.8825, 54.7991),
                endCoords = vector3(127.6224, -141.8164, 54.7991),
                lightRadius = 1.50,
                interval = 6000
            },
            {
                startCoords = vector3(128.9598, -157.8266, 54.7991),
                endCoords = vector3(133.5996, -144.5976, 54.7991),
                lightRadius = 1.50,
                interval = 8000
            },
            {
                coords = vector3(127.9458, -149.6369, 55.3239),
                lightRadius = 5.0,
                interval = 30000
            },
            {
                coords = vector3(134.3915, -141.7281, 55.3245),
                lightRadius = 2.0,
                interval = 25000
            },
            {
                coords = vector3(135.0717, -152.3000, 55.1938),
                lightRadius = 2.0,
                interval = 20000
            },
            {
                coords = vector3(127.5138, -138.2357, 55.2483),
                lightRadius = 2.0,
                interval = 35000
            },

            -- Top floor
            {
                centre = vector3(130.1403, -136.0952, 60.9060),
                radius = 3.0,
                lightRadius = 1.25,
                interval = 7500 -- milliseconds
            },
            {
                centre = vector3(130.5509, -144.1792, 60.8104),
                radius = 4.0,
                lightRadius = 1.25,
                interval = 6000 -- milliseconds
            },
            {
                centre = vector3(121.3130, -147.6595, 60.7754),
                radius = 4.0,
                lightRadius = 1.25,
                interval = 8000 -- milliseconds
            },
            {
                startCoords = vector3(126.5905, -139.0455, 60.3986),
                endCoords = vector3(145.5614, -145.9032, 60.3986),
                lightRadius = 1.0,
                interval = 10000
            },
            {
                coords = vector3(141.5996, -141.8550, 60.3986),
                lightRadius = 2.0,
                interval = 30000
            },
        }
    },

    officeComputers = {
        requiredItem = 'hack_usb',
        removeAfterUse = false,
        main = vector3(120.674911, -124.284164, 60.217838),
        other = {
            vector3(124.490730, -134.566620, 60.317894),
            vector3(119.362633, -132.603577, 60.317707)
        }
    },

    safe = {
        model = `ch_prop_ch_arcade_safe_door`,
        coords = vector3(117.920746, -125.324043, 60.649063),
        ---@type { item: string?, account: string?, count: integer | { min: integer, max: integer }, chance: integer?, metadata: any? }[]
        rewards = {
            { account = 'money', count = { min = 20000, max = 40000 } },
            { item = 'classified_docs', count = { min = 3, max = 5 } },
            { item = 'rare_coins', count = { min = 1, max = 2 }, chance = 50 },
            { item = 'luxurious_watch', count = { min = 1, max = 2 }, chance = 50 },
            { item = 'WEAPON_PISTOL', count = 1, chance = 25 }
        }
    },
    
    sewerDoors = {
        requiredWeapon = `WEAPON_CROWBAR`,
        locations = {
            {
                model = `3dp_heist_gallery_prop_door_sewer`,
                interact = vector3(165.427704, -140.154907, 44.626778),
                coords = vector3(164.285568, -139.773544, 44.589947),
            },
            {
                model = `3dp_heist_gallery_prop_door_sewer`,
                interact = vector3(133.106415, -142.919144, 44.655796),
                coords = vector3(134.298065, -143.471115, 44.602398)
            },
        }
    },
    
    ---@type { coords: vector3, radius: number, threshold: number }[]
    noiseSensors = {
        {
            coords = vector3(130.3590, -135.9325, 48.9837),
            radius = 5.0,
            threshold = 0.275,
        },
        {
            coords = vector3(127.3403, -144.9407, 48.9428),
            radius = 5.0,
            threshold = 0.5
        },
        {
            coords = vector3(130.1609, -135.9052, 60.2159),
            radius = 5.0,
            threshold = 0.275
        },
        {
            coords = vector3(143.0029, -137.1328, 60.2874),
            radius = 5.0,
            threshold = 0.5
        },
        {
            coords = vector3(151.8738, -145.3809, 50.9313),
            radius = 3.0,
            threshold = 0.275
        },
        {
            coords = vector3(127.5344, -149.5826, 54.3281),
            radius = 5.0,
            threshold = 0.5
        },
        {
            coords = vector3(136.0986, -141.8293, 54.3800),
            radius = 3.0,
            threshold = 0.5
        },
        {
            coords = vector3(115.5291, -142.8328, 54.1685),
            radius = 3.0,
            threshold = 0.5
        }
    },

    cameras = {
        desks = {
            vector3(119.972145, -137.648834, 54.730934),
            vector3(123.507027, -138.916046, 54.730934), 
        },
        settings = {
            rotateSpeed = 0.2,
            controls = {
                left = 34,
                right = 35,
                up = 32,
                down = 33,
                disableSensor = 47
            }
        },
        options = {
            {
                title = locale('cam_break_room_1'),
                coords = vector4(116.8990, -140.1908, 56.7991, 117.2150)
            },
            {
                title = locale('cam_break_room_2'),
                coords = vector4(109.9429, -143.6849, 56.9189, 297.0575)
            },
            {
                title = locale('cam_reception_desk'),
                coords = vector4(121.0340, -145.3086, 57.1898, 116.6645)
            },
            {
                title = locale('cam_reception_1'),
                coords = vector4(115.3819, -146.4435, 57.7077, 173.1990)
            },
            {
                title = locale('cam_reception_2'),
                coords = vector4(118.0940, -158.5838, 57.6207, 29.9711)
            },
            {
                title = locale('cam_stairs_1'),
                coords = vector4(127.9319, -129.5410, 52.8730, 296.4303)
            },
            {
                title = locale('cam_stairs_2'),
                coords = vector4(127.9053, -129.4787, 58.5378, 300.0523)
            },
            {
                title = locale('cam_stairs_3'),
                coords = vector4(137.9655, -127.0598, 63.9047, 116.9035)
            },
            {
                title = locale('cam_stairs_4'),
                coords = vector4(127.9220, -129.5152, 63.9021, 296.5080)
            },
            {
                title = locale('cam_outside_1'),
                coords = vector4(151.4704, -131.4814, 61.5183, 43.9095)
            },
            {
                title = locale('cam_outside_2'),
                coords = vector4(129.6275, -122.5015, 56.8428, 341.2720)
            },
            {
                title = locale('cam_storage'),
                coords = vector4(135.0514, -138.9265, 58.3901, 296.3500)
            },
            {
                title = locale('cam_bottom_1'),
                coords = vector4(127.6180, -130.1770, 52.8264, 195.5217)
            },
            {
                title = locale('cam_bottom_2'),
                coords = vector4(117.8061, -149.1005, 52.4181, 299.8525)
            },
            {
                title = locale('cam_bottom_3'),
                coords = vector4(142.5221, -158.0813, 52.5497, 26.7357)
            },
            {
                title = locale('cam_bottom_4'),
                coords = vector4(138.6060, -145.2959, 52.8308, 339.0700)
            },
            {
                title = locale('cam_bottom_5'),
                coords = vector4(135.2227, -138.7064, 52.7549, 297.0226)
            },
            {
                title = locale('cam_bottom_6'),
                coords = vector4(139.6339, -126.4762, 52.7699, 212.9678)
            },
            {
                title = locale('cam_bottom_7'),
                coords = vector4(152.5292, -131.1713, 52.7574, 110.8419)
            },
            {
                title = locale('cam_bottom_8'),
                coords = vector4(148.7627, -143.8335, 52.0819, 288.5585)
            },
            {
                title = locale('cam_bottom_9'),
                coords = vector4(152.5292, -131.1713, 52.7574, 110.8419),
            },
            {
                title = locale('cam_middle_1'),
                coords = vector4(120.1100, -155.7234, 58.1529, 286.3531)
            },
            {
                title = locale('cam_middle_2'),
                coords = vector4(132.4213, -132.0476, 58.1411, 193.9511)
            },
            {
                title = locale('cam_middle_3'),
                coords = vector4(133.4659, -156.6684, 58.1667, 342.6519)
            },
            {
                title = locale('cam_middle_4'),
                coords = vector4(149.0368, -147.7883, 58.1665, 119.7781)
            },
            {
                title = locale('cam_middle_5'),
                coords = vector4(142.8868, -164.7148, 58.1320, 24.3061)
            },
            {
                title = locale('cam_top_1'),
                coords = vector4(127.7113, -130.2621, 63.7958, 205.2480),
            },
            {
                title = locale('cam_top_2'),
                coords = vector4(119.4746, -137.1482, 63.8062, 205.0904),
            },
            {
                title = locale('cam_top_3'),
                coords = vector4(141.4266, -161.1588, 63.7842, 16.8620)
            },
            {
                title = locale('cam_top_4'),
                coords = vector4(147.5295, -144.4819, 63.4057, 115.2087),
            }
        }
    },

    paintings = {
        item = 'painting',
        locations = {
            vector4(150.8759, -129.8171, 50.8565, 340.0),
            vector4(152.2660, -132.8244, 50.8565, 250.0),
            vector4(150.6164, -137.3566, 50.8565, 250.0),
            vector4(145.9623, -143.2574, 50.8565, 160.0),
            vector4(155.3682, -142.2816, 50.8565, 70.0),
        }
    },

    vault = {
        keypads = {
            vector3(154.677872, -142.628998, 50.720982),
            vector3(153.789612, -145.069534, 50.713234)
        },
        door = {
            model = `ch_prop_ch_vault_d_door_01a`,
            coords = vector3(154.240189, -143.849411, 50.451408)
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
                    coords = vector4(157.1649, -140.7907, 50.2010, 160.0000),
                    type = 'trolley',
                },
                {
                    coords = vector4(158.1986, -141.1669, 50.2010, 160.0000),
                    type = 'trolley',
                },
                {
                    coords = vector4(159.2323, -141.5431, 50.2010, 160.0000),
                    type = 'trolley',
                },
                {
                    coords = vector4(160.4786, -142.8922, 50.2010, 70.0000),
                    type = 'trolley',
                },
                {
                    coords = vector4(160.1024, -143.9259, 50.2010, 70.0000),
                    type = 'trolley',
                },
                {
                    coords = vector4(159.7262, -144.9595, 50.2010, 70.0000),
                    type = 'trolley',
                },
                {
                    coords = vector4(157.5833, -147.2114, 50.2010, 340.0),
                    type = 'trolley',
                }
            }
        }
    },

    -- Props that are unnecessary in the MLO
    removeProps = {
        { coords = vector3(158.800034, -142.847610, 50.682278), model = `ex_prop_crate_oegg` },
        { coords = vector3(158.905716, -144.162094, 50.211979), model = `ex_prop_crate_gems_sc` },
        { coords = vector3(156.451920, -141.309509, 50.563221), model = `ex_prop_crate_jewels_sc` },
        { coords = vector3(152.864349, -145.099274, 50.305851), model = `3dp_heist_gallery_prop_wrapped_picture_02` },
        { coords = vector3(152.864349, -145.099274, 50.305851), model = `3dp_heist_gallery_prop_wrapped_picture_01` },
        { coords = vector3(153.404251, -145.398239, 50.034069), model = `v_corp_banktrolley` },
        { coords = vector3(157.591858, -146.402756, 50.151070), model = `v_corp_banktrolley` },
        { coords = vector3(150.886353, -129.829834, 50.817406), model = `3dp_heist_gallery_prop_art_47`},
        { coords = vector3(152.260757, -132.813095, 50.853065), model = `3dp_heist_gallery_prop_art_48`},
        { coords = vector3(150.609406, -137.350189, 50.846050), model = `3dp_heist_gallery_prop_art_49`},
        { coords = vector3(145.995285, -143.261917, 50.815113), model = `3dp_heist_gallery_prop_art_50`}
    }
}