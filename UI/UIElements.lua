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
    label.Size = size or UDim2.new(1, 0, 0, 30)
    label.Position = position or UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text or ""
    label.TextColor3 = SkillTree.SharedConfig.GetConfig("UI", "Text")
    label.Font = SkillTree.SharedConfig.GetConfig("UI", "Font")
    label.TextSize = SkillTree.SharedConfig.GetConfig("UI", "FontSize")
    return label
end

function UIElements.CreateButton(SkillTree, parent, text, onClick, size, position)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Size = size or UDim2.new(0, 150, 0, 40)
    button.Position = position or UDim2.new(0.5, -75, 0.5, 0)
    button.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Primary")
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Text = text or ""
    button.TextColor3 = SkillTree.SharedConfig.GetConfig("UI", "Background")
    button.Font = SkillTree.SharedConfig.GetConfig("UI", "Font")
    button.TextSize = SkillTree.SharedConfig.GetConfig("UI", "FontSize")
    
    -- Add hover effect
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(100, 210, 230)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Primary")
    end)
    
    button.MouseButton1Click:Connect(onClick)
    
    return button
end

function UIElements.CreateTextBox(SkillTree, parent, placeholderText, size, position)
    local textBox = Instance.new("TextBox")
    textBox.Parent = parent
    textBox.Size = size or UDim2.new(0, 200, 0, 30)
    textBox.Position = position or UDim2.new(0.5, -100, 0.5, 0)
    textBox.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Background")
    textBox.BorderColor3 = SkillTree.SharedConfig.GetConfig("UI", "Secondary")
    textBox.BorderSizePixel = 2
    textBox.PlaceholderText = placeholderText or ""
    textBox.PlaceholderColor3 = SkillTree.SharedConfig.GetConfig("UI", "Text")
    textBox.TextColor3 = SkillTree.SharedConfig.GetConfig("UI", "Text")
    textBox.Font = SkillTree.SharedConfig.GetConfig("UI", "Font")
    textBox.TextSize = SkillTree.SharedConfig.GetConfig("UI", "FontSize")
    return textBox
end

function UIElements.CreateImageLabel(SkillTree, parent, imageId, size, position)
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Parent = parent
    imageLabel.Size = size or UDim2.new(0, 50, 0, 50)
    imageLabel.Position = position or UDim2.new(0, 0, 0, 0)
    imageLabel.BackgroundTransparency = 1
    imageLabel.Image = imageId or ""
    return imageLabel
end

function UIElements.CreateImageButton(SkillTree, parent, imageId, onClick, size, position)
    local imageButton = Instance.new("ImageButton")
    imageButton.Parent = parent
    imageButton.Size = size or UDim2.new(0, 50, 0, 50)
    imageButton.Position = position or UDim2.new(0, 0, 0, 0)
    imageButton.BackgroundTransparency = 1
    imageButton.Image = imageId or ""
    imageButton.MouseButton1Click:Connect(onClick)
    
    -- Add hover effect
    imageButton.MouseEnter:Connect(function()
        imageButton.ImageTransparency = 0.5
    end)
    imageButton.MouseLeave:Connect(function()
        imageButton.ImageTransparency = 0
    end)
    
    return imageButton
end

function UIElements.CreateScrollingFrame(SkillTree, parent, size, position)
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Parent = parent
    scrollingFrame.Size = size or SkillTree.SharedConfig.GetConfig("UI", "Size")
    scrollingFrame.Position = position or SkillTree.SharedConfig.GetConfig("UI", "Position")
    scrollingFrame.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Background")
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.ScrollBarThickness = 5
    scrollingFrame.ScrollBarImageColor3 = SkillTree.SharedConfig.GetConfig("UI", "Tertiary")
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    return scrollingFrame
end

function UIElements.CreateProgressBar(SkillTree, parent, value, size, position)
    local progressBar = Instance.new("Frame")
    progressBar.Parent = parent
    progressBar.Size = size or UDim2.new(0.5, 0, 0, 20)
    progressBar.Position = position or UDim2.new(0.25, 0, 0.5, 0)
    progressBar.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Background")
    progressBar.BorderSizePixel = 0

    local progress = Instance.new("Frame")
    progress.Parent = progressBar
    progress.Size = UDim2.new(value or 0, 0, 1, 0)
    progress.Position = UDim2.new(0, 0, 0, 0)
    progress.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Accent")
    progress.BorderSizePixel = 0

    return progressBar, progress
end

return UIElements
