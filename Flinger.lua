-- Touch to Fling Script (Anti-Collision Bypass)
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

-- ميزة الـ NoClip (عشان تدخل جوه جسمه وتطيره)
local function ToggleNoClip()
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

-- تفعيل الدوران المدمر
local function ActivateTouchFling()
    local bg = Instance.new("BodyAngularVelocity", root)
    bg.Name = "DestructionForce"
    bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bg.P = math.huge
    bg.AngularVelocity = Vector3.new(0, 999999, 0) -- سرعة دوران مرعبة
    
    -- جعل القوة تتركز في أي شيء تلمسه
    char.Humanoid.Touched:Connect(function(hit)
        if hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Name ~= plr.Name then
            local targetRoot = hit.Parent:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                -- سر التقنية: دفع الخصم لبعيد جداً عند التلامس
                targetRoot.Velocity = Vector3.new(0, 10000, 0) + (root.CFrame.LookVector * 10000)
                print("Target Flung: " .. hit.Parent.Name)
            end
        end
    end)
end

-- تشغيل الخصائص
game:GetService("RunService").Stepped:Connect(ToggleNoClip) -- ن وكليب مستمر
ActivateTouchFling()
print("Touch to Fling is READY!")
