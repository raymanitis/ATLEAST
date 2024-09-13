local framework = Framework:New(Config.Framework, Config.FrameworkResource, Config.NewFrameworkVersion)

if Config.Framework == 'qb-core' then
    QBCore = exports[Config.FrameworkResource]:GetCoreObject()
elseif Config.Framework == 'esx' then
    if Config.NewFrameworkVersion then
        ESX = exports[Config.FrameworkResource]:getSharedObject()
    else
        while ESX == nil do
            TriggerEvent(Config.SharedObject, function(obj)
                ESX = obj
            end)
            Citizen.Wait(50)
        end
    end
end

local UserConfig = nil

local NPCDefaultGroupNameIfNotOwned = 'C8RE_NEUTRAL_ORG'

Zones = {}
Organizations = {}
Bounties = {}
Criminals = {}

SpawnedStuff = {}
WarBlips = {}
SpawnedNPCS = {}
ContinentalNPCS = {}
Borders = {}

local Loaded = false
local PropsAndTargetCreated = false
local MenuOpen = false
local ContinentalOpen = false
local ContinentalNPC = nil

-- CLIENT
local Currency = 0
local Organization = nil
local Identifier = nil
local CurrentWar = nil
local inWarZone = false
local CanSeeBorder = false

-- DETECT DEATH
local deathOverwrite = false
local ignoreNextDeath = false
local recentDeaths = {}
local damageIndex = {
    fatal = 6,
    weapon = 7
}

-- CAMERAS
local cam = nil
local cam2 = nil

----------------------
-- HELPER FUNCTIONS --
----------------------

-- Zone / index / coords helpers
local function getCoordsFromIndex(index)
    local northwest = {
        lat = 8396.62,
        lng = -4129.82
    }
    local southeast = {
        lat = -5105.48,
        lng = 4851.53
    }

    local offset = 115
    local numCols = math.ceil((southeast.lng - northwest.lng) / offset)

    local latIndex = math.floor((index - 1) / numCols) + 1
    local lngIndex = (index - 1) % numCols + 1

    local lat = northwest.lat - (latIndex - 0.5) * offset
    local lng = northwest.lng + (lngIndex + 0.5) * offset

    return lng, lat
end

local function getIndexFromLatLng(lng, lat)
    local northwest = {
        lat = 8396.62,
        lng = -4129.82
    }
    local southeast = {
        lat = -5105.48,
        lng = 4851.53
    }
    local offset = 115

    local numRows = math.ceil((northwest.lat - southeast.lat) / offset)
    local numCols = math.ceil((southeast.lng - northwest.lng) / offset)

    local latIndex = math.floor((northwest.lat - (lat + offset)) / offset) + 1
    local lngIndex = math.floor(((lng - offset) - northwest.lng) / offset) + 1

    local cellIndex = (latIndex) * (numCols ) + (lngIndex)

    return cellIndex
end

-- Player helpers
local function isPlayerInZone(playerCoords, zoneCenterCoords, radius)
    local xDiff = math.abs(playerCoords[1] - zoneCenterCoords[1])
    local yDiff = math.abs(playerCoords[2] - zoneCenterCoords[2])
    if xDiff <= radius and yDiff <= radius then
        return true
    else
        return false
    end
end

local function IsDowned()
    local PlayerData = framework:GetPlayerData()
    return framework:IsPlayerDown(PlayerData)
end

-- Target / props / storage helpers
local function SetEntityTargetOpenStorage(entity, zone, storage, data)
    if Config.UsingCoreInventory or Config.UsingOxInventory then
        exports["ox_target"]:addEntity(entity, {
            {
                icon = "fas fa-box-circle-check",
                label = "Open Storage",
                onSelect = function()
                    TriggerServerEvent('core_gangs:server:openStorage', {
                        zone = zone,
                        storage = storage,
                        InventoryType = data.InventoryType
                    })
                end
            }
        }, {
            distance = 3.0
        })
    else
        exports["ox_target"]:addEntity(entity, {
            {
                icon = "fas fa-box-circle-check",
                label = "Open Storage",
                onSelect = function()
                    data.zone = zone
                    data.storage = storage
                    framework:TriggerCallback('core_gangs:server:canAccessStorage', function(canAccess)
                        if canAccess then
                            if Config.UsingQBInventory or Config.UsingQSInventory or Config.UsingCodeMInventory then
                                TriggerServerEvent("inventory:server:OpenInventory", "stash", storage:gsub('-', '_'), {
                                    maxweight = data.maxWeight,
                                    slots = data.slot
                                })
                                TriggerEvent("inventory:client:SetCurrentStash", storage:gsub('-', '_'))
                            end
                        end
                    end, data)
                end
            }
        }, {
            distance = 3.0
        })
    end
end


local function createProp(zone, storage, data)
    local obj = CreateObject(GetHashKey(data.Prop), data.Coords, false, true, false)
    table.insert(SpawnedStuff, obj)
    SetEntityHeading(obj, data.Rotation)

    FreezeEntityPosition(obj, true)
    SetEntityTargetOpenStorage(obj, zone, storage, data)
end

local function createNPC(model, data)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
        Wait(1)
    end

    local npc = CreatePed(4, GetHashKey(model), data.Coords, data.Rotation, false, true)
	SetPedDefaultComponentVariation(npc)
    table.insert(SpawnedStuff, npc)
    if data.animDict then
        RequestAnimDict(data.animDict)
        while not HasAnimDictLoaded(data.animDict) do
            Wait(1)
        end

        TaskPlayAnim(npc, data.animDict, data.animName, 8.0, 0.0, -1, 1, 0.0, false, false, false)

        RemoveAnimDict(data.animDict)
    end

    SetEntityInvincible(npc, true)
    SetEntityCanBeDamaged(npc, false)
    SetEntityProofs(npc, true, true, true, true, true, true, true, true)
    FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetPedFleeAttributes(npc, 0, 0)
    SetPedCanRagdollFromPlayerImpact(npc, false)
    SetPedCanRagdoll(npc, false)

    SetPedSeeingRange(npc, 0.0)
    SetPedHearingRange(npc, 0.0)
    SetPedAlertness(npc, 0)
    SetPedCombatAttributes(npc, 46, true)

    SetEntityHeading(npc, data.Rotation)
    SetModelAsNoLongerNeeded(GetHashKey(model))

    return npc
end

local function CreateStorageNpc(zone, storageName, data)
    local npc = createNPC(data.Npc, data)
    SetEntityTargetOpenStorage(npc, zone, storageName, data)
end

local function createNPCFighter(zone)
    local zoneId = zone
    local zone = Zones[zone]

    local model = Config.NPCModels[math.random(#Config.NPCModels)]
    local weapon = Config.NPCWeapons[math.random(#Config.NPCWeapons)]

    if zone and zone.type then
        if zone.type  == 'house' then
            if Config.HouseZones[zoneId] and Config.HouseZones[zoneId].NPCModels then
                model = Config.HouseZones[zoneId].NPCModels[math.random(#Config.HouseZones[zoneId].NPCModels)]
            end
            if Config.HouseZones[zoneId] and Config.HouseZones[zoneId].NPCWeapons then
                weapon = Config.HouseZones[zoneId].NPCWeapons[math.random(#Config.HouseZones[zoneId].NPCWeapons)]
            end
        elseif zone.type ~= 'multiplier' then
            if Config.Zones[zoneId] and Config.Zones[zoneId].NPCModels then
                model = Config.Zones[zoneId].NPCModels[math.random(#Config.Zones[zoneId].NPCModels)]
            end
            if Config.Zones[zoneId] and Config.Zones[zoneId].NPCWeapons then
                weapon = Config.Zones[zoneId].NPCWeapons[math.random(#Config.Zones[zoneId].NPCWeapons)]
            end
        end
    end

    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
        Wait(1)
    end

    local x, y, found, safeCoord
    local tries = 0

    RequestCollisionAtCoord(zone.coords[1], zone.coords[2], zone.coords[3])

    repeat
        x = zone.coords[1] + math.random(-60.0, 60.0)
        y = zone.coords[2] + math.random(-60.0, 60.0)

        RequestCollisionAtCoord(x, y, zone.coords[3])

        local s, safeZ = GetGroundZFor_3dCoord(x, y, 99999.0, false)

        found, safeCoord = GetSafeCoordForPed(x, y, safeZ, true, 16)
        tries = tries + 1

        if tries >= 50 then
            break
        end
    until found

    if found then

        RequestCollisionAtCoord(safeCoord)
        local npc = CreatePed(0, GetHashKey(model), safeCoord.x, safeCoord.y, safeCoord.z, 0.0, true)

        SetPedRandomComponentVariation(npc, true)
        SetPedSphereDefensiveArea(npc, safeCoord.x, safeCoord.y, safeCoord.z, 60.0, false, false)
        GiveWeaponToPed(npc, GetHashKey(weapon), 255, false, true)

        if Config.NPCSpawnWithWeaponInHand then
            SetCurrentPedWeapon(npc, GetHashKey(weapon), true)
        end

        -- RELATIONSHIPS
        local orgOfNpc = zone.org or NPCDefaultGroupNameIfNotOwned
        if not DoesRelationshipGroupExist(GetHashKey('GANG_NPC_' .. orgOfNpc)) then
            local _, hash = AddRelationshipGroup('GANG_NPC_' .. orgOfNpc, GetHashKey('GANG_NPC_' .. orgOfNpc))
        end

        SetPedRelationshipGroupHash(npc, GetHashKey('GANG_NPC_' .. orgOfNpc))

        for k, v in pairs(Organizations) do
            if k ~= orgOfNpc then
                if Config.NPCAttackOnlyWhenWarOnNPCZone and CurrentWar ~= zoneId then
                    SetRelationshipBetweenGroups(1, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('GANG_' .. k))
                else
                    SetRelationshipBetweenGroups(5, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('GANG_' .. k))
                end
            end
        end

        SetRelationshipBetweenGroups(1, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('GANG_NPC_' .. orgOfNpc))

        SetRelationshipBetweenGroups(1, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey("PLAYER"))
        SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey('GANG_NPC_' .. orgOfNpc))

        SetRelationshipBetweenGroups(1, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('GANG_' .. orgOfNpc))
        SetRelationshipBetweenGroups(1, GetHashKey('GANG_' .. orgOfNpc), GetHashKey('GANG_NPC_' .. orgOfNpc))

        if not Config.NPCAttackOtherDefaultGroup then
            -- DEFAULT GTA V GROUP RESPECT RELATIONSHIP TO PREVENT WAR BETWEEN NPC
            SetRelationshipBetweenGroups(1, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('AMBIENT_GANG_BALLAS'))
            SetRelationshipBetweenGroups(1, GetHashKey('AMBIENT_GANG_BALLAS'), GetHashKey('GANG_NPC_' .. orgOfNpc))
            SetRelationshipBetweenGroups(1, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('AMBIENT_GANG_CULT'))
            SetRelationshipBetweenGroups(1, GetHashKey('AMBIENT_GANG_CULT'), GetHashKey('GANG_NPC_' .. orgOfNpc))
            SetRelationshipBetweenGroups(1, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('AMBIENT_GANG_FAMILY'))
            SetRelationshipBetweenGroups(1, GetHashKey('AMBIENT_GANG_FAMILY'), GetHashKey('GANG_NPC_' .. orgOfNpc))
            SetRelationshipBetweenGroups(1, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('AMBIENT_GANG_LOST'))
            SetRelationshipBetweenGroups(1, GetHashKey('AMBIENT_GANG_LOST'), GetHashKey('GANG_NPC_' .. orgOfNpc))
            SetRelationshipBetweenGroups(1, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('AMBIENT_GANG_MARABUNTE'))
            SetRelationshipBetweenGroups(1, GetHashKey('AMBIENT_GANG_MARABUNTE'), GetHashKey('GANG_NPC_' .. orgOfNpc))
            SetRelationshipBetweenGroups(1, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('AMBIENT_GANG_MEXICAN'))
            SetRelationshipBetweenGroups(1, GetHashKey('AMBIENT_GANG_MEXICAN'), GetHashKey('GANG_NPC_' .. orgOfNpc))
            SetRelationshipBetweenGroups(1, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('AMBIENT_GANG_SALVA'))
            SetRelationshipBetweenGroups(1, GetHashKey('AMBIENT_GANG_SALVA'), GetHashKey('GANG_NPC_' .. orgOfNpc))
            SetRelationshipBetweenGroups(1, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('AMBIENT_GANG_WEICHENG'))
            SetRelationshipBetweenGroups(1, GetHashKey('AMBIENT_GANG_WEICHENG'), GetHashKey('GANG_NPC_' .. orgOfNpc))
            SetRelationshipBetweenGroups(1, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('AMBIENT_GANG_HILLBILLY'))
            SetRelationshipBetweenGroups(1, GetHashKey('AMBIENT_GANG_HILLBILLY'), GetHashKey('GANG_NPC_' .. orgOfNpc))
            SetRelationshipBetweenGroups(1, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('COP'))
            SetRelationshipBetweenGroups(1, GetHashKey('COP'), GetHashKey('GANG_NPC_' .. orgOfNpc))
            SetRelationshipBetweenGroups(1, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('SECURITY_GUARD'))
            SetRelationshipBetweenGroups(1, GetHashKey('SECURITY_GUARD'), GetHashKey('GANG_NPC_' .. orgOfNpc))
            SetRelationshipBetweenGroups(1, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('DOMESTIC_ANIMAL'))
            SetRelationshipBetweenGroups(1, GetHashKey('DOMESTIC_ANIMAL'), GetHashKey('GANG_NPC_' .. orgOfNpc))
            SetRelationshipBetweenGroups(1, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('GUARD_DOG'))
            SetRelationshipBetweenGroups(1, GetHashKey('GUARD_DOG'), GetHashKey('GANG_NPC_' .. orgOfNpc))
            -- END DEFAULT NPC GROUP RELATIONSHIP
        end

        SetAmbientVoiceName(npc, "G_M_Y_Lost_01_WHITE_FULL_01")

        SetPedSeeingRange(npc, 25.0)
        SetEntityAsMissionEntity(npc, true, true)
        SetPedDropsWeaponsWhenDead(npc, false)
        SetPedFleeAttributes(npc, 0, false)
        SetPedCombatAttributes(npc, 46, true)
        SetPedCombatAttributes(npc, 5, true)

        TaskWanderInArea(npc, zone.coords.x, zone.coords.y, safeCoord.z, 60.0, 5, 5.0)
        return npc
    else
        return nil
    end
end

local function manageSpawnNpcFighter(zone, count)
    if Organization and Organization ~= '' then
        for i = 1, count do
            local npc = createNPCFighter(zone)
            if npc then
                SpawnedNPCS[zone] = SpawnedNPCS[zone] or {}
                table.insert(SpawnedNPCS[zone], npc)
                TriggerServerEvent("core_gangs:server:registerNPC", zone, NetworkGetNetworkIdFromEntity(npc))
            end
        end
    end
end

local function CreateDefaultRelationshipGroup()
    if not DoesRelationshipGroupExist(GetHashKey('PLAYER')) then
        local _, hash = AddRelationshipGroup('PLAYER', GetHashKey('PLAYER'))
    end
    SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey('PLAYER'))
end

RegisterNetEvent('core_gang:client:releaseNPCFighter', function(zone, npcNetworkId)

    local pedFromNetwork = NetworkGetEntityFromNetworkId(npcNetworkId)

    if Config.NPCStopAttackingOnWarEnd then
        RemoveAllPedWeapons(pedFromNetwork, true)
        SetCurrentPedWeapon(pedFromNetwork, GetHashKey('weapon_unarmed'), true)

        SetPedRelationshipGroupHash(pedFromNetwork, GetHashKey('PLAYER'))

        SetRelationshipBetweenGroups(1, GetHashKey('PLAYER'), GetPedRelationshipGroupHash(GetPlayerPed(-1)))
        SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(GetPlayerPed(-1)), GetHashKey('PLAYER'))

        SetPedCombatAttributes(pedFromNetwork, 46, false)
        SetPedCombatAttributes(pedFromNetwork, 5, false)
    end

    SetEntityAsMissionEntity(pedFromNetwork, false, false)
    if SpawnedNPCS[zone] then
        for k, v in pairs(SpawnedNPCS[zone]) do
            if v == pedFromNetwork then
                table.remove(SpawnedNPCS[zone], k)
                break
            end
        end
    end
end)

--------------------
-- DATA RETRIEVAL --
--------------------

RegisterNetEvent("core_gangs:client:updateCurrency", function(currency)
    Currency = currency
    SendNUIMessage({
        type = "currency",
        currency = Currency
    })
end)

-----------------
-- Player load --
-----------------
local receiveFirstServerEvent = false
local firstTimeDataRetrieve = false

local function initDataFirstLoad(force)
    framework:TriggerCallback('core_gangs:server:getPlayerCurrency', function(currency)
        Currency = currency

        SendNUIMessage({
            type = "currency",
            currency = Currency
        })

        framework:TriggerCallback('core_gangs:server:getPlayerConfig', function(config)
            UserConfig = config

            while not firstTimeDataRetrieve do
                Wait(5)
            end

            -- CREATE RELATIONSHIPS
            if not Loaded or force then
                for k, v in pairs(Organizations) do
                    if not DoesRelationshipGroupExist(GetHashKey('GANG_' .. k)) then
                        AddRelationshipGroup('GANG_' .. k, GetHashKey('GANG_' .. k))
                    end
                    SetRelationshipBetweenGroups(1, GetHashKey('GANG_' .. k), GetHashKey("PLAYER"))
                    SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey('GANG_' .. k))
                end
                -- All relation should be neutral (PLAYER GANG and ALL THE GANG ITSELF)
                for k, v in pairs(Organizations) do
                    for key, value in pairs(Organizations) do
                        SetRelationshipBetweenGroups(1, GetHashKey('GANG_' .. key), GetHashKey('GANG_' .. k))
                        SetRelationshipBetweenGroups(1, GetHashKey('GANG_' .. k), GetHashKey('GANG_' .. key))
                    end
                end
            end

            if not PropsAndTargetCreated and GetPlayerPed(-1) then
                CreatePropsAndTarget()
            end

            local playerData = framework:GetPlayerData()
            Identifier = framework:GetPlayerIdentifier_c(playerData)

            if (Criminals[Identifier]) then
                if Organizations[Criminals[Identifier].org] then
                    Organization = Criminals[Identifier].org
                else
                    Organization = nil
                end
            else
                Organization = nil
            end

            Loaded = true
        end)
    end)
end

local function retrieveDataFirstLoad(force)
    local callBackEnded = 0

    framework:TriggerCallback('core_gangs:server:retrieveAllDataByName', function(data)
        Organizations = data
        callBackEnded = callBackEnded + 1
    end, 'organization')

    while callBackEnded < 1 do
        Wait(5)
    end

    callBackEnded = 0
    framework:TriggerCallback('core_gangs:server:retrieveAllDataByName', function(data)
        Zones = data
        callBackEnded = callBackEnded + 1

    end, 'zone')

    while callBackEnded < 1 do
        Wait(5)
    end
    callBackEnded = 0

    framework:TriggerCallback('core_gangs:server:retrieveAllDataByName', function(data)
        Criminals = data
        callBackEnded = callBackEnded + 1

    end, 'criminal')

    while callBackEnded < 1 do
        Wait(5)
    end
    callBackEnded = 0

    framework:TriggerCallback('core_gangs:server:retrieveAllDataByName', function(data)
        Bounties = data
        callBackEnded = callBackEnded + 1


    end, 'bounty')

    while callBackEnded < 1 do
        Wait(5)
    end

    firstTimeDataRetrieve = true
    initDataFirstLoad(force)
    CreateDefaultRelationshipGroup()
end

RegisterNetEvent('core_gangs:client:canRetrieveDataFirstTime', function()
    receiveFirstServerEvent = true
    if not firstTimeDataRetrieve then
        retrieveDataFirstLoad()
    end
end)

if Config.Framework == 'qb-core' then
    RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
        retrieveDataFirstLoad(true)
    end)
elseif Config.Framework == 'esx' then
    RegisterNetEvent("esx:playerLoaded", function()
        retrieveDataFirstLoad(true)
    end)
end

local function HandleDeleteData(deleteDataTable)
    for k, v in pairs(deleteDataTable.Organizations) do
        Organizations[k] = nil
    end
    for k, v in pairs(deleteDataTable.Zones) do
        Zones[k] = nil
    end
    for k, v in pairs(deleteDataTable.Criminals) do
        Criminals[k] = nil
    end
    for k, v in pairs(deleteDataTable.Bounties) do
        Bounties[k] = nil
    end

end

local function HandleAddUpdateData(orgs, zones, bounty, criminals)
    for k, v in pairs(orgs) do
        Organizations[k] = v
    end

    for k, v in pairs(zones) do
        Zones[k] = v
    end

    for k, v in pairs(criminals) do
        Criminals[k] = v
    end

    for k, v in pairs(bounty) do
        Bounties[k] = v
    end
end

RegisterNetEvent("core_gangs:client:updateData", function(orgs, zones, bounty, criminals, deleteData)

    if deleteData then
        HandleDeleteData(deleteData)
    end

    HandleAddUpdateData(orgs, zones, bounty, criminals)

    local playerData = framework:GetPlayerData()
    Identifier = framework:GetPlayerIdentifier_c(playerData)

    if (Criminals[Identifier]) then
        if Organizations[Criminals[Identifier].org] then
            Organization = Criminals[Identifier].org
        else
            Organization = nil
        end
    else
        Organization = nil
    end

    SendNUIMessage({
        type = "update",
        orgs = Organizations,
        criminals = Criminals,
        bounties = Bounties,
        zones = Zones,
        config = Config,
        org = Organization,
        userConfig = UserConfig
    })
end)

RegisterNetEvent("core_gangs:client:notification", function(text, forceNotify)
    if (Organization and Organization ~= '') or forceNotify then
        if not MenuOpen or forceNotify then
            SendTextMessage(text)
        else
            SendNUIMessage({
                type = "notification",
                text = text
            })
        end
    end
end)

RegisterNetEvent("core_gangs:client:captureNotification", function(text, organization)
    if Organization and Organization ~= '' then
        if not organization or organization == Organization then
            SendTextMessage(text)
        end
    end
end)

RegisterNetEvent("core_gangs:client:warBlip", function(zone, time)
    if Organization and Organization ~= '' then
        CreateWarBlip(zone, time)
    end
end)

function CreateWarBlip(zone, timeLeft)
    local zoneId = tonumber(zone)
    if WarBlips[zoneId] == nil then
        WarBlips[zoneId] = AddBlipForArea(Zones[zoneId].coords.x, Zones[zoneId].coords.y, Zones[zoneId].coords.z, 120.0, 120.0)

        SetBlipRotation(WarBlips[zoneId], 0)
        SetBlipSprite(WarBlips[zoneId], 9)
        SetBlipColour(WarBlips[zoneId], 1)
        SetBlipAlpha(WarBlips[zoneId], 80)
        SetBlipAsShortRange(WarBlips[zoneId], true)

        SetTimeout(timeLeft, function()
            RemoveBlip(WarBlips[zoneId])
            WarBlips[zoneId] = nil
        end)
    end
end

RegisterNetEvent("core_gangs:client:refreshZones", function()
    if MenuOpen then
        SendNUIMessage({
            type = "refreshZones",
            zones = Zones
        })
    end
end)

RegisterNetEvent("core_gangs:client:inviteToOrg", function(org)
    SendNUIMessage({
        type = "invite",
        org = org
    })
end)

RegisterNetEvent("core_gangs:client:endWar", function(zone, winner)
    if CurrentWar == zone then
        endWar(zone)
    end

    if Config.DisplayWarWall then
        if Config.DisplayWallWarForEveryone or (Organization and Organization ~= '') then
            if Borders[zone] and (Borders[zone].dui) then
                DestroyDui(Borders[zone].dui)
                Borders[zone] = nil
            end
        end
    end
end)

local latestWarZone = nil
RegisterNetEvent("core_gangs:client:updateWar", function(zone, data, timeleft)
    if tonumber(CurrentWar) == tonumber(zone) or (latestWarZone and tonumber(latestWarZone) == tonumber(zone)) then
        SendNUIMessage({
            type = "updateWarChart",
            data = data,
            zone = zone,
            timeleft = timeleft,
            inwarzone = inWarZone
        })
        latestWarZone = zone
    end

    if MenuOpen then
        SendNUIMessage({
            type = "updateWars",
            zone = zone,
            timeleft = timeleft
        })
    end

    if Organization and Organization ~= '' then
        if WarBlips[tonumber(zone)] == nil then
            CreateWarBlip(zone, timeleft * 1000, WarBlips[tonumber(zone)])
        end
    end

    if Config.DisplayWarWall then
        if Config.DisplayWallWarForEveryone or (Organization and Organization ~= '') then
            local playerCoords = GetEntityCoords(PlayerPedId())
            local longCoords, latCoords = getCoordsFromIndex(tonumber(zone))
            if latCoords and longCoords then
                local zoneCoords = vector3(longCoords, latCoords, playerCoords.z)
                if playerCoords and zoneCoords then
                    local distance =  #(zoneCoords - playerCoords);
                    if distance <= (Config.DistanceToDisplayWall + 5.0) then
                        if Borders[zone] then
                            if IsDuiAvailable(Borders[zone].dui) then
                                SendDuiMessage(Borders[zone].dui, json.encode({
                                    type = "updateWarBorder",
                                    data = data,
                                    zone = zone,
                                    timeleft = timeleft,
                                    orgs = Organizations,
                                    EnableBackgroundWallEffect = Config.EnableBackgroundWallEffect,
                                    EnableSlidingTextWallEffect = Config.EnableSlidingTextWallEffect,
                                    EnablePulseTextWallEffect = Config.EnablePulseTextWallEffect
                                }))
                            else
                                print('[Core Gangs] Border hologram failed to load')
                            end
                        else
                            createWallBorder(zone)
                        end
                    elseif distance > (Config.DistanceToDisplayWall + 5.0) and Borders[zone] and Borders[zone].dui then
                        DestroyDui(Borders[zone].dui)
                        Borders[zone] = nil
                    end
                end
            end
        end
    end
end)

function CreatePropsAndTarget()
    for k, v in pairs(Config.Zones) do
        for k2, v2 in pairs(v.Storages) do
            if v2.Npc then
                CreateStorageNpc(k, k2, v2)
            elseif v2.Prop then
                createProp(k, k2, v2)
            end
        end
        if (v.NPCs) then
            for k2, v2 in pairs(v.NPCs) do
                createNPC(k2, v2)
            end
        end
    end

    for k, v in pairs(Config.HouseZones) do
        for k2, v2 in pairs(v.Storages) do
            if v2.Npc then
                CreateStorageNpc(k, k2, v2)
            elseif v2.Prop then
                createProp(k, k2, v2)
            end
        end
        if (v.NPCs) then
            for k2, v2 in pairs(v.NPCs) do
                createNPC(k2, v2)
            end
        end
    end

    for k, v in pairs(Config.Continentals) do
        local num = 1
        for k2, v2 in pairs(v.ShopNPCs) do
            local target = createNPC(k2, v2)
            ContinentalNPCS[k] = ContinentalNPCS[k] or {}
            ContinentalNPCS[k][num] = target
            exports["ox_target"]:addEntity(target, {
                {
                    icon = "fas fa-box-circle-check",
                    label = "Open Shop",
                    onSelect = function(data)
                        TriggerEvent('core_gangs:client:openContinental', data.id, data.pedzone)
                    end,
                    id = num, -- Custom data passed to the event
                    pedzone = k  -- Custom data passed to the event
                }
            }, {
                distance = 3.0
            })
            
            num = num + 1
        end
    end
    PropsAndTargetCreated = true
end

Citizen.CreateThread(function()
    if not PropsAndTargetCreated and GetPlayerPed(-1) then
        CreatePropsAndTarget()
    end
end)

-- NPCS

Citizen.CreateThread(function()
    while true do
        for zone, npcs in pairs(SpawnedNPCS) do
            for i, npc in ipairs(npcs) do
                if DoesEntityExist(npc) then
                    if GetEntityHealth(npc) > 0 and not isPlayerInZone(GetEntityCoords(npc), Zones[zone].coords, 60.0) and
                        (not GetIsTaskActive(npc, 343) or not GetIsTaskActive(npc, 222)) then
                        ClearPedTasksImmediately(npc)

                        local npcCoords = GetEntityCoords(npc)
                        TaskWanderInArea(npc, Zones[zone].coords.x, Zones[zone].coords.y, npcCoords.z, 60.0, 5, 5.0)
                    end
                else
                    table.remove(SpawnedNPCS[zone], i)
                end
            end
        end

        Citizen.Wait(3000)
    end
end)

-- LOOP

Citizen.CreateThread(function()
    while true do
        if ContinentalOpen and ContinentalNPC then
            local pCoords = GetEntityCoords(ContinentalNPC)

            local start = GetOffsetFromEntityInWorldCoords(ContinentalNPC, 0, 10.0, 10.0)
            local dir = pCoords - start

            DrawSpotLight(start[1], start[2], start[3], dir[1], dir[2], dir[3], 255, 255, 255, 25.0, 2.0, 2.0, 7.0, 0.0)

            SetArtificialLightsState(true)
            NetworkOverrideClockTime(1, 00, 00)

            DisplayRadar(false)
        else
            Citizen.Wait(500)
        end

        Citizen.Wait(1)
    end
end)

-- ZONE CHECKING
Citizen.CreateThread(function()

    while not Loaded do
        Citizen.Wait(100)
    end

    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local data = framework:GetPlayerData()

        if Organization and Organization ~= '' then
            SetPedRelationshipGroupHash(ped, GetHashKey('GANG_' .. Organization))
            for k, v in pairs(Zones) do
                if isPlayerInZone(coords, v.coords, 60) then
                    if CurrentWar ~= k and v.war > 0 then
                        startWar(k)
                    end

                    local ZoneData = Zones[k]
                    if ZoneData and ZoneData.npcs then
                        if (ZoneData.npcs or 0) > 0 and (((SpawnedNPCS[k] and #SpawnedNPCS[k]) or 0) < (ZoneData.npcs or 0)) then
                            local waitingCallback = true

                            framework:TriggerCallback('core_gangs:server:manageFighterNPCS', function(count)
                                if count and count > 0 then
                                    manageSpawnNpcFighter(k, count)
                                end
                                waitingCallback = false
                            end, { zone = k })

                            local callLimit = 500
                            while waitingCallback and callLimit > 0 do
                                callLimit = callLimit - 1
                                Wait(10)
                            end
                        end
                    end
                end
            end

            if CurrentWar then
                local warZone = Zones[CurrentWar]

                if isPlayerInZone(coords, warZone.coords, 60) then
                    -- UPDATE WAR SCORE
                    if not IsDowned() then
                        TriggerServerEvent("core_gangs:server:updateWarScore", CurrentWar, Organization)
                    end

                    inWarZone = true
                else
                    inWarZone = false
                end
            end
        else
            SetPedRelationshipGroupHash(ped, GetHashKey("PLAYER"))
        end

        Citizen.Wait(500)
    end
end)

-- WALLS

local wallLength = 120.0 -- Length of each wall
local wallHeight = 100.0 -- Height of each wall
local zoneRadius = 60.0

local spawned = false

local function calculateWallCorners(middlePoint, angle, length, height)
    -- Convert the incoming angle to radians and adjust by 90 degrees for perpendicular
    local perpAngle = math.rad(angle + 90)

    -- Calculate the perpendicular offsets for the wall's length
    local xOffset = (length / 2) * math.cos(perpAngle)
    local yOffset = (length / 2) * math.sin(perpAngle)

    -- Calculate the corners using the perpendicular offsets
    -- Notice that when x increases, y decreases, and vice versa, to ensure a straight line
    local topLeft = {
        x = middlePoint.x - xOffset,
        y = middlePoint.y - yOffset,
        z = middlePoint.z + height
    }
    local topRight = {
        x = middlePoint.x + xOffset,
        y = middlePoint.y + yOffset,
        z = middlePoint.z + height
    }
    local bottomLeft = {
        x = middlePoint.x - xOffset,
        y = middlePoint.y - yOffset,
        z = middlePoint.z
    }
    local bottomRight = {
        x = middlePoint.x + xOffset,
        y = middlePoint.y + yOffset,
        z = middlePoint.z
    }

    return topLeft, topRight, bottomLeft, bottomRight
end

local function drawWall(topLeft, topRight, bottomLeft, bottomRight, zone)
    if (inWarZone and CurrentWar == zone) or CanSeeBorder then
        DrawSpritePoly(topLeft.x, topLeft.y, topLeft.z, topRight.x, topRight.y, topRight.z, bottomRight.x,
            bottomRight.y, bottomRight.z, 255, 255, 255, 255, "border" .. zone, "holo" .. zone, 1.0, 0.0, 0.0, 0.0, 0.0,
            1.0, 0.0, 1.0, 1.0)

        DrawSpritePoly(topLeft.x, topLeft.y, topLeft.z, bottomRight.x, bottomRight.y, bottomRight.z, bottomLeft.x,
            bottomLeft.y, bottomLeft.z, 255, 255, 255, 255, "border" .. zone, "holo" .. zone, 1.0, 0.0, 0.0, 0.0, 1.0,
            1.0, 1.0, 1.0, 1.0)
    else
        DrawSpritePoly(bottomRight.x, bottomRight.y, bottomRight.z, topRight.x, topRight.y, topRight.z, topLeft.x,
            topLeft.y, topLeft.z, 255, 255, 255, 255, "border" .. zone, "holo" .. zone, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0,
            0.0, 0.0, 1.0)
        DrawSpritePoly(topLeft.x, topLeft.y, topLeft.z, bottomLeft.x, bottomLeft.y, bottomLeft.z, bottomRight.x,
            bottomRight.y, bottomRight.z, 255, 255, 255, 255, "border" .. zone, "holo" .. zone, 0.0, 0.0, 1.0, 0.0, 1.0,
            1.0, 1.0, 1.0)
    end
end

function createWallBorder(zone)

    local txd, txm = 'border' .. zone, 'holo' .. zone
    local textureDict = CreateRuntimeTxd(txd)
    local duiObj = CreateDui(string.format("nui://%s/html/border/border.html", GetCurrentResourceName()), 1500, 1500)

    local dui = GetDuiHandle(duiObj)
    local tx = CreateRuntimeTextureFromDuiHandle(textureDict, txm, dui)

    Citizen.Wait(500)
    Borders[zone] = { dui = duiObj }

    SendDuiMessage(duiObj, json.encode({
        type = "load",
        orgs = Organizations,
        config = Config
    }))
end

local function drawSquareWalls(middlePoint, wallLength, wallHeight, zone)
    local zoneRadius = wallLength / 2
    local coords = GetEntityCoords(PlayerPedId())

    if not Borders[zone].calculated then
        Borders[zone].calculated = {}
        RequestCollisionAtCoord(middlePoint.x, middlePoint.y, middlePoint.z)
    end

    for i = 0, 3 do
        if not Borders[zone].calculated[i] then
            local angle = i * 90
            local middleX = middlePoint.x + zoneRadius * math.cos(math.rad(angle))
            local middleY = middlePoint.y + zoneRadius * math.sin(math.rad(angle))
            RequestCollisionAtCoord(middlePoint.x, middlePoint.y, middlePoint.z)

            local s, safeZ = GetGroundZFor_3dCoord(middlePoint.x, middlePoint.y, 9999.0, false)
            local middleZ = (safeZ or middlePoint.z) - 40.0

            local wallMiddlePoint = {
                x = middleX,
                y = middleY,
                z = middleZ
            }

            local topLeft, topRight, bottomLeft, bottomRight = calculateWallCorners(wallMiddlePoint, angle, wallLength, wallHeight)

            Borders[zone].calculated[i] = {
                topLeft = topLeft,
                topRight = topRight,
                bottomLeft = bottomLeft,
                bottomRight = bottomRight
            }
        end

        local calculated = Borders[zone].calculated[i]
        drawWall(calculated.topLeft, calculated.topRight, calculated.bottomLeft, calculated.bottomRight, zone)
    end
end

-- WALL DRAWING
Citizen.CreateThread(function()
    while true do
        if next(Borders) then
            local coords = GetEntityCoords(PlayerPedId())
            for k, v in pairs(Borders) do
                local centerCoords = Zones[k].coords
                if #(centerCoords - coords) < Config.DistanceToDisplayWall then
                    CanSeeBorder = isPlayerInZone(GetEntityCoords(GetPlayerPed(-1)), centerCoords, 60.0)
                    drawSquareWalls(centerCoords, wallLength, wallHeight, k)
                end
            end
        else
            Citizen.Wait(1000)
        end
        Citizen.Wait(1)
    end
end)

-- DEATH CHECKING

AddEventHandler("gameEventTriggered", function(event, args)
    if event == "CEventNetworkEntityDamage" then
        OnEntityDamage(args)
    end
end)

function OnEntityDamage(args)
    local fatal = args[damageIndex.fatal]
    if fatal == 0 then
        return
    end

    local victim = args[1]
    local killer = args[2]
    local headshot = false
    local playerPed = PlayerPedId()

    if not IsEntityAPed(victim) or not IsEntityAPed(killer) or not IsPedAPlayer(killer) then
        return
    end

    if playerPed == victim then
        local weaponHash = args[damageIndex.weapon]

        --- DETECTS HEADSHOT
        local found, bone = GetPedLastDamageBone(victim)
        if found and (bone == 31086 or bone == 39317) then
            headshot = true
        end

        local isMelee = (args[12] == 1 and true) or false
        recentDeaths[victim] = true

        local victimCoords = GetEntityCoords(playerPed)
        local killerCoords = GetEntityCoords(killer)

        TriggerServerEvent("core_gangs:server:playerKilled", GetPlayerServerId(NetworkGetPlayerIndexFromPed(killer)),
            weaponHash, headshot, getIndexFromLatLng(victimCoords[1], victimCoords[2]),
            getIndexFromLatLng(killerCoords[1], killerCoords[2]))
        Citizen.Wait(1000)
        recentDeaths[victim] = nil
    end
end

function endWar(zone)
    SendNUIMessage({
        type = "stopWarChart"
    })

    CurrentWar = nil
    inWarZone = false
    latestWarZone = nil
end

function startWar(zone)
    CurrentWar = zone

    local zoneId = zone
    zone = Zones[zoneId]
    local orgOfNpc = zone.org or NPCDefaultGroupNameIfNotOwned

    local npcs = SpawnedNPCS[CurrentWar]
    for k, v in pairs(Organizations) do
        if k ~= orgOfNpc then
            if Config.NPCAttackOnlyWhenWarOnNPCZone and CurrentWar ~= zoneId then
                SetRelationshipBetweenGroups(1, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('GANG_' .. k))
            else
                SetRelationshipBetweenGroups(5, GetHashKey('GANG_NPC_' .. orgOfNpc), GetHashKey('GANG_' .. k))
            end
        end
    end
end

RegisterNUICallback("completeRegistration", function(data)
    local name, color, picture = data["name"], data["color"], data["picture"]

    TriggerServerEvent("core_gangs:server:createOrganization", name, color, picture)
end)

RegisterNUICallback("confirmUserInfo", function(data)
    local alias = data["alias"]
    local playerData = framework:GetPlayerData()
    local playerGang = framework:GetPlayerGang_c(playerData)

    TriggerServerEvent("core_gangs:server:createCriminal", alias, playerGang)
end)

RegisterNUICallback("startWar", function(data)
    local zone = data["zone"]
    TriggerServerEvent("core_gangs:server:startWar", zone, Organization)
end)

RegisterNUICallback("acceptInvite", function(data)
    local org = data["org"]
    TriggerServerEvent("core_gangs:server:acceptOrgInvite", org)
end)

RegisterNUICallback("inviteCriminal", function(data)
    local criminal = data["criminal"]
    TriggerServerEvent("core_gangs:server:inviteCriminalToOrg", criminal, Organization)
end)

RegisterNUICallback("kickCriminal", function(data)
    local criminal = data["criminal"]
    TriggerServerEvent("core_gangs:server:removeFromOrg", criminal, Organization)
end)

RegisterNUICallback("checkoutContinental", function(data)
    local cart, price = data["cart"], data["price"]

    TriggerServerEvent("core_gangs:server:checkoutContinental", cart, price)
end)

RegisterNUICallback("submitImage", function(data)
    local image = data["image"]
    TriggerServerEvent("core_gangs:server:changeOrganizationImage", image, Organization)
end)

RegisterNUICallback("updatePreference", function(data)
    framework:TriggerCallback('core_gangs:server:updatePreference', function(userConfig)
        UserConfig = userConfig
    end, data.preference)
end)

RegisterNUICallback("newBounty", function(data)
    local criminal, bounty = data["criminal"], data["bounty"]
    TriggerServerEvent("core_gangs:server:newBounty", criminal, bounty)
end)

RegisterNUICallback("deleteBounty", function(data)
    local id = data["id"]
    TriggerServerEvent("core_gangs:server:deleteBounty", id)
end)

RegisterNUICallback("acceptBounty", function(data)
    local id = data["id"]
    TriggerServerEvent("core_gangs:server:acceptBounty", id)
end)

RegisterNUICallback("setWaypoint", function(data)
    local zone = data["zone"]
    local coords = Zones[tonumber(zone)].coords
    SetNewWaypoint(coords[1], coords[2])
    SendNUIMessage({
        type = "notification",
        text = Config.Text["waypointSet"]
    })
end)

RegisterNUICallback("increaseProtection", function(data)
    local zone = data["zone"]
    TriggerServerEvent("core_gangs:server:increaseProtection", zone, Organization)
end)

RegisterNUICallback("increaseNPCS", function(data)
    local zone = data["zone"]
    TriggerServerEvent("core_gangs:server:increaseNPCS", zone, Organization)
end)

RegisterNUICallback("leaveOrg", function(data)
    TriggerServerEvent("core_gangs:server:leaveOrganization", Organization)
end)

RegisterNUICallback("close", function(data)
    if ContinentalOpen then
        openContinental(false)
        ContinentalOpen = false
    else
        MenuOpen = false
    end

    SetNuiFocus(false, false)
end)

RegisterKeyMapping("criminal", "Open Criminal Menu", "keyboard", Config.OpenKey)

RegisterCommand("criminal", function(source, args, rawCommand)
    openMenu()
end)

function openMenu()

    while not Loaded do
        Wait(100)
    end

    local playerData = framework:GetPlayerData()
    local cid = framework:GetPlayerIdentifier_c(playerData)
    local playerJob = framework:GetPlayerJob_c(playerData)

    if playerJob and playerJob.name and Config.BlacklistedJob[playerJob.name] then
        return
    end

    local coords = GetEntityCoords(PlayerPedId())

    framework:TriggerCallback('core_gangs:server:getPlayerCurrency', function(currency)
        Currency = currency
        SendNUIMessage({
            type = "currency",
            currency = Currency
        })

        SetNuiFocus(true, true)
        SendNUIMessage({
            type = "open",
            orgs = Organizations,
            criminals = Criminals,
            bounties = Bounties,
            zones = Zones,
            config = Config,
            org = Organization,
            cid = cid,
            coords = coords,
            userConfig = UserConfig
        })

        MenuOpen = true
    end)

end

RegisterNetEvent("core_gangs:client:openContinental", function(data)
    openContinental(true, data.pedzone, data.id)
end)

function openContinental(open, zone, num)
    if Organization == nil or Organization == '' then
        return
    end

    local ped = PlayerPedId()

    if open then
        if ContinentalNPCS[zone] and ContinentalNPCS[zone].ShopOpenHours then
            local hours = GetClockHours()
            local shopHours = ContinentalNPCS[zone].ShopOpenHours
            if shopHours and not (hours <= hours[2] or hours >= hours[1]) then
                SendNUIMessage({
                    type = "notification",
                    text = Config.Text["continental_shop_close"]
                })
                return
            end
        end

        trackEntity = ContinentalNPCS[zone][num]
        ContinentalNPC = trackEntity

        SetNuiFocus(true, true)

        SendNUIMessage({
            type = "continental",
            zone = zone,
            config = Config
        })

        offsetEnd = GetOffsetFromEntityInWorldCoords(trackEntity, vector3(0.0, 2.0, 0.0))
        offsetStart = GetOffsetFromEntityInWorldCoords(trackEntity, vector3(0.0, 5.0, 0.0))

        local direction = GetEntityForwardVector(trackEntity)
        local right = vector3(-direction.y, direction.x, direction.z)
        local offsetPosition = GetEntityCoords(trackEntity) + right * 1.2

        local offsetPed = CreatePed(4, GetEntityModel(trackEntity), offsetPosition.x, offsetPosition.y,
            GetEntityCoords(trackEntity)[3], 0.0, false, true)

        table.insert(SpawnedStuff, offsetPed)

        FreezeEntityPosition(offsetPed, true)
        SetEntityAlpha(offsetPed, 0, false)
        SetEntityCollision(offsetPed, false, false)

        SetTimecycleModifier("METRO_Tunnels")
        SetTimecycleModifierStrength(3.0)
        FreezeEntityPosition(ped, true)

        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", offsetStart, 0.0, 0.0, 0, 60.00, false, 0)
        PointCamAtEntity(cam, offsetPed, 0, 0, 0, true)
        FreezeEntityPosition(ped, false)
        SetCamFov(cam, 70.0)
        SetCamActiveWithInterp(cam, cam2, 300, true, true)
        RenderScriptCams(true, false, 1, true, true)

        cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", offsetEnd, 0.0, 0.0, 0, 60.00, false, 0)
        PointCamAtEntity(cam2, offsetPed, 0, 0, 0, true)
        SetCamFov(cam2, 60.0)
        SetCamActiveWithInterp(cam2, cam, 300, true, true)

        Citizen.CreateThread(function()
            Citizen.Wait(300)
            if DoesCamExist(cam) then
                DestroyCam(cam, true)
            end
        end)
    else
        SetArtificialLightsState(false)
        NetworkClearClockTimeOverride()
        DisplayRadar(true)

        SetTimecycleModifier("default")
        if DoesCamExist(cam) then
            DestroyCam(cam, true)
        end
        if DoesCamExist(cam2) then
            DestroyCam(cam2, true)
        end

        RenderScriptCams(false, false, 1, true, true)
        FreezeEntityPosition(ped, false)
    end

    ContinentalOpen = open
end

AddEventHandler("onResourceStop", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    for _, v in ipairs(SpawnedStuff) do
        DeleteEntity(v)
    end
end)

local function onResourceStartCheck()
    if not receiveFirstServerEvent then
        framework:TriggerCallback('core_gangs:server:isInitializationEnded', function(canAccess)
            if canAccess then
                receiveFirstServerEvent = true
                retrieveDataFirstLoad()
            else
                SetTimeout(1000, function()
                    onResourceStartCheck()
                end)
            end
        end)
    end
end

AddEventHandler("onResourceStart", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    if GetPlayerPed(-1) then
        SetTimeout(1000, function()
            onResourceStartCheck()
        end)
    end
end)


RegisterNetEvent('core_gangs:server:refreshData', function(name, data)
    if name and data then
        if name == 'organisation' then
            Organizations = data
        elseif name == 'zone' then
            Zones = data
        elseif name == 'criminal' then
            Criminals = data
        elseif name == 'bounty' then
            Bounties = data
        end
    end
end)

-- HELPER COMMAND

RegisterCommand('currentzone', function()
    local coords = GetEntityCoords(PlayerPedId())
    print('^1 ZoneID to set in config : ' .. getIndexFromLatLng(coords[1], coords[2]) .. '^7')
end)

-------------
-- EXPORTS --
-------------

local function getZoneFromPlayer()
    local coords = GetEntityCoords(PlayerPedId())
    local zone = getIndexFromLatLng(coords[1], coords[2])
    return zone
end

local function getZoneFromCoords(x, y)
    local zone = getIndexFromLatLng(x, y)
    return zone
end

local function isPlayerInZone(zoneId)
    local zone = getZoneFromPlayer()
    return zone == tonumber(zoneId)
end

local function isPlayerOrganizationZone(zoneId)
    if Organization then
        return Zones[tonumber(zoneId)] and Zones[tonumber(zoneId)].org == Organization
    end
    return false
end

local function getPlayerOrganization()
    return Organization or nil
end

local function isOrganizationZone(orgName, zoneId)
    return Zones[tonumber(zoneId)] and Zones[tonumber(zoneId)].org == orgName or false
end

exports('getCoordsFromZone', getCoordsFromIndex)

exports('getZoneFromPlayer', getZoneFromPlayer)

exports('getZoneFromCoords', getZoneFromCoords)

exports('getPlayerOrganization', getPlayerOrganization)

exports('isPlayerInZone', isPlayerInZone)

exports('isPlayerOrganizationZone',isPlayerOrganizationZone )

exports('isOrganizationZone', isOrganizationZone)
