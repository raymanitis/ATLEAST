/*
    THANKS FOR PURCHASING OUR HEIST CONTRACTS SCRIPTS! <3
    
    You can find the detailed configuration for each heist in lunar_contracts/config/contracts
    Target, 3D prompts, notifications and progress bar can be configured in lunar_bridge/config
    Minigames can be configured in lunar_contracts/config/cl_edit.lua

    Need help with the script?
    Join our discord, claim the customer role and open a support ticket:
    https://discord.gg/AAuvQYgyqX
*/

---@class Contract
---@field settings ContractSettings

Config = {}
---@type table<string, Contract>
Config.contracts = {}

Config.tabletItem = 'contracts_tablet'
Config.itemCheck = true -- Perform an item check on the client side event

Config.generator = {
    -- The minutes between each generation
    minutesBetweenGeneration = 2,

    -- The maximum number of contracts before it stops generating
    max = 16,

    -- The maximum number of contracts at player can own
    playerLimit = 1
}

-- Player's start with this
Config.defaultProfile = {
    image = 'https://t4.ftcdn.net/jpg/02/15/84/43/360_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg',
    crypto = 100,
    xp = 750
}

-- The allowed extensions for profile pictures
Config.allowedImageExtensions = {
    '.jpg',
    '.jpeg',
    '.png',
    '.webp'
}

Config.adminGroups = {
    ['admin'] = true,
    ['god'] = true
}

Config.crypto = {
    -- The currency label
    label = 'GMonētas',

    -- This dictates how the reward is handed out
    -- owner = Only the owner receives the crypto reward
    -- members = All of the members receive the reward
    -- members_split = The reward is split between the members instead of the full amount
    ---@type 'owner' | 'members' | 'members_split'
    reward = 'members_split'
}

---@class ShopBuyItem
---@field name string
---@field description string
---@field price { money: integer, crypto: integer }
---@field stock integer
---@field chance integer?

---@class ShopSellItem
---@field name string
---@field price { money: integer?, crypto: integer? }

-- The ped where players can receive orders
Config.ped = {
    model = `u_m_m_edtoh`,
    -- The blip appears when marked inside the tablet
    blip = {
        name = locale('dealer'),
        sprite = 108,
        size = 0.75,
        color = 26
    },
    buyAccount = 'money', -- The money account used in the transaction
    ---@type ShopBuyItem[]
    buyItems = {
        { name = 'angle_grinder', description = locale('angle_grinder_description'), price = { money = 1000, crypto = 75 }, stock = 3 },
        { name = 'hack_usb', description = locale('hack_usb_description'), price = { money = 1250, crypto = 100 }, stock = 5 },
        { name = 'hack_card', description = locale('hack_card_description'), price = { money = 2000, crypto = 150 }, stock = 5 },
        { name = 'thermite', description = locale('thermite_description'), price = { money = 250, crypto = 20 }, stock = 5 },
        { name = 'large_drill', description = locale('large_drill_description'), price = { money = 5000, crypto = 200 }, stock = 3 },
        { name = 'weapon_digiscanner', description = locale('signal_booster_description'), price = { money = 2500, crypto = 125 }, stock = 3 },
        { name = 'weapon_pistol', description = locale('weapon_pistol_description'), price = { money = 12500, crypto = 500 }, stock = 2, chance = 25 },
        { name = 'weapon_combatpistol', description = locale('weapon_combatpistol_description'), price = { money = 17500, crypto = 750 }, stock = 2, chance = 25 },
    },
    sellAccount = 'money',
    ---@type ShopSellItem[]
    sellItems = {
        { name = 'gold_bar', price = { money = 7500, crypto = 5 } },
        { name = 'classified_docs', price = { money = 3500, crypto = 2 } },
        { name = 'rare_coins', price = { money = 5250, crypto = 5 } },
        { name = 'diamonds_box', price = { money = 19500, crypto = 10 } },
        { name = 'diamond_necklace', price = { money = 12500, crypto = 5 } },
        { name = 'diamond_ring', price = { money = 7500, crypto = 5 } },
        { name = 'luxurious_watch', price = { money = 11500, crypto = 5 } },
        { name = 'painting', price = { money = 20000, crypto = 5 } },
    },
    ---@type vector4[]
    locations = {
        vector4(696.1232, -960.1873, 24.0025, 93.2174)
    }
}

Config.leaderboard = {
    limit = 10 -- Only shows the top 10, avoid very big values as it can slow down your server
}

-- This specifies the number of cash/gold in trolley/pile
-- I don't recommend changing this
Config.lootingAnimations = {
    ['cash'] = {
        ['pile'] = { intro = 1500, interval = 800, count = 18 },
        ['trolley'] = { intro = 2100, interval = 1000, count = 45 }
    },
    ['gold'] = {
        ['pile'] = { intro = 1500, interval = 600, count = 20 },
        ['trolley'] = { intro = 2100, interval = 1000, count = 45 }
    }
}

-- Used for CCTV's in the heists
Config.cameraSettings = {
    rotateSpeed = 0.2,
    controls = {
        left = 34,
        right = 35,
        up = 32,
        down = 33
    }
}

---@class ContractSettings
---@field disabled boolean
---@field chance integer
---@field price integer? can be zero
---@field requiredExperience integer
---@field rewards { crypto: integer | { min: integer, max: integer }, experience: integer | { min: integer, max: integer } }?
---@field expiry integer how many minutes does it take for the contract to expire
---@field minMembers integer
---@field timeToStart integer how many minutes does the player have to start the contract after buying it
---@field minPolice integer the minumum number of police online to start the heist, the police job 

---@class GuardWeapon
---@field name string
---@field ammo { name: string, min: integer, max: integer }

---@class LootData
---@field rewards table<string, { item: string?, account: string?, count: { pile: integer, trolley: integer } }>
---@field goldChance integer
---@field locations { coords: vector4, type: 'trolley' | 'pile', alreadySpawned: string?, requires: string? }[]