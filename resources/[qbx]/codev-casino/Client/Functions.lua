Citizen.CreateThread(function()
	if GetResourceState("qb-core") == "started" then
		Framework = exports['qb-core']:GetCoreObject()
	elseif GetResourceState("es_extended") == "started" then
		Framework = exports['es_extended']:getSharedObject()
	else 
		if Config.Debug then print("[CODEV-CASINO] [ERROR] No framework found, please add yours to editable files.") end
	end
end)

---@param msg string
function ShowHelpNotification(msg)
    AddTextEntry('esxHelpNotification', msg)
	DisplayHelpTextThisFrame('esxHelpNotification', false)
end

---@param x float
---@param y float
---@param z float
---@param text string
function drawText3D(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

if Config.AccessTypes["object"].enabled then
	Props = Config.AccessTypes["object"].objects
	if Config.AccessTypes["object"].useOption == "target" then 
		if Config.Debug then print("[CODEV-CASINO] [INFO] Using target option.") end
		CreateThread(function()
			exports['ox_target']:addModel(Props, {
				{
					icon = "fas fa-credit-card",
					label = "Enter Casino",
					onSelect = function()
						TriggerEvent('ctake:client:open')
					end,
				}
			}, {
				distance = 1.5
			})
			
		end)
	elseif Config.AccessTypes["object"].useOption == "drawtext" then
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(0)
				local ped = PlayerPedId()
				local coords = GetEntityCoords(ped)
				for k,v in pairs(Props) do
					local object = GetClosestObjectOfType(coords, 1.0, GetHashKey(v), false, false, false)
					if object ~= 0 then
						local objectCoords = GetEntityCoords(object)
						local distance = #(coords - objectCoords)
						if distance < 2.5 then
							drawText3D(objectCoords.x, objectCoords.y, objectCoords.z, '~g~[Main (Default: E)]~w~ Enter Casino')
							if IsControlJustPressed(0, 38) then
								TriggerEvent('ctake:client:open')
							end
						end
					end
				end
			end
		end)
	end
end