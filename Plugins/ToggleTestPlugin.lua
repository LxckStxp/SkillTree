-- main/Plugins/ToggleTestPlugin.lua

local ToggleTestPlugin = {}

ToggleTestPlugin.IsPlugin = true

local toggleState = false

function ToggleTestPlugin.GetContent(SkillTree)
    SkillTree.Logger.Log("ToggleTestPlugin", "Entering GetContent")
    SkillTree.Logger.Log("ToggleTestPlugin", "SkillTree: " .. tostring(SkillTree))
    SkillTree.Logger.Log("ToggleTestPlugin", "SkillTree.UI: " .. tostring(SkillTree.UI))
    SkillTree.Logger.Log("ToggleTestPlugin", "SkillTree.UI.Elements: " .. tostring(SkillTree.UI and SkillTree.UI.Elements))
    SkillTree.Logger.Log("ToggleTestPlugin", "SkillTree.UI.Elements.CreateToggleButton: " .. tostring(SkillTree.UI and SkillTree.UI.Elements and SkillTree.UI.Elements.CreateToggleButton))
    
    if SkillTree.UI and SkillTree.UI.Elements and SkillTree.UI.Elements.CreateToggleButton then
        return {
            SkillTree.UI.Elements.CreateToggleButton(SkillTree, nil, "Toggle Test", function()
                toggleState = not toggleState
                SkillTree.Logger.Log("ToggleTestPlugin", "Attempting to call UpdateToggleButton")
                if SkillTree.UIHandler and SkillTree.UIHandler.UpdateToggleButton then
                    SkillTree.Logger.Log("ToggleTestPlugin", "UIHandler and UpdateToggleButton found")
                    SkillTree.UIHandler.UpdateToggleButton(SkillTree, "Toggle Test", toggleState)
                else
                    SkillTree.Logger.Warn("ToggleTestPlugin", "UIHandler or UpdateToggleButton not found")
                end
            end, toggleState)
        }
    else
        SkillTree.Logger.Warn("ToggleTestPlugin", "UIElements or CreateToggleButton not found")
        return {}
    end
end

return ToggleTestPlugin
 
