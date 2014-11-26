--[[
    Sunwell Trash NPC´s Event
    Script 90% Complete
    Small Bugs must be fix, check commands in Script
    Author´s (Rochet, Salja, Foereaper)
--]]

local NPC_SUNBLADE_SCOUT = 25372
local NPC_SUNBLADE_PROTECTOR = 25507

local SunbladeScout = {}
local SunbaldeProtector = {}

local SunbladeScoutSay= {
    [1] = "not right text";
};

function SunbladeScout.GoProtector(eventId, delay, repeats, creature)
    creature:MoveIdle()
    creature:SetWalk(false)
    local target = creature:GetNearestCreature(1000, NPC_SUNBLADE_PROTECTOR)
    local x, y, z = target:GetRelativePoint(13, target:GetAngle(creature)-target:GetO())
    creature:MoveTo(1, x, y, z)
end
 
function SunbladeScout.OnEnterCombat(event, creature, player)
    creature:SendUnitYell(SunbladeScoutSay[1], 0)
    creature:SetFlag(59, 0x00020000)
    creature:SetFlag(60, 0x00008000)
    creature:RegisterEvent(SunbladeScout.GoProtector, 0, 1)
end
 
function Enable(eventId, delay, repeats, creature)
    creature:RemoveFlag(59, 0x00020000)
    creature:RemoveFlag(60, 0x00008000)
    creature:MoveChase(creature:GetVictim())
end
 
function SunbladeScout.OnWp(event, creature, type, id)
    if (type == 8 and id == 1) then
        local target = creature:GetNearestCreature(100, NPC_SUNBLADE_PROTECTOR)
        if(target) then
            creature:RegisterEvent(Enable, 6000, 1)
            creature:CastSpell(target, 46475)
        end
    end
end

function Active(eventId, delay, repeats, creature, caster)
     creature:SendUnitYell(SAY_SUNBLADE_SCOUT_1, 0)
end

function SunbaldeProtector.OnHitBySpell(event, creature, caster, spellid)
	if (spellid == 46475) then
        creature:RegisterEvent(function(a,b,c,d) Active(a,b,c,d, caster:GetGUID()) end, 6000, 1)
    end
end

function SunbladeScout.Reset(event, creature)
    creature:RemoveFlag(59, 0x00020000)
    creature:RemoveFlag(60, 0x00008000)
    creature:MoveWaypoint()
    creature:SetWalk(true)
end
 
function SunbladeScout.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(NPC_SUNBLADE_SCOUT, 1, SunbladeScout.OnEnterCombat)
RegisterCreatureEvent(NPC_SUNBLADE_SCOUT, 6, SunbladeScout.OnWp)
RegisterCreatureEvent(NPC_SUNBLADE_SCOUT, 24, SunbladeScout.Reset)
RegisterCreatureEvent(NPC_SUNBLADE_SCOUT, 23, SunbladeScout.Reset)
RegisterCreatureEvent(NPC_SUNBLADE_SCOUT, 4, SunbladeScout.OnDied)
RegisterCreatureEvent(NPC_SUNBLADE_PROTECTOR, 14, SunbaldeProtector.OnHitBySpell)
