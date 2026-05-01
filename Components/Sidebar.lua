--// PHANTOM UI - SIDEBAR (PROFESSIONAL)

local Sidebar = {}
Sidebar.__index = Sidebar

function Sidebar:Create(window)
    local self = setmetatable({}, Sidebar)

    local engine = window.Engine or window._engine
    local Theme = engine.Theme

    -- SIDEBAR FRAME
    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0, Theme.Sizes.SidebarWidth, 1, -Theme.Sizes.TopbarHeight)
    sidebar.Position = UDim2.new(0, 0, 0, Theme.Sizes.TopbarHeight)
    sidebar.BackgroundColor3 = Theme.Colors.Surface
    sidebar.BorderSizePixel = 0
    sidebar.Parent = window.Main

    Theme:ApplyCorner(sidebar)
    Theme:ApplyPadding(sidebar)

    -- LAYOUT
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = sidebar

    self.Frame = sidebar
    self.Tabs = {}
    self.Active = nil

    return self
end

-- CREATE TAB BUTTON
function Sidebar:AddTab(name, icon)
    local engine = self.Frame.Parent.Parent.Parent and self.Frame.Parent.Parent.Parent._engine
    local Theme = engine.Theme

    local btn = Instance.new("TextButton")
    btn.Name = name .. "_Tab"
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Theme.Colors.Card
    btn.Text = "   " .. name
    btn.TextColor3 = Theme.Colors.TextPrimary
    btn.Font = Theme.Fonts.Body
    btn.TextSize = 14
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.AutoButtonColor = false
    btn.Parent = self.Frame

    Theme:ApplyCorner(btn)

    -- ICON
    local iconImg = Instance.new("ImageLabel")
    iconImg.Size = UDim2.new(0, 20, 0, 20)
    iconImg.Position = UDim2.new(0, 8, 0.5, -10)
    iconImg.BackgroundTransparency = 1
    iconImg.Image = engine:GetIcon(icon)
    iconImg.Parent = btn

    local tab = {
        Name = name,
        Button = btn
    }

    table.insert(self.Tabs, tab)

    -- CLICK
    btn.MouseButton1Click:Connect(function()
        engine:PlaySound("tab")
        self:SetActive(tab)
    end)

    return tab
end

-- SET ACTIVE TAB
function Sidebar:SetActive(tab)
    local engine = self.Frame.Parent.Parent.Parent and self.Frame.Parent.Parent.Parent._engine
    local Theme = engine.Theme

    if self.Active then
        self.Active.Button.BackgroundColor3 = Theme.Colors.Card
    end

    tab.Button.BackgroundColor3 = Theme.Colors.CardHover
    self.Active = tab
end

return Sidebar
