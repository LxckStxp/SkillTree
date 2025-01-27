-- main/CoreModules/SharedConfig.lua

local SharedConfig = {
    UI = {
        Size = UDim2.new(0, 300, 0, 200),
        Position = UDim2.new(0.5, -150, 0.5, -100),
        FontSize = 20,
        Font = Enum.Font.Gotham,
        Primary = Color3.fromRGB(139, 233, 253), -- Previously PastelBlue
        Secondary = Color3.fromRGB(166, 226, 46), -- Previously PastelGreen
        Tertiary = Color3.fromRGB(171, 147, 255), -- Previously PastelPurple
        Accent = Color3.fromRGB(255, 160, 122), -- Previously PastelOrange
        Text = Color3.fromRGB(248, 248, 248), -- Light text
        Background = Color3.fromRGB(30, 30, 30) -- Dark background
    },
    Network = {Timeout = 5, Retries = 3}
}

function SharedConfig.GetConfig(category, key) return SharedConfig[category] and SharedConfig[category][key] end

function SharedConfig.Init(SkillTree) SkillTree.SharedConfig = SharedConfig end

return SharedConfig
