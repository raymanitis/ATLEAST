CreateThread(function()
    if Config.Item.Inventory ~= "tgiann-inventory" then return end

    local function GetItemsByName(name)
        local items = {}
        local inventory = exports["tgiann-inventory"]:GetPlayerItems()
        for _, item in pairs(inventory) do
            if item?.name == name then
                items[#items + 1] = item
            end
        end
        return items
    end

    function HasImeiIdentifier(imei)
        -- Iterate over each item name in the list of usable items
        for _, itemName in ipairs(Config.UseableItems) do
            local phones = GetItemsByName(itemName) -- Get items by current name
            -- Check each phone for the specified IMEI
            for i = 1, #phones do
                local phone = phones[i]
                if phone and phone.info and phone.info.imei == imei then
                    return true
                end
            end
        end

        return false
    end

    function GetImeiFromItem(item)
        return item?.info?.imei
    end

    RegisterNetEvent("yseries:use-phone-item", function(phoneItem)
        local active = SetupPhone(phoneItem)
        if active then
            ToggleOpen(true)
        end
    end)

    RegisterNetEvent('yseries:phone-item-added', function()
        debugPrint('Phone item added')
    end)

    RegisterNetEvent('tgiann-inventory:dropItem', function()
        Wait(500)

        debugPrint('Phone item removed')

        if Config.Item.UniquePhones and CurrentPhoneImei and not HasImeiIdentifier(CurrentPhoneImei) then
            PhoneDropped()

            RemovePrimaryPhone(PlayerData.identifier, CurrentPhoneImei)

            if not HasPrimaryPhone then
                debugPrint('Removed primary phone item with imei: ' .. CurrentPhoneImei)
            else
                debugPrint('Could not remove primary phone item with imei: ' .. CurrentPhoneImei)
            end
        end
    end)
end)
