-- Logger.lua

local Logger = {}

function Logger.Log(module, msg) print(string.format("[%s] [%s] %s", os.date("%Y-%m-%d %H:%M:%S"), module, msg)) end
function Logger.Warn(module, msg) warn(string.format("[%s] [%s] WARNING: %s", os.date("%Y-%m-%d %H:%M:%S"), module, msg)) end
function Logger.Error(module, msg) error(string.format("[%s] [%s] ERROR: %s", os.date("%Y-%m-%d %H:%M:%S"), module, msg)) end

function Logger.Init(SkillTree) SkillTree.Logger = Logger end

return Logger
