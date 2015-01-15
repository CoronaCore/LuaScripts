--[==[
    GameMaster Raid Announce by Salja
    Send a World wide Announce in Raid Warning Style
]==]

local ChatPrefix = "#announce"

if (ChatPrefix:sub(-1) ~= " ") then
    ChatPrefix = ChatPrefix.." ";
end

local function ChatSystem(event, player, msg, _, lang)
    if (msg:sub(1, ChatPrefix:len()) == ChatPrefix) then
        if player:IsGM() then
            -- local t = table.concat({"|cff7DFF00[", player:GetName(), "]:|r ", msg:sub(ChatPrefix:len()+1), ""});
            local t = table.concat({msg:sub(ChatPrefix:len()+1),});
            for _, p in ipairs(GetPlayersInWorld()) do
                player:SendChatMessageToPlayer(40, 0, t, p)
            end
        else
            PrintInfo("Not GameMaster or GameMaster modus off")
        end
        return false;
    end
end

RegisterPlayerEvent(18, ChatSystem)