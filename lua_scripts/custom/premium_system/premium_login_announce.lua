--[==[
]==]

-- Include sc_default
require "base/sc_default"
require "base/sc_premium"


function PremiumSystem.OnLogin(event, player)  -- Send a welcome massage to player and tell him is premium or not
    local PremiumPlayer = PremiumSystem(player)
    local PremiumActive = PremiumPlayer:IsActive() == true
    local PlayerName = player:GetName()

    if PremiumActive then
        player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Welcome %s you are Premium!|r", PremiumSystemName, PlayerName))
    else
        player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Welcome %s you are NOT Premium!|r", PremiumSystemName, PlayerName))
    end
end

RegisterPlayerEvent(3, PremiumSystem.OnLogin)  -- Register Event On Login
