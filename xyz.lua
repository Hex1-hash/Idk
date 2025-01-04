local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Settings
local autoFarmEnabled = false
local superFastAttackEnabled = false
local autoFarmDelay = 0.5
local fastAttackDelay = 0.1

-- Functions for features
function autoFarm()
    while autoFarmEnabled do
        local closestEnemy = nil
        local shortestDistance = math.huge

        for _, mob in pairs(workspace:GetChildren()) do
            if mob:FindFirstChild("HumanoidRootPart") and mob.Name ~= player.Name then
                local distance = (mob.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestEnemy = mob
                end
            end
        end

        if closestEnemy then
            character.HumanoidRootPart.CFrame = CFrame.new(closestEnemy.HumanoidRootPart.Position)
            game:GetService("ReplicatedStorage").Remotes.Combat:FireServer("Melee")
        end
        
        wait(autoFarmDelay)
    end
end

function superFastAttack()
    while superFastAttackEnabled do
        game:GetService("ReplicatedStorage").Remotes.Combat:FireServer("Melee")
        wait(fastAttackDelay)
    end
end

function superBring()
    local closestEnemy = nil
    local shortestDistance = math.huge

    for _, mob in pairs(workspace:GetChildren()) do
        if mob:FindFirstChild("HumanoidRootPart") and mob.Name ~= player.Name then
            local distance = (mob.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestEnemy = mob
            end
        end
    end

    if closestEnemy then
        character.HumanoidRootPart.CFrame = CFrame.new(closestEnemy.HumanoidRootPart.Position)
    end
end

-- GUI setup
local screenGui = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local autoFarmButton = Instance.new("TextButton")
local superFastAttackButton = Instance.new("TextButton")
local superBringButton = Instance.new("TextButton")

screenGui.Parent = player:WaitForChild("PlayerGui")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 250, 0, 200)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -100)

autoFarmButton.Parent = mainFrame
autoFarmButton.Text = "Start Auto Farm"
autoFarmButton.Size = UDim2.new(0, 200, 0, 50)
autoFarmButton.Position = UDim2.new(0, 25, 0, 25)
autoFarmButton.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    if autoFarmEnabled then
        autoFarm()
        autoFarmButton.Text = "Stop Auto Farm"
    else
        autoFarmButton.Text = "Start Auto Farm"
    end
end)

superFastAttackButton.Parent = mainFrame
superFastAttackButton.Text = "Start Fast Attack"
superFastAttackButton.Size = UDim2.new(0, 200, 0, 50)
superFastAttackButton.Position = UDim2.new(0, 25, 0, 80)
superFastAttackButton.MouseButton1Click:Connect(function()
    superFastAttackEnabled = not superFastAttackEnabled
    if superFastAttackEnabled then
        superFastAttack()
        superFastAttackButton.Text = "Stop Fast Attack"
    else
        superFastAttackButton.Text = "Start Fast Attack"
    end
end)

superBringButton.Parent = mainFrame
superBringButton.Text = "Super Bring"
superBringButton.Size = UDim2.new(0, 200, 0, 50)
superBringButton.Position = UDim2.new(0, 25, 0, 135)
superBringButton.MouseButton1Click:Connect(function()
    superBring()
end)
