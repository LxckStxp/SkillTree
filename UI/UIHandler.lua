-- main/UI/UIHandler.lua

local UIHandler = {}
local isVisible = false

function UIHandler.Init(SkillTree)
    SkillTree.Logger.Log("UIHandler", "Initializing UI system")
    SkillTree.UI = {Elements = loadstring(game:HttpGet("https://raw.githubusercontent.com/LxckStxp/SkillTree/main/UI/UIElements.lua"))()}
    UIHandler.CreateMainMenu(SkillTree)
    
    -- Set up toggle functionality
    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
            UIHandler.ToggleMenu(SkillTree)
        end
    end)
end

function UIHandler.OnStart(SkillTree) SkillTree.Logger.Log("UIHandler", "Starting UI system") end

function UIHandler.CreateMainMenu(SkillTree)
    SkillTree.Logger.Log("UIHandler", "Creating main menu")
    local screenGui = SkillTree.UI.Elements.CreateScreenGui(SkillTree)
    if not screenGui then
        SkillTree.Logger.Warn("UIHandler", "Failed to create ScreenGui")
        return
    end
    
    local mainFrame = SkillTree.UI.Elements.CreateDraggableFrame(SkillTree, screenGui, UDim2.new(0.6, 0, 0.7, 0), UDim2.new(0.2, 0, 0.15, 0))
    mainFrame.Visible = false -- Start with the menu hidden
    mainFrame.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Background")
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = SkillTree.SharedConfig.GetConfig("UI", "Border")
    
    -- Add a subtle shadow effect
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1354494349"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.8
    shadow.Parent = mainFrame
    
    SkillTree.Logger.Log("UIHandler", "Main frame created")
    
    -- Create header
    local header = SkillTree.UI.Elements.CreateFrame(SkillTree, mainFrame, UDim2.new(1, 0, 0, 50), UDim2.new(0, 0, 0, 0))
    header.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Primary")
    header.BorderSizePixel = 0
    
    local titleLabel = SkillTree.UI.Elements.CreateTextLabel(SkillTree, header, "SkillTree", UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0))
    titleLabel.TextSize = 24
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextColor3 = SkillTree.SharedConfig.GetConfig("UI", "Text")
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    
    -- Add a subtle gradient to the header
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, SkillTree.SharedConfig.GetConfig("UI", "Primary"):Lerp(Color3.new(1, 1, 1), 0.1)),
        ColorSequenceKeypoint.new(1, SkillTree.SharedConfig.GetConfig("UI", "Primary"):Lerp(Color3.new(0, 0, 0), 0.1))
    })
    gradient.Parent = header
    
    SkillTree.Logger.Log("UIHandler", "Header created")
    
    -- Create left panel for plugins list
    local leftPanel = SkillTree.UI.Elements.CreateFrame(SkillTree, mainFrame, UDim2.new(0.3, 0, 1, -50), UDim2.new(0, 0, 0, 50))
    leftPanel.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Background")
    leftPanel.BackgroundTransparency = 0.2
    leftPanel.BorderSizePixel = 0
    
    local pluginsList = SkillTree.UI.Elements.CreateScrollingFrame(SkillTree, leftPanel, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0))
    pluginsList.BackgroundColor3 = Color3.new(1, 1, 1)
    pluginsList.BackgroundTransparency = 1
    pluginsList.ScrollBarThickness = 5
    pluginsList.ScrollBarImageColor3 = SkillTree.SharedConfig.GetConfig("UI", "Primary")
    
    UIHandler.UpdatePluginsList(SkillTree, pluginsList)
    SkillTree.Logger.Log("UIHandler", "Left panel created")
    
    -- Create content area
    local contentArea = SkillTree.UI.Elements.CreateFrame(SkillTree, mainFrame, UDim2.new(0.7, 0, 1, -50), UDim2.new(0.3, 0, 0, 50))
    contentArea.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Background")
    contentArea.BackgroundTransparency = 0.2
    contentArea.BorderSizePixel = 0
    
    local contentFrame = SkillTree.UI.Elements.CreateScrollingFrame(SkillTree, contentArea, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0))
    contentFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    contentFrame.BackgroundTransparency = 1
    contentFrame.ScrollBarThickness = 5
    contentFrame.ScrollBarImageColor3 = SkillTree.SharedConfig.GetConfig("UI", "Primary")
    
    SkillTree.Logger.Log("UIHandler", "Content area created")
    
    SkillTree.GlobalData.MainFrame = mainFrame
    SkillTree.GlobalData.PluginsList = pluginsList
    SkillTree.GlobalData.ContentFrame = contentFrame
end

function UIHandler.UpdatePluginsList(SkillTree, pluginsList)
    for _, v in pairs(pluginsList:GetChildren()) do
        if v:IsA("GuiObject") then
            v:Destroy()
        end
    end
    
    local pluginCount = 0
    for name, module in pairs(SkillTree.Modules) do
        if module.IsPlugin then
            local button = SkillTree.UI.Elements.CreateButton(SkillTree, pluginsList, name, function()
                UIHandler.ShowPluginContent(SkillTree, name)
            end, UDim2.new(1, 0, 0, 30))
            button.Position = UDim2.new(0, 0, 0, pluginCount * 30)
            button.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Background")
            button.BackgroundTransparency = 0.5
            button.BorderSizePixel = 0
            
            -- Add hover effect
            button.MouseEnter:Connect(function()
                button.BackgroundTransparency = 0.3
            end)
            button.MouseLeave:Connect(function()
                button.BackgroundTransparency = 0.5
            end)
            
            pluginCount = pluginCount + 1
        end
    end
    
    pluginsList.CanvasSize = UDim2.new(0, 0, 0, pluginCount * 30)
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
            for i, item in ipairs(content) do
                if type(item) == "userdata" and item.IsA then
                    item.Parent = contentFrame
                    item.Position = UDim2.new(0, 0, 0, (i - 1) * item.Size.Y.Offset)
                else
                    local label = SkillTree.UI.Elements.CreateTextLabel(SkillTree, contentFrame, tostring(item), UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, (i - 1) * 30))
                    label.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Background")
                    label.BackgroundTransparency = 0.8
                    label.BorderSizePixel = 0
                    label.TextColor3 = SkillTree.SharedConfig.GetConfig("UI", "Text")
                end
            end
            contentFrame.CanvasSize = UDim2.new(0, 0, 0, #content * 30)
        else
            local label = SkillTree.UI.Elements.CreateTextLabel(SkillTree, contentFrame, "No content available for this plugin.", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0))
            label.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Background")
            label.BackgroundTransparency = 0.8
            label.BorderSizePixel = 0
            label.TextColor3 = SkillTree.SharedConfig.GetConfig("UI", "Text")
        end
    else
        local label = SkillTree.UI.Elements.CreateTextLabel(SkillTree, contentFrame, "No content available for this plugin.", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0))
        label.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Background")
        label.BackgroundTransparency = 0.8
        label.BorderSizePixel = 0
        label.TextColor3 = SkillTree.SharedConfig.GetConfig("UI", "Text")
    end
end

function UIHandler.ToggleMenu(SkillTree)
    isVisible = not isVisible
    SkillTree.GlobalData.MainFrame.Visible = isVisible
end

return UIHandler
