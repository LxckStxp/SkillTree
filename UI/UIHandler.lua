-- main/UI/UIHandler.lua

local UIHandler = {}
local isVisible = false

function UIHandler.ToggleMenu(SkillTree)
    isVisible = not isVisible
    SkillTree.GlobalData.MainFrame.Visible = isVisible
    
    -- Add a smooth transition effect
    if isVisible then
        SkillTree.GlobalData.MainFrame:TweenSizeAndPosition(SkillTree.SharedConfig.GetConfig("UI", "Size"), SkillTree.SharedConfig.GetConfig("UI", "Position"), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
    else
        SkillTree.GlobalData.MainFrame:TweenSizeAndPosition(UDim2.new(0, 0, 0, 0), SkillTree.SharedConfig.GetConfig("UI", "Position"), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
    end
end

function UIHandler.Init(SkillTree)
    SkillTree.Logger.Log("UIHandler", "Initializing UI system")
    SkillTree.Logger.Log("UIHandler", "Checking if UIElements is loaded: " .. tostring(SkillTree.UIElements ~= nil))
    SkillTree.Logger.Log("UIHandler", "Checking if SharedConfig is loaded: " .. tostring(SkillTree.SharedConfig ~= nil))
    if SkillTree.SharedConfig then
        SkillTree.Logger.Log("UIHandler", "SharedConfig.Primary: " .. tostring(SkillTree.SharedConfig.GetConfig("UI", "Primary")))
        SkillTree.Logger.Log("UIHandler", "SharedConfig.Secondary: " .. tostring(SkillTree.SharedConfig.GetConfig("UI", "Secondary")))
        SkillTree.Logger.Log("UIHandler", "SharedConfig.Tertiary: " .. tostring(SkillTree.SharedConfig.GetConfig("UI", "Tertiary")))
        SkillTree.Logger.Log("UIHandler", "SharedConfig.Accent: " .. tostring(SkillTree.SharedConfig.GetConfig("UI", "Accent")))
        SkillTree.Logger.Log("UIHandler", "SharedConfig.Text: " .. tostring(SkillTree.SharedConfig.GetConfig("UI", "Text")))
        SkillTree.Logger.Log("UIHandler", "SharedConfig.Background: " .. tostring(SkillTree.SharedConfig.GetConfig("UI", "Background")))
        SkillTree.Logger.Log("UIHandler", "SharedConfig.TrueColor: " .. tostring(SkillTree.SharedConfig.GetConfig("UI", "TrueColor")))
        SkillTree.Logger.Log("UIHandler", "SharedConfig.FalseColor: " .. tostring(SkillTree.SharedConfig.GetConfig("UI", "FalseColor")))
    end
    SkillTree.UI = {Elements = SkillTree.UIElements} -- Use the pre-loaded UIElements
    SkillTree.Logger.Log("UIHandler", "UIElements assigned to SkillTree.UI.Elements")
    UIHandler.CreateMainMenu(SkillTree)
    
    -- Set up toggle functionality
    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
            SkillTree.Logger.Log("UIHandler", "Toggle key pressed")
            UIHandler.ToggleMenu(SkillTree)
        end
    end)
end

function UIHandler.OnStart(SkillTree) 
    SkillTree.Logger.Log("UIHandler", "Starting UI system") 
end

function UIHandler.CreateMainMenu(SkillTree)
    SkillTree.Logger.Log("UIHandler", "Creating main menu")
    local screenGui = SkillTree.UI.Elements.CreateScreenGui(SkillTree)
    if not screenGui then
        SkillTree.Logger.Warn("UIHandler", "Failed to create ScreenGui")
        return
    end
    
    local mainFrame = SkillTree.UI.Elements.CreateStyledFrame(SkillTree, screenGui)
    mainFrame.Visible = false -- Start with the menu hidden
    SkillTree.Logger.Log("UIHandler", "Main frame created")
    
    -- Create header
    local header = UIHandler.CreateHeader(SkillTree, mainFrame)
    SkillTree.Logger.Log("UIHandler", "Header created")
    
    -- Create left panel for plugins list
    local leftPanel = SkillTree.UI.Elements.CreateLeftPanel(SkillTree, mainFrame)
    local pluginsList = SkillTree.UI.Elements.CreateScrollingFrame(SkillTree, leftPanel)
    UIHandler.UpdatePluginsList(SkillTree, pluginsList)
    SkillTree.Logger.Log("UIHandler", "Left panel created")
    
    -- Create content area
    local contentArea = SkillTree.UI.Elements.CreateContentArea(SkillTree, mainFrame)
    local contentFrame = SkillTree.UI.Elements.CreateScrollingFrame(SkillTree, contentArea)
    SkillTree.Logger.Log("UIHandler", "Content area created")
    
    SkillTree.GlobalData.MainFrame = mainFrame
    SkillTree.GlobalData.PluginsList = pluginsList
    SkillTree.GlobalData.ContentFrame = contentFrame
end

function UIHandler.CreateHeader(SkillTree, parent)
    local header = SkillTree.UI.Elements.CreateFrame(SkillTree, parent, UDim2.new(1, 0, 0, SkillTree.SharedConfig.GetConfig("UI", "HeaderHeight")), UDim2.new(0, 0, 0, 0))
    SkillTree.Logger.Log("UIHandler", "HeaderColor: " .. tostring(SkillTree.SharedConfig.GetConfig("UI", "Primary")))
    local headerColor = SkillTree.SharedConfig.GetConfig("UI", "Primary")
    if headerColor and typeof(headerColor) == "Color3" then
        header.BackgroundColor3 = headerColor
        SkillTree.Logger.Log("UIHandler", "Set header.BackgroundColor3 to: " .. tostring(header.BackgroundColor3))
    else
        SkillTree.Logger.Warn("UIHandler", "Invalid header color. Using default color.")
        header.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Default color
        SkillTree.Logger.Log("UIHandler", "Set header.BackgroundColor3 to default: " .. tostring(header.BackgroundColor3))
    end
    
    -- Center-aligned title with increased font size
    local titleLabel = SkillTree.UI.Elements.CreateTitleLabel(SkillTree, header, "SkillTree", UDim2.new(1, -SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2, 1, 0), UDim2.new(0, 0, 0, 0))
    titleLabel.Position = UDim2.new(0.5, -titleLabel.TextBounds.X/2, 0, 0)
    
    -- Add a subtle separator line
    local separator = Instance.new("Frame")
    separator.Parent = header
    separator.Size = UDim2.new(1, 0, 0, SkillTree.SharedConfig.GetConfig("UI", "BorderSize"))
    separator.Position = UDim2.new(0, 0, 1, -SkillTree.SharedConfig.GetConfig("UI", "BorderSize"))
    
    local separatorColor = SkillTree.SharedConfig.GetConfig("UI", "Secondary")
    SkillTree.Logger.Log("UIHandler", "SeparatorColor: " .. tostring(separatorColor))
    if separatorColor and typeof(separatorColor) == "Color3" then
        separator.BackgroundColor3 = separatorColor
        SkillTree.Logger.Log("UIHandler", "Set separator.BackgroundColor3 to: " .. tostring(separator.BackgroundColor3))
    else
        SkillTree.Logger.Warn("UIHandler", "Invalid separator color. Using default color.")
        separator.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Default color
        SkillTree.Logger.Log("UIHandler", "Set separator.BackgroundColor3 to default: " .. tostring(separator.BackgroundColor3))
    end
    
    separator.BorderSizePixel = 0
    
    return header
end 

function UIHandler.UpdatePluginsList(SkillTree, pluginsList)
    for _, v in pairs(pluginsList:GetChildren()) do
        if v:IsA("GuiObject") then
            v:Destroy()
        end
    end
    
    local pluginCount = 0
    local buttonHeight = 30 + SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2
    for name, module in pairs(SkillTree.Modules) do
        if module.IsPlugin then
            local button = SkillTree.UI.Elements.CreateButton(SkillTree, pluginsList, name, function()
                UIHandler.ShowPluginContent(SkillTree, name)
            end)
            button.Position = UDim2.new(0, 0, 0, pluginCount * (buttonHeight + SkillTree.SharedConfig.GetConfig("UI", "SectionSpacing")))
            pluginCount = pluginCount + 1
        end
    end
    
    pluginsList.CanvasSize = UDim2.new(0, 0, 0, pluginCount * (buttonHeight + SkillTree.SharedConfig.GetConfig("UI", "SectionSpacing")))
end

function UIHandler.ShowPluginContent(SkillTree, pluginName)
    local contentFrame = SkillTree.GlobalData.ContentFrame
    for _, v in pairs(contentFrame:GetChildren()) do
        if v:IsA("GuiObject") then
            v:Destroy()
        end
    end
    
    local plugin = SkillTree.Modules[pluginName]
    if plugin and plugin.GetContent then
        local content = plugin.GetContent(SkillTree)
        if content then
            local itemHeight = 30 + SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2
            for i, item in ipairs(content) do
                local yPosition = (i - 1) * (itemHeight + SkillTree.SharedConfig.GetConfig("UI", "SectionSpacing"))
                
                if type(item) == "userdata" and item.IsA then
                    item.Parent = contentFrame
                    item.Position = UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "Padding"), 0, yPosition)
                    
                    -- Handle toggle button
                    if item:IsA("TextButton") and item.Text == "Toggle Test" then
                        UIHandler.UpdateToggleButton(SkillTree, item.Text, false) -- Initialize as false
                    end
                else
                    local label = UIHandler.CreateWrappedTextLabel(SkillTree, contentFrame, tostring(item), UDim2.new(1, -SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2, 0, 30), UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "Padding"), 0, yPosition))
                    itemHeight = label.TextBounds.Y + SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2
                    label.Size = UDim2.new(1, -SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2, 0, itemHeight)
                end
            end
            
            contentFrame.CanvasSize = UDim2.new(0, 0, 0, #content * (itemHeight + SkillTree.SharedConfig.GetConfig("UI", "SectionSpacing")))
        else
            SkillTree.UI.Elements.CreateTextLabel(SkillTree, contentFrame, "No content available for this plugin.", nil, UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "Padding"), 0, 0))
        end
    else
        SkillTree.UI.Elements.CreateTextLabel(SkillTree, contentFrame, "No content available for this plugin.", nil, UDim2.new(0, SkillTree.SharedConfig.GetConfig("UI", "Padding"), 0, 0))
    end
end

function UIHandler.UpdateToggleButton(SkillTree, buttonText, state)
    local contentFrame = SkillTree.GlobalData.ContentFrame
    for _, child in ipairs(contentFrame:GetChildren()) do
        if child:IsA("TextButton") and child.Text == buttonText then
            if state then
                child.TextColor3 = SkillTree.SharedConfig.GetConfig("UI", "TrueColor")
            else
                child.TextColor3 = SkillTree.SharedConfig.GetConfig("UI", "FalseColor")
            end
        end
    end
end

function UIHandler.CreateWrappedTextLabel(SkillTree, parent, text, size, position)
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

return UIHandler
 
