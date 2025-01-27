-- main/UI/UIElements.lua

local UIElements = {}

-- VSCode Darkmode color palette
local colors = {
    background = Color3.fromRGB(30, 30, 30), -- Dark background
    foreground = Color3.fromRGB(248, 248, 248), -- Light text
    pastelBlue = Color3.fromRGB(139, 233, 253), -- Pastel blue
    pastelGreen = Color3.fromRGB(166, 226, 46), -- Pastel green
    pastelPurple = Color3.fromRGB(171, 147, 255), -- Pastel purple
    pastelOrange = Color3.fromRGB(255, 160, 122), -- Pastel orange
}

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

function UIElements.CreateFrame(parent, size, position)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = size or UDim2.new(0.5, 0, 0.5, 0)
    frame.Position = position or UDim2.new(0.25, 0, 0.25, 0)
    frame.BackgroundColor3 = colors.background
    frame.BorderSizePixel = 0
    return frame
end

function UIElements.CreateTextLabel(parent, text, size, position)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.Size = size or UDim2.new(1, 0, 0, 30)
    label.Position = position or UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text or ""
    label.TextColor3 = colors.foreground
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    return label
end

function UIElements.CreateButton(parent, text, onClick, size, position)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Size = size or UDim2.new(0, 150, 0, 40)
    button.Position = position or UDim2.new(0.5, -75, 0.5, 0)
    button.BackgroundColor3 = colors.pastelBlue
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Text = text or ""
    button.TextColor3 = colors.background
    button.Font = Enum.Font.Gotham
    button.TextSize = 16
    button.MouseButton1Click:Connect(onClick)
    
    -- Add hover effect
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(100, 210, 230)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = colors.pastelBlue
    end)
    
    return button
end

function UIElements.CreateTextBox(parent, placeholderText, size, position)
    local textBox = Instance.new("TextBox")
    textBox.Parent = parent
    textBox.Size = size or UDim2.new(0, 200, 0, 30)
    textBox.Position = position or UDim2.new(0.5, -100, 0.5, 0)
    textBox.BackgroundColor3 = colors.background
    textBox.BorderColor3 = colors.pastelGreen
    textBox.BorderSizePixel = 2
    textBox.PlaceholderText = placeholderText or ""
    textBox.PlaceholderColor3 = colors.foreground
    textBox.TextColor3 = colors.foreground
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 16
    return textBox
end

function UIElements.CreateImageLabel(parent, imageId, size, position)
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Parent = parent
    imageLabel.Size = size or UDim2.new(0, 50, 0, 50)
    imageLabel.Position = position or UDim2.new(0, 0, 0, 0)
    imageLabel.BackgroundTransparency = 1
    imageLabel.Image = imageId or ""
    return imageLabel
end

function UIElements.CreateImageButton(parent, imageId, onClick, size, position)
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

function UIElements.CreateScrollingFrame(parent, size, position)
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Parent = parent
    scrollingFrame.Size = size or UDim2.new(0.5, 0, 0.5, 0)
    scrollingFrame.Position = position or UDim2.new(0.25, 0, 0.25, 0)
    scrollingFrame.BackgroundColor3 = colors.background
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.ScrollBarThickness = 5
    scrollingFrame.ScrollBarImageColor3 = colors.pastelPurple
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    return scrollingFrame
end

function UIElements.CreateProgressBar(parent, value, size, position)
    local progressBar = Instance.new("Frame")
    progressBar.Parent = parent
    progressBar.Size = size or UDim2.new(0.5, 0, 0, 20)
    progressBar.Position = position or UDim2.new(0.25, 0, 0.5, 0)
    progressBar.BackgroundColor3 = colors.background
    progressBar.BorderSizePixel = 0

    local progress = Instance.new("Frame")
    progress.Parent = progressBar
    progress.Size = UDim2.new(value or 0, 0, 1, 0)
    progress.Position = UDim2.new(0, 0, 0, 0)
    progress.BackgroundColor3 = colors.pastelOrange
    progress.BorderSizePixel = 0

    return progressBar, progress
end

return UIElements
