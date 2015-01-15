-- Include sc_default
require "base/sc_default"
require "base/sc_premium"
require "premium_main"

local PremiumItemCommand = "#premium item"

function PremiumSystem.ItemStoneCommand(event, player, msg, _, lang)
    local PremiumPlayer = PremiumSystem(player)
    local PremiumActive = PremiumPlayer:IsActive() == true
    local PlayerName = player:GetName()

    if (msg == PremiumItemCommand) and PremiumActive then -- Use "#premium item" for create a premium item
        if  player:HasItem(PremiumItemEntry) then
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E %s your already have the %s|r", PremiumSystemName, PlayerName, GetItemLink(PremiumItemEntry)))
            return false;
        else
            player:AddItem(PremiumItemEntry, 1)
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Create|r %s", PremiumSystemName, GetItemLink(PremiumItemEntry)))
            return false;
        end
    end
end

RegisterPlayerEvent(18, PremiumSystem.ItemStoneCommand)
