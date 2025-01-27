-- main/Plugins/ActionPlugin.lua

local ActionPlugin = {
    IsPlugin = true
}

function ActionPlugin.Init(SkillTree)
    SkillTree.Logger.Log("ActionPlugin", "Initialized")
end

function ActionPlugin.GetContent(SkillTree)
    local content = {}

    local action1Button = SkillTree.UI.Elements.CreateButton(SkillTree, nil, "Perform Action 1", function()
        SkillTree.Logger.Log("ActionPlugin", "Action 1 performed")
    end, UDim2.new(1, 0, 0, 30))
    table.insert(content, action1Button)

    local action2Button = SkillTree.UI.Elements.CreateButton(SkillTree, nil, "Perform Action 2", function()
        SkillTree.Logger.Log("ActionPlugin", "Action 2 performed")
    end, UDim2.new(1, 0, 0, 30))
    table.insert(content, action2Button)

    return content
end

return ActionPlugin
