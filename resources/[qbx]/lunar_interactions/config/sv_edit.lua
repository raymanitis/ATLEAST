---@param source number
---@return boolean success Returning true continues the action
function OnHijackVehicle(source)
    local player = Framework.getPlayerFromId(source)
    if not player or (Jobs['hijack'] and not Jobs['hijack'][player:getJob()]) then return false end

    -- You can add your own code here

    Pending[source] = true --Pending[source] needs to be true or the vehicle action won't work
    return true
end

---@param source number
---@return boolean success Returning true continues the action
function OnRepairVehicle(source)
    local player = Framework.getPlayerFromId(source)
    if not player or (Jobs['repair'] and not Jobs['repair'][player:getJob()]) then return false end

    -- An example of requiring an item.
    if player:getItemCount('fixkit') >= 0 then
        player:removeItem('fixkit', 1)
        Pending[source] = true --Pending[source] needs to be true or the vehicle action won't work
        return true
    end

    return false
end

---@param source number
---@return boolean success Returning true continues the action
function OnCleanVehicle(source)
    local player = Framework.getPlayerFromId(source)
    if not player or (Jobs['clean'] and not Jobs['clean'][player:getJob()]) then return false end

    -- You can add your own code here

    Pending[source] = true --Pending[source] needs to be true or the vehicle action won't work
    return true
end

---@param source number
---@return boolean success Returning true continues the action
function OnImpoundVehicle(source)
    local player = Framework.getPlayerFromId(source)
    if not player or (Jobs['impound'] and not Jobs['impound'][player:getJob()]) then return false end

    -- You can add your own code here

    Pending[source] = true --Pending[source] needs to be true or the vehicle action won't work
    return true
end

function PlayerCuffStateChanged(source, targetId, state, type)
    if Config.HandcuffsSkillCheck and state then

        lib.callback('lunar_interactions:skillCheck', targetId, function(success)
            if success then
                Wait(700)
                exports['lunar_interactions']:uncuff(targetId)
                LR.notify(source, locale('player_refused'), 'error')
            end
        end)
    end

    -- AN EXAMPLE OF PLAYING CUFF SOUNDS
    -- local coords = GetEntityCoords(GetPlayerPed(source))
    -- if state then
    --     if type == 'handcuff' then
    --         exports.xsound:PlayUrlPos(-1, 'cuff', './sounds/cuff.ogg', 0.5, coords, false)
    --     else
    --         exports.xsound:PlayUrlPos(-1, 'ziptie', './sounds/ziptie.ogg', 0.5, coords, false)
    --     end
    -- else
    --     if type == 'handcuff' then
    --         exports.xsound:PlayUrlPos(-1, 'uncuff', './sounds/uncuff.ogg', 0.5, coords, false)
    --     else
    --         exports.xsound:PlayUrlPos(-1, 'cut', './sounds/cut.ogg', 0.5, coords, false)
    --     end
    -- end
end