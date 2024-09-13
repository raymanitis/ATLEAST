return {
    EnablePermaSystem = true,
    EnableCommandForceWalk = true,
    WipeInventory = false, -- Wipes inventory when respawning.
    ResetHungerAndThirst = true, -- Reset players hunger and thirst to full when revived.
    ResetStress = true, -- Reset stress fully when revived.
    PermaWhitelistCids = { -- Whitelisted citizenids that are able to perform /perma id.
        ['RANDOLIO'] = true -- QBCore citizenids are like 'BHU87653' | ESX is like char1:efefvde778hfdsd
    },
    PayPerRevive = { -- Pay EMS for reviving DEAD players. (Will not pay them if the target player is EMS also)
        enable = true,
        amount = 500,
    },
    PayPerHeal = { -- Pay EMS for healing players. (Will not pay them if the target player is EMS also)
        enable = true,
        amount = 500,
    },
    RespawnCharge = {
        enable = true,
        amount = 1000,
    },
    AiMedicChargePlayer = {
        enable = true,
        amount = 1000,
    },
    AiMedicPedModel = `s_m_m_doctor_01`,
    PermaCommand = 'perma',
    PermaWaitDuration = 10000, -- 10 seconds and then the player will be deleted and bodybag gets deleted.
    MaxForceWalkTime = 5, -- minutes.
    ForceWalkTargetDistance = 30.0, -- Can only force walk people within 30 game units of you.
    ItemsToKeep = { -- array of items that are kept when wiping inventory. [examples below]
        'radio',
        'sandwich',
    },
    RespawnLocations = { -- If you're not respawning in beds, it will find the closest hospital and place you at those coords.
        vec3(299.63, -579.15, 43.26), -- Pillbox
        vec3(337.39, -1393.26, 32.51), -- Central Medical
        vec3(-245.25, 6328.88, 32.43), -- Paleto Medical
    },
    PrisonRespawn = vec3(1770.11, 2550.65, 45.56),
    LoggingType = 'discord', -- 'discord' or 'lib' (ox lib.logger)
    DiscordWebhook = '', -- webhook link for logging deaths.
    ArmoryItems = {
        medicalbag = {price = 0},
        bandage = {price = 0},
        firstaid = {price = 0},
    },
    HealItems = {
        {
            item = 'bandage', bleed = {min = 3, max = 5}, heal = {min = 10, max = 15}, stress = {min = 1, max = 2},
            duration = 3000, dict = 'anim@amb@business@weed@weed_inspecting_high_dry@', clip = 'weed_inspecting_high_base_inspector', flag = 49,
            model = `prop_rolled_sock_02`, pos = vec3(0.1, 0, 0.05), rot = vec3(0, 0, 0), bone = 26610,
            disableActions = { move = false, car = false, mouse = false, combat = true, }, -- Disable actions during progress bar.
        },
        {
            item = 'firstaid', bleed = {min = 30, max = 50}, heal = {min = 40, max = 70},
            duration = 8000, dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a',
            model = `prop_stat_pack_01`, pos = vec3(0, 0, 0), rot = vec3(0, 0, 0), bone = 60309,
            disableActions = { move = false, car = false, mouse = false, combat = true, }, -- Disable actions during progress bar.
        },
    },
    MedBagItem = 'medicalbag',
    MedBagItemDefaults = { -- Stock based system during server up time. Players will need to restock at restock location at specific hospitals.
        bandage = {amount = 50},
        firstaid = {amount = 10},
        weapon_flashlight = {amount = 1},
        radio = {amount = 1},
    },
}