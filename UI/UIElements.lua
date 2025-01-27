-- main/UI/UIElements.lua

local UIElements = {}

function UIElements.CreateScreenGui(SkillTree)
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

function UIElements.CreateFrame(SkillTree, parent, size, position)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = size or SkillTree.SharedConfig.GetConfig("UI", "Size")
    frame.Position = position or SkillTree.SharedConfig.GetConfig("UI", "Position")
    frame.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Background")
    frame.BorderSizePixel = 0
    return frame
end

function UIElements.CreateTextLabel(SkillTree, parent, text, size, position)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.Size = size or UDim2.new(1, -SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2, 0, 30)
    label.Position = position or UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "Padding"), 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text or ""
    label.TextColor3 = SkillTree.SharedConfig.GetConfig("UI", "Text")
    label.Font = SkillTree.SharedConfig.GetConfig("UI", "Font")
    label.TextSize = SkillTree.SharedConfig.GetConfig("UI", "FontSize")
    return label
end

function UIElements.CreateTitleLabel(SkillTree, parent, text, size, position)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.Size = size or UDim2.new(1, -SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2, 0, 30)
    label.Position = position or UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "Padding"), 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text or ""
    label.TextColor3 = SkillTree.SharedConfig.GetConfig("UI", "Text")
    label.Font = SkillTree.SharedConfig.GetConfig("UI", "Font")
    label.TextSize = SkillTree.SharedConfig.GetConfig("UI", "TitleFontSize")
    label.Font = Enum.Font.SourceSansBold -- Use bold font for titles
    return label
end

function UIElements.CreateButton(SkillTree, parent, text, onClick, size, position)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Size = size or UDim2.new(1, -SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2, 0, 30)
    button.Position = position or UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "Padding"), 0, 0)
    button.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Primary")
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Text = text or ""
    button.TextColor3 = SkillTree.SharedConfig.GetConfig("UI", "Text")
    button.Font = SkillTree.SharedConfig.GetConfig("UI", "Font")
    button.TextSize = SkillTree.SharedConfig.GetConfig("UI", "FontSize")
    
    -- Add subtle hover effect
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Secondary")
        button.TextSize = SkillTree.SharedConfig.GetConfig("UI", "FontSize") + 2 -- Slightly increase font size on hover
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Primary")
        button.TextSize = SkillTree.SharedConfig.GetConfig("UI", "FontSize")
    end)
    
    button.MouseButton1Click:Connect(onClick)
    
    -- Add a subtle border
    local border = Instance.new("Frame")
    border.Parent = button
    border.Size = UDim2.new(1, SkillTree.SharedConfig.GetConfig("UI", "BorderSize") * 2, 1, SkillTree.SharedConfig.GetConfig("UI", "BorderSize") * 2)
    border.Position = UDim2.new(0, -SkillTree.SharedConfig.GetConfig("UI", "BorderSize"), 0, -SkillTree.SharedConfig.GetConfig("UI", "BorderSize"))
    border.BackgroundTransparency = 1
    border.BorderSizePixel = SkillTree.SharedConfig.GetConfig("UI", "BorderSize")
    border.BorderColor3 = SkillTree.SharedConfig.GetConfig("UI", "Tertiary")
    border.ZIndex = button.ZIndex - 1
    
    return button
end

function UIElements.CreateScrollingFrame(SkillTree, parent, size, position)
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Parent = parent
    scrollingFrame.Size = size or UDim2.new(1, -SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2, 1, -SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2)
    scrollingFrame.Position = position or UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "Padding"), 0, SkillTree.SharedConfig.GetConfig("UI", "Padding"))
    scrollingFrame.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Background")
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.ScrollBarThickness = SkillTree.SharedConfig.GetConfig("UI", "ScrollBarThickness")
    scrollingFrame.ScrollBarImageColor3 = SkillTree.SharedConfig.GetConfig("UI", "Tertiary")
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    return scrollingFrame
end

function UIElements.CreateToggleButton(SkillTree, parent, text, onClick, initialState, size, position)
    local toggleButton = UIElements.CreateButton(SkillTree, parent, text, onClick, size, position)
    toggleButton.TextColor3 = initialState and SkillTree.SharedConfig.GetConfig("UI", "TrueColor") or SkillTree.SharedConfig.GetConfig("UI", "FalseColor")
    return toggleButton
end

return UIElements
