--// PHANTOM UI - DROPDOWN (PROFESSIONAL)

local Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown:Create(parent, text, icon, options, callback, engine)
    local self = setmetatable({}, Dropdown)

    local Theme = engine.Theme
    local Card = require(script.Parent.Parent.Components.Card)

    options = options or {}

    local selected = nil
    local opened = false

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
    label.Size = UDim2.new(1, -120, 1, 0)
    label.Position = UDim2.new(0, 40, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Colors.TextPrimary
    label.Font = Theme.Fonts.Body
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = card

    -- SELECTED VALUE
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 100, 1, 0)
    valueLabel.Position = UDim2.new(1, -110, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = "Select"
    valueLabel.TextColor3 = Theme.Colors.TextSecondary
    valueLabel.Font = Theme.Fonts.Body
    valueLabel.TextSize = 14
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = card

    -- DROPDOWN LIST
    local list = Instance.new("Frame")
    list.Size = UDim2.new(1, 0, 0, 0)
    list.Position = UDim2.new(0, 0, 1, 0)
    list.BackgroundColor3 = Theme.Colors.Surface
    list.ClipsDescendants = true
    list.Parent = card

    Theme:ApplyCorner(list)

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.Parent = list

    -- CREATE OPTION
    local function createOption(opt)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 30)
        btn.BackgroundColor3 = Theme.Colors.Card
        btn.Text = opt
        btn.TextColor3 = Theme.Colors.TextPrimary
        btn.Font = Theme.Fonts.Body
        btn.TextSize = 14
        btn.Parent = list

        Theme:ApplyCorner(btn)

        btn.MouseButton1Click:Connect(function()
            selected = opt
            valueLabel.Text = opt
            opened = false

            engine:Tween(list, {
                Size = UDim2.new(1, 0, 0, 0)
            }, 0.25)

            engine:PlaySound("click")

            if callback then
                pcall(callback, selected)
            end
        end)
    end

    for _, opt in ipairs(options) do
        createOption(opt)
    end

    -- TOGGLE OPEN
    local click = Instance.new("TextButton")
    click.Size = UDim2.new(1, 0, 1, 0)
    click.BackgroundTransparency = 1
    click.Text = ""
    click.Parent = card

    click.MouseButton1Click:Connect(function()
        opened = not opened
        engine:PlaySound("click")

        local targetSize = opened and UDim2.new(1, 0, 0, #options * 35) or UDim2.new(1, 0, 0, 0)

        engine:Tween(list, {
            Size = targetSize
        }, 0.25)
    end)

    -- API
    function self:Set(val)
        if table.find(options, val) then
            selected = val
            valueLabel.Text = val
        end
    end

    function self:Get()
        return selected
    end

    self.Instance = card

    return self
end

return Dropdown
