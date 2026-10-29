-- =========================================================
-- MÓDULO 02 - CORE (F3X + HD ADMIN + HELPERS)
-- =========================================================

local BG = _G.BlackGUI
local ReplicatedStorage = BG.ReplicatedStorage
local plr = BG.plr
local Players = BG.Players
local TweenService = BG.TweenService

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

-- ============== DETECÇÃO DE EXECUTOR ==============
BG.executor = {
    nome = (syn and "Synapse") or (fluxus and "Fluxus") or (Krnl and "Krnl") or
           (is_sirhurt_closure and "SirHurt") or
           (type(identifyexecutor) == "function" and identifyexecutor()) or
           "Desconhecido",
    temSetclipboard = type(setclipboard) == "function",
    temHook = type(hookmetamethod) == "function" and type(hookfunction) == "function",
    temGetConnections = type(getconnections) == "function",
    temWriteFile = type(writefile) == "function",
    temHttpGet = type(game.HttpGet) == "function",
    temLoadstring = type(loadstring) == "function",
    temMakeFolder = type(makefolder) == "function",
}

print("[Core] Executor: " .. BG.executor.nome)

-- ============== LOG ==============
BG.log = function(...)
    local partes = {}
    for _, v in ipairs({...}) do
        table.insert(partes, tostring(v))
    end
    print("[BL5CK] " .. table.concat(partes, " "))
end

BG.logErro = function(...)
    local partes = {}
    for _, v in ipairs({...}) do
        table.insert(partes, tostring(v))
    end
    warn("[BL5CK ERRO] " .. table.concat(partes, " "))
end

-- ============== HELPERS DE PLAYER ==============
function BG.acharPlayer(termo)
    if not termo or termo == "" then return nil end
    termo = termo:lower()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name:lower():find(termo, 1, true) or p.DisplayName:lower():find(termo, 1, true) then
            return p
        end
    end
end

function BG.acharPlayerPorId(id)
    return Players:GetPlayerByUserId(id)
end

function BG.playerVivo(p)
    if not p or not p.Character then return false end
    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
    local hum = p.Character:FindFirstChildOfClass("Humanoid")
    return hrp ~= nil and hum ~= nil and hum.Health > 0
end

function BG.posicaoPlayer(p)
    if not BG.playerVivo(p) then return nil end
    return p.Character.HumanoidRootPart.Position
end

function BG.playersVivos(excluirEu)
    local lista = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if (not excluirEu or p ~= plr) and BG.playerVivo(p) then
            table.insert(lista, p)
        end
    end
    return lista
end

function BG.getHumanoid(p)
    if not p or not p.Character then return nil end
    return p.Character:FindFirstChildOfClass("Humanoid")
end

function BG.getHRP(p)
    if not p or not p.Character then return nil end
    return p.Character:FindFirstChild("HumanoidRootPart")
end

-- ============== HELPERS DE BTP ==============
function BG.garantirBTP(tempoMax)
    tempoMax = tempoMax or 5
    if BG.getFork3XEndpoint() then return true end
    BG.cmdHD(";btools")
    local inicio = os.clock()
    while os.clock() - inicio < tempoMax do
        task.wait(0.2)
        if BG.getFork3XEndpoint() then
            return true
        end
    end
    return false
end

function BG.loopGarantirBTP(condicao)
    task.spawn(function()
        while condicao() do
            task.wait(3)
            if not BG.getFork3XEndpoint() then
                BG.cmdHD(";btools")
            end
        end
    end)
end

-- ============== HELPERS DE PART ==============
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

function BG.criarPartFallback(cframe, tamanho, cor)
    local part = Instance.new("Part")
    part.Anchored = true
    part.CanCollide = false
    part.Size = tamanho or Vector3.new(1, 1, 1)
    part.CFrame = cframe or CFrame.new(0, 0, 0)
    part.Color = cor or Color3.fromRGB(255, 255, 255)
    part.Parent = workspace
    return part
end

function BG.criarWeldServerSide(seBTP, parte1, parte2)
    if not seBTP or not parte1 or not parte2 then return false end
    return pcall(function()
        seBTP:InvokeServer("CreateConstraints", {parte1}, {}, parte2, "Weld")
    end)
end

-- ============== HELPERS DE WORKSPACE ==============
function BG.contarPartes()
    local n = 0
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then n = n + 1 end
    end
    return n
end

function BG.partsDoPlayer(p)
    local lista = {}
    if not p or not p.Character then return lista end
    for _, v in ipairs(p.Character:GetDescendants()) do
        if v:IsA("BasePart") then table.insert(lista, v) end
    end
    return lista
end

function BG.limparPorNome(nome)
    local removidas = 0
    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name == nome and v:IsA("BasePart") then
            pcall(function() v:Destroy() end)
            removidas = removidas + 1
        end
    end
    return removidas
end

-- ============== UTILITÁRIOS GERAIS ==============
function BG.copiarTabela(t)
    if type(t) ~= "table" then return t end
    local c = {}
    for k, v in pairs(t) do
        c[k] = BG.copiarTabela(v)
    end
    return c
end

function BG.formatarTempo(s)
    local h = math.floor(s / 3600)
    local m = math.floor((s % 3600) / 60)
    local seg = math.floor(s % 60)
    if h > 0 then return string.format("%dh %dm %ds", h, m, seg) end
    if m > 0 then return string.format("%dm %ds", m, seg) end
    return seg .. "s"
end

function BG.retry(func, tentativas, delay)
    tentativas = tentativas or 3
    delay = delay or 0.5
    for i = 1, tentativas do
        local ok, res = pcall(func)
        if ok and res then return res end
        if i < tentativas then task.wait(delay) end
    end
    return nil
end

-- =========================================================
-- 10 HELPERS NOVOS
-- =========================================================

-- 1) DEBOUNCE: executa só após N ms sem ser chamado (útil em botões anti-spam)
function BG.debounce(fn, ms)
    ms = ms or 200
    local ultimaChamada = 0
    return function(...)
        local agora = os.clock() * 1000
        if agora - ultimaChamada < ms then return end
        ultimaChamada = agora
        return fn(...)
    end
end

-- 2) THROTTLE: executa no máximo 1x a cada N ms (útil em loops de movimento)
function BG.throttle(fn, ms)
    ms = ms or 100
    local ultimaExecucao = 0
    return function(...)
        local agora = os.clock() * 1000
        if agora - ultimaExecucao >= ms then
            ultimaExecucao = agora
            return fn(...)
        end
    end
end

-- 3) ONCE: executa só a primeira vez que for chamado (útil pra aviso único)
function BG.once(fn)
    local executou = false
    return function(...)
        if executou then return end
        executou = true
        return fn(...)
    end
end

-- 4) RUN EVERY: loop com controle (retorna {stop = fn, isActive = fn})
function BG.runEvery(ms, fn)
    local ativo = true
    local handle = {
        stop = function() ativo = false end,
        isActive = function() return ativo end,
    }
    task.spawn(function()
        while ativo do
            local ok, err = pcall(fn)
            if not ok then
                BG.logErro("runEvery:", err)
                ativo = false
                break
            end
            task.wait(ms / 1000)
        end
    end)
    return handle
end

-- 5) WAIT FOR: espera até condição ser verdadeira (com timeout)
function BG.waitFor(condicao, timeout)
    timeout = timeout or 10
    local inicio = os.clock()
    while os.clock() - inicio < timeout do
        if condicao() then return true end
        task.wait(0.05)
    end
    return false
end

-- 6) CLEANUP: registra instâncias/conexões/funções pra limpar tudo de uma vez
BG.cleanup = {
    _instances = {},
    _connections = {},
    _functions = {},

    addInstance = function(inst)
        table.insert(BG.cleanup._instances, inst)
        return inst
    end,

    addConnection = function(conn)
        table.insert(BG.cleanup._connections, conn)
        return conn
    end,

    addFunction = function(fn)
        table.insert(BG.cleanup._functions, fn)
        return fn
    end,

    clearAll = function()
        for _, inst in ipairs(BG.cleanup._instances) do
            pcall(function()
                if inst and inst.Parent then inst:Destroy() end
            end)
        end
        for _, conn in ipairs(BG.cleanup._connections) do
            pcall(function()
                if conn and conn.Disconnect then conn:Disconnect() end
            end)
        end
        for _, fn in ipairs(BG.cleanup._functions) do
            pcall(fn)
        end
        BG.cleanup._instances = {}
        BG.cleanup._connections = {}
        BG.cleanup._functions = {}
    end,
}

-- 7) TWEEN: one-liner pra tween
function BG.tween(obj, props, tempo, estilo, direcao)
    tempo = tempo or 0.3
    estilo = estilo or Enum.EasingStyle.Quad
    direcao = direcao or Enum.EasingDirection.Out
    local tween = TweenService:Create(obj, TweenInfo.new(tempo, estilo, direcao), props)
    tween:Play()
    return tween
end

-- 8) FORMAT NUMBER: 1500 → "1.5K", 1500000 → "1.5M"
function BG.formatNumber(n)
    n = tonumber(n) or 0
    if n >= 1e9 then return string.format("%.1fB", n / 1e9) end
    if n >= 1e6 then return string.format("%.1fM", n / 1e6) end
    if n >= 1e3 then return string.format("%.1fK", n / 1e3) end
    return tostring(n)
end

-- 9) INSTANTIATE: cria Instance com props em uma linha
function BG.instantiate(className, parent, props)
    local obj = Instance.new(className)
    if props then
        for k, v in pairs(props) do
            pcall(function() obj[k] = v end)
        end
    end
    if parent then obj.Parent = parent end
    return obj
end

-- 10) SAFE CALL: pcall que retorna (sucesso, resultado, erro)
function BG.safeCall(fn, ...)
    local ok, res = pcall(fn, ...)
    if ok then
        return true, res, nil
    end
    BG.logErro("safeCall:", res)
    return false, nil, res
end

print("[Core] Helpers prontos")
