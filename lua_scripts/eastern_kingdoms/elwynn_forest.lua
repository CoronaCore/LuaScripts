--[==[
    Kobold Vermin - Random Say on Aggro
    NPC Entry 6
    Script Complete 100%
]==]

local NPC_KOBOLD_VERMIN = 6

local KoboldVermin = {}

local NpcKoboldVerminSay= {
    [1] = "You no take candle!",
    [2] = "Yiieeeee! Me run!";
};

function KoboldVermin.OnEnterCombat(event, creature, target)
    local chance = math.random(1, 2)

    if (chance == 1) then
        creature:SendUnitSay(NpcKoboldVerminSay[1], 0)
    elseif (chance == 2) then
        creature:SendUnitSay(NpcKoboldVerminSay[2], 0)
    end
end

function KoboldVermin.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_KOBOLD_VERMIN, 1, KoboldVermin.OnEnterCombat)
RegisterCreatureEvent(NPC_KOBOLD_VERMIN, 2, KoboldVermin.OnLeaveCombat)

--[==[
    Defias Thug - Random Say on Aggro
    NPC Entry 38
    cript Complete 100%
]==]

local NPC_DEFIAS_THUG = 38

local DefiasThug = {}

local NpcDefiasThugSay= {
    [1] = "The Brotherhood will not tolerate your actions.",
    [2] = "Ah, a chance to use this freshly sharpened blade.",
    [3] = "Feel the power of the Brotherhood!";
};

function DefiasThug.OnEnterCombat(event, creature, target)
    local chance = math.random(1, 3)

    if (chance == 1) then
        creature:SendUnitSay(NpcDefiasThugSay[1], 0)
    elseif (chance == 2) then
        creature:SendUnitSay(NpcDefiasThugSay[2], 0)
    elseif (chance == 3) then
        creature:SendUnitSay(NpcDefiasThugSay[3], 0)
    end
end

function DefiasThug.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_DEFIAS_THUG, 1, DefiasThug.OnEnterCombat)
RegisterCreatureEvent(NPC_DEFIAS_THUG, 2, DefiasThug.OnLeaveCombat)

--[==[
    Thuros Lightfingers - Random Say on Aggro
    NPC Entry 61
    Script Complete 100%
]==]

local NPC_THUROS_LIGHTFINGERS = 61

local ThurosLightfingers = {}

local NpcThurosLightfingersSay= {
    [1] = "The Brotherhood will not tolerate your actions.",
    [2] = "Ah, a chance to use this freshly sharpened blade.",
    [3] = "Feel the power of the Brotherhood!";
};

function ThurosLightfingers.OnEnterCombat(event, creature, target)
    local chance = math.random(1, 3)

    if (chance == 1) then
        creature:SendUnitSay(NpcThurosLightfingersSay[1], 0)
    elseif (chance == 2) then
        creature:SendUnitSay(NpcThurosLightfingersSay[2], 0)
    elseif (chance == 3) then
        creature:SendUnitSay(NpcThurosLightfingersSay[3], 0)
    end
end

function ThurosLightfingers.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_THUROS_LIGHTFINGERS, 1, ThurosLightfingers.OnEnterCombat)
RegisterCreatureEvent(NPC_THUROS_LIGHTFINGERS, 2, ThurosLightfingers.OnLeaveCombat)

--[==[
    Kobold Labourer - Random Say on Aggro
    NPC Entry 80
    Script Complete 100%
]==]

local NPC_KOBOLD_LABOURER = 80

local KoboldLabourer = {}

local NpcKoboldLabourerSay= {
    [1] = "You no take candle!",
    [2] = "Yiieeeee! Me run!";
};

function KoboldLabourer.OnEnterCombat(event, creature, target)
    local chance = math.random(1, 2)

    if (chance == 1) then
        creature:SendUnitSay(NpcKoboldLabourerSay[1], 0)
    elseif (chance == 2) then
        creature:SendUnitSay(NpcKoboldLabourerSay[2], 0)
    end
end

function KoboldLabourer.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_KOBOLD_LABOURER, 1, KoboldLabourer.OnEnterCombat)
RegisterCreatureEvent(NPC_KOBOLD_LABOURER, 2, KoboldLabourer.OnLeaveCombat)
