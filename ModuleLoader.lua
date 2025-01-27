-- ModuleLoader.lua

local ModuleLoader = {}

function ModuleLoader.LoadModule(name, url, SkillTree)
    local success, module = pcall(function() return loadstring(game:HttpGet(url))() end)
    if success and type(module) == "table" then
        SkillTree.Modules[name] = module
        if module.Init then module.Init(SkillTree) end
        print(string.format("[%s] Loaded module: %s", name, name))
        return module
    else
        warn(string.format("[%s] WARNING: Failed to load module: %s", name, name))
    end
end

return ModuleLoader
