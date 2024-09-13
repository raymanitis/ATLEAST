Config = {}

Config.EnableExtraMenu = true
Config.Fliptime = 15000

Config.MenuItems = {
    [1] = {
        id = 'citizen',
        title = 'Galvenais',
        icon = 'user',
        items = {
            {
                id = 'getintrunk',
                title = 'Iekāpt bagāžniekā',
                icon = 'car',
                type = 'client',
                event = 'qb-trunk:client:GetIn',
                shouldClose = true
            }
        }
    },
    [2] = {
        id = 'general',
        title = 'Vispārīgi',
        icon = 'rectangle-list',
        items = {
            {
                id = 'house',
                title = 'Māja',
                icon = 'house',
                items = {
                    {
                        id = 'givehousekey',
                        title = 'Iedod atslēgas',
                        icon = 'key',
                        type = 'client',
                        event = 'qb-houses:client:giveHouseKey',
                        shouldClose = true
                    }, {
                        id = 'removehousekey',
                        title = 'Noņemt atslēgas',
                        icon = 'key',
                        type = 'client',
                        event = 'qb-houses:client:removeHouseKey',
                        shouldClose = true
                    }, {
                        id = 'togglelock',
                        title = 'Pārmainīt slēdzeni',
                        icon = 'door-closed',
                        type = 'client',
                        event = 'qb-houses:client:toggleDoorlock',
                        shouldClose = true
                    }, {
                        id = 'decoratehouse',
                        title = 'Dekorēt māju',
                        icon = 'box',
                        type = 'client',
                        event = 'qb-houses:client:decorate',
                        shouldClose = true
                    }, {
                        id = 'houseLocations',
                        title = 'Mijiedarbība',
                        icon = 'house',
                        items = {
                            {
                                id = 'setstash',
                                title = 'Iestatīt stashu',
                                icon = 'box-open',
                                type = 'client',
                                event = 'qb-houses:client:setLocation',
                                shouldClose = true
                            }, {
                                id = 'setoutift',
                                title = 'Iestatīt garderobi',
                                icon = 'shirt',
                                type = 'client',
                                event = 'qb-houses:client:setLocation',
                                shouldClose = true
                            }, {
                                id = 'setlogout',
                                title = 'Iziešana',
                                icon = 'door-open',
                                type = 'client',
                                event = 'qb-houses:client:setLocation',
                                shouldClose = true
                            }
                        }
                    }
                }
            }, {
                id = 'clothesmenu',
                title = 'Apģērbs',
                icon = 'shirt',
                items = {
                    {
                        id = 'Hair',
                        title = 'Mati',
                        icon = 'user',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleClothing',
                        arg = {id = 'Hair'},
                        shouldClose = true
                    }, {
                        id = 'Ear',
                        title = 'Auss',
                        icon = 'ear-deaf',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleProps',
                        arg = 'Ear',
                        shouldClose = true
                    }, {
                        id = 'Neck',
                        title = 'Kakls',
                        icon = 'user-tie',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleClothing',
                        arg = {id = 'Neck'},
                        shouldClose = true
                    }, {
                        id = 'Top',
                        title = 'Augša',
                        icon = 'shirt',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleClothing',
                        arg = {id = 'Top'},
                        shouldClose = true
                    }, {
                        id = 'Shirt',
                        title = 'Krekls',
                        icon = 'shirt',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleClothing',
                        arg = {id = 'Shirt'},
                        shouldClose = true
                    }, {
                        id = 'Pants',
                        title = 'Bikses',
                        icon = 'user',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleClothing',
                        arg = {id = 'Pants'},
                        shouldClose = true
                    }, {
                        id = 'Shoes',
                        title = 'Kurpes',
                        icon = 'shoe-prints',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleClothing',
                        arg = {id = 'Shoes'},
                        shouldClose = true
                    }, {
                        id = 'meer',
                        title = 'Ekstras',
                        icon = 'plus',
                        items = {
                            {
                                id = 'Hat',
                                title = 'Cepure',
                                icon = 'hat-cowboy-side',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleProps',
                                arg = 'Hat',
                                shouldClose = true
                            }, {
                                id = 'Glasses',
                                title = 'Brilles',
                                icon = 'glasses',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleProps',
                                arg = 'Glasses',
                                shouldClose = true
                            }, {
                                id = 'Visor',
                                title = 'Sejsegu',
                                icon = 'hat-cowboy-side',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleProps',
                                arg = 'Visor',
                                shouldClose = true
                            }, {
                                id = 'Mask',
                                title = 'Maska',
                                icon = 'masks-theater',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleClothing',
                                arg = {id = 'Mask'},
                                shouldClose = true
                            }, {
                                id = 'Vest',
                                title = 'Veste',
                                icon = 'vest',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleClothing',
                                arg = {id = 'Vest'},
                                shouldClose = true
                            }, {
                                id = 'Bag',
                                title = 'Soma',
                                icon = 'bag-shopping',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleClothing',
                                arg = {id = 'Bag'},
                                shouldClose = true
                            }, {
                                id = 'Bracelet',
                                title = 'Aproce',
                                icon = 'user',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleProps',
                                arg = 'Bracelet',
                                shouldClose = true
                            }, {
                                id = 'Watch',
                                title = 'Pulkstenis',
                                icon = 'stopwatch',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleProps',
                                arg = 'Watch',
                                shouldClose = true
                            }, {
                                id = 'Gloves',
                                title = 'Cimdi',
                                icon = 'mitten',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleClothing',
                                arg = {id = 'Gloves'},
                                shouldClose = true
                            }
                        }
                    }
                }
            }
        }
    },
}

Config.VehicleDoors = {
    id = 'vehicledoors',
    title = 'Auto durvis',
    icon = 'car-side',
    items = {
        {
            id = 'door0',
            title = 'Durvis (1)',
            icon = 'car-side',
            type = 'client',
            event = 'qb-radialmenu:client:openDoor',
            arg = 0,
            shouldClose = false
        }, {
            id = 'door4',
            title = 'Kapots',
            icon = 'car',
            type = 'client',
            event = 'qb-radialmenu:client:openDoor',
            arg = 4,
            shouldClose = false
        }, {
            id = 'door1',
            title = 'Durvis (2)',
            icon = 'car-side',
            type = 'client',
            event = 'qb-radialmenu:client:openDoor',
            arg = 1,
            shouldClose = false
        }, {
            id = 'door3',
            title = 'Durvis (3)',
            icon = 'car-side',
            type = 'client',
            event = 'qb-radialmenu:client:openDoor',
            arg = 3,
            shouldClose = false
        }, {
            id = 'door5',
            title = 'Bagāžnieks',
            icon = 'car',
            type = 'client',
            event = 'qb-radialmenu:client:openDoor',
            arg = 5,
            shouldClose = false
        }, {
            id = 'door2',
            title = 'Durvis (4)',
            icon = 'car-side',
            type = 'client',
            event = 'qb-radialmenu:client:openDoor',
            arg = 2,
            shouldClose = false
        }
    }
}

Config.VehicleExtras = {
    id = 'vehicleextras',
    title = 'Auto ekstras',
    icon = 'plus',
    items = {
        {
            id = 'extra1',
            title = 'Ekstra 1',
            icon = 'box-open',
            type = 'client',
            event = 'radialmenu:client:setExtra',
            arg = 1,
            shouldClose = false
        }, {
            id = 'extra2',
            title = 'Ekstra 2',
            icon = 'box-open',
            type = 'client',
            event = 'radialmenu:client:setExtra',
            arg = 2,
            shouldClose = false
        }, {
            id = 'extra3',
            title = 'Ekstra 3',
            icon = 'box-open',
            type = 'client',
            event = 'radialmenu:client:setExtra',
            arg = 3,
            shouldClose = false
        }, {
            id = 'extra4',
            title = 'Ekstra 4',
            icon = 'box-open',
            type = 'client',
            event = 'radialmenu:client:setExtra',
            arg = 4,
            shouldClose = false
        }, {
            id = 'extra5',
            title = 'Ekstra 5',
            icon = 'box-open',
            type = 'client',
            event = 'radialmenu:client:setExtra',
            arg = 5,
            shouldClose = false
        }, {
            id = 'extra6',
            title = 'Ekstra 6',
            icon = 'box-open',
            type = 'client',
            event = 'radialmenu:client:setExtra',
            arg = 6,
            shouldClose = false
        }, {
            id = 'extra7',
            title = 'Ekstra 7',
            icon = 'box-open',
            type = 'client',
            event = 'radialmenu:client:setExtra',
            arg = 7,
            shouldClose = false
        }, {
            id = 'extra8',
            title = 'Ekstra 8',
            icon = 'box-open',
            type = 'client',
            event = 'radialmenu:client:setExtra',
            arg = 8,
            shouldClose = false
        }, {
            id = 'extra9',
            title = 'Ekstra 9',
            icon = 'box-open',
            type = 'client',
            event = 'radialmenu:client:setExtra',
            arg = 9,
            shouldClose = false
        }, {
            id = 'extra10',
            title = 'Ekstra 10',
            icon = 'box-open',
            type = 'client',
            event = 'radialmenu:client:setExtra',
            arg = 10,
            shouldClose = false
        }, {
            id = 'extra11',
            title = 'Ekstra 11',
            icon = 'box-open',
            type = 'client',
            event = 'radialmenu:client:setExtra',
            arg = 11,
            shouldClose = false
        }, {
            id = 'extra12',
            title = 'Ekstra 12',
            icon = 'box-open',
            type = 'client',
            event = 'radialmenu:client:setExtra',
            arg = 12,
            shouldClose = false
        }, {
            id = 'extra13',
            title = 'Ekstra 13',
            icon = 'box-open',
            type = 'client',
            event = 'radialmenu:client:setExtra',
            arg = 13,
            shouldClose = false
        }
    }
}

Config.VehicleSeats = {
    id = 'vehicleseats',
    label = 'Sedvietas',
    icon = 'chair',
    menu = 'vehicleseatsmenu'
}

Config.JobInteractions = {
    ["ambulance"] = {
        {
            id = 'statuscheck',
            title = 'Pārbaudiet veselības stāvokli',
            icon = 'heart-pulse',
            type = 'client',
            event = 'hospital:client:CheckStatus',
            shouldClose = true
        },{
            id = 'revivep',
            title = 'Atdzīvināt',
            icon = 'user-doctor',
            type = 'client',
            event = 'hospital:client:RevivePlayer',
            shouldClose = true
        },{
            id = 'treatwounds',
            title = 'Dziedēt brūces',
            icon = 'bandage',
            type = 'client',
            event = 'hospital:client:TreatWounds',
            shouldClose = true
        }, {
            id = 'escort',
            title = 'Eskorts',
            icon = 'user-group',
            type = 'client',
            event = 'police:client:EscortPlayer',
            shouldClose = true
        },
    },
    ["taxi"] = {
        {
            id = 'togglemeter',
            title = 'Rādīt/paslēpt mērītāju',
            icon = 'eye-slash',
            type = 'client',
            event = 'qb-taxi:client:toggleMeter',
            shouldClose = false
        }, {
            id = 'togglemouse',
            title = 'Rādīt/paslēpt mērītāju',
            icon = 'hourglass-start',
            type = 'client',
            event = 'qb-taxi:client:enableMeter',
            shouldClose = true
        }, {
            id = 'npc_mission',
            title = 'Civilā misija',
            icon = 'taxi',
            type = 'client',
            event = 'qb-taxi:client:DoTaxiNpc',
            shouldClose = true
        }
    },
    ["tow"] = {
        {
            id = 'togglenpc',
            title = 'Pārslēgt Civilo',
            icon = 'toggle-on',
            type = 'client',
            event = 'jobs:client:ToggleNpc',
            shouldClose = true
        }, {
            id = 'towvehicle',
            title = 'Velkošais transportlīdzeklis',
            icon = 'truck-pickup',
            type = 'client',
            event = 'qb-tow:client:TowVehicle',
            shouldClose = true
        }
    },
    ["mechanic"] = {
        {
            id = 'towvehicle',
            title = 'Velkošais transportlīdzeklis',
            icon = 'truck-pickup',
            type = 'client',
            event = 'qb-tow:client:TowVehicle',
            shouldClose = true
        }
    },
    ["police"] = {
        {
            id = 'emergencybutton',
            title = 'Panikas poga',
            icon = 'bell',
            type = 'client',
            event = 'op-dispatch:server:notify:policistminusa',
            shouldClose = true
        }, {
            id = 'checkvehstatus',
            title = 'Pārbaudiet ķūnējuma statusu',
            icon = 'circle-info',
            type = 'client',
            event = 'qb-tunerchip:client:TuneStatus',
            shouldClose = true
        }, {
            id = 'resethouse',
            title = 'Atiestatiet mājas slēdzeni',
            icon = 'key',
            type = 'client',
            event = 'qb-houses:client:ResetHouse',
            shouldClose = true
        }, {
            id = 'takedriverlicense',
            title = 'Atņemt autovadītāja apliecību',
            icon = 'id-card',
            type = 'client',
            event = 'police:client:SeizeDriverLicense',
            shouldClose = true
        }, {
            id = 'policeinteraction',
            title = 'Policijas darbības',
            icon = 'list-check',
            items = {
                {
                    id = 'statuscheck',
                    title = 'Pārbaudiet veselības stāvokli',
                    icon = 'heart-pulse',
                    type = 'client',
                    event = 'hospital:client:CheckStatus',
                    shouldClose = true
                }, {
                    id = 'checkstatus',
                    title = 'Pārbaudiet stāvokli',
                    icon = 'question',
                    type = 'client',
                    event = 'police:client:CheckStatus',
                    shouldClose = true
                }, {
                    id = 'escort',
                    title = 'Eskorts',
                    icon = 'user-group',
                    type = 'client',
                    event = 'police:client:EscortPlayer',
                    shouldClose = true
                }, {
                    id = 'searchplayer',
                    title = 'Meklēt',
                    icon = 'magnifying-glass',
                    type = 'client',
                    event = 'police:client:SearchPlayer',
                    shouldClose = true
                }, {
                    id = 'jailplayer',
                    title = 'Cietums',
                    icon = 'user-lock',
                    type = 'client',
                    event = 'police:client:JailPlayer',
                    shouldClose = true
                }
            }
        }, {
            id = 'policeobjects',
            title = 'Objekti',
            icon = 'road',
            items = {
                {
                    id = 'spawnpion',
                    title = 'Konuss',
                    icon = 'triangle-exclamation',
                    type = 'client',
                    event = 'police:client:spawnPObj',
                    arg = 'cone',
                    shouldClose = false
                }, {
                    id = 'spawnhek',
                    title = 'Vārti',
                    icon = 'torii-gate',
                    type = 'client',
                    event = 'police:client:spawnPObj',
                    arg = 'barrier',
                    shouldClose = false
                }, {
                    id = 'spawnschotten',
                    title = 'Ātruma ierobežojuma zīme',
                    icon = 'sign-hanging',
                    type = 'client',
                    event = 'police:client:spawnPObj',
                    arg = 'roadsign',
                    shouldClose = false
                }, {
                    id = 'spawntent',
                    title = 'Telts',
                    icon = 'campground',
                    type = 'client',
                    event = 'police:client:spawnPObj',
                    arg = 'tent',
                    shouldClose = false
                }, {
                    id = 'spawnverlichting',
                    title = 'Apgaismojums',
                    icon = 'lightbulb',
                    type = 'client',
                    event = 'police:client:spawnPObj',
                    arg = 'light',
                    shouldClose = false
                }, {
                    id = 'spikestrip',
                    title = 'Spaiki',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'police:client:SpawnSpikeStrip',
                    shouldClose = false
                }, {
                    id = 'deleteobject',
                    title = 'Objekta noņemšana',
                    icon = 'trash',
                    type = 'client',
                    event = 'police:client:deleteObject',
                    shouldClose = false
                }
            }
        }
    },
}

Config.GangInteractions = {
    ["lostmc"] = {
        {
            id = 'handcuff',
            title = 'Roku dzelži',
            icon = 'handcuffs',
            type = 'client',
            event = 'police:client:CuffPlayerSoft',
            shouldClose = true
        },{
            id = 'playerinvehicle',
            title = 'Ievietot transportlīdzekli',
            icon = 'car-side',
            type = 'client',
            event = 'police:client:PutPlayerInVehicle',
            shouldClose = true
        }, {
            id = 'playeroutvehicle',
            title = 'Izņemt no transportlīdzekļa',
            icon = 'car-side',
            type = 'client',
            event = 'police:client:SetPlayerOutVehicle',
            shouldClose = true
        }, {
            id = 'stealplayer',
            title = 'Nozagt',
            icon = 'mask',
            type = 'client',
            event = 'police:client:SearchPlayer', -- If you want to use ox_inventory steal you need to register an event, put: exports.ox_inventory:openNearbyInventory() in the event. Then use the event you registered in this config.
            shouldClose = true
        }, {
            id = 'escort',
            title = 'Nolaupīt',
            icon = 'user-group',
            type = 'client',
            event = 'police:client:KidnapPlayer',
            shouldClose = true
        }, {
            id = 'escort2',
            title = 'Eskorts',
            icon = 'user-group',
            type = 'client',
            event = 'police:client:EscortPlayer',
            shouldClose = true
        }
    }
}

Config.TrunkClasses = {
    [0] = {allowed = true, x = 0.0, y = -1.5, z = 0.0}, -- Coupes
    [1] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Sedans
    [2] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- SUVs
    [3] = {allowed = true, x = 0.0, y = -1.5, z = 0.0}, -- Coupes
    [4] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Muscle
    [5] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Sports Classics
    [6] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Sports
    [7] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Super
    [8] = {allowed = false, x = 0.0, y = -1.0, z = 0.25}, -- Motorcycles
    [9] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Off-road
    [10] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Industrial
    [11] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Utility
    [12] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Vans
    [13] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Cycles
    [14] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Boats
    [15] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Helicopters
    [16] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Planes
    [17] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Service
    [18] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Emergency
    [19] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Military
    [20] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Commercial
    [21] = {allowed = true, x = 0.0, y = -1.0, z = 0.25} -- Trains
}

Config.Commands = {
    ["top"] = {
        Func = function() ToggleClothing({"Top"}) end,
        Sprite = "top",
        Desc = "Novilkt/uzvilkt kreklu",
        Button = 1,
        Name = "Torso"
    },
    ["gloves"] = {
        Func = function() ToggleClothing({"Gloves"}) end,
        Sprite = "gloves",
        Desc = "Novilkt/uzvilkt cimdus",
        Button = 2,
        Name = "Gloves"
    },
    ["visor"] = {
        Func = function() ToggleProps({"Visor"}) end,
        Sprite = "visor",
        Desc = "Pārslēgt cepures variācija",
        Button = 3,
        Name = "Visor"
    },
    ["bag"] = {
        Func = function() ToggleClothing({"Bag"}) end,
        Sprite = "bag",
        Desc = "Atver vai aizver somu",
        Button = 8,
        Name = "Bag"
    },
    ["shoes"] = {
        Func = function() ToggleClothing({"Shoes"}) end,
        Sprite = "shoes",
        Desc = "Novilkt/uzvilkt kurpes",
        Button = 5,
        Name = "Shoes"
    },
    ["vest"] = {
        Func = function() ToggleClothing({"Vest"}) end,
        Sprite = "vest",
        Desc = "Novilkt/uzvilkt vesti",
        Button = 14,
        Name = "Vest"
    },
    ["hair"] = {
        Func = function() ToggleClothing({"Hair"}) end,
        Sprite = "hair",
        Desc = "Ielieciet matus uz augšu/uz leju/bulciņā/zirgastē.",
        Button = 7,
        Name = "Hair"
    },
    ["hat"] = {
        Func = function() ToggleProps({"Hat"}) end,
        Sprite = "hat",
        Desc = "Novilkt/uzvilkt cepuri",
        Button = 4,
        Name = "Hat"
    },
    ["glasses"] = {
        Func = function() ToggleProps({"Glasses"}) end,
        Sprite = "glasses",
        Desc = "Novilkt/uzvilkt brilles",
        Button = 9,
        Name = "Glasses"
    },
    ["ear"] = {
        Func = function() ToggleProps({"Ear"}) end,
        Sprite = "ear",
        Desc = "Novilkt/uzvilkt aksesuārus",
        Button = 10,
        Name = "Ear"
    },
    ["neck"] = {
        Func = function() ToggleClothing({"Neck"}) end,
        Sprite = "neck",
        Desc = "Novilkt/uzvilkt kakla piederumu off/on",
        Button = 11,
        Name = "Neck"
    },
    ["watch"] = {
        Func = function() ToggleProps({"Watch"}) end,
        Sprite = "watch",
        Desc = "Novilkt/uzvilkt pulksteni",
        Button = 12,
        Name = "Watch",
        Rotation = 5.0
    },
    ["bracelet"] = {
        Func = function() ToggleProps({"Bracelet"}) end,
        Sprite = "bracelet",
        Desc = "Novilkt/uzvilkt rokassprādzi",
        Button = 13,
        Name = "Bracelet"
    },
    ["mask"] = {
        Func = function() ToggleClothing({"Mask"}) end,
        Sprite = "mask",
        Desc = "Novilkt/uzvilkt masku",
        Button = 6,
        Name = "Mask"
    }
}

local bags = {[40] = true, [41] = true, [44] = true, [45] = true}

Config.ExtraCommands = {
    ["pants"] = {
        Func = function() ToggleClothing({"Pants", true}) end,
        Sprite = "pants",
        Desc = "Novilkt/uzvilkt bikses",
        Name = "Pants",
        OffsetX = -0.04,
        OffsetY = 0.0
    },
    ["shirt"] = {
        Func = function() ToggleClothing({"Shirt", true}) end,
        Sprite = "shirt",
        Desc = "Novilkt/uzvilkt kreklu",
        Name = "shirt",
        OffsetX = 0.04,
        OffsetY = 0.0
    },
    ["reset"] = {
        Func = function()
            if not ResetClothing(true) then
                Notify('Nothing To Reset', 'error')
            end
        end,
        Sprite = "reset",
        Desc = "Atgrieziet visu atpakaļ normālā stāvoklī",
        Name = "reset",
        OffsetX = 0.12,
        OffsetY = 0.2,
        Rotate = true
    },
    ["bagoff"] = {
        Func = function() ToggleClothing({"Bagoff", true}) end,
        Sprite = "bagoff",
        SpriteFunc = function()
            local Bag = GetPedDrawableVariation(cache.ped, 5)
            local BagOff = LastEquipped["Bagoff"]
            if LastEquipped["Bagoff"] then
                if bags[BagOff.Drawable] then
                    return "bagoff"
                else
                    return "paraoff"
                end
            end
            if Bag ~= 0 then
                if bags[Bag] then
                    return "bagoff"
                else
                    return "paraoff"
                end
            else
                return false
            end
        end,
        Desc = "Novilkt/uzvilkt somu",
        Name = "bagoff",
        OffsetX = -0.12,
        OffsetY = 0.2
    }
}


-- Client-side script to handle the button press
RegisterNetEvent('op-dispatch:server:notify:policistminusa')
AddEventHandler('op-dispatch:server:notify:policistminusa', function()
    -- Define what should happen when the event is triggered
    local job = "police" -- Specify the job or target
    local text = "Policists kritis/ievainots, nepieciešama palīdzība" -- Alert text
    local coords = GetEntityCoords(PlayerPedId()) -- Current player coordinates
    local id = GetPlayerServerId(PlayerId()) -- Player ID
    local title = "PANIKAS POGA" -- Alert title
    local panic = true -- Panic effect enabled

    -- Trigger server-side event to handle the alert
    TriggerServerEvent('Opto_dispatch:Server:SendAlert', job, title, text, coords, panic, id)
end)
