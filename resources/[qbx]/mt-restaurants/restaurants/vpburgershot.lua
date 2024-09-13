Config.restaurants = Config.restaurants or {}

-- This config is made to G&N's Studios Vespucci Burgershot MLO - https://fivem.gnstud.io/package/4841796

-- For more info check: https://mt-scripts-documentations.gitbook.io/mt-script-documentation/

Config.restaurants.vpburgershot = {
    enabled = true,
    label = 'Burgershot',
    job = 'vpburgershot',
    ingredients = Config.ingredients.globalIngredients,
    maxIngredients = 6,
    maxRecipes = 10,
    maxRecipePrice = 1000,
    blip = { enabled = true, coords = vec3(-1178.48, -883.46, 13.88), sprite = 106, color = 1, scale = 0.6, display = 4 },
    zone = {
        points = {
            vec3(-1171.54, -865.83, 14.0),
            vec3(-1214.84, -893.46, 14.0),
            vec3(-1196.19, -917.43, 14.0),
            vec3(-1154.33, -891.12, 14.0)
        },
        thickness = 15,
    },
    management = {
        { coords = vec3(-1178.5, -896.9, 13.9), radius = 0.5 },
    },
    stashes = {
        { coords = vec3(-1201.2, -901.7, 14.3), radius = 0.55, label = 'Fridge', slots = 50, weight = 100 },
        { coords = vec3(-1195.1, -897.4, 14.3), radius = 0.55, label = 'Pass', slots = 50, weight = 100 },
    },
    trays = {
        { coords = vec3(-1194.4, -894.0, 14.1), radius = 0.35, label = 'Tray', slots = 10, weight = 10 },
        { coords = vec3(-1193.3, -895.5, 14.1), radius = 0.35, label = 'Tray', slots = 10, weight = 10 },
        { coords = vec3(-1192.4, -896.9, 14.1), radius = 0.35, label = 'Tray', slots = 10, weight = 10 },
    },
    prepare = {
        { coords = vec3(-1197.4, -898.4, 14.0), radius = 0.4, label = 'Prepare', ingredients = Config.ingredients.globalIngredients, anim = { dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', clip = 'machinic_loop_mechandplayer' } },
    },
    stations = {
        { coords = vec3(-1196.9, -895.0, 14.5), radius = 0.4, label = 'Drinks Machine', type = 'drink', anim = { dict = 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal', clip = 'pour_one' } },
        { coords = vec3(-1198.2, -895.1, 14.0), radius = 0.7, label = 'Grill', type = 'food', anim = { dict = 'amb@prop_human_bbq@male@idle_a', clip = 'idle_b' }, prop = { bone = 28422, model = 'prop_fish_slice_01', pos = vec3(0.0, 0.0, 0.0), rot = vec3(0.0, 0.0, 0.0) }  },
        { coords = vec3(-1200.8, -896.8, 14.0), radius = 0.7, label = 'Frier', type = 'food', anim = { dict = 'amb@prop_human_bbq@male@idle_a', clip = 'idle_b' }, prop = { bone = 28422, model = 'prop_cs_fork', pos = vec3(0.0, 0.0, 0.0), rot = vec3(0.0, 0.0, 0.0) }  },
    },
    registers = {
        { coords = vec3(-1194.95, -893.2, 14.25), radius = 0.4, label = 'Register', playersRadius = 5.0, comission = 10 },
        { coords = vec3(-1193.95, -894.7, 14.25), radius = 0.4, label = 'Register', playersRadius = 5.0, comission = 10 },
        { coords = vec3(-1192.95, -896.25, 14.3), radius = 0.4, label = 'Register', playersRadius = 5.0, comission = 10 },
    },
    offlineShop = {
        { coords = vec4(-1193.88, -895.88, 12.97, 309.54), label = 'Shop', model = 's_f_y_sweatshop_01', scenario = 'WORLD_HUMAN_AA_COFFEE' },
    },
    music = {
        { coords = vec3(-1196.6, -902.2, 13.9), radius = 0.25, maxMusicRadius = 50.0, maxMusicVolume = 50, prop = 'sf_prop_sf_laptop_01a', propHeading = 32.51+180 },
    },
    boxes = {
        { coords = vec3(-1192.0, -897.7, 14.4), radius = 0.35 },
    },
}