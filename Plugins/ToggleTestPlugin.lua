-- main/Plugins/ToggleTestPlugin.lua

local ToggleTestPlugin = {}

ToggleTestPlugin.IsPlugin = true

local toggleState = false

function ToggleTestPlugin.GetContent(SkillTree)
    return {
        SkillTree.UI.Elements.CreateButton(SkillTree, nil, "Toggle Test", function()
            toggleState = not toggleState
            UIHandler.UpdateToggleButton(SkillTree, "Toggle Test", toggleState)
        end)
    }
end

return ToggleTestPlugin
