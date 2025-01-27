-- main/Plugins/JumpPlugin.lua

local JumpPlugin = {
    IsPlugin = true
}

function JumpPlugin.Init(SkillTree)
    SkillTree.Logger.Log("JumpPlugin", "Initialized")
    
    -- Set up jump event listener
    local function setupJumpListener()
        local player = game:GetService("Players").LocalPlayer
        if player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Jumping:Connect(function()
                    SkillTree.Logger.Log("JumpPlugin", "Player jumped!")
                end)
            end
        end
        
        player.CharacterAdded:Connect(function(character)
            local humanoid = character:WaitForChild("Humanoid")
            humanoid.Jumping:Connect(function()
                SkillTree.Logger.Log("JumpPlugin", "Player jumped!")
            end)
        end)
    end
    
    -- Set up the listener immediately if the player exists
    local player = game:GetService("Players").LocalPlayer
    if player then
        setupJumpListener()
    else
        -- If the player doesn't exist yet, wait for them to load
        game:GetService("Players").PlayerAdded:Connect(function(newPlayer)
            if newPlayer == game:GetService("Players").LocalPlayer then
                setupJumpListener()
            end
        end)
    end
end

function JumpPlugin.GetContent(SkillTree)
    return {
        "This plugin prints to the console when you jump.",
        "No buttons needed!"
    }
end

return JumpPlugin
