CreateThread(function()
    if Config.Item.Inventory ~= "core_inventory" or not Config.Item.UniquePhones or not Config.Item.Require then
        return
    end

    local framework = nil
    if Config.Framework == "esx" then
        framework = exports['es_extended']:getSharedObject()
    elseif Config.Framework == "qb" then
        framework = exports["qb-core"]:GetCoreObject()
    end

    ---Function to get all items a player has with a specific name
    ---@param source number
    ---@param name string
    ---@return table items
    local function GetItemsByName(source, name)
        local playerIdentifier = Framework.GetPlayerFromId(source)?.identifier
        if playerIdentifier then
            playerIdentifier = playerIdentifier:gsub(':', '')

            local inventoryIdentifier = 'content-' .. playerIdentifier
            local inventory = exports['core_inventory']:getInventory(inventoryIdentifier)

            local items = {}
            debugPrint("Getting items with name: ", name)
            for _, v in pairs(inventory) do
                if v.name == name then
                    items[#items + 1] = v
                end
            end

            return items
        end

        return {}
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
                if phone?.metadata?.imei == imei then
                    debugPrint("Phone with imei " .. imei .. " found in " .. itemName)
                    return true
                end
            end
        end

        debugPrint("Phone with imei " .. imei .. " not found")
        return false
    end

    lib.callback.register('yseries:server:generate-phone-imei', function(source, phoneItem)
        local playerIdentifier = Framework.GetPlayerFromId(source)?.identifier
        if playerIdentifier then
            playerIdentifier = playerIdentifier:gsub(':', '')

            local inventoryIdentifier = 'content-' .. playerIdentifier
            local inventory = exports['core_inventory']:getInventory(inventoryIdentifier)
            for i = 1, #inventory do
                local item = inventory[i]
                if item?.name == phoneItem.name then
                    local newImei = GenerateUniqueIdentifier()

                    item.metadata.imei = newImei
                    exports['core_inventory']:updateMetadata(inventoryIdentifier, item.id, item.metadata)

                    return newImei
                end
            end
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
