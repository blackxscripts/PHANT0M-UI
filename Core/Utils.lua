--// PHANTOM UI - UTILS (PROFESSIONAL)

local Utils = {}

local HttpService = game:GetService("HttpService")

-- Gera ID único
function Utils:UUID()
    return HttpService:GenerateGUID(false)
end

-- Clamp (limitar valor)
function Utils:Clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

-- Lerp (interpolação)
function Utils:Lerp(a, b, t)
    return a + (b - a) * t
end

-- Formatar número (ex: slider)
function Utils:FormatNumber(num, decimals)
    decimals = decimals or 0
    return string.format("%."..decimals.."f", num)
end

-- Verificação segura de função
function Utils:IsFunction(fn)
    return typeof(fn) == "function"
end

-- Execução segura
function Utils:SafeCall(fn, ...)
    if not self:IsFunction(fn) then return end
    local success, result = pcall(fn, ...)
    if not success then
        warn("[Phantom UI] Error:", result)
    end
    return result
end

-- Criar instância com propriedades
function Utils:Create(class, props, children)
    local obj = Instance.new(class)

    if props then
        for k, v in pairs(props) do
            obj[k] = v
        end
    end

    if children then
        for _, child in ipairs(children) do
            child.Parent = obj
        end
    end

    return obj
end

-- Detectar mobile
function Utils:IsMobile()
    return game:GetService("UserInputService").TouchEnabled
end

-- Converter escala → offset
function Utils:ScaleToOffset(xScale, yScale, parent)
    local size = parent.AbsoluteSize
    return UDim2.new(0, size.X * xScale, 0, size.Y * yScale)
end

-- Debounce simples
function Utils:Debounce(time)
    local debounce = false
    return function(callback)
        if debounce then return end
        debounce = true

        callback()

        task.delay(time, function()
            debounce = false
        end)
    end
end

-- Deep copy (tabelas)
function Utils:DeepCopy(tbl)
    local copy = {}
    for k, v in pairs(tbl) do
        if typeof(v) == "table" then
            copy[k] = self:DeepCopy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

return Utils
