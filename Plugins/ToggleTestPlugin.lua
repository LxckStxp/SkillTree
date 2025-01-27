-- main/Plugins/ToggleTestPlugin.lua

local ToggleTestPlugin = {}

ToggleTestPlugin.IsPlugin = true

local toggleState = false

function ToggleTestPlugin.GetContent(SkillTree)
    return {
        SkillTree.UI.Elements.CreateToggleButton(SkillTree, nil, "Toggle Test", function()
            toggleState = not toggleState
            print("ToggleTestPlugin: Attempting to call UpdateToggleButton")
            if SkillTree.UIHandler and SkillTree.UIHandler.UpdateToggleButton then
                print("ToggleTestPlugin: UIHandler and UpdateToggleButton found")
                SkillTree.UIHandler.UpdateToggleButton(SkillTree, "Toggle Test", toggleState)
            else
                warn("ToggleTestPlugin: UIHandler or UpdateToggleButton not found")
            end
        end, toggleState)
    }
end

return ToggleTestPlugin
