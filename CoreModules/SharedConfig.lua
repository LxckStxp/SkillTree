-- main/CoreModules/SharedConfig.lua

local SharedConfig = {
    UI = {
        -- Menu size and position
        Size = UDim2.new(0, 400, 0, 300),
        Position = UDim2.new(0.5, -200, 0.5, -150),
        
        -- Font settings
        FontSize = 20,
        TitleFontSize = 24, -- New variable for title font size
        Font = Enum.Font.Roboto, -- Changed to Roboto for a modern look
        
        -- Color palette (dark mode theme with subtle variations)
        Primary = Color3.fromRGB(45, 45, 45), -- Dark gray
        Secondary = Color3.fromRGB(55, 55, 55), -- Slightly lighter gray for section backgrounds
        Tertiary = Color3.fromRGB(65, 65, 65), -- Even lighter gray for borders
        Accent = Color3.fromRGB(100, 180, 255), -- Soft blue accent
        Text = Color3.fromRGB(240, 240, 240), -- Soft white text for better readability
        Background = Color3.fromRGB(30, 30, 30), -- Dark background
        
        -- Padding and spacing
        Padding = 10,
        SectionSpacing = 20, -- New variable for spacing between sections
        
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
