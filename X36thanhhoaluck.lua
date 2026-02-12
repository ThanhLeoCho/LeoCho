-- LeoChoCho Hub - Fake x36 Luck GUI v2 (Smaller, Draggable, Minimize to Tab, Music Icon)
-- Update: Thêm thông báo nhỏ dưới "x36luckthanhhoa thanhleocho Activate" khi bật GUI / Activate

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LeoChoChoFakeHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = gui

-- Hàm thông báo fade (thông báo chính giữa)
local function showNotify(text)
    local notify = Instance.new("TextLabel")
    notify.Size = UDim2.new(0, 400, 0, 60)
    notify.Position = UDim2.new(0.5, -200, 0.1, 0)
    notify.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    notify.BackgroundTransparency = 0.4
    notify.Text = text
    notify.TextColor3 = Color3.fromRGB(255, 215, 0)
    notify.TextSize = 28
    notify.Font = Enum.Font.GothamBlack
    notify.TextWrapped = true
    notify.Parent = screenGui
    
    local nCorner = Instance.new("UICorner")
    nCorner.CornerRadius = UDim.new(0, 12)
    nCorner.Parent = notify
    
    TweenService:Create(notify, TweenInfo.new(0.7), {Position = UDim2.new(0.5, -200, 0.05, 0)}):Play()
    wait(3)
    TweenService:Create(notify, TweenInfo.new(1), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
    wait(1)
    notify:Destroy()
end

-- Thông báo nhỏ dưới GUI (mới thêm)
local function showSmallActivate()
    local small = Instance.new("TextLabel")
    small.Size = UDim2.new(0, 300, 0, 30)
    small.Position = UDim2.new(0.5, -150, 0.85, 0)  -- dưới GUI
    small.BackgroundTransparency = 1
    small.Text = "x36luckthanhhoa thanhleocho Activate"
    small.TextColor3 = Color3.fromRGB(0, 255, 150)  -- xanh lá may mắn
    small.TextSize = 20
    small.Font = Enum.Font.GothamBold
    small.TextStrokeTransparency = 0.7
    small.TextStrokeColor3 = Color3.fromRGB(0,0,0)
    small.Parent = screenGui
    
    TweenService:Create(small, TweenInfo.new(1), {TextTransparency = 1}):Play()
    wait(1)
    small:Destroy()
end

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 180)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.4
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = mainFrame

-- Rainbow viền
local stroke = Instance.new("UIStroke")
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Thickness = 3
stroke.Transparency = 0.1
stroke.Color = Color3.fromRGB(255, 255, 255)
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

-- Title bar (draggable)
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundTransparency = 1
titleBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.8, 0, 1, 0)
title.Position = UDim2.new(0.1, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "LeoChoCho Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 28
title.Font = Enum.Font.FredokaOne
title.TextStrokeTransparency = 0.8
title.TextStrokeColor3 = Color3.fromRGB(0,0,0)
title.Parent = titleBar

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

-- Draggable bằng title bar
local dragging, dragInput, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- x36 Luck text
local luckyText = Instance.new("TextLabel")
luckyText.Size = UDim2.new(0.9, 0, 0, 40)
luckyText.Position = UDim2.new(0.05, 0, 0.25, 0)
luckyText.BackgroundTransparency = 0.6
luckyText.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
luckyText.Text = "x36 Luck 🍀"
luckyText.TextColor3 = Color3.fromRGB(200, 255, 200)
luckyText.TextSize = 30
luckyText.Font = Enum.Font.GothamBlack
luckyText.Parent = mainFrame

local luckyCorner = Instance.new("UICorner")
luckyCorner.CornerRadius = UDim.new(0, 10)
luckyCorner.Parent = luckyText

-- Music icon thay lock
local musicIcon = Instance.new("ImageLabel")
musicIcon.Size = UDim2.new(0, 30, 0, 30)
musicIcon.Position = UDim2.new(0.05, 0, 0.25, 5)
musicIcon.BackgroundTransparency = 1
musicIcon.Image = "rbxassetid://7072721035"
musicIcon.ImageColor3 = Color3.fromRGB(200, 100, 255)
musicIcon.Parent = mainFrame

-- Nút Activate
local activateBtn = Instance.new("TextButton")
activateBtn.Size = UDim2.new(0.7, 0, 0, 50)
activateBtn.Position = UDim2.new(0.15, 0, 0.55, 0)
activateBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
activateBtn.Text = "ACTIVATE"
activateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
activateBtn.TextSize = 32
activateBtn.Font = Enum.Font.GothamBlack
activateBtn.Parent = mainFrame

local actCorner = Instance.new("UICorner")
actCorner.CornerRadius = UDim.new(0, 12)
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

activateBtn.MouseEnter:Connect(function()
    TweenService:Create(activateBtn, TweenInfo.new(0.3), {Size = UDim2.new(0.75, 0, 0, 55)}):Play()
end)

activateBtn.MouseLeave:Connect(function()
    TweenService:Create(activateBtn, TweenInfo.new(0.3), {Size = UDim2.new(0.7, 0, 0, 50)}):Play()
end)

activateBtn.MouseButton1Click:Connect(function()
    activateBtn.Text = "ACTIVATED! ✨"
    TweenService:Create(activateBtn, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(0, 200, 100)}):Play()
    showSmallActivate()  -- hiện thông báo nhỏ dưới khi Activate
    wait(3)
    activateBtn.Text = "ACTIVATE"
    TweenService:Create(activateBtn, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(40, 40, 60)}):Play()
end)

-- Close button (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextSize = 24
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1,0)
closeCorner.Parent = closeBtn

-- Minimize tab nhỏ
local minimizeTab = Instance.new("TextButton")
minimizeTab.Size = UDim2.new(0, 80, 0, 40)
minimizeTab.Position = UDim2.new(0.05, 0, 0.9, 0)
minimizeTab.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
minimizeTab.Text = "LeoHub 🍀"
minimizeTab.TextColor3 = Color3.fromRGB(200, 255, 200)
minimizeTab.TextSize = 18
minimizeTab.Font = Enum.Font.GothamBold
minimizeTab.Visible = false
minimizeTab.Parent = screenGui

local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 10)
tabCorner.Parent = minimizeTab

minimizeTab.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    minimizeTab.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    minimizeTab.Visible = true
end)

-- Mưa clover
local cloverFolder = Instance.new("Folder")
cloverFolder.Name = "CloverRain"
cloverFolder.Parent = mainFrame

local function createClover()
    local clover = Instance.new("ImageLabel")
    clover.Size = UDim2.new(0, 25, 0, 25)
    clover.Position = UDim2.new(math.random(), math.random(-50,50), 0, -50)
    clover.BackgroundTransparency = 1
    clover.Image = "rbxassetid://7072718362"
    clover.ImageTransparency = 0.3 + math.random() * 0.4
    clover.ImageColor3 = Color3.fromRGB(100 + math.random(0,80), 220 + math.random(0,35), 100)
    clover.Parent = cloverFolder
    
    local fallTween = TweenService:Create(clover, TweenInfo.new(6 + math.random()*4, Enum.EasingStyle.Linear), {
        Position = UDim2.new(clover.Position.X.Scale, clover.Position.X.Offset, 1.2, math.random(-100,100)),
        Rotation = math.random(-720,720),
        ImageTransparency = 1
    })
    fallTween:Play()
    fallTween.Completed:Connect(function() clover:Destroy() end)
end

spawn(function()
    while screenGui.Parent do
        if math.random(1,4) == 1 then createClover() end
        wait(0.2 + math.random()*0.3)
    end
end)

-- Bật GUI + hiện thông báo chính + nhỏ dưới
showNotify("X36LUCK Đã được kích hoạt, thanh hoá mãi đỉnh")
showSmallActivate()  -- hiện nhỏ dưới ngay khi bật
print("LeoChoCho Hub v2 loaded! Có thông báo nhỏ dưới 'x36luckthanhhoa thanhleocho Activate' nha Phong 🌈🍀")
