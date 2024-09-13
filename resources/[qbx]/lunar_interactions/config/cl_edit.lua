function SearchInventory(targetId)
    if not LR.progressBar(locale('searching'), 3000, false, {
        dict = 'missbigscore2aig_7@driver',
        clip = 'boot_r_loop',
        flag = 1
    }) then return end
    
    if Framework.name == 'es_extended' then
        exports.ox_inventory:openInventory('player', targetId)
    else
        exports.ox_inventory:openInventory('player', targetId)
    end
end

---@param type 'handcuffs' | 'zipties'
function OnCuffingPlayer(type)
    --ExecuteCommand('me Putting on handcuffs')
end

---@param type 'handcuffs' | 'zipties'
function OnUncuffingPlayer(type)
    --ExecuteCommand('me Taking off handcuffs')
end

function OnDraggingPlayer()
    --ExecuteCommand('me Dragging person')
end

function OnCarryPlayer()

end

function OnTakeHostage()

end

function OnPutInVehicle()

end

function OnTakingOutOfVehicle()

end

-- Ran inside a loop
function OnCarrying()
    DisableControlAction(0, 25, true)
    DisablePlayerFiring(cache.playerId, true)
end

-- Ran inside a loop
function OnDragging()
    DisableControlAction(0, 21)
    SetPlayerSprint(cache.playerId, false)
end

function OnBreakingHandcuffs()

end

function HandcuffedControls()
    DisableControlAction(0, 24, true) --Attack
    DisableControlAction(0, 257, true) --Attack 2
    DisableControlAction(0, 25, true) --Aim
    DisableControlAction(0, 263, true) --Melee Attack 1
    DisableControlAction(0, 45, true) --Reload
    DisableControlAction(0, 44, true) --Cover
    DisableControlAction(0, 37, true) --Select Weapon
    DisableControlAction(0, 23, true) --Also 'enter' ?
    DisableControlAction(0, 288, true) --Disable phone
    DisableControlAction(0, 289, true) --Inventory
    DisableControlAction(0, 170, true) --Animations
    DisableControlAction(0, 167, true) --Job
    DisableControlAction(0, 0, true) --Disable changing view
    DisableControlAction(0, 26, true) --Disable looking behind
    DisableControlAction(0, 73, true) --Disable clearing animation
    DisableControlAction(2, 199, true) --Disable pause screen
    DisableControlAction(0, 59, true) --Disable steering in vehicle
    DisableControlAction(0, 71, true) --Disable driving forward in vehicle
    DisableControlAction(0, 72, true) --Disable reversing in vehicle
    DisableControlAction(2, 36, true) --Disable going stealth
    DisableControlAction(0, 47, true) --Disable weapon
    DisableControlAction(0, 264, true) --Disable melee
    DisableControlAction(0, 257, true) --Disable melee
    DisableControlAction(0, 140, true) --Disable melee
    DisableControlAction(0, 141, true) --Disable melee
    DisableControlAction(0, 142, true) --Disable melee
    DisableControlAction(0, 143, true) --Disable melee
    DisableControlAction(0, 75, true) --Disable exit vehicle
    DisableControlAction(27, 75, true) --Disable exit vehicle
end

-- You can add custom canInteract handler here
CanInteractFilter = {
    -- ['steal'] = function(entity)
    --     return IsDead(entity)
    --         or IsEntityPlayingAnim(entity, 'dead', 'dead_a', 3)
    --         or IsPedCuffed(entity)
    --         or IsEntityPlayingAnim(entity, 'mp_arresting', 'idle', 3)
    --         or IsEntityPlayingAnim(entity, 'missminuteman_1ig_2', 'handsup_base', 3)
    --         or IsEntityPlayingAnim(entity, 'missminuteman_1ig_2', 'handsup_enter', 3)
    --         or IsEntityPlayingAnim(entity, 'random@mugging3', 'handsup_standing_base', 3)
    -- end
    ['break_handcuffs'] = function(entity)
        return IsPedCuffed(entity) and (not Config.BreakHandcuffsItem.name or Framework.hasItem(Config.BreakHandcuffsItem.name))
    end
}

lib.callback.register('lunar_interactions:skillCheck', function()
    return lib.skillCheck({ 'easy', 'easy', 'medium', 'medium', 'hard' }, { 'e' })
end)

---@param ped number
function IsDead(ped)
    return IsEntityDead(ped)
        or IsEntityPlayingAnim(ped, 'dead', 'dead_a', 3)
end

StopKeybind = lib.addKeybind({
    defaultKey = 'g',
    name = 'stop_interactions',
    description = 'Stop interaction (carrying, dragging)',
    onReleased = function()
        StopDrag()
        StopCarry()
        StopTakeHostage()
    end
})