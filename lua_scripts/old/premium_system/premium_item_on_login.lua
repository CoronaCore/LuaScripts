-- Include sc_default
require "base/sc_default"
require "base/sc_premium"

function PremiumSystem.CreateItemOnLogin(event, player)
    local PremiumPlayer = PremiumSystem(player)
    local PremiumActive = PremiumPlayer:IsActive() == true

	if PremiumSystem.Settings.ItemEnable == true then
        if PremiumActive and not player:HasItem(PremiumSystem.Settings.ItemEntry) then
            player:AddItem(PremiumSystem.Settings.ItemEntry, 1)
        end
	end
end

RegisterPlayerEvent(3, PremiumSystem.CreateItemOnLogin) 
