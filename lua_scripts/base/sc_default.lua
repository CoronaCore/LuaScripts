--
-- Cooldown Methods by Foereaper
--
-- player:SetLuaCooldown(seconds) -- Sets the cooldown timer to X seconds
-- player:GetLuaCooldown()        -- Returns cooldown or 0 if none
--

local cooldowns = {};

function Player:SetLuaCooldown(seconds)
    assert(type(self) == "userdata");
    seconds = assert(tonumber(seconds));
    local guid, source = self:GetGUIDLow(), debug.getinfo(2, 'S').short_src;
 
    if (not cooldowns[guid]) then
        cooldowns[guid] = {};
    end
 
    cooldowns[guid][source] = os.clock() + seconds;
end
 
function Player:GetLuaCooldown()
    assert(type(self) == "userdata");
    local guid, source = self:GetGUIDLow(), debug.getinfo(2, 'S').short_src;
 
    if (not cooldowns[guid]) then
        cooldowns[guid] = {};
    end
 
    local cd = cooldowns[guid][source];
    if (not cd or cd < os.clock()) then
        cooldowns[guid][source] = 0
        return 0;
    else
        return cooldowns[guid][source] - os.clock();
    end
end

--
-- GossipSetText Methods by Rochet2
--
-- player:GossipMenuAddItem(0, "Text", 0, 0)
-- player:GossipMenuAddItem(0, "Text", 0, 0)
-- player:GossipSetText("Text")
-- player:GossipSendMenu(0x7FFFFFFF, creature)
--

local SMSG_NPC_TEXT_UPDATE = 384
local MAX_GOSSIP_TEXT_OPTIONS = 8

function Player:GossipSetText(text)
    data = CreatePacket(SMSG_NPC_TEXT_UPDATE, 100);
    data:WriteULong(0x7FFFFFFF)
    for i = 1, MAX_GOSSIP_TEXT_OPTIONS do
        data:WriteFloat(0)     -- Probability
        data:WriteString(text) -- Text
        data:WriteString(text) -- Text
        data:WriteULong(0)     -- language
        data:WriteULong(0)     -- emote
        data:WriteULong(0)     -- emote
        data:WriteULong(0)     -- emote
        data:WriteULong(0)     -- emote
        data:WriteULong(0)     -- emote
        data:WriteULong(0)     -- emote
    end
    self:SendPacketToPlayer(data)
end