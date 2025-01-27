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
    SkillTree.Logger.Log("UIHandler", "Main frame created")
    
    -- Create header
    local header = SkillTree.UI.Elements.CreateFrame(SkillTree, mainFrame, UDim2.new(1, 0, 0, 50), UDim2.new(0, 0, 0, 0))
    header.BackgroundColor3 = SkillTree.SharedConfig.GetConfig("UI", "Primary")
    local titleLabel = SkillTree.UI.Elements.CreateTextLabel(SkillTree, header, "SkillTree", UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0))
    titleLabel.TextSize = 24
    SkillTree.Logger.Log("UIHandler", "Header created")
    
    -- Create left panel for plugins list
    local leftPanel = SkillTree.UI.Elements.CreateFrame(SkillTree, mainFrame, UDim2.new(0.3, 0, 1, -50), UDim2.new(0, 0, 0, 50))
    local pluginsList = SkillTree.UI.Elements.CreateScrollingFrame(SkillTree, leftPanel, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0))
    UIHandler.UpdatePluginsList(SkillTree, pluginsList)
    SkillTree.Logger.Log("UIHandler", "Left panel created")
    
    -- Create content area
    local contentArea = SkillTree.UI.Elements.CreateFrame(SkillTree, mainFrame, UDim2.new(0.7, 0, 1, -50), UDim2.new(0.3, 0, 0, 50))
    local contentFrame = SkillTree.UI.Elements.CreateScrollingFrame(SkillTree, contentArea, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0))
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
                end
            end
            contentFrame.CanvasSize = UDim2.new(0, 0, 0, #content * 30)
        else
            SkillTree.UI.Elements.CreateTextLabel(SkillTree, contentFrame, "No content available for this plugin.", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0))
        end
    else
        SkillTree.UI.Elements.CreateTextLabel(SkillTree, contentFrame, "No content available for this plugin.", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0))
    end
end

function UIHandler.ToggleMenu(SkillTree)
    isVisible = not isVisible
    SkillTree.GlobalData.MainFrame.Visible = isVisible
end

return UIHandler
