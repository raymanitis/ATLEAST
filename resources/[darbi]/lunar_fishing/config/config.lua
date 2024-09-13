Config = {}

Config.progressPerCatch = 0.02 -- The progress per one fish caught

---@class Fish
---@field price integer | { min: integer, max: integer }
---@field chance integer Percentage chance
---@field skillcheck SkillCheckDifficulity }

---@type table<string, Fish>
Config.fish = {
    ['anchovy'] = { price = { min = 5, max = 7 }, chance = 35, skillcheck = { 'easy', 'medium' } },
    ['trout'] = { price = { min = 5, max = 10 }, chance = 35, skillcheck = { 'easy', 'medium' } },
    ['haddock'] = { price = { min = 10, max = 20 }, chance = 20, skillcheck = { 'easy', 'medium' } },
    ['salmon'] = { price = { min = 15, max = 20 }, chance = 10, skillcheck = { 'easy', 'medium', 'medium' } },
    ['grouper'] = { price = { min = 20, max = 35 }, chance = 25, skillcheck = { 'easy', 'medium', 'medium', 'medium' } },
    ['piranha'] = { price = { min = 20, max = 35 }, chance = 25, skillcheck = { 'easy', 'medium', 'medium' } },
    ['red_snapper'] = { price = { min = 40, max = 50 }, chance = 20, skillcheck = { 'easy', 'medium', 'medium', 'medium' } },
    ['mahi_mahi'] = { price = { min = 40, max = 50 }, chance = 20, skillcheck = { 'easy', 'medium', 'medium', 'medium' } },
    ['tuna'] = { price = { min = 50, max = 70 }, chance = 5, skillcheck = { 'easy', 'medium', 'medium' } },
    ['shark'] = { price = { min = 90, max = 115 }, chance = 3, skillcheck = { 'easy', 'medium', 'medium' } },
}

---@class FishingRod
---@field name string
---@field price integer
---@field minLevel integer The minimal level
---@field breakChance integer Percentage chance

---@type FishingRod[]
Config.fishingRods = {
    { name = 'basic_rod', price = 500, minLevel = 1, breakChance = 20 },
    { name = 'graphite_rod', price = 1500, minLevel = 2, breakChance = 10 },
    { name = 'titanium_rod', price = 3000, minLevel = 3, breakChance = 1 },
}

---@class FishingBait
---@field name string
---@field price integer
---@field minLevel integer The minimal level
---@field waitDivisor number The total wait time gets divided by this value

---@type FishingBait[]
Config.baits = {
    { name = 'worms', price = 5, minLevel = 1, waitDivisor = 1.0 },
    { name = 'artificial_bait', price = 15, minLevel = 2, waitDivisor = 3.0 },
}

---@class FishingZone
---@field locations vector3[] One of these gets picked at random
---@field radius number
---@field minLevel integer
---@field waitTime { min: integer, max: integer }
---@field includeOutside boolean Whether you can also catch fish from Config.outside
---@field blip BlipData?
---@field message { enter: string, exit: string }?
---@field fishList string[]

---@type FishingZone[]
Config.fishingZones = {
    {
        blip = {
            name = 'Korallu rifs',
            sprite = 317,
            color = 24,
            scale = 0.6
        },
        locations = {
            vector3(-1774.0654, -1796.2740, 0.0),
            vector3(2482.8589, -2575.6780, 0.0)
        },
        radius = 250.0,
        minLevel = 1,
        waitTime = { min = 5, max = 10 },
        includeOutside = true,
        message = { enter = 'Jūs esat iekļuvis koraļļu rifā.', exit = 'Jūs esat atstājis koraļļu rifu.' },
        fishList = { 'mahi_mahi', 'red_snapper' }
    },
    {
        blip = {
            name = 'Dzilie udeni',
            sprite = 317,
            color = 29,
            scale = 0.6
        },
        locations = {
            vector3(-4941.7964, -2411.9146, 0.0),
        },
        radius = 1000.0,
        minLevel = 3,
        waitTime = { min = 50, max = 80 },
        includeOutside = false,
        message = { enter = 'Jūs esat iegājis dziļos ūdeņos.', exit = 'Jūs esat atstājis dziļos ūdeņus.' },
        fishList = { 'grouper', 'tuna', 'shark' }
    },
    {
        blip = {
            name = 'Purvs',
            sprite = 317,
            color = 56,
            scale = 0.6
        },
        locations = {
            vector3(-2188.1182, 2596.9348, 0.0),
        },
        radius = 200.0,
        minLevel = 2,
        waitTime = { min = 40, max = 60 },
        includeOutside = true,
        message = { enter = 'Jūs esat iekļuvis purvā.', exit = 'Jūs esat atstājis purvu.' },
        fishList = { 'piranha' }
    },
}

-- Outside of all zones
Config.outside = {
    waitTime = { min = 25, max = 35 },

    ---@type string[]
    fishList = {
        'trout', 'anchovy', 'haddock', 'salmon'
    }
}

Config.ped = {
    model = `s_m_m_cntrybar_01`,
    buyAccount = 'money',
    sellAccount = 'money',
    blip = {
        name = 'SeaTrade Korpuracija',
        sprite = 356,
        color = 74,
        scale = 0.75
    },

    ---@type vector4[]
    locations = {
        vector4(-2081.3831, 2614.3223, 3.0840, 112.7910),
        vector4(-1492.3639, -939.2579, 10.2140, 144.0305)
    }
}

Config.renting = {
    model = `s_m_m_dockwork_01`, -- The ped model
    account = 'money',
    boats = {
        { model = `speeder`, price = 400, image = 'https://i.postimg.cc/mDSqWj4P/164px-Speeder.webp' },
        { model = `dinghy`, price = 600, image = 'https://i.postimg.cc/ZKzjZgj0/164px-Dinghy2.webp'  },
        { model = `tug`, price = 1000, image = 'https://i.postimg.cc/jq7vpKHG/164px-Tug.webp' }
    },
    blip = {
        name = 'Laivu ire',
        sprite = 410,
        color = 74,
        scale = 0.75
    },
    returnDivider = 5, -- Players can return it and get some cash back
    returnRadius = 30.0, -- The save radius

    ---@type { coords: vector4, spawn: vector4 }[]
    locations = {
        { coords = vector4(-1434.4818, -1512.2745, 2.1486, 25.8666), spawn = vector4(-1494.4496, -1537.6943, 2.3942, 115.6015) }
    }
}