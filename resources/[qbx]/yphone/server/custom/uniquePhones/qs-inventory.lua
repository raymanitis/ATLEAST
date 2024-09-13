CreateThread(function()
    if Config.Item.Inventory ~= "qs-inventory" or not Config.Item.UniquePhones or not Config.Item.Require then
        return
    end

    local ESX, QBCore
    if Config.Framework == "esx" then
        ESX = exports['es_extended']:getSharedObject()
    elseif Config.Framework == "qb" then
        QBCore = exports["qb-core"]:GetCoreObject()
    end

    ---Function to check if a player has a phone with a specific imei
    ---@param source any
    ---@param imei string
    ---@return boolean
    function HasImeiIdentifier(source, imei)
        debugPrint("Checking if " .. source .. " has a phone item with imei: ", imei)

        -- Determine the framework and get inventory accordingly
        local inventory = {}
        if Config.Framework == "esx" then
            inventory = ESX.GetPlayerFromId(source).getInventory()
        elseif Config.Framework == "qb" then
            inventory = QBCore.Functions.GetPlayer(source).PlayerData.items
        end

        -- Iterate through each item in the inventory
        for _, item in pairs(inventory) do
            -- Check if the item is a phone and has the specified IMEI
            if item and item.info and item.info.imei == imei and table.contains(Config.UseableItems, item.name) then
                debugPrint("Phone with imei " .. imei .. " found")
                return true
            end
        end

        debugPrint("Phone with imei " .. imei .. " not found")
        return false
    end

    lib.callback.register('yseries:server:generate-phone-imei', function(source, phoneItem)
        -- Utility function to check if an item is a useable phone item
        local function isUseablePhoneItem(itemName)
            for _, useableItemName in ipairs(Config.UseableItems) do
                if itemName == useableItemName then
                    return true
                end
            end
            return false
        end

        if Config.Framework == "esx" then
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer then
                local items = xPlayer.getInventory()
                -- Generate new imei. Set the imei to the phone item. Set the phone item to the player's inventory
                local newImei = GenerateUniqueIdentifier()
                for _, item in ipairs(items) do
                    if item and isUseablePhoneItem(item.name) then
                        item.info.imei = newImei
                        -- Assuming 'qs-inventory' is a placeholder, adjust according to your actual inventory management system
                        exports['qs-inventory']:SetInventory(source, items)
                        return newImei
                    end
                end
            else
                return false
            end
        elseif Config.Framework == "qb" then
            local qPlayer = QBCore.Functions.GetPlayer(source)
            if qPlayer then
                -- Generate new imei. Set the imei to the phone item. Set the phone item to the player's inventory
                local newImei = GenerateUniqueIdentifier()
                -- Ensure the item at the provided slot is a useable phone item before setting the IMEI
                if phoneItem and phoneItem.slot and isUseablePhoneItem(qPlayer.PlayerData.items[phoneItem.slot].name) then
                    qPlayer.PlayerData.items[phoneItem.slot].info.imei = newImei
                    qPlayer.Functions.SetInventory(qPlayer.PlayerData.items)

                    qPlayer.Functions.Save()

                    return newImei
                end
            else
                return false
            end
        end
    end)

    if Config.Framework == "esx" then
        for i = 1, #Config.UseableItems do
            exports['qs-inventory']:CreateUsableItem(Config.UseableItems[i], function(source, item)
                if item then
                    debugPrint("Using phone item")

                    TriggerClientEvent("yseries:use-phone-item", source, item)
                end
            end)
        end
    elseif Config.Framework == "qb" then
        for i = 1, #Config.UseableItems do
            QBCore.Functions.CreateUseableItem(Config.UseableItems[i], function(source, item)
                if item then
                    debugPrint("Using phone item")

                    TriggerClientEvent("yseries:use-phone-item", source, item)
                end
            end)
        end
    end
end)
