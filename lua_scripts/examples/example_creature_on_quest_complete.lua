local NpcId =
local QuestId =

local SAY_01 = "Example OnQuestReward Works"

local function OnQuestReward(event, player, creature, quest)
    if (quest:GetId() == QuestId) then
        creature:SendUnitSay(SAY_01, 0)
    end
end

RegisterCreatureEvent(NpcId, 34, OnQuestReward)
