-- main/Main/ModuleLoader.lua

local ModuleLoader = {}

-- Internal logging function
local function log(message)
    print("[ModuleLoader] " .. message)
end

-- Internal warning function
local function warn(message)
    warn("[ModuleLoader] " .. message)
end

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
        
        log("Loaded module: " .. name)
    else
        warn("Failed to load module: " .. name .. ". Error: " .. tostring(module))
    end
end

return ModuleLoader
