--// PHANTOM UI - SOUND SERVICE (PROFESSIONAL)

local SoundService = {}
SoundService.__index = SoundService

local Debris = game:GetService("Debris")

-- BASE (seu repositório)
local AUDIO_BASE = "https://raw.githubusercontent.com/blackxscripts/Icons/main/Audio-Effect/"

-- Mapeamento de sons
local Sounds = {
    click = AUDIO_BASE .. "clicksoundeffect.mp3",
    tab   = AUDIO_BASE .. "minecraft_click.mp3"
}

-- Cache (evita recriar sempre)
local Cache = {}

function SoundService:Play(name, volume)
    local soundId = Sounds[name]
    if not soundId then
        warn("[Phantom UI] Sound not found:", name)
        return
    end

    local s = Instance.new("Sound")
    s.SoundId = soundId
    s.Volume = volume or 1
    s.Parent = game:GetService("SoundService")

    s:Play()

    Debris:AddItem(s, 2)
end

-- Permite adicionar novos sons dinamicamente
function SoundService:Register(name, url)
    Sounds[name] = url
end

-- Obter URL
function SoundService:Get(name)
    return Sounds[name]
end

return SoundService
