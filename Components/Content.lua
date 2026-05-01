--// PHANTOM UI - CONTENT (PROFESSIONAL)

local Content = {}
Content.__index = Content

function Content:Create(window)
    local self = setmetatable({}, Content)

    local engine = window.Engine or window._engine
    local Theme = engine.Theme

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -Theme.Sizes.SidebarWidth, 1, -Theme.Sizes.TopbarHeight)
    content.Position = UDim2.new(0, Theme.Sizes.SidebarWidth, 0, Theme.Sizes.TopbarHeight)
    content.BackgroundTransparency = 1
    content.Parent = window.Main

    self.Frame = content
    self.Pages = {}
    self.Current = nil

    return self
end

-- Criar página (tab content)
function Content:AddPage(name)
    local engine = self.Frame.Parent.Parent.Parent and self.Frame.Parent.Parent.Parent._engine
    local Theme = engine.Theme

    local page = Instance.new("Frame")
    page.Name = name .. "_Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = self.Frame

    -- Layout interno
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

    -- Padding interno
    Theme:ApplyPadding(page)

    self.Pages[name] = page

    return page
end

-- Trocar página ativa
function Content:Switch(page)
    local engine = self.Frame.Parent.Parent.Parent and self.Frame.Parent.Parent.Parent._engine
    local Theme = engine.Theme

    if self.Current then
        self.Current.Visible = false
    end

    page.Visible = true
    self.Current = page
end

return Content
