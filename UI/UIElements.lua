-- main/UI/UIElements.lua

local UIElements = {}

function UIElements.CreateScreenGui(SkillTree)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer.PlayerGui
    if not screenGui.Parent then return nil end
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 100
    return screenGui
end

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
    label.Font = Enum.Font.SourceSansBold
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
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Secondary")
        button.TextSize = SkillTree.SharedConfig.GetConfig("UI", "FontSize") + 2
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Primary")
        button.TextSize = SkillTree.SharedConfig.GetConfig("UI", "FontSize")
    end)
    
    button.MouseButton1Click:Connect(onClick)
    
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

function UIElements.CreateLeftPanel(SkillTree, parent)
    local leftPanel = UIElements.CreateFrame(SkillTree, parent, UDim2.new(SkillTree.SharedConfig.GetConfig("UI", "LeftPanelWidth"), 0, 1, 0), UDim2.new(0, 0, 0, 0))
    leftPanel.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "LeftPanelColor")
    return leftPanel
end

function UIElements.CreateContentArea(SkillTree, parent)
    local contentArea = UIElements.CreateFrame(SkillTree, parent, UDim2.new(SkillTree.SharedConfig.GetConfig("UI", "ContentAreaWidth"), 0, 1, 0), UDim2.new(SkillTree.SharedConfig.GetConfig("UI", "LeftPanelWidth"), 0, 0, 0))
    contentArea.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "ContentColor")
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
    border.BorderColor3 = SkillTree.SharedConfig.GetConfig("UI", "Tertiary")
    
    return frame
end

return UIElements
