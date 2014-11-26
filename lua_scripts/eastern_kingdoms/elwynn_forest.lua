--[==[
    Kobold Vermin - Random Say on Aggro
    NPC Entry 6
    Script Complete 100%
]==]

NPC_KOBOLD_VERMIN = 6

local NpcKoboldVerminSay= {
    [1] = "You no take candle!",
    [2] = "Yiieeeee! Me run!";
};

local function KoboldVerminOnEnterCombat(event, creature, target)
    local chance = math.random(1, 2)

    if (chance == 1) then
        creature:SendUnitSay(NpcKoboldVerminSay[1], 0)
    elseif (chance == 2) then
        creature:SendUnitSay(NpcKoboldVerminSay[2], 0)
    end
end

local function KoboldVerminOnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_KOBOLD_VERMIN, 1, KoboldVerminOnEnterCombat)
RegisterCreatureEvent(NPC_KOBOLD_VERMIN, 2, KoboldVerminOnLeaveCombat)

--[==[
    Defias Thug - Random Say on Aggro
    NPC Entry 38
    cript Complete 100%
]==]

NPC_DEFIAS_THUG = 38

local NpcDefiasThugSay= {
    [1] = "The Brotherhood will not tolerate your actions.",
    [2] = "Ah, a chance to use this freshly sharpened blade.",
    [3] = "Feel the power of the Brotherhood!";
};

local function DefiasThugOnEnterCombat(event, creature, target)
    local chance = math.random(1, 3)

    if (chance == 1) then
        creature:SendUnitSay(NpcDefiasThugSay[1], 0)
    elseif (chance == 2) then
        creature:SendUnitSay(NpcDefiasThugSay[2], 0)
    elseif (chance == 3) then
        creature:SendUnitSay(NpcDefiasThugSay[3], 0)
    end
end

local function DefiasThugOnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_DEFIAS_THUG, 1, DefiasThugOnEnterCombat)
RegisterCreatureEvent(NPC_DEFIAS_THUG, 2, DefiasThugOnLeaveCombat)

--[==[
    Thuros Lightfingers - Random Say on Aggro
    NPC Entry 61
    Script Complete 100%
]==]

NPC_THUROS_LIGHTFINGERS = 61

local NpcThurosLightfingersSay= {
    [1] = "The Brotherhood will not tolerate your actions.",
    [2] = "Ah, a chance to use this freshly sharpened blade.",
    [3] = "Feel the power of the Brotherhood!";
};

local function ThurosLightfingersOnEnterCombat(event, creature, target)
    local chance = math.random(1, 3)

    if (chance == 1) then
        creature:SendUnitSay(NpcThurosLightfingersSay[1], 0)
    elseif (chance == 2) then
        creature:SendUnitSay(NpcThurosLightfingersSay[2], 0)
    elseif (chance == 3) then
        creature:SendUnitSay(NpcThurosLightfingersSay[3], 0)
    end
end

local function ThurosLightfingersOnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_THUROS_LIGHTFINGERS, 1, ThurosLightfingersOnEnterCombat)
RegisterCreatureEvent(NPC_THUROS_LIGHTFINGERS, 2, ThurosLightfingersOnLeaveCombat)

--[==[
    Kobold Labourer - Random Say on Aggro
    NPC Entry 80
    Script Complete 100%
]==]

NPC_KOBOLD_LABOURER = 80

local NpcKoboldLabourerSay= {
    [1] = "You no take candle!",
    [2] = "Yiieeeee! Me run!";
};

local function KoboldLabourerOnEnterCombat(event, creature, target)
    local chance = math.random(1, 2)

    if (chance == 1) then
        creature:SendUnitSay(NpcKoboldLabourerSay[1], 0)
    elseif (chance == 2) then
        creature:SendUnitSay(NpcKoboldLabourerSay[2], 0)
    end
end

local function KoboldLabourerOnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_KOBOLD_LABOURER, 1, KoboldLabourerOnEnterCombat)
RegisterCreatureEvent(NPC_KOBOLD_LABOURER, 2, KoboldLabourerOnLeaveCombat)
