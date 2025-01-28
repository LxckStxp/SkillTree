-- main/ModuleLoader.lua

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
    log("Attempting to load module: " .. name .. " from " .. url)
    local success, module = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    
    if success and module then
        log("Successfully loaded module: " .. name)
        if module.Init then
            log("Module " .. name .. " has an Init function")
            local initSuccess, initError = pcall(function()
                log("Calling Init function for module: " .. name)
                module.Init(SkillTree)
                log("Init function for module " .. name .. " completed")
            end)
            if not initSuccess then
                internalWarn("Failed to initialize module: " .. name .. ". Error: " .. tostring(initError))
            else
                log("Successfully initialized module: " .. name)
            end
        else
            log("Module " .. name .. " does not have an Init function")
        end
        
        if module.IsPlugin then
            SkillTree.Modules[name] = module
            log("Added module " .. name .. " to SkillTree.Modules")
        else
            SkillTree[name] = module
            log("Added module " .. name .. " to SkillTree")
        end
        
        log("Loaded module: " .. name)
    else
        internalWarn("Failed to load module: " .. name .. ". Error: " .. tostring(module))
    end
end

return ModuleLoader
