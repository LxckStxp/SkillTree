-- main/Plugins/ToggleTestPlugin.lua

local ToggleTestPlugin = {}

ToggleTestPlugin.IsPlugin = true

local toggleState = false

function ToggleTestPlugin.GetContent(SkillTree)
    return {
        SkillTree.UI.Elements.CreateButton(SkillTree, nil, "Toggle Test", function()
            toggleState = not toggleState
            if SkillTree.UIHandler and SkillTree.UIHandler.UpdateToggleButton then
                SkillTree.UIHandler.UpdateToggleButton(SkillTree, "Toggle Test", toggleState)
            else
                warn("UIHandler or UpdateToggleButton not found")
            end
        end)
    }
end

return ToggleTestPlugin
