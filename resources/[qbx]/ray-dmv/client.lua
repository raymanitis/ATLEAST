local hasStartedDMVTest = false

function ShowDMVStartDialog()
    -- Simple confirmation dialog to start the DMV test
    local input = lib.alertDialog({
        header = 'CSDD tests',
        content = 'Tests izmaksā 500$ vai esi pārliecināts ka vēlies to sākt?',
        centered = true,
        cancel = true, -- Enable a cancel button
        labels = { confirm = 'Sākt', cancel = 'Atcelt' }
    })

    if input == 'confirm' then
        -- Player confirmed to start the test, trigger server to check license
        TriggerServerEvent('qbx_dmvtest:checkLicenseBeforeStart')
    else
        print("Player declined to start the DMV Test.")
        lib.notify({description = "Tu atteicies sākt CSDD testu.", type = 'inform'})
    end
end

-- Register client-side event to start the test after the server confirms no license
RegisterNetEvent('qbx_dmvtest:allowTestStart', function()
    StartDMVTest() -- Start the DMV test after server confirms no license
end)


-- Start DMV Test Function
function StartDMVTest()
    -- if hasStartedDMVTest then
    --     print("You are already taking the DMV test.")
    --     return
    -- end

    hasStartedDMVTest = true
    local mistakes = 0

    -- Start the first question
    ShowQuestion(1, mistakes)
end

-- Function to Show a Question using ox_lib input dialog with select type
function ShowQuestion(questionIndex, mistakes)
    -- Get the question data from Config
    local questionData = Config.Questions[questionIndex]
    local question = questionData.question
    local answers = questionData.answers

    -- Use the ox_lib input dialog for showing the question and options (select type)
    local input = lib.inputDialog('CSDD tests', {
        {type = 'select', label = question, options = {
            {label = answers[1], value = 1},
            {label = answers[2], value = 2},
            {label = answers[3], value = 3}
        }, description = 'Izvēlies pareizo atbildi', required = true}
    })

    -- Handle user input
    if input then
        local selectedAnswer = tonumber(input[1]) -- Get the selected answer (value corresponds to option selected)
        local correctAnswer = questionData.correctAnswer

        -- Check if the selected answer is correct
        if selectedAnswer ~= correctAnswer then
            mistakes = mistakes + 1
            lib.notify({description = "Nepareizi draudziņ!", type = 'error'})
        else
            lib.notify({description = "Pareiza atbilde!", type = 'success'})
        end

        -- Check if the player has failed the test
        if mistakes > Config.MaxMistakes then
            lib.notify({description = "Tu izgāzies testā!", type = 'error'})
            hasStartedDMVTest = false
            return
        end

        -- Move to the next question or finish the test
        if questionIndex == #Config.Questions then
            lib.notify({description = "Apsveicu, tu nokārtoji testu, tiesības ir kabatās!", type = 'success'})
            TriggerServerEvent('qbx_dmvtest:grantLicense') -- Grant license on success
            hasStartedDMVTest = false
        else
            ShowQuestion(questionIndex + 1, mistakes) -- Move to the next question
        end
    else
        lib.notify({description = "Tu atcēli testu.", type = 'inform'})
        hasStartedDMVTest = false
    end
end

-- Register client-side event to start the test after the server confirms
RegisterNetEvent('qbx_dmvtest:startDMVTest', function()
    StartDMVTest() -- Start the DMV test after confirmation
end)

-- Spawn the DMV ped
Citizen.CreateThread(function()
    local pedModel = GetHashKey(Config.DMVPed.model)
    
    -- Request the ped model
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(100)
    end
    
    -- Create the ped
    local ped = CreatePed(4, pedModel, Config.DMVPed.location.x, Config.DMVPed.location.y, Config.DMVPed.location.z, Config.DMVPed.location.heading, false, true)
    SetEntityAsMissionEntity(ped, true, true)
    SetEntityInvincible(ped, true)  -- Make ped invincible
    SetBlockingOfNonTemporaryEvents(ped, true)  -- Prevent reactions
    FreezeEntityPosition(ped, true)  -- Freeze in place

    -- Apply animation to the ped
    if Config.DMVPed.animation then
        RequestAnimDict(Config.DMVPed.animation.dict)
        while not HasAnimDictLoaded(Config.DMVPed.animation.dict) do
            Wait(100)
        end
        TaskPlayAnim(ped, Config.DMVPed.animation.dict, Config.DMVPed.animation.name, 8.0, 1.0, -1, Config.DMVPed.animation.flag, 0, false, false, false)
    end

    -- Set up ox_target for the ped using onSelect, no progress bar
    exports.ox_target:addLocalEntity(ped, {{
        name = 'start_dmv_test',
        icon = 'fa-solid fa-car',
        label = 'CSDD tests',
        distance = 2.5,
        onSelect = function()
            ShowDMVStartDialog()  -- Show the confirmation dialog before starting
        end
    }})
end)
