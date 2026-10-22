-- =========================================================
-- BLACKGUI LOADER (v4 - UserModules com tracking automático)
-- Repo: EchoX10/Bl5ckGUI
-- =========================================================

local GITHUB_USER   = "EchoX10"
local GITHUB_REPO   = "Bl5ckGUI"
local GITHUB_BRANCH = "main"

local PASTA_RAIZ     = "Bl5ckGUI"
local PASTA_MODS     = PASTA_RAIZ .. "/modules"
local PASTA_KEY      = PASTA_RAIZ .. "/key"
local PASTA_USER     = PASTA_RAIZ .. "/UserModules"
local PASTA_USERFUNC = PASTA_RAIZ .. "/UserModulesFunctions"
local ARQ_NAMES      = PASTA_USERFUNC .. "/FunctionNames.json"
local ARQ_CODES      = PASTA_USERFUNC .. "/FunctionCodes.json"

local BASE_URL = "https://raw.githubusercontent.com/" .. GITHUB_USER .. "/" .. GITHUB_REPO .. "/" .. GITHUB_BRANCH .. "/modules/"

local HttpService = game:GetService("HttpService")

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

-- =========================================================
-- UI DE LOADING
-- =========================================================
local TweenService = BG.TweenService
local CoreGui = BG.CoreGui

local cancelado = false
local carregandoTask = nil

local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "BG_Loading"
loadingGui.ResetOnSpawn = false
loadingGui.IgnoreGuiInset = true
loadingGui.DisplayOrder = 9999999
loadingGui.Parent = CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 180)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -90)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = loadingGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(40, 180, 70)
stroke.Thickness = 2
stroke.Parent = mainFrame

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 36)
titleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 14)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -80, 1, 0)
titleLabel.Position = UDim2.new(0, 14, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "BL5CK GUI · Carregando"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 13
titleLabel.Parent = titleBar

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 28, 0, 26)
minBtn.Position = UDim2.new(1, -64, 0, 5)
minBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 14
minBtn.Parent = titleBar
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 26)
closeBtn.Position = UDim2.new(1, -32, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(140, 30, 30)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 12
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -28, 1, -50)
contentFrame.Position = UDim2.new(0, 14, 0, 44)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 26)
statusLabel.Position = UDim2.new(0, 0, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Iniciando..."
statusLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 13
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.TextWrapped = true
statusLabel.Parent = contentFrame

local subLabel = Instance.new("TextLabel")
subLabel.Size = UDim2.new(1, 0, 0, 18)
subLabel.Position = UDim2.new(0, 0, 0, 28)
subLabel.BackgroundTransparency = 1
subLabel.Text = ""
subLabel.TextColor3 = Color3.fromRGB(130, 130, 130)
subLabel.Font = Enum.Font.Gotham
subLabel.TextSize = 11
subLabel.TextXAlignment = Enum.TextXAlignment.Left
subLabel.TextWrapped = true
subLabel.Parent = contentFrame

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(1, 0, 0, 10)
barBg.Position = UDim2.new(0, 0, 1, -18)
barBg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
barBg.BorderSizePixel = 0
barBg.Parent = contentFrame
Instance.new("UICorner", barBg).CornerRadius = UDim.new(0, 5)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(40, 180, 70)
barFill.BorderSizePixel = 0
barFill.Parent = barBg
Instance.new("UICorner", barFill).CornerRadius = UDim.new(0, 5)

local percentLabel = Instance.new("TextLabel")
percentLabel.Size = UDim2.new(0, 40, 0, 14)
percentLabel.Position = UDim2.new(1, -40, 1, -36)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.TextColor3 = Color3.fromRGB(40, 180, 70)
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextSize = 11
percentLabel.Parent = contentFrame

local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)
titleBar.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local minimizado = false
local tamanhoOriginal = UDim2.new(0, 400, 0, 180)
minBtn.MouseButton1Click:Connect(function()
    minimizado = not minimizado
    if minimizado then
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 400, 0, 36)}):Play()
        contentFrame.Visible = false
        minBtn.Text = "+"
    else
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = tamanhoOriginal}):Play()
        contentFrame.Visible = true
        minBtn.Text = "—"
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    cancelado = true
    if carregandoTask then
        pcall(function() task.cancel(carregandoTask) end)
    end
    local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    tween:Play()
    tween.Completed:Connect(function() loadingGui:Destroy() end)
end)

-- =========================================================
-- HELPERS
-- =========================================================
local function setStatus(texto, sub)
    if cancelado then return end
    statusLabel.Text = texto
    if sub then subLabel.Text = sub end
end

local function setProgresso(fracao)
    if cancelado then return end
    fracao = math.clamp(fracao, 0, 1)
    barFill.Size = UDim2.new(fracao, 0, 1, 0)
    percentLabel.Text = math.floor(fracao * 100) .. "%"
end

local function abortarSeCancelado()
    if cancelado then error("__CANCELADO__") end
end

-- =========================================================
-- FILESYSTEM
-- =========================================================
local function pastaExiste(path)
    if isfolder then
        local ok, res = pcall(isfolder, path)
        return ok and res
    end
    return false
end

local function garantirPasta(path)
    if pastaExiste(path) then return true end
    local ok = pcall(makefolder, path)
    return ok
end

local function arqExiste(path)
    if isfile then
        local ok, res = pcall(isfile, path)
        return ok and res
    end
    return false
end

local function lerArquivo(path)
    local ok, c = pcall(readfile, path)
    if ok then return c end
    return nil
end

local function escreverArquivo(path, c)
    local ok = pcall(writefile, path, c)
    return ok
end

local function lerJSON(path)
    if not arqExiste(path) then return {} end
    local c = lerArquivo(path)
    if not c or c == "" then return {} end
    local ok, t = pcall(function() return HttpService:JSONDecode(c) end)
    if ok and type(t) == "table" then return t end
    return {}
end

local function salvarJSON(path, tabela)
    local ok, enc = pcall(function() return HttpService:JSONEncode(tabela) end)
    if ok and enc then escreverArquivo(path, enc) end
end

-- =========================================================
-- HASH DE CÓDIGO (pra comparar função antiga vs nova)
-- =========================================================
local function hashString(str)
    if not str then return "0" end
    local h = 5381
    for i = 1, #str do
        h = ((h * 33) + str:byte(i)) % 4294967296
    end
    return tostring(h)
end

-- serializa uma função pra hash (usando debug.getinfo quando disponível)
local function hashFuncao(fn)
    if type(fn) == "function" then
        local ok, info = pcall(function() return debug.getinfo(fn) end)
        if ok and info then
            return hashString(tostring(info.source) .. tostring(info.linedefined) .. tostring(info.lastlinedefined))
        end
        return hashString(tostring(fn))
    end
    if type(fn) == "table" or type(fn) == "userdata" then
        return hashString(tostring(fn))
    end
    return hashString(tostring(fn))
end

-- =========================================================
-- TRACKING: registry em memória
-- =========================================================
-- BG._userRegistry = { [arquivo] = { funcs = {nome:hash}, conns = {id:hash} } }
BG._userRegistry = BG._userRegistry or {}

-- =========================================================
-- LIMPAR tudo que um UserModule adicionou
-- =========================================================
local function limparUserModule(nomeArquivo)
    local nomes = lerJSON(ARQ_NAMES)
    local codigos = lerJSON(ARQ_CODES)

    local dadosNomes = nomes[nomeArquivo] or {}
    local dadosCodigos = codigos[nomeArquivo] or {}

    -- remove funções de BG
    if dadosNomes.funcs then
        for _, nomeFunc in ipairs(dadosNomes.funcs) do
            pcall(function() BG[nomeFunc] = nil end)
        end
    end

    -- desconecta conns
    if BG._userConns and BG._userConns[nomeArquivo] then
        for _, conn in ipairs(BG._userConns[nomeArquivo]) do
            pcall(function()
                if conn and conn.Disconnect then conn:Disconnect() end
            end)
        end
        BG._userConns[nomeArquivo] = nil
    end

    -- destroy GUIs registradas
    if BG._userGuis and BG._userGuis[nomeArquivo] then
        for _, gui in ipairs(BG._userGuis[nomeArquivo]) do
            pcall(function()
                if gui and gui.Parent then gui:Destroy() end
            end)
        end
        BG._userGuis[nomeArquivo] = nil
    end

    -- limpa entradas do arquivo nos JSONs
    nomes[nomeArquivo] = nil
    codigos[nomeArquivo] = nil
    salvarJSON(ARQ_NAMES, nomes)
    salvarJSON(ARQ_CODES, codigos)
end

-- =========================================================
-- CARREGA UserModule com PROXY que intercepta BG.xxx = ...
-- =========================================================
local function carregarUserModule(caminho)
    local src = lerArquivo(caminho)
    if not src or #src < 5 then return false end

    local nomeArquivo = caminho:match("([^/\\]+)$") or caminho

    -- limpa antes (evita duplicar)
    limparUserModule(nomeArquivo)

    -- prepara registro
    BG._userConns = BG._userConns or {}
    BG._userGuis = BG._userGuis or {}
    BG._userConns[nomeArquivo] = {}
    BG._userGuis[nomeArquivo] = {}

    local nomesRegistrados = { funcs = {}, conns = {} }
    local codigosRegistrados = { funcs = {}, conns = {} }

    -- Proxy de BG que intercepta escritas
    local proxyBG = setmetatable({}, {
        __index = function(_, k) return BG[k] end,
        __newindex = function(_, k, v)
            -- se é uma função nova, registra
            if type(v) == "function" then
                table.insert(nomesRegistrados.funcs, k)
                codigosRegistrados.funcs[k] = hashFuncao(v)
            end
            BG[k] = v
        end,
    })

    -- trackers expostos pro script
    local function trackGui(gui)
        if gui then table.insert(BG._userGuis[nomeArquivo], gui) end
        return gui
    end

    local function trackConn(conn)
        if conn then
            local id = "conn_" .. tostring(#BG._userConns[nomeArquivo] + 1)
            table.insert(BG._userConns[nomeArquivo], conn)
            table.insert(nomesRegistrados.conns, id)
            codigosRegistrados.conns[id] = hashFuncao(conn)
        end
        return conn
    end

    local function trackFunc(nome)
        if nome then
            table.insert(nomesRegistrados.funcs, nome)
            codigosRegistrados.funcs[nome] = hashFuncao(BG[nome])
        end
    end

    -- ambiente isolado
    local env = setmetatable({
        BG = proxyBG,
        game = game,
        workspace = workspace,
        script = script,
        Instance = Instance,
        Vector3 = Vector3,
        Vector2 = Vector2,
        CFrame = CFrame,
        Color3 = Color3,
        UDim = UDim,
        UDim2 = UDim2,
        Enum = Enum,
        TweenInfo = TweenInfo,
        Ray = Ray,
        RaycastParams = RaycastParams,
        OverlapParams = OverlapParams,
        PhysicalProperties = PhysicalProperties,
        NumberRange = NumberRange,
        NumberSequence = NumberSequence,
        ColorSequence = ColorSequence,
        BrickColor = BrickColor,
        Rect = Rect,
        Region3 = Region3,
        Faces = Faces,
        Axes = Axes,
        task = task,
        wait = wait,
        spawn = spawn,
        delay = delay,
        tick = tick,
        time = time,
        os = os,
        math = math,
        string = string,
        table = table,
        pcall = pcall,
        xpcall = xpcall,
        error = error,
        assert = assert,
        type = type,
        typeof = typeof,
        tostring = tostring,
        tonumber = tonumber,
        pairs = pairs,
        ipairs = ipairs,
        next = next,
        select = select,
        unpack = unpack,
        rawget = rawget,
        rawset = rawset,
        rawequal = rawequal,
        setmetatable = setmetatable,
        getmetatable = getmetatable,
        print = print,
        warn = warn,
        -- trackers
        trackGui = trackGui,
        trackConn = trackConn,
        trackFunc = trackFunc,
    }, { __index = _G })

    if setfenv then
        local fn, err = loadstring(src, "UserModule::" .. nomeArquivo)
        if not fn then
            warn("[UserModule] Sintaxe errada em " .. nomeArquivo .. ": " .. tostring(err))
            return false
        end
        setfenv(fn, env)
        local ok, errRun = pcall(fn)
        if not ok then
            warn("[UserModule] Runtime em " .. nomeArquivo .. ": " .. tostring(errRun))
        end
    else
        -- executor sem setfenv: roda normal (sem sandbox)
        local fn, err = loadstring(src, "UserModule::" .. nomeArquivo)
        if not fn then
            warn("[UserModule] Sintaxe errada em " .. nomeArquivo .. ": " .. tostring(err))
            return false
        end
        local ok, errRun = pcall(fn)
        if not ok then
            warn("[UserModule] Runtime em " .. nomeArquivo .. ": " .. tostring(errRun))
        end
    end

    -- salva no JSON
    local nomes = lerJSON(ARQ_NAMES)
    local codigos = lerJSON(ARQ_CODES)
    nomes[nomeArquivo] = nomesRegistrados
    codigos[nomeArquivo] = codigosRegistrados
    salvarJSON(ARQ_NAMES, nomes)
    salvarJSON(ARQ_CODES, codigos)

    return true
end

-- =========================================================
-- PROCESSO PRINCIPAL
-- =========================================================
carregandoTask = task.spawn(function()
    local ok, err = pcall(function()
        -- ETAPA 1: criar pastas
        setStatus("Verificando estrutura...", "")
        setProgresso(0.02)
        task.wait(0.1)
        abortarSeCancelado()

        for _, pasta in ipairs({PASTA_RAIZ, PASTA_MODS, PASTA_KEY, PASTA_USER, PASTA_USERFUNC}) do
            if not pastaExiste(pasta) then
                setStatus("Criando " .. pasta .. "/", "")
                garantirPasta(pasta)
                task.wait(0.1)
            end
            abortarSeCancelado()
        end
        setProgresso(0.08)
        task.wait(0.15)

        -- inicializa JSONs se não existem
        if not arqExiste(ARQ_NAMES) then
            escreverArquivo(ARQ_NAMES, "{}")
        end
        if not arqExiste(ARQ_CODES) then
            escreverArquivo(ARQ_CODES, "{}")
        end
        setProgresso(0.1)

        -- ETAPA 2: baixar módulos faltando
        local faltando = {}
        for _, arquivo in ipairs(MODULOS) do
            if not arqExiste(PASTA_MODS .. "/" .. arquivo) then
                table.insert(faltando, arquivo)
            end
        end

        if #faltando == 0 then
            setStatus("Modulos em cache", "")
            setProgresso(0.5)
            task.wait(0.1)
        else
            setStatus("Baixando " .. #faltando .. " modulos...", "")
            for i, arquivo in ipairs(faltando) do
                abortarSeCancelado()
                setStatus("Baixando " .. i .. "/" .. #faltando, arquivo)
                setProgresso(0.1 + (i / #faltando) * 0.4)
                local url = BASE_URL .. arquivo
                local okHttp, src = pcall(game.HttpGet, game, url, true)
                if okHttp and src and #src > 50 then
                    escreverArquivo(PASTA_MODS .. "/" .. arquivo, src)
                end
                task.wait(0.05)
            end
        end
        setProgresso(0.5)
        abortarSeCancelado()

        -- ETAPA 3: key system
        setStatus("Verificando key system...", "")
        setProgresso(0.52)
        task.wait(0.1)
        local keyFile = PASTA_KEY .. "/blackgui_key.txt"
        local expireFile = PASTA_KEY .. "/blackgui_expire.txt"
        if not arqExiste(keyFile) then escreverArquivo(keyFile, "") end
        if not arqExiste(expireFile) then escreverArquivo(expireFile, "0") end
        setProgresso(0.56)
        abortarSeCancelado()

        -- ETAPA 4: carregar módulos base
        setStatus("Carregando módulos base...", "")
        for i, arquivo in ipairs(MODULOS) do
            abortarSeCancelado()
            setStatus("Carregando " .. i .. "/" .. #MODULOS, arquivo)
            setProgresso(0.56 + (i / #MODULOS) * 0.34)

            local caminhoLocal = PASTA_MODS .. "/" .. arquivo
            if arqExiste(caminhoLocal) then
                local src = lerArquivo(caminhoLocal)
                if src then
                    local fn, errSyntax = loadstring(src, "Bl5ckGUI::" .. arquivo)
                    if fn then
                        local okRun, errRun = pcall(fn)
                        if not okRun then
                            setStatus("Erro em " .. arquivo, tostring(errRun))
                            task.wait(2)
                            abortarSeCancelado()
                        end
                    else
                        setStatus("Sintaxe em " .. arquivo, tostring(errSyntax))
                        task.wait(2)
                        abortarSeCancelado()
                    end
                end
            end
            task.wait(0.03)
        end
        setProgresso(0.9)
        abortarSeCancelado()

        -- ETAPA 5: UserModules — detecta removidos e limpa
        setStatus("Verificando UserModules...", "")
        setProgresso(0.91)
        task.wait(0.1)

        local arquivosNoDisco = {}
        if listfiles then
            local okL, lista = pcall(listfiles, PASTA_USER)
            if okL and lista then
                for _, caminho in ipairs(lista) do
                    local nome = caminho:match("([^/\\]+)$")
                    if nome then
                        arquivosNoDisco[nome] = caminho
                    end
                end
            end
        end

        -- 5a: arquivos que estão no JSON mas não no disco → remove
        local nomesRegistrados = lerJSON(ARQ_NAMES)
        for nomeAntigo, _ in pairs(nomesRegistrados) do
            if not arquivosNoDisco[nomeAntigo] then
                setStatus("Removendo UserModule deletado", nomeAntigo)
                limparUserModule(nomeAntigo)
                task.wait(0.1)
                abortarSeCancelado()
            end
        end

        -- 5b: carrega os que existem
        local listaArquivos = {}
        for nome, caminho in pairs(arquivosNoDisco) do
            table.insert(listaArquivos, {nome = nome, caminho = caminho})
        end

        for i, arq in ipairs(listaArquivos) do
            abortarSeCancelado()
            setStatus("Carregando UserModule " .. i .. "/" .. #listaArquivos, arq.nome)
            setProgresso(0.91 + (i / math.max(1, #listaArquivos)) * 0.07)
            carregarUserModule(arq.caminho)
            task.wait(0.05)
        end

        setProgresso(0.98)
        task.wait(0.15)
        abortarSeCancelado()

        -- ETAPA 6: animação final
        setProgresso(1)
        setStatus("BL5CK GUI pronta!", "")
        task.wait(0.4)

        local gira = TweenService:Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Rotation = 360,
        })
        gira:Play()
        gira.Completed:Wait()
        loadingGui:Destroy()
    end)

        if not ok and not cancelado then
        warn("[Loader] Erro: " .. tostring(err))
        task.wait(3)
        if loadingGui and loadingGui.Parent then
            loadingGui:Destroy()
        end
    end
end)

-- =========================================================
-- AUTO-EXECUTE (queue_on_teleport)
-- =========================================================
local AUTOEXEC_FLAG = "Bl5ckGUI/autoexec.flag"
local AUTOEXEC_SCRIPT = "Bl5ckGUI/loader_autoload.lua"

local function salvarLoaderParaAutoexec()
    -- baixa o loader atualizado do GitHub e salva no disco
    local ok, src = pcall(game.HttpGet, game, "https://raw.githubusercontent.com/" .. GITHUB_USER .. "/" .. GITHUB_REPO .. "/" .. GITHUB_BRANCH .. "/Loader.lua", true)
    if ok and src and #src > 500 then
        escreverArquivo(AUTOEXEC_SCRIPT, src)
        escreverArquivo(AUTOEXEC_FLAG, "1")
        return true
    end
    return false
end

local function registrarAutoexec()
    local queueFn = nil
    if type(queue_on_teleport) == "function" then
        queueFn = queue_on_teleport
    elseif syn and type(syn.queue_on_teleport) == "function" then
        queueFn = syn.queue_on_teleport
    elseif fluxus and type(fluxus.queue_on_teleport) == "function" then
        queueFn = fluxus.queue_on_teleport
    end

    if not queueFn then
        return false
    end

    local autoexecSrc = [[
        pcall(function()
            if isfile and isfile("Bl5ckGUI/autoexec.flag") then
                if isfile("Bl5ckGUI/loader_autoload.lua") then
                    local src = readfile("Bl5ckGUI/loader_autoload.lua")
                    loadstring(src)()
                end
            end
        end)
    ]]

    pcall(queueFn, autoexecSrc)
    return true
end

task.spawn(function()
    task.wait(3)
    if not salvarLoaderParaAutoexec() then
        warn("[AutoExec] Não consegui baixar o loader para autoexec")
        return
    end
    if registrarAutoexec() then
        print("[AutoExec] Ativado via queue_on_teleport")
    else
        print("[AutoExec] Executor sem queue_on_teleport")
    end
end)
