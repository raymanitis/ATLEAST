Config = {}

Config.DisplaySettings = {
    time = 15000, -- time in ms for the ped being displayed
    license = true -- set this to false so it wont show the license
}


Config.PedSettings = {
    collision = false, --set true to enable the ped collision
    pedAlpha = 200, --invisibility of the ped, 0 to 255
    boardAlpha = 200, --invisibility of the board, 0 to 255
    drawText = true --disabling this wont draw a 3d text
}

Locales = {
    ["pressinfo"] = "[~b~E~w~] Kopet ~y~Info",
    ["detailClipboard"] = "Speletaja info nokopets"
}

function DrawNotify(text, type)
    --Depending on your notification system you can work with type
    -- There are 3 types
    -- "error"
    -- "success"
    -- nil (for information))

    SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(0,1)
end

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 170)
    ClearDrawOrigin()
end