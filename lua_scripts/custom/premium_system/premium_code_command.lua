--[==[
]==]

-- Include sc_default
require "base/sc_default"
require "base/sc_premium"

local PremiumCodeCommand = "#premium code"

function PremiumSystem.CodeCommand(event, player, msg, _, lang)
    local PremiumPlayer = PremiumSystem(player)
    local PremiumActive = PremiumPlayer:IsActive() == true
    local PremiumExpireDate = PremiumPlayer:GeExpireDate()
    local PlayerName = player:GetName()

    if (msg == PremiumCodeCommand) then
        if PremiumActive then -- Use "#premium code" to enter a new premium code
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E %s you already have premium status!|r", PremiumSystem.Settings.SystemName, PlayerName))
            return false;
        else
            PremiumSystem.OnCodeGossipHello(event, player)
            return false;
        end
    end
end

function PremiumSystem.OnCodeGossipHello(event, player, unit)
    player:GossipClearMenu()
    player:GossipMenuAddItem(0, "Enter the Code!", 1, 1, true, nil)
    player:GossipSetText("Greetings "..player:GetName().."")
    player:GossipSendMenu(0x7FFFFFFF, player, 100)
end

function PremiumSystem.OnCodeGossipSelect(event, player, _, sender, intid, code)
    local PremiumPlayer = PremiumSystem(player)
    local PremiumExpireDate = PremiumPlayer:GeExpireDate()
    local PlayerGUID = player:GetGUIDLow()
    local PlayerAccount = player:GetAccountId()

    if (intid == 1) then
        local PremiumCodeCheck = AuthDBQuery(string.format("SELECT * FROM account_premium_codes WHERE code = ('%s') and type = 0 and active = 1", code))
        local PremiumCode = code

        if PremiumCodeCheck ~= nil and PremiumCode == PremiumCodeCheck:GetString(1) then
            AuthDBQuery(string.format("UPDATE account_premium_codes SET guid = ('%s'), used = CURRENT_TIMESTAMP, active = 0 WHERE code = ('%s')", PlayerGUID, PremiumCode))
            AuthDBQuery(string.format("UPDATE account_premium SET end = CURRENT_TIMESTAMP + interval ('%s') day, rank = ('%s'), active = 1 WHERE id = ('%s')", PremiumCodeCheck:GetString(3), PremiumCodeCheck:GetString(4), PlayerAccount))
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Your code %s is right!|r", PremiumSystem.Settings.SystemName, PremiumCode))
        else
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Yout code %s is worng or Code already used!|r", PremiumSystem.Settings.SystemName, PremiumCode))
        end
    end
end

RegisterPlayerEvent(18, PremiumSystem.CodeCommand)
RegisterPlayerGossipEvent(100, 2, PremiumSystem.OnCodeGossipSelect)                                 -- Register Event On Gossip Select
