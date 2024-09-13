CreateThread(function()
    if Config.Item.Inventory ~= "codem-inventory" or not Config.Item.UniquePhones or not Config.Item.Require then
        return
    end

    local framework = nil
    if Config.Framework == "qb" then
        framework = exports["qb-core"]:GetCoreObject()
    elseif Config.Framework == "esx" then
        framework = exports["es_extended"]:getSharedObject()
    end

    ---Function to get all items a player has with a specific name
    ---@param source number
    ---@param name string
    ---@return table items
    local function GetItemsByName(source, name)
        local src = source
        local inventory = exports["codem-inventory"]:GetInventory(false, src)
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

    lib.callback.register('yseries:server:generate-phone-imei', function(source, phoneItem)
        local player = Framework.GetPlayerFromId(source)
        if player then
            -- Genereate new imei. Set the imei to the phone item. Set the phone item to the player's inventory
            local newImei = GenerateUniqueIdentifier()

            local inventory = exports["codem-inventory"]:GetInventory(false, source)
            if inventory then
                local phone = inventory[tostring(phoneItem.slot)]
                if phone then
                    local info = phone.info
                    if not info then
                        info = {}
                    end
                    info.imei = newImei
                    exports['codem-inventory']:SetItemMetadata(source, phoneItem.slot, info)
                else
                    print('Phone item not found')
                end
            end

            return newImei
        end

        return false
    end)

    if framework then
        for i = 1, #Config.UseableItems do
            if Config.Framework == "qb" then
                framework.Functions.CreateUseableItem(Config.UseableItems[i], function(source, item)
                    if item then
                        debugPrint("Using phone item")

                        TriggerClientEvent("yseries:use-phone-item", source, item)
                    end
                end)
            elseif Config.Framework == "esx" then
                framework.RegisterUseableItem(Config.UseableItems[i], function(source, _, item)
                    if item then
                        debugPrint("Using phone item")

                        TriggerClientEvent("yseries:use-phone-item", source, item)
                    end
                end)
            end
        end
    end
end)
