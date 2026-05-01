--// PHANTOM UI - THEME (PROFESSIONAL)

local Theme = {}

-- Paleta principal (Black X / Phantom style)
Theme.Colors = {
    Background     = Color3.fromRGB(12, 12, 12),
    Surface        = Color3.fromRGB(18, 18, 18),
    Card           = Color3.fromRGB(22, 22, 22),
    CardHover      = Color3.fromRGB(28, 28, 28),

    Accent         = Color3.fromRGB(140, 100, 255), -- roxo phantom
    AccentSoft     = Color3.fromRGB(100, 80, 200),

    TextPrimary    = Color3.fromRGB(255, 255, 255),
    TextSecondary  = Color3.fromRGB(180, 180, 180),

    Stroke         = Color3.fromRGB(40, 40, 40),
    Divider        = Color3.fromRGB(30, 30, 30),
}

-- Tamanhos padrão
Theme.Sizes = {
    Window = UDim2.new(0, 600, 0, 350),

    SidebarWidth = 150,
    TopbarHeight = 40,

    ElementHeight = 50,
    Padding = 10,
    Radius = 12,
}

-- Fontes
Theme.Fonts = {
    Title = Enum.Font.GothamBold,
    Body  = Enum.Font.Gotham,
}

-- Animações
Theme.Animations = {
    Fast = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Normal = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Slow = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
}

-- Funções utilitárias

function Theme:ApplyCorner(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or self.Sizes.Radius)
    corner.Parent = instance
    return corner
end

function Theme:ApplyStroke(instance, color)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or self.Colors.Stroke
    stroke.Thickness = 1
    stroke.Parent = instance
    return stroke
end

function Theme:ApplyPadding(instance, padding)
    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, padding or self.Sizes.Padding)
    pad.PaddingBottom = UDim.new(0, padding or self.Sizes.Padding)
    pad.PaddingLeft = UDim.new(0, padding or self.Sizes.Padding)
    pad.PaddingRight = UDim.new(0, padding or self.Sizes.Padding)
    pad.Parent = instance
    return pad
end

return Theme
