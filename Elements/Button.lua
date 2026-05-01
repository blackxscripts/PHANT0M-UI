--// PHANTOM UI - BUTTON (PROFESSIONAL)

local Button = {}
Button.__index = Button

function Button:Create(parent, text, icon, callback, engine)
    local self = setmetatable({}, Button)

    local Theme = engine.Theme
    local Card = require(script.Parent.Parent.Components.Card)

    -- Base (Card)
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
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 40, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Colors.TextPrimary
    label.Font = Theme.Fonts.Body
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = card

    -- CLICK AREA
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = card

    button.MouseButton1Click:Connect(function()
        engine:PlaySound("click")
        if callback then
            pcall(callback)
        end
    end)

    self.Instance = card
    self.Button = button

    return self
end

return Button
