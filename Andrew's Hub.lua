local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Andrew's hub",
    LoadingTitle = "Welcome to Andrew's Hub",
    LoadingSubtitle = "by Andrew",
    Theme = "Default",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Andrewhub",
        FileName = "Config"
    }
})

local WelcomeTab = Window:CreateTab("Welcome!")
WelcomeTab:CreateLabel("Hello, I am Andrew and I created this basic script for utility purposes")

WelcomeTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local Player = game.Players.LocalPlayer
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)
    end
})

WelcomeTab:CreateButton({
    Name = "Leave Game",
    Callback = function()
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer

        local function autoLeave()
            if player then
                player:Kick("You have left the game.")
                -- game:Shutdown() won't execute after Kick(), but in case the script is run in Studio or by error:
                task.delay(1, function()
                    pcall(function()
                        game:Shutdown()
                    end)
                end)
            end
        end

        autoLeave()
    end
})

WelcomeTab:CreateButton({
    Name = "Reset Character",
    Callback = function()
        local Player = game.Players.LocalPlayer
        if Player.Character then
            Player.Character:BreakJoints()
        end
    end
})

WelcomeTab:CreateToggle({
    Name = "Join/Leave Notifications",
    CurrentValue = false,
    Callback = function(value)
        _G.JoinLeaveNotifications = value
        if value then
            game.Players.PlayerAdded:Connect(function(player)
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Player Joined",
                    Text = player.Name .. " has joined the game!",
                    Duration = 5
                })
            end)
            game.Players.PlayerRemoving:Connect(function(player)
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Player Left",
                    Text = player.Name .. " has left the game!",
                    Duration = 5
                })
            end)
        end
    end
})
WelcomeTab:CreateLabel("Home")

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local destinationPlaceId = 111248419958538 -- Your Hub game ID

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Backquote then
        TeleportService:Teleport(destinationPlaceId, Players.LocalPlayer)
    end
end)

local TogglesTab = Window:CreateTab("Toggles")

TogglesTab:CreateButton({
    Name = "Infinite Jump",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local UIS = game:GetService("UserInputService")
        UIS.JumpRequest:Connect(function()
            if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
                Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
})

TogglesTab:CreateToggle({
    Name = "Full Bright",
    CurrentValue = false,
    Callback = function(value)
        if value then
            game:GetService("Lighting").Brightness = 2
            game:GetService("Lighting").ClockTime = 12
            game:GetService("Lighting").FogEnd = 100000
            game:GetService("Lighting").GlobalShadows = false
        else
            game:GetService("Lighting").Brightness = 1
            game:GetService("Lighting").ClockTime = 14
            game:GetService("Lighting").FogEnd = 1000
            game:GetService("Lighting").GlobalShadows = true
        end
    end
})

TogglesTab:CreateInput({
    Name = "Custom Speed",
    PlaceholderText = "Enter speed value",
    RemoveTextAfterFocusLost = false,
    Callback = function(value)
        _G.CustomSpeedValue = tonumber(value) or 16
    end
})

TogglesTab:CreateToggle({
    Name = "Enable Custom Speed",
    CurrentValue = false,
    Callback = function(value)
        local Player = game.Players.LocalPlayer
        _G.CustomSpeedEnabled = value

        local function applySpeed()
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                if _G.CustomSpeedEnabled then
                    Player.Character.Humanoid.WalkSpeed = _G.CustomSpeedValue or 16
                else
                    Player.Character.Humanoid.WalkSpeed = 16
                end
            end
        end

        Player.CharacterAdded:Connect(function()
            wait(0.1) -- Small delay to ensure character is fully loaded
            applySpeed()
        end)

        applySpeed()
    end
})

TogglesTab:CreateInput({
    Name = "Custom Jump Power",
    PlaceholderText = "Enter jump power value",
    RemoveTextAfterFocusLost = false,
    Callback = function(value)
        _G.CustomJumpPowerValue = tonumber(value) or 50
    end
})

TogglesTab:CreateToggle({
    Name = "Enable Custom Jump Power",
    CurrentValue = false,
    Callback = function(value)
        local Player = game.Players.LocalPlayer
        _G.CustomJumpPowerEnabled = value

        local function applyJumpPower()
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                if _G.CustomJumpPowerEnabled then
                    Player.Character.Humanoid.JumpPower = _G.CustomJumpPowerValue or 50
                else
                    Player.Character.Humanoid.JumpPower = 16
                end
            end
        end

        Player.CharacterAdded:Connect(function()
            wait(0.1) -- Small delay to ensure character is fully loaded
            applyJumpPower()
        end)

        applyJumpPower()
    end
})

local PrebuiltTab = Window:CreateTab("Prebuilt Scripts")


PrebuiltTab:CreateLabel("Anti-AFK Script (Always Active)")

-- Run the Anti-AFK script
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)



PrebuiltTab:CreateButton({
    Name = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})


PrebuiltTab:CreateButton({
    Name = "Emotes",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/eCpipCTH"))()
    end
})

PrebuiltTab:CreateButton({
    Name = "Animations",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ExploitFin/AquaMatrix/refs/heads/AquaMatrix/AquaMatrix"))()
    end
})



PrebuiltTab:CreateButton({
    Name = "Dex Explorer",
    Callback = function()
        loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
    end
})

PrebuiltTab:CreateButton({
    Name = "Orca",
    Callback = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/richie0866/orca/master/public/latest.lua"))()
    end
})


local MiscTab = Window:CreateTab("Misc")

MiscTab:CreateButton({
    Name = "Teleport to Spawn",
    Callback = function()
        local Player = game.Players.LocalPlayer
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local spawnLocation = workspace:FindFirstChild("SpawnLocation")
            if spawnLocation then
                Player.Character.HumanoidRootPart.CFrame = spawnLocation.CFrame
            else
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Error",
                    Text = "Spawn location not found!",
                    Duration = 5
                })
            end
        end
    end
})
