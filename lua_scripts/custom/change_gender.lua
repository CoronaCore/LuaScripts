local NPC_ENTRY =

function ChangeGenderMenu(event, player, unit)
    if player:GetGender() == 0 then
        player:GossipMenuAddItem(0, "Change Gender to Female", 0, 1)
    else
        player:GossipMenuAddItem(0, "Change Gender to Male", 0, 2)
    end
    player:GossipMenuAddItem(0, "Nevermind..", 0, 3)
    player:GossipSendMenu(1, unit)
end

function ChangeGenderSelect(event, player, unit, sender, intid, code)
    if (intid == 1) then
        player:SendBroadcastMessage("|cFFFFA500Your gender has been changed!")
        player:SetGender(1)
        player:SaveToDB()
        player:GossipComplete()
    elseif (intid == 2) then
        player:SendBroadcastMessage("|cFFFFA500Your gender has been changed!")
        player:SetGender(0)
        player:SaveToDB()
        player:GossipComplete()
    elseif (intid == 3) then
        player:GossipComplete()
    end
end


RegisterCreatureGossipEvent(NPC_ENTRY, 1, ChangeGenderMenu)
RegisterCreatureGossipEvent(NPC_ENTRY, 2, ChangeGenderSelect)