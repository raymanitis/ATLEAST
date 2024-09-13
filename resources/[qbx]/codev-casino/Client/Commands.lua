if Config.AccessTypes["command"].enabled then 
    RegisterCommand(Config.AccessTypes["command"].command, function (source, args, rawCommand)
        TriggerEvent('ctake:client:open')    
    end)
    TriggerEvent('chat:addSuggestion', '/'..Config.AccessTypes["command"].command, 'Use casino')
end

RegisterCommand('createcasinoprop', function(source, args, raw)
    TriggerServerEvent('ctake:server:permissionCheck')
end)

TriggerEvent('chat:addSuggestion', '/createcasinoprop', 'Create permanent casino prop (Casino admins only)')

RegisterCommand('deletecasinoprop', function ()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local object = GetClosestObjectOfType(coords, 1.0, GetHashKey('qua_ocasino_betmachine'), false, false, false)
    for k,v in pairs(objects) do 
        if v == object then
            TriggerServerEvent('ctake:server:deleteObject', k)
            return
        end
    end
end)

TriggerEvent('chat:addSuggestion', '/deletecasinoprop', 'Delete closest permanent casino object (Casino admins only)')

RegisterNetEvent('ctake:client:createObject', function (obj)
    local obj = "qua_ocasino_betmachine"
    obj = GetHashKey(obj) -- type(obj) == 'number' and obj or
    RequestModel(obj)
    Citizen.Wait(2000)
    if obj and IsModelValid(obj) then
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local obj2 = CreateObject(obj, coords.x, coords.y, coords.z, false, false, true)
        currentObject = obj2
        local objectHeading = GetEntityHeading(currentObject)
        SetEntityAlpha(currentObject, 150, false)
        SetEntityCompletelyDisableCollision(currentObject, false, false)
        Citizen.CreateThread(function()
            while currentObject do
                ShowHelpNotification("Press arrow keys to move the object\nPress ~INPUT_VEH_FLY_ROLL_LEFT_ONLY~ and ~INPUT_VEH_FLY_ROLL_RIGHT_ONLY~ to rotate the object left/right\nPress ~INPUT_VEH_FLY_SELECT_TARGET_LEFT~ to place the object on the ground\nPress ~INPUT_VEH_FLY_SELECT_TARGET_RIGHT~ to place the object on the player\nPress ~INPUT_FRONTEND_ACCEPT~ to save the object")
                local speed = 1
                if IsControlPressed(0, 21) then
                    speed = 5
                else
                    speed = 1
                end
                if IsControlPressed(0, 172) then
                    local objectCoords = GetEntityCoords(currentObject)
                    SetEntityCoords(currentObject, objectCoords.x+(0.01 * speed), objectCoords.y, objectCoords.z)
                end
                if IsControlPressed(0, 173) then
                    local objectCoords = GetEntityCoords(currentObject)
                    SetEntityCoords(currentObject, objectCoords.x-(0.01 * speed), objectCoords.y, objectCoords.z)
                end

                if IsControlPressed(0, 174) then
                    local objectCoords = GetEntityCoords(currentObject)
                    SetEntityCoords(currentObject, objectCoords.x, objectCoords.y-(0.01 * speed), objectCoords.z)
                end
                if IsControlPressed(0, 175) then
                    local objectCoords = GetEntityCoords(currentObject)
                    SetEntityCoords(currentObject, objectCoords.x, objectCoords.y+(0.01 * speed), objectCoords.z)
                end

                if IsControlPressed(0, 111) then
                    local objectCoords = GetEntityCoords(currentObject)
                    SetEntityCoords(currentObject, objectCoords.x, objectCoords.y, objectCoords.z+(0.01 * speed))
                end
                if IsControlPressed(0, 110) then
                    local objectCoords = GetEntityCoords(currentObject)
                    SetEntityCoords(currentObject, objectCoords.x, objectCoords.y, objectCoords.z-(0.01 * speed))
                end

                if IsControlPressed(0, 108) then
                    objectHeading = GetEntityHeading(currentObject)
                    SetEntityHeading(currentObject, objectHeading-(0.2 * speed))
                end
                if IsControlPressed(0, 109) then
                    objectHeading = GetEntityHeading(currentObject)
                    SetEntityHeading(currentObject, objectHeading+(0.2 * speed))
                end

                if IsControlPressed(0, 117) then
                    PlaceObjectOnGroundProperly(currentObject)
                    local objectCoords = GetEntityCoords(currentObject)
                    SetEntityCoords(currentObject, objectCoords)
                end
                if IsControlPressed(0, 118) then
                    SetEntityCoords(currentObject, GetEntityCoords(PlayerPedId()))
                    SetEntityHeading(currentObject, 0.0)
                end
                if IsControlJustReleased(0, 201) then
                    local objectCoords = GetEntityCoords(currentObject)
                    TriggerServerEvent('ctake:server:saveObject', objectCoords, objectHeading)
                    DeleteObject(currentObject)
                    currentObject = nil
                end
                Citizen.Wait(0)
            end
        end)
    end
end)
