--
-- Premium methods by Daniel S. Reichenbach
--

RulesSystemName = "|cffff0000[Rules System]|r"

RulesSystem = {}
RulesSystem.__index = RulesSystem

setmetatable(RulesSystem, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function RulesSystem.new(player)
    local self = setmetatable({}, RulesSystem)

    if (player ~= nil) then
        -- store Account Id for updating data etc.
        self.GetGUID = player:GetGUIDLow()

        -- query rules settings
        local PlayerRulesStatus = CharDBQuery("SELECT * FROM character_rules WHERE guid = "..self.GetGUID)
        if (PlayerRulesStatus ~= nil) then
            self.RulesState   = PlayerRulesStatus:GetBool(1)
        else
            -- no rulessettings found, set defaults
            self.RulesState   = false
        end
    end
    return self
end

function RulesSystem:IsActive()
    return self.RulesState
end

function RulesSystem:SetInActive()
    CharDBQuery("UPDATE character_rules SET active = 0 WHERE guid = "..self.GetGUID)
end

function RulesSystem:SetAccount()
    CharDBQuery(string.format("INSERT INTO character_rules (`guid`) VALUES (%s)", self.GetGUID))
end

function RulesSystem:Reset()
    CharDBQuery("UPDATE character_rules SET active = 1")
end

function RulesSystem:DeleteAccount(player)
    CharDBQuery("DELETE FROM character_rules WHERE guid = "..player)
end

