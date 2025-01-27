-- main/Main/ModuleLoader.lua

local ModuleLoader = {}

-- Internal logging function
local function log(message)
    print("[ModuleLoader] " .. message)
end

-- Internal warning function
local function internalWarn(message)
    warn("[ModuleLoader] " .. message)
end

function ModuleLoader.LoadModule(name, url, SkillTree)
    log("Attempting to load module: " .. name)
    local success, module = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    
    if success and module then
        if module.Init then
            local initSuccess, initError = pcall(function()
                module.Init(SkillTree)
            end)
            if not initSuccess then
                internalWarn("Failed to initialize module: " .. name .. ". Error: " .. tostring(initError))
            else
                log("Successfully initialized module: " .. name)
            end
        end
        
        if module.IsPlugin then
            SkillTree.Modules[name] = module
        else
            SkillTree[name] = module
        end
        
        log("Loaded module: " .. name)
    else
        internalWarn("Failed to load module: " .. name .. ". Error: " .. tostring(module))
    end
end

return ModuleLoader
