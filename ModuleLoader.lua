-- main/Main/ModuleLoader.lua

local ModuleLoader = {}

function ModuleLoader.LoadModule(name, url, SkillTree)
    local success, module = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    
    if success and module then
        if module.Init then
            module.Init(SkillTree)
        end
        
        if module.IsPlugin then
            SkillTree.Modules[name] = module
        else
            SkillTree[name] = module
        end
        
        SkillTree.Logger.Log("ModuleLoader", "Loaded module: " .. name)
    else
        SkillTree.Logger.Warn("ModuleLoader", "Failed to load module: " .. name .. ". Error: " .. tostring(module))
    end
end

return ModuleLoader
