-- =========================================================
-- BLACKGUI LOADER (v2 - com UI de loading)
-- Repo: EchoX10/Bl5ckGUI
-- =========================================================

local GITHUB_USER   = "EchoX10"
local GITHUB_REPO   = "Bl5ckGUI"
local GITHUB_BRANCH = "main"

local PASTA_RAIZ   = "Bl5ckGUI"
local PASTA_MODS   = PASTA_RAIZ .. "/modules"
local PASTA_KEY    = PASTA_RAIZ .. "/key"

local BASE_URL = "https://raw.githubusercontent.com/" .. GITHUB_USER .. "/" .. GITHUB_REPO .. "/" .. GITHUB_BRANCH .. "/modules/"

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

-- title bar
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

-- content
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

-- barra
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

-- drag
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

-- minimizar
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

-- fechar (cancelar tudo)
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
    tween.Completed:Connect(function()
        loadingGui:Destroy()
    end)
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
    if cancelado then
        error("__CANCELADO__")
    end
end

-- =========================================================
-- FILESYSTEM
-- =========================================================
local function existePasta(path)
    return isfolder and isfolder(path) or false
end

local function garantirPasta(path)
    if existePasta(path) then return true end
    local ok = pcall(makefolder, path)
    return ok
end

local function arquivoExiste(path)
    return isfile and isfile(path) or false
end

-- =========================================================
-- PROCESSO PRINCIPAL
-- =========================================================
carregandoTask = task.spawn(function()
    local ok, err = pcall(function()
        -- ETAPA 1: criar pastas
        setStatus("Criando estrutura de pastas...", "Bl5ckGUI/modules, Bl5ckGUI/key")
        setProgresso(0.02)
        task.wait(0.15)

        if not garantirPasta(PASTA_RAIZ) then
            setStatus("Erro: nao consegui criar pasta " .. PASTA_RAIZ, "Verifique permissoes do executor")
            return
        end
        setProgresso(0.04)
        task.wait(0.1)

        if not garantirPasta(PASTA_MODS) then
            setStatus("Erro: nao consegui criar " .. PASTA_MODS, "")
            return
        end
        setProgresso(0.06)
        task.wait(0.1)

        if not garantirPasta(PASTA_KEY) then
            setStatus("Erro: nao consegui criar " .. PASTA_KEY, "")
            return
        end
        setProgresso(0.08)
        task.wait(0.15)
        abortarSeCancelado()

        -- ETAPA 2: baixar/atualizar módulos
        setStatus("Verificando modulos...", "Cache local em " .. PASTA_MODS)
        task.wait(0.15)
        abortarSeCancelado()

        local total = #MODULOS
        local baixados = 0

        for i, arquivo in ipairs(MODULOS) do
            abortarSeCancelado()

            local caminhoLocal = PASTA_MODS .. "/" .. arquivo
            local progressoBase = 0.1 + ((i - 1) / total) * 0.75

            setStatus("Baixando modulo " .. i .. "/" .. total, arquivo)
            setProgresso(progressoBase)
            task.wait(0.05)
            abortarSeCancelado()

            local url = BASE_URL .. arquivo
            local okHttp, src = pcall(game.HttpGet, game, url, true)

            if not okHttp or not src or #src < 50 then
                setStatus("Falha ao baixar " .. arquivo, "Verifique conexao com GitHub")
                task.wait(2)
                abortarSeCancelado()
                -- segue mesmo com falha, mas registra
                local okFile, srcFile = pcall(readfile, caminhoLocal)
                if not (okFile and srcFile) then
                    error("Falha ao obter " .. arquivo)
                end
            else
                local okWrite = pcall(writefile, caminhoLocal, src)
                if okWrite then
                    baixados = baixados + 1
                else
                    -- se writefile falhou, tenta ler do disco depois
                    warn("[Loader] writefile falhou pra " .. arquivo .. ", vai tentar ler local")
                end
            end

            setProgresso(progressoBase + 0.75 / total)
            task.wait(0.03)
        end

        setStatus("Modulos prontos", baixados .. "/" .. total .. " baixados e salvos no disco")
        setProgresso(0.88)
        task.wait(0.3)
        abortarSeCancelado()

        -- ETAPA 3: verificar/criar arquivos de key
        setStatus("Preparando key system...", "Bl5ckGUI/key")
        setProgresso(0.9)
        task.wait(0.2)
        abortarSeCancelado()

        local keyFile = PASTA_KEY .. "/blackgui_key.txt"
        local expireFile = PASTA_KEY .. "/blackgui_expire.txt"

        if not arquivoExiste(keyFile) then
            pcall(writefile, keyFile, "")
        end
        setProgresso(0.93)
        task.wait(0.1)

        if not arquivoExiste(expireFile) then
            pcall(writefile, expireFile, "0")
        end
        setProgresso(0.96)
        task.wait(0.2)
        abortarSeCancelado()

        -- ETAPA 4: carregar módulos do disco
        setStatus("Carregando modulos do disco...", "")
        task.wait(0.15)
        setProgresso(0.98)
        abortarSeCancelado()

        for i, arquivo in ipairs(MODULOS) do
            abortarSeCancelado()
            local caminhoLocal = PASTA_MODS .. "/" .. arquivo
            setStatus("Carregando " .. i .. "/" .. #MODULOS, arquivo)

            local okRead, src = pcall(readfile, caminhoLocal)
            if not okRead or not src then
                setStatus("Erro lendo " .. arquivo, "Arquivo corrompido no disco")
                task.wait(2)
                abortarSeCancelado()
                error("Nao consegui ler " .. caminhoLocal)
            end

            local fn, err = loadstring(src, "Bl5ckGUI::" .. arquivo)
            if not fn then
                setStatus("Sintaxe errada em " .. arquivo, tostring(err))
                task.wait(3)
                abortarSeCancelado()
                error("Sintaxe errada: " .. tostring(err))
            end

            local okRun, errRun = pcall(fn)
            if not okRun then
                setStatus("Erro em " .. arquivo, tostring(errRun))
                task.wait(3)
                abortarSeCancelado()
                error("Runtime: " .. tostring(errRun))
            end

            task.wait(0.05)
        end

        -- ETAPA 5: 100%
        setProgresso(1)
        setStatus("BL5CK GUI pronta!", "Carregando painel...")
        task.wait(0.4)
        abortarSeCancelado()

        -- ETAPA 6: animação final
        -- gira + diminui + some
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
        -- se deu erro, deixa o painel por 3s mostrando o erro
        task.wait(3)
        if loadingGui and loadingGui.Parent then
            local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            })
            tween:Play()
            tween.Completed:Connect(function()
                loadingGui:Destroy()
            end)
        end
    end
end)
