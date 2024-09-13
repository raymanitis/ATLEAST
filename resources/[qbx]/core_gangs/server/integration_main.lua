--- Funciton trigger when zone war end, you can trigger any additionnal event you wnat in it
--- @param winnerInfo table { organization = name, score = 1000, playersInvolved = { [identifier] = score, [identifier] = score  ...} }
--- @param loserInfo table { [organizationName] = { organization = name, score = 250, playersInvolved = { [identifier] = score, [identifier] = score  ...}, ... }
function onWarEnd(winnerInfo, loserInfo)
    -- print('winner data :', json.encode(winnerInfo, { indent = true}))
    -- print('loser data :', json.encode(loserInfo, { indent = true}))
end

--- Function to check the police number, add your event / custom code here
--- @return true if amount is reach, false if not
function checkPoliceAmount()
    return true
end

--- Function to trigger dispatch alert
--- @param x number coords x of the zone where the war was start (center of the zone)
--- @param y number coords y of the zone where the war was start (center of the zone)
--- @param zoneid number id of the zone where the war was start
--- @param source number source id of the player who trigger the alert
function callDispatch(x, y, zoneId, source)
    -- core dispatch exemple
    --[[TriggerEvent(
        "core_dispatch:addCall",
        "10-71",
        "Gang war start in area",
        {{icon = "fa-venus-mars", info = "Gang"}},
        {x, y, 90.0},
        "police",
        5000,
        156,
        1,
        false
        )
    ]]--
    -- QS dispatch exemple
    --[[
        TriggerEvent('qs-dispatch:server:CreateDispatchCall', {
            job = { 'police', 'sheriff', 'traffic', 'patrol' },
            callLocation = vector3(x, y, 90.0),
            callCode = { code = '10-71', snippet = '10-71' },
            message = "Gang war start in area",
            flashes = false,
            blip = {
                sprite = 156, --blip sprite
                scale = 1.5, -- blip scale
                colour = 1, -- blip colour
                flashes = true, -- blip flashes
                text = 'Gang War', -- blip text
                time = (20 * 1000),
            },
            otherData = {
                {
                    text = 'Gang', -- text of the other data item (can add more than one)
                    icon = 'fas fa-venus-mars', -- icon font awesome https://fontawesome.com/icons/
                }
            }
        })
    ]]
    -- ps dispatch exemple
    --[[
        local dispatchData = {
            message = 'Gang war start in area',
            codeName = 'vehicleshots',
            code = '10-71',
            icon = 'fas fa-venus-mars',
            priority = 2,
            coords = vector3(x, y, 90.0),
            jobs = { 'leo' }
        }

        TriggerEvent('ps-dispatch:server:notify', dispatchData)
    ]]
end
