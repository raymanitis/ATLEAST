Config = {} -- Do not alter

-- 🔎 Looking for more high quality scripts?
-- 🛒 Shop Now: https://lationscripts.com/github
-- 💬 Join Discord: https://discord.gg/9EbY4nM5uu
-- 😢 How dare you leave this option false?!
Config.YouFoundTheBestScripts = true

-- Use only if needed, directed by support or know what you're doing
-- Notice: enabling debug features will significantly increase resmon
-- And should always be disabled in production
Config.Debug = false

-- Do you want to be notified via server console if an update is available?
-- True if yes, false if no
Config.VersionCheck = false

-- Target system, available options are: 'ox_target', 'qb-target', 'qtarget', 'custom' & 'none'
-- 'custom' needs to be added to client/functions.lua
-- If 'none' then TextUI is used instead of targeting
Config.Target = 'ox_target'

-- Notification system, available options are: 'ox_lib', 'esx', 'qb', 'okok' & 'custom'
-- 'custom' needs to be added to client/functions.lua
Config.Notify = 'ox_lib'

-- If using TextUI (Config.Target = 'none') then what key do you want to open the shop?
-- Default is 38 (E), find more control ID's here: https://docs.fivem.net/docs/game-references/controls/
Config.Interact = 38

-- Manage & create your pawn shops here
Config.Shops = {
    ['main'] = { -- Unique identifier for this shop
        name = 'Lombards', -- Shop name
        slots = 25, -- How many slots are available
        weight = 100000, -- How much weight is available
        coords = vec4(173.4025, -1316.5673, 29.3472, 251.5453), -- Where this shop exists
        radius = 1.0, -- How large of a circle zone radius (for targeting only)
        spawnPed = true, -- Spawn a ped to interact with here?
        pedModel = 'a_m_y_beach_02', -- If spawnPed = true, what ped model?
        -- You can limit the hours at which the shop is available here
        -- Min is the earliest the shop is available (default 06:00AM)
        -- Max is the latest the shop is available (default 21:00 aka 9PM)
        -- If you want it available 24/7, set min to 1 and max to 24
        hour = { min = 1, max = 24 },
        account = 'cash', -- Give 'cash', 'bank' or 'dirty' money when selling here?
        allowlist = {
            -- Balanced item prices based on server's economy
        
            -- Luxury and Valuable Items
            ['diamond_ring'] = { label = 'Diamond Ring', price = 800 },  -- Expensive luxury item
            ['rolex'] = { label = 'Rolex', price = 1000 },  -- High-value luxury watch
        
            -- Electronics and Gadgets
            ['tablet'] = { label = 'Tablet', price = 500 },  -- Moderately expensive electronic
            ['laptop'] = { label = 'Laptop', price = 700 },  -- Standard laptop
            ['mansionlaptop'] = { label = 'Mansion Laptop', price = 1000 },  -- High-end laptop
            ['houselaptop'] = { label = 'House Laptop', price = 600 },  -- Affordable laptop
            ['mdtablet'] = { label = 'Planšetdators', price = 550 },  -- Special use electronic
            ['mddesktop'] = { label = 'Dators', price = 800 },  -- High-end desktop
            ['mdmonitor'] = { label = 'Monitors', price = 400 },  -- Specialized monitor
            ['mdspeakers'] = { label = 'Tumbiņas', price = 300 },  -- Specialized speakers
        
            -- Art and Collectibles
            ['art1'] = { label = 'Art Piece 1', price = 450 },  -- Valued art piece
            ['art2'] = { label = 'Art Piece 2', price = 500 },  -- Valued art piece
            ['art3'] = { label = 'Art Piece 3', price = 550 },  -- Valued art piece
            ['art4'] = { label = 'Art Piece 4', price = 600 },  -- Valued art piece
            ['art5'] = { label = 'Art Piece 5', price = 650 },  -- Valued art piece
            ['art7'] = { label = 'Art Piece 7', price = 700 },  -- Premium art piece
        
            -- Everyday Items
            ['boombox'] = { label = 'Boombox', price = 250 },  -- Entertainment
        
        },
        -- If placeholders = true then the "slots" amount above will be overridden
        -- This option will fill the shop with "display" items, and only
        -- Display items that are possible to sell here. If false, it will be
        -- An empty inventory, and the "slots" amount above will not be overridden
        placeholders = true,
        blip = {
            enabled = true, -- Enable or disable the blip for this shop
            sprite = 59, -- Sprite ID (https://docs.fivem.net/docs/game-references/blips/)
            color = 0, -- Color (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
            scale = 0.8, -- Size/scale
            label = 'Lombards' -- Label
        }
    }
    -- Add more pawn shops here as desired
    -- Be sure to follow the same format as above
}
