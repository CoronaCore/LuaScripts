-- -- -- -- -- -- -- -- -- -- -- -- --
-- -- PvP Token System by Salja. -- --
-- -- -- -- -- -- -- -- -- -- -- -- --

-- Include sc_default
require "base/sc_default"

local TokenSystem = {}

-- Settings
TokenSystem.Settings = {
    Name = "[Token System]",
    ItemOrGold = 0,                     -- 0 = Gold and Item, 1 = Only Item, 2 = Only Gold
    WorldAnnounce = true,               -- Sends a World Announce false = Off, true = On
    GoldCount = 10000,                  -- Reward in copper
    ItemEntry = 20558,                  -- Warsong Gulch Mark of Honor
    ItemCount = 1,                      -- Count of the Item
    ItemName = GetItemLink(20558),
    Cooldown = 180,                     -- Wehn you kill the same player in this time you become not gold or item (set to 0 for disable)
};

function TokenSystem.OnPlayerKill(event, killer, killed)
    local Receiver = killer:GetGUIDLow()
    local KillerName = killer:GetName()
    local KilledName = killed:GetName()

    if (TokenSystem.Settings.WorldAnnounce == true) then
        SendWorldMessage(string.format("%s |Hplayer:%s|h[%s]|h killed |Hplayer:%s|h[%s]|h", TokenSystem.Settings.Name, KillerName, KillerName, KilledName, KilledName))
    end

    if (TokenSystem.Settings.ItemOrGold ~= 2) then
        if killed:GetLuaCooldown() == 0 then
            if (killer:AddItem(TokenSystem.Settings.ItemEntry, TokenSystem.Settings.ItemCount)) then
                if (TokenSystem.Settings.ItemCount == 1) then
                    killer:SendBroadcastMessage(string.format("%s |CFF20C000 You get: %s|CFF20C000.|r", TokenSystem.Settings.Name, TokenSystem.Settings.ItemName))
                    killed:SetLuaCooldown(TokenSystem.Settings.Cooldown)
                else
                    killer:SendBroadcastMessage(string.format("%s |CFF20C000 You get: %s|CFF20C000 x%s.|r", TokenSystem.Settings.Name, TokenSystem.Settings.ItemNamem, TokenSystem.Settings.ItemCount))
                    killed:SetLuaCooldown(TokenSystem.Settings.Cooldown)
                end
            else
                killer:SendBroadcastMessage(string.format("%s |cffff0000 Your bags are full, we will send it by mail.|r", TokenSystem.Settings.Name))
                SendMail("Token System", "Your Bags are full we send via Mail", Receiver, nil, 41, nil, TokenSystem.Settings.ItemEntry, TokenSystem.Settings.ItemCount)
                killed:SetLuaCooldown(TokenSystem.Settings.Cooldown)
            end
        else
            killer:SendBroadcastMessage(string.format("%s Set Cooldown for %s, to %s seconds for next token kill", TokenSystem.Settings.Name, KilledName, math.ceil(killed:GetLuaCooldown())))
            killed:SendBroadcastMessage(string.format("%s Set YOUR Cooldown, to %s seconds for next token kill", TokenSystem.Settings.Name, math.ceil(killed:GetLuaCooldown())))
        end
    end

    if (TokenSystem.Settings.ItemOrGold ~= 1) then
        if killed:GetLuaCooldown() == 0 then
            killer:ModifyMoney(TokenSystem.Settings.GoldCount)
            killer:SendBroadcastMessage(string.format("%s |CFF20C000 You get: %s|CFF20C000 Copper.|r", TokenSystem.Settings.Name, TokenSystem.Settings.GoldCount))
            killed:SetLuaCooldown(TokenSystem.Settings.Cooldown)
        else
            killer:SendBroadcastMessage(string.format("%s Set Cooldown for %s, to %s seconds for next token kill", TokenSystem.Settings.Name, KilledName, math.ceil(killed:GetLuaCooldown())))
            killed:SendBroadcastMessage(string.format("%s Set YOUR Cooldown, to %s seconds for next token kill", TokenSystem.Settings.Name, math.ceil(killed:GetLuaCooldown())))
        end
    end
end

RegisterPlayerEvent(6, TokenSystem.OnPlayerKill)
