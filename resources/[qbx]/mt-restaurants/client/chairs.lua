local sitting = false
local tpCoords = nil

sitChair = function(coords)
    if sitting then return end

    tpCoords = GetEntityCoords(cache.ped)
    currentScenario = 'PROP_HUMAN_SEAT_CHAIR_MP_PLAYER'
    TaskStartScenarioAtPosition(cache.ped, currentScenario, coords.x, coords.y, coords.z, coords.w, 0, 1, true)

    sitting = true
    CreateThread(function()
        while sitting do
            Wait(0)
            showTextUI(locale('textui_sit_get_up'), Config.textuiPos)
            if IsControlJustPressed(0, Config.sitsGetUpKey) or (not IsPedUsingScenario(cache.ped, currentScenario)) then
               sitting = false
               hideTextUI()
               ClearPedTasks(cache.ped)
               SetEntityCoords(cache.ped, tpCoords.x, tpCoords.y, tpCoords.z - 0.3)
               break
            end
        end
    end)
end