--// PHANTOM UI - TOGGLE (PROFESSIONAL)

local Toggle = {}
Toggle.__index = Toggle

function Toggle:Create(parent, text, icon, callback, engine)
    local self = setmetatable({}, Toggle)

    local Theme = engine.Theme
    local Card = require(script.Parent.Parent.Components.Card)

    local state = false

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
    label.Size = UDim2.new(1, -100, 1, 0)
    label.Position = UDim2.new(0, 40, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Colors.TextPrimary
    label.Font = Theme.Fonts.Body
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = card

    -- SWITCH BACKGROUND
    local switch = Instance.new("Frame")
    switch.Size = UDim2.new(0, 40, 0, 20)
    switch.Position = UDim2.new(1, -50, 0.5, -10)
    switch.BackgroundColor3 = Theme.Colors.Stroke
    switch.Parent = card

    Theme:ApplyCorner(switch, 100)

    -- KNOB
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 1, 0.5, -9)
    knob.BackgroundColor3 = Theme.Colors.TextPrimary
    knob.Parent = switch

    Theme:ApplyCorner(knob, 100)

    -- CLICK AREA
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = card

    -- TOGGLE FUNCTION
    local function setState(val)
        state = val

        engine:Tween(knob, {
            Position = state and UDim2.new(1, -19, 0.5, -9) or UDim2.new(0, 1, 0.5, -9)
        }, 0.2)

        switch.BackgroundColor3 = state and Theme.Colors.Accent or Theme.Colors.Stroke

        if callback then
            pcall(callback, state)
        end
    end

    button.MouseButton1Click:Connect(function()
        engine:PlaySound("click")
        setState(not state)
    end)

    -- API
    function self:Set(val)
        setState(val)
    end

    function self:Get()
        return state
    end

    self.Instance = card
    self.Button = button

    return self
end

return Toggle
