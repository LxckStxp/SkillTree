-- main/Plugins/ToggleTestPlugin.lua

local ToggleTestPlugin = {}

ToggleTestPlugin.IsPlugin = true

local toggleState = false

function ToggleTestPlugin.GetContent(SkillTree)
    print("ToggleTestPlugin: Entering GetContent")
    print("ToggleTestPlugin: SkillTree: " .. tostring(SkillTree))
    print("ToggleTestPlugin: SkillTree.UI: " .. tostring(SkillTree.UI))
    print("ToggleTestPlugin: SkillTree.UI.Elements: " .. tostring(SkillTree.UI and SkillTree.UI.Elements))
    print("ToggleTestPlugin: SkillTree.UI.Elements.CreateToggleButton: " .. tostring(SkillTree.UI and SkillTree.UI.Elements and SkillTree.UI.Elements.CreateToggleButton))
    
    if SkillTree.UI and SkillTree.UI.Elements and SkillTree.UI.Elements.CreateToggleButton then
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
    else
        warn("ToggleTestPlugin: UIElements or CreateToggleButton not found")
        return {}
    end
end

return ToggleTestPlugin
