-- Include sc_default
require "base/sc_default"
require "base/sc_premium"
require "premium_main"

local PremiumItemCommand = "#premium item"

function PremiumSystem.ItemStoneCommand(event, player, msg, _, lang)
    local PremiumPlayer = PremiumSystem(player)
    local PremiumActive = PremiumPlayer:IsActive() == true
    local PlayerName = player:GetName()

    if (msg == PremiumItemCommand) and PremiumSystem.Settings.ItemEnable == true then
	    if PremiumActive then -- Use "#premium item" for create a premium item
            if  player:HasItem(PremiumSystem.Settings.ItemEntry) then
                player:SendBroadcastMessage(string.format("%s|CFFFE8A0E %s your already have the %s|r", PremiumSystem.Settings.SystemName, PlayerName, GetItemLink(PremiumSystem.Settings.ItemEntry)))
                return false;
            else
                player:AddItem(PremiumSystem.Settings.ItemEntry, 1)
                player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Create|r %s", PremiumSystem.Settings.SystemName, GetItemLink(PremiumSystem.Settings.ItemEntry)))
                return false;
		    end
        end
    else
		player:SendBroadcastMessage(string.format("%s|CFFFE8A0E The command %s is disabled.", PremiumSystem.Settings.SystemName, PremiumItemCommand))
        return false;
    end
end

RegisterPlayerEvent(18, PremiumSystem.ItemStoneCommand)
