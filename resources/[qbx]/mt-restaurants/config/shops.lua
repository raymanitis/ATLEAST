Config = Config or {}

-- For more info check: https://mt-scripts-documentations.gitbook.io/mt-script-documentation/

Config.shops = {
    {
        label = 'Produktu veikals', -- The name that will be displayed on the shop
        enabled = true, -- If false it'll disable the shop
        blip = { enabled = true, sprite = 267, color = 73, scale = 0.6, display = 4 }, -- Shop blip map
        ped = { coords = vec4(462.110107, -693.728210, 26.447880, 80.796547), model = 'mp_m_shopkeep_01', scenario = 'WORLD_HUMAN_CLIPBOARD' }, -- Shop ped options
        items = { -- Shop items
            { name = 'meat', price = 50, count = 100 },
            { name = 'fish', price = 50, count = 100 },
            { name = 'onion', price = 10, count = 100 },
            { name = 'carrot', price = 10, count = 100 },
            { name = 'lettuce', price = 10, count = 100 },
            { name = 'cucumber', price = 10, count = 100 },
            { name = 'potato', price = 10, count = 100 },
            { name = 'tomato', price = 10, count = 100 },
            { name = 'wheat', price = 10, count = 100 },
            { name = 'strawberry', price = 10, count = 100 },
            { name = 'watermelon', price = 10, count = 100 },
            { name = 'soya', price = 10, count = 100 },
            { name = 'pineapple', price = 10, count = 100 },
            { name = 'apple', price = 10, count = 100 },
            { name = 'pear', price = 10, count = 100 },
            { name = 'lemon', price = 10, count = 100 },
            { name = 'banana', price = 10, count = 100 },
            { name = 'orange', price = 10, count = 100 },
            { name = 'peach', price = 10, count = 100 },
            { name = 'mango', price = 10, count = 100 },
            { name = 'corn', price = 10, count = 100 },
            { name = 'coffee_beans', price = 10, count = 100 },
        }
    },
}