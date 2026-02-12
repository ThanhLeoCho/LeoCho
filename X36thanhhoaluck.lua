-- LeoChoCho Hub - GUI Fake x36 May Mắn (Full Tiếng Việt: Di chuyển + Thay đổi kích thước + Tab nhỏ + Âm thanh)
-- Phong ơi, bản tiếng Việt hoàn chỉnh nè! 🌈🍀🔊

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LeoChoChoFakeHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = gui

-- Âm thanh ding nhẹ
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://91127717"  -- ding notify Roblox
sound.Volume = 0.4
sound.Parent = screenGui

-- Hàm thông báo
local function showNotify(text)
    local notify = Instance.new("TextLabel")
    notify.Size = UDim2.new(0, 280, 0, 45)
    notify.Position = UDim2.new(0.5, -140, 0.08, 0)
    notify.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    notify.BackgroundTransparency = 0.5
    notify.Text = text
    notify.TextColor3 = Color3.fromRGB(180, 255, 180)
    notify.TextSize = 22
    notify.Font = Enum.Font.GothamBold
    notify.Parent = screenGui
    
    local nCorner = Instance.new("UICorner")
    nCorner.CornerRadius = UDim.new(0, 10)
    nCorner.Parent = notify
    
    TweenService:Create(notify, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -140, 0.05, 0)}):Play()
    wait(2.5)
    TweenService:Create(notify, TweenInfo.new(0.8), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
    wait(0.8)
    notify:Destroy()
end

-- Khung chính
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 340, 0, 180)
mainFrame.Position = UDim2.new(0.5, -170, 0.5, -90)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.45
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = mainFrame

-- Viền cầu vồng
local stroke = Instance.new("UIStroke")
stroke.Thickness = 3
stroke.Transparency = 0.1
stroke.Parent = mainFrame

local strokeGradient = Instance.new("UIGradient")
strokeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255,127,0)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255,255,0)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0,255,0)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0,0,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(127,0,255))
})
strokeGradient.Rotation = 90
strokeGradient.Parent = stroke

spawn(function()
    while true do
        local t = tick() * 1.3
        strokeGradient.Offset = Vector2.new(math.sin(t) * 0.5, 0)
        task.wait(0.03)
    end
end)

-- Thanh tiêu đề (kéo để di chuyển)
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundTransparency = 1
titleBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "LeoChoCho Hub"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextSize = 28
title.Font = Enum.Font.FredokaOne
title.Parent = titleBar

local titleGradient = Instance.new("UIGradient")
titleGradient.Color = strokeGradient.Color
titleGradient.Parent = title

spawn(function()
    while true do
        local t = tick() * 0.9
        titleGradient.Offset = Vector2.new((math.sin(t) + 1)/2, 0)
        task.wait(0.03)
    end
end)

-- Kéo di chuyển
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Thay đổi kích thước (kéo góc dưới phải)
local resizeHandle = Instance.new("Frame")
resizeHandle.Size = UDim2.new(0, 20, 0, 20)
resizeHandle.Position = UDim2.new(1, -20, 1, -20)
resizeHandle.BackgroundTransparency = 1
resizeHandle.Parent = mainFrame

local resizing = false
resizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = true
    end
end)

resizeHandle.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - (mainFrame.AbsolutePosition + Vector2.new(mainFrame.AbsoluteSize.X, mainFrame.AbsoluteSize.Y))
        local newSize = Vector2.new(
            math.clamp(mainFrame.AbsoluteSize.X + delta.X, 240, 500),
            math.clamp(mainFrame.AbsoluteSize.Y + delta.Y, 140, 350)
        )
        mainFrame.Size = UDim2.new(0, newSize.X, 0, newSize.Y)
    end
end)

-- x36 May Mắn
local luckyText = Instance.new("TextLabel")
luckyText.Size = UDim2.new(0.9, 0, 0, 40)
luckyText.Position = UDim2.new(0.05, 0, 0.25, 0)
luckyText.BackgroundTransparency = 0.6
luckyText.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
luckyText.Text = "x36 May Mắn 🍀"
luckyText.TextColor3 = Color3.fromRGB(200, 255, 200)
luckyText.TextSize = 30
luckyText.Font = Enum.Font.GothamBlack
luckyText.Parent = mainFrame

local luckyCorner = Instance.new("UICorner")
luckyCorner.CornerRadius = UDim.new(0, 10)
luckyCorner.Parent = luckyText

-- Nút BẬT / ĐÃ BẬT
local isActivated = false
local activateBtn = Instance.new("TextButton")
activateBtn.Size = UDim2.new(0.7, 0, 0, 50)
activateBtn.Position = UDim2.new(0.15, 0, 0.55, 0)
activateBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
activateBtn.Text = "BẬT"
activateBtn.TextColor3 = Color3.fromRGB(255,255,255)
activateBtn.TextSize = 32
activateBtn.Font = Enum.Font.GothamBlack
activateBtn.Parent = mainFrame

local actCorner = Instance.new("UICorner")
actCorner.CornerRadius = UDim.new(0, 12)
actCorner.Parent = activateBtn

local actStroke = Instance.new("UIStroke")
actStroke.Thickness = 3
actStroke.Color = Color3.fromRGB(0,255,150)
actStroke.Parent = activateBtn

local actGradient = Instance.new("UIGradient")
actGradient.Color = strokeGradient.Color
actGradient.Parent = activateBtn

spawn(function()
    while true do
        local t = tick() * 1.5
        actGradient.Offset = Vector2.new(math.sin(t) * 0.6, 0)
        task.wait(0.03)
    end
end)

activateBtn.MouseButton1Click:Connect(function()
    isActivated = not isActivated
    if isActivated then
        activateBtn.Text = "ĐÃ BẬT"
        TweenService:Create(activateBtn, TweenInfo.new(0.4), {BackgroundColor3 = Color3.fromRGB(0,220,100)}):Play()
        TweenService:Create(actStroke, TweenInfo.new(0.4), {Thickness = 5}):Play()
    else
        activateBtn.Text = "BẬT"
        TweenService:Create(activateBtn, TweenInfo.new(0.4), {BackgroundColor3 = Color3.fromRGB(40,40,60)}):Play()
        TweenService:Create(actStroke, TweenInfo.new(0.4), {Thickness = 3}):Play()
    end
    sound:Play()
end)

-- Mưa cỏ 4 lá
local cloverFolder = Instance.new("Folder")
cloverFolder.Parent = mainFrame

local function createClover()
    local clover = Instance.new("ImageLabel")
    clover.Size = UDim2.new(0, 35, 0, 35)
    clover.Position = UDim2.new(math.random(), math.random(-60,60), 0, -60)
    clover.BackgroundTransparency = 1
    clover.Image = "rbxassetid://7072718362"
    clover.ImageTransparency = 0.2 + math.random()*0.4
    clover.ImageColor3 = Color3.fromHSV(math.random(), 0.8, 1)
    clover.Parent = cloverFolder
    
    TweenService:Create(clover, TweenInfo.new(5 + math.random()*4, Enum.EasingStyle.Linear), {
        Position = UDim2.new(clover.Position.X.Scale, clover.Position.X.Offset, 1.2, math.random(-150,150)),
        Rotation = math.random(-720,720),
        ImageTransparency = 1
    }):Play():Completed:Connect(function() clover:Destroy() end)
end

spawn(function()
    while screenGui.Parent do
        createClover()
        task.wait(0.15)
    end
end)

-- Nút đóng & Tab nhỏ
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(220,60,60)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextSize = 22
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1,0)
closeCorner.Parent = closeBtn

local minimizeTab = Instance.new("TextButton")
minimizeTab.Size = UDim2.new(0, 60, 0, 30)
minimizeTab.Position = UDim2.new(0, 10, 1, -40)
minimizeTab.BackgroundColor3 = Color3.fromRGB(50,50,80)
minimizeTab.Text = "Leo 🍀"
minimizeTab.TextColor3 = Color3.fromRGB(200,255,200)
minimizeTab.TextSize = 16
minimizeTab.Font = Enum.Font.GothamBold
minimizeTab.Visible = false
minimizeTab.Parent = screenGui

local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 8)
tabCorner.Parent = minimizeTab

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    minimizeTab.Visible = true
    sound:Play()
end)

minimizeTab.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    minimizeTab.Visible = false
    sound:Play()
    showNotify("LeoChoCho Hub Đã Bật!")
end)

-- Bật đầu tiên
showNotify("LeoChoCho Hub Đã Bật!")
sound:Play()

print("LeoChoCho Hub tiếng Việt full loaded! Bật/Tắt, di chuyển, thay đổi kích thước, tab nhỏ, âm thanh 🍀🔊")
