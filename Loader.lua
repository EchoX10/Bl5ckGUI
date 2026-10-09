-- =========================================================
-- BLACKGUI LOADER
-- Repo: EchoX10/Bl5ckGUI
-- =========================================================

local GITHUB_USER   = "EchoX10"
local GITHUB_REPO   = "Bl5ckGUI"
local GITHUB_BRANCH = "main"
local PASTA         = "modules"

local BASE_URL = "https://raw.githubusercontent.com/" .. GITHUB_USER .. "/" .. GITHUB_REPO .. "/" .. GITHUB_BRANCH .. "/" .. PASTA .. "/"

_G.BlackGUI = _G.BlackGUI or {}
local BG = _G.BlackGUI

BG.Players           = game:GetService("Players")
BG.ReplicatedStorage = game:GetService("ReplicatedStorage")
BG.SoundService      = game:GetService("SoundService")
BG.TweenService      = game:GetService("TweenService")
BG.UserInputService  = game:GetService("UserInputService")
BG.RunService        = game:GetService("RunService")
BG.CoreGui           = game:GetService("CoreGui")
BG.plr               = BG.Players.LocalPlayer
BG.playerGui         = BG.plr:WaitForChild("PlayerGui")

local MODULOS = {
    "01-Config.lua",
    "02-Core.lua",
    "03-Jogador.lua",
    "04-Visual.lua",
    "05-Mapa.lua",
    "06-GUI.lua"
}

print("════════ BLACKGUI LOADER ════════")
print("Repo: " .. GITHUB_USER .. "/" .. GITHUB_REPO)

for i, arquivo in ipairs(MODULOS) do
    local url = BASE_URL .. arquivo
    print(string.format("[%d/%d] %s", i, #MODULOS, arquivo))

    local ok, src = pcall(game.HttpGet, game, url, true)
    if not ok or not src or #src < 50 then
        warn("❌ Falha ao baixar " .. arquivo)
        warn("   URL: " .. url)
        return
    end

    local fn, err = loadstring(src)
    if not fn then
        warn("❌ Sintaxe errada em " .. arquivo .. ": " .. tostring(err))
        return
    end

    local ok2, err2 = pcall(fn)
    if not ok2 then
        warn("❌ Runtime em " .. arquivo .. ": " .. tostring(err2))
        return
    end

    print("   ✅ OK")
end

print("════════ BLACKGUI PRONTA ════════")
