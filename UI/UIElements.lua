-- main/UI/UIElements.lua

local UIElements = {}

function UIElements.CreateScreenGui()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer.PlayerGui
    if not screenGui.Parent then
        warn("PlayerGui not found or not accessible")
        return nil
    end
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 100 -- Higher value ensures it's on top of other GUIs
    return screenGui
end

function UIElements.CreateFrame(SkillTree, parent)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Name = "SkillTreeMainFrame"
    frame.Size = UDim2.new(0.5, 0, 0.5, 0) -- Make it larger
    frame.Position = UDim2.new(0.25, 0, 0.25, 0) -- Center it
    frame.BackgroundColor3 = Color3.new(1, 0, 0) -- Bright red for visibility
    frame.BackgroundTransparency = 0 -- Make it fully opaque
    return frame
end

function UIElements.CreateTitleLabel(SkillTree, parent)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.Name = "SkillTreeTitle"
    label.Size = UDim2.new(1, 0, 0, 50) -- Make it larger
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundColor3 = Color3.new(0, 1, 0) -- Bright green for visibility
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
    button.Size = UDim2.new(0, 150, 0, 50) -- Make it larger
    button.Position = UDim2.new(0.5, -75, 0.5, 0) -- Center it
    button.BackgroundColor3 = Color3.new(0, 0, 1) -- Bright blue for visibility
    button.Text = text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 20 -- Make it larger
    button.MouseButton1Click:Connect(onClick)
    return button
end

return UIElements
