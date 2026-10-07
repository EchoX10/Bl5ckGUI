-- =========================================================
-- MÓDULO 01 - CONFIG + NOTIFICAÇÕES + KEY SYSTEM
-- =========================================================

local BG = _G.BlackGUI
local SoundService = BG.SoundService
local TweenService = BG.TweenService
local CoreGui = BG.CoreGui
local plr = BG.plr

-- ============== CONFIG GLOBAL ==============
BG.TEXTURE_ID = 139385026360175
BG.PART_SIZE = Vector3.new(1.5, 1.5, 0.001)
BG.SPAWN_DELAY = 0.01
BG.TRAP_POSITION = Vector3.new(-11565.53, 12984.85, -5125.60)
BG.TRAP_SIZE = Vector3.new(10, 10, 10)

BG.COMANDOS_RAPIDOS = {
    {nome = "Heal (Curar)", cmd = ";heal"},
    {nome = "Kill (Matar)", cmd = ";kill"},
    {nome = "Jail (Prender)", cmd = ";jail"},
    {nome = "Ice (Congelar)", cmd = ";ice"},
    {nome = "Blur (Desfocar)", cmd = ";blur"},
    {nome = "Warp (Fov)", cmd = ";warp"},
    {nome = "Freeze (Parar)", cmd = ";freeze"},
    {nome = "Dmg (Dano)", cmd = ";dmg"}
}

-- ============== NOTIFICAÇÕES ==============
local NOTIF_CONFIG = {
    sucesso = {icone = "rbxassetid://6353957304", som = "rbxassetid://133071738727579", cor = Color3.fromRGB(35, 140, 60), corBorda = Color3.fromRGB(60, 200, 90), titulo = "SUCESSO"},
    erro = {icone = "rbxassetid://71503984286896", som = "rbxassetid://131661013076677", cor = Color3.fromRGB(160, 40, 40), corBorda = Color3.fromRGB(220, 70, 70), titulo = "ERRO"},
    info = {icone = "rbxassetid://108376802555749", som = "rbxassetid://131390520971848", cor = Color3.fromRGB(40, 80, 160), corBorda = Color3.fromRGB(70, 130, 220), titulo = "AVISO"}
}

local notifGui = Instance.new("ScreenGui")
notifGui.Name = "BlackGUI_Notif"
notifGui.ResetOnSpawn = false
notifGui.IgnoreGuiInset = true
notifGui.DisplayOrder = 999998
notifGui.Parent = CoreGui

local notifContainer = Instance.new("Frame")
notifContainer.Size = UDim2.new(0, 350, 1, -20)
notifContainer.Position = UDim2.new(1, -370, 0, 10)
notifContainer.BackgroundTransparency = 1
notifContainer.Parent = notifGui

local notifLayout = Instance.new("UIListLayout")
notifLayout.Padding = UDim.new(0, 8)
notifLayout.VerticalAlignment = Enum.VerticalAlignment.Top
notifLayout.SortOrder = Enum.SortOrder.LayoutOrder
notifLayout.Parent = notifContainer

local function notificar(tipo, mensagem, duracao)
    tipo = tipo or "info"
    duracao = duracao or 4
    local cfg = NOTIF_CONFIG[tipo] or NOTIF_CONFIG.info

    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(1, 0, 0, 70)
    notif.BackgroundColor3 = cfg.cor
    notif.BorderSizePixel = 0
    notif.BackgroundTransparency = 0.1
    notif.LayoutOrder = os.clock() * 1000
    notif.Parent = notifContainer

    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 10)

    local stroke = Instance.new("UIStroke")
    stroke.Color = cfg.corBorda
    stroke.Thickness = 2
    stroke.Transparency = 0.3
    stroke.Parent = notif

    local icone = Instance.new("ImageLabel")
    icone.Size = UDim2.new(0, 50, 0, 50)
    icone.Position = UDim2.new(0, 10, 0.5, -25)
    icone.BackgroundTransparency = 1
    icone.Image = cfg.icone
    icone.Parent = notif

    local titulo = Instance.new("TextLabel")
    titulo.Size = UDim2.new(1, -75, 0, 20)
    titulo.Position = UDim2.new(0, 70, 0, 10)
    titulo.BackgroundTransparency = 1
    titulo.Text = cfg.titulo
    titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
    titulo.Font = Enum.Font.GothamBold
    titulo.TextSize = 14
    titulo.TextXAlignment = Enum.TextXAlignment.Left
    titulo.Parent = notif

    local msg = Instance.new("TextLabel")
    msg.Size = UDim2.new(1, -75, 0, 35)
    msg.Position = UDim2.new(0, 70, 0, 30)
    msg.BackgroundTransparency = 1
    msg.Text = tostring(mensagem)
    msg.TextColor3 = Color3.fromRGB(230, 230, 230)
    msg.Font = Enum.Font.Gotham
    msg.TextSize = 12
    msg.TextXAlignment = Enum.TextXAlignment.Left
    msg.TextYAlignment = Enum.TextYAlignment.Top
    msg.TextWrapped = true
    msg.Parent = notif

    local barraBg = Instance.new("Frame")
    barraBg.Size = UDim2.new(1, -20, 0, 3)
    barraBg.Position = UDim2.new(0, 10, 1, -8)
    barraBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    barraBg.BackgroundTransparency = 0.5
    barraBg.BorderSizePixel = 0
    barraBg.Parent = notif
    Instance.new("UICorner", barraBg).CornerRadius = UDim.new(0, 2)

    local barra = Instance.new("Frame")
    barra.Size = UDim2.new(1, 0, 1, 0)
    barra.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    barra.BackgroundTransparency = 0.3
    barra.BorderSizePixel = 0
    barra.Parent = barraBg
    Instance.new("UICorner", barra).CornerRadius = UDim.new(0, 2)

    task.spawn(function()
        local som = Instance.new("Sound")
        som.SoundId = cfg.som
        som.Volume = 0.7
        som.PlaybackSpeed = 1.1
        som.Parent = SoundService
        som:Play()
        game:GetService("Debris"):AddItem(som, 3)
    end)

    notif.Position = UDim2.new(1, 0, 0, 0)
    notif.BackgroundTransparency = 1

    TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 0.1
    }):Play()

    TweenService:Create(barra, TweenInfo.new(duracao, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 1, 0)
    }):Play()

    task.spawn(function()
        task.wait(duracao)
        local saida = TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0)
        })
        saida:Play()
        saida.Completed:Wait()
        notif:Destroy()
    end)
end

BG.notifySucesso = function(m, d) notificar("sucesso", m, d) end
BG.notifyErro    = function(m, d) notificar("erro", m, d) end
BG.notifyInfo    = function(m, d) notificar("info", m, d) end

-- ============== KEY SYSTEM ==============
local KEY_FILE = "blackgui_key.txt"
local KEY_EXPIRE_FILE = "blackgui_expire.txt"
local TEMPO_EXPIRACAO = 35 * 60

local function gerarKey()
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local k = ""
    for i = 1, 16 do
        local r = math.random(1, #chars)
        k = k .. chars:sub(r, r)
    end
    return k
end

local function salvarKey(key)
    local ts = os.time() + TEMPO_EXPIRACAO
    pcall(function()
        writefile(KEY_FILE, key)
        writefile(KEY_EXPIRE_FILE, tostring(ts))
    end)
end

local function keyValida()
    local k, e = nil, nil
    pcall(function()
        if isfile(KEY_FILE) then k = readfile(KEY_FILE) end
        if isfile(KEY_EXPIRE_FILE) then e = tonumber(readfile(KEY_EXPIRE_FILE)) end
    end)
    if k and e and os.time() < e then return true, k end
    return false, nil
end

-- Função pra copiar pro clipboard
local function copiarClipboard(texto)
    local metodos = {setclipboard, toclipboard, writeclipboard}
    for _, f in ipairs(metodos) do
        if type(f) == "function" then
            if pcall(f, texto) then return true end
        end
    end
    if syn and syn.write_clipboard then
        if pcall(syn.write_clipboard, texto) then return true end
    end
    for _, nome in ipairs({"setclipboard", "toclipboard", "writeclipboard"}) do
        local f = _G[nome] or (getfenv and getfenv()[nome])
        if type(f) == "function" and pcall(f, texto) then return true end
    end
    return false
end

BG.copiarClipboard = copiarClipboard

-- ============== FRASES DAS MISSÕES ==============
local FRASES_MISSAO = {
    "BL5CK É O MELHOR", "F3X + HDADMIN = PODER", "BL5CK DOMINA TUDO", "MODO TÓXICO ATIVADO",
    "CLONE + ARMA = DESTRUIÇÃO", "ZUMBI INVADE O SERVIDOR", "TOOL HACKER DELETANDO", "METEORITO CAINDO AGORA"
}

local COMPLETAR_MISSAO = {
    {frase = "O comando pra matar é ;___", resposta = "kill"},
    {frase = "O comando pra congelar é ;___", resposta = "ice"},
    {frase = "O nome do criador é ___", resposta = "BL5CK"},
    {frase = "O comando pra esconder GUIs é ;___", resposta = "hideGuis"},
    {frase = "O painel se chama ___", resposta = "BL5CK GUI"},
    {frase = "O comando pra prender é ;___", resposta = "jail"},
    {frase = "O comando pra dar dano é ;___", resposta = "dmg"}
}

local function gerarConta(dif)
    local a, b, op, res
    if dif == 1 then
        a = math.random(1, 10); b = math.random(1, 10); op = "+"; res = a + b
    elseif dif == 2 then
        a = math.random(2, 12); b = math.random(2, 12); op = "x"; res = a * b
    elseif dif == 3 then
        b = math.random(2, 12); res = math.random(2, 12); a = b * res; op = "/"
    elseif dif == 4 then
        a = math.random(2, 5); b = math.random(2, 8); op = "^"; res = a ^ b
    else
        a = math.random(1, 10); b = math.random(1, 10)
        local c = math.random(1, 5)
        return string.format("(%d + %d) x %d", a, b, c), (a + b) * c
    end
    return string.format("%d %s %d", a, op, b), res
end

-- ============== VAR GLOBAL DA KEY ==============
local temKey, keyAtual = keyValida()
BG.keyAtual = keyAtual

-- ============== JANELAS (mostrar key + missões) ==============
local function abrirJanelaMostrarKey(key)
    local gui = Instance.new("ScreenGui")
    gui.Name = "BG_MostrarKey"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 1000001
    gui.Parent = CoreGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 340, 0, 200)
    frame.Position = UDim2.new(0.5, -170, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(40, 180, 70)
    stroke.Thickness = 2
    stroke.Parent = frame

    local tit = Instance.new("TextLabel")
    tit.Size = UDim2.new(1, 0, 0, 40)
    tit.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    tit.Text = "🔑 SUA KEY"
    tit.TextColor3 = Color3.fromRGB(255, 255, 255)
    tit.Font = Enum.Font.GothamBold
    tit.TextSize = 15
    tit.Parent = frame
    Instance.new("UICorner", tit).CornerRadius = UDim.new(0, 12)

    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(1, -40, 0, 50)
    keyBox.Position = UDim2.new(0, 20, 0, 60)
    keyBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    keyBox.BorderSizePixel = 0
    keyBox.Text = key
    keyBox.TextColor3 = Color3.fromRGB(100, 255, 100)
    keyBox.Font = Enum.Font.GothamBold
    keyBox.TextSize = 18
    keyBox.TextEditable = false
    keyBox.ClearTextOnFocus = false
    keyBox.Parent = frame
    Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 8)

    local copiar = Instance.new("TextButton")
    copiar.Size = UDim2.new(1, -40, 0, 45)
    copiar.Position = UDim2.new(0, 20, 0, 120)
    copiar.BackgroundColor3 = Color3.fromRGB(20, 60, 30)
    copiar.Text = "📋 COPIAR KEY"
    copiar.TextColor3 = Color3.fromRGB(255, 255, 255)
    copiar.Font = Enum.Font.GothamBold
    copiar.TextSize = 14
    copiar.Parent = frame
    Instance.new("UICorner", copiar).CornerRadius = UDim.new(0, 8)

    copiar.MouseButton1Click:Connect(function()
        -- Seleciona tudo + copia pro clipboard
        local copiou = copiarClipboard(key)

        -- Também tenta selecionar visualmente o texto
        keyBox:CaptureFocus()
        keyBox.CursorPosition = #key + 1
        keyBox.SelectionStart = 1

        if copiou then
            copiar.Text = "✅ COPIADO!"
            copiar.BackgroundColor3 = Color3.fromRGB(40, 100, 50)
            notifySucesso("Key copiada!")
        else
            copiar.Text = "⚠️ COPIE MANUALMENTE"
            copiar.BackgroundColor3 = Color3.fromRGB(160, 100, 20)
            notifyInfo("Segura no campo e copia manual")
        end
        task.wait(1.5)
        copiar.Text = "📋 COPIAR KEY"
        copiar.BackgroundColor3 = Color3.fromRGB(20, 60, 30)
    end)

    local fechar = Instance.new("TextButton")
    fechar.Size = UDim2.new(0, 25, 0, 25)
    fechar.Position = UDim2.new(1, -28, 0, 3)
    fechar.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    fechar.Text = "X"
    fechar.TextColor3 = Color3.fromRGB(255, 255, 255)
    fechar.Font = Enum.Font.GothamBold
    fechar.TextSize = 12
    fechar.Parent = frame
    Instance.new("UICorner", fechar).CornerRadius = UDim.new(0, 6)
    fechar.MouseButton1Click:Connect(function() gui:Destroy() end)
end

local function abrirJanelaMissoes(key)
    local gui = Instance.new("ScreenGui")
    gui.Name = "BG_Missoes"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 1000000
    gui.Parent = CoreGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 450, 0, 550)
    frame.Position = UDim2.new(0.5, -225, 0.5, -275)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(40, 180, 70)
    stroke.Thickness = 2
    stroke.Parent = frame

    local tit = Instance.new("TextLabel")
    tit.Size = UDim2.new(1, 0, 0, 50)
    tit.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    tit.Text = "🎯 MISSÕES - Complete as 3 pra obter a key"
    tit.TextColor3 = Color3.fromRGB(255, 255, 255)
    tit.Font = Enum.Font.GothamBold
    tit.TextSize = 15
    tit.Parent = frame
    Instance.new("UICorner", tit).CornerRadius = UDim.new(0, 12)

    local progresso = Instance.new("TextLabel")
    progresso.Size = UDim2.new(1, -40, 0, 30)
    progresso.Position = UDim2.new(0, 20, 0, 60)
    progresso.BackgroundTransparency = 1
    progresso.Text = "Progresso: 0/3"
    progresso.TextColor3 = Color3.fromRGB(200, 200, 200)
    progresso.Font = Enum.Font.GothamBold
    progresso.TextSize = 13
    progresso.Parent = frame

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -40, 1, -180)
    scroll.Position = UDim2.new(0, 20, 0, 100)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ScrollingDirection = Enum.ScrollingDirection.Y
    scroll.Parent = frame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 15)
    layout.Parent = scroll

    local completas = 0

    -- ============ MISSÃO 1 ============
    local m1 = Instance.new("Frame")
    m1.Size = UDim2.new(1, -10, 0, 130)
    m1.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    m1.BorderSizePixel = 0
    m1.Parent = scroll
    Instance.new("UICorner", m1).CornerRadius = UDim.new(0, 8)

    local m1t = Instance.new("TextLabel")
    m1t.Size = UDim2.new(1, -20, 0, 30)
    m1t.Position = UDim2.new(0, 10, 0, 5)
    m1t.BackgroundTransparency = 1
    m1t.Text = "🔢 Missão 1: Matemática (5 contas, 4 acertos)"
    m1t.TextColor3 = Color3.fromRGB(255, 255, 255)
    m1t.Font = Enum.Font.GothamBold
    m1t.TextSize = 13
    m1t.TextXAlignment = Enum.TextXAlignment.Left
    m1t.Parent = m1

    local m1b = Instance.new("TextButton")
    m1b.Size = UDim2.new(1, -20, 0, 45)
    m1b.Position = UDim2.new(0, 10, 0, 40)
    m1b.BackgroundColor3 = Color3.fromRGB(50, 30, 80)
    m1b.Text = "INICIAR"
    m1b.TextColor3 = Color3.fromRGB(255, 255, 255)
    m1b.Font = Enum.Font.GothamBold
    m1b.TextSize = 12
    m1b.Parent = m1
    Instance.new("UICorner", m1b).CornerRadius = UDim.new(0, 6)

    m1b.MouseButton1Click:Connect(function()
        local rodada = 1
        local acertos = 0

        local function proxima()
            if rodada > 5 then
                if acertos >= 4 then
                    completas = completas + 1
                    progresso.Text = string.format("Progresso: %d/3", completas)
                    m1b.Text = "✅ COMPLETADA (" .. acertos .. "/5)"
                    m1b.BackgroundColor3 = Color3.fromRGB(20, 60, 30)
                    m1b.Active = false
                    notifySucesso("Missão 1 completa!")
                else
                    m1b.Text = "❌ FALHOU (" .. acertos .. "/5) - TENTE DE NOVO"
                    m1b.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
                    task.wait(2)
                    m1b.Text = "INICIAR"
                    m1b.BackgroundColor3 = Color3.fromRGB(50, 30, 80)
                end
                return
            end

            local conta, resultado = gerarConta(rodada)
            m1b.Text = string.format("%d/5: %s = ? (10s)", rodada, conta)

            local input = Instance.new("TextBox")
            input.Size = UDim2.new(1, -20, 0, 35)
            input.Position = UDim2.new(0, 10, 0, 90)
            input.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            input.PlaceholderText = "Resposta..."
            input.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
            input.Text = ""
            input.TextColor3 = Color3.fromRGB(255, 255, 255)
            input.Font = Enum.Font.GothamBold
            input.TextSize = 13
            input.Parent = m1
            Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)
            input:CaptureFocus()

            local ok = Instance.new("TextButton")
            ok.Size = UDim2.new(0, 80, 0, 35)
            ok.Position = UDim2.new(1, -90, 0, 90)
            ok.BackgroundColor3 = Color3.fromRGB(20, 60, 30)
            ok.Text = "OK"
            ok.TextColor3 = Color3.fromRGB(255, 255, 255)
            ok.Font = Enum.Font.GothamBold
            ok.TextSize = 12
            ok.Parent = m1
            Instance.new("UICorner", ok).CornerRadius = UDim.new(0, 6)

            local feito = false
            local function verif()
                if feito then return end
                feito = true
                if tonumber(input.Text) == resultado then acertos = acertos + 1 end
                input:Destroy(); ok:Destroy()
                rodada = rodada + 1
                task.wait(0.3)
                proxima()
            end

            ok.MouseButton1Click:Connect(verif)
            input.FocusLost:Connect(function(e) if e then verif() end end)
            task.spawn(function()
                task.wait(10)
                if input.Parent then verif() end
            end)
        end
        proxima()
    end)

    -- ============ MISSÃO 2 ============
    local m2 = Instance.new("Frame")
    m2.Size = UDim2.new(1, -10, 0, 130)
    m2.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    m2.BorderSizePixel = 0
    m2.Parent = scroll
    Instance.new("UICorner", m2).CornerRadius = UDim.new(0, 8)

    local m2t = Instance.new("TextLabel")
    m2t.Size = UDim2.new(1, -20, 0, 30)
    m2t.Position = UDim2.new(0, 10, 0, 5)
    m2t.BackgroundTransparency = 1
    m2t.Text = "✏️ Missão 2: Digite a frase (3 frases)"
    m2t.TextColor3 = Color3.fromRGB(255, 255, 255)
    m2t.Font = Enum.Font.GothamBold
    m2t.TextSize = 13
    m2t.TextXAlignment = Enum.TextXAlignment.Left
    m2t.Parent = m2

    local m2b = Instance.new("TextButton")
    m2b.Size = UDim2.new(1, -20, 0, 45)
    m2b.Position = UDim2.new(0, 10, 0, 40)
    m2b.BackgroundColor3 = Color3.fromRGB(50, 30, 80)
    m2b.Text = "INICIAR"
    m2b.TextColor3 = Color3.fromRGB(255, 255, 255)
    m2b.Font = Enum.Font.GothamBold
    m2b.TextSize = 12
    m2b.Parent = m2
    Instance.new("UICorner", m2b).CornerRadius = UDim.new(0, 6)

    m2b.MouseButton1Click:Connect(function()
        local idx = 1
        local acertos = 0
        local function proxima()
            if idx > 3 then
                if acertos >= 2 then
                    completas = completas + 1
                    progresso.Text = string.format("Progresso: %d/3", completas)
                    m2b.Text = "✅ COMPLETADA (" .. acertos .. "/3)"
                    m2b.BackgroundColor3 = Color3.fromRGB(20, 60, 30)
                    m2b.Active = false
                    notifySucesso("Missão 2 completa!")
                else
                    m2b.Text = "❌ FALHOU (" .. acertos .. "/3)"
                    m2b.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
                    task.wait(2)
                    m2b.Text = "INICIAR"
                    m2b.BackgroundColor3 = Color3.fromRGB(50, 30, 80)
                end
                return
            end

            local frase = FRASES_MISSAO[math.random(1, #FRASES_MISSAO)]
            m2b.Text = string.format("%d/3: Digite exato (15s)", idx)

            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -20, 0, 25)
            lbl.Position = UDim2.new(0, 10, 0, 90)
            lbl.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            lbl.Text = frase
            lbl.TextColor3 = Color3.fromRGB(255, 255, 100)
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 11
            lbl.Parent = m2
            Instance.new("UICorner", lbl).CornerRadius = UDim.new(0, 6)

            local input = Instance.new("TextBox")
            input.Size = UDim2.new(1, -20, 0, 30)
            input.Position = UDim2.new(0, 10, 0, 120)
            input.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            input.PlaceholderText = "Digite aqui..."
            input.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
            input.Text = ""
            input.TextColor3 = Color3.fromRGB(255, 255, 255)
            input.Font = Enum.Font.Gotham
            input.TextSize = 12
            input.Parent = m2
            Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)
            input:CaptureFocus()

            local feito = false
            local function verif()
                if feito then return end
                feito = true
                if input.Text == frase then acertos = acertos + 1 end
                lbl:Destroy(); input:Destroy()
                idx = idx + 1
                task.wait(0.3)
                proxima()
            end

            input.FocusLost:Connect(function(e) if e then verif() end end)
            task.spawn(function()
                task.wait(15)
                if input.Parent then verif() end
            end)
        end
        proxima()
    end)

    -- ============ MISSÃO 3 ============
    local m3 = Instance.new("Frame")
    m3.Size = UDim2.new(1, -10, 0, 130)
    m3.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    m3.BorderSizePixel = 0
    m3.Parent = scroll
    Instance.new("UICorner", m3).CornerRadius = UDim.new(0, 8)

    local m3t = Instance.new("TextLabel")
    m3t.Size = UDim2.new(1, -20, 0, 30)
    m3t.Position = UDim2.new(0, 10, 0, 5)
    m3t.BackgroundTransparency = 1
    m3t.Text = "📝 Missão 3: Complete a frase (4 frases)"
    m3t.TextColor3 = Color3.fromRGB(255, 255, 255)
    m3t.Font = Enum.Font.GothamBold
    m3t.TextSize = 13
    m3t.TextXAlignment = Enum.TextXAlignment.Left
    m3t.Parent = m3

    local m3b = Instance.new("TextButton")
    m3b.Size = UDim2.new(1, -20, 0, 45)
    m3b.Position = UDim2.new(0, 10, 0, 40)
    m3b.BackgroundColor3 = Color3.fromRGB(50, 30, 80)
    m3b.Text = "INICIAR"
    m3b.TextColor3 = Color3.fromRGB(255, 255, 255)
    m3b.Font = Enum.Font.GothamBold
    m3b.TextSize = 12
    m3b.Parent = m3
    Instance.new("UICorner", m3b).CornerRadius = UDim.new(0, 6)

    m3b.MouseButton1Click:Connect(function()
        local idx = 1
        local acertos = 0
        local usadas = {}
        local function proxima()
            if idx > 4 then
                if acertos >= 3 then
                    completas = completas + 1
                    progresso.Text = string.format("Progresso: %d/3", completas)
                    m3b.Text = "✅ COMPLETADA (" .. acertos .. "/4)"
                    m3b.BackgroundColor3 = Color3.fromRGB(20, 60, 30)
                    m3b.Active = false
                    notifySucesso("Missão 3 completa!")
                else
                    m3b.Text = "❌ FALHOU (" .. acertos .. "/4)"
                    m3b.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
                    task.wait(2)
                    m3b.Text = "INICIAR"
                    m3b.BackgroundColor3 = Color3.fromRGB(50, 30, 80)
                end
                return
            end

            local i
            repeat i = math.random(1, #COMPLETAR_MISSAO) until not usadas[i]
            usadas[i] = true
            local missao = COMPLETAR_MISSAO[i]

            m3b.Text = string.format("%d/4: Complete (10s)", idx)

            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -20, 0, 25)
            lbl.Position = UDim2.new(0, 10, 0, 90)
            lbl.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            lbl.Text = missao.frase
            lbl.TextColor3 = Color3.fromRGB(255, 255, 100)
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 11
            lbl.Parent = m3
            Instance.new("UICorner", lbl).CornerRadius = UDim.new(0, 6)

            local input = Instance.new("TextBox")
            input.Size = UDim2.new(1, -20, 0, 30)
            input.Position = UDim2.new(0, 10, 0, 120)
            input.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            input.PlaceholderText = "Resposta..."
            input.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
            input.Text = ""
            input.TextColor3 = Color3.fromRGB(255, 255, 255)
            input.Font = Enum.Font.Gotham
            input.TextSize = 12
            input.Parent = m3
            Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)
            input:CaptureFocus()

            local feito = false
            local function verif()
                if feito then return end
                feito = true
                if input.Text:lower() == missao.resposta:lower() then acertos = acertos + 1 end
                lbl:Destroy(); input:Destroy()
                idx = idx + 1
                task.wait(0.3)
                proxima()
            end

            input.FocusLost:Connect(function(e) if e then verif() end end)
            task.spawn(function()
                task.wait(10)
                if input.Parent then verif() end
            end)
        end
        proxima()
    end)

    -- Botão pra mostrar key
    local mostrar = Instance.new("TextButton")
    mostrar.Size = UDim2.new(1, -40, 0, 45)
    mostrar.Position = UDim2.new(0, 20, 1, -60)
    mostrar.BackgroundColor3 = Color3.fromRGB(20, 60, 30)
    mostrar.Text = "🔑 VER KEY"
    mostrar.TextColor3 = Color3.fromRGB(255, 255, 255)
    mostrar.Font = Enum.Font.GothamBold
    mostrar.TextSize = 13
    mostrar.Parent = frame
    Instance.new("UICorner", mostrar).CornerRadius = UDim.new(0, 8)

    mostrar.MouseButton1Click:Connect(function()
        if completas >= 3 then
            abrirJanelaMostrarKey(key)
        else
            notifyErro("Complete as 3 missões primeiro!")
        end
    end)

    local fechar = Instance.new("TextButton")
    fechar.Size = UDim2.new(0, 25, 0, 25)
    fechar.Position = UDim2.new(1, -28, 0, 3)
    fechar.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    fechar.Text = "X"
    fechar.TextColor3 = Color3.fromRGB(255, 255, 255)
    fechar.Font = Enum.Font.GothamBold
    fechar.TextSize = 12
    fechar.Parent = frame
    Instance.new("UICorner", fechar).CornerRadius = UDim.new(0, 6)
    fechar.MouseButton1Click:Connect(function() gui:Destroy() end)
end

-- ============== TELA DE LOGIN ==============
if not temKey then
    keyAtual = gerarKey()
    BG.keyAtual = keyAtual
    salvarKey(keyAtual)
    print("[BlackGUI] Key gerada: " .. keyAtual)

    local loginGui = Instance.new("ScreenGui")
    loginGui.Name = "BlackGUI_Login"
    loginGui.ResetOnSpawn = false
    loginGui.IgnoreGuiInset = true
    loginGui.DisplayOrder = 999999
    loginGui.Parent = CoreGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 420)
    frame.Position = UDim2.new(0.5, -175, 0.5, -210)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BorderSizePixel = 0
    frame.Parent = loginGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(40, 180, 70)
    stroke.Thickness = 2
    stroke.Parent = frame

    local tit = Instance.new("TextLabel")
    tit.Size = UDim2.new(1, 0, 0, 50)
    tit.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    tit.Text = "🔒 BL5CK GUI KEY"
    tit.TextColor3 = Color3.fromRGB(255, 255, 255)
    tit.Font = Enum.Font.GothamBold
    tit.TextSize = 16
    tit.Parent = frame
    Instance.new("UICorner", tit).CornerRadius = UDim.new(0, 12)

    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, -40, 0, 50)
    info.Position = UDim2.new(0, 20, 0, 60)
    info.BackgroundTransparency = 1
    info.Text = "Clique em VER KEY pra copiar a key.\nOu complete as missões."
    info.TextColor3 = Color3.fromRGB(200, 200, 200)
    info.Font = Enum.Font.Gotham
    info.TextSize = 12
    info.TextWrapped = true
    info.Parent = frame

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(1, -40, 0, 40)
    input.Position = UDim2.new(0, 20, 0, 120)
    input.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    input.PlaceholderText = "Cole a key aqui..."
    input.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
    input.Text = ""
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.Font = Enum.Font.GothamBold
    input.TextSize = 14
    input.Parent = frame
    Instance.new("UICorner", input).CornerRadius = UDim.new(0, 8)

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, -40, 0, 25)
    status.Position = UDim2.new(0, 20, 0, 165)
    status.BackgroundTransparency = 1
    status.Text = ""
    status.TextColor3 = Color3.fromRGB(255, 100, 100)
    status.Font = Enum.Font.GothamBold
    status.TextSize = 11
    status.Parent = frame

    -- BOTÃO 1: VALIDAR
    local validar = Instance.new("TextButton")
    validar.Size = UDim2.new(1, -40, 0, 45)
    validar.Position = UDim2.new(0, 20, 0, 195)
    validar.BackgroundColor3 = Color3.fromRGB(20, 60, 30)
    validar.Text = "✅ VALIDAR KEY"
    validar.TextColor3 = Color3.fromRGB(255, 255, 255)
    validar.Font = Enum.Font.GothamBold
    validar.TextSize = 13
    validar.Parent = frame
    Instance.new("UICorner", validar).CornerRadius = UDim.new(0, 8)

    -- BOTÃO 2: VER KEY
    local verKey = Instance.new("TextButton")
    verKey.Size = UDim2.new(1, -40, 0, 45)
    verKey.Position = UDim2.new(0, 20, 0, 250)
    verKey.BackgroundColor3 = Color3.fromRGB(50, 80, 130)
    verKey.Text = "🔑 VER KEY"
    verKey.TextColor3 = Color3.fromRGB(255, 255, 255)
    verKey.Font = Enum.Font.GothamBold
    verKey.TextSize = 13
    verKey.Parent = frame
    Instance.new("UICorner", verKey).CornerRadius = UDim.new(0, 8)

    -- BOTÃO 3: MISSÕES
    local missoes = Instance.new("TextButton")
    missoes.Size = UDim2.new(1, -40, 0, 45)
    missoes.Position = UDim2.new(0, 20, 0, 305)
    missoes.BackgroundColor3 = Color3.fromRGB(50, 30, 80)
    missoes.Text = "🎯 FAZER MISSÕES"
    missoes.TextColor3 = Color3.fromRGB(255, 255, 255)
    missoes.Font = Enum.Font.GothamBold
    missoes.TextSize = 13
    missoes.Parent = frame
    Instance.new("UICorner", missoes).CornerRadius = UDim.new(0, 8)

    local validado = false

    validar.MouseButton1Click:Connect(function()
        if input.Text:upper() == keyAtual then
            status.Text = "✅ Key válida!"
            status.TextColor3 = Color3.fromRGB(100, 255, 100)
            validado = true
            task.wait(0.5)
            loginGui:Destroy()
        else
            status.Text = "❌ Key inválida!"
            status.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)

    verKey.MouseButton1Click:Connect(function()
        abrirJanelaMostrarKey(keyAtual)
    end)

    missoes.MouseButton1Click:Connect(function()
        abrirJanelaMissoes(keyAtual)
    end)

    while not validado do task.wait(0.1) end
end

print("[Config] Notificações + Key system prontos")
