--------------------------------------------------------
-- [Slo-Mo] Commands - ?slomo
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
    ?slomo [scale]
]]
Noir.Started:Connect(function()
    Noir.Services.CommandService:CreateCommand("slomo", {"slo-mo", "sl", "slowmotion"}, nil, g_savedata.IsAuthOnly, g_savedata.IsAdminOnly, false, "Sets slow motion.", function(player, message, args, hasPermission)
        -- Check if player has permission
        if not hasPermission then
            Noir.Services.NotificationService:Error("Command", "You do not have permission to run this command.", player)
            return
        end

        if args[1] then
            -- Get the scale the user wants
            local scale = tonumber(args[1])

            -- Not a number
            if not scale then
                Noir.Services.NotificationService:Error("Command", "The scale must be a number between %d and %d.\nExample: ?slomo 0.5", player, SlowMotion.MinimumScale, SlowMotion.MaximumScale)
                return
            end

            -- Not in range
            if scale < SlowMotion.MinimumScale or scale > SlowMotion.MaximumScale then
                Noir.Services.NotificationService:Error("Command", "The scale must be a number between %d and %d.\nExample: ?slomo 0.5", player, SlowMotion.MinimumScale, SlowMotion.MaximumScale)
                return
            end

            -- Notify the user
            Noir.Services.NotificationService:Success("Slow Motion", "You have set the slow motion scale to %.1fx.", player, scale)

            -- Set the scale
            SlowMotion:SetSlowMotionScale(scale)
        else
            -- Notify player and give a hint
            Noir.Services.NotificationService:Success("Slow Motion", "Slow motion has been toggled.\n\nNote that you can provide a custom scale by adding a number after '?slomo', eg: '?slomo 0.7'.", player)

            -- Slow motion toggling
            if SlowMotion:GetSlowMotionScale() < SlowMotion.MaximumScale then
                -- If slow motion is enabled, disable it
                SlowMotion:ResetSlowMotionScale()
            else
                -- If slow motion is disabled, enable it
                SlowMotion:SetSlowMotionScale(g_savedata.DefaultSlowMotionSpeed)
            end
        end
    end)
end)