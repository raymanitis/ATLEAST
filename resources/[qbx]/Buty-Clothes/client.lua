function storePlayerClothes()

    local player = PlayerPedId()
    
    playerClothes = {
        torso = GetPedDrawableVariation(player, 3),
        torso_texture = GetPedTextureVariation(player, 3),
        legs = GetPedDrawableVariation(player, 4),
        legs_texture = GetPedTextureVariation(player, 4),
        feet = GetPedDrawableVariation(player, 6),
        feet_texture = GetPedTextureVariation(player, 6),
        accessories = GetPedDrawableVariation(player, 7),
        accessories_texture = GetPedTextureVariation(player, 7),
        undershirt = GetPedDrawableVariation(player, 8),
        undershirt_texture = GetPedTextureVariation(player, 8),
        top = GetPedDrawableVariation(player, 11),
        top_texture = GetPedTextureVariation(player, 11),
        hat = GetPedPropIndex(player, 0),
        hat_texture = GetPedPropTextureIndex(player, 0),
        glasses = GetPedPropIndex(player, 1),
        glasses_texture = GetPedPropTextureIndex(player, 1),
        chaleco = GetPedDrawableVariation(player, 9),
        chaleco_texture = GetPedTextureVariation(player, 9)
    }

end

function restorePlayerClothes()
    local player = PlayerPedId()
    
    SetPedComponentVariation(player, 3, playerClothes["torso"], playerClothes["torso_texture"], 0)
    SetPedComponentVariation(player, 4, playerClothes["legs"], playerClothes["legs_texture"], 0)
    SetPedComponentVariation(player, 6, playerClothes["feet"], playerClothes["feet_texture"], 0)
    SetPedComponentVariation(player, 7, playerClothes["accessories"], playerClothes["accessories_texture"], 0)
    SetPedComponentVariation(player, 8, playerClothes["undershirt"], playerClothes["undershirt_texture"], 0)
    SetPedComponentVariation(player, 11, playerClothes["top"], playerClothes["top_texture"], 0)
    SetPedComponentVariation(player, 9, playerClothes["chaleco"], playerClothes["chaleco_texture"], 0, 0)
end

function changeClothes(torso,pant,shoes,shirt,arms)
    storePlayerClothes()
    Wait(10)
    local player = PlayerPedId()
    SetPedComponentVariation(player, 3, arms[1], 0)
    SetPedComponentVariation(player, 4, pant[1], pant[2], 0)
    SetPedComponentVariation(player, 6, shoes[1], shoes[2], 0)
    SetPedComponentVariation(player, 8, shirt[1], shirt[2], 0)
    SetPedComponentVariation(player, 11, torso[1], torso[2], 0)
    SetPedComponentVariation(player, 9, 0, 0, 0)
end