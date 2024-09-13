Configuration = {

    framework = 'qbcore',  -- framework "esx" or "qbcore"

    trigger = 'qb-core', -- qb-core or es_extended

    Mysql = 'oxmysql',  -- oxmysql, mysql-async or ghmattisql

    UseKeys = true,
    UseFuel = true,
    UseDeleteVehicle = false,
    UseWorkUniforms = true,
    UseQuasarInventory = false,
    
    NPC = {
        {x = -555.169, y = -195.16, z = 38.22, h = 252.05, ped},
        -- {x = 1533.12, y = -2116.28, z = 76.8, h = 219.12, ped}
    },

    NPCmodel = "cs_barry",

    Payment_type = "cash", --bank or cash

    vehicleData = {
        [`rebel`] = {0, -2.0, -0.3},
        [`mule`] = {0, -2.0, 0},
        [`model3`] = {0, -2.0, 0},
    },

    Color_UI = "#FE7F2D",

}

Target = {
    UseTarget = false, 

    Coords = vector3(-542.96, -207.84, 37.64),

    TargetExport = 'ox_target',

    ["Home"] = {
        Text = 'Darba centrs', 
        Icon = 'fa fa-briefcase'        
    },

    ["Workclothes"] = {
        [1] = {
            Text = 'SĀKT STRĀDĀT', 
            Icon = 'fa fa-user-circle-o' 
        },
        [2] = {
            Text = 'BEIGT STRĀDĀT', 
            Icon = 'fa fa-sign-out' 
        }
    },

    ["Vehicle"] = {
        [1] = {
            Text = 'PAŅEMT TRANSPORTLĪDZEKLI', 
            Icon = 'fa fa-car' 
        },
        [2] = {
            Text = 'SAGLABĀT TRANSPORTLĪDZEKLI', 
            Icon = 'fa fa-car' 
        }
    },

    ["Tool"] = {
        [1] = {
            Text = 'PAŅEMT DARBARĪKU', 
            Icon = 'fa fa-wrench' 
        },
        [2] = {
            Text = 'SAGLABĀT DARBARĪKU', 
            Icon = 'fa fa-wrench' 
        }
    },

    ["Job"] = {
        Text = 'DARBS', 
        Icon = 'fa fa-hand-rock-o' 
    },

    ["Payout"] = {
        Text = 'SAŅEMT SAMAKSU', 
        Icon = 'fa fa-money' 
    }

}