--[==[
    NOTE: need to insert character_rules.sql in your characters database
          for better work skip the cinematic in your mangosd.conf
]==]

-- Include sc_default
require "base/sc_default"
require "base/sc_rules"

-- Rules Settings
RulesSystem.Settings = {
    OnLogin = true,
    OnChat = true,
    Cooldown = 30,
    Spell = 9454,
};

-- Rules Texts
RulesSystem.Texts = {
    [0] = "|CFFFF0303Server Rules!|r",
    [1] = "|CFFFFFF01Welcome on CoronaCore Server|r",
    [2] = "TEXT TEXT TEXT TEXT TEXT TEXT  TEXT TEXT TEXT TEXT  TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT",
    [3] = "|CFFFF0303Server Infos!|r",
    [4] = "TEXT TEXT TEXT TEXT TEXT TEXT  TEXT TEXT TEXT TEXT  TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT",
    [5] = "|CFFFFFF01http://your-server.com|r",
};

-- Commands for Rules
RulesSystem.Commands = {
    [0] = "#rules",                                                     -- Show rules
    [1] = "#rules reset",                                               -- Reset Rules for all Player (Only GameMaster can use it)
    [2] = "#rules send all",                                            -- Send Rules Window to all Online Players
    [3] = "#rules send player",                                         -- Send Rules Window to player %s
};

if (RulesSystem.Commands[3]:sub(-1) ~= " ") then
    RulesSystem.Commands[3] = RulesSystem.Commands[3].." ";
end

function RulesSystem.OnChat(event, player, msg, _, lang)                -- Use "#rules" for sending rules
    local RulesPlayer = RulesSystem(player)

    if (msg == RulesSystem.Commands[0]) and RulesSystem.Settings.OnChat == true then
        RulesSystem.OnGossipHello(event, player)
        return false;
    elseif (msg == RulesSystem.Commands[1]) and player:IsGM() == true then
        RulesPlayer:Reset()
        player:SendBroadcastMessage(string.format("%s Rules updatet pls accept again.", RulesSystemName))
        return false;
    elseif (msg == RulesSystem.Commands[2]) and player:IsGM() == true then
        for _, p in ipairs(GetPlayersInWorld()) do
            RulesSystem.OnGossipHello(event, p)
        end
        return false;
    elseif (msg:sub(1, RulesSystem.Commands[3]:len()) == RulesSystem.Commands[3]) and player:IsGM() == true then
        if GetPlayerByName(msg:sub(RulesSystem.Commands[3]:len()+1)) then
            RulesSystem.OnGossipHello(event, GetPlayerByName(msg:sub(RulesSystem.Commands[3]:len()+1)))
        else
            player:SendBroadcastMessage(string.format("%s No player found with name %s", RulesSystemName, msg:sub(RulesSystem.Commands[3]:len()+1)))
        end
        return false;
    end
end

function RulesSystem.OnCharCreate(event, player)
    local RulesPlayer = RulesSystem(player)
    RulesPlayer:SetAccount()                                             -- Insert guid into character_rules on new character create
end

function RulesSystem.OnCharDelete(event, player)
    RulesSystem:DeleteAccount(player)                                    -- Delete guid from character_rules on character delete
end

function RulesSystem.OnLogin(event, player)
    local RulesPlayer = RulesSystem(player)
    local RulesActive = RulesPlayer:IsActive() == true
    local PlayerName = player:GetName()

    if RulesSystem.Settings.OnLogin == true and RulesActive then          -- Check Rules Active on Login
        player:AddAura(RulesSystem.Settings.Spell, player)                -- AddAura frozen to Player
        player:PlaySoundToPlayer(1509)
        player:SendBroadcastMessage(string.format("%s Welcome %s read the rules and accept it you can use #rules for show rules again!", RulesSystemName, PlayerName, RulesCommand))
        player:SetLuaCooldown(RulesSystem.Settings.Cooldown, 2)
        player:RegisterEvent(RulesSystem.CooldownCheck, 1000, player:GetLuaCooldown(2))
    end
end

function RulesSystem.OnGossipHello(event, player)                          -- Show Rules
    player:GossipClearMenu()
    player:GossipMenuAddItem(4, "", 0, 1, false, string.format("%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n", RulesSystem.Texts[0], RulesSystem.Texts[1], RulesSystem.Texts[2], RulesSystem.Texts[3], RulesSystem.Texts[4], RulesSystem.Texts[5], RulesSystem.Texts[5]))
    player:GossipSendMenu(0x7FFFFFFF, player, 200)
end
 
function RulesSystem.OnGossipSelect(event, player, _, sender, intid, code)
    local RulesPlayer = RulesSystem(player)
    local PlayerName = player:GetName()

    if (intid == 1) and player:GetLuaCooldown(2) == 0 then
        player:RemoveAura(RulesSystem.Settings.Spell)                      -- Remove Aura
        RulesPlayer:SetInActive()                                          -- Set Rules Active = false
        player:SendBroadcastMessage(string.format("%s Thanks %s for accept the rules!", RulesSystemName, PlayerName))
        player:PlaySoundToPlayer(888)
        player:GossipComplete()                                            -- Close the Gossip
    end
end

function RulesSystem.CooldownCheck(event, delay, repeats, player)
    local RulesPlayer = RulesSystem(player)
    local PlayerName = player:GetName()

    if player:GetLuaCooldown(2) > 0 then
        for _, v in pairs(GetPlayersInWorld()) do
            player:GossipClearMenu()
            player:GossipMenuAddItem(4, "", 0, 1, false, string.format("%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s\n\n|cffff0000You can accept in |CFFFFFF01%s|r |cffff0000seconds|r\n\n", RulesSystem.Texts[0], RulesSystem.Texts[1], RulesSystem.Texts[2], RulesSystem.Texts[3], RulesSystem.Texts[4], RulesSystem.Texts[5], math.ceil(player:GetLuaCooldown(2))))
            player:GossipSendMenu(0x7FFFFFFF, player, 200)
        end
    else
        RulesSystem.OnGossipHello(event, player)
        player:PlaySoundToPlayer(1150)
        player:RemoveEvents()
    end
end

RegisterPlayerEvent(1, RulesSystem.OnCharCreate)                            -- Register Evenet On Character Create
RegisterPlayerEvent(2, RulesSystem.OnCharDelete)                            -- Register Evenet On Character Create
RegisterPlayerEvent(3, RulesSystem.OnLogin)                                 -- Register Event On Login
RegisterPlayerGossipEvent(200, 2, RulesSystem.OnGossipSelect)               -- Register Event for Gossip Select
RegisterPlayerEvent(18, RulesSystem.OnChat)                                 -- Register Evenet on Chat Command use