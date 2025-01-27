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
    local mainFrame = SkillTree.UI.Elements.CreateFrame(SkillTree, screenGui)
    if mainFrame then
        SkillTree.Logger.Log("UIHandler", "Main frame created")
        local titleLabel = SkillTree.UI.Elements.CreateTitleLabel(SkillTree, mainFrame)
        if titleLabel then
            SkillTree.Logger.Log("UIHandler", "Title label created")
            local startButton = SkillTree.UI.Elements.CreateButton(SkillTree, mainFrame, "Start", function() SkillTree.Logger.Log("UIHandler", "Start button clicked") end)
            if startButton then
                SkillTree.Logger.Log("UIHandler", "Start button created")
                local settingsButton = SkillTree.UI.Elements.CreateButton(SkillTree, mainFrame, "Settings", function() SkillTree.Logger.Log("UIHandler", "Settings button clicked") end)
                if settingsButton then
                    SkillTree.Logger.Log("UIHandler", "Settings button created")
                else
                    SkillTree.Logger.Warn("UIHandler", "Failed to create settings button")
                end
            else
                SkillTree.Logger.Warn("UIHandler", "Failed to create start button")
            end
        else
            SkillTree.Logger.Warn("UIHandler", "Failed to create title label")
        end
    else
        SkillTree.Logger.Warn("UIHandler", "Failed to create main frame")
    end
end

return UIHandler
