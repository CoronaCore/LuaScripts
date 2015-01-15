-- Include sc_default
require "base/sc_default"
require "base/sc_premium"

local PremiumHelpCommand = "#premium help"

function PremiumSystem.OnChatHelp(event, player, msg, _, lang)
    local PremiumPlayer = PremiumSystem(player)
    local PremiumActive = PremiumPlayer:IsActive() == true

    if (msg == PremiumHelpCommand) and PremiumActive then -- Use "#premium help" for list you all premium commands
        player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Use |r|CFFE55BB0#premium help|r|CFFFE8A0E for list all premium commands.", PremiumSystemName))
        player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Use |r|CFFE55BB0#premium menu|r|CFFFE8A0E for show the premium menu.", PremiumSystemName))
        player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Use |r|CFFE55BB0#premium status|r|CFFFE8A0E for check your premium status.|r", PremiumSystemName))
        player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Use |r|CFFE55BB0#premium buff|r|CFFFE8A0E for buff you self.|r", PremiumSystemName))
        player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Use |r|CFFE55BB0#premium item|r|CFFFE8A0E for create a premium stone item.|r", PremiumSystemName))
        return false;
    end
end

RegisterPlayerEvent(18, PremiumSystem.OnChatHelp)