-- Include sc_default
require "lua_scripts/base/sc_default"

local QueueAlliance = CreateQueue()
local QueueHorde = CreateQueue()

function QueueOnChat(event, player, msg, _, lang)
local GUID = player:GetGUID()
    if (msg == "#SetQueue") then
        if (player:GetTeam() == 0) then
            QueueAlliance:Set(GUID)
            player:SendBroadcastMessage("Join Queue")
        else
            QueueHorde:Set(GUID)
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
        player:SendBroadcastMessage("Queue Alliance "..QueueAlliance:Count().." Queue Horde "..QueueHorde:Count().."")
    end
end

RegisterPlayerEvent(18, QueueOnChat)