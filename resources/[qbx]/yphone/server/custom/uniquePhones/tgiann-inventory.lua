CreateThread(function()
    if Config.Item.Inventory ~= "tgiann-inventory" then return end

    ---Function to get all items a player has with a specific name
    ---@param source number
    ---@param name string
    ---@return table items
    local function GetItemsByName(source, name)
        local inventory = exports["tgiann-inventory"]:GetPlayerItems(source)

        local items = {}
        debugPrint("Getting items with name: ", name)
        for _, v in pairs(inventory) do
            if v.name == name then
                items[#items + 1] = v
            end
        end

        return items
    end

    ---Function to check if a player has a phone with a specific imei
    ---@param source any
    ---@param imei string
    ---@return boolean
    function HasImeiIdentifier(source, imei)
        debugPrint("Checking if " .. source .. " has a phone item with imei: " .. imei)

        -- Iterate over each item name in Config.UseableItems
        for _, itemName in ipairs(Config.UseableItems) do
            local phones = GetItemsByName(source, itemName)

            for i = 1, #phones do
                local phone = phones[i]
                -- Assuming the IMEI is stored in the first element of the info array
                if phone and phone.info and phone.info.imei == imei then
                    debugPrint("Phone with imei " .. imei .. " found in " .. itemName)
                    return true
                end
            end
        end

        debugPrint("Phone with imei " .. imei .. " not found")
        return false
    end

    local Framework = nil
    if Config.Framework == "esx" then
        Framework = exports['es_extended']:getSharedObject()
    elseif Config.Framework == "qb" then
        Framework = exports["qb-core"]:GetCoreObject()
    end

    lib.callback.register('yseries:server:generate-phone-imei', function(source, phoneItem)
        local item = exports["tgiann-inventory"]:GetItemBySlot(source, phoneItem.slot)
        if item then
            local newImei = GenerateUniqueIdentifier()
            local newMetadata = { imei = newImei }
            exports["tgiann-inventory"]:UpdateItemMetadata(source, phoneItem.name, phoneItem.slot, newMetadata)

            return newImei
        end

        return false
    end)

    if Framework then
        for i = 1, #Config.UseableItems do
            if Config.Framework == "qb" then
                Framework.Functions.CreateUseableItem(Config.UseableItems[i], function(source, item)
                    if item then
                        debugPrint("Using phone item")

                        TriggerClientEvent("yseries:use-phone-item", source, item)
                    end
                end)
            elseif Config.Framework == "esx" then
                Framework.RegisterUseableItem(Config.UseableItems[i], function(source, _, item)
                    if item then
                        debugPrint("Using phone item")

                        TriggerClientEvent("yseries:use-phone-item", source, item)
                    end
                end)
            end
        end
    end
end)
