-- MainScript.lua

_G.SkillTree = {Modules = {}, GlobalData = {}}

local ModuleLoader = ModuleLoader.LoadModule("ModuleLoader", "https://github.com/SkillTree/Main/ModuleLoader.lua", _G.SkillTree)

local function InitSkillTree()
    ModuleLoader.LoadModule("SharedConfig", "https://github.com/SkillTree/CoreModules/SharedConfig.lua", _G.SkillTree)
    ModuleLoader.LoadModule("Logger", "https://github.com/SkillTree/CoreModules/Logger.lua", _G.SkillTree)
    ModuleLoader.LoadModule("CoreUtils", "https://github.com/SkillTree/Modules/CoreUtils.lua", _G.SkillTree)
    ModuleLoader.LoadModule("NetworkManager", "https://github.com/SkillTree/Modules/NetworkManager.lua", _G.SkillTree)
    ModuleLoader.LoadModule("UIHandler", "https://github.com/SkillTree/Modules/UIHandler.lua", _G.SkillTree)
    
    for _, module in pairs(_G.SkillTree.Modules) do
        if module.OnStart then module.OnStart(_G.SkillTree) end
    end
end

InitSkillTree()
