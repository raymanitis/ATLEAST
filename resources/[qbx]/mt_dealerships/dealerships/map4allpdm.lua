Config.dealerships = Config.dealerships or {}

Config.dealerships.cardealer = { -- Dealership ID, NEEDS TO BE THE SAME AS THE JOB!!!
    enabled = true, -- true or false to enable or disable the dealership
    label = 'Premium Deluxe Motorsports', -- Dealership label
    logo = 'https://i.ibb.co/nkBN3bs/logo.png', -- Dealership logo that'll show on UI
    job = 'cardealer', -- Dealership job or false to not player owned dealerships, NEEDS TO BE THE SAME AS THE ID!!!
    currency = 'cash', -- bank, cash or money to ESX (Also to QBCore you can choose other currency like crypto and etc)
    useStock = true, -- When using job = false this will be ignored
    allowBuyCatalogue = true, -- If true players will be able to buy the vehicles on the catalogue
    allowChangeVehicle = true, -- If true players will be able to change the vehicles on the catalogue witout job
    needsMission = true, -- Set to false or true to disable/disable the needing of going pick up the car
    testDriveRoutingBucket = true, -- Set this to false if you don't want the test drive to be inside of a Routing Bucket
    testDriveTime = 50, -- Test drive time in seconds
    testDriveSpawn = vec4(-69.48, -1105.88, 26.07, 73.5), -- Test drive spawn coords
    truck = 'packer', -- The truck used on importation
    trailer = 'tr4', -- The trailer used on importation
    truckSpawn = vec4(-58.46, -1072.99, 27.23, 70.0), -- Importation truck spawn coords
    buySpawn = vec4(-17.59, -1107.66, 26.65, 161.25), -- Vehicle buy spawn coords
    comissions = { buyPercentage = 50, sellComission = 10 }, -- The dealership commisions (buyPercentage is the percentage of vehicle price that the dealership will buy it and the sellComission is the comission that the employee will earn on selling vehicles to players)
    blip = { enabled = true, coords = vec3(-58.01, -1097.08, 26.44), sprite = 523, color = 3, scale = 0.6, display = 4 }, -- Dealership map blip
    dashboards = { -- Dealership dashboards to import vehicles and see transations and etc
        { coords = vec3(-33.2509, -1114.9865, 26.2791), radius = 0.5, includeBossMenu = true },
    },
    catalogues = { -- The catalogues to the players see the vehicle and emplooyes change the vehicle on showrrom
        { coords = vec3(-55.3109, -1097.0756, 26.4863), radius = 0.3, vehicleCoords = vec4(-50.1102, -1094.8655, 25.4224, 132.9709), vehicle = 'sultan', vehicleColor = 54 },
        { coords = vec3(-42.1, -1096.2, 99926.6), radius = 0.3, vehicleCoords = vec4(-45.4329, -1096.8319, 25.4223, 133.1784), vehicle = 'elegy', vehicleColor = 0 },
        { coords = vec3(-37.2, -1098.0, 9926.6), radius = 0.3, vehicleCoords = vec4(-40.8427, -1098.6511, 25.4224, 133.3088), vehicle = 'stratum', vehicleColor = 73 },

    },
    categories = { -- The categories that will show on the catalogue and dashboard (need to add the shop with the job name to the vehicles.lua too on the shops field otherwise it'll not show the vehicles!!)
        { label = 'Compacts', id = 'compacts' },
        { label = 'Sedans', id = 'sedans' },
        { label = 'SUVs', id = 'suvs' },
        { label = 'Coupes', id = 'coupes' },
        { label = 'Muscle', id = 'muscle' },
        { label = 'Sports Classics', id = 'sportsclassics' },
        { label = 'Sports', id = 'sports' },
        { label = 'Super', id = 'super' },
        { label = 'Motorcycles', id = 'motorcycles' },
        { label = 'OffRoad', id = 'offroad' },
        { label = 'Industrial', id = 'industrial' },
        { label = 'Utility', id = 'utility' },
        { label = 'Vans', id = 'vans' },
        { label = 'Cycles', id = 'cycles' },
        { label = 'Service', id = 'service' },
        { label = 'Commercial', id = 'commercial' },
        { label = 'Open Wheel', id = 'openwheel' },
    },
    pickups = {
        vec4(1201.35, -3187.03, 5.98, 175.35)
    }
}