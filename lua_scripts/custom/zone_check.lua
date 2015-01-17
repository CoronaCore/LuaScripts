--[==[
]==]

ZoneCheck = {}

ZoneCheckName = "|CFF1CB619[Zone Check System]|r"

ZoneCheck.Settings = {
    TimeToTeleport = 10,                                    -- Set 0 to Instant Teleport
    Spell = 9454,
};

-- AreaId, ZoneId, MapId
ZoneCheck.ZonesAreas = {
    [1] = { 876, 876, 1}, -- GM Island
};

function ZoneCheck.OnEnterZone(event, player, newZone, newArea)
    local PlayerName = player:GetName()
    local newMap = player:GetMapId()

    for i, v in ipairs(ZoneCheck.ZonesAreas) do
        if newArea == v[1] and newZone == v[2] and newMap == v[3] and player:IsGM() == false then
            player:AddAura(ZoneCheck.Settings.Spell, player)
            player:SetLuaCooldown(ZoneCheck.Settings.TimeToTeleport, 6)
            player:RegisterEvent(ZoneCheck.CooldownCheck, 1000, player:GetLuaCooldown(6))
            player:SendBroadcastMessage(string.format("%s You not a GameMaster you cant enter this zone!", ZoneCheckName))
            for _, v in pairs(GetPlayersInWorld()) do
                if v:IsGM() == true then
                   v:SendBroadcastMessage(string.format("%s Player %s Enter Zone %s Area %s Map %s without GM rights", ZoneCheckName, player:GetName(), newZone, newArea, newMap))
                end
            end
        end
    end
end

function ZoneCheck.CooldownCheck(event, delay, repeats, player)
    if player:GetLuaCooldown(6) == 0 then
        player:RemoveEventById(event)
        player:RemoveAura(ZoneCheck.Settings.Spell)
        player:Teleport(530, 2398.07, 6003.91, 148.686, 1.79828)
    elseif player:GetLuaCooldown(6) <= ZoneCheck.Settings.TimeToTeleport then
        player:SendBroadcastMessage(string.format("%s You will teleport in %s seconds!", ZoneCheckName, player:GetLuaCooldown(6)))
        if player:IsGM() == true then
            player:RemoveEventById(event)
            player:RemoveAura(ZoneCheck.Settings.Spell)
        end
    end
end

RegisterPlayerEvent(27, ZoneCheck.OnEnterZone)