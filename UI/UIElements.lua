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

function UIElements.CreateDraggableFrame(SkillTree, parent, size, position)
    local frame = UIElements.CreateFrame(SkillTree, parent, size, position)
    
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)

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

function UIElements.CreateSlider(SkillTree, parent, minValue, maxValue, defaultValue, onChange, size, position)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Parent = parent
    sliderFrame.Size = size or UDim2.new(1, 0, 0, 30)
    sliderFrame.Position = position or UDim2.new(0, 0, 0, 0)
    sliderFrame.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Background")
    sliderFrame.BorderSizePixel = 0

    local sliderBar = Instance.new("Frame")
    sliderBar.Parent = sliderFrame
    sliderBar.Size = UDim2.new(1, -20, 0.5, 0)
    sliderBar.Position = UDim2.new(0, 10, 0.25, 0)
    sliderBar.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Secondary")
    sliderBar.BorderSizePixel = 0

    local sliderHandle = Instance.new("Frame")
    sliderHandle.Parent = sliderBar
    sliderHandle.Size = UDim2.new(0, 20, 1, 0)
    sliderHandle.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Primary")
    sliderHandle.BorderSizePixel = 0

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Parent = sliderFrame
    valueLabel.Size = UDim2.new(0, 50, 1, 0)
    valueLabel.Position = UDim2.new(1, -50, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.TextColor3 = SkillTree.SharedConfig.GetConfig("UI", "Text")
    valueLabel.Font = SkillTree.SharedConfig.GetConfig("UI", "Font")
    valueLabel.TextSize = SkillTree.SharedConfig.GetConfig("UI", "FontSize")

    local currentValue = defaultValue or minValue
    sliderHandle.Position = UDim2.new((currentValue - minValue) / (maxValue - minValue), 0, 0, 0)
    valueLabel.Text = tostring(currentValue)

    local dragging = false
    local dragStartX, startPosX

    sliderHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStartX = input.Position.X
            startPosX = sliderHandle.Position.X.Scale
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position.X - dragStartX
            local newPosX = math.clamp(startPosX + delta / sliderBar.AbsoluteSize.X, 0, 1)
            sliderHandle.Position = UDim2.new(newPosX, 0, 0, 0)
            currentValue = math.floor(minValue + (maxValue - minValue) * newPosX)
            valueLabel.Text = tostring(currentValue)
            if onChange then
                onChange(currentValue)
            end
        end
    end)

    return sliderFrame, function() return currentValue end
end

return UIElements
