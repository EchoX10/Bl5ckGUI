-- =========================================================
-- MÓDULO 02 - CORE (F3X + HD ADMIN + HELPERS)
-- =========================================================

local BG = _G.BlackGUI
local ReplicatedStorage = BG.ReplicatedStorage
local plr = BG.plr

-- ============== CARREGAR F3X WRAPPER ==============
print("[Core] Baixando F3X wrapper...")
local F3X_URL = "https://raw.githubusercontent.com/bqmb3/f3x-wrapper/main/loader.lua"

local ok, html = pcall(function()
    return game:HttpGet(F3X_URL, true)
end)

if not ok or not html or #html < 100 then
    warn("[Core] Falha ao baixar F3X: " .. tostring(html))
    return
end

local ok2, F3X = pcall(function() return loadstring(html)() end)

if not ok2 or not F3X then
    warn("[Core] loadstring do F3X falhou")
    return
end

BG.F3X = F3X
print("[Core] F3X carregado")

-- ============== SERVERENDPOINT (F3X tradicional) ==============
local function getSE()
    if plr.Character then
        for _, c in ipairs(plr.Character:GetChildren()) do
            if c:FindFirstChild("SyncAPI") then
                return c.SyncAPI:FindFirstChild("ServerEndpoint")
            end
        end
    end
    local bp = plr:FindFirstChild("Backpack")
    if bp then
        for _, c in ipairs(bp:GetChildren()) do
            if c:FindFirstChild("SyncAPI") then
                return c.SyncAPI:FindFirstChild("ServerEndpoint")
            end
        end
    end
end

BG.se = getSE()
if BG.se then
    print("[Core] ServerEndpoint F3X encontrado")
else
    warn("[Core] ServerEndpoint não encontrado")
end

-- ============== HD ADMIN ==============
local function getRC()
    local hdc = ReplicatedStorage:FindFirstChild("HDAdminHDClient")
    if hdc then
        local sig = hdc:FindFirstChild("Signals")
        if sig then
            return sig:FindFirstChild("RequestCommandSilent") or sig:FindFirstChild("RequestCommand")
        end
    end
end

BG.rc = getRC()
if BG.rc then
    print("[Core] HD Admin encontrado")
else
    warn("[Core] HD Admin não encontrado")
end

BG.cmdHD = function(c)
    if not BG.rc then return end
    pcall(function() BG.rc:InvokeServer(c) end)
end

-- ============== BUILDING TOOLS+ ENDPOINT ==============
function BG.getFork3XEndpoint()
    local bp = plr:FindFirstChild("Backpack")
    if bp then
        for _, tool in ipairs(bp:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == "Building Tools+" then
                local syncAPI = tool:FindFirstChild("SyncAPI")
                if syncAPI then
                    local s = syncAPI:FindFirstChild("ServerEndpoint")
                    if s and s:IsA("RemoteFunction") then return s end
                end
            end
        end
    end
    if plr.Character then
        for _, tool in ipairs(plr.Character:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == "Building Tools+" then
                local syncAPI = tool:FindFirstChild("SyncAPI")
                if syncAPI then
                    local s = syncAPI:FindFirstChild("ServerEndpoint")
                    if s and s:IsA("RemoteFunction") then return s end
                end
            end
        end
    end
end

-- ============== HELPERS ==============
function BG.acharParteReal(posicao, tamanho)
    local parteReal, menorDist = nil, math.huge
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("BasePart") then
            local d = (obj.Position - posicao).Magnitude
            local tamDiff = (obj.Size - tamanho).Magnitude
            if d < 3 and tamDiff < 0.5 and d < menorDist then
                menorDist = d
                parteReal = obj
            end
        end
    end
    return parteReal
end

function BG.criarWeldServerSide(seBTP, parte1, parte2)
    if not seBTP or not parte1 or not parte2 then return false end
    return pcall(function()
        seBTP:InvokeServer("CreateConstraints", {parte1}, {}, parte2, "Weld")
    end)
end

print("[Core] Helpers prontos")
