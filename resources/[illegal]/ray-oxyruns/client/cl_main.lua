local QBCore = exports['qb-core']:GetCoreObject()

local started = false
local dropOffCount = 0
local hasDropOff = false

local oxyPed = nil
local madeDeal = false

local dropOffBlip = nil

local peds = {
	'a_m_y_stwhi_02',
	'a_m_y_stwhi_01',
	'a_f_y_genhot_01',
	'a_f_y_vinewood_04',
	'a_m_m_golfer_01',
	'a_m_m_soucent_04',
	'a_m_o_soucent_02',
	'a_m_y_epsilon_01',
	'a_m_y_epsilon_02',
	'a_m_y_mexthug_01'
}

--- This function can be used to trigger your desired dispatch alerts
local AlertCops = function()
	local job = "police" -- Jobs that will recive the alert
	local text = "Redzams kā persona tirgo tabletes" -- Main text alert
	local coords = GetEntityCoords(PlayerPedId()) -- Alert coords
	local id = GetPlayerServerId(PlayerId()) -- Player that triggered the alert
	local title = "Oxyrun" -- Main title alert
	local panic = false -- Allow/Disable panic effect
   
	TriggerServerEvent('Opto_dispatch:Server:SendAlert', job, title, text, coords, panic, id)
end

--- Creates a drop off blip at a given coordinate
--- @param coords vector4 - Coordinates of a location
local CreateDropOffBlip = function(coords)
	dropOffBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(dropOffBlip, 51)
    SetBlipScale(dropOffBlip, 1.0)
    SetBlipAsShortRange(dropOffBlip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Deliver")
    EndTextCommandSetBlipName(dropOffBlip)
end

--- Creates a drop off ped at a given coordinate
--- @param coords vector4 - Coordinates of a location
local CreateDropOffPed = function(coords)
	if oxyPed ~= nil then return end
	local model = peds[math.random(#peds)]
	local hash = GetHashKey(model)

    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(10) end
	oxyPed = CreatePed(5, hash, coords.x, coords.y, coords.z-1, coords.w, true, true)
	while not DoesEntityExist(oxyPed) do Wait(10) end
	ClearPedTasks(oxyPed)
    ClearPedSecondaryTask(oxyPed)
    TaskSetBlockingOfNonTemporaryEvents(oxyPed, true)
    SetPedFleeAttributes(oxyPed, 0, 0)
    SetPedCombatAttributes(oxyPed, 17, 1)
    SetPedSeeingRange(oxyPed, 0.0)
    SetPedHearingRange(oxyPed, 0.0)
    SetPedAlertness(oxyPed, 0)
    SetPedKeepTask(oxyPed, true)
	FreezeEntityPosition(oxyPed, true)
	exports.ox_target:addSphereZone({
		name = "oxy_ped_droppoff",
		coords = vector3(coords.x,coords.y,coords.z),
		size = vec3(1,1,1),
		debug = false,
		drawSprite = false,
		options = {
			{
				type = "client",
				event = "qb-oxyruns:client:DeliverOxy",
				icon = "fas fa-capsules",
				label = "Lag Avtale",
				distance = 2,
			}
		}
	})
end

--- Creates a random drop off location
local CreateDropOff = function()
	hasDropOff = true
	--TriggerEvent('qb-phone:client:CustomNotification', 'CURRENT', "Make your way to the drop-off..", 'fas fa-capsules', '#3480eb', 8000)
	lib.defaultNotify({
		title = "Oxy run",
		description = "Dodieties uz vietu un piegādājiet klientam",
		position = 'top-right',
		icon = "pills",
		iconColor = "#9cde40",
		duration = 10000,
	})
	dropOffCount += 1
	local randomLoc = Config.Locations[math.random(#Config.Locations)]
	-- Blip
	CreateDropOffBlip(randomLoc)
	-- PolyZone
	dropOffArea = CircleZone:Create(randomLoc.xyz, 200.0, {
		name = "dropOffArea",
		debugPoly = false
	})
	dropOffArea:onPlayerInOut(function(isPointInside, point)
		if isPointInside then
			if oxyPed == nil then
				--TriggerEvent('qb-phone:client:CustomNotification', 'CURRENT', "Make the delivery..", 'fas fa-capsules', '#3480eb', 8000)
				lib.defaultNotify({
					title = "Oxy run",
					description = "Piegādāt klientam",
					position = 'top-right',
					icon = "pills",
					iconColor = "#9cde40",
					duration = 5000,
				})
				CreateDropOffPed(randomLoc)
			end
		end
	end)
end

--- Start an oxy run after paying the initial payment
local StartOxyrun = function()
	if started then return end
	started = true
	--TriggerEvent('qb-phone:client:CustomNotification', 'CURRENT', "Wait for a new location..", 'fas fa-capsules', '#3480eb', 8000)
	lib.defaultNotify({
		title = "Oxy run",
		description = "Pagaidiet, kamēr priekšnieks nosūtīs jums atrašanās vietu",
		position = 'top-right',
		icon = "pills",
		iconColor = "#9cde40",
		duration = 5000,
	})
	while started do
		Wait(4000)
		if not hasDropOff then
			Wait(8000)
			CreateDropOff()
		end
	end
end

--- Deletes the oxy ped
local DeleteOxyped = function()
	FreezeEntityPosition(oxyPed, false)
	SetPedKeepTask(oxyPed, false)
	TaskSetBlockingOfNonTemporaryEvents(oxyPed, false)
	ClearPedTasks(oxyPed)
	TaskWanderStandard(oxyPed, 10.0, 10)
	SetPedAsNoLongerNeeded(oxyPed)
	Wait(20000)
	DeletePed(oxyPed)
	oxyPed = nil
end

RegisterNetEvent("qb-oxyruns:client:StartOxy", function()
	if started then return end
	QBCore.Functions.TriggerCallback('qb-oxyruns:server:StartOxy', function(canStart)
	--lib.callback.register('qb-oxyruns:server:StartOxy', function(canStart) --kanskje senere
		if canStart then
			StartOxyrun()
		end
	end)
end)
RegisterNetEvent('qb-oxyruns:client:DeliverOxy', function()
	if madeDeal then return end
	local ped = PlayerPedId()
				    local coords = GetEntityCoords(PlayerPedId())
				local substreet = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
				local streetname = GetStreetNameFromHashKey(substreet)
	if not IsPedOnFoot(ped) then return end
	if #(GetEntityCoords(ped) - GetEntityCoords(oxyPed)) < 5.0 then
		-- Anti spam
		madeDeal = true
		exports['qb-target']:RemoveTargetEntity(oxyPed)

		-- Face each other
		TaskTurnPedToFaceEntity(oxyPed, ped, 1.0)
		TaskTurnPedToFaceEntity(ped, oxyPed, 1.0)
		Wait(1500)
		PlayAmbientSpeech1(oxyPed, "Generic_Hi", "Speech_Params_Force")
		Wait(1000)

		-- Playerped animation
		RequestAnimDict("mp_safehouselost@")
    	while not HasAnimDictLoaded("mp_safehouselost@") do Wait(10) end
    	TaskPlayAnim(ped, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
		Wait(800)
		
		-- Oxyped animation
		PlayAmbientSpeech1(oxyPed, "Chat_State", "Speech_Params_Force")
		Wait(500)
		RequestAnimDict("mp_safehouselost@")
		while not HasAnimDictLoaded("mp_safehouselost@") do Wait(10) end
		TaskPlayAnim(oxyPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
		Wait(3000)

		-- Remove blip
		RemoveBlip(dropOffBlip)
		dropOffBlip = nil

		-- Reward
		lib.callback('qb-oxyruns:server:Reward')

		-- Menti
		AlertCops()

		-- Finishing up
		dropOffArea:destroy()
		exports.ox_target:removeZone(oxy_ped_droppoff)
		Wait(2000)
		if dropOffCount == Config.RunAmount then
			--TriggerEvent('qb-phone:client:CustomNotification', 'CURRENT', "You are done delivering, go back to the pharmacy..", 'fas fa-capsules', '#3480eb', 20000)
			lib.defaultNotify({
				title = "Oxyrun",
				description = "Jūs esat pabeidzis piegādi",
				position = 'top-right',
				icon = "pills",
				iconColor = "#9cde40",
				duration = 10000,
			})
			started = false
			dropOffCount = 0
		else
			--TriggerEvent('qb-phone:client:CustomNotification', 'CURRENT', "Delivery was good, you will be updated with the next drop-off..", 'fas fa-capsules', '#3480eb', 20000)
			lib.defaultNotify({
				title = "Oxyrun",
				description = "Good shit... Pagaidiet līdz nākamajai vietai",
				position = 'top-right',
				icon = "pills",
				iconColor = "#9cde40",
				duration = 5000,
			})
		end
		DeleteOxyped()
		hasDropOff = false
		madeDeal = false
	end
end)

CreateThread(function()
	-- Starter Ped
	local pedModel = `g_m_m_chemwork_01`
	RequestModel(pedModel)
	while not HasModelLoaded(pedModel) do Wait(10) end
	local ped = CreatePed(0, pedModel, Config.StartLocation.x, Config.StartLocation.y, Config.StartLocation.z-1.0, Config.StartLocation.w, false, false)
	TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD', true)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	-- Target
	exports['qb-target']:AddTargetEntity(ped, {
		options = {
			{
				type = "client",
				event = "qb-oxyruns:client:StartOxy",
				icon = 'fas fa-capsules',
				label = 'Sākt oxyrun ('..Config.StartOxyPayment..'$)',
			}
		},
		distance = 2.0
	})
end)

--RegisterCommand("testOxy", function()
--	TriggerEvent("qb-oxyruns:server:StartOxy")
--end)
