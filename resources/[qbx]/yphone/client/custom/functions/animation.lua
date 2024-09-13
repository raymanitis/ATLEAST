local animPrefix = 'cellphone_'
local playerPhones = {}
local playerState = LocalPlayer.state

Animation = {
    OpenPhone = function()
        DoPhoneAnimation(animPrefix .. 'text_in')
    end,
    ClosePhone = function()
        DoPhoneAnimation(animPrefix .. 'text_out')

        Animation.Reset()
    end,
    TextToCall = function()
        DoPhoneAnimation(animPrefix .. 'text_to_call')
    end,
    CallToText = function()
        DoPhoneAnimation(animPrefix .. 'call_to_text')
    end,
    PocketToCall = function()
        DoPhoneAnimation(animPrefix .. 'call_listen_base')
    end,
    CallToPocket = function()
        DoPhoneAnimation(animPrefix .. 'call_out')

        Animation.Reset()
    end,
    Selfie = function()
        DoPhoneAnimation('selfie', 'self')
    end,
    SelfieIn = function()
        DoPhoneAnimation('selfie_in', 'self')
    end,
    SelfieOut = function()
        DoPhoneAnimation('selfie_out', 'self')
    end,
    Reset = function(immediately)
        SetTimeout(immediately and 0 or 500, function()
            StopAnimTask(PlayerPedId(), PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 2.5)

            ClearPedTasks(PlayerPedId())

            DeletePhone()
        end)

        PhoneData.AnimationData.lib = nil
        PhoneData.AnimationData.anim = nil
    end,
}

local function checkAnimationLoop()
    CreateThread(function()
        while PhoneData.AnimationData.lib ~= nil and PhoneData.AnimationData.anim ~= nil do
            local ped = PlayerPedId()
            if not IsEntityPlayingAnim(ped, PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 3) then
                lib.playAnim(ped, PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 3.0, 3.0, -1, 50, 0, false,
                    false, false)
            end
            Wait(500)
        end
    end)
end

local function createPhoneProp(ped, model)
    lib.requestModel(model)

    local coords = GetEntityCoords(ped)
    local phone = CreateObject(model, coords.x, coords.y, coords.z, false, false, false)

    local zRot = (string.find(model, "fold") and not PhoneFolded) and 200.0 or 180.0

    AttachEntityToEntity(phone, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, zRot, true, true, false, true,
        2, true)
    SetModelAsNoLongerNeeded(model)

    return phone
end

local function deletePhoneProp(serverId)
    local phone = playerPhones[serverId]

    if DoesEntityExist(phone) then
        DeleteEntity(phone)
    end
end

AddStateBagChangeHandler('phoneProp', '', function(bagName, key, value, reserved, replicated)
    if replicated then return end

    local player = GetPlayerFromStateBagName(bagName)
    if player == 0 then return end

    local ped = GetPlayerPed(player)
    local serverId = GetPlayerServerId(player)

    if not value then
        return deletePhoneProp(serverId)
    end

    playerPhones[serverId] = createPhoneProp(ped, value)
end)

RegisterNetEvent('onPlayerDropped', function(serverId)
    deletePhoneProp(serverId)
end)

-- Prop sync
function PhoneModelSync()
    DeletePhone()

    local hash = GetPhoneModelHash()
    playerState:set('phoneProp', hash, true)
end

function DeletePhone()
    playerState:set('phoneProp', nil, true)
end

function DoPhoneAnimation(anim, extraDict, ovverride)
    local ped = PlayerPedId()
    local AnimationLib = 'cellphone@'
    local AnimationStatus = anim

    if IsPedInAnyVehicle(ped, false) then
        AnimationLib = 'anim@cellphone@in_car@ps'
    end

    if extraDict then
        if ovverride then
            AnimationLib = extraDict
        else
            AnimationLib = AnimationLib .. extraDict
        end
    end

    lib.playAnim(ped, AnimationLib, AnimationStatus, 3.0, 3.0, -1, 50, 0, false, false, false)

    PhoneData.AnimationData.lib = AnimationLib
    PhoneData.AnimationData.anim = AnimationStatus

    checkAnimationLoop()
end
