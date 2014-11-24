--[==[
    NOTE: Very Alpha and still in developement
]==]

-- Include sc_default
require "lua_scripts/base/sc_default"

local QueueSystem= {
    ["BattleZone"] = {"|CFFFF0303Tarren Mill vs. Southshore|r", 0, 267},
    ["MinCountAlliance"] = 1,
    ["MinCountHorde"] = 0,
    ["MaxScore"] = 2,
    [0] = 0,
    [1] = 0;
};

local QueueAlliance = CreateQueue()
local QueueHorde = CreateQueue()

function QueueOnChat(event, player, msg, _, lang)
local GUID = player:GetGUID()
    if (msg == "#SetQueue") then
        if QueueAlliance:Has(GUID) or QueueHorde:Has(GUID) then
            player:SendBroadcastMessage("You are already in the Queue for "..QueueSystem["BattleZone"][1].."")
        else
            if (player:GetTeam() == 0) then
                QueueAlliance:Set(GUID)
                player:RegisterEvent(QueueCheck, 10000, 0)
                player:SendBroadcastMessage("Join Queue for "..QueueSystem["BattleZone"][1].."")
            else
                QueueHorde:Set(GUID)
                player:RegisterEvent(QueueCheck, 10000, 0)
                player:SendBroadcastMessage("Join Queue for "..QueueSystem["BattleZone"][1].."")
            end
        end
    elseif (msg == "#RemoveQueue") then
        if QueueAlliance:Has(GUID) or QueueHorde:Has(GUID) then
            if (player:GetTeam() == 0) then
                QueueAlliance:Remove(GUID)
                player:RemoveAura(32609)
                player:SendBroadcastMessage("Leave Queue "..QueueSystem["BattleZone"][1].."")
                print("[Queue System] Player "..player:GetName().." Leave Queue")
            else
                QueueHorde:Remove(GUID)
                player:RemoveAura(32610)
                player:SendBroadcastMessage("Leave Queue "..QueueSystem["BattleZone"][1].."")
                print("[Queue System] Player "..player:GetName().." Leave Queue")
            end
        else
            player:SendBroadcastMessage("They are in no Queue")
        end
    elseif (msg == "#HasQueue") then
        if QueueAlliance:Has(GUID) or QueueHorde:Has(GUID) then
            player:SendBroadcastMessage("You IN Queue for "..QueueSystem["BattleZone"][1].."")
        else
            player:SendBroadcastMessage("You NOT in Queue for "..QueueSystem["BattleZone"][1].."")
        end
    elseif (msg == "#CountQueue") then
        player:SendBroadcastMessage("Queue "..QueueSystem["BattleZone"][1].." |CFF0042FFAlliance|r "..QueueAlliance:Count().."/"..QueueSystem["MinCountAlliance"].." Queue |CFFFF0303Horde|r "..QueueHorde:Count().."/"..QueueSystem["MinCountHorde"].."")
    end
end

function QueueOnSelect(event, player, _, sender, intid, code)
    if (intid == 1) then
        if (player:GetTeam() == 0) then
            player:Teleport(0, -613.069, -512.968, 35.2413, 0.462777)
            player:CastSpell(player, 32609)
            print("[Queue System] Player "..player:GetName().." Accept the Battle")
        else
            player:Teleport(0, -613.069, -512.968, 35.2413, 0.462777)
            player:CastSpell(player, 32610)
            print("[Queue System] Player "..player:GetName().." Accept the Battle")
        end
    end
end

function QueueCheck(event, delay, pCall, player)
    if (QueueAlliance:Count() == QueueSystem["MinCountAlliance"] and QueueHorde:Count() == QueueSystem["MinCountHorde"]) then
        player:GossipMenuAddItem(4, "", 0, 1, false, ""..QueueSystem["BattleZone"][1].."")
        player:GossipSendMenu(0x7FFFFFFF, player, 100)
        player:RemoveEvents()
        print("[Queue System] Queue full start "..QueueSystem["BattleZone"][1].."")
    else
        print("[Queue System] Queue Alliance "..QueueAlliance:Count().."/"..QueueSystem["MinCountAlliance"].." Queue Horde "..QueueHorde:Count().."/"..QueueSystem["MinCountHorde"].."")
    end
end

function QueueOnLogut(event, player)
local GUID = player:GetGUID()
    if QueueAlliance:Has(GUID) or QueueHorde:Has(GUID) then
        if (player:GetTeam() == 0) then
            QueueAlliance:Remove(GUID)
            player:RemoveAura(32609)
            player:SaveToDB()
            print("[Queue System] Player "..player:GetName().." Leave Queue")
        else
            QueueHorde:Remove(GUID)
            player:RemoveAura(32610)
            player:SaveToDB()
            print("[Queue System] Player "..player:GetName().." Leave Queue")
        end
    end
end

function QueueOnEnterArea(event, player, newZone, newArea)
local GUID = player:GetGUID()
    if (player:GetMapId() == QueueSystem["BattleZone"][2]) and (player:GetZoneId() == QueueSystem["BattleZone"][3]) then
        player:InitializeWorldState(1, 1377, 0, 1)
        player:UpdateWorldState(2317, QueueSystem["MaxScore"])
        player:UpdateWorldState(2313, QueueSystem[0])
        player:UpdateWorldState(2314, QueueSystem[1])
    end

    if (player:GetTeam() == 0) then
        if (player:GetZoneId() == QueueSystem["BattleZone"][3]) then
--
        else
            player:RemoveAura(32609)
            -- QueueAlliance:Remove(GUID)
        end
    else
        if (player:GetZoneId() == QueueSystem["BattleZone"][3]) then
--
        else
            player:RemoveAura(32610)
            -- QueueHorde:Remove(GUID)
        end
    end
end

RegisterPlayerEvent(18, QueueOnChat)
RegisterPlayerEvent(4, QueueOnLogut)
RegisterPlayerGossipEvent(100, 2, QueueOnSelect)
RegisterPlayerEvent(27, QueueOnEnterArea)