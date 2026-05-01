--// PHANTOM UI - ENGINE (CORE SYSTEM V2)

local Engine = {}
Engine.__index = Engine

-- Services internos
local Players = game:GetService("Players")

-- Import local (será resolvido pelo Init.lua)
local Icons
local Sound
local Tween
local Input
local Theme

-- Setter para injeção de dependências (padrão profissional)
function Engine:Inject(deps)
    Icons = deps.Icons
    Sound = deps.Sound
    Tween = deps.Tween
    Input = deps.Input
    Theme = deps.Theme
end

-- Criação segura da GUI
local function createGui()
    local gui = Instance.new("ScreenGui")
    gui.Name = "PhantomUI"
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.ResetOnSpawn = false

    local success = pcall(function()
        gui.Parent = game:GetService("CoreGui")
    end)

    if not success or not gui.Parent then
        local player = Players.LocalPlayer
        if player then
            gui.Parent = player:WaitForChild("PlayerGui")
        end
    end

    return gui
end

-- API principal
function Engine:Create()
    local self = setmetatable({}, Engine)

    -- GUI
    self.Gui = createGui()

    -- ROOT
    local root = Instance.new("Frame")
    root.Name = "Root"
    root.Size = UDim2.fromScale(1, 1)
    root.BackgroundTransparency = 1
    root.Parent = self.Gui

    self.Root = root

    -- CONTAINER CENTRAL
    local container = Instance.new("Frame")
    container.Name = "MainContainer"
    container.AnchorPoint = Vector2.new(0.5, 0.5)
    container.Position = UDim2.fromScale(0.5, 0.5)
    container.Size = UDim2.new(0, 600, 0, 350)
    container.BackgroundTransparency = 1
    container.Parent = root

    self.MainContainer = container

    -- ESTADO INTERNO
    self.Loaded = true

    -- MÉTODOS UTILITÁRIOS

    function self:PlaySound(name)
        if Sound then
            Sound:Play(name)
        end
    end

    function self:Tween(obj, props, time)
        if Tween then
            Tween:Create(obj, props, time)
        end
    end

    function self:GetIcon(name)
        if Icons then
            return Icons:Get(name)
        end
        return ""
    end

    -- DRAG GLOBAL (aplicado depois pelo Window)
    function self:EnableDrag(frame)
        if Input then
            Input:MakeDraggable(frame)
        end
    end

    return self
end

return Engine
