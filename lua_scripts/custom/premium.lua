local function PremiumOnLogin(event, player)
    local result = CharDBQuery("SELECT AccountId FROM premium WHERE active=1 and AccountId = "..player:GetAccountId())
    if (result) then
        player:SendBroadcastMessage("|CFFE55BB0[Premium]|r|CFFFE8A0E Welcome "..player:GetName().." you are Premium! |r")
        player:SendBroadcastMessage("|CFFE55BB0[Premium]|r|CFFFE8A0E Use #pr help for more infos. |r")
    else
        player:SendBroadcastMessage("|CFFE55BB0[Premium]|r|CFFFE8A0E Welcome "..player:GetName().." you are NOT Premium! |r")
    end
end

local function PremiumOnChat(event, player, msg, _, lang)
    local result = CharDBQuery("SELECT AccountId FROM premium WHERE active=1 and AccountId = "..player:GetAccountId())
    if (msg == "#pr help") then
        if (result) then
            player:SendBroadcastMessage("|CFFE55BB0[Premium]|r|CFFFE8A0E You can use #pr bank |r")
            player:SendBroadcastMessage("|CFFE55BB0[Premium]|r|CFFFE8A0E You can use #pr auction |r")
        else
            player:SendBroadcastMessage("|CFFE55BB0[Premium]|r|CFFFE8A0E Sorry "..player:GetName().." you are NOT Premium! |r")
        end
    elseif (msg == "#pr bank") then
        if (result) then
            player:SendShowBank(player)
        else
            player:SendBroadcastMessage("|CFFE55BB0[Premium]|r|CFFFE8A0E Sorry "..player:GetName().." you are NOT Premium! |r")
        end
    elseif (msg == "#pr auction") then
        if (result) then
            player:SendAuctionMenu(player)
        else
            player:SendBroadcastMessage("|CFFE55BB0[Premium]|r|CFFFE8A0E Sorry "..player:GetName().." you are NOT Premium! |r")
        end
    end
end

RegisterPlayerEvent(3, PremiumOnLogin)
RegisterPlayerEvent(18, PremiumOnChat)