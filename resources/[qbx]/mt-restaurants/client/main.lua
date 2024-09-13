local blip = {}
local zone = {}
local shopBlip = {}
local shopPed = {}
lib.locale()

RegisterNetEvent('mt-restaurants:client:notify', notify)

createRestaurants = function()
    if Config.inventory == 'ox_inventory' then exports.ox_inventory:displayMetadata({ calories = locale('inventory_metadata_calories'), restaurant = locale('inventory_metadata_restaurant') }) end
    for k, v in pairs(Config.restaurants) do
        if v.enabled then

            if v.blip.enabled then
                blip[k] = createBlip(v.blip.coords, v.blip.sprite, v.blip.display, v.blip.scale, v.blip.color, v.label)
            end
            
            zone[k] = lib.zones.poly({ points = v.zone.points, thickness = v.zone.thickness, debug = Config.debug, onEnter = function() onZoneEnter(v.job, k) end, onExit = function() onZoneExit(v.job, k) end })
        
            if v.management then
                for a, b in pairs(v.management) do
                    local options = {
                        {
                            distance = 2.5,
                            label = locale('target_management'),
                            icon = locale('target_management_icon'),
                            onSelect = function() openManagement(v.job) end,
                            action = function() openManagement(v.job) end,
                            canInteract = function()
                                return (getPlayerJob() == v.job and isPlayerJobBoss())
                            end,
                        }
                    }
                    createSphereZoneTarget(b.coords, b.radius, options, 2.5, 'management_target_'..k..'_'..a)
                end
            end

            if v.stashes then
                for a, b in pairs(v.stashes) do
                    local options = {
                        {
                            distance = 2.5,
                            label = locale('target_stashes', b.label),
                            icon = locale('target_stashes_icon'),
                            onSelect = function() openStash('restaurants_stash_'..k..'_'..a, b.label, b.slots, b.weight) end,
                            action = function() openStash('restaurants_stash_'..k..'_'..a, b.label, b.slots, b.weight) end,
                            canInteract = function()
                                return (getPlayerJob() == v.job)
                            end,
                        }
                    }
                    createSphereZoneTarget(b.coords, b.radius, options, 2.5, 'stash_target_'..k..'_'..a)
                end
            end

            if v.trays then
                for a, b in pairs(v.trays) do
                    local options = {
                        {
                            distance = 2.5,
                            label = locale('target_trays', b.label),
                            icon = locale('target_trays_icon'),
                            onSelect = function() openStash('restaurants_trays_'..k..'_'..a, b.label, b.slots, b.weight) end,
                            action = function() openStash('restaurants_trays_'..k..'_'..a, b.label, b.slots, b.weight) end,
                        }
                    }
                    createSphereZoneTarget(b.coords, b.radius, options, 2.5, 'tray_target_'..k..'_'..a)

                    if b.prop then
                        createProp(b.prop, b.coords, b.propHeading or 0.0)
                    end
                end
            end

            if v.prepare then
                for a, b in pairs(v.prepare) do
                    local options = {
                        {
                            distance = 2.5,
                            label = locale('target_prepare', b.label),
                            icon = locale('target_prepare_icon'),
                            onSelect = function() openPrepare('restaurants_prepare_'..v.job..'_'..a, b.ingredients, b.label, b.anim) end,
                            action = function() openPrepare('restaurants_prepare_'..v.job..'_'..a, b.ingredients, b.label, b.anim) end,
                            canInteract = function()
                                return (getPlayerJob() == v.job)
                            end,
                        }
                    }
                    createSphereZoneTarget(b.coords, b.radius, options, 2.5, 'prepare_target_'..k..'_'..a)

                    if b.prop then
                        createProp(b.prop, b.coords, b.propHeading or 0.0)
                    end
                end
            end

            if v.stations then
                for a, b in pairs(v.stations) do
                    local options = {
                        {
                            distance = 2.5,
                            label = locale('target_station', b.label),
                            icon = locale('target_station_icon'),
                            onSelect = function() openStation(v.job, a) end,
                            action = function() openStation(v.job, a) end,
                            canInteract = function()
                                return (getPlayerJob() == v.job)
                            end,
                        }
                    }
                    createSphereZoneTarget(b.coords, b.radius, options, 2.5, 'station_target_'..k..'_'..a)
                end
            end

            if v.registers then
                for a, b in pairs(v.registers) do
                    local options = {
                        {
                            distance = 2.5,
                            label = locale('target_register', b.label),
                            icon = locale('target_register_icon'),
                            onSelect = function() openRegister(v.job, a) end,
                            action = function() openRegister(v.job, a) end,
                            canInteract = function()
                                return (getPlayerJob() == v.job)
                            end,
                        }
                    }
                    createSphereZoneTarget(b.coords, b.radius, options, 2.5, 'register_target_'..k..'_'..a)

                    if b.prop then
                        createProp(b.prop, b.coords, b.propHeading or 0.0)
                    end
                end
            end

            if v.menus then
                for a, b in pairs(v.menus) do
                    local options = {
                        {
                            distance = 2.5,
                            label = locale('target_menu', b.label),
                            icon = locale('target_menu_icon'),
                            onSelect = function() takeMenu(v.job) end,
                            action = function() takeMenu(v.job) end
                        }
                    }
                    createSphereZoneTarget(b.coords, b.radius, options, 2.5, 'menu_target_'..k..'_'..a)
                end
            end

            if v.music then
                for a, b in pairs(v.music) do
                    local options = {
                        {
                            distance = 2.5,
                            label = locale('target_music_play_song'),
                            icon = locale('target_music_play_song_icon'),
                            onSelect = function()
                                playSong('restaurant_music_'..v.job..'_'..a, v.job, a, b.coords)
                            end,
                            action = function()
                                playSong('restaurant_music_'..v.job..'_'..a, v.job, a, b.coords)
                            end,
                            canInteract = function()
                                return (getPlayerJob() == v.job)
                            end,
                        },
                        {
                            distance = 2.5,
                            label = locale('target_music_stop_song'),
                            icon = locale('target_music_stop_song_icon'),
                            onSelect = function()
                                stopSong('restaurant_music_'..v.job..'_'..a)
                            end,
                            action = function()
                                stopSong('restaurant_music_'..v.job..'_'..a)
                            end,
                            canInteract = function()
                                return (getPlayerJob() == v.job and exports.xsound:soundExists('restaurant_music_'..v.job..'_'..a))
                            end
                        },
                        {
                            distance = 2.5,
                            label = locale('target_music_change_song_status'),
                            icon = locale('target_music_change_song_status_icon'),
                            onSelect = function()
                                changeSongStatus('restaurant_music_'..v.job..'_'..a, v.job, a)
                            end,
                            action = function()
                                changeSongStatus('restaurant_music_'..v.job..'_'..a, v.job, a)
                            end,
                            canInteract = function()
                                return (getPlayerJob() == v.job and exports.xsound:soundExists('restaurant_music_'..v.job..'_'..a))
                            end
                        },
                    }
                    createSphereZoneTarget(b.coords, b.radius, options, 2.5, 'music_target_'..k..'_'..a)

                    if b.prop then
                        createProp(b.prop, b.coords, b.propHeading or 0.0)
                    end
                end
            end

            if v.garage then
                for a, b in pairs(v.garage) do
                    local options = {
                        {
                            distance = 2.5,
                            label = locale('target_garage'),
                            icon = locale('target_garage_icon'),
                            onSelect = function() openGarage(v.job, a) end,
                            action = function() openGarage(v.job, a) end,
                            canInteract = function()
                                return (getPlayerJob() == v.job)
                            end,
                        }
                    }
                    loadModel('prop_park_ticket_01')
                    local garageProp = CreateObject(GetHashKey('prop_park_ticket_01'), b.coords.x, b.coords.y, b.coords.z, false, false, false)
                    SetEntityHeading(garageProp, b.coords.w)
                    FreezeEntityPosition(garageProp, true)
                    createEntityTarget(garageProp, options, 2.5, 'garage_shop_'..v.job..'_'..a)
                end
            end

            if v.boxes then
                for a, b in pairs(v.boxes) do
                    local options = {
                        {
                            distance = 2.5,
                            label = locale('target_take_box'),
                            icon = locale('target_take_box_icon'),
                            onSelect = function() takeBox(v.job, a) end,
                            action = function() takeBox(v.job, a) end,
                            canInteract = function()
                                return (getPlayerJob() == v.job)
                            end,
                        }
                    }
                    createSphereZoneTarget(b.coords, b.radius, options, 2.5, 'box_target_'..k..'_'..a)
                end
            end
            
            if v.peds then
                for a, b in pairs(v.peds) do
                    createPed(b.coords, b.model, b.anim)
                end
            end

            if v.delivery then
                for a, b in pairs(v.delivery) do
                    local options = {
                        {
                            distance = 2.5,
                            label = locale('target_ask_delivery'),
                            icon = locale('target_ask_delivery_icon'),
                            onSelect = function() takeOrder(v.job, a) end,
                            action = function() takeOrder(v.job, a) end,
                            canInteract = function()
                                return (getPlayerJob() == v.job)
                            end,
                        }
                    }
                    createSphereZoneTarget(b.coords, b.radius, options, 2.5, 'box_target_'..k..'_'..a)

                    if b.prop then
                        createProp(b.prop, b.coords, b.propHeading or 0.0)
                    end
                end
            end

            if v.drivethru then
                for a, b in pairs(v.drivethru) do
                    lib.points.new({
                        coords = b.inCoords,
                        distance = b.inRadius,
                        onEnter = function()
                            enteredInDriveThru(v.job, a, v.driveThruId)
                        end,
                        onExit = function()
                            exitInDriveThru(v.job, a, v.driveThruId)
                        end,
                    })

                    lib.points.new({
                        coords = b.outCoords,
                        distance = b.outRadius,
                        onEnter = function()
                            enteredOutDriveThru(v.job, a, v.driveThruId)
                        end,
                        onExit = function()
                            exitOutDriveThru(v.job, a, v.driveThruId)
                        end,
                    })
                end
            end

            if v.chairs then
                for a, b in pairs(v.chairs) do
                    local options = {
                        {
                            distance = 2.5,
                            label = locale('target_sit'),
                            icon = locale('target_sit_icon'),
                            onSelect = function() sitChair(b) end,
                            action = function() sitChair(b) end,
                        }
                    }
                    createSphereZoneTarget(b, 0.4, options, 2.5, 'chair_target_'..k..'_'..a)
                end
            end
        end
    end

    for k, v in pairs (Config.shops) do
        if v.enabled then
            if v.blip.enabled then shopBlip[k] = createBlip(vec3(v.ped.coords.x, v.ped.coords.y, v.ped.coords.z), v.blip.sprite, v.blip.display, v.blip.scale, v.blip.color, v.label) end
            shopPed[k] = createPed(v.ped.coords, v.ped.model, { scenario = v.ped.scenario})
            local options = {
                {
                    distance = 2.5,
                    label = locale('target_shop', v.label),
                    icon = locale('target_shop_icon'),
                    onSelect = function() openShop('ingredients_shop_'..k, v.label, v.items) end,
                    action = function() openShop('ingredients_shop_'..k, v.label, v.items) end,
                }
            }
            createEntityTarget(shopPed[k], options, 2.5, 'ingredients_shop_'..k)
        end
    end
end
CreateThread(createRestaurants)
