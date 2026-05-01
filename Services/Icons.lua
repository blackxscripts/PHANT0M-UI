--// PHANTOM UI - ICONS SERVICE (PROFESSIONAL)

local Icons = {}
Icons.__index = Icons

-- BASE (seu repositório)
local ICON_BASE = "https://raw.githubusercontent.com/blackxscripts/Icons/main/Icones2/"

-- Cache (performance)
local Cache = {}

-- Retorna URL do ícone
function Icons:Get(name)
    if not name or name == "" then
        return ""
    end

    -- Cache hit
    if Cache[name] then
        return Cache[name]
    end

    local url = ICON_BASE .. name .. ".png"
    Cache[name] = url

    return url
end

-- Registrar ícone custom
function Icons:Register(name, url)
    Cache[name] = url
end

-- Pré-carregar múltiplos ícones (opcional)
function Icons:Preload(list)
    for _, name in ipairs(list) do
        self:Get(name)
    end
end

return Icons
