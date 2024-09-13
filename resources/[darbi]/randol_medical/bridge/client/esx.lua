if GetResourceState('es_extended') ~= 'started' then return end

Config = require 'shared'
ESX = exports['es_extended']:getSharedObject()
PlayerData = {}

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    ESX.PlayerLoaded = true
    SetTimeout(1000, function()
        onPlayerLoaded()
        initJobStuff()
    end)
end)

RegisterNetEvent('esx:onPlayerLogout', function()
    table.wipe(PlayerData)
    ESX.PlayerLoaded = false
    onUnload()
    clearJobStuff()
end)

function hasPlyLoaded()
    return ESX.PlayerLoaded
end

function DoNotification(text, nType)
    lib.notify({ title = "Notification", description = text, type = nType, })
end

function GetPlayerJob()
    return PlayerData.job.name
end

function GetJobGrade()
    return PlayerData.job.grade
end

function toggleFrameworkDeath(bool)
    ESX.SetPlayerData('dead', bool)
end

AddEventHandler('esx:setPlayerData', function(key, value)
	PlayerData[key] = value
end)

AddEventHandler('onResourceStart', function(res)
    if GetCurrentResourceName() ~= res or not hasPlyLoaded() then return end
    PlayerData = ESX.PlayerData
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle') -- From esx_ambulancejob
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local vehicle, distance = ESX.Game.GetClosestVehicle()

	if vehicle and distance < 5 then
		local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

		for i = maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat then
			TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
		end
	end
end)