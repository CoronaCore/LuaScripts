-- -- -- -- -- -- -- -- -- -- -- -- --
-- -- PvP Token System by Salja. -- --
-- -- -- -- -- -- -- -- -- -- -- -- --

-- Include sc_default
require "base/sc_default"

PvPToken = {}

-- Settings
PvPToken.Settings = {
    ItemOrGold = 0,                     -- 0 = Gold and Item, 1 = Only Item, 2 = Only Gold
    WorldAnnounce = true,               -- Sends a World Announce false = Off, true = On
    GoldCount = 10000,                  -- Reward in copper
    ItemEntry = 20558,                  -- Warsong Gulch Mark of Honor
    ItemCount = 1,                      -- Count of the Item
    ItemName = GetItemLink(20558),
    KillCooldown = 180,                 -- Wehn you kill the same player in this time you become not gold or item (set to 0 for disable)
};

function PvPToken.OnPlayerKill(event, killer, killed)
    local Receiver = killer:GetGUIDLow()
    local KillerName = killer:GetName()
    local KilledName = killed:GetName()

    if (PvPToken.Settings.WorldAnnounce == true) then
        SendWorldMessage(string.format("[PVP] |Hplayer:%s|h[%s]|h killed |Hplayer:%s|h[%s]|h", KillerName, KillerName, KilledName, KilledName))
    end

    if (PvPToken.Settings.ItemOrGold ~= 2) then
        if killed:GetLuaCooldown() == 0 then
            if (killer:AddItem(PvPToken.Settings.ItemEntry, PvPToken.Settings.ItemCount)) then
                if (PvPToken.Settings.ItemCount == 1) then
                    killer:SendBroadcastMessage("|CFF20C000 You get: "..PvPToken.Settings.ItemName.."|CFF20C000.|r")
                    killed:SetLuaCooldown(PvPToken.Settings.KillCooldown)
                else
                    killer:SendBroadcastMessage("|CFF20C000 You get: "..PvPToken.Settings.ItemName.."|CFF20C000 x"..PvPToken.Settings.ItemCount..".|r")
                    killed:SetLuaCooldown(PvPToken.Settings.KillCooldown)
                end
            else
                killer:SendBroadcastMessage("|cffff0000 Your bags are full, we will send it by mail.|r")
                SendMail("PvP Token System", "Your Bags are full we send via Mail", Receiver, nil, 41, nil, PvPToken.Settings.ItemEntry, PvPToken.Settings.ItemCount)
                killed:SetLuaCooldown(PvPToken.Settings.KillCooldown)
            end
        else
            killer:SendBroadcastMessage(string.format("Set Cooldown for %s, to %s seconds for next token kill", KilledName, math.ceil(killed:GetLuaCooldown())))
            killed:SendBroadcastMessage(string.format("Set YOUR Cooldown, to %s seconds for next token kill", math.ceil(killed:GetLuaCooldown())))
        end
    end

    if (PvPToken.Settings.ItemOrGold ~= 1) then
        if killed:GetLuaCooldown() == 0 then
            killer:ModifyMoney(PvPToken.Settings.GoldCount)
            killer:SendBroadcastMessage("|CFF20C000 You get: "..PvPToken.Settings.GoldCount.."|CFF20C000 Copper.|r")
            killed:SetLuaCooldown(PvPToken.Settings.KillCooldown)
        else
            killer:SendBroadcastMessage(string.format("Set Cooldown for %s, to %s seconds for next token kill", KilledName, math.ceil(killed:GetLuaCooldown())))
            killed:SendBroadcastMessage(string.format("Set YOUR Cooldown, to %s seconds for next token kill", math.ceil(killed:GetLuaCooldown())))
        end
    end
end

RegisterPlayerEvent(6, PvPToken.OnPlayerKill)