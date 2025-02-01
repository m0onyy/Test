-- THIS SCRIPT ONLY WORKS FOR PHONES NOT IPADS OR DESKTOPS
local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Line = Instance.new("ImageButton")
Line.Size = UDim2.new(0.06, 0, 0.135, 0)
Line.Position = UDim2.new(0.22, 0, -0.14, 0)
Line.BackgroundColor3 = Color3.new(0, 0, 0)
Line.BorderColor3 = Color3.new(1, 1, 1)
Line.BorderSizePixel = 1
Line.Image = "rbxassetid://79159724721875"
Line.Transparency = 0.35
Line.Draggable = true
Line.Parent = gui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(10, 10) 
Corner.Parent = Line
Line.MouseButton1Click:Connect(function()

game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
end)
