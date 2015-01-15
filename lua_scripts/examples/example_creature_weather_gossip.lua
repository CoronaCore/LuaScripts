local NPC_ENTRY =

local function TestMenuWeather(event, plr, unit)
    plr:GossipMenuAddItem(0, "Test Weather", 0, 1)
    plr:GossipMenuAddItem(0, "Nevermind..", 0, 2)
    plr:GossipSendMenu(1, unit)
end

local function TestMenuSelectWeather(event, plr, unit, sender, intid, code)
    if (intid == 1) then
        plr:GetMap():SetWeather(plr:GetZoneId(), math.random(0, 3), 1) -- random weather
        plr:GossipComplete()
    elseif (intid == 2) then
        plr:GossipComplete()
    end
end

RegisterCreatureGossipEvent(NPC_ENTRY, 1, TestMenuWeather)
RegisterCreatureGossipEvent(NPC_ENTRY, 2, TestMenuSelectWeather)