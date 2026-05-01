--// PHANTOM UI - STATE (PROFESSIONAL)

local State = {}
State.__index = State

function State:Create()
    local self = setmetatable({}, State)

    -- Tabs
    self.Tabs = {}
    self.CurrentTab = nil

    -- Elements state (toggles, sliders, etc.)
    self.Values = {}

    -- Flags / storage
    self.Flags = {}

    -- Config
    self.Config = {
        AutoSave = false,
        SaveKey = "PhantomUI_Config"
    }

    return self
end

-- Tab management
function State:SetCurrentTab(tab)
    self.CurrentTab = tab
end

function State:GetCurrentTab()
    return self.CurrentTab
end

-- Register tab
function State:RegisterTab(tab)
    table.insert(self.Tabs, tab)
end

-- Values (toggles, sliders)
function State:SetValue(flag, value)
    self.Values[flag] = value
end

function State:GetValue(flag)
    return self.Values[flag]
end

-- Flags
function State:SetFlag(flag, value)
    self.Flags[flag] = value
end

function State:GetFlag(flag)
    return self.Flags[flag]
end

-- Reset state
function State:Reset()
    self.Values = {}
    self.Flags = {}
    self.CurrentTab = nil
end

return State
