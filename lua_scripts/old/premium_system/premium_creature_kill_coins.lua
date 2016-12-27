--[==[
    Premium System gain coins from creature kill
]==]

-- Include sc_default
require "base/sc_default"
require "base/sc_premium"


local CoinsCount = 1

function PremiumSystem.OnCreatureKill(event, player, creature)
    local PremiumPlayer = PremiumSystem(player)
    local PremiumActive = PremiumPlayer:IsActive() == true

    if PremiumActive then
        if creature:GetLevel() <= 10 and player:GetLevel() <= 10 then
            PremiumPlayer:ModifyCoins(CoinsCount)
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E %s Bonus Coin|r", PremiumSystem.Settings.SystemName, CoinsCount))
        elseif creature:GetLevel() > 10 and player:GetLevel() <= 20 then
            PremiumPlayer:ModifyCoins(CoinsCount)
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E %s Bonus Coin|r", PremiumSystem.Settings.SystemName, CoinsCount))
        elseif creature:GetLevel() > 20 and player:GetLevel() <= 30 then
            PremiumPlayer:ModifyCoins(CoinsCount)
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E %s Bonus Coin|r", PremiumSystem.Settings.SystemName, CoinsCount))
        elseif creature:GetLevel() > 30 and player:GetLevel() <= 40 then
            PremiumPlayer:ModifyCoins(CoinsCount)
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E %s Bonus Coin|r", PremiumSystem.Settings.SystemName, CoinsCount))
        elseif creature:GetLevel() > 40 and player:GetLevel() <= 50 then
            PremiumPlayer:ModifyCoins(CoinsCount)
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E %s Bonus Coin|r", PremiumSystem.Settings.SystemName, CoinsCount))
        elseif creature:GetLevel() > 40 and player:GetLevel() <= 50 then
            PremiumPlayer:ModifyCoins(CoinsCount)
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E %s Bonus Coin|r", PremiumSystem.Settings.SystemName, CoinsCount))
        elseif creature:GetLevel() > 50 and player:GetLevel() <= 60 then
            PremiumPlayer:ModifyCoins(CoinsCounts)
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E %s Bonus Coin|r", PremiumSystem.Settings.SystemName, CoinsCount))
        elseif creature:GetLevel() > 60 and player:GetLevel() <= 70 then
            PremiumPlayer:ModifyCoins(CoinsCounts)
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E %s Bonus Coin|r", PremiumSystem.Settings.SystemName, CoinsCount))
        elseif creature:GetLevel() >= 68 and player:GetLevel() == 70 then
            PremiumPlayer:ModifyCoins(CoinsCount)
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E %s Bonus Coin|r", PremiumSystem.Settings.SystemName, CoinsCount))
        end
    end
end

RegisterPlayerEvent(7, PremiumSystem.OnCreatureKill)             -- Register Event Player Kill Creature
