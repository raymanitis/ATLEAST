config = {}

-- target resource (only one of these can be true)
-------------------------------------------------------
config.qbtarget = false
config.oxtarget = true
-------------------------------------------------------


config.pedmodel = 'a_m_m_prolhost_01' -- ped model hash

config.scenario = 'WORLD_HUMAN_CLIPBOARD' -- scenario for ped to play, false to disable

config.locations = {
    ['legion'] = {
        ped = true, -- if false uses boxzone (below)

        coords = vector4(170.6967, -730.0757, 33.1332, 73.4145),
        
        -------- boxzone (only used if ped is false) --------

        length = 1.0,  
        width = 1.0,   
        minZ = 30.81,  
        maxZ = 30.81,  
        debug = false, 

        -----------------------------------------------------
        vehicles = {
            ['asea']        = {     -- vehicle model name
                price = 200,        -- ['vehicle'] = price
                image = 'https://r2.fivemanage.com/43z7Bt109UNYve2xRiuvK/images/asea.png',      -- image for menu, false for no image
            },
            ['sentinel']    = {
                price = 400, 
                image = 'https://r2.fivemanage.com/43z7Bt109UNYve2xRiuvK/images/sentinel.png',
            },
            ['bison']       = {
                price = 500, 
                image = 'https://r2.fivemanage.com/43z7Bt109UNYve2xRiuvK/images/bison.png',
            },

        },

        vehiclespawncoords = vector4(165.5100, -733.8829, 33.1334, 69.0521), -- where vehicle spawns when rented

    },

    ['dome'] = {
        ped = true, -- if false uses boxzone (below)

        coords = vector4(-486.3782, -247.5130, 35.8427, 105.1828),
        
        -------- boxzone (only used if ped is false) --------

        length = 1.0,  
        width = 1.0,   
        minZ = 30.81,  
        maxZ = 30.81,  
        debug = false, 

        -----------------------------------------------------
        vehicles = {
            ['asea']        = {     -- vehicle model name
                price = 100,        -- ['vehicle'] = price
                image = 'https://r2.fivemanage.com/43z7Bt109UNYve2xRiuvK/images/asea.png',      -- image for menu, false for no image
            },
            ['sentinel']    = {
                price = 200, 
                image = 'https://r2.fivemanage.com/43z7Bt109UNYve2xRiuvK/images/sentinel.png',
            },
            ['bison']       = {
                price = 300, 
                image = 'https://r2.fivemanage.com/43z7Bt109UNYve2xRiuvK/images/bison.png',
            },

        },

        vehiclespawncoords = vector4(-487.8832, -252.5952, 35.6853, 110.6452), -- where vehicle spawns when rented

    },

    -- add as many locations as you'd like with any type of vehicle (air, water, land) follow same format as above
}

