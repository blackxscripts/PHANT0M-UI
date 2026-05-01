--// PHANTOM UI - SLIDER (PROFESSIONAL)

local Slider = {}
Slider.__index = Slider

function Slider:Create(parent, text, icon, min, max, default, callback, engine)
    local self = setmetatable({}, Slider)

    local Theme = engine.Theme
    local Utils = require(script.Parent.Parent.Core.Utils)
    local Card = require(script.Parent.Parent.Components.Card)

    min = min or 0
    max = max or 100
    default = default or min

    local value = Utils:Clamp(default, min, max)

    -- BASE
    local card = Card:Create(parent, engine).Frame

    -- ICON
    local iconImg = Instance.new("ImageLabel")
    iconImg.Size = UDim2.new(0, 22, 0, 22)
    iconImg.Position = UDim2.new(0, 10, 0.5, -11)
    iconImg.BackgroundTransparency = 1
    iconImg.Image = engine:GetIcon(icon)
    iconImg.Parent = card

    -- TEXT
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -120, 0, 20)
    label.Position = UDim2.new(0, 40, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Colors.TextPrimary
    label.Font = Theme.Fonts.Body
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = card

    -- VALUE TEXT
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 60, 0, 20)
    valueLabel.Position = UDim2.new(1, -70, 0, 5)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(value)
    valueLabel.TextColor3 = Theme.Colors.TextSecondary
    valueLabel.Font = Theme.Fonts.Body
    valueLabel.TextSize = 14
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = card

    -- BAR BACKGROUND
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -60, 0, 6)
    bar.Position = UDim2.new(0, 40, 1, -12)
    bar.BackgroundColor3 = Theme.Colors.Stroke
    bar.Parent = card

    Theme:ApplyCorner(bar, 100)

    -- FILL
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Theme.Colors.Accent
    fill.Parent = bar

    Theme:ApplyCorner(fill, 100)

    -- DRAG
    local dragging = false

    local function update(inputX)
        local relative = (inputX - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
        relative = Utils:Clamp(relative, 0, 1)

        value = math.floor((min + (max - min) * relative))
        valueLabel.Text = tostring(value)

        fill.Size = UDim2.new(relative, 0, 1, 0)

        if callback then
            pcall(callback, value)
        end
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            engine:PlaySound("click")
            update(input.Position.X)
        end
    end)

    bar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input.Position.X)
        end
    end)

    -- API
    function self:Set(val)
        val = Utils:Clamp(val, min, max)
        value = val

        local percent = (value - min) / (max - min)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        valueLabel.Text = tostring(value)

        if callback then
            pcall(callback, value)
        end
    end

    function self:Get()
        return value
    end

    self.Instance = card

    return self
end

return Slider
