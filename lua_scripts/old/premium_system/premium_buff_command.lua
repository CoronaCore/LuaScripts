--[==[
]==]

-- Include sc_default
require "base/sc_default"
require "base/sc_premium"

local BuffEntrys = { 23948, 24752, 16877, 10220, 13033, 11735, 10952 };

local PremiumBuffCommand = "#premium buff"

function PremiumSystem.BuffCommand(event, player, msg, _, lang)
    local PremiumPlayer = PremiumSystem(player)
    local PremiumActive = PremiumPlayer:IsActive() == true

     if (msg == PremiumBuffCommand) and PremiumActive then
        for _, v in ipairs(BuffEntrys)do
                player:AddAura(v, player)
        end
        return false;
    end
end

RegisterPlayerEvent(18, PremiumSystem.BuffCommand)