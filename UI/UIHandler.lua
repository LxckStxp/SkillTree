-- main/UI/UIHandler.lua

local UIHandler = {}

function UIHandler.Init(SkillTree)
    SkillTree.Logger.Log("UIHandler", "Initializing UI system")
    SkillTree.UI = {Elements = loadstring(game:HttpGet("https://raw.githubusercontent.com/LxckStxp/SkillTree/main/UI/UIElements.lua"))()}
    UIHandler.CreateMainMenu(SkillTree)
end

function UIHandler.OnStart(SkillTree) SkillTree.Logger.Log("UIHandler", "Starting UI system") end

function UIHandler.CreateMainMenu(SkillTree)
    SkillTree.Logger.Log("UIHandler", "Creating main menu")
    local screenGui = SkillTree.UI.Elements.CreateScreenGui()
    if not screenGui then
        SkillTree.Logger.Warn("UIHandler", "Failed to create ScreenGui")
        return
    end
    
    local mainFrame = SkillTree.UI.Elements.CreateFrame(screenGui, UDim2.new(0.6, 0, 0.7, 0), UDim2.new(0.2, 0, 0.15, 0))
    SkillTree.Logger.Log("UIHandler", "Main frame created")
    
    local titleLabel = SkillTree.UI.Elements.CreateTextLabel(mainFrame, "SkillTree", UDim2.new(1, 0, 0, 50), UDim2.new(0, 0, 0, 0))
    titleLabel.TextSize = 24
    SkillTree.Logger.Log("UIHandler", "Title label created")
    
    local startButton = SkillTree.UI.Elements.CreateButton(mainFrame, "Start", function() SkillTree.Logger.Log("UIHandler", "Start button clicked") end, UDim2.new(0, 150, 0, 40), UDim2.new(0.5, -75, 0.3, 0))
    SkillTree.Logger.Log("UIHandler", "Start button created")
    
    local settingsButton = SkillTree.UI.Elements.CreateButton(mainFrame, "Settings", function() SkillTree.Logger.Log("UIHandler", "Settings button clicked") end, UDim2.new(0, 150, 0, 40), UDim2.new(0.5, -75, 0.4, 0))
    SkillTree.Logger.Log("UIHandler", "Settings button created")
    
    -- Add a text box for user input
    local textBox = SkillTree.UI.Elements.CreateTextBox(mainFrame, "Enter your name", UDim2.new(0, 200, 0, 30), UDim2.new(0.5, -100, 0.5, 0))
    SkillTree.Logger.Log("UIHandler", "Text box created")
    
    -- Add an image label
    local imageLabel = SkillTree.UI.Elements.CreateImageLabel(mainFrame, "rbxassetid://4805638147", UDim2.new(0, 100, 0, 100), UDim2.new(0.5, -50, 0.6, 0))
    SkillTree.Logger.Log("UIHandler", "Image label created")
    
    -- Add a scrolling frame
    local scrollingFrame = SkillTree.UI.Elements.CreateScrollingFrame(mainFrame, UDim2.new(0.9, 0, 0.2, 0), UDim2.new(0.05, 0, 0.75, 0))
    for i = 1, 10 do
        local item = SkillTree.UI.Elements.CreateTextLabel(scrollingFrame, "Item " .. i, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, i - 1, 0))
    end
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 300)
    SkillTree.Logger.Log("UIHandler", "Scrolling frame created")
    
    -- Add a progress bar
    local progressBar, progress = SkillTree.UI.Elements.CreateProgressBar(mainFrame, 0.5, UDim2.new(0.8, 0, 0, 20), UDim2.new(0.1, 0, 0.9, 0))
    SkillTree.Logger.Log("UIHandler", "Progress bar created")
end

return UIHandler
