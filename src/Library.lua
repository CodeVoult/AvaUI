--!nocheck
-- ============================================================
--  AVA UI  ·  Liquid Glass
--  Translucent surfaces, soft motion, and automatic category icons
-- ============================================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local GITHUB_RAW_BASE = "https://raw.githubusercontent.com/CodeVoult/ImperialUI-/main/elements/"

local function LoadElement(name)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(GITHUB_RAW_BASE .. name .. ".lua"))()
    end)
    if not success or not result then
        warn("[Library Error] No se pudo cargar el modulo " .. name .. ": " .. tostring(result))
    end
    return result
end

local Spring            = LoadElement("Spring")
local SpringAnimations  = LoadElement("SpringAnimations")
local TabsModule        = LoadElement("Tabs")
local ToggleModule      = LoadElement("Toggle")
local ButtonModule      = LoadElement("Button")
local SliderModule      = LoadElement("Slider")
local DropdownModule    = LoadElement("Dropdown")
local ColorPickerModule = LoadElement("ColorPicker")

local Library = {}
Library.__index = Library

if game:GetService("CoreGui"):FindFirstChild("DDOS_VENOM") then
    game:GetService("CoreGui").DDOS_VENOM:Destroy()
end

-- ================================================================== --
--  THEMES  (agrega los tuyos aqui, todo lo demas se adapta solo)
-- ================================================================== --
local ThemeList = {
    LiquidGlass = {
        bg = Color3.fromRGB(10, 18, 31),
        panel = Color3.fromRGB(22, 34, 53),
        panel2 = Color3.fromRGB(43, 61, 82),
        card = Color3.fromRGB(49, 68, 91),
        border = Color3.fromRGB(235, 245, 255),
        acc = Color3.fromRGB(139, 194, 255),
        acc2 = Color3.fromRGB(92, 153, 222),
        text = Color3.fromRGB(246, 250, 255),
        sub = Color3.fromRGB(176, 194, 215),
        sep = Color3.fromRGB(74, 94, 117),
        switchOff = Color3.fromRGB(61, 78, 99),
        red = Color3.fromRGB(255, 112, 125),
        green = Color3.fromRGB(111, 231, 176),
        grad = { Color3.fromRGB(206, 231, 255), Color3.fromRGB(115, 177, 239), Color3.fromRGB(83, 118, 170) },
    },
    Venom = { -- azul original, pulido
        bg = Color3.fromRGB(10, 18, 32),
        panel = Color3.fromRGB(6, 13, 26),
        panel2 = Color3.fromRGB(13, 24, 42),
        card = Color3.fromRGB(8, 15, 28),
        border = Color3.fromRGB(0, 166, 255),
        acc = Color3.fromRGB(0, 150, 255),
        acc2 = Color3.fromRGB(0, 80, 200),
        text = Color3.fromRGB(240, 245, 255),
        sub = Color3.fromRGB(160, 180, 205),
        sep = Color3.fromRGB(10, 20, 36),
        switchOff = Color3.fromRGB(12, 20, 34),
        red = Color3.fromRGB(255, 60, 60),
        green = Color3.fromRGB(50, 255, 100),
        grad = { Color3.fromRGB(0, 200, 255), Color3.fromRGB(0, 110, 240), Color3.fromRGB(5, 30, 80) },
    },
    Crimson = { -- como tus fotos rojas
        bg = Color3.fromRGB(16, 10, 12),
        panel = Color3.fromRGB(12, 7, 9),
        panel2 = Color3.fromRGB(24, 14, 17),
        card = Color3.fromRGB(14, 8, 10),
        border = Color3.fromRGB(255, 40, 40),
        acc = Color3.fromRGB(235, 20, 35),
        acc2 = Color3.fromRGB(140, 5, 15),
        text = Color3.fromRGB(255, 244, 244),
        sub = Color3.fromRGB(205, 165, 165),
        sep = Color3.fromRGB(30, 14, 16),
        switchOff = Color3.fromRGB(26, 14, 16),
        red = Color3.fromRGB(255, 60, 60),
        green = Color3.fromRGB(50, 255, 100),
        grad = { Color3.fromRGB(255, 80, 80), Color3.fromRGB(235, 20, 35), Color3.fromRGB(70, 0, 10) },
    },
    Royal = { -- morado estilo CHARM / Cat
        bg = Color3.fromRGB(15, 11, 26),
        panel = Color3.fromRGB(10, 7, 20),
        panel2 = Color3.fromRGB(21, 15, 38),
        card = Color3.fromRGB(12, 8, 22),
        border = Color3.fromRGB(150, 80, 255),
        acc = Color3.fromRGB(124, 58, 237),
        acc2 = Color3.fromRGB(70, 20, 160),
        text = Color3.fromRGB(245, 240, 255),
        sub = Color3.fromRGB(180, 165, 210),
        sep = Color3.fromRGB(20, 14, 34),
        switchOff = Color3.fromRGB(18, 12, 30),
        red = Color3.fromRGB(255, 60, 60),
        green = Color3.fromRGB(50, 255, 100),
        grad = { Color3.fromRGB(190, 120, 255), Color3.fromRGB(124, 58, 237), Color3.fromRGB(35, 8, 80) },
    },
    Emerald = {
        bg = Color3.fromRGB(9, 20, 16),
        panel = Color3.fromRGB(6, 14, 11),
        panel2 = Color3.fromRGB(12, 28, 22),
        card = Color3.fromRGB(8, 17, 13),
        border = Color3.fromRGB(0, 230, 160),
        acc = Color3.fromRGB(0, 200, 140),
        acc2 = Color3.fromRGB(0, 110, 80),
        text = Color3.fromRGB(240, 255, 250),
        sub = Color3.fromRGB(160, 200, 185),
        sep = Color3.fromRGB(10, 24, 19),
        switchOff = Color3.fromRGB(11, 24, 19),
        red = Color3.fromRGB(255, 60, 60),
        green = Color3.fromRGB(50, 255, 100),
        grad = { Color3.fromRGB(60, 255, 190), Color3.fromRGB(0, 200, 140), Color3.fromRGB(0, 45, 35) },
    },
}
Library.ThemeList = ThemeList

local T = {}
for k, v in pairs(ThemeList.LiquidGlass) do T[k] = v end
T.bgTrans = 0.5
T.glassTrans = 0.5
T.tabSize = 214
Library.T = T

-- Text glyphs are used for named categories; numeric/asset IDs remain supported.
local IconCatalog = {
    { terms = { "combat", "combate", "fight", "fighting", "battle", "attack", "melee", "sword", "lucha", "pelea" }, glyph = "⚔" },
    { terms = { "aim", "target", "aimbot", "silent", "objetivo", "apuntar", "mira" }, glyph = "◎" },
    { terms = { "visual", "visuals", "visuales", "esp", "render", "overlay" }, glyph = "◉" },
    { terms = { "movement", "move", "walk", "speed", "flight", "fly", "movimiento", "movilidad" }, glyph = "↗" },
    { terms = { "player", "players", "character", "avatar", "jugador", "personaje" }, glyph = "●" },
    { terms = { "world", "environment", "map", "sky", "mundo", "entorno", "mapa" }, glyph = "◈" },
    { terms = { "setting", "settings", "config", "configuration", "option", "options", "ajustes", "configuracion", "configuración", "opciones" }, glyph = "⚙" },
    { terms = { "utility", "utilities", "misc", "other", "utilidad", "herramientas", "otros" }, glyph = "⊞" },
    { terms = { "home", "main", "general", "inicio", "principal" }, glyph = "⌂" },
    { terms = { "security", "shield", "protect", "seguridad", "proteccion", "protección" }, glyph = "◇" },
}

Library.IconMap = IconCatalog

function Library.ResolveIcon(iconOrCategory, fallbackCategory)
    local value = tostring(iconOrCategory or "")
    local numericId = tonumber(value)
    if numericId then
        return { Kind = "Image", Value = "rbxassetid://" .. tostring(numericId) }
    end
    if string.match(value, "^rbxassetid://") then
        return { Kind = "Image", Value = value }
    end

    local search = string.lower(value .. " " .. tostring(fallbackCategory or ""))
    for _, entry in ipairs(IconCatalog) do
        for _, term in ipairs(entry.terms) do
            if string.find(search, term, 1, true) then
                return { Kind = "Text", Value = entry.glyph }
            end
        end
    end
    return { Kind = "Text", Value = "◈" }
end

function Library.GetIcon(category)
    return Library.ResolveIcon(category).Value
end

-- ================================================================== --
--  HELPERS
-- ================================================================== --
local function New(cls, props)
    local o = Instance.new(cls)
    for k, v in pairs(props or {}) do o[k] = v end
    return o
end
Library.New = New

local function Cor(obj, r) return New("UICorner", { CornerRadius = UDim.new(0, r or 8), Parent = obj }) end
Library.Cor = Cor

local function Stk(obj, col, th) return New("UIStroke", { Color = col or T.border, Thickness = th or 1.2, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = obj }) end
Library.Stk = Stk

local function List(obj, dir, pad) return New("UIListLayout", { FillDirection = dir or Enum.FillDirection.Vertical, Padding = UDim.new(0, pad or 8), SortOrder = Enum.SortOrder.LayoutOrder, Parent = obj }) end
Library.List = List

local function Pad(obj, t, b, l, r) New("UIPadding", { PaddingTop = UDim.new(0, t or 0), PaddingBottom = UDim.new(0, b or 0), PaddingLeft = UDim.new(0, l or 0), PaddingRight = UDim.new(0, r or 0), Parent = obj }) end
Library.Pad = Pad

local function Tween(obj, t, props, style, dir)
    local anim = TweenService:Create(obj, TweenInfo.new(t, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out), props)
    anim:Play()
    return anim
end
Library.Tween = Tween

local function Shadow(obj, transparency, expand)
    return New("ImageLabel", {
        Name = "Shadow", AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 3),
        Size = UDim2.new(1, expand or 24, 1, expand or 24),
        BackgroundTransparency = 1, Image = "rbxassetid://6014261993",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = transparency or 0.55,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(49, 49, 450, 450),
        ZIndex = 0, Parent = obj,
    })
end
Library.Shadow = Shadow

-- Gradiente de acento (bordes / strokes animados)
local function AccGradient(parent, rot)
    return New("UIGradient", {
        Rotation = rot or 225,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, T.grad[1]),
            ColorSequenceKeypoint.new(0.5, T.grad[2]),
            ColorSequenceKeypoint.new(1, T.grad[3]),
        }),
        Parent = parent,
    })
end
Library.AccGradient = AccGradient

-- Rotacion suave de un gradiente; se detiene solo si el parent muere
local function SpinGradient(grad, speed)
    task.spawn(function()
        local acc = 0
        while grad and grad.Parent do
            acc += (speed or 1.2)
            if acc >= 1 then
                grad.Rotation = (grad.Rotation + acc) % 360
                acc = 0
            end
            task.wait(0.05) -- ~20fps para la rotacion: invisible a ojo, barato
        end
    end)
end
Library.SpinGradient = SpinGradient

-- CHAMFER: esquinas "mochadas" como tus fotos.
-- Pinta 4 triangulos (rotados 45°) del color de la tarjeta detras.
-- IMPORTANTE: el objeto debe estar sobre un fondo opaco del color `coverColor`.
local function Chamfer(obj, cut, coverColor, z)
    cut = cut or 10
    z = z or ((obj.ZIndex or 1) + 1)
    local covers = {}
    local corners = { {0,0,-1,-1}, {1,0,1,-1}, {0,1,-1,1}, {1,1,1,1} }
    for _, c in ipairs(corners) do
        local x, y, sx, sy = c[1], c[2], c[3], c[4]
        local tri = New("Frame", {
            AnchorPoint = Vector2.new(x, y),
            Position = UDim2.new(x, sx * cut * 0.55, y, sy * cut * 0.55),
            Size = UDim2.new(0, cut * 1.7, 0, cut * 1.7),
            Rotation = 45,
            BackgroundColor3 = coverColor,
            BorderSizePixel = 0,
            ZIndex = z,
            Parent = obj,
        })
        table.insert(covers, tri)
    end
    obj.ClipsDescendants = false
    return covers
end
Library.Chamfer = Chamfer

-- Registry para cambio de theme en vivo
function Library:Reg(obj, prop, role)
    if not self._themed then self._themed = {} end
    table.insert(self._themed, { obj = obj, prop = prop, role = role })
    return obj
end

function Library:SetTheme(name)
    local th = ThemeList[name]
    if not th then warn("[Library] Theme inexistente: " .. tostring(name)) return end
    self.ThemeName = name
    for k, v in pairs(th) do self.T[k] = v end
    for _, e in ipairs(self._themed or {}) do
        if e.obj and e.obj.Parent then
            if e.role == "@grad" then
                e.obj.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, th.grad[1]),
                    ColorSequenceKeypoint.new(0.5, th.grad[2]),
                    ColorSequenceKeypoint.new(1, th.grad[3]),
                })
            else
                local target = th[e.role]
                if target then
                    pcall(function() Tween(e.obj, 0.35, { [e.prop] = target }) end)
                end
            end
        end
    end
end

-- ================================================================== --
--  VENTANA
-- ================================================================== --
function Library:CreateWindow(hubTitle, themeName, blurIntensity)
    local self = setmetatable({}, Library)
    self.LogoLocked = false
    self.Pages = {}
    self.Tabs = {}
    self.ActivePage = nil
    self._themed = {}
    self.T = T
    self.ThemeName = "LiquidGlass"
    for k, v in pairs(ThemeList.LiquidGlass) do T[k] = v end
    T.bgTrans = 0.5
    T.glassTrans = 0.5
    T.tabSize = 214
    if themeName and ThemeList[themeName] then
        for k, v in pairs(ThemeList[themeName]) do T[k] = v end
        self.ThemeName = themeName
    end

    local cleanTitle = hubTitle and string.gsub(tostring(hubTitle), "<[^>]*>", "") or "AVA UI"
    self.WindowTitle = cleanTitle

    local guiParent = gethui and gethui() or game:GetService("CoreGui")
    local previousGui = guiParent:FindFirstChild("AVA_LIQUID_GLASS")
    if previousGui then previousGui:Destroy() end

    self.GUI = New("ScreenGui", {
        Name = "AVA_LIQUID_GLASS",
        ResetOnSpawn = false,
        DisplayOrder = 999999999,
        IgnoreGuiInset = true,
        Parent = guiParent,
    })

    local previousBlur = Lighting:FindFirstChild("AVA_UI_Blur")
    if previousBlur then previousBlur:Destroy() end
    self.BlurIntensity = math.clamp(tonumber(blurIntensity) or 28, 0, 56)
    self.Blur = New("BlurEffect", {
        Name = "AVA_UI_Blur",
        Size = 0,
        Parent = Lighting,
    })
    self.OnWindowOpened = function()
        if self.Blur and self.Blur.Parent then
            Tween(self.Blur, 0.36, { Size = self.BlurIntensity })
        end
    end
    self.OnWindowClosed = function()
        if self.Blur and self.Blur.Parent then
            Tween(self.Blur, 0.3, { Size = 0 })
        end
    end
    self.GUI.Destroying:Connect(function()
        if self.Blur and self.Blur.Parent then self.Blur:Destroy() end
    end)

    -- Sonido de clic (una sola conexion por boton)
    local clickSound = Instance.new("Sound")
    clickSound.SoundId = "rbxassetid://4590657391"
    clickSound.Volume = 0.4
    clickSound.Parent = self.GUI
    local hooked = setmetatable({}, { __mode = "k" })
    self.GUI.DescendantAdded:Connect(function(obj)
        if (obj:IsA("TextButton") or obj:IsA("ImageButton")) and not hooked[obj] then
            hooked[obj] = true
            obj.MouseButton1Click:Connect(function()
                if not clickSound.Playing then clickSound:Play() end
            end)
        end
    end)

    self.NotifLayer = New("Frame", {
        Name = "Notifs",
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, -16, 1, -16),
        Size = UDim2.new(0, 260, 0, 10),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        ZIndex = 999999995,
        Parent = self.GUI,
    })
    List(self.NotifLayer, Enum.FillDirection.Vertical, 8)

    -- Floating glass launcher
    self.FloatIcon = New("TextButton", {
        Name = "FloatIcon",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(0, 156, 0, 48),
        Position = UDim2.new(0.5, 0, 0, 60),
        BackgroundColor3 = T.panel2,
        BackgroundTransparency = 0.18,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 999999990,
        Parent = self.GUI,
    })
    Cor(self.FloatIcon, 24)
    local floatStroke = Stk(self.FloatIcon, T.border, 1)
    floatStroke.Transparency = 0.72
    self:Reg(floatStroke, "Color", "border")

    local floatMark = New("Frame", {
        Position = UDim2.new(0, 9, 0.5, -15),
        Size = UDim2.new(0, 30, 0, 30),
        BackgroundColor3 = T.acc,
        BackgroundTransparency = 0.14,
        BorderSizePixel = 0,
        ZIndex = 999999991,
        Parent = self.FloatIcon,
    })
    Cor(floatMark, 15)
    self:Reg(floatMark, "BackgroundColor3", "acc")
    New("TextLabel", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Text = "A",
        TextColor3 = T.text,
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        ZIndex = 999999992,
        Parent = floatMark,
    })

    New("TextLabel", {
        Position = UDim2.new(0, 47, 0, 0),
        Size = UDim2.new(1, -52, 1, 0),
        BackgroundTransparency = 1,
        Text = "AVA UI  ·  OPEN",
        TextColor3 = T.text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 999999992,
        Parent = self.FloatIcon,
    })

    self.closeTextLabel = New("TextLabel", {
        Name = "CloseTextAnim",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(0, 156, 0, 48),
        BackgroundTransparency = 1,
        Text = "AVA UI  ·  OPEN",
        TextColor3 = T.text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 12,
        TextTransparency = 1,
        Visible = false,
        ZIndex = 999999998,
        Parent = self.GUI,
    })

    -- Ventana principal
    self.WinMain = New("Frame", {
        Name = "Window",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 150, 0, 44),
        BackgroundColor3 = T.bg,
        BackgroundTransparency = T.glassTrans,
        Visible = false,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = self.GUI,
    })
    self.WinCorner = Cor(self.WinMain, 22)
    self.WinScale = New("UIScale", { Scale = 1, Parent = self.WinMain })

    local winInner = New("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = T.panel,
        BackgroundTransparency = T.glassTrans,
        ClipsDescendants = true,
        Parent = self.WinMain,
    })
    Cor(winInner, 32)

    local bgGradient = New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, T.panel2),
            ColorSequenceKeypoint.new(1, T.panel),
        }),
        Rotation = 45,
        Parent = winInner,
    })
    self:Reg(winInner, "BackgroundColor3", "panel")

    self.borderStroke = New("UIStroke", {
        Name = "BorderStroke",
        Thickness = 1.2,
        Color = T.border,
        Transparency = 0.68,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = self.WinMain,
    })
    self:Reg(self.borderStroke, "Color", "border")

    self.ContentGroup = New("CanvasGroup", {
        Name = "ContentGroup",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        GroupTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Visible = false,
        ZIndex = 4,
        Parent = winInner,
    })

    self.titleBar = New("Frame", {
        Size = UDim2.new(1, 0, 0, 52),
        BackgroundTransparency = 1,
        ZIndex = 5,
        Parent = self.ContentGroup,
    })

    local brandBadge = New("Frame", {
        Position = UDim2.new(0, 12, 0, 10),
        Size = UDim2.new(0, 31, 0, 31),
        BackgroundColor3 = T.panel2,
        BackgroundTransparency = 0.24,
        BorderSizePixel = 0,
        ZIndex = 6,
        Parent = self.titleBar,
    })
    Cor(brandBadge, 12)
    local brandStroke = Stk(brandBadge, T.border, 1)
    brandStroke.Transparency = 0.82
    self:Reg(brandStroke, "Color", "border")
    local brandLetter = New("TextLabel", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Text = "A",
        TextColor3 = T.acc,
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        ZIndex = 7,
        Parent = brandBadge,
    })
    self:Reg(brandLetter, "TextColor3", "acc")

    self.TitleLabel = New("TextLabel", {
        Size = UDim2.new(1, -70, 0, 22),
        Position = UDim2.new(0, 52, 0, 5),
        BackgroundTransparency = 1,
        Text = cleanTitle,
        TextColor3 = T.text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 17,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 7,
        Parent = self.titleBar,
    })
    self:Reg(self.TitleLabel, "TextColor3", "text")

    local titleCaption = New("TextLabel", {
        Size = UDim2.new(1, -70, 0, 14),
        Position = UDim2.new(0, 53, 0, 27),
        BackgroundTransparency = 1,
        Text = "LIQUID GLASS  ·  AVA",
        TextColor3 = T.sub,
        Font = Enum.Font.GothamMedium,
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 7,
        Parent = self.titleBar,
    })
    self:Reg(titleCaption, "TextColor3", "sub")

    -- Sidebar
    self.Sidebar = New("ScrollingFrame", {
        Position = UDim2.new(0, 8, 0, 52),
        Size = UDim2.new(0, T.tabSize - 30, 1, -62),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = T.acc,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ZIndex = 3,
        Parent = self.ContentGroup,
    })
    self:Reg(self.Sidebar, "ScrollBarImageColor3", "acc")
    List(self.Sidebar, Enum.FillDirection.Vertical, 6)
    Pad(self.Sidebar, 4, 12, 2, 6)

    self.ContentArea = New("Frame", {
        Position = UDim2.new(0, T.tabSize - 20, 0, 52),
        Size = UDim2.new(1, -T.tabSize + 14, 1, -58),
        BackgroundColor3 = T.panel,
        BackgroundTransparency = 0.58,
        ClipsDescendants = true,
        ZIndex = 3,
        Parent = self.ContentGroup,
    })
    Cor(self.ContentArea, 14)
    local contentStroke = Stk(self.ContentArea, T.border, 1)
    contentStroke.Transparency = 0.9
    self:Reg(contentStroke, "Color", "border")
    self:Reg(self.ContentArea, "BackgroundColor3", "panel")

    -- Animaciones (tu spring, intacto)
    self.Animations = SpringAnimations.Setup(self, {
        targetWidth = 700,
        targetHeight = 440,
    }, Spring)

    function self:Open() self.Animations.Open() end
    function self:Close() self.Animations.Close() end
    function self:Toggle() self.Animations.Toggle() end
    function self:IsOpen() return self.Animations.IsOpen() end
    function self:SetTitle(title)
        local newTitle = string.gsub(tostring(title or "AVA UI"), "<[^>]*>", "")
        self.WindowTitle = newTitle
        self.TitleLabel.Text = newTitle
    end
    function self:SetBlurIntensity(value)
        self.BlurIntensity = math.clamp(tonumber(value) or 28, 0, 56)
        if self:IsOpen() then self.OnWindowOpened() end
    end

    -- Keybind: RightControl
    UserInputService.InputBegan:Connect(function(i, gpe)
        if not gpe and i.KeyCode == Enum.KeyCode.RightControl then
            self:Toggle()
        end
    end)

    -- Drag del icono
    local function makeDraggable(obj, target)
        local dragStart, startPos, dragging
        obj.InputBegan:Connect(function(i)
            if self.LogoLocked then return end
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = i.Position
                startPos = target.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(i)
            if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                local del = i.Position - dragStart
                target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + del.X, startPos.Y.Scale, startPos.Y.Offset + del.Y)
            end
        end)
        UserInputService.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                dragging = false
                local parentSize = self.GUI.AbsoluteSize
                if parentSize.X > 0 and parentSize.Y > 0 then
                    local absPos, absSize = target.AbsolutePosition, target.AbsoluteSize
                    target.Position = UDim2.new((absPos.X + absSize.X / 2) / parentSize.X, 0, (absPos.Y + absSize.Y / 2) / parentSize.Y, 0)
                end
            end
        end)
    end
    makeDraggable(self.FloatIcon, self.FloatIcon)

    function self:SetScale(v) if self.WinScale then self.WinScale.Scale = v end end
    function self:SetLogoVisible(v) if self.FloatIcon then self.FloatIcon.Visible = v end end
    function self:SetLogoLocked(l) self.LogoLocked = l end

    return self
end

-- ================================================================== --
--  NOTIFICACIONES
-- ================================================================== --
function Library:Notify(feature, state)
    local accent = state and T.green or T.red
    local titleTxt = state and "SISTEMA ACTIVO" or "SISTEMA DESACTIVADO"

    local card = New("Frame", {
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundColor3 = T.card,
        BorderSizePixel = 0,
        ZIndex = 999999996,
        Parent = self.NotifLayer,
    })
    Cor(card, 12)

    local st = Stk(card, accent, 1.2)
    st.Transparency = 1
    local sh = Shadow(card, 1, 24)
    local cs = New("UIScale", { Scale = 0.8, Parent = card })

    local bar = New("Frame", {
        Position = UDim2.new(0, 10, 0.5, -12),
        Size = UDim2.new(0, 3, 0, 24),
        BackgroundColor3 = accent,
        BackgroundTransparency = 1,
        ZIndex = 999999997,
        Parent = card,
    })
    Cor(bar, 2)

    local title = New("TextLabel", {
        Position = UDim2.new(0, 20, 0, 8),
        Size = UDim2.new(1, -30, 0, 16),
        BackgroundTransparency = 1,
        Text = titleTxt, TextColor3 = accent,
        Font = Enum.Font.GothamBold, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTransparency = 1, ZIndex = 999999997, Parent = card,
    })

    local sub = New("TextLabel", {
        Position = UDim2.new(0, 20, 0, 24),
        Size = UDim2.new(1, -30, 0, 16),
        BackgroundTransparency = 1,
        Text = tostring(feature), TextColor3 = T.text,
        Font = Enum.Font.GothamMedium, TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTransparency = 1, ZIndex = 999999997, Parent = card,
    })

    local track = New("Frame", {
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, 0, 2),
        BackgroundColor3 = T.sep,
        BackgroundTransparency = 1,
        ZIndex = 999999997, Parent = card,
    })
    local fill = New("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = accent,
        BackgroundTransparency = 1,
        ZIndex = 999999998, Parent = track,
    })
    Cor(fill, 1)

    Tween(cs, 0.4, { Scale = 1 }, Enum.EasingStyle.Back)
    Tween(st, 0.35, { Transparency = 0 })
    Tween(sh, 0.35, { ImageTransparency = 0.6 })
    Tween(bar, 0.35, { BackgroundTransparency = 0 })
    Tween(title, 0.35, { TextTransparency = 0 })
    Tween(sub, 0.35, { TextTransparency = 0 })
    Tween(track, 0.35, { BackgroundTransparency = 0.5 })
    Tween(fill, 0.35, { BackgroundTransparency = 0 })
    Tween(fill, 2.0, { Size = UDim2.new(0, 0, 1, 0) }, Enum.EasingStyle.Linear)

    task.delay(2.1, function()
        if not card or not card.Parent then return end
        Tween(cs, 0.3, { Scale = 0.8 }, Enum.EasingStyle.Quad)
        Tween(st, 0.3, { Transparency = 1 })
        Tween(sh, 0.3, { ImageTransparency = 1 })
        Tween(bar, 0.3, { BackgroundTransparency = 1 })
        Tween(title, 0.3, { TextTransparency = 1 })
        Tween(sub, 0.3, { TextTransparency = 1 })
        track:Destroy()
        task.delay(0.35, function() if card then card:Destroy() end end)
    end)
end

-- ================================================================== --
--  TABS / SECCIONES
-- ================================================================== --
function Library:CreateTab(name, iconId)
    local page = TabsModule.Create(self, name, iconId)
    local TabMethods = { Library = self, Page = page }

    function TabMethods:CreateSection(title)
        local container = New("Frame", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            ZIndex = 5,
            Parent = page,
        })
        List(container, Enum.FillDirection.Vertical, 8)

        local head = New("TextLabel", {
            Size = UDim2.new(1, -4, 0, 24),
            Position = UDim2.new(0, 4, 0, 0),
            BackgroundTransparency = 1,
        Text = title,
            TextColor3 = T.sub,
        Font = Enum.Font.GothamSemibold,
        TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 6,
            Parent = container,
        })
        self:Reg(head, "TextColor3", "sub")

        local card = New("Frame", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = T.card,
            BackgroundTransparency = 0.62,
            BorderSizePixel = 0,
            ZIndex = 5,
            Parent = container,
        })
        Cor(card, 17)
        local cardStroke = Stk(card, T.border, 1)
        cardStroke.Transparency = 0.9
        self:Reg(cardStroke, "Color", "border")
        self:Reg(card, "BackgroundColor3", "card")
        List(card, Enum.FillDirection.Vertical, 8)
        Pad(card, 10, 10, 10, 10)

        local ElementMethods = { Card = card, Library = self }

        function ElementMethods:AddToggle(lbl, def, cb) ToggleModule.Add(self.Library, card, lbl, def, cb) end
        function ElementMethods:AddButton(lbl, cb) ButtonModule.Add(self.Library, card, lbl, cb) end
        function ElementMethods:AddSlider(lbl, mn, mx, def, cb) SliderModule.Add(self.Library, card, lbl, mn, mx, def, cb) end
        function ElementMethods:AddDropdown(lbl, options, defaultIdx, cb) DropdownModule.Add(self.Library, card, lbl, options, defaultIdx, cb) end
        function ElementMethods:AddColorPicker(lbl, defaultColor, cb) ColorPickerModule.Add(self.Library, card, lbl, defaultColor, cb) end

        return ElementMethods
    end

    return TabMethods
end

return Library
