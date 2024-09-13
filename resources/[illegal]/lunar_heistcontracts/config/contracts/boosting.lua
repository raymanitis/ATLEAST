Config.contracts.boosting = {
    ---@type ContractSettings
    settings = {
        disabled = false,
        chance = 35,
        requiredExperience = 100,
        expiry = 23 * 60,
        timeToStart = 30,
        minMembers = 2,
        minPolice = 1
    },

    dispatch = {
        enabled = true,
        code = '10-68',
        title = locale('dispatch_boosting_title'),
        message = locale('dispatch_boosting_message'),
        vehicleBlip = {
            updateInterval = 5000, -- I don't recommend changing this, your server peformance can drop if it's too low
            name = locale('stolen_vehicle'),
            sprite = 225,
            scale = 0.75,
            color = 1
        }
    },

    approximateRadius = 200.0,

    spawnLocations = {
        ['lockpick'] = {
            vector4(-1520.7578, -548.4412, 32.8482, 215.3415),
            vector4(-170.4345, -1439.5774, 30.9451, 50.3475),
            vector4(439.7684, -1517.5640, 28.9398, 140.0629),
            vector4(-463.9556, -614.1570, 30.8367, 179.4923),
            vector4(-810.8802, -753.6340, 22.3218, 90.3339),
            vector4(-834.4339, -1168.1241, 6.2571, 76.6386),
            vector4(-925.6292, -1299.3309, 4.6819, 19.8721),
            vector4(-1043.3739, -1326.1215, 5.1195, 254.4179),
            vector4(-1178.2334, -1488.6187, 4.0427, 305.0702),
            vector4(-1194.2140, -1480.0293, 4.0422, 125.7524),
            vector4(-966.2504, -1592.5219, 4.6813, 20.8618),
            vector4(-804.7687, -1313.8940, 4.6623, 349.9294),
            vector4(-707.9008, -1276.6799, 4.6626, 140.8960),
            vector4(-611.1016, -1597.5709, 26.4128, 85.3701),
            vector4(-620.8082, -1649.5424, 25.4875, 61.0062),
            vector4(-48.8321, -2008.3660, 17.6785, 109.7960),
            vector4(-337.6100, -2176.8147, 9.9799, 270.9385),
            vector4(-301.8607, -2225.3982, 8.1526, 324.5063),
            vector4(-239.7739, -1474.9739, 31.1183, 319.9109),
            vector4(49.3928, -1720.2686, 28.9647, 229.9328),
            vector4(37.4871, -1734.4160, 28.9647, 230.6106),
            vector4(626.4125, 164.2940, 96.0126, 70.4869),
            vector4(684.2336, 238.1650, 93.4130, 60.4013),
            vector4(713.7549, 247.0225, 92.7226, 61.0322),
            vector4(470.8979, 246.3734, 102.8715, 69.7763),
            vector4(386.8878, 290.8047, 102.7093, 165.8121),
            vector4(204.8080, 390.3016, 106.8898, 171.7657),
            vector4(-369.4258, 298.0104, 84.5275, 180.7057),
            vector4(-381.2932, 280.3168, 84.4847, 13.9491),
            vector4(-571.2256, 337.9190, 84.2042, 175.0359),
            vector4(-612.4045, 331.4264, 84.7796, 355.4982)
        },
        ['keyfob'] = {
            {
                coords = vector4(-479.2318, 597.1677, 127.3753, 90.9704),
                -- Possible places where the signal could be coming from
                signal = {
                    vector3(-451.2128, 599.5940, 128.4270),
                    vector3(-451.2802, 587.5130, 129.0895),
                    vector3(-461.1254, 579.1854, 129.8361),
                    vector3(-455.1431, 579.5142, 129.0618)
                },
                -- Possible dog spawn locations
                dog = {
                    vector4(-443.8341, 585.2844, 127.1710, 205.7532),
                    vector4(-450.0932, 565.0529, 124.3823, 113.1404),
                    vector4(-471.8669, 573.9384, 125.8749, 156.876)
                }
            },
            {
                coords = vector4(-1750.8333, 365.3658, 88.9634, 116.8392),
                -- Possible places where the signal could be coming from
                signal = {
                    vector3(-1723.7144, 355.5685, 89.4251),
                    vector3(-1726.1024, 368.1982, 89.7608),
                    vector3(-1712.0718, 378.0889, 90.2248),
                    vector3(-1714.3124, 386.2498, 89.7250),
                    vector3(-1733.0771, 379.0028, 89.7251),
                },
                -- Possible dog spawn locations
                dog = {
                    vector4(-1725.7426, 369.8363, 89.7575, 227.3727),
                    vector4(-1708.0585, 388.3655, 89.3036, 199.7610),
                    vector4(-1704.3773, 367.2439, 87.0613, 139.2555)
                }
            },
            {
                coords = vector4(-1997.0525, 295.3358, 91.0374, 285.1936),
                -- Possible places where the signal could be coming from
                signal = {
                    vector3(-1995.4154, 301.1107, 91.9646),
                    vector3(-2009.8153, 294.7317, 91.7600),
                    vector3(-2014.3499, 304.8646, 91.3440),
                    vector3(-2017.7073, 319.1851, 91.3483),
                    vector3(-2009.8459, 316.7469, 91.5606),
                    vector3(-1998.9141, 313.5500, 91.5606),
                },
                -- Possible dog spawn locations
                dog = {
                    vector4(-2010.2638, 325.1972, 91.5606, 292.1094),
                    vector4(-1990.3757, 313.2166, 91.6996, 197.7217),
                    vector4(-2017.3981, 310.3386, 91.3643, 194.6337),
                }
            },
            {
                coords = vector4(-1937.1790, 181.6171, 83.9006, 307.6016),
                signal = {
                    vector3(-1922.1437, 160.1411, 84.8484),
                    vector3(-1943.6018, 151.1130, 84.8461),
                    vector3(-1949.9512, 159.3916, 84.8469),
                    vector3(-1961.4309, 169.1945, 84.6537),
                    vector3(-1948.8948, 178.7565, 84.6546),                        
                },
                dog = {
                    vector4(-1952.7725, 161.0499, 84.6525, 216.3790),
                    vector4(-1949.4656, 137.5034, 84.6528, 335.2778),
                }
            },
            {
                coords = vector4(-1937.1790, 181.6171, 83.9006, 307.6016),
                signal = {
                    vector3(-1922.1437, 160.1411, 84.8484),
                    vector3(-1943.6018, 151.1130, 84.8461),
                    vector3(-1949.9512, 159.3916, 84.8469),
                    vector3(-1961.4309, 169.1945, 84.6537),
                    vector3(-1948.8948, 178.7565, 84.6546),                        
                },
                dog = {
                    vector4(-1952.7725, 161.0499, 84.6525, 216.3790),
                    vector4(-1949.4656, 137.5034, 84.6528, 335.2778),
                }
            },
            {
                coords = vector4(-1270.7074, 507.0760, 96.5317, 180.0175),
                signal = {
                    vector3(-1277.9529, 497.1163, 97.8904),
                    vector3(-1289.2899, 486.8794, 97.5597),
                    vector3(-1288.9506, 500.7378, 97.5597),
                    vector3(-1299.2777, 514.1119, 97.5599),
                    vector3(-1299.1503, 520.5468, 97.5599),
                    vector3(-1285.9489, 524.2120, 98.5050),
                    vector3(-1265.0345, 523.8202, 96.7779),                        
                },
                dog = {
                    vector4(-1290.0165, 504.8416, 97.5598, 177.1596),
                    vector4(-1297.0541, 536.0049, 101.9502, 2.4929)
                }
            },
            {
                coords = vector4(-1099.9408, 556.5491, 101.9875, 102.8939),
                signal = {
                    vector3(-1089.9263, 548.5173, 103.6334),
                    vector3(-1069.6993, 551.4531, 102.7304),
                    vector3(-1069.4723, 561.8574, 102.9210),
                    vector3(-1082.2906, 573.3425, 102.7257),
                    vector3(-1075.0126, 572.0650, 102.7270),                        
                },
                dog = {
                    vector4(-1065.8203, 558.1601, 102.7286, 306.7905),
                    vector4(-1097.3483, 537.6516, 102.7018, 207.7213),
                    vector4(-1074.5341, 573.5345, 102.7258, 34.8669)
                }
            },
            {
                coords = vector4(-945.7809, 595.9313, 100.2713, 162.6593),
                signal = {
                    vector3(-951.9478, 615.4610, 109.6673),
                    vector3(-941.5214, 619.4229, 109.8670),
                    vector3(-930.9655, 615.9601, 109.8663),
                    vector3(-952.8363, 593.7595, 105.4377),
                    vector3(-958.0143, 595.4472, 105.4377),
                    vector3(-957.9819, 604.2910, 105.4377),                        
                },
                dog = {
                    vector4(-932.8885, 605.0627, 109.7692, 74.2809),
                    vector4(-952.0020, 597.5383, 109.2977, 342.7045)
                }
            },
            {
                coords = vector4(-806.4092, 425.2929, 90.8456, 337.5347),
                signal = {
                    vector3(-805.8190, 407.3279, 91.5597),
                    vector3(-814.6285, 403.4699, 91.5598),
                    vector3(-820.1439, 403.2643, 91.5597),
                    vector3(-827.5478, 400.3836, 91.5458),
                    vector3(-833.2071, 406.2167, 91.5597),
                    vector3(-832.6088, 418.6907, 91.5634),
                    vector3(-836.4852, 412.8113, 91.5411),
                    vector3(-824.8073, 421.9895, 92.1242),
                },
                dog = {
                    vector4(-820.0910, 401.9077, 91.5595, 242.5643),
                    vector4(-837.1818, 409.0812, 91.4593, 1.8317)
                }
            },
            {
                coords = vector4(-1053.6470, 768.0931, 166.9328, 276.0136),
                signal = {
                    vector3(-1058.9114, 755.1713, 167.3101),
                    vector3(-1069.7841, 749.4611, 168.0472),
                    vector3(-1070.2922, 757.5201, 168.0472),
                    vector3(-1084.2654, 759.3033, 168.2310),
                    vector3(-1090.0658, 764.6542, 168.0489),
                    vector3(-1078.7429, 771.3269, 168.0472),
                    vector3(-1065.0428, 772.0513, 170.0545),
                },
                dog = {
                    vector4(-1075.4376, 772.1696, 168.0470, 277.4811),
                    vector4(-1071.6671, 756.8495, 168.0475, 183.3542)
                }
            },
            {
                coords = vector4(-594.3798, 753.9817, 182.9887, 257.2894),
                signal = {
                    vector3(-587.6550, 767.5355, 188.5103),
                    vector3(-597.4534, 764.2040, 189.3102),
                    vector3(-608.7227, 772.1409, 188.7097),
                    vector3(-604.8251, 768.3967, 188.5103),
                    vector3(-618.6473, 773.3822, 188.5196),
                    vector3(-618.3226, 778.5288, 188.5205),                        
                },
                dog = {
                    vector4(-620.4013, 779.0128, 188.5196, 170.7271),
                    vector4(-584.4644, 773.2662, 188.5093, 211.5001)
                }
            },
            {
                coords = vector4(-520.8345, 574.9931, 121.3071, 280.9768),
                signal = {
                    vector3(-543.7930, 586.9905, 117.3114),
                    vector3(-525.8796, 572.8200, 121.4510),
                    vector3(-537.5488, 573.3865, 121.2546),
                    vector3(-542.3812, 576.9590, 117.3112),                        
                },
                dog = {
                    vector4(-551.6342, 590.9133, 114.9683, 191.0835),
                    vector4(-536.5128, 565.9169, 117.3113, 102.0672)
                }
            },
            {
                coords = vector4(-575.1688, 496.3365, 105.8740, 11.2655),
                signal = {
                    vector3(-570.2431, 477.6638, 107.9281),
                    vector3(-585.1104, 469.2743, 109.3373),
                    vector3(-597.5217, 468.6186, 109.0135),
                    vector3(-599.3658, 481.2415, 109.2043),
                    vector3(-601.3388, 491.1221, 109.0136),                        
                },
                dog = {
                    vector4(-594.8941, 464.1763, 109.0135, 190.0485),
                    vector4(-570.1520, 476.0711, 107.9281, 192.3974)
                }
            },
            {
                coords = vector4(-358.9918, 515.5300, 119.1310, 136.7789),
                signal = {
                    vector3(-338.0842, 529.1056, 120.2611),
                    vector3(-328.0660, 520.1568, 120.1231),
                    vector3(-331.1550, 509.9329, 120.1430),
                    vector3(-352.4466, 522.5242, 120.1499),                        
                },
                dog = {
                    vector3(-335.7412, 528.6562, 120.1426),
                    vector3(-326.8187, 516.5598, 119.8541)
                }
            },
            {
                coords = vector4(-196.5192, 615.2192, 196.4062, 185.5072),
                signal = {
                    vector3(-188.5512, 643.5150, 199.6403),
                    vector3(-198.9198, 636.4758, 199.6404),
                    vector3(-179.6006, 643.8037, 199.6412),
                    vector3(-170.4339, 628.2401, 198.6285),
                    vector3(-177.4018, 617.2621, 198.6331),
                },
                dog = {
                    vector4(-169.6767, 654.6321, 200.6979, 100.2005),
                    vector4(-168.4617, 630.7152, 198.6264, 181.9154)
                }
            },
            {
                coords = vector4(-353.6120, 474.5162, 111.9749, 280.4931),
                signal = {
                    vector3(-371.6213, 462.2370, 112.6474),
                    vector3(-369.0779, 468.0324, 112.6461),
                    vector3(-370.8619, 456.0660, 112.4624),
                    vector3(-355.7995, 458.2690, 116.6468),                        
                },
                dog = {
                    vector3(-371.0592, 454.1260, 112.4624)
                }
            }
        }
    },

    deliveryLocations = {
        vector4(400.6250, 2590.8079, 43.5194, 105.5167),
        vector4(-2193.3118, 4243.5928, 48.0176, 39.2991),
        vector4(349.1683, 3406.9587, 36.4514, 24.9887),
        vector4(975.9569, 3616.3884, 32.6320, 273.3684),
        vector4(2483.1201, 4111.1504, 38.0647, 339.5246),
        vector4(1770.2189, 4585.8433, 37.7066, 246.0966),
        vector4(-170.7366, 6444.8672, 31.5149, 47.3494),
        vector4(184.6294, 6634.5713, 31.5401, 187.4902),
        vector4(1458.2036, 6347.6787, 23.8370, 21.6108),
        vector4(2934.2437, 4630.8838, 48.5426, 51.0063),
        vector4(1591.8646, 3619.1174, 35.1463, 301.2936)
    },

    areaBlip = {
        name = locale('car_approx_location'),
        sprite = 456,
        size = 0.9,
        color = 1
    },

    carBlip = {
        name = locale('target_car'),
        sprite = 225,
        size = 0.75,
        color = 1 
    },

    deliveryBlip = {
        name = locale('delivery_location'),
        sprite = 431,
        color = 2,
        size = 0.9
    },

    -- Used in the keyfob style mission
    dog = {
        enabled = true,
        models = {
            `a_c_chop`,
            `a_c_husky`,
            `a_c_retriever`,
            `a_c_rottweiler`
        }
    },

    --- The item needed for the lockpick style
    lockpickItem = {
        name = 'lockpick',
        removeAfterUse = false
    },
    --- The item needed for the hack
    removeTrackerItem = {
        name = 'hack_usb',
        removeAfterUse = false
    },

    -- One of the models will be used
    deliveryPed = {
        `g_m_importexport_01`,
        `g_m_y_mexgoon_03`,
        `g_m_y_famfor_01`,
    },

    rewardAccount = 'money',

    ---@alias BoostingClass { label: string, image: string, style: 'lockpick' | 'keyfob', chance: integer, price: integer, reward: { money: integer | { min: integer, max: integer }, crypto: integer | { min: integer, max: integer }, experience: integer | { min: integer, max: integer } }, hasTracker: boolean, cars: (string | number)[] }

    -- lockpick = Only use a lockpick to unlock it
    -- keyfob = You need a signal booster to unlock the vehicle
    ---@type BoostingClass[]
    classes = {
        {
            label = 'D',
            image = './contracts/boosting_d.webp', -- Located in web/build
            style = 'lockpick',
            chance = 50,
            price = 0,
            reward = { money = { min = 2500, max = 7500 }, crypto = 25, experience = 100 },
            hasTracker = false,
            cars = {
                `tornado`,
                `tornado2`,
                `voodoo2`,
                `voodoo`,
                `hermes`,
                `hustler`,
                `tornado3`,
                `peyote`,
                `virgo2`,
                `virgo3`,
                `romero`,
                `dynasty`,
                `pigalle`
            },
        },
        {
            label = 'C',
            image = './contracts/boosting_c.webp', -- Located in web/build
            style = 'lockpick',
            chance = 25,
            price = 0,
            reward = { money = { min = 5000, max = 12500 }, crypto = 50, experience = 150 },
            hasTracker = false,
            cars = {
                `futo`,
                `glendale`,
                `ingot`,
                `issi2`,
                `panto`,
                `prairie`,
                `rhapsody`,
                `stalion`,
                `warrener`,
                `weevil`,
                `brioso2`,
                `kanjo`,
                `nebula`
            },
        },
        {
            label = 'B',
            image = './contracts/boosting_b.webp', -- Located in web/build
            style = 'keyfob',
            chance = 20,
            price = 10,
            reward = { money = { min = 12500, max = 20000 }, crypto = 100, experience = 200 },
            hasTracker = true,
            cars = {
                `komoda`,
                `jugular`,
                `locust`,
                `neo`,
                `paragon`,
                `rebla`,
                `caracara2`,
                `drafter`,
                `novak`,
                `schafter3`,
                `sugoi`,
                `toros`,
                `vstr`
            },
        },
        {
            label = 'A',
            image = './contracts/boosting_a.webp', -- Located in web/build
            style = 'keyfob',
            chance = 3,
            price = 20,
            reward = { money = { min = 25000, max = 50000 }, crypto = 200, experience = 250 },
            hasTracker = false,
            cars = {
                `comet4`,
                `comet5`,
                `coquette4`,
                `elegy`,
                `elegy2`,
                `feltzer3`,
                `jester3`,
                `raiden`,
                `schlagen`,
                `flashgt`,
                `pariah`
            },
        },
        {
            label = 'S',
            image = './contracts/boosting_s.webp', -- Located in web/build
            style = 'keyfob',
            chance = 2,
            price = 50,
            reward = { money = { min = 50000, max = 75000 }, crypto = 350, experience = 500 },
            hasTracker = true,
            cars = {
                `autarch`,
                `cheetah2`,
                `cyclone`,
                `deveste`,
                `emerus`,
                `entity2`,
                `furia`,
                `italigtb2`,
                `krieger`,
                `le7b`,
                `nero2`,
                `s80`,
                `sc1`
            }
        },
        {
            label = 'S+',
            image = './contracts/boosting_sp.webp', -- Located in web/build
            style = 'keyfob',
            chance = 1,
            price = 75,
            reward = { money = { min = 75000, max = 100000 }, crypto = 500, experience = 750 },
            hasTracker = true,
            cars = {
                `thrax`,
                `tigon`,
                `vagner`,
                `taipan`,
                `tezeract`,
                `torero`,
                `tyrant`,
                `visione`,
                `xa21`,
                `zorrusso`,
                `prototipo`,
                `sultanrs`
            }
        }
        
    }
}