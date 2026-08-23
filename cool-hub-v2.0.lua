-- COOL HUB v2.0 Mobile Optimization - Samsung Galaxy S21 5G
-- Оптимизировано под 2400x1080 (20:9)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Создание GUI с оптимизацией под мобильные
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CoolHubGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Функция для Draggable с поддержкой Touch
local function makeDraggable(obj, bounds)
    local UserInputService = game:GetService("UserInputService")
    local dragging = false
    local dragStart = nil
    local startPos = nil
    local gui = obj

    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = input.Position - dragStart
            local newX = startPos.X.Offset + delta.X
            local newY = startPos.Y.Offset + delta.Y
            
            -- Ограничения для экрана Samsung
            local screenSize = workspace.CurrentCamera.ViewportSize
            local buttonSize = gui.AbsoluteSize
            
            newX = math.clamp(newX, 0, screenSize.X - buttonSize.X)
            newY = math.clamp(newY, 0, screenSize.Y - buttonSize.Y)
            
            gui.Position = UDim2.new(0, newX, 0, newY)
        end
    end)
end

-- Создание основной рамки (оптимизировано для Samsung S21)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Size = UDim2.new(0.35, 0, 0.45, 0) -- 35% ширины, 45% высоты
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Тень для MainFrame
local MainShadow = Instance.new("Frame")
MainShadow.Name = "MainShadow"
MainShadow.AnchorPoint = Vector2.new(0.5, 0.5)
MainShadow.Size = UDim2.new(0.35, 10, 0.45, 10)
MainShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
MainShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainShadow.BackgroundTransparency = 0.5
MainShadow.BorderSizePixel = 0
MainShadow.ZIndex = 1
MainShadow.Parent = ScreenGui

MainFrame.ZIndex = 2

-- Закругление углов
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.04, 0)
UICorner.Parent = MainFrame

local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0.04, 0)
ShadowCorner.Parent = MainShadow

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Title.BorderSizePixel = 0
Title.Text = "COOL HUB"
Title.TextColor3 = Color3.fromRGB(255, 80, 80)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.Parent = MainFrame

-- Кнопка сворачивания
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.AnchorPoint = Vector2.new(1, 0)
MinimizeButton.Size = UDim2.new(0.15, 0, 0.12, 0)
MinimizeButton.Position = UDim2.new(0.98, 0, 0.015, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "❌"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextScaled = true
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = MainFrame

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0.3, 0)
MinimizeCorner.Parent = MinimizeButton

-- Кнопка CH (свернутое состояние)
local CHButton = Instance.new("TextButton")
CHButton.Name = "CHButton"
CHButton.Size = UDim2.new(0, 60, 0, 60) -- Фиксированный размер 60x60 пикселей
CHButton.Position = UDim2.new(0, 10, 0, 100)
CHButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
CHButton.BorderSizePixel = 0
CHButton.Text = "CH"
CHButton.TextColor3 = Color3.fromRGB(255, 80, 80)
CHButton.TextScaled = true
CHButton.Font = Enum.Font.GothamBlack
CHButton.Visible = false
CHButton.ZIndex = 10
CHButton.Parent = ScreenGui

local CHCorner = Instance.new("UICorner")
CHCorner.CornerRadius = UDim.new(1, 0)
CHCorner.Parent = CHButton

-- Делаем CH кнопку перетаскиваемой
makeDraggable(CHButton)

-- Функции сворачивания/разворачивания
local function minimizeMenu()
    local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    local tween = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 0, 0, 0)})
    local shadowTween = TweenService:Create(MainShadow, tweenInfo, {Size = UDim2.new(0, 0, 0, 0)})
    tween:Play()
    shadowTween:Play()
    wait(0.25)
    MainFrame.Visible = false
    MainShadow.Visible = false
    CHButton.Visible = true
end

local function maximizeMenu()
    CHButton.Visible = false
    MainFrame.Visible = true
    MainShadow.Visible = true
    local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    local tween = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0.35, 0, 0.45, 0)})
    local shadowTween = TweenService:Create(MainShadow, tweenInfo, {Size = UDim2.new(0.35, 10, 0.45, 10)})
    tween:Play()
    shadowTween:Play()
end

MinimizeButton.MouseButton1Click:Connect(minimizeMenu)
CHButton.MouseButton1Click:Connect(maximizeMenu)

-- Контейнер вкладок
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(1, 0, 0.1, 0)
TabContainer.Position = UDim2.new(0, 0, 0.15, 0)
TabContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

-- Вкладки
local TabButtons = {}
local tabs = {"Skybox", "Fly", "Speed"}

for i, tabName in ipairs(tabs) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabName
    TabButton.Size = UDim2.new(0.33, 0, 1, 0)
    TabButton.Position = UDim2.new((i - 1) * 0.33, 0, 0, 0)
    TabButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    TabButton.BorderSizePixel = 0
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextScaled = true
    TabButton.Font = Enum.Font.Gotham
    TabButton.Parent = TabContainer
    TabButtons[tabName] = TabButton
end

-- Контент вкладок
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 0.75, 0)
ContentFrame.Position = UDim2.new(0, 0, 0.25, 0)
ContentFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

-- Функция переключения вкладок
local function showTab(tabName)
    for _, child in ipairs(ContentFrame:GetChildren()) do
        child.Visible = false
    end
    for name, button in pairs(TabButtons) do
        if name == tabName then
            button.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            button.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
            button.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
    end
    if ContentFrame:FindFirstChild(tabName .. "Content") then
        ContentFrame[tabName .. "Content"].Visible = true
    end
end

-- ===== SKYBOX TAB =====
local SkyboxContent = Instance.new("Frame")
SkyboxContent.Name = "SkyboxContent"
SkyboxContent.Size = UDim2.new(1, 0, 1, 0)
SkyboxContent.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
SkyboxContent.BorderSizePixel = 0
SkyboxContent.Parent = ContentFrame

local SkyboxTitle = Instance.new("TextLabel")
SkyboxTitle.Size = UDim2.new(0.8, 0, 0.15, 0)
SkyboxTitle.Position = UDim2.new(0.1, 0, 0.05, 0)
SkyboxTitle.BackgroundTransparency = 1
SkyboxTitle.Text = "c00lkidd Skybox"
SkyboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SkyboxTitle.TextScaled = true
SkyboxTitle.Font = Enum.Font.GothamBold
SkyboxTitle.Parent = SkyboxContent

local SkyboxButton = Instance.new("TextButton")
SkyboxButton.Size = UDim2.new(0.8, 0, 0.2, 0)
SkyboxButton.Position = UDim2.new(0.1, 0, 0.25, 0)
SkyboxButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SkyboxButton.BorderSizePixel = 0
SkyboxButton.Text = "Включить Skybox"
SkyboxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SkyboxButton.TextScaled = true
SkyboxButton.Font = Enum.Font.Gotham
SkyboxButton.Parent = SkyboxContent

local SkyboxCorner = Instance.new("UICorner")
SkyboxCorner.CornerRadius = UDim.new(0.15, 0)
SkyboxCorner.Parent = SkyboxButton

local skyboxEnabled = false
SkyboxButton.MouseButton1Click:Connect(function()
    skyboxEnabled = not skyboxEnabled
    if skyboxEnabled then
        local sky = Instance.new("Sky")
        sky.Name = "c00lkiddSkybox"
        sky.SkyboxBk = "rbxassetid://169431710"
        sky.SkyboxDn = "rbxassetid://169431710"
        sky.SkyboxFt = "rbxassetid://169431710"
        sky.SkyboxLf = "rbxassetid://169431710"
        sky.SkyboxRt = "rbxassetid://169431710"
        sky.SkyboxUp = "rbxassetid://169431710"
        sky.Parent = game.Lighting
        SkyboxButton.Text = "Выключить Skybox"
        SkyboxButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
    else
        if game.Lighting:FindFirstChild("c00lkiddSkybox") then
            game.Lighting.c00lkiddSkybox:Destroy()
        end
        SkyboxButton.Text = "Включить Skybox"
        SkyboxButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    end
end)

-- ===== FLY TAB =====
local FlyContent = Instance.new("Frame")
FlyContent.Name = "FlyContent"
FlyContent.Size = UDim2.new(1, 0, 1, 0)
FlyContent.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
FlyContent.BorderSizePixel = 0
FlyContent.Parent = ContentFrame

local FlyTitle = Instance.new("TextLabel")
FlyTitle.Size = UDim2.new(0.8, 0, 0.15, 0)
FlyTitle.Position = UDim2.new(0.1, 0, 0.05, 0)
FlyTitle.BackgroundTransparency = 1
FlyTitle.Text = "Мобильный Fly"
FlyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyTitle.TextScaled = true
FlyTitle.Font = Enum.Font.GothamBold
FlyTitle.Parent = FlyContent

local FlyButton = Instance.new("TextButton")
FlyButton.Size = UDim2.new(0.8, 0, 0.15, 0)
FlyButton.Position = UDim2.new(0.1, 0, 0.25, 0)
FlyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
FlyButton.BorderSizePixel = 0
FlyButton.Text = "Включить Fly"
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.TextScaled = true
FlyButton.Font = Enum.Font.Gotham
FlyButton.Parent = FlyContent

local FlyCorner = Instance.new("UICorner")
FlyCorner.CornerRadius = UDim.new(0.15, 0)
FlyCorner.Parent = FlyButton

-- Управление Fly для мобильных
local UpButton = Instance.new("TextButton")
UpButton.Size = UDim2.new(0.25, 0, 0.12, 0)
UpButton.Position = UDim2.new(0.375, 0, 0.5, 0)
UpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
UpButton.BorderSizePixel = 0
UpButton.Text = "▲"
UpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UpButton.TextScaled = true
UpButton.Font = Enum.Font.GothamBold
UpButton.Parent = FlyContent

local DownButton = Instance.new("TextButton")
DownButton.Size = UDim2.new(0.25, 0, 0.12, 0)
DownButton.Position = UDim2.new(0.375, 0, 0.75, 0)
DownButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
DownButton.BorderSizePixel = 0
DownButton.Text = "▼"
DownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DownButton.TextScaled = true
DownButton.Font = Enum.Font.GothamBold
DownButton.Parent = FlyContent

local flyEnabled = false
local flySpeed = 20
local bodyVelocity = nil
local bodyGyro = nil
local flyConnection = nil

local function startFly()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end
    
    humanoid.PlatformStand = true
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9000
    bodyGyro.MaxTorque = Vector3.new(9000, 9000, 9000)
    bodyGyro.CFrame = rootPart.CFrame
    bodyGyro.Parent = rootPart
    
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(9000, 9000, 9000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = rootPart
    
    local movingUp = false
    local movingDown = false
    
    UpButton.MouseButton1Down:Connect(function()
        movingUp = true
    end)
    UpButton.MouseButton1Up:Connect(function()
        movingUp = false
    end)
    
    DownButton.MouseButton1Down:Connect(function()
        movingDown = true
    end)
    DownButton.MouseButton1Up:Connect(function()
        movingDown = false
    end)
    
    flyConnection = RunService.Heartbeat:Connect(function()
        if not flyEnabled then return end
        
        local camera = workspace.CurrentCamera
        local direction = Vector3.new(0, 0, 0)
        
        -- Автоматическое движение вперед
        direction = direction + camera.CFrame.LookVector
        
        if movingUp then
            direction = direction + Vector3.new(0, 1, 0)
        end
        if movingDown then
            direction = direction - Vector3.new(0, 1, 0)
        end
        
        if direction.Magnitude > 0 then
            direction = direction.Unit
            bodyVelocity.Velocity = direction * flySpeed
        else
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
        
        bodyGyro.CFrame = camera.CFrame
    end)
end

local function stopFly()
    flyEnabled = false
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoid then
            humanoid.PlatformStand = false
        end
        if rootPart then
            if bodyGyro then bodyGyro:Destroy() end
            if bodyVelocity then bodyVelocity:Destroy() end
        end
    end
    bodyGyro = nil
    bodyVelocity = nil
end

FlyButton.MouseButton1Click:Connect(function()
    if not flyEnabled then
        flyEnabled = true
        startFly()
        FlyButton.Text = "Выключить Fly"
        FlyButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
    else
        stopFly()
        FlyButton.Text = "Включить Fly"
        FlyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    end
end)

-- ===== SPEED TAB =====
local SpeedContent = Instance.new("Frame")
SpeedContent.Name = "SpeedContent"
SpeedContent.Size = UDim2.new(1, 0, 1, 0)
SpeedContent.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
SpeedContent.BorderSizePixel = 0
SpeedContent.Parent = ContentFrame

local SpeedTitle = Instance.new("TextLabel")
SpeedTitle.Size = UDim2.new(0.8, 0, 0.15, 0)
SpeedTitle.Position = UDim2.new(0.1, 0, 0.05, 0)
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.Text = "Speed Hack"
SpeedTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedTitle.TextScaled = true
SpeedTitle.Font = Enum.Font.GothamBold
SpeedTitle.Parent = SpeedContent

local SpeedButton = Instance.new("TextButton")
SpeedButton.Size = UDim2.new(0.8, 0, 0.2, 0)
SpeedButton.Position = UDim2.new(0.1, 0, 0.25, 0)
SpeedButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SpeedButton.BorderSizePixel = 0
SpeedButton.Text = "Включить Speed"
SpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedButton.TextScaled = true
SpeedButton.Font = Enum.Font.Gotham
SpeedButton.Parent = SpeedContent

local speedEnabled = false
SpeedButton.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            if speedEnabled then
                humanoid.WalkSpeed = 50
                SpeedButton.Text = "Выключить Speed"
                SpeedButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
            else
                humanoid.WalkSpeed = 16
                SpeedButton.Text = "Включить Speed"
                SpeedButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            end
        end
    end
end)

-- Подключение вкладок
TabButtons["Skybox"].MouseButton1Click:Connect(function() showTab("Skybox") end)
TabButtons["Fly"].MouseButton1Click:Connect(function() showTab("Fly") end)
TabButtons["Speed"].MouseButton1Click:Connect(function() showTab("Speed") end)

-- Показать первую вкладку
showTab("Skybox")

print("COOL HUB v2.0 Mobile успешно загружен!")
print("Оптимизировано для Samsung Galaxy S21 5G")