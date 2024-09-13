local hud = false
local speedometer = false
local QBCore = exports['qb-core']:GetCoreObject()
local isPlayerLoaded = false

-- Detect when player is loaded
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    isPlayerLoaded = true
    hud = true -- Ensure the HUD flag is set to true when player is loaded
    Wait(500) -- Small delay to ensure all data is loaded properly
    SendNUIMessage({action = 'show'})
    UpdateHudValues() -- Update HUD values when the player is loaded

    -- Refresh weapons to ensure they appear on the player's back
    Wait(2000)
    exports["Renewed-Weaponscarry"]:RefreshWeapons()
end)



RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    print("Player unloaded event triggered")
    isPlayerLoaded = false
    SendNUIMessage({action = 'hide'})
    hud = false
end)

RegisterNUICallback('ready', function(data, cb)
    print("NUI is ready")
    if data.show and isPlayerLoaded then 
        Wait(500)
        SendNUIMessage({action = 'show'})
        hud = true
        UpdateHudValues() -- Update HUD values when the NUI is ready
    end
end)

-- Check if player is already loaded when the script is restarted
Citizen.CreateThread(function()
    while QBCore == nil do
        Citizen.Wait(100) -- Wait for QBCore to be initialized
    end

    -- Check if player is loaded when script starts/restarts
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData and next(PlayerData) ~= nil then
        print("Player already loaded on script restart")
        isPlayerLoaded = true
        hud = true
        SendNUIMessage({action = 'show'})
        UpdateHudValues() -- Update HUD values when script is restarted
        exports["Renewed-Weaponscarry"]:RefreshWeapons()
    end
end)

-- Function to update HUD values
function UpdateHudValues()
    if isPlayerLoaded then
        print("Updating HUD values")
        local player = PlayerPedId()
        local health = GetEntityHealth(player) - 100
        local armour = GetPedArmour(player)

        -- QBCore: Fetching hunger and thirst
        local PlayerData = QBCore.Functions.GetPlayerData()
        local hunger = PlayerData.metadata.hunger
        local thirst = PlayerData.metadata.thirst

        -- Ensure values are valid
        if health < 0 then health = 0 end

        -- Send updated values to the HUD
        SendNUIMessage({action = 'health', health = health})
        SendNUIMessage({action = 'armour', armour = armour})
        SendNUIMessage({action = 'food', food = math.ceil(hunger)})
        SendNUIMessage({action = 'water', water = math.ceil(thirst)})

        -- If in a vehicle, update speedometer and fuel
        if IsPedInAnyVehicle(player) then
            local vehicle = GetVehiclePedIsIn(player)
            if GetPedInVehicleSeat(vehicle, -1) == player then
                local fuel = Entity(vehicle).state.fuel or GetVehicleFuelLevel(vehicle)
                local speed = GetEntitySpeed(vehicle)

                SendNUIMessage({action = 'fuel', fuel = fuel})
                SendNUIMessage({action = 'speed', speed = speed})
            end
        end
    end
end

local last = {
    health = -1,
    armour = -1,
    food = -1,
    water = -1,
    fuel = -1,
    speed = -1,
    pause = false
}

Citizen.CreateThread(function()
    while true do
        if hud and isPlayerLoaded then
            local pause = IsPauseMenuActive()
            if pause ~= last.pause then
                if pause then
                    SendNUIMessage({action = 'hide', opacity = 0})
                else
                    SendNUIMessage({action = 'hide', opacity = 1})
                end
                last.pause = pause
            end

            local player = PlayerPedId()
            local health = GetEntityHealth(player) - 100
            local armour = GetPedArmour(player)

            -- QBCore: Fetching hunger and thirst
            local PlayerData = QBCore.Functions.GetPlayerData()
            local hunger = PlayerData.metadata.hunger
            local thirst = PlayerData.metadata.thirst

            if health < 0 then health = 0 end
            if health ~= last.health then 
                SendNUIMessage({action = 'health', health = health}) 
                last.health = health 
            end
            if armour ~= last.armour then 
                SendNUIMessage({action = 'armour', armour = armour}) 
                last.armour = armour 
            end
            if hunger ~= last.food then 
                SendNUIMessage({action = 'food', food = math.ceil(hunger)}) 
                last.food = hunger 
            end
            if thirst ~= last.water then 
                SendNUIMessage({action = 'water', water = math.ceil(thirst)}) 
                last.water = thirst 
            end
        end
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 1000
        if hud and isPlayerLoaded then
            local player = PlayerPedId()
            if IsPedInAnyVehicle(player) then
                local vehicle = GetVehiclePedIsIn(player)
                if GetPedInVehicleSeat(vehicle, -1) == player then
                    wait = 200
                    if not speedometer then
                        SendNUIMessage({action = 'speedometer', speedometer = 'show', metric = Config.Metric})
                        speedometer = true
                    else
                        -- Use Entity(vehicle).state.fuel to get fuel
                        local fuel = Entity(vehicle).state.fuel
                        local speed = GetEntitySpeed(vehicle)

                        -- If no state value for fuel exists, fallback to GetVehicleFuelLevel
                        if not fuel then
                            fuel = GetVehicleFuelLevel(vehicle)
                        end

                        if fuel ~= last.fuel then 
                            SendNUIMessage({action = 'fuel', fuel = fuel}) 
                            last.fuel = fuel 
                        end
                        if speed ~= last.speed then 
                            SendNUIMessage({action = 'speed', speed = speed}) 
                            last.speed = speed 
                        end
                    end
                elseif speedometer then
                    SendNUIMessage({action = 'speedometer', speedometer = 'hide', metric = Config.Metric})
                    speedometer = false
                end
            elseif speedometer then
                SendNUIMessage({action = 'speedometer', speedometer = 'hide', metric = Config.Metric})
                speedometer = false
            end
        elseif speedometer then
            SendNUIMessage({action = 'speedometer', speedometer = 'hide', metric = Config.Metric})
            speedometer = false
        end
        Citizen.Wait(wait)
    end
end)

function seatbelt(toggle)
    SendNUIMessage({action = 'seatbelt', seatbelt = toggle})
end
