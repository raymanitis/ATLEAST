--- Clear the player inventory
---@param source number player source to remove inventory
---@param identifier string player identifier to remove inventory
function ClearPlayerInventory(source, identifier)

end

--- Test if item can be add into the stash
--- return true if it can, return false if there is no space
---@param name string 'Name of the stash'
---@param slot number 'Number of slot for the stash'
---@param maxWeight number 'Max weight of the stash'
---@param itemName string 'name of the item to retrieve his informations'
---@param itemAmount number 'amount of the item that will be added to stash'
function CustomCanCarryItemStash(name, slot, maxWeight, itemName, itemAmount)
    return true
end

--- Register Stash for your inventory 
--- (if it use this capability, if not let it empty)
---@param name string 'Name of the stash'
---@param slot number 'Number of slot for the stash'
---@param maxWeight number 'Max weight of the stash'
function CustomRegisterStash(name, slot, maxWeight)
    
end

--- Add item into stash for your inventory 
--- (if it use this capability, if not let it empty but item wont be add to stash)
--- Need to return a boolean (true = item add successfully, false = item not add to the stash)
---@param stashName string 'Stash name where the item will be add'
---@param itemName string 'Name of the item add'
---@param amount number 'Amount of item add'
---@param metadata table 'Metadata of the item add'
---@param slot number 'Number of slot for the stash'
---@param maxWeight number 'Max weight of the stash'
---@return boolean true : add successfully, false : not add
function CustomAddItemIntoStash(stashName, itemName, amount, metadata, slot, maxWeight)

end

--- Remove item into stash for your inventory 
--- (if it use this capability, if not let it empty but item wont be add to stash)
--- Need to return a boolean (true = item remove successfully, false = item not remove from the stash)
---@param stashName string 'Stash name where the item will be remove'
---@param itemName string 'Name of the item remove'
---@param amount number 'Amount of item remove'
---@param metadata table 'Metadata of the item remove'
---@param slot number 'Number of slot for the stash'
---@param maxWeight number 'Max weight of the stash'
---@return boolean true : remove successfully, false : not remove
function CustomRemoveItemIntoStash(stashName, itemName, amount, metadata, slot, maxWeight)

end

--- Function to open storage (inventory) server side
---@param source number player source
---@param name string storage name
---@param type string storage type
function CustomOpenStorage(source, name, type)

end

--- Return current server time (Hardware not ingame time)
function GetServerTime()
    local time = os.time()
    local h = tonumber(os.date('%H', time))
    local m = tonumber(os.date('%M', time))
    return h, m 
end