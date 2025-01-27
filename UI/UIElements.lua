-- main/UI/UIElements.lua

local UIElements = {}

function UIElements.CreateFrame(SkillTree)
    return Instance.new("Frame", game.Players.LocalPlayer.PlayerGui) do
        Name = "SkillTreeMainFrame"
        Size = SkillTree.SharedConfig.GetConfig("UI", "Size")
        Position = SkillTree.SharedConfig.GetConfig("UI", "Position")
        BackgroundColor3 = Color3.new(0, 0, 0)
        BackgroundTransparency = 0.5
    end
end

function UIElements.CreateTitleLabel(SkillTree, parent)
    return Instance.new("TextLabel", parent) do
        Name = "SkillTreeTitle"
        Size = UDim2.new(1, 0, 0, 30)
        Position = UDim2.new(0, 0, 0, 0)
        BackgroundColor3 = Color3.new(1, 1, 1)
        Text = "SkillTree"
        TextColor3 = Color3.new(0, 0, 0)
        Font = SkillTree.SharedConfig.GetConfig("UI", "Font")
        TextSize = SkillTree.SharedConfig.GetConfig("UI", "FontSize")
    end
end

function UIElements.CreateButton(SkillTree, parent, text, onClick)
    return Instance.new("TextButton", parent) do
        Name = text .. "Button"
        Size = UDim2.new(0, 100, 0, 30)
        Position = UDim2.new(0.5, -50, 0.5, 0)
        BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
        Text = text
        TextColor3 = Color3.new(1, 1, 1)
        Font = Enum.Font.SourceSans
        TextSize = 14
        MouseButton1Click:Connect(onClick)
    end
end

return UIElements
