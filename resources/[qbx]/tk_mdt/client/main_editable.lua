local doingProgress = false

---@class FineData
---@field targetIdentifier string
---@field amount number

---@param data FineData
function FinePlayer(data)

end

---@class JailData
---@field targetIdentifier string
---@field time number

---@param data JailData
function JailPlayer(data)
    if Config.Jail == 'tk' then
        exports.tk_jail:jail(data.targetIdentifier, data.time)
    elseif Config.Jail == 'pickle' then
        TriggerServerEvent('tk_mdt:jailPlayer', data)
    end
end

local function StopProgress(ped, anim, obj, ptfx)
    if DoesEntityExist(obj) then DeleteEntity(obj) end

    if anim then
        ClearPedTasks(ped)
    end

    if ptfx then
        StopParticleFxLooped(ptfx, false)
    end

    doingProgress = false
end

function DoProgress(anim, duration)
    local ped = PlayerPedId()

    if doingProgress or IsPedInAnyVehicle(ped, true) or IsEntityDead(ped) or IsPedHandcuffed(ped) then return end
    doingProgress = true

    anim = type(anim) == 'table' and anim[math.random(#anim)] or anim

    if anim?.dict and not LoadDict(anim.dict) then return end

    duration = anim?.duration or duration or 5000
    local startTime = GetGameTimer()
    local controls = {20, 21, 30, 31, 32, 33, 34, 35, 24, 48, 257, 25, 263, 22, 44, 37, 288, 289, 170, 167, 318, 137, 36, 47, 264, 257, 266, 267, 268, 269, 140, 141, 142, 143, 75, 73}

    local obj, ptfx

    if anim?.prop?.model then
        if not LoadModel(anim.prop.model) then return end

        local pos = anim.prop.pos or vec3(0.0, 0.0, 0.0)
        local rot = anim.prop.rot or vec3(0.0, 0.0, 0.0)

        local pC = GetEntityCoords(ped)
        obj = CreateObject(anim.prop.model, pC.x, pC.y, pC.z + 0.2, true, true, true)
        AttachEntityToEntity(obj, ped, GetPedBoneIndex(ped, anim.prop.bone), pos, rot, true, true, false, true, 1, true)
    end

    if anim?.ptfx?.name then
        if not LoadPtfx(anim.ptfx.asset) then return end

        local offset = anim.ptfx.offset vec3(0.0, 0.0, 0.0)
        local rot = anim.ptfx.rot or vec3(0.0, 0.0, 0.0)
        local color = anim.ptfx.color or {r = 1.0, g = 1.0, b = 1.0}

        UseParticleFxAsset(anim.ptfx.asset)
        ptfx = StartNetworkedParticleFxLoopedOnEntityBone(anim.ptfx.name, obj, offset, rot, GetEntityBoneIndexByName(anim.ptfx.name, 'VFX'), anim.ptfx.scale, false, false, false)
        SetParticleFxLoopedColour(ptfx, color.r, color.g, color.b, false)
    end

    if anim?.scenario then
        TaskStartScenarioInPlace(ped, anim.scenario, 0, true)
    end

    while true do
        for _,v in pairs(controls) do DisableControlAction(0, v, true) end

        if anim?.dict and anim?.name and not IsEntityPlayingAnim(ped, anim.dict, anim.name, 3) then
            TaskPlayAnim(ped, anim.dict, anim.name, 2.0, 2.0, -1, anim.flag or 49, 0, false, false, false)
        end

        if IsDisabledControlJustPressed(0, 73) or IsEntityDead(ped) then
            StopProgress(ped, anim, obj, ptfx)
            return false
        end

        if startTime + duration < GetGameTimer() then
            StopProgress(ped, anim, obj, ptfx)
            return true
        end

        Wait(0)
    end
end

local function GetLineCount(str)
    local lines = 1
    for i = 1, #str do
        local c = str:sub(i, i)
        if c == '\n' then lines = lines + 1 end
    end

    return lines
end

function Draw3DText(coords, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 410
    local lineCount = GetLineCount(text)
    DrawRect(0.0, 0.0+0.0125*lineCount, 0.017+factor, 0.03*lineCount, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function Notify(text, notifyType)
    if Config.NotificationType == 'mythic' then
        exports['mythic_notify']:DoHudText(notifyType, text)
    else
        ShowNotification(text, notifyType)
    end
end

function DisplayHelpText(text)
    AddTextEntry('help_text', text)
    DisplayHelpTextThisFrame('help_text', false)
end

function ShowTextUI(text)
    if Config.UseOxLib then
        lib.showTextUI(text, {position = 'right-center'})
    else
        exports['qb-core']:DrawText(text, 'left')
    end
end

function HideTextUI()
    if Config.UseOxLib then
        lib.hideTextUI()
    else
        exports['qb-core']:HideText()
    end
end

function OxRemoveBoxZone(zone)
    exports.ox_target:removeZone(zone)
end

function OxAddBoxZone(options)
    return exports.ox_target:addBoxZone(options)
end

function OxAddLocalEntity(entity, options)
    return exports.ox_target:addLocalEntity(entity, options)
end

function OxRemoveLocalEntity(entity)
    exports.ox_target:removeLocalEntity(entity)
end

function GetVehicleName(vehModel)
    vehModel = tonumber(vehModel)
    local make = GetLabelText(GetMakeNameFromVehicleModel(vehModel))
    local model = GetLabelText(GetDisplayNameFromVehicleModel(vehModel))
    return('%s %s'):format(make, model)
end