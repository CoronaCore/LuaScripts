--
-- Premium methods by Daniel S. Reichenbach
--

PremiumSystem = {}
PremiumSystem.__index = PremiumSystem

-- DPremium System Settings
PremiumSystem.Settings = {
    Version = "1.1",
    SystemName = "|CFFE55BB0[Premium System]|r",
    ItemEntry = 60000,
    ItemEnable = false,
};

setmetatable(PremiumSystem, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function PremiumSystem.new(player)
    local self = setmetatable({}, PremiumSystem)

    if (player ~= nil) then
        -- store Account Id for updating data etc.
        self.AccountId = player:GetAccountId()

        -- query premium settings
        local PlayerPremiumStatus = AuthDBQuery("SELECT * FROM account_premium WHERE id = "..self.AccountId)
        if (PlayerPremiumStatus ~= nil) then
            self.Rank           = PlayerPremiumStatus:GetInt8(1)
            self.Coins          = PlayerPremiumStatus:GetInt32(2)
            self.StartDate      = PlayerPremiumStatus:GetString(3)
            self.ExpireDate     = PlayerPremiumStatus:GetString(4)
            self.PremiumState   = PlayerPremiumStatus:GetBool(5)
        else
            -- no premium settings found, set defaults
            self.Rank           = 0
            self.Coins          = 0
            self.StartDate      = nil
            self.ExpireDat      = nil
            self.PremiumState   = false
        end
    end
    return self
end

function PremiumSystem:GetAccountId()
    return self.AccountId
end

function PremiumSystem:GetRank()
    return self.Rank
end

function PremiumSystem:ModifyCoins(value)
    if value ~= nil then
        AuthDBQuery("UPDATE account_premium SET coins = coins + "..value.." WHERE id = "..self.AccountId)
    end
end

function PremiumSystem:GetCoins()
    return self.Coins
end

function PremiumSystem:GetStartDate()
    return self.StartDate
end

function PremiumSystem:GeExpireDate()
    return self.ExpireDate
end

function PremiumSystem:IsActive()
    return self.PremiumState
end

