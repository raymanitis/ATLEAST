Config = {}
Config.InteractDistance = 4.0
Config.DisableTarget = false -- Use this if you want to only utilize the exports

Config.HandcuffItems = true -- This enables the handcuffs and zipties items
Config.HandcuffsItemName = 'handcuffs'
Config.ZiptiesItemName = 'zipties'

Config.HandcuffsSkillCheck = true -- This allows the players to get out of handcuffs

---@type { name: string, removeAfterUse: boolean  }?
Config.BreakHandcuffsItem = { name = 'bolt_cutters', removeAfterUse = true }

-- Allows carried players to be put inside a vehicle just like if they were dragged
-- Note that you aren't able to put in players that are dead
Config.AdvancedCarry = false
Config.StopCarry = true -- Whether the carried player can interrupt being carried

Config.PlayerActions = {
    ['steal'] = true,
    ['handcuff'] = true, -- Works both for handcuffs and zipties
    ['drag'] = true,
    ['carry'] = true,
    ['take_hostage'] = false,
    ['break_handcuffs'] = true -- Look inside cl_edit.lua for further configuration
}

Config.VehicleActions = {
    ['put_in_vehicle'] = true,
    ['out_the_vehicle'] = true,
    ['hijack'] = false,
    ['repair'] = false,
    ['clean'] = true,
    ['impound'] = false,
}

-- You can limit certain actions to jobs here
Config.JobRestrictions = {
    --EXAMPLE:
    -- ['handcuff'] = {
    --     'police',
    --     'sheriff'
    -- }
    -- ['ziptie'] = {
    --     'mafia'
    -- }
}

-- Weapon groups allowed for take_hostage
Config.Weapons = {
    [416676503] = true, -- Handguns
    [-95776620] = true --Submachine guns
}

-- used for the uncuff command
Config.Admins = {
    ['admin'] = true
}

Config.Durations = {
    ['hijack'] = 10000,
    ['repair'] = 10000,
    ['clean'] = 10000,
    ['impound'] = 10000,
}