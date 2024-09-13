return {
    UseTarget = true, -- if false, it will use https://github.com/darktrovx/interact script. see handleInteractions function in cl_open.
    EnableAiMedic = false,
    EnablePermaSystem = true,
    EnableLastStand = true, -- Setting this to false will skip to the dead phase where you cannot crawl.
    EnableBedCamera = true,
    ProgressCircle = true, -- if false, will use ox lib rectangle.
    EnableGlobalPlayerTarget = true, -- Global target eye player options for revive/heal/view injuries.
    DeathLogs = true,
    Debug = false,
    UseGarages = true,
    EnableCrawling = true, -- Enable players to crawl with W & S and mouse rotation during last stand phase.
    EnableMedicalBag = true,
    EnableElevators = true,
    RespawnIntoBed = true, -- if true, keep in mind that some MLO bed props may tweak out when setting into a bed if not within range of the MLO.
    DontBleedOnFallDamage = true, -- What GTA decides is fall damage can be really stupid and inconsistent.
    EnableEchoAudio = true, -- The echo audio that plays when in laststand/dead.
    BloodFx = { -- Enable/disable the different screen effects of bleeding.
        shake = true,
        flash = true,
        bloodsplats = true,
    },
    RequireItemToCallEMS = {
        enable = true, -- Set to true if you want them to have an item to be able to call for help.
        item = 'phone', -- item to check for.
    },
    RequireItemToCallAiMedic = {
        enable = true, -- Set to true if you want them to have an item to be able to call for help.
        item = 'phone', -- item to check for.
    },
    AmbulanceJobNames = {
        ambulance = true,
    },
    AllowedJobs = { -- Used for restricted elevator access.
        ambulance = true,
        police = true,
    },
    Knockout = {
        enable = true,
        RestoreHealth = true, -- Will slowly restore players health when knocked out.
        KnockoutTime = 20, -- 20 seconds
        Health = 125, -- Threshold for getting knocked out.
        Weapons = { `WEAPON_UNARMED`, `WEAPON_BAT`, },
    },
    CheckInjuriesCommand = 'checkinj', -- Command for a player to view their own injuries.
    AiMedicCommand = 'aihelp',
    ActionsKeybind = 'F6',
    Inventory = GetResourceState('ox_inventory') == 'started' and 'ox' or 'qb',
    InvResourceName = 'qb-inventory', -- This is only for handling variations like ps-inventory, lj-inventory.
    AntiSpamTimer = 5, -- 5 minutes between alerting EMS when dead.
    BleedoutTimer = 120, -- seconds
    RespawnTimer = 600, -- seconds
    BleedTick = 20, -- tick every 20 seconds
    InjuredWalkThreshold = 35, -- When bleeding reaches 35 or higher, force injured walk.
    RespawnKeyPress = 45, -- [R]
    AlertKeyPress = 38, -- [E]
    LastHealTimerCheck = 30000, -- (30000 = 30 seconds) IF a player is bleeding and hasn't used a heal item to reduced their bleeding within the specified time since their last heal, it will increase their bleed level.
    RandomBleedIncrease = {min = 1, max = 3},
    DropMedicalBagKey = 191, -- ENTER
    DamageBleedIncrease = {min = 3, max = 5},
    LeaveBedKey = 55, -- [SPACEBAR]
    BleedChance = 0.5, -- Max is 1.0. The higher the number, the more likely you are to bleed upon damage.
    HealPlayAnimProp = { -- If you don't want to use a prop for the heal other animation, you can just comment out the whole HealPlayAnimProp table.
        model = `prop_stat_pack_01`,
        pos = vec3(0, 0, 0),
        rot = vec3(0, 0, 0),
        bone = 60309,
    },
    HealPlayAnim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a' },
    downedAnimDict = 'random@dealgonewrong',
    downedAnim = 'idle_a',
    deadAnimDict = 'dead',
    deadAnim = 'dead_a',
    vehAnimDict = 'veh@low@front_ps@idle_duck',
    vehAnim = 'sit',
    inBedDict = 'mini@cpr@char_b@cpr_def',
    inBedAnim = 'cpr_pumpchest_idle',
    getOutDict = 'mini@cpr@char_b@cpr_str',
    getOutAnim = 'cpr_success',
    cprAnimDict = 'mini@cpr@char_a@cpr_str',
    cprAnim = 'cpr_pumpchest',
    RevivePlayerDuration = 5000,
    HealPlayerDuration = 5000,
    MedicHealOtherItem = 'bandage',
    MedicReviveOtherItem = 'firstaid',
    Morgue = {
        entrance = {target = vec3(241.35, -1378.83, 33.74), set = vec3(275.65, -1361.31, 24.54)},
        exit = {target = vec3(276.15, -1361.72, 24.54), set = vec3(240.92, -1379.32, 33.74)},
        tables = { vec4(291.46, -1346.01, 24.57, 155.31), vec4(296.56, -1349.74, 24.57, 142.8), vec4(294.59, -1353.03, 24.59, 68.99), }
    },
    CrutchForceWalk = {
        enable = true,
        blockWeapons = true,
    },
    AiReviveTime = 10000,
}