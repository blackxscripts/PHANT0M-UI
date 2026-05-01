--// PHANTOM UI - CARD (PROFESSIONAL BASE COMPONENT)

local Card = {}
Card.__index = Card

function Card:Create(parent, engine)
    local self = setmetatable({}, Card)

    local Theme = engine.Theme

    -- CONTAINER
    local frame = Instance.new("Frame")
    frame.Name = "Card"
    frame.Size = UDim2.new(1, 0, 0, Theme.Sizes.ElementHeight)
    frame.BackgroundColor3 = Theme.Colors.Card
    frame.BorderSizePixel = 0
    frame.Parent = parent

    Theme:ApplyCorner(frame)
    Theme:ApplyPadding(frame, 10)

    -- HOVER EFFECT
    frame.MouseEnter:Connect(function()
        engine:Tween(frame, {
            BackgroundColor3 = Theme.Colors.CardHover
        }, 0.15)
    end)

    frame.MouseLeave:Connect(function()
        engine:Tween(frame, {
            BackgroundColor3 = Theme.Colors.Card
        }, 0.15)
    end)

    self.Frame = frame

    return self
end

return Card
