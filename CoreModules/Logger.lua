-- Logger.lua

local Logger = {}

function Logger.Log(module, msg) print(string.format("[%s] %s", module, msg)) end
function Logger.Warn(module, msg) warn(string.format("[%s] WARNING: %s", module, msg)) end
function Logger.Error(module, msg) error(string.format("[%s] ERROR: %s", module, msg)) end

function Logger.Init(SkillTree) SkillTree.Logger = Logger end

return Logger
