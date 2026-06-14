-- Roblox FPS Boost & White Screen Toggle GUI
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- Temizlik: Eğer script zaten çalışıyorsa eskisini siler (Üst üste binmesin diye)
if CoreGui:FindFirstChild("FPS_Boost_System") then
    CoreGui.FPS_Boost_System:Destroy()
end

-- Ana Gui Seçenekleri
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FPS_Boost_System"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

-- Beyaz Perde (Arkayı Kapatan Frame)
local BlankFrame = Instance.new("Frame")
BlankFrame.Name = "BlankFrame"
BlankFrame.Size = UDim2.new(1, 0, 1, 0)
BlankFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Beyaz ekran (Gece için 0,0,0 yani siyah yapabilirsin)
BlankFrame.Visible = false
BlankFrame.ZIndex = 1
BlankFrame.Parent = ScreenGui

-- Bilgilendirme Yazısı
local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, 0, 0, 50)
InfoText.Position = UDim2.new(0, 0, 0.5, -25)
InfoText.BackgroundTransparency = 1
InfoText.TextColor3 = Color3.fromRGB(40, 40, 40)
InfoText.TextSize = 28
InfoText.Font = Enum.Font.GothamBold
InfoText.Text = "FPS BOOST MOD ON!\n(The game continues to run in the background)"
InfoText.Parent = BlankFrame

-- Açma / Kapatma Butonu (Toggle Button)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 140, 0, 40)
ToggleButton.Position = UDim2.new(0, 20, 0, 20) -- Ekranın sol üst köşesinde durur
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 144, 255) -- Güzel bir mavi tonu
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "FPS Boost: OFF"
ToggleButton.ZIndex = 10 -- Her zaman en üstte görünmesi için
ToggleButton.Parent = ScreenGui

-- Buton Köşelerini Yuvarlama (Daha modern görünüm)
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = ToggleButton

-- Durum Değişkeni
local isBoosted = false

-- Buton Fonksiyonu
ToggleButton.MouseButton1Click:Connect(function()
    isBoosted = not isBoosted
    
    if isBoosted then
        -- MODU AÇ
        BlankFrame.Visible = true
        ToggleButton.Text = "FPS Boost: ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(220, 53, 69) -- Kırmızı yapar
        
        -- 3D Çizimi Kapatır (İşlemci ve Ekran Kartını rahatlatır)
        RunService:Set3dRenderEfficiency(0)
    else
        -- MODU KAPAT
        BlankFrame.Visible = false
        ToggleButton.Text = "FPS Boost: OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 144, 255) -- Tekrar mavi olur
        
        -- 3D Çizimi Geri Açar (Oyun normale döner)
        RunService:Set3dRenderEfficiency(1)
    end
end)

-- Küçük bir Buton Animasyonu (Mouse üzerine gelince parlar)
ToggleButton.MouseEnter:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.15}):Play()
end)
ToggleButton.MouseLeave:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
end)
