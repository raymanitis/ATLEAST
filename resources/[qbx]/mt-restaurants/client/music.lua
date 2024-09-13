function playSong(musicID, job, id, coords)
    local input = lib.inputDialog(locale('input_music_play_song'), {
        { type = 'input', icon = 'fab fa-youtube', label = locale('input_music_song_link'), required = true },
        { type = 'slider', icon = 'volume-up', label = locale('input_music_song_vol'), required = true, min = 0, max = Config.restaurants[job].music[id].maxMusicVolume },
        { type = 'slider', icon = 'expand', label = locale('input_music_song_dist'), required = true, min = 0, max = Config.restaurants[job].music[id].maxMusicRadius },
    })
    if input and input[1] and input[2] and input[3] then
        TriggerServerEvent('mt-restaurants:server:playSong', musicID, input, coords)
    end
end

function changeSongStatus(musicID, job, id)
    local input = lib.inputDialog(locale('input_music_play_song'), {
        { type = 'slider', icon = 'volume-up', label = locale('input_music_song_vol'), required = true, min = 0, max = Config.restaurants[job].music[id].maxMusicVolume },
        { type = 'slider', icon = 'expand', label = locale('input_music_song_dist'), required = true, min = 0, max = Config.restaurants[job].music[id].maxMusicRadius },
    })
    if input and input[1] and input[2] then
        TriggerServerEvent('mt-restaurants:server:changeSongStatus', musicID, input)
    end
end

function stopSong(musicID)
    TriggerServerEvent('mt-restaurants:server:stopSong', musicID)
end