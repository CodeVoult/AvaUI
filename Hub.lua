local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/CodeVoult/AvaUI/refs/heads/main/src/Library.lua?v=" .. math.random(1,999999)))()

-- El título se mostrará sin HTML
local Window = Library:CreateWindow('Zyrox Hub VIP v1.2')  -- texto plano

-- Crear pestañas con iconos

-- ... etc.
-- ============================================================
--   TABS
-- ============================================================
local MainTab     = Window:CreateTab("Main", "rbxassetid://129659183898289")
local CombatTab   = Window:CreateTab("Combat", "rbxassetid://139144481094772")
local HitboxTab   = Window:CreateTab("Hitbox", "rbxassetid://92387641579827")
local VisualTab   = Window:CreateTab("Visual", "rbxassetid://128792349513965")
local FarmTab     = Window:CreateTab("Farm", "rbxassetid://139145941679098")
local AvatarTab   = Window:CreateTab("Avatar", "rbxassetid://109575005864749")
local AnimsTab    = Window:CreateTab("Animaciones", "rbxassetid://103266505441539")
local CameraTab   = Window:CreateTab("Camera", "rbxassetid://80826768886976")
local SettingsTab = Window:CreateTab("Settings", "rbxassetid://92718502822243")

-- ============================================================
--   COMBAT TAB
-- ============================================================
local SilentSec = CombatTab:CreateSection("Silent Aim")

SilentSec:AddToggle("Activar Silent Aim", false, function(v) end)

SilentSec:AddToggle("Solo con Armas", false, function(v) end)

SilentSec:AddToggle("Comprobar Paredes", false, function(v) end)

SilentSec:AddToggle("Ocultar Círculo de FOV", false, function(v) end)

SilentSec:AddDropdown("Punto Objetivo", {"Cabeza", "Torso", "Pies"}, 1, function(choice) end)

SilentSec:AddSlider("Radio de FOV", 30, 800, 120, function(v) end)

SilentSec:AddSlider("Disimulo / Smoothness", 10, 100, 50, function(v) end)

SilentSec:AddSlider("Fuerza Predicción", 0, 200, 100, function(v) end)

SilentSec:AddSlider("Rango de Distancia", 50, 1000, 500, function(v) end)

local AutoShootSec = CombatTab:CreateSection("Auto Shoot (En mantenimiento)")

AutoShootSec:AddToggle("Auto Shoot", false, function(v) end)

AutoShootSec:AddSlider("Rango de Disparo", 10, 1000, 250, function(v) end)

-- ============================================================
--   HITBOX TAB
-- ============================================================
local HitboxSec = HitboxTab:CreateSection("Hitbox Expander")

HitboxSec:AddToggle("Activar Hitbox", false, function(v) end)

HitboxSec:AddToggle("Ver Hitbox Visualmente", true, function(v) end)

HitboxSec:AddSlider("Tamaño de Hitbox", 2, 60, 10, function(v) end)

-- ============================================================
--   VISUAL TAB
-- ============================================================
local EspSec = VisualTab:CreateSection("Visualizadores ESP")

EspSec:AddToggle("Resaltado (Chasis Highlight)", false, function(v) end)

EspSec:AddToggle("Lineas", false, function(v) end)

EspSec:AddToggle("Cajas 2D (Boxes)", false, function(v) end)

EspSec:AddToggle("Esqueleto", false, function(v) end)

local ColorSec = VisualTab:CreateSection("Color del ESP")

ColorSec:AddColorPicker("Color de Resaltado", Color3.fromRGB(50, 255, 100), function(newColor) end)

-- ============================================================
--   FARM TAB
-- ============================================================
local FarmSec = FarmTab:CreateSection("Auto Farm Controller")

FarmSec:AddToggle("Habilitar Auto Farm", false, function(v) end)

-- ============================================================
--   AVATAR TAB
-- ============================================================
local AvatarSec = AvatarTab:CreateSection("Modificaciones Cosméticas")

AvatarSec:AddToggle("Headless Local", false, function(v) end)

AvatarSec:AddToggle("Korblox Pierna Izquierda", false, function(v) end)

-- ============================================================
--   ANIMACIONES TAB
-- ============================================================
local AnimsSec = AnimsTab:CreateSection("Animaciones By Zyrox")

-- ============================================================
--   CAMERA TAB
-- ============================================================
local FovSec = CameraTab:CreateSection("Field of View (FOV)")

FovSec:AddToggle("Habilitar Modificador FOV", false, function(v) end)

FovSec:AddSlider("Modificar FOV", 30, 120, 70, function(v) end)

local MoveSec = CameraTab:CreateSection("Desplazamiento")

MoveSec:AddToggle("Atravesar Paredes (Noclip)", false, function(v) end)

MoveSec:AddToggle("Aumentar Velocidad (Speed)", false, function(v) end)

MoveSec:AddSlider("Velocidad de Caminado", 16, 300, 200, function(v) end)

-- ============================================================
--   SETTINGS TAB
-- ============================================================
local SizeSec = SettingsTab:CreateSection("Dimensiones del Hub")

SizeSec:AddSlider("Ancho/Escala del Hub", 80, 150, 100, function(v)
    Window:SetScale(v / 100)
end)

local GhostSec = SettingsTab:CreateSection("Ajustes Visuales del Logo")

GhostSec:AddToggle("Modo Invisible (Esconder Logo)", false, function(v)
    Window:SetLogoVisible(not v)
end)

GhostSec:AddToggle("Bloquear Logo (Estatico)", false, function(v)
    Window:SetLogoLocked(v)
end)

local OptSec = SettingsTab:CreateSection("Optimizacion de Latencia")

OptSec:AddToggle("Optimizar FPS del Dispositivo", false, function(v) end)
