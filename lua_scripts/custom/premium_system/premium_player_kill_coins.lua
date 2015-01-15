--[==[
]==]

-- Include sc_default
require "base/sc_default"
require "base/sc_premium"


local CoinsCount = 1

function PremiumSystem.OnPlayerKill(event, killer, killed)
    local PremiumPlayer = PremiumSystem(killer)
    local PremiumActive = PremiumPlayer:IsActive() == true

    if PremiumActive then
        PremiumPlayer:ModifyCoins(CoinsCount)
        killer:SendBroadcastMessage(string.format("%s|CFFFE8A0E %s Bonus Coin|r", PremiumSystemName, CoinsCount))
    end
end

RegisterPlayerEvent(6, PremiumSystem.OnPlayerKill)
