--// PHANTOM UI - LABEL (PROFESSIONAL)

local Label = {}
Label.__index = Label

function Label:Create(parent, text, icon, engine)
    local self = setmetatable({}, Label)

    local Theme = engine.Theme
    local Card = require(script.Parent.Parent.Components.Card)

    -- BASE
    local card = Card:Create(parent, engine).Frame

    -- ICON (opcional)
    if icon then
        local iconImg = Instance.new("ImageLabel")
        iconImg.Size = UDim2.new(0, 22, 0, 22)
        iconImg.Position = UDim2.new(0, 10, 0.5, -11)
        iconImg.BackgroundTransparency = 1
        iconImg.Image = engine:GetIcon(icon)
        iconImg.Parent = card
    end

    -- TEXT
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, icon and -60 or -20, 1, 0)
    label.Position = UDim2.new(0, icon and 40 or 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text or ""
    label.TextColor3 = Theme.Colors.TextSecondary
    label.Font = Theme.Fonts.Body
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = card

    -- API
    function self:Set(textValue)
        label.Text = textValue
    end

    function self:Get()
        return label.Text
    end

    self.Instance = card
    self.Label = label

    return self
end

return Label
