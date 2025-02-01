
local codex = nil

for _, v in pairs(game.CoreGui:GetDescendants()) do
    if v.Name == "Codex" then
        codex = v
        break
    end
end

if codex then
    local gui = codex:FindFirstChild("gui")
    if gui then
        local tabs = gui:FindFirstChild("tabs")
        if tabs then
            local console = tabs:FindFirstChild("console")
            if console then
                console:Destroy()
            end
        end
    end
end


local ScreenGui1 = Instance.new("ScreenGui") 
ScreenGui1.Parent = game.CoreGui

local TextButton1 = Instance.new("TextButton") 
TextButton1.Parent = ScreenGui1
TextButton1.Size = UDim2.new(0, 50, 0, 50)
TextButton1.Position = UDim2.new(0.01, 0, 0)
TextButton1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextButton1.BackgroundTransparency = 0.3
TextButton1.BorderSizePixel = 0
TextButton1.Text = "❕"
TextButton1.TextColor3 = Color3.fromRGB(242, 243, 243)
TextButton1.TextSize = 18

local UICorner1 = Instance.new("UICorner") 
UICorner1.Parent = TextButton1
UICorner1.CornerRadius = UDim.new(0.5, 0)

TextButton1.MouseButton1Click:Connect(function()
    -- console
    game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
end)
