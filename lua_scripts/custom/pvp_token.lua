local ItemEntry = 20558 -- Warsong Gulch Mark of Honor
local ItemCount = 1

local function PvPTokenItem(event, killer, killed)
    killer:AddItem(ItemEntry, ItemCount)
end

RegisterPlayerEvent(6, PvPTokenItem)