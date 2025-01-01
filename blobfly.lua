-- Load OrionLib
local OrionLib = loadstring(game:HttpGet('https://github.com/m0onyy/Test/raw/refs/heads/main/Orion.lua'))()

-- Create the Window and Tabs
local window = OrionLib:MakeWindow({
    Name = "Spin and Fly Control",
    HidePremium = false
})

local spinTab = window:MakeTab({
    Name = "Spin Settings",
    Icon = "rbxassetid://6031075931", -- Icon for the spin tab
    PremiumOnly = false
})

local flyTab = window:MakeTab({
    Name = "Fly Settings",
    Icon = "rbxassetid://6031075931", -- Icon for the fly tab
    PremiumOnly = false
})

-- Spin Variables
local spinSpeed = 20
local spinning = false
local bodyAngularVelocity = nil

-- Fly Variables
local flying = false
local flyGui = nil

-- Spin Speed Control
spinTab:AddTextBox({
    Name = "Spin Speed",
    Default = "20", -- Default spin speed value
    TextDisappear = true,
    Callback = function(value)
        spinSpeed = tonumber(value) or 20
        -- If spinning, update the speed of the rotation
        if spinning and bodyAngularVelocity then
            bodyAngularVelocity.AngularVelocity = Vector3.new(0, spinSpeed, 0)
        end
    end
})

-- Toggle Spin On/Off
spinTab:AddToggle({
    Name = "Toggle Spin",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        if state then
            -- Start spinning
            bodyAngularVelocity = Instance.new("BodyAngularVelocity")
            bodyAngularVelocity.Name = "Spinning"
            bodyAngularVelocity.MaxTorque = Vector3.new(0, math.huge, 0)
            bodyAngularVelocity.AngularVelocity = Vector3.new(0, spinSpeed, 0)
            bodyAngularVelocity.Parent = humanoidRootPart
            spinning = true
        else
            -- Stop spinning
            if bodyAngularVelocity then
                bodyAngularVelocity:Destroy()
                bodyAngularVelocity = nil
            end
            spinning = false
        end
    end
})

-- Blob Fly UI Button on Fly Tab
flyTab:AddButton({
    Name = "Blob Fly UI",
    Callback = function()
        if flyGui then
            flyGui.Enabled = not flyGui.Enabled
        else
            -- Create Fly GUI
            flyGui = Instance.new("ScreenGui")
            flyGui.Parent = game.CoreGui
            flyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

            -- Dragging Frame for Fly UI
            local dragFrame = Instance.new("Frame")
            dragFrame.Parent = flyGui
            dragFrame.Active = true
            dragFrame.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
            dragFrame.BorderSizePixel = 0
            dragFrame.Draggable = true
            dragFrame.Size = UDim2.new(0, 237, 0, 27)
            dragFrame.Position = UDim2.new(0.482438415, 0, 0.454874992, 0)

            local closeButton = Instance.new("TextButton")
            closeButton.Parent = dragFrame
            closeButton.Size = UDim2.new(0, 27, 0, 27)
            closeButton.Position = UDim2.new(0.875, 0, 0, 0)
            closeButton.Text = "X"
            closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            closeButton.TextScaled = true
            closeButton.MouseButton1Click:Connect(function()
                flyGui:Destroy()
                flyGui = nil
            end)

            -- Fly Frame
            local flyFrame = Instance.new("Frame")
            flyFrame.Parent = dragFrame
            flyFrame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            flyFrame.Size = UDim2.new(0, 237, 0, 139)

            -- Speed TextBox
            local speedTextBox = Instance.new("TextBox")
            speedTextBox.Parent = flyFrame
            speedTextBox.Size = UDim2.new(0, 111, 0, 33)
            speedTextBox.Position = UDim2.new(0.445025861, 0, 0.402877688, 0)
            speedTextBox.Text = "50"
            speedTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)

            -- Toggle Fly Button
            local toggleFlyButton = Instance.new("TextButton")
            toggleFlyButton.Parent = flyFrame
            toggleFlyButton.Size = UDim2.new(0, 199, 0, 32)
            toggleFlyButton.Position = UDim2.new(0.0759493634, 0, 0.705797076, 0)
            toggleFlyButton.Text = "Toggle Fly"
            toggleFlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)

            toggleFlyButton.MouseButton1Click:Connect(function()
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

                if flying then
                    -- Stop flying
                    flying = false
                    humanoidRootPart:FindFirstChildOfClass("BodyVelocity"):Destroy()
                    humanoidRootPart:FindFirstChildOfClass("BodyGyro"):Destroy()
                else
                    -- Start flying
                    flying = true
                    local BV = Instance.new("BodyVelocity", humanoidRootPart)
                    local BG = Instance.new("BodyGyro", humanoidRootPart)
                    BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    BG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)

                    game:GetService('RunService').RenderStepped:connect(function()
                        BG.CFrame = game.Workspace.CurrentCamera.CFrame
                        BV.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * tonumber(speedTextBox.Text)
                    end)
                end
            end)
        end
    end
})

-- Initialize OrionLib
OrionLib:Init()
