--[==[
]==]

ZoneCheck = {}

ZoneCheckName = "|CFF1CB619[Zone Check System]|r"

ZoneCheck.Settings = {
    TimeToTeleport = 15,                                    -- Set 0 to Instant Teleport
    Spell = 9454,
};

-- AreaId, ZoneId, MapId
ZoneCheck.ZonesAreas = {
    [1] = { 876, 876, 1},
    [2] = { 1519, 1519, 0 },
};

function ZoneCheck.OnEnterZone(event, player, newZone, newArea)
	local PlayerName = player:GetName()
	local PlayerGMRank = player:GetGMRank()
	local newMap = player:GetMapId()

    for i, v in ipairs(ZoneCheck.ZonesAreas) do
        if newArea == v[1] and newZone == v[2] and newMap == v[3] and not player:IsGM() then
        	player:AddAura(ZoneCheck.Settings.Spell, player)
		    if player:GetLuaCooldown(6) == 0 then 
			    player:SetLuaCooldown(ZoneCheck.Settings.TimeToTeleport, 6)
                player:RegisterEvent(ZoneCheck.CooldownCheck, 1000, player:GetLuaCooldown(6))
		        player:SendBroadcastMessage(string.format("%s You not a GameMaster you cant enter this zone!", ZoneCheckName))
            end
            for _, v in pairs(GetPlayersInWorld()) do
            	if v:GetGMRank() > 0 then
                   v:SendBroadcastMessage(string.format("%s Player %s Enter Zone %s Area %s Map %s without GM rights", ZoneCheckName, player:GetName(), newZone, newArea, newMap))
                end
            end
	    end
    end
end

function ZoneCheck.CooldownCheck(event, delay, repeats, player)
    if player:GetLuaCooldown(6) == 0 then
        player:RemoveEvents()
        player:RemoveAura(ZoneCheck.Settings.Spell)
        player:Teleport(530, 2398.07, 6003.91, 148.686, 1.79828)
    elseif player:GetLuaCooldown(6) <= 10 then
        player:SendBroadcastMessage(string.format("%s You will teleport in %s seconds!", ZoneCheckName, player:GetLuaCooldown(6)))
        if player:IsGM() then
            player:RemoveEvents()
            player:SetLuaCooldown(0, 6)
        end
    end
end

RegisterPlayerEvent(27, ZoneCheck.OnEnterZone)