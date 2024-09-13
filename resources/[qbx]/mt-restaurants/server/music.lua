RegisterNetEvent("mt-restaurants:server:playSong", function(musicId, input, coords)
    exports.xsound:PlayUrlPos(-1, musicId, input[1], input[2]/100, vector3(coords.x, coords.y, coords.z))
    exports.xsound:Distance(-1, musicId, input[3])
    exports.xsound:setVolume(-1, musicId, input[2]/100)
end)

RegisterNetEvent("mt-restaurants:server:changeSongStatus", function(musicId, input)
    exports.xsound:Distance(-1, musicId, input[2])
    exports.xsound:setVolume(-1, musicId, input[1]/100)
end)

RegisterNetEvent('mt-restaurants:server:stopSong', function(musicID)
    exports.xsound:Destroy(-1, musicID)
end)