local Ran = false
AddEventHandler("playerSpawned", function()
	if not Ran then
		ShutdownLoadingScreenNui()
		Ran = true
	end
end)

CreateThread(function()
    while true do
        if NetworkIsPlayerActive(PlayerId()) then
			TriggerEvent('qb-multicharacter:client:chooseChar')
			ShutdownLoadingScreen()
			ShutdownLoadingScreenNui()
			break
		end
		Wait(1)
	end
end)