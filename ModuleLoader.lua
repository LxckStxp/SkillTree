-- ModuleLoader.lua

local ModuleLoader = {}

function ModuleLoader.LoadModule(name, url, SkillTree)
    local success, module = pcall(function() return loadstring(game:HttpGet(url))() end)
    if success and type(module) == "table" then
        SkillTree.Modules[name] = module
        if module.Init then module.Init(SkillTree) end
        print(string.format("[%s] [%s] Loaded module: %s", os.date("%Y-%m-%d %H:%M:%S"), "ModuleLoader", name))
        return module
    else
        warn(string.format("[%s] [%s] WARNING: Failed to load module: %s", os.date("%Y-%m-%d %H:%M:%S"), "ModuleLoader", name))
    end
end

return ModuleLoader
