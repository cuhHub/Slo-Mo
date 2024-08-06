--------------------------------------------------------
-- [Slo-Mo] Main
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

-- // Misc
-- Add a note in case players using the addon forget
property.checkbox("(Note) Use '?slomo' to toggle slow motion.", false)

-- // Customizable settings
g_savedata.IsAdminOnly = g_savedata.IsAdminOnly or property.checkbox("Slow Motion - Is admin required for toggling?", true)
g_savedata.IsAuthOnly = g_savedata.IsAuthOnly or property.checkbox("Slow Motion - Is auth required for toggling?", false)
g_savedata.DefaultSlowMotionSpeed = g_savedata.DefaultSlowMotionSpeed or property.slider("Slow Motion - Default Slow Motion Speed (0.5x default)", 0, 1, 0.01, 0.5)

-- // Start
Noir:Start()