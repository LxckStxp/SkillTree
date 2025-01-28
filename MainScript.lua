-- main/MainScript.lua

print("SkillTree Incoming..")

_G.SkillTree = {Modules = {}, GlobalData = {}}

-- Load ModuleLoader
local ModuleLoader = loadstring(game:HttpGet("https://raw.githubusercontent.com/LcxkStxp/SkillTree/main/ModuleLoader.lua"))()

-- Use ModuleLoader to load itself into SkillTree
ModuleLoader.LoadModule("ModuleLoader", "https://raw.githubusercontent.com/LcxkStxp/SkillTree/main/ModuleLoader.lua", _G.SkillTree)

local function InitSkillTree()
    -- Load core modules
    ModuleLoader.LoadModule("SharedConfig", "https://raw.githubusercontent.com/LcxkStxp/SkillTree/main/CoreModules/SharedConfig.lua", _G.SkillTree)
    ModuleLoader.LoadModule("Logger", "https://raw.githubusercontent.com/LcxkStxp/SkillTree/main/CoreModules/Logger.lua", _G.SkillTree)
    
    -- Initialize core modules
    for _, module in pairs(_G.SkillTree.Modules) do
        if module.Init then
            module.Init(_G.SkillTree)
        end
    end
    
    -- Load UIElements
    ModuleLoader.LoadModule("UIElements", "https://raw.githubusercontent.com/LcxkStxp/SkillTree/main/UI/UIElements.lua", _G.SkillTree)
    
    -- Load plugins
    local plugins = {"ActionPlugin", "JumpPlugin", "ToggleTestPlugin"}
    for _, pluginName in ipairs(plugins) do
        ModuleLoader.LoadModule(pluginName, "https://raw.githubusercontent.com/LcxkStxp/SkillTree/main/Plugins/" .. pluginName .. ".lua", _G.SkillTree)
    end
    
    -- Initialize plugins
    for _, module in pairs(_G.SkillTree.Modules) do
        if module.IsPlugin and module.OnStart then
            module.OnStart(_G.SkillTree)
        end
    end
    
    -- Load UIHandler last
    ModuleLoader.LoadModule("UIHandler", "https://raw.githubusercontent.com/LcxkStxp/SkillTree/main/UI/UIHandler.lua", _G.SkillTree)
    
    -- Initialize UIHandler
    if _G.SkillTree.UIHandler and _G.SkillTree.UIHandler.Init then
        _G.SkillTree.UIHandler.Init(_G.SkillTree)
    end
end

InitSkillTree()
