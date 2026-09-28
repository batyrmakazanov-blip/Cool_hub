-- ============================================
-- c00lkidd menu v1.0
-- писал ночью, так что если что-то криво - извиняйте
-- ============================================

local decalID   = "8408806737"
local skyboxID  = "8408806737"
local soundID   = "515669032"

local plr = game.Players.LocalPlayer
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

-- сюда пихаю всё что включено, чтоб потом выключать
local active = {
    decals = {}, particles = nil, trail = nil, light = nil,
    sound = nil, guiOverlay = nil, spamThread = nil, shakeThread = nil,
    sky = nil, textLabels = {}, discoThread = nil, discoLights = nil,
    skinOn = false
}


-- ============ ИНТЕРФЕЙС ============

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "c00lkidd_menu"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999
screenGui.Parent = plr:WaitForChild("PlayerGui")

-- кнопка С
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 55, 0, 55)
toggleBtn.Position = UDim2.new(0, 15, 0.5, -27)
toggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
toggleBtn.Text = "C"
toggleBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
toggleBtn.TextScaled = true
toggleBtn.Font = Enum.Font.GothamBlack
toggleBtn.BorderSizePixel = 0
toggleBtn.ZIndex = 50
toggleBtn.Parent = screenGui
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)

local btnStroke = Instance.new("UIStroke", toggleBtn)
btnStroke.Color = Color3.fromRGB(255, 0, 0)
btnStroke.Thickness = 2
btnStroke.Transparency = 0.3

local btnGrad = Instance.new("UIGradient", toggleBtn)
btnGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
})
btnGrad.Rotation = 45

-- пульсация кнопки
task.spawn(function()
    while toggleBtn.Parent do
        for i = 0.15, 0.75, 0.06 do
            if not toggleBtn.Parent then break end
            btnStroke.Transparency = i
            task.wait(0.04)
        end
        for i = 0.75, 0.15, -0.06 do
            if not toggleBtn.Parent then break end
            btnStroke.Transparency = i
            task.wait(0.04)
        end
    end
end)

-- окно
local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 380, 0, 450)
menu.Position = UDim2.new(0.5, -190, 0.5, -225)
menu.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
menu.BorderSizePixel = 0
menu.Visible = false
menu.ZIndex = 50
menu.Parent = screenGui
Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 10)

local menuStroke = Instance.new("UIStroke", menu)
menuStroke.Color = Color3.fromRGB(255, 0, 0)
menuStroke.Thickness = 1.5
menuStroke.Transparency = 0.5

local menuGrad = Instance.new("UIGradient", menu)
menuGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 10, 15)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 15))
})
menuGrad.Rotation = 45

-- шапка
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 55)
topBar.BackgroundColor3 = Color3.fromRGB(25, 5, 10)
topBar.BorderSizePixel = 0
topBar.ZIndex = 51
topBar.Parent = menu
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 10)

-- костыль чтобы нижние углы шапки не скруглялись
local topFix = Instance.new("Frame")
topFix.Size = UDim2.new(1, 0, 0, 15)
topFix.Position = UDim2.new(0, 0, 1, -15)
topFix.BackgroundColor3 = Color3.fromRGB(25, 5, 10)
topFix.BorderSizePixel = 0
topFix.ZIndex = 51
topFix.Parent = topBar

local topGrad = Instance.new("UIGradient", topBar)
topGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(190, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 0, 0))
})
topGrad.Rotation = 90

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, -100, 1, 0)
logo.Position = UDim2.new(0, 15, 0, 0)
logo.BackgroundTransparency = 1
logo.Text = "C00LKIDD | V1.0"
logo.TextColor3 = Color3.fromRGB(255, 255, 255)
logo.TextXAlignment = Enum.TextXAlignment.Left
logo.Font = Enum.Font.GothamBlack
logo.TextSize = 19
logo.ZIndex = 52
logo.Parent = topBar
local ls = Instance.new("UIStroke", logo)
ls.Color = Color3.fromRGB(0, 0, 0)
ls.Thickness = 1.5

-- свернуть
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -70, 0, 12)
minBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 16
minBtn.BorderSizePixel = 0
minBtn.ZIndex = 52
minBtn.Parent = topBar
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

-- закрыть
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 12)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.BorderSizePixel = 0
closeBtn.ZIndex = 52
closeBtn.Parent = topBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

-- подпись над списком
local sectionTitle = Instance.new("TextLabel")
sectionTitle.Size = UDim2.new(1, -30, 0, 30)
sectionTitle.Position = UDim2.new(0, 15, 0, 60)
sectionTitle.BackgroundTransparency = 1
sectionTitle.Text = "► функции"
sectionTitle.TextColor3 = Color3.fromRGB(255, 60, 60)
sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
sectionTitle.Font = Enum.Font.GothamBold
sectionTitle.TextSize = 13
sectionTitle.ZIndex = 52
sectionTitle.Parent = menu

-- скролл
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -110)
scroll.Position = UDim2.new(0, 10, 0, 95)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ZIndex = 51
scroll.Parent = menu

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

-- переключатель
local function makeToggle(text, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -10, 0, 42)
    container.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    container.BorderSizePixel = 0
    container.ZIndex = 52
    container.Parent = scroll
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)
    
    local contStroke = Instance.new("UIStroke", container)
    contStroke.Color = Color3.fromRGB(60, 60, 80)
    contStroke.Thickness = 1
    contStroke.Transparency = 0.5
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(230, 230, 230)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 14
    label.ZIndex = 53
    label.Parent = container
    
    local toggleBg = Instance.new("Frame")
    toggleBg.Size = UDim2.new(0, 42, 0, 22)
    toggleBg.Position = UDim2.new(1, -55, 0.5, -11)
    toggleBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    toggleBg.BorderSizePixel = 0
    toggleBg.ZIndex = 53
    toggleBg.Parent = container
    Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1, 0)
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 2, 0.5, -9)
    knob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    knob.BorderSizePixel = 0
    knob.ZIndex = 54
    knob.Parent = toggleBg
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    
    local on = false
    local click = Instance.new("TextButton")
    click.Size = UDim2.new(1, 0, 1, 0)
    click.BackgroundTransparency = 1
    click.Text = ""
    click.ZIndex = 55
    click.Parent = container
    
    click.MouseButton1Click:Connect(function()
        on = not on
        if on then
            toggleBg.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            knob.Position = UDim2.new(1, -20, 0.5, -9)
            contStroke.Color = Color3.fromRGB(255, 0, 0)
        else
            toggleBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            knob.Position = UDim2.new(0, 2, 0.5, -9)
            contStroke.Color = Color3.fromRGB(60, 60, 80)
        end
        callback()
    end)
end

-- обычная кнопка
local function makeBtn(text, callback, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 42)
    btn.BackgroundColor3 = color or Color3.fromRGB(20, 20, 28)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    btn.ZIndex = 52
    btn.Parent = scroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(255, 0, 0)
    stroke.Thickness = 1
    stroke.Transparency = 0.6
    
    btn.MouseButton1Click:Connect(callback)
end

toggleBtn.MouseButton1Click:Connect(function() menu.Visible = not menu.Visible end)
closeBtn.MouseButton1Click:Connect(function() menu.Visible = false end)
minBtn.MouseButton1Click:Connect(function() menu.Visible = false end)


-- ============ ЭФФЕКТЫ ============

-- 1. текстуры на всё
local function toggleDecals()
    if #active.decals > 0 then
        for _, d in pairs(active.decals) do
            if d.Parent then d:Destroy() end
        end
        active.decals = {}
        return
    end
    local function spam(root)
        for _, v in pairs(root:GetChildren()) do
            if v:IsA("Decal") then
                v:Destroy()
            elseif v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Transparency = 0
                for _, face in pairs({"Front","Back","Right","Left","Top","Bottom"}) do
                    local d = Instance.new("Decal")
                    d.Texture = "rbxassetid://" .. decalID
                    d.Face = face
                    d.Parent = v
                    table.insert(active.decals, d)
                end
            end
            if #v:GetChildren() > 0 then spam(v) end
        end
    end
    spam(workspace)
end

-- 2. туман
local function toggleFog()
    if Lighting.FogEnd == 300 then
        Lighting.FogColor = Color3.fromRGB(192,192,192)
        Lighting.FogStart = 0
        Lighting.FogEnd = 100000
        Lighting.Ambient = Color3.fromRGB(128,128,128)
        Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
    else
        Lighting.FogColor = Color3.fromRGB(255,0,0)
        Lighting.FogStart = 0
        Lighting.FogEnd = 300
        Lighting.Ambient = Color3.fromRGB(255,0,0)
        Lighting.OutdoorAmbient = Color3.fromRGB(255,0,0)
    end
end

-- 3. скайбокс
local function toggleSky()
    if active.sky and active.sky.Parent then
        active.sky:Destroy()
        active.sky = nil
        return
    end
    local old = Lighting:FindFirstChildOfClass("Sky")
    if old then old:Destroy() end
    local sky = Instance.new("Sky")
    sky.Parent = Lighting
    for _, f in pairs({"SkyboxBk","SkyboxDn","SkyboxFt","SkyboxLf","SkyboxRt","SkyboxUp"}) do
        sky[f] = "rbxassetid://" .. skyboxID
    end
    active.sky = sky
end

-- 4. частицы
local function toggleParticles()
    local char = plr.Character
    if not char then return end
    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    if not torso then return end
    if active.particles and active.particles.Parent then
        active.particles:Destroy()
        active.particles = nil
        return
    end
    local e = Instance.new("ParticleEmitter")
    e.Parent = torso
    e.Texture = "rbxassetid://" .. decalID
    e.Rate = 20
    e.VelocitySpread = 20
    e.Lifetime = NumberRange.new(1, 2)
    active.particles = e
end

-- 5. звук
local function toggleSound()
    if active.sound and active.sound.Parent then
        active.sound:Destroy()
        active.sound = nil
        return
    end
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://" .. soundID
    s.Volume = 1
    s.Looped = true
    s.Parent = SoundService
    s:Play()
    active.sound = s
end

-- 6. красный экран
local function toggleOverlay()
    if active.guiOverlay and active.guiOverlay.Parent then
        active.guiOverlay:Destroy()
        active.guiOverlay = nil
        return
    end
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,0,1,0)
    f.BackgroundColor3 = Color3.fromRGB(255,0,0)
    f.BackgroundTransparency = 0.75
    f.BorderSizePixel = 0
    f.ZIndex = 5
    f.Parent = screenGui
    active.guiOverlay = f
end

-- 7. тряска
local function toggleShake()
    if active.shakeThread then
        task.cancel(active.shakeThread)
        active.shakeThread = nil
        return
    end
    active.shakeThread = task.spawn(function()
        while active.shakeThread do
            local char = plr.Character
            if char then
                for _, p in pairs(char:GetChildren()) do
                    if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                        local orig = p.CFrame
                        p.CFrame = orig * CFrame.new(
                            math.random(-10,10)/100,
                            math.random(-10,10)/100,
                            math.random(-10,10)/100)
                        task.wait()
                        if p.Parent then p.CFrame = orig end
                    end
                end
            end
            task.wait(0.05)
        end
    end)
end

-- 8. трейл
local function toggleTrail()
    local char = plr.Character
    if not char then return end
    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    if not torso then return end
    if active.trail and active.trail.Parent then
        active.trail:Destroy()
        active.trail = nil
        return
    end
    local a0 = Instance.new("Attachment", torso)
    a0.Position = Vector3.new(0,1,0)
    local a1 = Instance.new("Attachment", torso)
    a1.Position = Vector3.new(0,-1,0)
    local t = Instance.new("Trail", torso)
    t.Attachment0 = a0
    t.Attachment1 = a1
    t.Color = ColorSequence.new(Color3.fromRGB(255,0,0))
    t.Lifetime = 0.5
    t.Transparency = NumberSequence.new(0.3)
    active.trail = t
end

-- 9. спам текста
local function toggleSpam()
    if active.spamThread then
        task.cancel(active.spamThread)
        active.spamThread = nil
        for _, l in pairs(active.textLabels) do
            if l.Parent then l:Destroy() end
        end
        active.textLabels = {}
        return
    end
    active.spamThread = task.spawn(function()
        while active.spamThread do
            local l = Instance.new("TextLabel")
            l.Size = UDim2.new(0,250,0,40)
            l.Position = UDim2.new(math.random(),0,math.random(),0)
            l.BackgroundTransparency = 1
            l.Text = "team c00lkidd join today!"
            l.TextColor3 = Color3.fromRGB(255,0,0)
            l.TextStrokeTransparency = 0
            l.Font = Enum.Font.SourceSansBold
            l.TextScaled = true
            l.ZIndex = 10
            l.Parent = screenGui
            table.insert(active.textLabels, l)
            task.wait(0.3)
            if l.Parent then l:Destroy() end
        end
    end)
end

-- 10. красный свет
local function toggleLight()
    local char = plr.Character
    if not char then return end
    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    if not torso then return end
    if active.light and active.light.Parent then
        active.light:Destroy()
        active.light = nil
        return
    end
    local l = Instance.new("PointLight", torso)
    l.Color = Color3.fromRGB(255,0,0)
    l.Range = 30
    l.Brightness = 5
    active.light = l
end

-- 11. диско
local function toggleDisco()
    local char = plr.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    if not hum or not torso then return end
    
    if active.discoThread then
        task.cancel(active.discoThread)
        active.discoThread = nil
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        if active.discoLights then
            for _, l in pairs(active.discoLights) do
                if l.Parent then l:Destroy() end
            end
            active.discoLights = nil
        end
        return
    end
    
    active.discoLights = {}
    local dances = {"rbxassetid://507771019","rbxassetid://507776043","rbxassetid://507777826"}
    
    active.discoThread = task.spawn(function()
        while active.discoThread do
            local h = char:FindFirstChildOfClass("Humanoid")
            if h then
                for _, t in pairs(h:GetPlayingAnimationTracks()) do t:Stop() end
                local anim = Instance.new("Animation")
                anim.AnimationId = dances[math.random(1,#dances)]
                local track = h:FindFirstChildOfClass("Animator"):LoadAnimation(anim)
                track:Play()
                task.wait(3)
                track:Stop()
            else
                task.wait(0.5)
            end
        end
    end)
    
    local colors = {
        Color3.fromRGB(255,0,0), Color3.fromRGB(0,255,0), Color3.fromRGB(0,0,255),
        Color3.fromRGB(255,255,0), Color3.fromRGB(255,0,255), Color3.fromRGB(0,255,255)
    }
    task.spawn(function()
        while active.discoThread do
            for _, l in pairs(active.discoLights) do
                if l.Parent then l:Destroy() end
            end
            active.discoLights = {}
            for i = 1, 6 do
                local l = Instance.new("PointLight")
                l.Color = colors[math.random(1,#colors)]
                l.Range = 15
                l.Brightness = 3
                l.Parent = torso
                table.insert(active.discoLights, l)
                task.wait(0.15)
            end
            task.wait(0.1)
        end
    end)
end

-- 12. скин c00lkidd
local skinOriginal = {}
local function toggleSkin()
    local char = plr.Character
    if not char then return end
    if active.skinOn then
        active.skinOn = false
        for part, color in pairs(skinOriginal) do
            if part.Parent then
                part.Color = color
                part.Material = Enum.Material.Plastic
            end
        end
        skinOriginal = {}
        local head = char:FindFirstChild("Head")
        if head then
            for _, c in pairs(head:GetChildren()) do
                if c.Name == "C00lkiddFace" then c:Destroy()
                elseif c:IsA("Decal") then c.Transparency = 0 end
            end
        end
        local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
        if torso then
            for _, c in pairs(torso:GetChildren()) do
                if c.Name == "C00lkiddText" then c:Destroy() end
            end
        end
        return
    end
    active.skinOn = true
    skinOriginal = {}
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            skinOriginal[part] = part.Color
            part.Color = Color3.fromRGB(255,0,0)
            part.Material = Enum.Material.SmoothPlastic
        end
    end
    local head = char:FindFirstChild("Head")
    if head then
        for _, c in pairs(head:GetChildren()) do
            if c:IsA("Decal") then c.Transparency = 1 end
        end
        local f = Instance.new("Decal")
        f.Name = "C00lkiddFace"
        f.Texture = "rbxassetid://10066971660"
        f.Face = Enum.NormalId.Front
        f.Parent = head
    end
    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    if torso then
        local gui = Instance.new("SurfaceGui")
        gui.Name = "C00lkiddText"
        gui.Face = Enum.NormalId.Front
        gui.Parent = torso
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1,0,1,0)
        label.BackgroundTransparency = 1
        label.Text = "team c00lkidd\njoin today!"
        label.TextColor3 = Color3.fromRGB(0,0,0)
        label.Font = Enum.Font.SourceSansBold
        label.TextScaled = true
        label.Parent = gui
    end
end

-- 13. телепорт с выбором игрока
local tpGui = Instance.new("Frame")
tpGui.Name = "TeleportMenu"
tpGui.Size = UDim2.new(0, 240, 0, 350)
tpGui.Position = UDim2.new(0.5, -120, 0.5, -175)
tpGui.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
tpGui.BorderSizePixel = 0
tpGui.Visible = false
tpGui.ZIndex = 60
tpGui.Parent = screenGui
Instance.new("UICorner", tpGui).CornerRadius = UDim.new(0, 10)

local tpStroke = Instance.new("UIStroke", tpGui)
tpStroke.Color = Color3.fromRGB(255, 0, 0)
tpStroke.Thickness = 1.5
tpStroke.Transparency = 0.5

local tpTitle = Instance.new("TextLabel")
tpTitle.Size = UDim2.new(1, 0, 0, 45)
tpTitle.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
tpTitle.Text = "телепорт к игроку"
tpTitle.TextColor3 = Color3.fromRGB(255,255,255)
tpTitle.TextScaled = true
tpTitle.Font = Enum.Font.GothamBold
tpTitle.BorderSizePixel = 0
tpTitle.ZIndex = 61
tpTitle.Parent = tpGui
Instance.new("UICorner", tpTitle).CornerRadius = UDim.new(0, 10)

local tpClose = Instance.new("TextButton")
tpClose.Size = UDim2.new(0, 35, 0, 35)
tpClose.Position = UDim2.new(1, -40, 0, 5)
tpClose.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
tpClose.Text = "X"
tpClose.TextColor3 = Color3.fromRGB(255, 255, 255)
tpClose.TextScaled = true
tpClose.Font = Enum.Font.GothamBold
tpClose.BorderSizePixel = 0
tpClose.ZIndex = 62
tpClose.Parent = tpGui
Instance.new("UICorner", tpClose).CornerRadius = UDim.new(1, 0)

local tpScroll = Instance.new("ScrollingFrame")
tpScroll.Size = UDim2.new(1, -20, 1, -60)
tpScroll.Position = UDim2.new(0, 10, 0, 50)
tpScroll.BackgroundTransparency = 1
tpScroll.BorderSizePixel = 0
tpScroll.ScrollBarThickness = 5
tpScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
tpScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
tpScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
tpScroll.ZIndex = 61
tpScroll.Parent = tpGui
local tpl = Instance.new("UIListLayout")
tpl.Padding = UDim.new(0, 6)
tpl.SortOrder = Enum.SortOrder.LayoutOrder
tpl.Parent = tpScroll

local function refreshTPList()
    for _, c in pairs(tpScroll:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    for _, other in pairs(Players:GetPlayers()) do
        if other ~= plr then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 45)
            btn.BackgroundColor3 = Color3.fromRGB(25, 20, 30)
            btn.Text = other.DisplayName .. " (@" .. other.Name .. ")"
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.TextScaled = true
            btn.Font = Enum.Font.GothamMedium
            btn.BorderSizePixel = 0
            btn.ZIndex = 62
            btn.Parent = tpScroll
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            
            local s = Instance.new("UIStroke", btn)
            s.Color = Color3.fromRGB(255, 0, 0)
            s.Thickness = 1
            s.Transparency = 0.6
            
            btn.MouseButton1Click:Connect(function()
                local char = plr.Character
                if not char then return end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                local target = other.Character
                if target then
                    local tHrp = target:FindFirstChild("HumanoidRootPart")
                    if tHrp then
                        hrp.CFrame = tHrp.CFrame * CFrame.new(0, 0, 3)
                        tpGui.Visible = false
                    end
                end
            end)
        end
    end
end
tpClose.MouseButton1Click:Connect(function() tpGui.Visible = false end)
Players.PlayerAdded:Connect(function() task.wait(0.5) refreshTPList() end)
Players.PlayerRemoving:Connect(function() task.wait(0.5) refreshTPList() end)

-- 14. всё вкл/выкл
local function toggleAll()
    toggleDecals()
    toggleFog()
    toggleSky()
    toggleParticles()
    toggleSound()
    toggleOverlay()
    toggleShake()
    toggleTrail()
    toggleSpam()
    toggleLight()
    toggleDisco()
    toggleSkin()
end


-- ============ КНОПКИ ============

makeToggle("🟥 текстуры", toggleDecals)
makeToggle("🌫 туман", toggleFog)
makeToggle("🌌 скайбокс", toggleSky)
makeToggle("✨ частицы", toggleParticles)
makeToggle("🎵 спуки-звук", toggleSound)
makeToggle("🔴 красный экран", toggleOverlay)
makeToggle("📳 тряска", toggleShake)
makeToggle("💫 трейл", toggleTrail)
makeToggle("📝 спам текста", toggleSpam)
makeToggle("💡 красный свет", toggleLight)
makeToggle("🕺 диско", toggleDisco)

makeBtn("🔴  скин c00lkidd  🔴", toggleSkin, Color3.fromRGB(120, 0, 0))
makeBtn("👥  телепорт к игроку  👥", function()
    refreshTPList()
    tpGui.Visible = not tpGui.Visible
end, Color3.fromRGB(60, 0, 60))
makeBtn("⚡  включить всё  ⚡", toggleAll, Color3.fromRGB(180, 0, 0))

print("[c00lkidd menu] загружено, жми C слева")
