--[==[
    NOTE: need to insert character_premium.sql in your characters database
]==]

-- Include sc_default
require "base/sc_default"
require "base/sc_premium"

-- Command for Premium Menu
local PremiumMenuCommand = "#premium menu"

-- Rules Texts
PremiumSystem.Texts = {
    [0] = "TEXT TEXT TEXT TEXT TEXT TEXT  TEXT TEXT TEXT TEXT  TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT",
    [1] = "TEXT TEXT TEXT TEXT TEXT TEXT  TEXT TEXT TEXT TEXT  TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT",
    [2] = "TEXT TEXT TEXT TEXT TEXT TEXT  TEXT TEXT TEXT TEXT  TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT",
};

-- ItemLink, ItemEntry, ItemCount, CoinsCost
PremiumSystem.Items = {
    [1] = { GetItemLink(33225), 33225, 1, 100 }, -- Reins of the Swift Spectral Tiger
    [2] = { GetItemLink(33225), 33225, 1, 100 }, -- Reins of the Swift Spectral Tiger
    [3] = { GetItemLink(33225), 33225, 1, 100 }, -- Reins of the Swift Spectral Tiger
    [4] = { GetItemLink(33225), 33225, 1, 100 }, -- Reins of the Swift Spectral Tiger
};


function PremiumSystem.MenuCommand(event, player, msg, _, lang)
    local PremiumPlayer = PremiumSystem(player)
    local PremiumActive = PremiumPlayer:IsActive() == true

    if (msg == PremiumMenuCommand) and PremiumActive then                -- Use "#premium menu" for sending the gossip menu
         PremiumSystem.OnGossipHello(event, player)
        return false;
    end
end


function PremiumSystem.OnGossipHello(event, player)
    local PremiumPlayer = PremiumSystem(player)
    local PremiumActive = PremiumPlayer:IsActive() == true
    local PremiumExpireDate = PremiumPlayer:GeExpireDate()
    local PremiumCoins = PremiumPlayer:GetCoins()
    local PremiumRank = PremiumPlayer:GetRank()
    local PlayerName = player:GetName()

    if PremiumActive then
        player:GossipClearMenu()
        player:GossipMenuAddItem(0, "Show Premium Infos", 0, 3)
        player:GossipMenuAddItem(0, "Buy with Coins", 0, 4)
        player:GossipMenuAddItem(0, "Show Bank", 0, 5)
        player:GossipMenuAddItem(0, "Show AuctionsHouse", 0, 6)
        player:GossipMenuAddItem(0, "Reset Talents", 0, 7)
        player:GossipMenuAddItem(0, "Repair Items", 0, 8)
        -- Close the Menu
        player:GossipMenuAddItem(0, "Nevermind", 0, 1)
        -- Room for more premium things
        player:GossipSetText(string.format("Hello %s\n\nYou Premium rank is %s\n\nYou have %s coins\n\nPremium will expire on %s", PlayerName, PremiumRank, PremiumCoins, PremiumExpireDate))
        player:GossipSendMenu(0x7FFFFFFF, player, 100)
    end
    return false
end


function PremiumSystem.OnGossipSelect(event, player, _, sender, intid, code)
    local PremiumPlayer = PremiumSystem(player)
    local PremiumCoins = PremiumPlayer:GetCoins()
    local PlayerName = player:GetName()

    if (intid == 1) then                     -- Close the Gossip
        player:GossipComplete()
    elseif (intid == 2) then                 -- Go back to main menu
        PremiumSystem.OnGossipHello(event, player)
    elseif (intid == 3) then                 -- Show Server Info Site
        player:GossipSetText(string.format("%s\n\n%s\n\n%s", PremiumSystem.Texts[0], PremiumSystem.Texts[1], PremiumSystem.Texts[2]))
        player:GossipMenuAddItem(0, "Back", 0, 2)
        player:GossipSendMenu(0x7FFFFFFF, player, 100)
    elseif (intid == 4) then                 -- Show Buy with Coins Site
        player:GossipSetText("Buy for Coins Site")
        for i, v in ipairs(PremiumSystem.Items) do
            player:GossipMenuAddItem(4, "Buy for "..v[4].." Coins\n\n"..v[1].."\n", i, 1000, false, ""..v[1].."\n\n"..v[4].." Coins\n\n")
        end
        player:GossipMenuAddItem(0, "Back", 0, 2)
        player:GossipSendMenu(0x7FFFFFFF, player, 100)
    elseif (intid == 5) then                 -- Send Bank Window
        player:SendShowBank(player)
    elseif (intid == 6) then                 -- Send Auctions Window
        player:SendAuctionMenu(player)
    elseif (intid == 7) then                 -- Resets Player Talents
        player:ResetTalents()
        player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Talents Resetet |r", PremiumSystemName))
        player:GossipComplete()
    elseif (intid == 8) then                 -- Resets Player Talents
        player:DurabilityRepairAll()
        player:SendBroadcastMessage(string.format("%s|CFFFE8A0E All Items Repaired |r", PremiumSystemName))
        player:GossipComplete()
    end

    if (intid == 1000) then
        local ItemLink, ItemEntry, ItemCount, Coins = table.unpack(PremiumSystem.Items[sender])

        if PremiumCoins < Coins then
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E You need %s Coins for %sx %s|r", PremiumSystemName, Coins, ItemCount, ItemLink))
            player:GossipComplete()
        else
            player:AddItem(ItemEntry, ItemCount)
            PremiumPlayer:ModifyCoins(-Coins)
            player:SendBroadcastMessage(string.format("%s|CFFFE8A0E Create %sx|r %s", PremiumSystemName, ItemCount, ItemLink))
            player:GossipComplete()
        end
    end
end

RegisterPlayerEvent(18, PremiumSystem.MenuCommand)                          -- Register Event on Chat Command use
RegisterPlayerGossipEvent(100, 2, PremiumSystem.OnGossipSelect)             -- Register Event for Gossip Select
RegisterItemGossipEvent(PremiumItemEntry, 1, PremiumSystem.OnGossipHello)   -- Register Gossip Event on Item Use
RegisterItemGossipEvent(PremiumItemEntry, 2, PremiumSystem.OnGossipSelect)  -- Register Gossip Event on Item Use Select
