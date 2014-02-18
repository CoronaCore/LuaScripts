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