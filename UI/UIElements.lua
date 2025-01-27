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
    SkillTree.Logger.Log("UIElements", "CreateFrame BackgroundColor3: " .. tostring(SkillTree.SharedConfig.GetConfig("UI", "Background")))
    local backgroundColor = SkillTree.SharedConfig.GetConfig("UI", "Background")
    if backgroundColor and typeof(backgroundColor) == "Color3" then
        frame.BackgroundColor3 = backgroundColor
        SkillTree.Logger.Log("UIElements", "Set frame.BackgroundColor3 to: " .. tostring(frame.BackgroundColor3))
    else
        SkillTree.Logger.Warn("UIElements", "Invalid background color. Using default color.")
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Default color
        SkillTree.Logger.Log("UIElements", "Set frame.BackgroundColor3 to default: " .. tostring(frame.BackgroundColor3))
    end
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

function UIElements.CreateTextBox(SkillTree, parent, placeholderText, size, position)
    local textBox = Instance.new("TextBox")
    textBox.Parent = parent
    textBox.Size = size or UDim2.new(1, -SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2, 0, 30)
    textBox.Position = position or UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "Padding"), 0, 0)
    textBox.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Background")
    textBox.BorderColor3 = SkillTree.SharedConfig.GetConfig("UI", "Secondary")
    textBox.BorderSizePixel = SkillTree.SharedConfig.GetConfig("UI", "BorderSize")
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
    imageLabel.Size = size or UDim2.new(0, 24, 0, 24) -- Smaller size for minimalistic icons
    imageLabel.Position = position or UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "Padding"), 0, SkillTree.SharedConfig.GetConfig("UI", "Padding") + 3) -- Adjusted position for alignment
    imageLabel.BackgroundTransparency = 1
    imageLabel.Image = imageId or ""
    return imageLabel
end

function UIElements.CreateImageButton(SkillTree, parent, imageId, onClick, size, position)
    local imageButton = Instance.new("ImageButton")
    imageButton.Parent = parent
    imageButton.Size = size or UDim2.new(0, 24, 0, 24) -- Smaller size for minimalistic icons
    imageButton.Position = position or UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "Padding"), 0, SkillTree.SharedConfig.GetConfig("UI", "Padding") + 3) -- Adjusted position for alignment
    imageButton.BackgroundTransparency = 1
    imageButton.Image = imageId or ""
    imageButton.MouseButton1Click:Connect(onClick)
    
    -- Add subtle hover effect
    imageButton.MouseEnter:Connect(function()
        imageButton.ImageTransparency = 0.2
    end)
    imageButton.MouseLeave:Connect(function()
        imageButton.ImageTransparency = 0
    end)
    
    return imageButton
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

function UIElements.CreateProgressBar(SkillTree, parent, value, size, position)
    local progressBar = Instance.new("Frame")
    progressBar.Parent = parent
    progressBar.Size = size or UDim2.new(1, -SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2, 0, 10)
    progressBar.Position = position or UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "Padding"), 0, SkillTree.SharedConfig.GetConfig("UI", "Padding"))
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
    sliderFrame.Size = size or UDim2.new(1, -SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2, 0, 20)
    sliderFrame.Position = position or UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "Padding"), 0, SkillTree.SharedConfig.GetConfig("UI", "Padding"))
    sliderFrame.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Background")
    sliderFrame.BorderSizePixel = 0

    local sliderBar = Instance.new("Frame")
    sliderBar.Parent = sliderFrame
    sliderBar.Size = UDim2.new(1, 0, 0.5, 0)
    sliderBar.Position = UDim2.new(0, 0, 0.25, 0)
    sliderBar.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Secondary")
    sliderBar.BorderSizePixel = 0

    local sliderHandle = Instance.new("Frame")
    sliderHandle.Parent = sliderBar
    sliderHandle.Size = UDim2.new(0, 10, 1, 0)
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
            if onChange then
                onChange(currentValue)
            end
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position.X - dragStartX
            local newPosX = math.clamp(startPosX + delta / sliderBar.AbsoluteSize.X, 0, 1)
            sliderHandle.Position = UDim2.new(newPosX, 0, 0, 0)
            currentValue = math.floor(minValue + (maxValue - minValue) * newPosX)
            valueLabel.Text = tostring(currentValue)
        end
    end)

    return sliderFrame, function() return currentValue end
end

function UIElements.CreateStyledFrame(SkillTree, parent, size, position)
    local frame = UIElements.CreateDraggableFrame(SkillTree, parent, size or SkillTree.SharedConfig.GetConfig("UI", "Size"), position or SkillTree.SharedConfig.GetConfig("UI", "Position"))
    
    -- Add a subtle border
    local border = Instance.new("Frame")
    border.Parent = frame
    border.Size = UDim2.new(1, SkillTree.SharedConfig.GetConfig("UI", "BorderSize") * 2, 1, SkillTree.SharedConfig.GetConfig("UI", "BorderSize") * 2)
    border.Position = UDim2.new(0, -SkillTree.SharedConfig.GetConfig("UI", "BorderSize"), 0, -SkillTree.SharedConfig.GetConfig("UI", "BorderSize"))
    border.BackgroundTransparency = 1
    border.BorderSizePixel = SkillTree.SharedConfig.GetConfig("UI", "BorderSize")
    border.BorderColor3 = SkillTree.SharedConfig.GetConfig("UI", "Secondary")
    border.ZIndex = frame.ZIndex - 1
    
    return frame
end

function UIElements.CreateHeader(SkillTree, parent)
    local header = UIElements.CreateFrame(SkillTree, parent, UDim2.new(1, 0, 0, SkillTree.SharedConfig.GetConfig("UI", "HeaderHeight")), UDim2.new(0, 0, 0, 0))
    header.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Primary")
    
    -- Center-aligned title with increased font size
    local titleLabel = UIElements.CreateTitleLabel(SkillTree, header, "SkillTree", UDim2.new(1, -SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2, 1, 0), UDim2.new(0, 0, 0, 0))
    titleLabel.Position = UDim2.new(0.5, -titleLabel.TextBounds.X/2, 0, 0)
    
    -- Add a subtle separator line
    local separator = Instance.new("Frame")
    separator.Parent = header
    separator.Size = UDim2.new(1, 0, 0, SkillTree.SharedConfig.GetConfig("UI", "BorderSize"))
    separator.Position = UDim2.new(0, 0, 1, -SkillTree.SharedConfig.GetConfig("UI", "BorderSize"))
    separator.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Secondary")
    separator.BorderSizePixel = 0
    
    return header
end

function UIElements.CreateLeftPanel(SkillTree, parent)
    local leftPanel = UIElements.CreateFrame(SkillTree, parent, UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "LeftPanelWidth"), 1, -SkillTree.SharedConfig.GetConfig("UI", "HeaderHeight")), UDim2.new(0, 0, 0, SkillTree.SharedConfig.GetConfig("UI", "HeaderHeight")))
    leftPanel.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "LeftPanelColor")
    return leftPanel
end

function UIElements.CreateContentArea(SkillTree, parent)
    local contentArea = UIElements.CreateFrame(SkillTree, parent, UDim2.new(1, -SkillTree.SharedConfig.GetConfig("UI", "LeftPanelWidth"), 1, -SkillTree.SharedConfig.GetConfig("UI", "HeaderHeight")), UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "LeftPanelWidth"), 0, SkillTree.SharedConfig.GetConfig("UI", "HeaderHeight")))
    contentArea.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "ContentColor")
    return contentArea
end

function UIElements.CreateToggleButton(SkillTree, parent, text, onClick, initialState, size, position)
    local toggleButton = UIElements.CreateButton(SkillTree, parent, text, onClick, size, position)
    toggleButton.TextColor3 = initialState and SkillTree.SharedConfig.GetConfig("UI", "TrueColor") or SkillTree.SharedConfig.GetConfig("UI", "FalseColor")
    return toggleButton
end

function UIElements.CreateWrappedTextLabel(SkillTree, parent, text, size, position)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.Size = size or UDim2.new(1, -SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2, 0, 30)
    label.Position = position or UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "Padding"), 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text or ""
    label.TextColor3 = SkillTree.SharedConfig.GetConfig("UI", "Text")
    label.Font = SkillTree.SharedConfig.GetConfig("UI", "Font")
    label.TextSize = SkillTree.SharedConfig.GetConfig("UI", "FontSize")
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Top
    return label
end

return UIElements
