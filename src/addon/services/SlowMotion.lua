--------------------------------------------------------
-- [Slo-Mo] Services - Slow Motion
--------------------------------------------------------

--[[
    ----------------------------

    CREDIT:
        Author(s): @Cuh4 (GitHub)
        GitHub Repository: https://github.com/cuhHub/Slo-Mo

    License:
        Copyright (C) 2024 Cuh4

        Licensed under the Apache License, Version 2.0 (the "License");
        you may not use this file except in compliance with the License.
        You may obtain a copy of the License at

            http://www.apache.org/licenses/LICENSE-2.0

        Unless required by applicable law or agreed to in writing, software
        distributed under the License is distributed on an "AS IS" BASIS,
        WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
        See the License for the specific language governing permissions and
        limitations under the License.

    ----------------------------
]]

-------------------------------
-- // Main
-------------------------------

--[[
    A service to handle the slow motion aspect of this addon.
]]
---@class SlowMotion: NoirService
---@field SlowMotionScale number 0 - 1
---@field _MaxTPS number
---@field MinimumScale number
---@field MaximumScale number
---@field OnScaleChange NoirEvent
SlowMotion = Noir.Services:CreateService(
    "SlowMotion"
)

function SlowMotion:ServiceInit()
    self._MaxTPS = 62.5
    self.MinimumScale = 1 / self._MaxTPS
    self.MaximumScale = 1

    self.SlowMotionScale = self:Load("SlowMotionScale", 1)
    self:Save("SlowMotionScale", self.SlowMotionScale)

    self.OnScaleChange = Noir.Libraries.Events:Create()
end

function SlowMotion:ServiceStart()
    -- Notify players when the slow motion scale changes
    ---@param new number
    self.OnScaleChange:Connect(function(new)
        local everyone = Noir.Services.PlayerService:GetPlayers()
        Noir.Services.NotificationService:Info("Slow Motion", "The slow motion scale has been set to %.1fx.", everyone, new)
    end)

    -- Set slow motion (for persistence)
    self:SetTPS()

    -- Notify players that slow motion is active if a save was loaded into
    if Noir.AddonReason == "SaveLoad" and self.SlowMotionScale < self.MaximumScale then
        local everyone = Noir.Services.PlayerService:GetPlayers()
        Noir.Services.NotificationService:Warning("Slow Motion", "Slow motion is enabled! Use '?slomo' to toggle (disable) it.", everyone, self.SlowMotionScale)

        server.announce("Slow Motion", "Slow motion is enabled! Use '?slomo' to toggle (disable) it.", -1)
    end
end

--[[
    Calculates TPS from the slow motion scale.
]]
function SlowMotion:_CalculateTPSFromSlowMotionScale()
    return self._MaxTPS * self.SlowMotionScale
end

--[[
    Set desired TPS for Noir's TPSService.
]]
function SlowMotion:SetTPS()
    local requiredTPS = self:_CalculateTPSFromSlowMotionScale()
    Noir.Services.TPSService:SetTPS(requiredTPS)
end

--[[
    Sets the slow motion scale.
]]
---@param scale number
function SlowMotion:SetSlowMotionScale(scale)
    Noir.TypeChecking:Assert("SlowMotion:SetSlowMotionScale()", "scale", scale, "number")

    self.SlowMotionScale = Noir.Libraries.Number:Clamp(scale, self.MinimumScale, self.MaximumScale)
    self:Save("SlowMotionScale", self.SlowMotionScale)

    self:SetTPS()

    self.OnScaleChange:Fire(self.SlowMotionScale)
end

--[[
    Resets the slow motion scale.
]]
function SlowMotion:ResetSlowMotionScale()
    self:SetSlowMotionScale(self.MaximumScale)
end

--[[
    Returns the slow motion scale.
]]
---@return number
function SlowMotion:GetSlowMotionScale()
    return self.SlowMotionScale
end