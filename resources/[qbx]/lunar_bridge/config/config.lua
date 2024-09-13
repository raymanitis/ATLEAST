Config = {}
Config.Target = true -- Whether to use target or text UI.

-- You can ignore this if you use target.
-- This cannot be changed on clients that already cached this.
Config.Keybinds = {
    'E', 'G', 'C'
}

Config.Dispatch = {
    Enable = true, -- Enable dispatch
    Type = 'normal', --['normal'/'cd_dispatch'/'qs-dispatch'/'ps-dispatch']
	Jobs = {
		'police',
		'sheriff'
	}
}

-- The distance at which peds and props get loaded in for players
Config.SpawnDistance = 100.0

-- The built-in 3D prompts
Config.Prompts = {
	Enabled = true,
	RenderDistance = 3.0, -- Don't put this to more than 5.0 to avoid issues
	SpriteSize = 0.0190,
	SpriteColor = { r = 170, g = 170, b = 255, a = 255 },
	---@type 'prompt' | 'prompt_old'
	Dict = 'prompt' -- Choose the one you like
}

-- This will map addAccountMoney calls to your dirty money item
-- You can use your black_money item as an account in our scripts due to this
Config.BlackMoney = {
	-- You can change it to whatever your dirty money item name is
	ItemName = 'black_money',

	-- marked_bills use metadata in some moneywashing scripts, this is up to you
	-- Beware that you can only use the dirty money item as a reward when this is set to true
	UsesMetadata = false
}