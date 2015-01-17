--[==[
]==]

-- Include sc_default
require "base/sc_default"
require "base/sc_premium"

function PremiumSystem.OnEnterZone(event, player, newZone, newArea)
    local PremiumPlayer = PremiumSystem(player)
    local PremiumActive = PremiumPlayer:IsActive() == true
    local newMap = player:GetMapId()

    if PremiumActive and player:GetTeam() == 0 then                     -- Alliance Stormwind Speed to 2
        if newArea == 1519 and newZone == 1519 and newMap == 0 then
            player:SetSpeed(1, 2, true)
        else
            player:SetSpeed(1, 1, true)
        end
    end

    if PremiumActive and player:GetTeam() == 1 then
        if newArea == 1637 and newZone == 1637 and newMap == 1 then     -- Horde Orgrimma Speed to 2
            player:SetSpeed(1, 2, true)
        else
            player:SetSpeed(1, 1, true)
        end
    end
end

RegisterPlayerEvent(27, PremiumSystem.OnEnterZone)