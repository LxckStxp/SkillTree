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
    local mainFrame = SkillTree.UI.Elements.CreateFrame(SkillTree)
    local titleLabel = SkillTree.UI.Elements.CreateTitleLabel(SkillTree, mainFrame)
    local startButton = SkillTree.UI.Elements.CreateButton(SkillTree, mainFrame, "Start", function() SkillTree.Logger.Log("UIHandler", "Start button clicked") end)
    local settingsButton = SkillTree.UI.Elements.CreateButton(SkillTree, mainFrame, "Settings", function() SkillTree.Logger.Log("UIHandler", "Settings button clicked") end)
end

return UIHandler
