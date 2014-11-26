local NPC_ENTRY =
local QUEST_ENTRY =

local NpcSay= {
    [1] = "Example OnQuestReward Works";
};

local function OnQuestReward(event, player, creature, quest)
    if (quest:GetId() == QUEST_ENTRY) then
        creature:SendUnitSay(NpcSay[1], 0)
    end
end

RegisterCreatureEvent(NPC_ENTRY, 34, OnQuestReward)
