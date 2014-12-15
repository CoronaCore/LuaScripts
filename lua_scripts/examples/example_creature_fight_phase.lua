local NPC_EXAMPLE =

local NpcExample = {}

local NpcExampleSay= {
    [1] = "Start Phase 1",
    [2] = "Phase 1 runs",
    [3] = "Start Phase 2",
    [4] = "Phase 2 runs",
    [5] = "Start Phase 3",
    [6] = "Phase 3 runs",
    [7] = "Start Phase 4",
    [8] = "Phase 4 runs",
    [9] = "On Leave Combat",
    [10] = "On Target Died",
    [11] = "On Died";
};

local NpcExampleSpells= {
    [1] = 8282;
};

function NpcExample.OnEnterCombat(event, creature, target)        -- Start Phase 1 at 100% Health
    creature:SendUnitSay(NpcExampleSay[1], 0)                     -- NPC Say
    creature:RegisterEvent(NpcExample.OnPhase_1_Say, 5000, 0)
    creature:RegisterEvent(NpcExample.OnPhase_2, 1000, 0)         -- Check for next Phase
end

function NpcExample.OnPhase_1_Say(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), NpcExampleSpells[1]) -- Npc Cast Spell
    creature:SendUnitSay(NpcExampleSay[2], 0)                     -- NPC Say
end

function NpcExample.OnPhase_2(event, delay, pCall, creature)
    if (creature:GetHealthPct() <= 75) then                       -- Start Phase 2 at 75% Health
        creature:RemoveEvents()
        creature:SendUnitSay(NpcExampleSay[3], 0)                 -- Npc Say
        creature:RegisterEvent(NpcExample.OnPhase_2_Say, 5000, 0)
        creature:RegisterEvent(NpcExample.OnPhase_3, 1000, 0)     -- Check for next Phase
    end
end

function NpcExample.OnPhase_2_Say(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), NpcExampleSpells[1]) -- Npc Cast Spell
    creature:SendUnitSay(NpcExampleSay[4], 0)                     -- Npc Say
end

function NpcExample.OnPhase_3(event, delay, pCall, creature)
    if (creature:GetHealthPct() <= 50) then                       -- Start Phase 3 at 50% Health
        creature:RemoveEvents()
        creature:SendUnitSay(NpcExampleSay[5], 0)                 -- Npc Say
        creature:RegisterEvent(NpcExample.OnPhase_3_Say, 5000, 0)
        creature:RegisterEvent(NpcExample.OnPhase_4, 1000, 0)     -- Check for next Phase
    end
end

function NpcExample.OnPhase_3_Say(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), NpcExampleSpells[1]) -- Npc Cast Spell
    creature:SendUnitSay(NpcExampleSay[6], 0)                     -- Npc Say
end

function NpcExample.OnPhase_4(event, delay, pCall, creature)
    if (creature:GetHealthPct() <= 25) then                       -- Start Phase 4 at 25% Health
        creature:RemoveEvents()
        creature:SendUnitSay(NpcExampleSay[7], 0)                 -- Npc Say
        creature:RegisterEvent(NpcExample.OnPhase_4_Say, 5000, 0)
    end
end

function NpcExample.OnPhase_4_Say(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), NpcExampleSpells[1]) -- Npc Cast Spell
    creature:SendUnitSay(NpcExampleSay[8], 0)                     -- Npc Say
end

function NpcExample.OnLeaveCombat(event, creature)
    creature:SendUnitSay(NpcExampleSay[9], 0)                     -- Npc Say
    creature:RemoveEvents()
end

function NpcExample.OnTargetDied(event, creature, victim)
    creature:SendUnitSay(NpcExampleSay[10], 0)                    -- Npc Say
end

function NpcExample.OnDied(event, creature, killer)
    creature:SendUnitSay(NpcExampleSay[11], 0)                    -- Npc Say
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_EXAMPLE, 1, NpcExample.OnEnterCombat)
RegisterCreatureEvent(NPC_EXAMPLE, 2, NpcExample.OnLeaveCombat)
RegisterCreatureEvent(NPC_EXAMPLE, 3, NpcExample.OnTargetDied)
RegisterCreatureEvent(NPC_EXAMPLE, 4, NpcExample.OnDied)