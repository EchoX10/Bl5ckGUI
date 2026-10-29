-- =========================================================
-- MÓDULO 07 - KEY SYSTEM + LOGIN
-- =========================================================

local BG = _G.BlackGUI
local CoreGui = BG.CoreGui
local TweenService = BG.TweenService
local notifySucesso = BG.notifySucesso
local notifyErro = BG.notifyErro
local notifyInfo = BG.notifyInfo

local KEY_FILE = "Bl5ckGUI/key/blackgui_key.txt"
local KEY_EXPIRE_FILE = "Bl5ckGUI/key/blackgui_expire.txt"
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

-- ============== JANELA MOSTRAR KEY ==============
local function abrirJanelaMostrarKey(key)
    local gui = Instance.new("ScreenGui")
    gui.Name = "BG_MostrarKey"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 1000001
    gui.Parent = CoreGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 160)
    frame.Position = UDim2.new(0.5, -150, 0.5, -80)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(40, 180, 70)
    stroke.Thickness = 2
    stroke.Parent = frame

    local tit = Instance.new("TextLabel")
    tit.Size = UDim2.new(1, 0, 0, 35)
    tit.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    tit.Text = "SUA KEY"
    tit.TextColor3 = Color3.fromRGB(255, 255, 255)
    tit.Font = Enum.Font.GothamBold
    tit.TextSize = 14
    tit.Parent = frame
    Instance.new("UICorner", tit).CornerRadius = UDim.new(0, 12)

    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(1, -30, 0, 40)
    keyBox.Position = UDim2.new(0, 15, 0, 45)
    keyBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    keyBox.BorderSizePixel = 0
    keyBox.Text = key
    keyBox.TextColor3 = Color3.fromRGB(100, 255, 100)
    keyBox.Font = Enum.Font.GothamBold
    keyBox.TextSize = 16
    keyBox.TextEditable = false
    keyBox.ClearTextOnFocus = false
    keyBox.Parent = frame
    Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 8)

    local copiar = Instance.new("TextButton")
    copiar.Size = UDim2.new(1, -30, 0, 40)
    copiar.Position = UDim2.new(0, 15, 0, 95)
    copiar.BackgroundColor3 = Color3.fromRGB(20, 60, 30)
    copiar.Text = "COPIAR KEY"
    copiar.TextColor3 = Color3.fromRGB(255, 255, 255)
    copiar.Font = Enum.Font.GothamBold
    copiar.TextSize = 13
    copiar.Parent = frame
    Instance.new("UICorner", copiar).CornerRadius = UDim.new(0, 8)

    copiar.MouseButton1Click:Connect(function()
        local copiou = copiarClipboard(key)
        keyBox:CaptureFocus()
        keyBox.CursorPosition = #key + 1
        keyBox.SelectionStart = 1

        if copiou then
            copiar.Text = "COPIADO!"
            copiar.BackgroundColor3 = Color3.fromRGB(40, 100, 50)
            notifySucesso("Key copiada!")
        else
            copiar.Text = "COPIE MANUALMENTE"
            copiar.BackgroundColor3 = Color3.fromRGB(160, 100, 20)
            notifyInfo("Segura no campo e copia manual")
        end
        task.wait(1.5)
        copiar.Text = "COPIAR KEY"
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

-- ============== JANELA MISSÕES ==============
local function abrirJanelaMissoes(key)
    local gui = Instance.new("ScreenGui")
    gui.Name = "BG_Missoes"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 1000000
    gui.Parent = CoreGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 420)
    frame.Position = UDim2.new(0.5, -200, 0.5, -210)
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
    tit.Text = "MISSOES - Complete as 3"
    tit.TextColor3 = Color3.fromRGB(255, 255, 255)
    tit.Font = Enum.Font.GothamBold
    tit.TextSize = 14
    tit.Parent = frame
    Instance.new("UICorner", tit).CornerRadius = UDim.new(0, 12)

    local progresso = Instance.new("TextLabel")
    progresso.Size = UDim2.new(1, -40, 0, 25)
    progresso.Position = UDim2.new(0, 20, 0, 45)
    progresso.BackgroundTransparency = 1
    progresso.Text = "Progresso: 0/3"
    progresso.TextColor3 = Color3.fromRGB(200, 200, 200)
    progresso.Font = Enum.Font.GothamBold
    progresso.TextSize = 12
    progresso.Parent = frame

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -30, 1, -85)
    scroll.Position = UDim2.new(0, 15, 0, 75)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ScrollingDirection = Enum.ScrollingDirection.Y
    scroll.Parent = frame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.Parent = scroll

    local completas = 0

    -- MISSAO 1
    local m1 = Instance.new("Frame")
    m1.Size = UDim2.new(1, -10, 0, 110)
    m1.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    m1.BorderSizePixel = 0
    m1.Parent = scroll
    Instance.new("UICorner", m1).CornerRadius = UDim.new(0, 8)

    local m1t = Instance.new("TextLabel")
    m1t.Size = UDim2.new(1, -20, 0, 25)
    m1t.Position = UDim2.new(0, 10, 0, 5)
    m1t.BackgroundTransparency = 1
    m1t.Text = "Missao 1: Matematica (5 contas)"
    m1t.TextColor3 = Color3.fromRGB(255, 255, 255)
    m1t.Font = Enum.Font.GothamBold
    m1t.TextSize = 12
    m1t.TextXAlignment = Enum.TextXAlignment.Left
    m1t.Parent = m1

    local m1b = Instance.new("TextButton")
    m1b.Size = UDim2.new(1, -20, 0, 38)
    m1b.Position = UDim2.new(0, 10, 0, 35)
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
                    m1b.Text = "COMPLETADA (" .. acertos .. "/5)"
                    m1b.BackgroundColor3 = Color3.fromRGB(20, 60, 30)
                    m1b.Active = false
                    notifySucesso("Missao 1 completa!")
                else
                    m1b.Text = "FALHOU (" .. acertos .. "/5) - TENTE DE NOVO"
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
            input.Size = UDim2.new(1, -110, 0, 32)
            input.Position = UDim2.new(0, 10, 0, 75)
            input.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            input.PlaceholderText = "Resposta..."
            input.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
            input.Text = ""
            input.TextColor3 = Color3.fromRGB(255, 255, 255)
            input.Font = Enum.Font.GothamBold
            input.TextSize = 12
            input.Parent = m1
            Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)
            input:CaptureFocus()

            local ok = Instance.new("TextButton")
            ok.Size = UDim2.new(0, 80, 0, 32)
            ok.Position = UDim2.new(1, -90, 0, 75)
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

    -- MISSAO 2
    local m2 = Instance.new("Frame")
    m2.Size = UDim2.new(1, -10, 0, 110)
    m2.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    m2.BorderSizePixel = 0
    m2.Parent = scroll
    Instance.new("UICorner", m2).CornerRadius = UDim.new(0, 8)

    local m2t = Instance.new("TextLabel")
    m2t.Size = UDim2.new(1, -20, 0, 25)
    m2t.Position = UDim2.new(0, 10, 0, 5)
    m2t.BackgroundTransparency = 1
    m2t.Text = "Missao 2: Digite a frase (3 frases)"
    m2t.TextColor3 = Color3.fromRGB(255, 255, 255)
    m2t.Font = Enum.Font.GothamBold
    m2t.TextSize = 12
    m2t.TextXAlignment = Enum.TextXAlignment.Left
    m2t.Parent = m2

    local m2b = Instance.new("TextButton")
    m2b.Size = UDim2.new(1, -20, 0, 38)
    m2b.Position = UDim2.new(0, 10, 0, 35)
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
                    m2b.Text = "COMPLETADA (" .. acertos .. "/3)"
                    m2b.BackgroundColor3 = Color3.fromRGB(20, 60, 30)
                    m2b.Active = false
                    notifySucesso("Missao 2 completa!")
                else
                    m2b.Text = "FALHOU (" .. acertos .. "/3)"
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
            lbl.Size = UDim2.new(1, -20, 0, 22)
            lbl.Position = UDim2.new(0, 10, 0, 75)
            lbl.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            lbl.Text = frase
            lbl.TextColor3 = Color3.fromRGB(255, 255, 100)
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 10
            lbl.Parent = m2
            Instance.new("UICorner", lbl).CornerRadius = UDim.new(0, 6)

            local input = Instance.new("TextBox")
            input.Size = UDim2.new(1, -20, 0, 28)
            input.Position = UDim2.new(0, 10, 0, 100)
            input.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            input.PlaceholderText = "Digite aqui..."
            input.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
            input.Text = ""
            input.TextColor3 = Color3.fromRGB(255, 255, 255)
            input.Font = Enum.Font.Gotham
            input.TextSize = 11
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

    -- MISSAO 3
    local m3 = Instance.new("Frame")
    m3.Size = UDim2.new(1, -10, 0, 110)
    m3.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    m3.BorderSizePixel = 0
    m3.Parent = scroll
    Instance.new("UICorner", m3).CornerRadius = UDim.new(0, 8)

    local m3t = Instance.new("TextLabel")
    m3t.Size = UDim2.new(1, -20, 0, 25)
    m3t.Position = UDim2.new(0, 10, 0, 5)
    m3t.BackgroundTransparency = 1
    m3t.Text = "Missao 3: Complete a frase (4 frases)"
    m3t.TextColor3 = Color3.fromRGB(255, 255, 255)
    m3t.Font = Enum.Font.GothamBold
    m3t.TextSize = 12
    m3t.TextXAlignment = Enum.TextXAlignment.Left
    m3t.Parent = m3

    local m3b = Instance.new("TextButton")
    m3b.Size = UDim2.new(1, -20, 0, 38)
    m3b.Position = UDim2.new(0, 10, 0, 35)
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
                    m3b.Text = "COMPLETADA (" .. acertos .. "/4)"
                    m3b.BackgroundColor3 = Color3.fromRGB(20, 60, 30)
                    m3b.Active = false
                    notifySucesso("Missao 3 completa!")
                else
                    m3b.Text = "FALHOU (" .. acertos .. "/4)"
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
            lbl.Size = UDim2.new(1, -20, 0, 22)
            lbl.Position = UDim2.new(0, 10, 0, 75)
            lbl.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            lbl.Text = missao.frase
            lbl.TextColor3 = Color3.fromRGB(255, 255, 100)
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 10
            lbl.Parent = m3
            Instance.new("UICorner", lbl).CornerRadius = UDim.new(0, 6)

            local input = Instance.new("TextBox")
            input.Size = UDim2.new(1, -20, 0, 28)
            input.Position = UDim2.new(0, 10, 0, 100)
            input.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            input.PlaceholderText = "Resposta..."
            input.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
            input.Text = ""
            input.TextColor3 = Color3.fromRGB(255, 255, 255)
            input.Font = Enum.Font.Gotham
            input.TextSize = 11
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
local temKey, keyAtual = keyValida()
BG.keyAtual = keyAtual

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
    frame.Size = UDim2.new(0, 320, 0, 295)
    frame.Position = UDim2.new(0.5, -160, 0.5, -147)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BorderSizePixel = 0
    frame.Parent = loginGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(40, 180, 70)
    stroke.Thickness = 2
    stroke.Parent = frame

    local tit = Instance.new("TextLabel")
    tit.Size = UDim2.new(1, 0, 0, 40)
    tit.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    tit.Text = "BL5CK GUI KEY"
    tit.TextColor3 = Color3.fromRGB(255, 255, 255)
    tit.Font = Enum.Font.GothamBold
    tit.TextSize = 15
    tit.Parent = frame
    Instance.new("UICorner", tit).CornerRadius = UDim.new(0, 12)

    local closeLogin = Instance.new("TextButton")
    closeLogin.Size = UDim2.new(0, 28, 0, 28)
    closeLogin.Position = UDim2.new(1, -32, 0, 6)
    closeLogin.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    closeLogin.Text = "X"
    closeLogin.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeLogin.Font = Enum.Font.GothamBold
    closeLogin.TextSize = 12
    closeLogin.Parent = frame
    Instance.new("UICorner", closeLogin).CornerRadius = UDim.new(0, 6)

    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, -40, 0, 28)
    info.Position = UDim2.new(0, 20, 0, 45)
    info.BackgroundTransparency = 1
    info.Text = "Clique em VER KEY pra copiar.\nOu complete as missoes."
    info.TextColor3 = Color3.fromRGB(200, 200, 200)
    info.Font = Enum.Font.Gotham
    info.TextSize = 11
    info.TextWrapped = true
    info.Parent = frame

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(1, -40, 0, 35)
    input.Position = UDim2.new(0, 20, 0, 78)
    input.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    input.PlaceholderText = "Cole a key aqui..."
    input.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
    input.Text = ""
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.Font = Enum.Font.GothamBold
    input.TextSize = 13
    input.Parent = frame
    Instance.new("UICorner", input).CornerRadius = UDim.new(0, 8)

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, -40, 0, 16)
    status.Position = UDim2.new(0, 20, 0, 115)
    status.BackgroundTransparency = 1
    status.Text = ""
    status.TextColor3 = Color3.fromRGB(255, 100, 100)
    status.Font = Enum.Font.GothamBold
    status.TextSize = 10
    status.Parent = frame

    local validar = Instance.new("TextButton")
    validar.Size = UDim2.new(1, -40, 0, 38)
    validar.Position = UDim2.new(0, 20, 0, 135)
    validar.BackgroundColor3 = Color3.fromRGB(20, 60, 30)
    validar.Text = "VALIDAR KEY"
    validar.TextColor3 = Color3.fromRGB(255, 255, 255)
    validar.Font = Enum.Font.GothamBold
    validar.TextSize = 12
    validar.Parent = frame
    Instance.new("UICorner", validar).CornerRadius = UDim.new(0, 8)

    local verKey = Instance.new("TextButton")
    verKey.Size = UDim2.new(1, -40, 0, 38)
    verKey.Position = UDim2.new(0, 20, 0, 178)
    verKey.BackgroundColor3 = Color3.fromRGB(50, 80, 130)
    verKey.Text = "VER KEY"
    verKey.TextColor3 = Color3.fromRGB(255, 255, 255)
    verKey.Font = Enum.Font.GothamBold
    verKey.TextSize = 12
    verKey.Parent = frame
    Instance.new("UICorner", verKey).CornerRadius = UDim.new(0, 8)

    local missoes = Instance.new("TextButton")
    missoes.Size = UDim2.new(1, -40, 0, 38)
    missoes.Position = UDim2.new(0, 20, 0, 221)
    missoes.BackgroundColor3 = Color3.fromRGB(50, 30, 80)
    missoes.Text = "FAZER MISSOES"
    missoes.TextColor3 = Color3.fromRGB(255, 255, 255)
    missoes.Font = Enum.Font.GothamBold
    missoes.TextSize = 12
    missoes.Parent = frame
    Instance.new("UICorner", missoes).CornerRadius = UDim.new(0, 8)

    local validado = false
    local cancelado = false

    validar.MouseButton1Click:Connect(function()
        if input.Text:upper() == keyAtual then
            status.Text = "Key valida!"
            status.TextColor3 = Color3.fromRGB(100, 255, 100)
            validado = true
            task.wait(0.5)
            loginGui:Destroy()
        else
            status.Text = "Key invalida!"
            status.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)

    verKey.MouseButton1Click:Connect(function()
        abrirJanelaMostrarKey(keyAtual)
    end)

    missoes.MouseButton1Click:Connect(function()
        abrirJanelaMissoes(keyAtual)
    end)

    closeLogin.MouseButton1Click:Connect(function()
        cancelado = true
        loginGui:Destroy()
    end)

    -- esconde o painel enquanto não validar
    task.spawn(function()
        while not validado and not cancelado do
            local bgGui = game:GetService("CoreGui"):FindFirstChild("BlackGUI")
            if bgGui then bgGui.Enabled = false end
            task.wait(0.1)
        end

        if validado then
            local bgGui = game:GetService("CoreGui"):FindFirstChild("BlackGUI")
            if bgGui then bgGui.Enabled = true end
        end
    end)
end

print("[Key] Modulo carregado")
