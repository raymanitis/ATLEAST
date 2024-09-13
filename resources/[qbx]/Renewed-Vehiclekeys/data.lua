return {
    lockChance = 0.5, -- (50%) Chance of local vehicles to be locked around the world
    lockChanceAI = 0.5, -- (50%) Chance of AI vehicles to be locked around the world

    useWeaponRobbery = true, -- Be able to rob driving peds for their vehicle keys

    useKeybindKey = true, -- Weather or not to use the build in keybind system
    useHotwireSystem = true, -- Weather or not to use the hotwire system

    useKeyItem = false, -- set to true if you want to use a item based key system

    engineKey = 'G', -- Key to toggle the engine on and off
    lockKey = 'L', -- Key to toggle the lock on and off

    circleProgress = true, -- Uses the circle progress bar instead of the default one from ox_lib

    immune = {
        [`bmx`] = true,
    },

    -- Specific Doors that are ALWAYS locked no matter what
    doorsBlocked = {
        [`stockade`] = {[1] = true, [2] = true}
    },

    searchPercent = 0.03, -- 3% chance of getting a item from searching a vehicle
    rewards = {
        { name = 'money', amount = 20, },
        { name = 'key' } -- we don't need to specify amount here as it will just give u 1 or if not using items give u the key
    },

    -- Minigame settings

    -- Whichs possible keys can show up when they lockpick / hotwire the vehicle
    keys = {'r', 'e', 'n', 'e', 'w', 'e', 'd'},

    difficulties = {
        slow = { time = {min = 75, max = 150}, turns = {min = 3, max = 5} },
        medium = { time = {min = 50, max = 100}, turns = {min = 2, max = 4} },
        fast = { time = {min = 25, max = 50}, turns = {min = 1, max = 2} }
    },

    -- Vehicle Config
    vehicles = {
        -- Compacts --
        [0] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },


        -- Sedans --
        [1] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },


        -- SUVS --
        [2] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },


        -- COUPES --
        [3] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },


        -- MUSCLES --
        [4] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },

        -- SPORT CLASSICS --
        [5] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },

        -- Sports --
        [6] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },

        -- SUPERS --
        [7] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },

        -- MOTORCYCLES --
        [8] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
            noLocks = true, -- This vehicle cannot be locked!
        },

        -- OFF-ROAD --
        [9] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },


        -- Industrial --
        [10] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },

        -- Utility --
        [11] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },

        -- Vans --
        [12] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },

        -- Cycles --
        [13] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
            noLocks = true, -- This vehicle cannot be locked!
        },

        -- Boats --
        [14] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },

        -- Helicopters --
        [15] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },


        -- Planes --
        [16] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },

        -- Service --
        [17] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },

        -- Emergency --
        [18] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                advancedlockpick = {
                    difficulty = 'slow',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = false, -- Can this vehicle be hotwired?
            search = false, -- Can this vehicle be searched?
        },

        -- Military --
        [19] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },

        -- Commercial --
        [20] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },

        -- Trains --
        [21] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },

        -- Open Wheel --
        [22] = {
            pickable = true, -- Can this vehicle be lock picked?
            pickItem = {  -- What item is required to lock pick this vehicle?
                lockpick = {
                    difficulty = 'slow',
                    degrade = {min = 1, max = 5}
                },

                advancedlockpick = {
                    difficulty = 'medium',
                    degrade = {min = 0, max = 2}
                }
            },
            hotwire = 'slow', -- The difficulty of hotwiring this vehicle, false if it cannot be hotwired
            search = 5000, -- Time it takes to search this vehicle, if false it cannot be searched
        },
    },


    -- List of all the weapons that peds do not become scared of when you aim at them
    blockedWeapons = {
        [`WEAPON_UNARMED`] = true,
        [`WEAPON_KNIFE`] = true,
        [`WEAPON_NIGHTSTICK`] = true,
        [`WEAPON_HAMMER`] = true,
        [`WEAPON_BAT`] = true,
        [`WEAPON_CROWBAR`] = true,
        [`WEAPON_GOLFCLUB`] = true,
        [`WEAPON_BOTTLE`] = true,
        [`WEAPON_DAGGER`] = true,
        [`WEAPON_HATCHET`] = true,
        [`WEAPON_MACHETE`] = true,
        [`WEAPON_FLASHLIGHT`] = true,
        [`WEAPON_SWITCHBLADE`] = true,
        [`WEAPON_POOLCUE`] = true,
        [`WEAPON_WRENCH`] = true,
        [`WEAPON_BATTLEAXE`] = true,
        [`WEAPON_GRENADE`] = true,
        [`WEAPON_STICKYBOMB`] = true,
        [`WEAPON_BZGAS`] = true,
        [`WEAPON_MOLOTOV`] = true,
        [`WEAPON_FIREEXTINGUISHER`] = true,
        [`WEAPON_PETROLCAN`] = true,
        [`WEAPON_FLARE`] = true,
        [`WEAPON_BALL`] = true,
        [`WEAPON_SNOWBALL`] = true,
        [`WEAPON_SMOKEGRENADE`] = true,
    }
}