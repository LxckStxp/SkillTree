-- main/UI/UIElements.lua

function UIElements.CreateFrame(SkillTree, parent, size, position)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = size or SkillTree.SharedConfig.GetConfig("UI", "Size")
    frame.Position = position or SkillTree.SharedConfig.GetConfig("UI", "Position")
    local backgroundColor = SkillTree.SharedConfig.GetConfig("UI", "Background")
    if backgroundColor and typeof(backgroundColor) == "Color3" then
        frame.BackgroundColor3 = backgroundColor
    else
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Default color
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

function UIElements.CreateButton(SkillTree, parent, text, onClick, size, position)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Size = size or UDim2.new(1, -SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2, 0, 30)
    button.Position = position or UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "Padding"), 0, 0)
    local buttonColor = SkillTree.SharedConfig.GetConfig("UI", "Primary")
    if buttonColor and typeof(buttonColor) == "Color3" then
        button.BackgroundColor3 = buttonColor
    else
        button.BackgroundColor3 = Color3.fromRGB(45, 45, 45) -- Default color
    end
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Text = text or ""
    button.TextColor3 = SkillTree.SharedConfig.GetConfig("UI", "Text")
    button.Font = SkillTree.SharedConfig.GetConfig("UI", "Font")
    button.TextSize = SkillTree.SharedConfig.GetConfig("UI", "FontSize")
    
    button.MouseEnter:Connect(function()
        local hoverColor = SkillTree.SharedConfig.GetConfig("UI", "Secondary")
        if hoverColor and typeof(hoverColor) == "Color3" then
            button.BackgroundColor3 = hoverColor
        else
            button.BackgroundColor3 = Color3.fromRGB(55, 55, 55) -- Default hover color
        end
        button.TextSize = SkillTree.SharedConfig.GetConfig("UI", "FontSize") + 2
    end)
    button.MouseLeave:Connect(function()
        local normalColor = SkillTree.SharedConfig.GetConfig("UI", "Primary")
        if normalColor and typeof(normalColor) == "Color3" then
            button.BackgroundColor3 = normalColor
        else
            button.BackgroundColor3 = Color3.fromRGB(45, 45, 45) -- Default normal color
        end
        button.TextSize = SkillTree.SharedConfig.GetConfig("UI", "FontSize")
    end)
    
    button.MouseButton1Click:Connect(onClick)
    
    local border = Instance.new("Frame")
    border.Parent = button
    border.Size = UDim2.new(1, SkillTree.SharedConfig.GetConfig("UI", "BorderSize") * 2, 1, SkillTree.SharedConfig.GetConfig("UI", "BorderSize") * 2)
    border.Position = UDim2.new(0, -SkillTree.SharedConfig.GetConfig("UI", "BorderSize"), 0, -SkillTree.SharedConfig.GetConfig("UI", "BorderSize"))
    border.BackgroundTransparency = 1
    border.BorderSizePixel = SkillTree.SharedConfig.GetConfig("UI", "BorderSize")
    local borderColor = SkillTree.SharedConfig.GetConfig("UI", "Tertiary")
    if borderColor and typeof(borderColor) == "Color3" then
        border.BorderColor3 = borderColor
    else
        border.BorderColor3 = Color3.fromRGB(65, 65, 65) -- Default border color
    end
    border.ZIndex = button.ZIndex - 1
    
    return button
end

function UIElements.CreateTextBox(SkillTree, parent, placeholderText, size, position)
    local textBox = Instance.new("TextBox")
    textBox.Parent = parent
    textBox.Size = size or UDim2.new(1, -SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2, 0, 30)
    textBox.Position = position or UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "Padding"), 0, 0)
    local textBoxColor = SkillTree.SharedConfig.GetConfig("UI", "Background")
    if textBoxColor and typeof(textBoxColor) == "Color3" then
        textBox.BackgroundColor3 = textBoxColor
    else
        textBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Default color
    end
    local borderColor = SkillTree.SharedConfig.GetConfig("UI", "Secondary")
    if borderColor and typeof(borderColor) == "Color3" then
        textBox.BorderColor3 = borderColor
    else
        textBox.BorderColor3 = Color3.fromRGB(55, 55, 55) -- Default border color
    end
    textBox.BorderSizePixel = SkillTree.SharedConfig.GetConfig("UI", "BorderSize")
    textBox.PlaceholderText = placeholderText or ""
    textBox.PlaceholderColor3 = SkillTree.SharedConfig.GetConfig("UI", "Text")
    textBox.TextColor3 = SkillTree.SharedConfig.GetConfig("UI", "Text")
    textBox.Font = SkillTree.SharedConfig.GetConfig("UI", "Font")
    textBox.TextSize = SkillTree.SharedConfig.GetConfig("UI", "FontSize")
    return textBox
end

function UIElements.CreateScrollingFrame(SkillTree, parent, size, position)
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Parent = parent
    scrollingFrame.Size = size or UDim2.new(1, -SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2, 1, -SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2)
    scrollingFrame.Position = position or UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "Padding"), 0, SkillTree.SharedConfig.GetConfig("UI", "Padding"))
    local frameColor = SkillTree.SharedConfig.GetConfig("UI", "Background")
    if frameColor and typeof(frameColor) == "Color3" then
        scrollingFrame.BackgroundColor3 = frameColor
    else
        scrollingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Default color
    end
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.ScrollBarThickness = SkillTree.SharedConfig.GetConfig("UI", "ScrollBarThickness")
    local scrollBarColor = SkillTree.SharedConfig.GetConfig("UI", "Tertiary")
    if scrollBarColor and typeof(scrollBarColor) == "Color3" then
        scrollingFrame.ScrollBarImageColor3 = scrollBarColor
    else
        scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(65, 65, 65) -- Default scroll bar color
    end
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    return scrollingFrame
end

function UIElements.CreateLeftPanel(SkillTree, parent)
    local leftPanel = UIElements.CreateFrame(SkillTree, parent, UDim2.new(SkillTree.SharedConfig.GetConfig("UI", "LeftPanelWidth"), 0, 1, 0), UDim2.new(0, 0, 0, 0))
    local panelColor = SkillTree.SharedConfig.GetConfig("UI", "LeftPanelColor")
    if panelColor and typeof(panelColor) == "Color3" then
        leftPanel.BackgroundColor3 = panelColor
    else
        leftPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Default color
    end
    return leftPanel
end

function UIElements.CreateContentArea(SkillTree, parent)
    local contentArea = UIElements.CreateFrame(SkillTree, parent, UDim2.new(SkillTree.SharedConfig.GetConfig("UI", "ContentAreaWidth"), 0, 1, 0), UDim2.new(SkillTree.SharedConfig.GetConfig("UI", "LeftPanelWidth"), 0, 0, 0))
    local contentColor = SkillTree.SharedConfig.GetConfig("UI", "ContentColor")
    if contentColor and typeof(contentColor) == "Color3" then
        contentArea.BackgroundColor3 = contentColor
    else
        contentArea.BackgroundColor3 = Color3.fromRGB(35, 35, 35) -- Default color
    end
    return contentArea
end

function UIElements.CreateStyledFrame(SkillTree, parent, size, position)
    local frame = UIElements.CreateDraggableFrame(SkillTree, parent, size or SkillTree.SharedConfig.GetConfig("UI", "Size"), position or SkillTree.SharedConfig.GetConfig("UI", "Position"))
    
    local border = Instance.new("Frame")
    border.Parent = frame
    border.Size = UDim2.new(1, SkillTree.SharedConfig.GetConfig("UI", "BorderSize") * 2, 1, SkillTree.SharedConfig.GetConfig("UI", "BorderSize") * 2)
    border.Position = UDim2.new(0, -SkillTree.SharedConfig.GetConfig("UI", "BorderSize"), 0, -SkillTree.SharedConfig.GetConfig("UI", "BorderSize"))
    border.BackgroundTransparency = 1
    border.BorderSizePixel = SkillTree.SharedConfig.GetConfig("UI", "BorderSize")
    local borderColor = SkillTree.SharedConfig.GetConfig("UI", "Tertiary")
    if borderColor and typeof(borderColor) == "Color3" then
        border.BorderColor3 = borderColor
    else
        border.BorderColor3 = Color3.fromRGB(65, 65, 65) -- Default border color
    end
    
    return frame
end
