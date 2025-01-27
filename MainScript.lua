-- main/MainScript.lua

_G.SkillTree = {Modules = {}, GlobalData = {}}

-- Load Logger first
local Logger = loadstring(game:HttpGet("https://raw.githubusercontent.com/LxckStxp/SkillTree/main/CoreModules/Logger.lua"))()
Logger.Init(_G.SkillTree)

-- Load ModuleLoader
local ModuleLoader = loadstring(game:HttpGet("https://raw.githubusercontent.com/LxckStxp/SkillTree/main/ModuleLoader.lua"))()

-- Use ModuleLoader to load itself into SkillTree
ModuleLoader.LoadModule("ModuleLoader", "https://raw.githubusercontent.com/LxckStxp/SkillTree/main/ModuleLoader.lua", _G.SkillTree)

local function InitSkillTree()
    -- Load core modules
    ModuleLoader.LoadModule("SharedConfig", "https://raw.githubusercontent.com/LxckStxp/SkillTree/main/CoreModules/SharedConfig.lua", _G.SkillTree)
    ModuleLoader.LoadModule("CoreUtils", "https://raw.githubusercontent.com/LxckStxp/SkillTree/main/Modules/CoreUtils.lua", _G.SkillTree)
    ModuleLoader.LoadModule("NetworkManager", "https://raw.githubusercontent.com/LxckStxp/SkillTree/main/Modules/NetworkManager.lua", _G.SkillTree)
    ModuleLoader.LoadModule("UIHandler", "https://raw.githubusercontent.com/LxckStxp/SkillTree/main/UI/UIHandler.lua", _G.SkillTree)
    
    -- Load plugins
    local plugins = {"ActionPlugin", "JumpPlugin"}
    for _, pluginName in ipairs(plugins) do
        ModuleLoader.LoadModule(pluginName, "https://raw.githubusercontent.com/LxckStxp/SkillTree/main/Plugins/" .. pluginName .. ".lua", _G.SkillTree)
    end
    
    -- Initialize all modules
    for _, module in pairs(_G.SkillTree.Modules) do
        if module.OnStart then module.OnStart(_G.SkillTree) end
    end
end

InitSkillTree()
