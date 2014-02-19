local function PremiumOnLogin(event, player)
    local result = CharDBQuery("SELECT AccountId FROM premium WHERE active=1 and AccountId = "..player:GetAccountId())
    if (result) then
        player:SendBroadcastMessage("|CFFE55BB0[Premium]|r|CFFFE8A0E Welcome "..player:GetName().." you are Premium! |r")
    else
        player:SendBroadcastMessage("|CFFE55BB0[Premium]|r|CFFFE8A0E Welcome "..player:GetName().." you are NOT Premium! |r")
    end
end

local function PremiumOnChat(event, player, msg, _, lang)
    local result = CharDBQuery("SELECT AccountId FROM premium WHERE active=1 and AccountId = "..player:GetAccountId())
    if (msg == "#premium") then
        if (result) then
            OnPremiumHello(event, player)
        else
            player:SendBroadcastMessage("|CFFE55BB0[Premium]|r|CFFFE8A0E Sorry "..player:GetName().." you are NOT Premium! |r")
        end
    end
end

function OnPremiumHello(event, player)
    player:GossipClearMenu()
    player:GossipMenuAddItem(0, "Show Bank", 0, 3)
    player:GossipMenuAddItem(0, "Show AuctionsHouse", 0, 4)
    player:GossipMenuAddItem(0, "Nevermind..", 0, 1)
    player:GossipSendMenu(1, player, 100)
end

function OnPremiumSelect(event, player, _, sender, intid, code)
    if (intid == 1) then
        player:GossipComplete()
    elseif (intid == 2) then
        OnPremiumHello(event, player)
    elseif (intid == 3) then
        player:SendShowBank(player)
    elseif (intid == 4) then
        player:SendAuctionMenu(player)
    end
end

RegisterPlayerEvent(3, PremiumOnLogin)
RegisterPlayerEvent(18, PremiumOnChat)
RegisterPlayerGossipEvent(100, 2, OnPremiumSelect)