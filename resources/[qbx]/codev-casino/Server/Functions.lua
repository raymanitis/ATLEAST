local cacheFiles = {}

Citizen.CreateThread(function()
	if GetResourceState("qb-core") == "started" then
		Framework = exports['qb-core']:GetCoreObject()
	elseif GetResourceState("es_extended") == "started" then
		Framework = exports['es_extended']:getSharedObject()
	else 
		if Config.Debug then print("[CODEV-CASINO] [ERROR] No framework found, please add yours to editable files.") end
	end
end)

-- Save cacheFiles to Server\Data\players.json every 30 minutes
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30 * 60000)
		local data = LoadResourceFile(GetCurrentResourceName(), 'Server/Data/players.json')
		local data = json.decode(data)
		for k,v in pairs(cacheFiles) do
			data[k] = v
		end
		SaveResourceFile(GetCurrentResourceName(), 'Server/Data/players.json', json.encode(data), -1)
		if Config.Debug then print("[CODEV-CASINO] [INFO] Saved cacheFiles to Server/Data/players.json") end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		local data = LoadResourceFile(GetCurrentResourceName(), 'Server/Data/players.json')
		local data = json.decode(data)
		for k,v in pairs(cacheFiles) do
			data[k] = v
		end
		SaveResourceFile(GetCurrentResourceName(), 'Server/Data/players.json', json.encode(data), -1)
		if Config.Debug then print("[CODEV-CASINO] [INFO] Saved cacheFiles to Server/Data/players.json") end
	end
end)

---@param playerData table // player data
---@param src number // player id
function savePlayerData(playerData, src)
	if not next(cacheFiles) then
		local data = LoadResourceFile(GetCurrentResourceName(), 'Server/Data/players.json')
		local data = json.decode(data)
		cacheFiles = data
	end

    if playerData.identifier then 
		if Config.Debug then print("[CODEV-CASINO] [INFO] SAVING PLAYER TO CACHE:"..playerData.identifier) end
        cacheFiles[playerData.identifier] = playerData
		if src then 
			TriggerClientEvent('ctake:client:receiveData', src, cacheFiles[playerData.identifier])
		end
        return true
    end
	
	return false
end

---@param identifier string // player identifier
---@param src number // player id
function getPlayerData(identifier, src)
	if not next(cacheFiles) then 
		local data = LoadResourceFile(GetCurrentResourceName(), 'Server/Data/players.json')
		local data = json.decode(data)
		cacheFiles = data
	end
	local data = cacheFiles
	local found = false
	if data[identifier] then 
		local v = data[identifier]
		found = true
		v.isAdmin = isPlayerAdmin(src)
		return v
	end

	if not found then 
		local player = {
			identifier = identifier,
			money = 0,
            name = GetPlayerName(src),
			bets = {},
			veniatorHistory = {},
			isAdmin = isPlayerAdmin(src),
			chatban = false,
			timeout = false,
			image = "https://cdn.discordapp.com/attachments/932478723700183140/1120182521481662495/blank-profile-picture-973460_640.webp"
		}
		savePlayerData(player, src)
		return player
	end

	return false
end

---@param id number // player id
function getPlayerIdentifier(id)
    local license  = false

    for k,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        end
    end

    return license
end

---@param type string // "money" or "bank"
---@param amount number // amount to add
function removePlayerMoney(type, amount)
	local amount = tonumber(amount)
	local src = source
	if GetResourceState("qb-core") == "started" then
		local Player = Framework.Functions.GetPlayer(src)
		if Player then
			if type == "money" then
				local plyAmount = Player.Functions.GetMoney("cash")
				if plyAmount >= amount then
					sendDiscordLog('money', 'MONEY', '**'..Player.PlayerData.name..'** deposited **$'..amount..'** from **'..type..'**', getPlayerIdentifier(src))
					return Player.Functions.RemoveMoney("cash", amount)
				else
					sendDiscordLog('money', 'MONEY', '**'..Player.PlayerData.name..'** tried to deposit **$'..amount..'** from **'..type..'** but he/she doesn\'t have enough money.', getPlayerIdentifier(src))
					return false
				end
			elseif type == "bank" then
				local plyAmount = Player.Functions.GetMoney("bank")
				if plyAmount >= amount then
					sendDiscordLog('money', 'MONEY', '**'..Player.PlayerData.name..'** deposited **$'..amount..'** from **'..type..'**', getPlayerIdentifier(src))
					return Player.Functions.RemoveMoney("bank", amount)
				else
					sendDiscordLog('money', 'MONEY', '**'..Player.PlayerData.name..'** tried to deposit **$'..amount..'** from **'..type..'** but he/she doesn\'t have enough money.', getPlayerIdentifier(src))
					return false
				end
			end
		end
	elseif GetResourceState("es_extended") == "started" then
		local Player = Framework.GetPlayerFromId(src)
		if Player then
			local plyAmount = Player.getAccount(type).money
			if plyAmount >= amount then
				Player.removeAccountMoney(type, amount)
				sendDiscordLog('money', 'MONEY', '**'..Player.getName()..'** deposited **$'..amount..'** from **'..type..'**', getPlayerIdentifier(src))
				return true
			else
				sendDiscordLog('money', 'MONEY', '**'..Player.getName()..'** tried to deposit **$'..amount..'** from **'..type..'** but he/she doesn\'t have enough money.', getPlayerIdentifier(src))
				return false
			end
		end
	else
		if Config.Debug then print("[CODEV-CASINO] [ERROR] removePlayerMoney: No framework found, please add yours to editable files.") end
	end
end

---@param type string // "money" or "bank"
---@param amount number // amount to add
function addPlayerMoney(type, amount)
	local amount = tonumber(amount)
	local src = source
	if GetResourceState("qb-core") == "started" then
		local Player = Framework.Functions.GetPlayer(src)
		if Player then
			if type == "money" then
				return Player.Functions.AddMoney("cash", amount) 
			elseif type == "bank" then
				return Player.Functions.AddMoney("bank", amount) 
			end
			sendDiscordLog('money', 'MONEY', '**'..Player.PlayerData.name..'** withdrawn **$'..amount..'** to **'..type..'**', getPlayerIdentifier(src))
		end
	elseif GetResourceState("es_extended") == "started" then
		local Player = Framework.GetPlayerFromId(src)
		if Player then
			Player.addAccountMoney(type, amount)
			sendDiscordLog('money', 'MONEY', '**'..Player.getName()..'** withdrawn **$'..amount..'** to **'..type..'**', getPlayerIdentifier(src))
			return true
		end
	else
		if Config.Debug then print("[CODEV-CASINO] [ERROR] addPlayerMoney: No framework found, please add yours to editable files.") end
	end
end

---@param id number // player id
function isPlayerAdmin(id)
	local src = id
	local identifier = getPlayerIdentifier(src)
	return Config.StaffList[identifier]
end

function veniatorCalculation()
	local precision = 100;
	local stopNum;
	local coeffChance = math.random(1, 100);
	
	if coeffChance >= 1 and coeffChance <= 10 then
		stopNum = math.random(1 * precision, 1 * precision) / precision
	elseif coeffChance >= 11 and coeffChance <= 30 then
		stopNum = math.random(1 * precision, 2 * precision) / precision
	elseif coeffChance >= 31 and coeffChance <= 45 then
		stopNum = math.random(1 * precision, 2 * precision) / precision
	elseif coeffChance >= 46 and coeffChance <= 60 then
		stopNum = math.random(1 * precision, 3 * precision) / precision
	elseif coeffChance >= 61 and coeffChance <= 75 then
		stopNum = math.random(1 * precision, 3 * precision) / precision
	elseif coeffChance >= 76 and coeffChance <= 95 then
		stopNum = math.random(1 * precision, 5 * precision) / precision
	elseif coeffChance >= 96 and coeffChance <= 100 then
		stopNum = math.random(10 * precision, 30 * precision) / precision
	end

	return stopNum
end

---@param array table // Config.PlinkoChances[row] indexes
function selectIndexByProbability(row)
	local array = Config.PlinkoChances[row]
    -- Calculate total probability
    local totalProbability = 0
    for _, probability in ipairs(array) do
        totalProbability = totalProbability + probability
    end

    -- Random number in range [0, totalProbability)
    local randomNum = math.random() * totalProbability

    -- Find the index of the probability that randomNum falls into
    local cumulativeProbability = 0
    for i, probability in ipairs(array) do
        cumulativeProbability = cumulativeProbability + probability
        if randomNum <= cumulativeProbability then
			if Config.Debug then print("[CASINO] [INFO] Plinko: Selected index "..i.." with probability "..probability) end
            return (i - 1)
        end
    end

    -- Should never reach here due to floating point precision, but just in case
    local number = #array
    local mid = (number + 1)
    if mid % 2 == 0 then 
        mid = mid / 2
    else
        mid = (number + 2) / 2
    end
    
	if Config.Debug then print("[CASINO] [INFO] Plinko: Selected index mid "..mid.." with probability "..array[mid]) end
    return mid
end

---@param type string // Config.Webhooks indexes
---@param title string
---@param string message // message to send
---@param identifier string // player identifier
function sendDiscordLog(title, message, identifier, Webhook)
    local headers = {
        ['Content-Type'] = 'application/json'
    }
    local embed = {
        {
            ["color"] = 15548997,
            ["title"] = title,
            ["description"] = message .. "\nPlayer Identifier: " .. identifier .. "\nPlayer Steam Name: " .. GetPlayerName(source),
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ"),
            ["footer"] = {
                ["text"] = "Developed by Codeverse Scripts - discord.gg/codeverse",
            },
            ["author"] = {
                ["name"] = "SERVER LOGS",
            },
        }
    }
    PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
end

---@param eventName string
---@param ... any
function TriggerEventForCasinoPlayers(eventName, ...)
  local players = PlayersInCasino
  if #players == 0 then return end 
  for i = 1, #players do
    if players[i] then
      TriggerClientEvent(eventName, players[i], ...)
    end
  end
end

if Config.AccessTypes["item"].enabled then 
	if GetResourceState("qb-core") == "started" then
		Framework = exports['qb-core']:GetCoreObject()
		Framework.Functions.CreateUseableItem(Config.AccessTypes["item"].itemName, function(source, item)
			local src = source
			local Player = Framework.Functions.GetPlayer(src)
			if Player.Functions.GetItemByName(item.name) then
				TriggerClientEvent('ctake:client:open', src)
			end
		end)
	elseif GetResourceState("es_extended") == "started" then
    Framework = exports['es_extended']:getSharedObject()
    Framework.RegisterUsableItem(Config.AccessTypes["item"].itemName, function(source, item)
      local src = source
      TriggerClientEvent('ctake:client:open', src)
    end)
	else
		if Config.Debug then print("[CODEV-CASINO] [ERROR] addPlayerMoney: No framework found, please add yours to editable files.") end
	end
end
