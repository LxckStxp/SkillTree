-- main/Plugins/JumpPlugin.lua

local JumpPlugin = {
    IsPlugin = true
}

function JumpPlugin.Init(SkillTree)
    SkillTree.Logger.Log("JumpPlugin", "Initialized")
    
    -- Set up jump event listener
    game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.Jumping:Connect(function()
            SkillTree.Logger.Log("JumpPlugin", "Player jumped!")
        end)
    end)
end

function JumpPlugin.GetContent(SkillTree)
    return {
        "This plugin prints to the console when you jump.",
        "No buttons needed!"
    }
end

return JumpPlugin
