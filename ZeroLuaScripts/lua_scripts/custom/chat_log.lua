cddcdm = ""

local file = io.open("lua_scripts/ChatLog.log", "a")

function OnChat_Command(event, player, message, type, language)
    swm = string.lower(message)

    local plrname = player:GetName()
    local accname = player:GetAccountName()
    local giddy = message:gsub(cddcdm.."","")

    if (swm:find(cddcdm.." ") == false) then
    else
        pg = player:GetGuildName()
        msgtype = MSG(type)
        tom = type

        if (language ~= -1) then
            if (tom == 10) then
                file:write("("..os.date()..") "..GmCheck(player)" ["..accname.."] ["..plrname.."] "..giddy"\n")
            else
                file:write("("..os.date()..") ["..accname.."] ["..plrname.."] "..msgtype..": "..giddy.."\n")
                file:flush()
            end
        end
    end
end

RegisterPlayerEvent(18, OnChat_Command)
RegisterPlayerEvent(19, OnChat_Command)
RegisterPlayerEvent(20, OnChat_Command)
RegisterPlayerEvent(21, OnChat_Command)
RegisterPlayerEvent(22, OnChat_Command)

function MSG(type)
    if (type == 0x00) then
        return("System")
    elseif (type == 0x01) then
        return("Says")
    elseif (type == 0x02) then
        return("Party")
    elseif (type == 0x03) then
        return("Raid")
    elseif (type == 0x04) then
        return("Guild["..pg.."]")
    elseif (type == 0x05) then
        return("Guild Officer["..pg.."]")
    elseif (type == 0x06) then
        return("Yells")
    elseif (type == 0x07) then
        return("Whisper")
    elseif (type == 0x11) then
        return("(General/Trade/Local Defense/LFG/Custom)")
    elseif (type == 0x2C) then
        return("Battleground")
    elseif (type == 0x2D) then
        return("Battleground Leader")
    else
        return(type)
    end
end

function GmCheck(player)
    if (player:IsGm() == true) then
        return("[GM]")
	end
end