--[==[
]==]

-- Include sc_default
require "base/sc_default"
require "base/sc_premium"

function PremiumSystem.OnPlayerKill(event, killer, killed)
    local PremiumPlayer = PremiumSystem(killer)
    local PremiumActive = PremiumPlayer:IsActive() == true

    if PremiumActive and PremiumSystem.Settings.ActiveKillCoins == true then
        PremiumPlayer:ModifyCoins(PremiumSystem.Settings.CoinsCount)
        killer:SendBroadcastMessage(string.format("%s|CFFFE8A0E %s Bonus Coin|r", PremiumSystem.Settings.SystemName, CoinsCount))
    end
end

RegisterPlayerEvent(6, PremiumSystem.OnPlayerKill)
