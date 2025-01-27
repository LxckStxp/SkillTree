-- main/Plugins/JumpPlugin.lua

local JumpPlugin = {
    IsPlugin = true
}

function JumpPlugin.Init(SkillTree)
    SkillTree.Logger.Log("JumpPlugin", "Initialized")
    
    local function setupJumpListener(character)
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Jumping:Connect(function()
                SkillTree.Logger.Log("JumpPlugin", "Player jumped!")
            end)
        else
            character:WaitForChild("Humanoid").Jumping:Connect(function()
                SkillTree.Logger.Log("JumpPlugin", "Player jumped!")
            end)
        end
    end
    
    local function setupPlayerListener(player)
        if player.Character then
            setupJumpListener(player.Character)
        end
        
        player.CharacterAdded:Connect(setupJumpListener)
    end
    
    -- Set up the listener immediately if the player exists
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    if localPlayer then
        setupPlayerListener(localPlayer)
    else
        -- If the player doesn't exist yet, wait for them to load
        players.PlayerAdded:Connect(function(newPlayer)
            if newPlayer == players.LocalPlayer then
                setupPlayerListener(newPlayer)
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
