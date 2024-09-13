local spawnedVehicle = nil

openGarage = function(job, id)
    local menu = { id = 'garage_restaurants_'..job..'_'..id, title = locale('menu_garage_title'), options = {} }
    if not spawnedVehicle then
        for k, v in pairs(Config.workshops[job].garage[id].vehicles) do
            menu.options[#menu.options+1] = { title = v.label, icon = v.icon, arrow = true,
                onSelect = function()
                    spawnedVehicle = spawnVehicle(v.id, Config.workshops[job].garage[id].spawnCoords)
                end
            }
        end
    else
        menu.options[#menu.options+1] = { title = locale('menu_garage_store_vehicle'), icon = 'ban', arrow = true,
            onSelect = function()
                removeVehicleKey(GetVehicleNumberPlateText(spawnedVehicle))
                TaskEveryoneLeaveVehicle(spawnedVehicle)
                NetworkRequestControlOfEntity(spawnedVehicle)
                DeleteVehicle(spawnedVehicle)
                DeleteEntity(spawnedVehicle)
                spawnedVehicle = nil
            end
        }
    end
    lib.registerContext(menu)
    lib.showContext(menu.id)
end