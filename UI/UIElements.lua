-- main/UI/UIElements.lua

local UIElements = {}

function UIElements.CreateFrame(SkillTree)
    local frame = Instance.new("Frame")
    frame.Parent = game.Players.LocalPlayer.PlayerGui
    frame.Name = "SkillTreeMainFrame"
    frame.Size = SkillTree.SharedConfig.GetConfig("UI", "Size")
    frame.Position = SkillTree.SharedConfig.GetConfig("UI", "Position")
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BackgroundTransparency = 0.5
    return frame
end

function UIElements.CreateTitleLabel(SkillTree, parent)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.Name = "SkillTreeTitle"
    label.Size = UDim2.new(1, 0, 0, 30)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundColor3 = Color3.new(1, 1, 1)
    label.Text = "SkillTree"
    label.TextColor3 = Color3.new(0, 0, 0)
    label.Font = SkillTree.SharedConfig.GetConfig("UI", "Font")
    label.TextSize = SkillTree.SharedConfig.GetConfig("UI", "FontSize")
    return label
end

function UIElements.CreateButton(SkillTree, parent, text, onClick)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Name = text .. "Button"
    button.Size = UDim2.new(0, 100, 0, 30)
    button.Position = UDim2.new(0.5, -50, 0.5, 0)
    button.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
    button.Text = text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 14
    button.MouseButton1Click:Connect(onClick)
    return button
end

return UIElements
