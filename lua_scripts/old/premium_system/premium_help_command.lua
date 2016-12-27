-- Include sc_default
require "base/sc_default"
require "base/sc_premium"

local PremiumHelpCommand = "#premium help"

function PremiumSystem.OnChatHelp(event, player, msg, _, lang)
    local PremiumPlayer = PremiumSystem(player)
    local PremiumActive = PremiumPlayer:IsActive() == true

    if (msg == PremiumHelpCommand) then 
        if PremiumActive then -- Use "#premium help" for list you all premium commands
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Version |r|CFFE55BB0%s|r", PremiumSystem.Settings.SystemName, PremiumSystem.Settings.Version))
            player:SendBroadcastMessage(string.format("%s", PremiumSystem.Settings.SystemName))
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Use |r|CFFE55BB0#premium help|r|CFFFE8A0E for list all premium commands.|r", PremiumSystem.Settings.SystemName))
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Use |r|CFFE55BB0#premium menu|r|CFFFE8A0E for show the premium menu.|r", PremiumSystem.Settings.SystemName))
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Use |r|CFFE55BB0#premium status|r|CFFFE8A0E for check your premium status.|r", PremiumSystem.Settings.SystemName))
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Use |r|CFFE55BB0#premium buff|r|CFFFE8A0E for buff you self.|r", PremiumSystem.Settings.SystemName))
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Use |r|CFFE55BB0#premium item|r|CFFFE8A0E for create a premium stone item.|r", PremiumSystem.Settings.SystemName))
            return false;
        else
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Use |r|CFFE55BB0#premium code|r|CFFFE8A0E to enter a premium code.|r", PremiumSystem.Settings.SystemName))
            return false;
        end
    end
end

RegisterPlayerEvent(18, PremiumSystem.OnChatHelp)