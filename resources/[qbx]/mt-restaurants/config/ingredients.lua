Config = Config or {}

-- For more info check: https://mt-scripts-documentations.gitbook.io/mt-script-documentation/

Config.ingredients = { -- All items, you can create different categories of items to use on different restaurants
    globalIngredients = { -- List of the items, to create custom buffs just add them to the customBuffs field and change the function on its use on the functions.lua following the same format (more info at docs website)
        { needCut = true, neededItems = { onion = 1 }, item = 'cutted_onion', count = 5, type = { 'food', 'drink' }, calories = 100, customBuffs = { stress = 10, armour = 10, alcohol = 50 } },
        { needCut = true, neededItems = { carrot = 1 }, item = 'cutted_carrot', count = 5, type = { 'food', 'drink' }, calories = 100, customBuffs = {} },
        { needCut = true, neededItems = { lettuce = 1 }, item = 'cutted_lettuce', count = 5, type = { 'food', 'drink' }, calories = 100, customBuffs = {} },
        { needCut = true, neededItems = { cucumber = 1 }, item = 'cutted_cucumber', count = 5, type = { 'food', 'drink' }, calories = 100, customBuffs = {} },
        { needCut = true, neededItems = { potato = 1 }, item = 'cutted_potato', count = 5, type = { 'food', 'drink' }, calories = 100, customBuffs = {} },
        { needCut = true, neededItems = { tomato = 1 }, item = 'cutted_tomato', count = 5, type = { 'food', 'drink' }, calories = 100, customBuffs = {} },
        { needCut = true, neededItems = { wheat = 1 }, item = 'cutted_wheat', count = 5, type = { 'food', 'drink' }, calories = 100, customBuffs = {} },
        { needCut = true, neededItems = { strawberry = 1 }, item = 'cutted_strawberry', count = 5, type = { 'food', 'drink' }, calories = 100, customBuffs = {} },
        { needCut = true, neededItems = { watermelon = 1 }, item = 'cutted_watermelon', count = 5, type = { 'food', 'drink' }, calories = 100, customBuffs = {} },
        { needCut = true, neededItems = { soya = 1 }, item = 'cutted_soya', count = 5, type = { 'food', 'drink' }, calories = 100, customBuffs = {} },
        { needCut = true, neededItems = { pineapple = 1 }, item = 'cutted_pineapple', count = 5, type = { 'food', 'drink' }, calories = 100, customBuffs = {} },
        { needCut = true, neededItems = { apple = 1 }, item = 'cutted_apple', count = 5, type = { 'food', 'drink' }, calories = 100, customBuffs = {} },
        { needCut = true, neededItems = { pear = 1 }, item = 'cutted_pear', count = 5, type = { 'food', 'drink' }, calories = 100, customBuffs = {} },
        { needCut = true, neededItems = { lemon = 1 }, item = 'cutted_lemon', count = 5, type = { 'food', 'drink' }, calories = 100, customBuffs = { stress = 10, armour = 10, alcohol = 50 } },
        { needCut = true, neededItems = { banana = 1 }, item = 'cutted_banana', count = 5, type = { 'food', 'drink' }, calories = 100, customBuffs = {} },
        { needCut = true, neededItems = { orange = 1 }, item = 'cutted_orange', count = 5, type = { 'food', 'drink' }, calories = 100, customBuffs = {} },
        { needCut = true, neededItems = { peach = 1 }, item = 'cutted_peach', count = 5, type = { 'food', 'drink' }, calories = 100, customBuffs = {} },
        { needCut = true, neededItems = { mango = 1 }, item = 'cutted_mango', count = 5, type = { 'food', 'drink' }, calories = 100, customBuffs = {} },
        { needCut = true, neededItems = { meat = 1 }, item = 'cutted_meat', count = 5, type = { 'food' }, calories = 500, customBuffs = {} },
        { needCut = true, neededItems = { fish = 1 }, item = 'cutted_fish', count = 5, type = { 'food' }, calories = 500 },
        { needCut = false, item = 'corn', type = { 'food', 'drink' }, calories = 100, customBuffs = {} },
        { needCut = false, item = 'coffee_beans', type = { 'food', 'drink' }, calories = 100, customBuffs = {} },
    },
}