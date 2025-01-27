-- ModuleLoader.lua

local ModuleLoader = {}

function ModuleLoader.LoadModule(name, url, SkillTree)
    local success, module = pcall(function() return loadstring(game:HttpGet(url))() end)
    if success and type(module) == "table" then
        SkillTree.Modules[name] = module
        if module.Init then module.Init(SkillTree) end
        print(string.format("[%s] %s", "ModuleLoader", "Loaded module: " .. name))
        return module
    else
        warn(string.format("[%s] WARNING: %s", "ModuleLoader", "Failed to load module: " .. name))
    end
end

return ModuleLoader
