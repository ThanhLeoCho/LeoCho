-- LeoChoCho Hub - Fake x36 Luck GUI v3 (Toggle Activate + Clover Rain with Clover Icon)
-- Update: Activate toggle (bật/tắt), mưa clover thay vì lock icon

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LeoChoChoFakeHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = gui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 200)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.4
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 18)
corner.Parent = mainFrame

-- Rainbow viền
local stroke = Instance.new("UIStroke")
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Thickness = 4
stroke.Transparency = 0.1
stroke.Parent = mainFrame

local strokeGradient = Instance.new("UIGradient")
strokeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 127, 0)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(127, 0, 255))
})
strokeGradient.Rotation = 90
strokeGradient.Parent = stroke

spawn(function()
    while stroke.Parent do
        local t = tick() * 1.2
        strokeGradient.Offset = Vector2.new(math.sin(t) * 0.5, 0)
        wait(0.03)
    end
end)

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "LeoChoCho Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 38
title.Font = Enum.Font.FredokaOne
title.TextStrokeTransparency = 0.8
title.TextStrokeColor3 = Color3.fromRGB(0,0,0)
title.Parent = mainFrame

local titleGradient = Instance.new("UIGradient")
titleGradient.Color = strokeGradient.Color
titleGradient.Rotation = 45
titleGradient.Parent = title

spawn(function()
    while title.Parent do
        local t = tick() * 0.8
        titleGradient.Offset = Vector2.new((math.sin(t) + 1)/2, 0)
        wait(0.03)
    end
end)

-- x36 Luck
local luckyText = Instance.new("TextLabel")
luckyText.Size = UDim2.new(0.9, 0, 0, 45)
luckyText.Position = UDim2.new(0.05, 0, 0.3, 0)
luckyText.BackgroundTransparency = 0.6
luckyText.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
luckyText.Text = "x36 Luck 🍀"
luckyText.TextColor3 = Color3.fromRGB(180, 255, 180)
luckyText.TextSize = 32
luckyText.Font = Enum.Font.GothamBlack
luckyText.Parent = mainFrame

local luckyCorner = Instance.new("UICorner")
luckyCorner.CornerRadius = UDim.new(0, 12)
luckyCorner.Parent = luckyText

-- Nút Activate TOGGLE
local isActivated = false
local activateBtn = Instance.new("TextButton")
activateBtn.Size = UDim2.new(0.7, 0, 0, 55)
activateBtn.Position = UDim2.new(0.15, 0, 0.55, 0)
activateBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
activateBtn.Text = "ACTIVATE"
activateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
activateBtn.TextSize = 36
activateBtn.Font = Enum.Font.GothamBlack
activateBtn.Parent = mainFrame

local actCorner = Instance.new("UICorner")
actCorner.CornerRadius = UDim.new(0, 14)
actCorner.Parent = activateBtn

local actStroke = Instance.new("UIStroke")
actStroke.Thickness = 3
actStroke.Color = Color3.fromRGB(0, 255, 150)
actStroke.Parent = activateBtn

local actGradient = Instance.new("UIGradient")
actGradient.Color = titleGradient.Color
actGradient.Parent = activateBtn

spawn(function()
    while activateBtn.Parent do
        local t = tick() * 1.5
        actGradient.Offset = Vector2.new(math.sin(t) * 0.6, 0)
        wait(0.03)
    end
end)

activateBtn.MouseButton1Click:Connect(function()
    isActivated = not isActivated
    if isActivated then
        activateBtn.Text = "ACTIVATED"
        TweenService:Create(activateBtn, TweenInfo.new(0.4), {BackgroundColor3 = Color3.fromRGB(0, 220, 100)}):Play()
        TweenService:Create(actStroke, TweenInfo.new(0.4), {Thickness = 5, Color = Color3.fromRGB(0, 255, 0)}):Play()
    else
        activateBtn.Text = "ACTIVATE"
        TweenService:Create(activateBtn, TweenInfo.new(0.4), {BackgroundColor3 = Color3.fromRGB(40, 40, 60)}):Play()
        TweenService:Create(actStroke, TweenInfo.new(0.4), {Thickness = 3, Color = Color3.fromRGB(0, 255, 150)}):Play()
    end
end)

-- Mưa cỏ 4 lá (clover rain, icon là cỏ 4 lá)
local cloverFolder = Instance.new("Folder")
cloverFolder.Name = "CloverRain"
cloverFolder.Parent = mainFrame

local function createClover()
    local clover = Instance.new("ImageLabel")
    clover.Size = UDim2.new(0, 40, 0, 40)  -- to hơn tí cho nổi
    clover.Position = UDim2.new(math.random(), math.random(-60,60), 0, -60)
    clover.BackgroundTransparency = 1
    clover.Image = "rbxassetid://7072718362"  -- clover 4 lá chuẩn Roblox
    clover.ImageTransparency = 0.1 + math.random() * 0.4
    clover.ImageColor3 = Color3.fromHSV(math.random(), 0.8, 1)  -- random hue neon xanh-vàng-tím cho rainbow vibe
    clover.ZIndex = 5
    clover.Parent = cloverFolder
    
    local fallTween = TweenService:Create(clover, TweenInfo.new(5 + math.random()*5, Enum.EasingStyle.Linear), {
        Position = UDim2.new(clover.Position.X.Scale, clover.Position.X.Offset, 1.2, math.random(-150,150)),
        Rotation = math.random(-720,720),
        ImageTransparency = 1
    })
    fallTween:Play()
    fallTween.Completed:Connect(function() clover:Destroy() end)
end

spawn(function()
    while screenGui.Parent do
        createClover()  -- spawn dày hơn cho mưa clover đẹp
        wait(0.1 + math.random()*0.15)
    end
end)

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextSize = 26
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1,0)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

print("LeoChoCho Hub v3 loaded! Activate toggle + Clover Rain full 🍀🌈 Chạy thử nhấn Activate bật/tắt nha Phong!")
