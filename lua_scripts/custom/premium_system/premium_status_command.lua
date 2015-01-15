--[==[
]==]

-- Include sc_default
require "base/sc_default"
require "base/sc_premium"

local PremiumStatusCommand = "#premium status"

function PremiumSystem.StatusCommand(event, player, msg, _, lang)
    local PremiumPlayer = PremiumSystem(player)
    local PremiumActive = PremiumPlayer:IsActive() == true
    local PremiumExpireDate = PremiumPlayer:GeExpireDate()
    local PremiumCoins = PremiumPlayer:GetCoins()
    local PremiumRank = PremiumPlayer:GetRank()
    local PlayerName = player:GetName()

    if (msg == PremiumStatusCommand) and PremiumActive then -- Use "#premium status" for show your premium status
        player:SendBroadcastMessage(string.format("%s|CFFFE8A0E %s your premium rank is %s|r", PremiumSystemName, PlayerName, PremiumRank))
        player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Premium will expire on %s|r", PremiumSystemName, PremiumExpireDate))
        player:SendBroadcastMessage(string.format("%s|CFFFE8A0E You have %s Coins|r", PremiumSystemName, PremiumCoins))
        return false;
    end
end

RegisterPlayerEvent(18, PremiumSystem.StatusCommand) 
