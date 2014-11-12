--[[
    Sunwell Trash NPC´s Event
    Script 90% Complete
    Small Bugs must be fix, check commands in Script
    Author´s (Rochet, Salja, Foereaper)
--]]

local NPC_SUNBLADE_SCOUT = 25372
local NPC_SUNBLADE_PROTECTOR = 25507

local SAY_SUNBLADE_SCOUT_1 = "Balalalalala"  -- not right text

local function SunbladeScoutGoProtector(eventId, delay, repeats, creature)
    creature:MoveIdle()
    creature:SetWalk(false)
    local target = creature:GetNearestCreature(1000, NPC_SUNBLADE_PROTECTOR)
    local x, y, z = target:GetRelativePoint(13, target:GetAngle(creature)-target:GetO())
    creature:MoveTo(1, x, y, z)
end
 
local function SunbladeScoutOnEnterCombat(event, creature, player)
    creature:SendUnitYell(SAY_SUNBLADE_SCOUT_1, 0)
    creature:SetFlag(59, 0x00020000)
    creature:SetFlag(60, 0x00008000)
    creature:RegisterEvent(SunbladeScoutGoProtector, 0, 1)
end
 
local function Enable(eventId, delay, repeats, creature)
    creature:RemoveFlag(59, 0x00020000)
    creature:RemoveFlag(60, 0x00008000)
    creature:MoveChase(creature:GetVictim())
end
 
local function SunbladeScoutOnWp(event, creature, type, id)
    if (type == 8 and id == 1) then
        local target = creature:GetNearestCreature(100, NPC_SUNBLADE_PROTECTOR)
        if(target) then
            creature:RegisterEvent(Enable, 6000, 1)
            creature:CastSpell(target, 46475)
        end
    end
end

local function ActiveProtector(eventId, delay, repeats, creature, caster)
     caster:SendUnitYell(SAY_SUNBLADE_SCOUT_1, 0)
     creature:SendUnitYell(SAY_SUNBLADE_SCOUT_1, 0)
end

local function SunbaldeProtectorOnHitBySpell(event, creature, caster, spellid)
	if (spellid == 46475) then
        creature:RegisterEvent(function(a,b,c,d) ActiveProtector,(a,b,c,d, caster:GetGUID()) end, 6000, 1)
    end
end

local function SunbladeScoutOnReset(event, creature)
    creature:RemoveFlag(59, 0x00020000)
    creature:RemoveFlag(60, 0x00008000)
    creature:MoveWaypoint()
    creature:SetWalk(true)
end
 
local function SunbladeScoutOnLeaveCombat(event, creature)
    creature:RemoveFlag(59, 0x00020000)
    creature:RemoveFlag(60, 0x00008000)
    creature:MoveWaypoint()
    creature:SetWalk(true)
end

local function SunbladeScoutOnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_SUNBLADE_SCOUT, 1, SunbladeScoutOnEnterCombat)
RegisterCreatureEvent(NPC_SUNBLADE_SCOUT, 6, SunbladeScoutOnWp)
RegisterCreatureEvent(NPC_SUNBLADE_SCOUT, 24, SunbladeScoutOnLeaveCombat)
RegisterCreatureEvent(NPC_SUNBLADE_SCOUT, 23, SunbladeScoutOnReset)
RegisterCreatureEvent(NPC_SUNBLADE_SCOUT, 4, SunbladeScoutOnDied)
RegisterCreatureEvent(NPC_SUNBLADE_PROTECTOR, 14, SunbaldeProtectorOnHitBySpell)
