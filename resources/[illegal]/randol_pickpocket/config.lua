return {
    ProgressTime = 5000,
    Cooldown = {
        enable = true,
        time = 30, -- seconds
    },
    BlacklistedJobs = {
        police = true,
        ambulance = true,
    },
    AlertPolice = function(coords)
        if math.random() > 0.1 then return end -- low alert chance by default.
        local job = "police" -- Jobs that will recive the alert
        local text = "Kāds redzējis kā garām gājējs no kabatas civilpersonai kaut ko paņem" -- Main text alert
        local coords = GetEntityCoords(PlayerPedId()) -- Alert coords
        local id = GetPlayerServerId(PlayerId()) -- Player that triggered the alert
        local title = "Apzagta civilpersona" -- Main title alert
        local panic = false -- Allow/Disable panic effect
       
        TriggerServerEvent('Opto_dispatch:Server:SendAlert', job, title, text, coords, panic, id)
    end,
}