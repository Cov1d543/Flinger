-- FIXED Touch to Fling (Bypass)
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

-- منع الشخصية من الوقوع أو الطيران عشوائياً (Anti-Self Fling)
local function Stabilize()
    local bg = Instance.new("BodyVelocity", root)
    bg.Name = "Stabilizer"
    bg.MaxForce = Vector3.new(0, math.huge, 0) -- بيثبتك على الأرض بس بيخليك تمشي عادي
    bg.Velocity = Vector3.new(0, 0, 0)
end

-- الدوران المدمر (للعالم الخارجي فقط)
local function StartFling()
    local bavg = Instance.new("BodyAngularVelocity", root)
    bavg.Name = "FlingForce"
    bavg.MaxTorque = Vector3.new(0, math.huge, 0) -- الدوران أفقي فقط عشان متتشقلبش
    bavg.P = math.huge
    bavg.AngularVelocity = Vector3.new(0, 99999, 0) -- سرعة دوران عالية
    
    -- "لمسة الموت"
    root.Touched:Connect(function(hit)
        if hit.Parent and hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Name ~= plr.Name then
            local targetRoot = hit.Parent:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                -- بنضرب الخصم بقوة خرافية لفوق ولبعيد
                targetRoot.Velocity = Vector3.new(0, 5000, 0) + (root.CFrame.LookVector * 5000)
            end
        end
    end)
end

-- تفعيل الـ NoClip عشان متخبطش في الأرض وتطير نفسك
game:GetService("RunService").Stepped:Connect(function()
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end)

Stabilize()
StartFling()
print("Veloce Fling Fixed - Ready!")
