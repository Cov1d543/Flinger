-- Fling Executor Script (Anti-Collision Bypass)
local Library = {} -- ممكن نطورها لـ GUI كاملة لاحقاً

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

-- ميزة الـ Invisible Fling (عشان تطيرهم من غير ما يشوفوك)
local function InvisibleFling()
    local Trow = Instance.new("BodyAngularVelocity", root)
    Trow.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    Trow.P = math.huge
    Trow.AngularVelocity = Vector3.new(0, 999999, 0) -- سرعة دوران خرافية
    
    -- تخطي حماية منع التصادم عن طريق تغيير الـ Velocity باستمرار
    spawn(function()
        while Trow.Parent do
            root.Velocity = Vector3.new(999, 999, 999)
            task.wait(0.1)
            root.Velocity = Vector3.new(0, 0, 0)
            task.wait(0.1)
        end
    end)
end

-- إنشاء واجهة سريعة (GUI) تظهر للاكسكيوتر
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Active = true
Frame.Draggable = true

local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(1, -20, 0, 40)
Button.Position = UDim2.new(0, 10, 0, 10)
Button.Text = "ACTIVATE FLING"
Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Button.TextColor3 = Color3.new(1, 1, 1)

local KillButton = Instance.new("TextButton", Frame)
KillButton.Size = UDim2.new(1, -20, 0, 40)
KillButton.Position = UDim2.new(0, 10, 0, 55)
KillButton.Text = "FLY MODE"
KillButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
KillButton.TextColor3 = Color3.new(1, 1, 1)

-- تفعيل الفلينج عند الضغط
Button.MouseButton1Click:Connect(function()
    InvisibleFling()
    print("Fling Activated!")
end)

-- ميزة الطيران (Fly) اللي طلبتها
KillButton.MouseButton1Click:Connect(function()
    local bv = Instance.new("BodyVelocity", root)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Velocity = Vector3.new(0, 50, 0) -- هيطيرك لفوق
    task.wait(2)
    bv:Destroy()
end)
