local ItemEntry = 20558 -- Warsong Gulch Mark of Honor
local ItemCount = 1
local ItemName = GetItemLink(ItemEntry)

local function PvPTokenItem(event, killer, killed)
    killer:AddItem(ItemEntry, ItemCount)

    if (ItemCount == 1) then
         killer:SendBroadcastMessage("|CFF20C000 You create: "..ItemName.."|CFF20C000.|r")
    else
         killer:SendBroadcastMessage("|CFF20C000 You create: "..ItemName.."|CFF20C000 x"..ItemCount..".|r")
    end
end

RegisterPlayerEvent(6, PvPTokenItem)