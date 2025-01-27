-- UIHandler.lua

local UIHandler = {}

function UIHandler.Init(SkillTree)
    SkillTree.Logger.Log("UIHandler", "Initializing UI system")
    SkillTree.UI = {Elements = loadstring(game:HttpGet("https://raw.githubusercontent.com/SkillTree/UI/UIElements.lua"))()}
    UIHandler.CreateInitialUI(SkillTree)
end

function UIHandler.OnStart(SkillTree) SkillTree.Logger.Log("UIHandler", "Starting UI system") end

function UIHandler.CreateInitialUI(SkillTree)
    SkillTree.Logger.Log("UIHandler", "Creating initial UI")
    local mainFrame = SkillTree.UI.Elements.Create("Frame", {
        Name = "SkillTreeMainFrame",
        Size = SkillTree.SharedConfig.GetConfig("UI", "Size"),
        Position = SkillTree.SharedConfig.GetConfig("UI", "Position"),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 0.5
    })
    
    SkillTree.UI.Elements.Create("TextLabel", {
        Name = "SkillTreeTitle",
        Parent = mainFrame,
        Size = UDim2.new(1, 0, 0, 30),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.new(1, 1, 1),
        Text = "SkillTree",
        TextColor3 = Color3.new(0, 0, 0),
        Font = SkillTree.SharedConfig.GetConfig("UI", "Font"),
        TextSize = SkillTree.SharedConfig.GetConfig("UI", "FontSize")
    })
end

return UIHandler
