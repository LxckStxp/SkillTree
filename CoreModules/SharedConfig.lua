-- SharedConfig.lua

local SharedConfig = {
    UI = {Size = UDim2.new(0, 300, 0, 200), Position = UDim2.new(0.5, -150, 0.5, -100), FontSize = 20, Font = Enum.Font.SourceSansBold},
    Network = {Timeout = 5, Retries = 3}
}

function SharedConfig.GetConfig(category, key) return SharedConfig[category] and SharedConfig[category][key] end

function SharedConfig.Init(SkillTree) SkillTree.SharedConfig = SharedConfig end

return SharedConfig
 
