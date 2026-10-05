-- ============================================
-- 卡密验证 + 飞行菜单
-- 卡密: SYDW
-- 仅限自建私人服务器测试
-- ============================================

local p = game.Players.LocalPlayer
local R = game:GetService("RunService")

local KEY = "SYDW"   -- 卡密，改这里

------------------------------------------------
-- 1. 卡密弹窗
------------------------------------------------
local kg = Instance.new("ScreenGui")
kg.Name = "KeyGui"
kg.ResetOnSpawn = false
kg.IgnoreGuiInset = true
kg.Parent = p:WaitForChild("PlayerGui")

local kf = Instance.new("Frame")
kf.Size = UDim2.new(0, 260, 0, 170)
kf.Position = UDim2.new(0.5, -130, 0.5, -85)
kf.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
kf.BorderSizePixel = 0
kf.Active = true
kf.Draggable = true
kf.Parent = kg
Instance.new("UICorner", kf).CornerRadius = UDim.new(0, 10)

local kt = Instance.new("TextLabel")
kt.Size = UDim2.new(1, 0, 0, 38)
kt.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
kt.BorderSizePixel = 0
kt.Text = "卡密验证"
kt.TextColor3 = Color3.fromRGB(255, 255, 255)
kt.TextSize = 17
kt.Font = Enum.Font.GothamBold
kt.Parent = kf
Instance.new("UICorner", kt).CornerRadius = UDim.new(0, 10)

local ki = Instance.new("TextBox")
ki.Size = UDim2.new(0.8, 0, 0, 38)
ki.Position = UDim2.new(0.1, 0, 0, 56)
ki.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ki.BorderSizePixel = 0
ki.PlaceholderText = "请输入卡密"
ki.Text = ""
ki.TextColor3 = Color3.fromRGB(255, 255, 255)
ki.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
ki.TextSize = 15
ki.Font = Enum.Font.Gotham
ki.ClearTextOnFocus = false
ki.Parent = kf
Instance.new("UICorner", ki).CornerRadius = UDim.new(0, 6)

local kb = Instance.new("TextButton")
kb.Size = UDim2.new(0.8, 0, 0, 38)
kb.Position = UDim2.new(0.1, 0, 0, 106)
kb.BackgroundColor3 = Color3.fromRGB(60, 120, 220)
kb.Text = "验证"
kb.TextColor3 = Color3.fromRGB(255, 255, 255)
kb.TextSize = 16
kb.Font = Enum.Font.GothamBold
kb.Parent = kf
Instance.new("UICorner", kb).CornerRadius = UDim.new(0, 6)

local km = Instance.new("TextLabel")
km.Size = UDim2.new(0.8, 0, 0, 18)
km.Position = UDim2.new(0.1, 0, 0, 148)
km.BackgroundTransparency = 1
km.Text = ""
km.TextColor3 = Color3.fromRGB(255, 100, 100)
km.TextSize = 12
km.Font = Enum.Font.Gotham
km.Parent = kf

------------------------------------------------
-- 2. 飞行系统
------------------------------------------------
local function buildFly()
    local fly, spd, lockH, lockV, nc = false, 50, false, false, false
    local bv, bg, ncc
    local md, ud = Vector3.new(0, 0, 0), 0

    local sg = Instance.new("ScreenGui")
    sg.Name = "FlyFloatGui"
    sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true
    sg.Parent = p:WaitForChild("PlayerGui")

    local ball = Instance.new("TextButton")
    ball.Size = UDim2.new(0, 56, 0, 56)
    ball.Position = UDim2.new(0.05, 0, 0.3, 0)
    ball.BackgroundColor3 = Color3.fromRGB(60, 120, 220)
    ball.Text = "✈"
    ball.TextColor3 = Color3.fromRGB(255, 255, 255)
    ball.TextSize = 26
    ball.Font = Enum.Font.GothamBold
    ball.Active = true
    ball.Draggable = true
    ball.Parent = sg
    Instance.new("UICorner", ball).CornerRadius = UDim.new(1, 0)

    local mf = Instance.new("Frame")
    mf.Size = UDim2.new(0, 230, 0, 360)
    mf.Position = UDim2.new(0.5, -115, 0.5, -180)
    mf.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mf.BorderSizePixel = 0
    mf.Active = true
    mf.Draggable = true
    mf.Visible = false
    mf.Parent = sg
    Instance.new("UICorner", mf).CornerRadius = UDim.new(0, 10)

    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, 0, 0, 34)
    t.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    t.BorderSizePixel = 0
    t.Text = "飞行菜单"
    t.TextColor3 = Color3.fromRGB(255, 255, 255)
    t.TextSize = 16
    t.Font = Enum.Font.GothamBold
    t.Parent = mf
    Instance.new("UICorner", t).CornerRadius = UDim.new(0, 10)

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 28)
    closeBtn.Position = UDim2.new(1, -34, 0, 3)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 15
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = t
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 30, 0, 28)
    minBtn.Position = UDim2.new(1, -68, 0, 3)
    minBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    minBtn.Text = "—"
    minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minBtn.TextSize = 15
    minBtn.Font = Enum.Font.GothamBold
    minBtn.Parent = t
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

    local tb = Instance.new("TextButton")
    tb.Size = UDim2.new(0.8, 0, 0, 38)
    tb.Position = UDim2.new(0.1, 0, 0, 44)
    tb.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    tb.Text = "开启飞行"
    tb.TextColor3 = Color3.fromRGB(255, 255, 255)
    tb.TextSize = 15
    tb.Font = Enum.Font.GothamBold
    tb.Parent = mf
    Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 8)

    local sl = Instance.new("TextLabel")
    sl.Size = UDim2.new(0.8, 0, 0, 20)
    sl.Position = UDim2.new(0.1, 0, 0, 88)
    sl.BackgroundTransparency = 1
    sl.Text = "速度: " .. spd
    sl.TextColor3 = Color3.fromRGB(200, 200, 200)
    sl.TextSize = 13
    sl.Font = Enum.Font.Gotham
    sl.TextXAlignment = Enum.TextXAlignment.Left
    sl.Parent = mf

    local nb = Instance.new("TextButton")
    nb.Size = UDim2.new(0.35, 0, 0, 32)
    nb.Position = UDim2.new(0.1, 0, 0, 112)
    nb.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    nb.Text = "-10"
    nb.TextColor3 = Color3.fromRGB(255, 255, 255)
    nb.TextSize = 14
    nb.Font = Enum.Font.Gotham
    nb.Parent = mf
    Instance.new("UICorner", nb).CornerRadius = UDim.new(0, 8)

    local pb = Instance.new("TextButton")
    pb.Size = UDim2.new(0.35, 0, 0, 32)
    pb.Position = UDim2.new(0.55, 0, 0, 112)
    pb.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    pb.Text = "+10"
    pb.TextColor3 = Color3.fromRGB(255, 255, 255)
    pb.TextSize = 14
    pb.Font = Enum.Font.Gotham
    pb.Parent = mf
    Instance.new("UICorner", pb).CornerRadius = UDim.new(0, 8)

    local hb = Instance.new("TextButton")
    hb.Size = UDim2.new(0.8, 0, 0, 32)
    hb.Position = UDim2.new(0.1, 0, 0, 152)
    hb.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    hb.Text = "水平锁定: 关"
    hb.TextColor3 = Color3.fromRGB(255, 255, 255)
    hb.TextSize = 13
    hb.Font = Enum.Font.Gotham
    hb.Parent = mf
    Instance.new("UICorner", hb).CornerRadius = UDim.new(0, 8)

    local vb = Instance.new("TextButton")
    vb.Size = UDim2.new(0.8, 0, 0, 32)
    vb.Position = UDim2.new(0.1, 0, 0, 188)
    vb.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    vb.Text = "垂直锁定: 关"
    vb.TextColor3 = Color3.fromRGB(255, 255, 255)
    vb.TextSize = 13
    vb.Font = Enum.Font.Gotham
    vb.Parent = mf
    Instance.new("UICorner", vb).CornerRadius = UDim.new(0, 8)

    local cb = Instance.new("TextButton")
    cb.Size = UDim2.new(0.8, 0, 0, 32)
    cb.Position = UDim2.new(0.1, 0, 0, 224)
    cb.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    cb.Text = "穿墙: 关"
    cb.TextColor3 = Color3.fromRGB(255, 255, 255)
    cb.TextSize = 13
    cb.Font = Enum.Font.Gotham
    cb.Parent = mf
    Instance.new("UICorner", cb).CornerRadius = UDim.new(0, 8)

    local tp = Instance.new("TextLabel")
    tp.Size = UDim2.new(0.8, 0, 0, 20)
    tp.Position = UDim2.new(0.1, 0, 0, 260)
    tp.BackgroundTransparency = 1
    tp.Text = "左下方向键 + 右下升降键"
    tp.TextColor3 = Color3.fromRGB(150, 150, 150)
    tp.TextSize = 11
    tp.Font = Enum.Font.Gotham
    tp.TextXAlignment = Enum.TextXAlignment.Left
    tp.Parent = mf

    local ac = {tb, sl, nb, pb, hb, vb, cb, tp}
    local minimized = false
    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        for _, o in ipairs(ac) do o.Visible = not minimized end
        mf.Size = minimized and UDim2.new(0, 230, 0, 34) or UDim2.new(0, 230, 0, 360)
        minBtn.Text = minimized and "+" or "—"
    end)
    ball.MouseButton1Click:Connect(function() mf.Visible = not mf.Visible end)
    closeBtn.MouseButton1Click:Connect(function() mf.Visible = false end)

    local dp = Instance.new("Frame")
    dp.Size = UDim2.new(0, 150, 0, 150)
    dp.Position = UDim2.new(0, 20, 1, -170)
    dp.BackgroundTransparency = 1
    dp.Visible = false
    dp.Parent = sg

    local function mdb(tx, ps, dr)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, 46, 0, 46)
        b.Position = ps
        b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        b.BackgroundTransparency = 0.2
        b.Text = tx
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.TextSize = 18
        b.Font = Enum.Font.GothamBold
        b.Parent = dp
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        b.MouseButton1Down:Connect(function() md = dr end)
        b.MouseButton1Up:Connect(function() md = Vector3.new(0, 0, 0) end)
        b.MouseLeave:Connect(function() md = Vector3.new(0, 0, 0) end)
    end
    mdb("↑", UDim2.new(0, 52, 0, 0), Vector3.new(0, 0, -1))
    mdb("↓", UDim2.new(0, 52, 0, 104), Vector3.new(0, 0, 1))
    mdb("←", UDim2.new(0, 0, 0, 52), Vector3.new(-1, 0, 0))
    mdb("→", UDim2.new(0, 104, 0, 52), Vector3.new(1, 0, 0))

    local uf = Instance.new("Frame")
    uf.Size = UDim2.new(0, 60, 0, 110)
    uf.Position = UDim2.new(1, -80, 1, -140)
    uf.BackgroundTransparency = 1
    uf.Visible = false
    uf.Parent = sg

    local function mud(tx, ps, vl)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 0, 50)
        b.Position = ps
        b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        b.BackgroundTransparency = 0.2
        b.Text = tx
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.TextSize = 20
        b.Font = Enum.Font.GothamBold
        b.Parent = uf
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        b.MouseButton1Down:Connect(function() ud = vl end)
        b.MouseButton1Up:Connect(function() ud = 0 end)
        b.MouseLeave:Connect(function() ud = 0 end)
    end
    mud("▲", UDim2.new(0, 0, 0, 0), 1)
    mud("▼", UDim2.new(0, 0, 0, 60), -1)

    local function SF()
        if fly then return end
        local c = p.Character
        local h = c and c:FindFirstChild("HumanoidRootPart")
        if not h then return end
        fly = true
        bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(5e5, 5e5, 5e5)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = h
        bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(5e5, 5e5, 5e5)
        bg.CFrame = h.CFrame
        bg.Parent = h
        tb.Text = "关闭飞行"
        tb.BackgroundColor3 = Color3.fromRGB(80, 160, 80)
        dp.Visible = true
        uf.Visible = true
    end

    local function XF()
        if not fly then return end
        fly = false
        md = Vector3.new(0, 0, 0)
        ud = 0
        if bv then bv:Destroy() bv = nil end
        if bg then bg:Destroy() bg = nil end
        tb.Text = "开启飞行"
        tb.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        dp.Visible = false
        uf.Visible = false
    end

    local function SN(s)
        nc = s
        if ncc then ncc:Disconnect() ncc = nil end
        if nc then
            ncc = R.Stepped:Connect(function()
                local c = p.Character
                if not c then return end
                for _, q in ipairs(c:GetDescendants()) do
                    if q:IsA("BasePart") and q.CanCollide then q.CanCollide = false end
                end
            end)
        end
        cb.Text = "穿墙: " .. (nc and "开" or "关")
        cb.BackgroundColor3 = nc and Color3.fromRGB(80, 160, 80) or Color3.fromRGB(60, 60, 60)
    end

    tb.MouseButton1Click:Connect(function() if fly then XF() else SF() end end)
    pb.MouseButton1Click:Connect(function() spd = math.min(spd + 10, 500) sl.Text = "速度: " .. spd end)
    nb.MouseButton1Click:Connect(function() spd = math.max(spd - 10, 10) sl.Text = "速度: " .. spd end)
    hb.MouseButton1Click:Connect(function()
        lockH = not lockH
        hb.Text = "水平锁定: " .. (lockH and "开" or "关")
        hb.BackgroundColor3 = lockH and Color3.fromRGB(80, 160, 80) or Color3.fromRGB(60, 60, 60)
    end)
    vb.MouseButton1Click:Connect(function()
        lockV = not lockV
        vb.Text = "垂直锁定: " .. (lockV and "开" or "关")
        vb.BackgroundColor3 = lockV and Color3.fromRGB(80, 160, 80) or Color3.fromRGB(60, 60, 60)
    end)
    cb.MouseButton1Click:Connect(function() SN(not nc) end)

    R.RenderStepped:Connect(function()
        if not fly or not bv or not bg then return end
        local c = p.Character
        local h = c and c:FindFirstChild("HumanoidRootPart")
        if not h then return end
        local cf = workspace.CurrentCamera.CFrame
        local fw = Vector3.new(cf.LookVector.X, 0, cf.LookVector.Z).Unit
        local rt = Vector3.new(cf.RightVector.X, 0, cf.RightVector.Z).Unit
        local dr = fw * (-md.Z) + rt * md.X
        dr = Vector3.new(dr.X, 0, dr.Z)
        if dr.Magnitude > 0 then dr = dr.Unit end
        dr = dr + Vector3.new(0, ud, 0)
        if lockH then dr = Vector3.new(dr.X, 0, dr.Z) end
        if lockV then dr = Vector3.new(0, dr.Y, 0) end
        if dr.Magnitude > 0 then dr = dr.Unit end
        bv.Velocity = dr * spd
        local lk = Vector3.new(cf.LookVector.X, 0, cf.LookVector.Z)
        if lk.Magnitude > 0 then bg.CFrame = CFrame.new(h.Position, h.Position + lk.Unit) end
    end)

    p.CharacterAdded:Connect(function() XF() end)
end

------------------------------------------------
-- 3. 验证逻辑
------------------------------------------------
local function tryUnlock()
    local k = ki.Text
    if k == "" then
        km.Text = "请输入卡密"
        return
    end
    if k == KEY then
        km.Text = "验证成功，进入..."
        km.TextColor3 = Color3.fromRGB(100, 255, 100)
        task.wait(0.6)
        kg:Destroy()
        buildFly()
    else
        km.Text = "卡密错误"
        km.TextColor3 = Color3.fromRGB(255, 100, 100)
        ki.Text = ""
    end
end

kb.MouseButton1Click:Connect(tryUnlock)
ki.FocusLost:Connect(function(enter)
    if enter then tryUnlock() end
end)