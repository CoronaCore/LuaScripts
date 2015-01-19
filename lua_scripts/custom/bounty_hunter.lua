--[==[
]==]

-- Include sc_default
require "base/sc_default"

BountyHunterSystem = {}

BountyHunterSystemName = "|CFF18E7BD[Bounty Hunter System]|r"

BountyHunterSystem.Settings = {
    NpcEntry = 60000,
    BountyMoney = 100000,
    BountyCommand = "#bounty list",
};

function BountyHunterSystem.OnGossipHello(event, player, unit)
    player:GossipMenuAddItem(0, "Set a Bounty for "..BountyHunterSystem.Settings.BountyMoney.." Chopper", 1, 1, true, nil)
    player:GossipMenuAddItem(0, "Bounty List", 0, 2)
    player:GossipSetText("Greetings "..player:GetName().."")
    player:GossipSendMenu(0x7FFFFFFF, unit)
end

function BountyHunterSystem.OnGossipSelect(event, player, unit, sender, intid, code)
    local result = CharDBQuery("SELECT * FROM character_bounty ORDER BY id ASC")

    if (intid == 1) then
        local BountyCheck = CharDBQuery(string.format("SELECT * FROM character_bounty WHERE bounty_name = ('%s')", code))
        local Bounty = GetPlayerByName(code)
        local BountyName = code
        local HunterName = player:GetName()

        if Bounty then
            if BountyName == HunterName then
                player:SendBroadcastMessage(string.format("%s You cant set a bounty on your self", BountyHunterSystemName))
                player:GossipComplete()
            else
                if result ~= nil and BountyCheck ~= nil then
                    if BountyName == BountyCheck:GetString(1) then
                        player:SendBroadcastMessage(string.format("%s On |CFFFF0000%s|r is already a bounty", BountyHunterSystemName, BountyName))
                        player:GossipComplete()
                    else
                        if player:GetCoinage() >= BountyHunterSystem.Settings.BountyMoney then
                            player:SendBroadcastMessage(string.format("%s Set a bounty on |CFFFF0000%s|r", BountyHunterSystemName, BountyName))
                            CharDBQuery(string.format("INSERT INTO `character_bounty` (`bounty_name`, `hunter_name`) VALUES('%s','%s')", BountyName, HunterName))
                            Bounty:SendBroadcastMessage(string.format("%s |CFFFF0000%s|r set a bounty on you", BountyHunterSystemName, HunterName))
                            player:ModifyMoney(-BountyHunterSystem.Settings.BountyMoney)
                            player:GossipComplete()
                        else
                            player:SendBroadcastMessage(string.format("%s You do not have enough money", BountyHunterSystemName))
                        end
                    end
                else
                    if player:GetCoinage() >= BountyHunterSystem.Settings.BountyMoney then
                        player:SendBroadcastMessage(string.format("%s Set a bounty on |CFFFF0000%s|r", BountyHunterSystemName, BountyName))
                        CharDBQuery(string.format("INSERT INTO `character_bounty` (`bounty_name`, `hunter_name`) VALUES('%s','%s')", BountyName, HunterName))
                        Bounty:SendBroadcastMessage(string.format("%s |CFFFF0000%s|r set a bounty on you", BountyHunterSystemName, HunterName))
                        player:ModifyMoney(-BountyHunterSystem.Settings.BountyMoney)
                        player:GossipComplete()
                    else
                        player:SendBroadcastMessage(string.format("%s You do not have enough money", BountyHunterSystemName))
                    end 
                end
            end
        else
            player:SendBroadcastMessage(string.format("%s Player with name |CFFFF0000%s|r not found in world", BountyHunterSystemName, BountyName))
            player:GossipComplete()
        end
    end

    if (intid == 2) then
        if result ~= nil then
            repeat
                player:SendBroadcastMessage(string.format("%s Bounty: = |CFFFF0000%s|r  / Hunter: = |CFFFF0000%s|r", BountyHunterSystemName, result:GetString(1), result:GetString(2)))
            until not result:NextRow()
        else
            player:SendBroadcastMessage(string.format("%s No bounty found", BountyHunterSystemName))
        end
    end
    player:GossipComplete()
end

function BountyHunterSystem.OnChatCommand(event, player, msg, _, lang)
    local result = CharDBQuery("SELECT * FROM character_bounty ORDER BY id ASC")

    if (msg == BountyHunterSystem.Settings.BountyCommand) then
        if result ~= nil then
            repeat
                player:SendBroadcastMessage(string.format("%s Bounty: = |CFFFF0000%s|r  / Hunter: = |CFFFF0000%s|r", BountyHunterSystemName, result:GetString(1), result:GetString(2)))
            until not result:NextRow()
        else
            player:SendBroadcastMessage(string.format("%s No bounty found", BountyHunterSystemName))
        end
        return false
   end
end

function BountyHunterSystem.OnPlayerKill(event, killer, killed)
    local BountyNameCheck = CharDBQuery(string.format("SELECT * FROM character_bounty WHERE bounty_name = ('%s')", killed:GetName()))
    local BountyName = killed:GetName()
 
    if BountyNameCheck ~= nil then
        if BountyName == BountyNameCheck:GetString(1) then
            killed:SendBroadcastMessage(string.format("%s You remove from bounty list", BountyHunterSystemName))
            killer:SendBroadcastMessage(string.format("%s On |CFFFF0000%s|r was a bounty you become |CFFFF0000%s|r Chopper", BountyHunterSystemName, BountyName, BountyHunterSystem.Settings.BountyMoney))
            CharDBQuery(string.format("DELETE FROM `character_bounty` WHERE bounty_name = '%s'", BountyName))
            killer:ModifyMoney(BountyHunterSystem.Settings.BountyMoney)
        end
    end
end

RegisterPlayerEvent(6, BountyHunterSystem.OnPlayerKill)
RegisterPlayerEvent(18, BountyHunterSystem.OnChatCommand)
RegisterCreatureGossipEvent(BountyHunterSystem.Settings.NpcEntry, 1, BountyHunterSystem.OnGossipHello)
RegisterCreatureGossipEvent(BountyHunterSystem.Settings.NpcEntry, 2, BountyHunterSystem.OnGossipSelect)