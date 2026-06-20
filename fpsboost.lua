-- KAINATBOZAN V5: Universal Extreme Anti-Lag & FPS Booster
local Lighting = game:GetService("Lighting")
local Terrain = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- Clean up previous GUI if it exists
if CoreGui:FindFirstChild("Kainatbozan_FPS_V5") then
    CoreGui.Kainatbozan_FPS_V5:Destroy()
end

-- Main GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Kainatbozan_FPS_V5"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Create Main Toggle Button
local BoostButton = Instance.new("TextButton")
BoostButton.Size = UDim2.new(0, 200, 0, 45)
BoostButton.Position = UDim2.new(0, 20, 0, 80)
BoostButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Black background
BoostButton.TextColor3 = Color3.fromRGB(255, 0, 0) -- Kainatbozan Red
BoostButton.TextSize = 13
BoostButton.Font = Enum.Font.GothamBold
BoostButton.Text = "ULTRA BOOST: DISABLED"
BoostButton.ZIndex = 10
BoostButton.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = BoostButton

-- Universal Optimization Function
local function OptimizeObject(obj)
    if obj:IsA("BasePart") then
        obj.Material = Enum.Material.SmoothPlastic
        obj.Reflectance = 0
        obj.CastShadow = false
        
        -- Turns the map into solid matte gray (Saves massive GPU/CPU power)
        if not obj:IsDescendantOf(Players.LocalPlayer.Character) then
            obj.Color = Color3.fromRGB(100, 100, 100) 
        end
        
    elseif obj:IsA("Decal") or obj:IsA("Texture") then
        -- Removes all image textures and wallpapers
        obj:Destroy()
        
    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Sparkles") or obj:IsA("Fire") then
        -- Disables laggy particle effects from skills, guns, or fast movement
        obj.Enabled = false
        
    elseif obj:IsA("MeshPart") or obj:IsA("SpecialMesh") then
        -- Strips down complex 3D models into simple blocks to prevent CPU bottleneck
        if obj:IsA("MeshPart") and not obj:IsDescendantOf(Players.LocalPlayer.Character) then
            obj.MeshId = ""
            obj.TextureID = ""
        end
        
    elseif obj:IsA("PostEffect") or obj:IsA("Sky") or obj:IsA("Atmosphere") or obj:IsA("Clouds") then
        -- Destroys skyboxes, blurs, sun-rays, and heavy bloom filters
        obj:Destroy()
        
    elseif obj:IsA("Sound") then
        -- Mutes background audio and spammy effects to lower CPU cycles
        obj.Volume = 0
        
    elseif obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("ShirtGraphic") then
        -- Deletes other players' heavy 3D clothing and attachments
        if not obj:IsDescendantOf(Players.LocalPlayer.Character) then
            obj:Destroy()
        end
    end
end

-- Core Engine Booster
local function StartUniversalBoost()
    -- 1. Force Roblox Graphics Quality to Level 1
    local settings = settings()
    settings.Rendering.QualityLevel = Enum.QualityLevel.Level01
    
    -- 2. Disable Engine Physics Animations (Tree swaying, grass movement, etc.)
    settings.Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.DefaultAuto
    settings.Physics.ThrottleAdjustTime = 1
    
    -- 3. Black out the sky and disable shadow calculations
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 0
    Lighting.Ambient = Color3.fromRGB(120, 120, 120) -- Sets world lighting to standard gray
    
    -- 4. Clean up the existing map completely
    for _, obj in pairs(game:GetDescendants()) do
        OptimizeObject(obj)
    end
    
    -- 5. Automatically catch and optimize new laggy objects spawned by your script/farm
    game.DescendantAdded:Connect(function(obj)
        task.wait() -- Micro-delay to ensure stability
        OptimizeObject(obj)
    end)
    
    -- 6. Integrated Anti-AFK (Prevents 20-minute idle kicks during overnight farming)
    local VirtualUser = game:GetService("VirtualUser")
    Players.LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0,0))
    end)
end

-- Button Click Event Listener
local activated = false
BoostButton.MouseButton1Click:Connect(function()
    if not activated then
        activated = true
        BoostButton.Text = "ULTRA BOOST: ENABLED!"
        BoostButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0) -- Turns red when active
        BoostButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        StartUniversalBoost()
    end
end)

-- Visual Tweens for Hover Effects
BoostButton.MouseEnter:Connect(function()
    TweenService:Create(BoostButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
end)
BoostButton.MouseLeave:Connect(function()
    TweenService:Create(BoostButton, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
end)
