--[==[
]==]

-- Include sc_default
require "base/sc_default"

TimeMorph = {}

TimeMorphName = "|CFF1CB619[Morph System]|r"

TimeMorph.Settings = {
    NpcActive = true,
    NpcEntry = 60000,
    ItemActive = true,
    ItemEntry = 70000,
    MorphTime = 25,
};

-- Icon, Name, DisplayID, Scale
TimeMorph.Displays = {
    [1] = { "|TInterface\\icons\\INV_Hammer_01.png:30:30:-15:0|t", "Kael Sunstrider", 20023, 0.3 },
    [2] = { "|TInterface\\icons\\INV_Hammer_01.png:30:30:-15:0|t", "Maiev Shadowsong", 20628, 0.7 },
    [3] = { "|TInterface\\icons\\INV_Hammer_01.png:30:30:-15:0|t", "Rexxar Champion of the Horde ", 20918, 0.5 },
    [4] = { "|TInterface\\icons\\INV_Hammer_01.png:30:30:-15:0|t", "Archmond", 18292, 0.03 },
    [5] = { "|TInterface\\icons\\INV_Hammer_01.png:30:30:-15:0|t", "Lady Sinestra", 21401, 0.2 },
    [6] = { "|TInterface\\icons\\INV_Hammer_01.png:30:30:-15:0|t", "Champion Sunstrike", 17261, 1 },
    [7] = { "|TInterface\\icons\\INV_Hammer_01.png:30:30:-15:0|t", "Champion Swiftblade", 17260, 1 },
    [8] = { "|TInterface\\icons\\INV_Hammer_01.png:30:30:-15:0|t", "Illidan Storimrage", 21135, 0.3 },
    [9] = { "|TInterface\\icons\\INV_Hammer_01.png:30:30:-15:0|t", "Al'ar", 18945, 0.2 },
};

function TimeMorph.OnGossipHello(event, player, unit)
    if player:GetLuaCooldown(3) == 0 then
        player:GossipSetText(string.format("Welcome %s in %s\n\nYou will Morph for |CFFFF0000%s|r sconds", player:GetName(), TimeMorphName, TimeMorph.Settings.MorphTime))
        for i, v in ipairs(TimeMorph.Displays) do
            player:GossipMenuAddItem(0, ""..v[1]..""..v[2].."", i, 1)
        end
    else
        player:GossipSetText(string.format("Welcome %s in %s\n\nYou are Morphed you must DeMorph befor you can add a new Morph", player:GetName(), TimeMorphName))
        player:GossipMenuAddItem(0, "|TInterface/ICONS/INV_Enchant_Disenchant:30:30:-15:0|tDeMorph Me", 0, 2)
        player:GossipMenuAddItem(0, "|TInterface/ICONS/Ability_Spy:30:30:-15:0|tClose Menue", 0, 3)
    end
    player:GossipSendMenu(0x7FFFFFFF, unit)
end

function TimeMorph.OnGossipSelect(event, player, unit, sender, intid, code)

    if (intid == 1) then
        local Icon, Name, DisplayID, Scale = table.unpack(TimeMorph.Displays[sender])
        player:SetDisplayId(DisplayID)
        player:SetScale(Scale)
        player:SetLuaCooldown(TimeMorph.Settings.MorphTime, 3)
        player:RegisterEvent(TimeMorph.CooldownCheck, 1000, player:GetLuaCooldown(3))
        player:SendBroadcastMessage(string.format("%s You Morph you will DeMorph in %s seconds!", TimeMorphName, player:GetLuaCooldown(3)))
        player:PlaySoundToPlayer(888)
        player:GossipClearMenu()
        TimeMorph.OnGossipHello(event, player, unit)
    elseif (intid == 2) then
        player:DeMorph()
        player:SetScale(1)
        player:SetLuaCooldown(0, 3)
        player:RemoveEvents()
        player:SendBroadcastMessage(string.format("%s You DeMorph", TimeMorphName))
        player:GossipClearMenu()
        TimeMorph.OnGossipHello(event, player, unit)
    elseif (intid == 3) then
        player:GossipComplete()
    end
end

function TimeMorph.CooldownCheck(event, delay, repeats, player)
    if player:GetLuaCooldown(3) == 0 then
        player:DeMorph()
        player:SetScale(1)
        player:PlaySoundToPlayer(1435)
        player:RemoveEvents()
        player:SendBroadcastMessage(string.format("%s You DeMorph", TimeMorphName))
    elseif player:GetLuaCooldown(3) <= 10 then
        player:SendBroadcastMessage(string.format("%s You will DeMorph in %s seconds!", TimeMorphName, player:GetLuaCooldown(3)))
    end
end

function TimeMorph.OnElunaReload(event)
    for _, v in pairs(GetPlayersInWorld()) do
        v:DeMorph()
        v:SetLuaCooldown(0, 3)
        v:SetScale(1)
    end
end

function TimeMorph.OnLogout(event, player)
    player:DeMorph()
    player:SetLuaCooldown(0, 3)
    player:SetScale(1)
end

if TimeMorph.Settings.NpcActive == false and TimeMorph.Settings.ItemActive == false then
   print("----------------------------------------------")
   print(" Time Morph: Script not loaded check settings ")
   print("               Script by Salja                ")
   print("----------------------------------------------")
end

if TimeMorph.Settings.NpcActive == true then
    RegisterCreatureGossipEvent(TimeMorph.Settings.NpcEntry, 1, TimeMorph.OnGossipHello)
    RegisterCreatureGossipEvent(TimeMorph.Settings.NpcEntry, 2, TimeMorph.OnGossipSelect)

   print("----------------------------------------------")
   print("        Time Morph: NPC Script loaded         ")
   print("               Script by Salja                ")
   print("----------------------------------------------")
end

if TimeMorph.Settings.ItemActive == true then
    RegisterItemGossipEvent(TimeMorph.Settings.ItemEntry, 1, TimeMorph.OnGossipHello)
    RegisterItemGossipEvent(TimeMorph.Settings.ItemEntry, 2, TimeMorph.OnGossipSelect)

   print("----------------------------------------------")
   print("        Time Morph: ITEM Script loaded        ")
   print("               Script by Salja                ")
   print("----------------------------------------------")
end

RegisterPlayerEvent(4, TimeMorph.OnLogout)
RegisterServerEvent(16, TimeMorph.OnElunaReload)
