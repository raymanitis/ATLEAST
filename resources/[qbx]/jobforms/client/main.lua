function DoApplication(AreaIndex)
    local area = Config.Areas[AreaIndex]
    local Questions = area.Questions
    local input = lib.inputDialog(area.label, Questions)
    if not input then return end
    
    lib.notify({
        title = 'Darba pieteikums',
        description = 'Veiksmīgi iesniedzāt pieteikumu.',
        type = 'success',
        icon = 'check',
        duration = 5000 -- Show the notification for 5 seconds
    })
    
    TriggerServerEvent("jobforms:apply", AreaIndex, input)
end

CreateThread(function()
    for i = 1, #Config.Areas do
        local area = Config.Areas[i]
        if Config.UseTarget then 
            exports.ox_target:addSphereZone({
                coords = area.Coords,
                radius = area.TargetSettings.radius,
                debug = area.TargetSettings.debug,
                options = {
                    {
                        name = area.label,
                        icon = area.TargetSettings.icon,
                        label = area.TargetSettings.label,
                        onSelect = function()
                            DoApplication(i)
                        end,
                        canInteract = function()
                            return not Config.ApplicationSettings.Cooldown.enabled or not LocalPlayer.state.ApplicationCooldown
                        end
                    }
                }
            })
        else 
            local point = lib.points.new(area.Coords, area.MarkerSettings.Distance, {
                area = area, DrawingTextUI = false, areaIndex = i
            })
            function point:nearby()
                if self.area.MarkerSettings.DrawMarker then
                    local m_set = self.area.MarkerSettings
                    DrawMarker(m_set.type, self.coords.x, self.coords.y, self.coords.z, 0, 0, 0, m_set.rotation.x, m_set.rotation.y, m_set.rotation.z, m_set.size.x, m_set.size.y, m_set.size.z, m_set.colour.r, m_set.colour.g, m_set.colour.b, m_set.colour.a, false, true, 2, nil, nil, false)
                end
                if self.currentDistance < 1 then
                    if not self.DrawingTextUI then
                        self.DrawingTextUI = true
                        lib.showTextUI(self.area.MarkerSettings.TextUI)
                    end
                    if IsControlJustPressed(0, 38) then
                        if Config.ApplicationSettings.Cooldown.enabled and LocalPlayer.state.ApplicationCooldown then 
                            return lib.notify({
                                title = 'Job Application',
                                description = 'Please wait for your cooldown to finish.',
                                icon = 'ban',
                                iconColor = '#C53030'
                            })
                        end
                        DoApplication(self.areaIndex)
                    end
                else
                    if self.DrawingTextUI then
                        self.DrawingTextUI = false
                        lib.hideTextUI()
                    end
                end
            end
        end
        if area.Blip.enabled then
            local blip = AddBlipForCoord(area.Coords)
            SetBlipSprite(blip, area.Blip.sprite)
            SetBlipAsShortRange(blip, true)
            SetBlipColour(blip, area.Blip.colour)
            SetBlipScale(blip, area.Blip.size)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(area.label)
            EndTextCommandSetBlipName(blip)
        end
    end
end)
