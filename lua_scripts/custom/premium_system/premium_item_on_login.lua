-- Include sc_default
require "base/sc_default"
require "base/sc_premium"

function PremiumSystem.CreateItemOnLogin(event, player)
    local PremiumPlayer = PremiumSystem(player)
    local PremiumActive = PremiumPlayer:IsActive() == true

    if PremiumActive and not player:HasItem(PremiumItemEntry) then
        player:AddItem(PremiumItemEntry, 1)
    end
end

RegisterPlayerEvent(3, PremiumSystem.CreateItemOnLogin) 
