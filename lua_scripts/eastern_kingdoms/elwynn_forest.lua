--[==[
    Kobold Vermin - Random Say on Aggro
    NPC Entry 6
    Script Complete 100%
]==]

local NPC_KOBOLD_VERMIN = 6

local KoboldVermin = {}

local KoboldVerminSay= {
    [1] = "You no take candle!",
    [2] = "Yiieeeee! Me run!";
};

function KoboldVermin.OnEnterCombat(event, creature, target)
    local double d = math.random()
    local chance = math.random(1, 2)

    if (d < 0.7) then
        if (chance == 1) then
            creature:SendUnitSay(KoboldVerminSay[1], 0)
        elseif (chance == 2) then
            creature:SendUnitSay(KoboldVerminSay[2], 0)
        end
    end
end

function KoboldVermin.Reset(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_KOBOLD_VERMIN, 1, KoboldVermin.OnEnterCombat)
RegisterCreatureEvent(NPC_KOBOLD_VERMIN, 2, KoboldVermin.Reset)
RegisterCreatureEvent(NPC_KOBOLD_VERMIN, 4, KoboldVermin.Reset)

--[==[
    Defias Thug - Random Say on Aggro
    NPC Entry 38
    cript Complete 100%
]==]

local NPC_DEFIAS_THUG = 38

local DefiasThug = {}

local DefiasThugSay= {
    [1] = "The Brotherhood will not tolerate your actions.",
    [2] = "Ah, a chance to use this freshly sharpened blade.",
    [3] = "Feel the power of the Brotherhood!";
};

function DefiasThug.OnEnterCombat(event, creature, target)
    local double d = math.random()
    local chance = math.random(1, 3)

    if (d < 0.7) then
        if (chance == 1) then
            creature:SendUnitSay(DefiasThugSay[1], 0)
        elseif (chance == 2) then
            creature:SendUnitSay(DefiasThugSay[2], 0)
        elseif (chance == 3) then
            creature:SendUnitSay(DefiasThugSay[3], 0)
        end
    end
end

function DefiasThug.Reset(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_DEFIAS_THUG, 1, DefiasThug.OnEnterCombat)
RegisterCreatureEvent(NPC_DEFIAS_THUG, 2, DefiasThug.Reset)
RegisterCreatureEvent(NPC_DEFIAS_THUG, 4, DefiasThug.Reset)

--[==[
    Thuros Lightfingers - Random Say on Aggro
    NPC Entry 61
    Script Complete 100%
]==]

local NPC_THUROS_LIGHTFINGERS = 61

local ThurosLightfingers = {}

local ThurosLightfingersSay= {
    [1] = "The Brotherhood will not tolerate your actions.",
    [2] = "Ah, a chance to use this freshly sharpened blade.",
    [3] = "Feel the power of the Brotherhood!";
};

function ThurosLightfingers.OnEnterCombat(event, creature, target)
    local double d = math.random()
    local chance = math.random(1, 3)

    if (d < 0.6) then
        if (chance == 1) then
            creature:SendUnitSay(ThurosLightfingersSay[1], 0)
        elseif (chance == 2) then
            creature:SendUnitSay(ThurosLightfingersSay[2], 0)
        elseif (chance == 3) then
            creature:SendUnitSay(ThurosLightfingersSay[3], 0)
        end
    end
end

function ThurosLightfingers.Reset(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_THUROS_LIGHTFINGERS, 1, ThurosLightfingers.OnEnterCombat)
RegisterCreatureEvent(NPC_THUROS_LIGHTFINGERS, 2, ThurosLightfingers.Reset)
RegisterCreatureEvent(NPC_THUROS_LIGHTFINGERS, 4, ThurosLightfingers.Reset)

--[==[
    Kobold Labourer - Random Say on Aggro
    NPC Entry 80
    Script Complete 100%
]==]

local NPC_KOBOLD_LABOURER = 80

local KoboldLabourer = {}

local KoboldLabourerSay= {
    [1] = "You no take candle!",
    [2] = "Yiieeeee! Me run!";
};

function KoboldLabourer.OnEnterCombat(event, creature, target)
    local double d = math.random()
    local chance = math.random(1, 2)

    if (d < 0.7) then
        if (chance == 1) then
            creature:SendUnitSay(KoboldLabourerSay[1], 0)
        elseif (chance == 2) then
            creature:SendUnitSay(KoboldLabourerSay[2], 0)
        end
    end
end

function KoboldLabourer.Reset(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_KOBOLD_LABOURER, 1, KoboldLabourer.OnEnterCombat)
RegisterCreatureEvent(NPC_KOBOLD_LABOURER, 2, KoboldLabourer.Reset)
RegisterCreatureEvent(NPC_KOBOLD_LABOURER, 4, KoboldLabourer.Reset)

--[==[
    Riverpaw Runt - Random Say on Aggro
    Riverpaw Runt - Flee at 15% HP
    NPC Entry 97
    Script Complete 100%
]==]

local NPC_RIVERPAW_RUNT = 97

local RiverpawRunt = {}

local RiverpawRuntSay= {
    [1] = "More bones to gnaw on...",
    [2] = "Grrrr... fresh meat!";
};

function RiverpawRunt.OnEnterCombat(event, creature, target)
    local double d = math.random()
    local chance = math.random(1, 2)

    if (d < 0.7) then
        if (chance == 1) then
            creature:SendUnitSay(RiverpawRuntSay[1], 0)
        elseif (chance == 2) then
            creature:SendUnitSay(RiverpawRuntSay[2], 0)
        end
    end
    creature:RegisterEvent(RiverpawRunt.CheckPhase2, 1000, 0)
end

function RiverpawRunt.CheckPhase2(event, delay, pCall, creature)
    if (creature:GetHealthPct() <= 15) then
        creature:MoveFleeing(creature)
        creature:RemoveEvents()
    end
end

function RiverpawRunt.Reset(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_RIVERPAW_RUNT, 1, RiverpawRunt.OnEnterCombat)
RegisterCreatureEvent(NPC_RIVERPAW_RUNT, 2, RiverpawRunt.Reset)
RegisterCreatureEvent(NPC_RIVERPAW_RUNT, 4, RiverpawRunt.Reset)
