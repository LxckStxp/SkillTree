-- CoreUtils.lua

local CoreUtils = {}

function CoreUtils.Init(SkillTree) SkillTree.GlobalData.SomeImportantData = "Initialized" end

function CoreUtils.UtilityFunction() return "Utility function result" end

return CoreUtils
