-- main/CoreModules/SharedConfig.lua

local SharedConfig = {
    UI = {
        -- Menu size and position
        Size = UDim2.new(0, 400, 0, 300), -- Increased size
        Position = UDim2.new(0.5, -200, 0.5, -150), -- Adjusted position for new size
        
        -- Font settings
        FontSize = 20,
        Font = Enum.Font.Gotham,
        
        -- Color palette (dark mode theme with less clashing colors)
        Primary = Color3.fromRGB(45, 45, 45), -- Dark gray
        Secondary = Color3.fromRGB(60, 60, 60), -- Slightly lighter gray
        Tertiary = Color3.fromRGB(75, 75, 75), -- Even lighter gray
        Accent = Color3.fromRGB(100, 180, 255), -- Soft blue accent
        Text = Color3.fromRGB(220, 220, 220), -- Light gray text
        Background = Color3.fromRGB(30, 30, 30), -- Dark background
        
        -- Padding
        Padding = 10,
        
        -- Other UI settings
        ScrollBarThickness = 5,
        BorderSize = 1,
        HeaderHeight = 40,
        LeftPanelWidth = 0.3,
        ContentAreaWidth = 0.7
    },
    Network = {
        Timeout = 5,
        Retries = 3
    }
}

function SharedConfig.GetConfig(category, key) 
    return SharedConfig[category] and SharedConfig[category][key] 
end

function SharedConfig.Init(SkillTree) 
    SkillTree.SharedConfig = SharedConfig 
end

return SharedConfig
