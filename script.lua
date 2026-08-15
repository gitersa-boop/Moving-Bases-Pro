if getgenv().FR then 
    getgenv().AF = false 
    getgenv().ES = false 
    getgenv().ME = false 
    getgenv().AK = false 
    task.wait(0.2) 
end

getgenv().FR = true
getgenv().AF = false
getgenv().ES = false
getgenv().ME = false
getgenv().FB = false
getgenv().AK = false
getgenv().SS = 30
getgenv().WS = 0

local P = game:GetService("Players")
local L = game:GetService("Lighting")
local I = game:GetService("VirtualInputManager")
local R = game:GetService("RunService")
local p = P.LocalPlayer
local ae, am, lc = {}, {}, nil

local function clr() 
    for _, o in pairs(game.Workspace:GetDescendants()) do 
        if o:IsA("BillboardGui") and o.Name == "SESP" then o:Destroy() end 
    end 
    ae, am = {}, {} 
end

local function tag(it, tx, c, s, o, t)
    local pt = it:IsA("BasePart") and it or (it:IsA("Model") and (it.PrimaryPart or it:FindFirstChildWhichIsA("BasePart") or it:FindFirstChild("HumanoidRootPart")))
    if not pt or t[pt] then return end
    local g = Instance.new("BillboardGui", pt)
    g.Name, g.AlwaysOnTop, g.Size, g.StudsOffset, g.Adornee = "SESP", true, UDim2.new(0, 150, 0, 30), o, pt
    local l = Instance.new("TextLabel", g)
    l.Size, l.BackgroundTransparency, l.TextSize, l.Font, l.Text, l.TextColor3, l.TextStrokeColor3, l.TextStrokeTransparency = UDim2.new(1, 0, 1, 0), 1, 13, Enum.Font.SourceSansBold, tx, c, s, 0.2
    t[pt] = g
end

local function lock() 
    if getgenv().FB then 
        L.Ambient = Color3.fromRGB(255, 255, 255)
        L.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        L.ColorShift_Top = Color3.fromRGB(255, 255, 255)
        L.ColorShift_Bottom = Color3.fromRGB(255, 255, 255)
        L.Brightness = 2
        L.ClockTime = 14 
    end 
end

local sg = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
sg.Name, sg.ResetOnSpawn = "SUI", false

local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 220, 0, 420)
f.Position = UDim2.new(0.05, 0, 0.25, 0)
f.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
f.Active = true
f.Draggable = true
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)

local ti = Instance.new("TextLabel", f)
ti.Size = UDim2.new(1, 0, 0, 35)
ti.Text = "Moving Bases Ultimate"
ti.TextColor3 = Color3.fromRGB(255, 255, 255)
ti.TextSize = 14
ti.Font = Enum.Font.SourceSansBold
ti.BackgroundTransparency = 1

local function btn(txt, y, tg, cb)
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(0, 180, 0, 32)
    b.Position = UDim2.new(0, 20, 0, y)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 13
    b.Font = Enum.Font.SourceSansBold
    b.BackgroundColor3 = tg and Color3.fromRGB(180, 50, 50) or Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(cb)
    return b
end

local b1, b2, b3, b4, b5, b6, b7, b8, b9
b1 = btn("Autofarm: OFF", 45, true, function() 
    getgenv().AF = not getgenv().AF 
    b1.Text = getgenv().AF and "Autofarm: ON" or "Autofarm: OFF" 
    b1.BackgroundColor3 = getgenv().AF and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(180, 50, 50) 
end)

b2 = btn("Instant Sell Resources 💰", 85, false, function()
    local r = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
    if not r then return end 
    local wf = getgenv().AF 
    getgenv().AF, b1.Text, b1.BackgroundColor3 = false, "Autofarm: OFF", Color3.fromRGB(180, 50, 50)
    local op = r.CFrame 
    r.CFrame = CFrame.new(Vector3.new(18.7, 5.0, 84.4)) 
    task.wait(0.2) 
    I:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    for _, o in pairs(game.Workspace:GetDescendants()) do 
        if o:IsA("ProximityPrompt") and (r.Position - o.Parent.Position).Magnitude < 15 then o:InputHoldBegin() end 
    end 
    task.wait(0.5) 
    I:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    for _, o in pairs(game.Workspace:GetDescendants()) do 
        if o:IsA("ProximityPrompt") then o:InputHoldEnd() end 
    end 
    task.wait(0.15) 
    r.CFrame = op 
    getgenv().AF = wf 
    if wf then b1.Text, b1.BackgroundColor3 = "Autofarm: ON", Color3.fromRGB(50, 150, 50) end
end)

b3 = btn("One-Tap Spin-Kill: OFF", 125, true, function() 
    getgenv().AK = not getgenv().AK 
    b3.Text = getgenv().AK and "One-Tap Spin-Kill: ON" or "One-Tap Spin-Kill: OFF" 
    b3.BackgroundColor3 = getgenv().AK and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(180, 50, 50) 
end)

b4 = btn("Item Names ESP: OFF", 165, true, function() 
    getgenv().ES = not getgenv().ES 
    b4.Text = getgenv().ES and "Item Names ESP: ON" or "Item Names ESP: OFF" 
    b4.BackgroundColor3 = getgenv().ES and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(180, 50, 50) 
    if not getgenv().ES then clr() end 
end)

b5 = btn("Universal Mob ESP: OFF", 205, true, function() 
    getgenv().ME = not getgenv().ME 
    b5.Text = getgenv().ME and "Universal Mob ESP: ON" or "Universal Mob ESP: OFF" 
    b5.BackgroundColor3 = getgenv().ME and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(180, 50, 50) 
    if not getgenv().ME then clr() end 
end)

b6 = btn("Teleport to Shop 🛒", 245, false, function() 
    local r = p.Character and p.Character:FindFirstChild("HumanoidRootPart") 
    if r then 
        getgenv().AF, b1.Text, b1.BackgroundColor3 = false, "Autofarm: OFF", Color3.fromRGB(180, 50, 50) 
        r.CFrame = CFrame.new(Vector3.new(46.8, 5.5, 127.4)) 
    end 
end)

b7 = btn("Spin Speed: Med (30)", 285, false, function() 
    if getgenv().SS == 15 then getgenv().SS, b7.Text = 30, "Spin Speed: Med (30)" 
    elseif getgenv().SS == 30 then getgenv().SS, b7.Text = 60, "Spin Speed: Fast (60)" 
    else getgenv().SS, b7.Text = 15, "Spin Speed: Slow (15)" end 
end)

b8 = btn("Speed Modifier: Normal", 325, false, function()
    if getgenv().WS == 0 then 
        getgenv().WS, b8.Text = 1.5, "Speed Modifier: Runner (x1.5)" 
    elseif getgenv().WS == 1.5 then 
        getgenv().WS, b8.Text = 3.5, "Speed Modifier: Flash (x3.5)" 
    else 
        getgenv().WS, b8.Text = 0, "Speed Modifier: Normal"
        pcall(function() 
            local char = p.Character 
            local root = char and char:FindFirstChild("HumanoidRootPart") 
            local hum = char and char:FindFirstChildWhichIsA("Humanoid") 
            if root then root.AssemblyLinearVelocity = Vector3.zero end 
            if hum then hum.WalkSpeed = 16 end 
        end)
    end
end)

b9 = btn("Fullbright: OFF", 365, true, function()
    getgenv().FB = not getgenv().FB 
    b9.Text = getgenv().FB and "Fullbright: ON" or "Fullbright: OFF" 
    b9.BackgroundColor3 = getgenv().FB and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(45, 45, 45)
    if getgenv().FB then 
        lock() 
        lc = L.Changed:Connect(lock) 
    else 
        if lc then lc:Disconnect() end 
        L.Ambient, L.OutdoorAmbient, L.ColorShift_Top, L.ColorShift_Bottom = Color3.fromRGB(0,0,0), Color3.fromRGB(128,128,128), Color3.fromRGB(0,0,0), Color3.fromRGB(0,0,0) 
    end
end)

task.spawn(function()
    while getgenv().FR do 
        R.RenderStepped:Wait()
        pcall(function()
            local char = p.Character 
            local root = char and char:FindFirstChild("HumanoidRootPart") 
            local hum = char and char:FindFirstChildWhichIsA("Humanoid")
            if root and hum and getgenv().WS > 0 and hum.MoveDirection.Magnitude > 0 then 
                root.CFrame = root.CFrame + (hum.MoveDirection * getgenv().WS) 
            end 
        end)
    end 
end)

task.spawn(function()
    while getgenv().FR do 
        task.wait(0.5)
        pcall(function()
            if getgenv().FB then 
                for _, o in pairs(L:GetChildren()) do 
                    if o:IsA("Atmosphere") or o:IsA("Sky") or o:IsA("Clouds") then o:Destroy() end 
                end 
            end
            if getgenv().ES then 
                for _, fn in pairs({"FleshDrops", "MiningDrops"}) do 
                    local fld = game.Workspace:FindFirstChild(fn)
                    if fld then 
                        for _, it in pairs(fld:GetChildren()) do 
                            local c = (fn == "FleshDrops") and Color3.fromRGB(255, 75, 75) or Color3.fromRGB(50, 200, 255) 
                            tag(it, it.Name, c, Color3.fromRGB(0, 0, 0), Vector3.new(0, 2, 0), ae) 
                        end 
                    end 
                end 
            end
            if getgenv().ME then 
                for _, o in pairs(game.Workspace:GetDescendants()) do 
                    if o:IsA("Humanoid") and o.Parent and o.Parent:IsA("Model") and o.Parent ~= p.Character and not P:GetPlayerFromCharacter(o.Parent) then 
                        tag(o.Parent, "⚠️ " .. o.Parent.Name, Color3.fromRGB(50, 255, 50), Color3.fromRGB(0, 50, 0), Vector3.new(0, 3, 0), am) 
                    end 
                end 
            end
        end)
    end 
end)

task.spawn(function()
    while getgenv().FR do 
        R.Heartbeat:Wait()
        if getgenv().AK then 
            pcall(function()
                local ch = p.Character 
                local r = ch and ch:FindFirstChild("HumanoidRootPart") 
                local tl = ch and ch:FindFirstChildWhichIsA("Tool")
                
                if r and tl then 
                    for _, o in pairs(game.Workspace:GetChildren()) do 
                        if o:IsA("Model") and o ~= ch and not P:GetPlayerFromCharacter(o) then 
                            local humanoid = o:FindFirstChildOfClass("Humanoid")
                            if humanoid and humanoid.Health > 0 then
                                local er = o:FindFirstChild("HumanoidRootPart") or o:FindFirstChildWhichIsA("BasePart")
                                if er and (r.Position - er.Position).Magnitude < 16 then 
                                    r.CFrame = CFrame.new(r.Position, Vector3.new(er.Position.X, r.Position.Y, er.Position.Z))
                                    tl:Activate()
                                    
                                    local rm = tl:FindFirstChildWhichIsA("RemoteEvent") 
                                        or tl:FindFirstChild("Hit") 
                                        or tl:FindFirstChild("Swing") 
                                        or game:GetService("ReplicatedStorage"):FindFirstChild("Damage")
                                        
                                    if rm and rm:IsA("RemoteEvent") then
                                        for i = 1, 8 do 
                                            rm:FireServer(o) 
                                        end
                                    end
                                    
                                    r.CFrame = r.CFrame * CFrame.Angles(0, math.rad(45), 0)
                                end
                            end
                        end
                    end 
                end
            end)
        end
    end
end)

task.spawn(function()
    while getgenv().FR do
        task.wait(0.2)
        if getgenv().AF then
            pcall(function()
                local root = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                if not root then return end
                
                local dropsContainers = {
                    game.Workspace:FindFirstChild("FleshDrops"),
                    game.Workspace:FindFirstChild("MiningDrops")
                }
                
                for _, fn in pairs(dropsContainers) do
                    if fn and getgenv().AF then
                        for _, it in pairs(fn:GetChildren()) do
                            if (it:IsA("BasePart") or it:IsA("Model")) and getgenv().AF then
                                local target = it:IsA("BasePart") and it or (it.PrimaryPart or it:FindFirstChildWhichIsA("BasePart"))
                                if target then
                                    root.CFrame = CFrame.new(target.Position + Vector3.new(0, 1.5, 0))
                                    for i = 1, 6 do
                                        if not getgenv().AF then break end
                                        root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(getgenv().SS or 0), 0)
                                        task.wait(0.02)
                                    end
                                    task.wait(0.05)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)
