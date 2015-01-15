-- Include sc_default
require "base/sc_default"

local QueueSettings= {
    ["MinCountAlliance"] = 10,
    ["MinCountHorde"] = 10,
};

local QueueAlliance = CreateQueue()
local QueueHorde = CreateQueue()

function QueueOnChat(event, player, msg, _, lang)
local GUID = player:GetGUID()
    if (msg == "#SetQueue") then
        if (player:GetTeam() == 0) then
            QueueAlliance:Set(GUID)
            player:RegisterEvent(QueueCheck, 10000, 0)
            player:SendBroadcastMessage("Join Queue")
        else
            QueueHorde:Set(GUID)
            player:RegisterEvent(QueueCheck, 10000, 0)
            player:SendBroadcastMessage("Join Queue")
        end
    elseif (msg == "#RemoveQueue") then
        if (player:GetTeam() == 0) then
            QueueAlliance:Remove(GUID)
            player:SendBroadcastMessage("Leave Queue")
        else
            QueueHorde:Remove(GUID)
            player:SendBroadcastMessage("Leave Queue")
        end
    elseif (msg == "#HasQueue") then
        if QueueAlliance:Has(GUID) or QueueHorde:Has(GUID) then
            player:SendBroadcastMessage("You in Queue")
        else
            player:SendBroadcastMessage("You not in Queue")
        end
    elseif (msg == "#CountQueue") then
        player:SendBroadcastMessage("Queue |CFF0042FFAlliance|r "..QueueAlliance:Count().."/"..QueueSettings["MinCountAlliance"].." Queue |CFFFF0303Horde|r "..QueueHorde:Count().."/"..QueueSettings["MinCountHorde"].."")
    end
end

function QueueCheck(event, delay, pCall, player)
    if (QueueAlliance:Count() == QueueSettings["MinCountAlliance"] and QueueHorde:Count() == QueueSettings["MinCountHorde"]) then
        player:SendBroadcastMessage("Queue Full")
        player:RemoveEvents()
    else
        player:SendBroadcastMessage("Queue |CFF0042FFAlliance|r "..QueueAlliance:Count().."/"..QueueSettings["MinCountAlliance"].." Queue |CFFFF0303Horde|r "..QueueHorde:Count().."/"..QueueSettings["MinCountHorde"].."")
    end
end

RegisterPlayerEvent(18, QueueOnChat)