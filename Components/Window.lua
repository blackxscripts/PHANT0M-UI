--// PHANTOM UI - WINDOW (PROFESSIONAL)

local Window = {}
Window.__index = Window

function Window:Create(engine)
    local self = setmetatable({}, Window)

    local Theme = engine.Theme

    local container = engine.MainContainer

    -- MAIN WINDOW
    local main = Instance.new("Frame")
    main.Name = "Window"
    main.Size = Theme.Sizes.Window
    main.BackgroundColor3 = Theme.Colors.Background
    main.BorderSizePixel = 0
    main.Parent = container

    Theme:ApplyCorner(main)

    self.Main = main

    -- TOPBAR
    local top = Instance.new("Frame")
    top.Name = "Topbar"
    top.Size = UDim2.new(1, 0, 0, Theme.Sizes.TopbarHeight)
    top.BackgroundColor3 = Theme.Colors.Surface
    top.BorderSizePixel = 0
    top.Parent = main

    Theme:ApplyCorner(top)

    -- TITLE
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -50, 1, 0)
    title.Position = UDim2.new(0, 15, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "PHANTOM HUB"
    title.TextColor3 = Theme.Colors.TextPrimary
    title.Font = Theme.Fonts.Title
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = top

    -- CLOSE BUTTON
    local close = Instance.new("TextButton")
    close.Name = "Close"
    close.Size = UDim2.new(0, 30, 0, 30)
    close.Position = UDim2.new(1, -35, 0.5, -15)
    close.BackgroundColor3 = Theme.Colors.Card
    close.Text = "X"
    close.TextColor3 = Theme.Colors.TextPrimary
    close.Font = Theme.Fonts.Title
    close.TextSize = 14
    close.Parent = top

    Theme:ApplyCorner(close)

    close.MouseButton1Click:Connect(function()
        engine:PlaySound("click")
        engine.Gui:Destroy()
    end)

    -- DRAG
    engine:EnableDrag(top)

    self.Topbar = top

    return self
end

return Window
