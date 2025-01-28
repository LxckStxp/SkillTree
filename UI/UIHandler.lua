-- main/UI/UIHandler.lua

local UIHandler = {}
local isVisible = false

function UIHandler.ToggleMenu(SkillTree)
    isVisible = not isVisible
    SkillTree.GlobalData.MainFrame.Visible = isVisible
    
    if isVisible then
        SkillTree.GlobalData.MainFrame:TweenSizeAndPosition(SkillTree.SharedConfig.GetConfig("UI", "Size"), SkillTree.SharedConfig.GetConfig("UI", "Position"), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
    else
        SkillTree.GlobalData.MainFrame:TweenSizeAndPosition(UDim2.new(0, 0, 0, 0), SkillTree.SharedConfig.GetConfig("UI", "Position"), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
    end
end

function UIHandler.Init(SkillTree)
    print("UIHandler.Init: Starting initialization")
    if not SkillTree.UIElements then
        print("UIHandler.Init: UIElements not found")
        return
    end
    
    SkillTree.UI = {Elements = SkillTree.UIElements}
    
    if not SkillTree.SharedConfig then
        print("UIHandler.Init: SharedConfig not found")
        return
    end
    
    while not SkillTree.SharedConfig or not SkillTree.SharedConfig.GetConfig("UI", "Primary") do
        wait(0.1)
    end
    
    print("UIHandler.Init: Creating main menu")
    local success, errorMsg = pcall(function()
        UIHandler.CreateMainMenu(SkillTree)
    end)
    
    if not success then
        print("UIHandler.Init: Failed to create main menu. Error: " .. tostring(errorMsg))
        return
    end
    
    print("UIHandler.Init: Setting up toggle functionality")
    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
            UIHandler.ToggleMenu(SkillTree)
        end
    end)
    
    print("UIHandler.Init: Initialization completed successfully")
end

function UIHandler.OnStart(SkillTree) end

function UIHandler.CreateMainMenu(SkillTree)
    print("UIHandler.CreateMainMenu: Starting to create main menu")
    local screenGui = SkillTree.UI.Elements.CreateScreenGui(SkillTree)
    if not screenGui then
        print("UIHandler.CreateMainMenu: Failed to create ScreenGui")
        return
    end
    
    local mainFrame = SkillTree.UI.Elements.CreateStyledFrame(SkillTree, screenGui)
    mainFrame.Visible = false
    
    local header = UIHandler.CreateHeader(SkillTree, mainFrame)
    
    local leftPanel = SkillTree.UI.Elements.CreateLeftPanel(SkillTree, mainFrame)
    local pluginsList = SkillTree.UI.Elements.CreateScrollingFrame(SkillTree, leftPanel)
    UIHandler.UpdatePluginsList(SkillTree, pluginsList)
    
    local contentArea = SkillTree.UI.Elements.CreateContentArea(SkillTree, mainFrame)
    local contentFrame = SkillTree.UI.Elements.CreateScrollingFrame(SkillTree, contentArea)
    
    SkillTree.GlobalData.MainFrame = mainFrame
    SkillTree.GlobalData.PluginsList = pluginsList
    SkillTree.GlobalData.ContentFrame = contentFrame
    
    print("UIHandler.CreateMainMenu: Main menu created successfully")
end

function UIHandler.CreateHeader(SkillTree, parent)
    local header = SkillTree.UI.Elements.CreateFrame(SkillTree, parent, UDim2.new(1, 0, 0, SkillTree.SharedConfig.GetConfig("UI", "HeaderHeight")), UDim2.new(0, 0, 0, 0))
    header.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Primary")
    
    local titleLabel = SkillTree.UI.Elements.CreateTitleLabel(SkillTree, header, "SkillTree", UDim2.new(1, -SkillTree.SharedConfig.GetConfig("UI", "Padding") * 2, 1, 0), UDim2.new(0, 0, 0, 0))
    titleLabel.Position = UDim2.new(0.5, -titleLabel.TextBounds.X/2, 0, 0)
    
    local separator = Instance.new("Frame")
    separator.Parent = header
    separator.Size = UDim2.new(1, 0, 0, SkillTree.SharedConfig.GetConfig("UI", "BorderSize"))
    separator.Position = UDim2.new(0, 0, 1, -SkillTree.SharedConfig.GetConfig("UI", "BorderSize"))
    separator.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Secondary")
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
                    
                    if item:IsA("TextButton") and item.Text == "Toggle Test" then
                        UIHandler.UpdateToggleButton(SkillTree, item.Text, false)
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
            child.TextColor3 = state and SkillTree.SharedConfig.GetConfig("UI", "TrueColor") or SkillTree.SharedConfig.GetConfig("UI", "FalseColor")
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
