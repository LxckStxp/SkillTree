-- CoreUtils.lua

local CoreUtils = {}

function CoreUtils.Init(SkillTree) SkillTree.GlobalData.SomeImportantData = "Initialized" end

function CoreUtils.UtilityFunction() SkillTree.Logger.Log("CoreUtils", "Utility function called"); return "Utility function result" end

return CoreUtils
 
