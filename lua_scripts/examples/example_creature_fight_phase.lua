local NPC_EXAMPLE=

local NpcExample = {}

function NpcExample.OnEnterCombat(event, creature, target)        -- Start Phase 1
    creature:SendUnitSay("Phase 1", 0, target)
    creature:RegisterEvent(NpcExample.OnPhase_2, 1000, 0)
end

function NpcExample.OnPhase_2(event, delay, pCall, creature)      -- Start Phase 2
    if (creature:GetHealthPct() < 75) then
        creature:RemoveEvents()
        creature:SendUnitSay("Phase 2", 0, target)
        creature:RegisterEvent(NpcExample.OnPhase_3, 1000, 0)
    end
end

function NpcExample.OnPhase_3(event, delay, pCall, creature)      -- Start Phase 3
    if (creature:GetHealthPct() < 50) then
        creature:RemoveEvents()
        creature:SendUnitSay("Phase 3", 0, target)
        creature:RegisterEvent(NpcExample.OnPhase_4, 1000, 0)
    end
end

function NpcExample.OnPhase_4(event, delay, pCall, creature)      -- Start Phase 4
    if (creature:GetHealthPct() < 25) then
        creature:RemoveEvents()
        creature:SendUnitSay("Phase 4", 0, target)
    end
end

function NpcExample.OnLeaveCombat(event, creature)
    creature:SendUnitSay("On Leave Combat", 0, target)
    creature:RemoveEvents()
end

function NpcExample.OnTargetDied(event, creature, victim)
    creature:SendUnitSay("On Target Died", 0, target)
end

function NpcExample.OnDied(event, creature, killer)
    creature:SendUnitSay("On Died", 0, target)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_EXAMPLE, 1, NpcExample.OnEnterCombat)
RegisterCreatureEvent(NPC_EXAMPLE, 2, NpcExample.OnLeaveCombat)
RegisterCreatureEvent(NPC_EXAMPLE, 3, NpcExample.OnTargetDied)
RegisterCreatureEvent(NPC_EXAMPLE, 4, NpcExample.OnDied)