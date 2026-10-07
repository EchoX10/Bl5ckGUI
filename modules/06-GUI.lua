-- =========================================================
-- MÓDULO 06 - GUI PRINCIPAL (Abas + Todos os Botões)
-- =========================================================

local BG = _G.BlackGUI
local CoreGui = BG.CoreGui
local notifySucesso = BG.notifySucesso
local notifyErro = BG.notifyErro
local notifyInfo = BG.notifyInfo
local cmdHD = BG.cmdHD

-- ============== JANELA PRINCIPAL ==============
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BlackGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999999

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 210)
mainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui
mainFrame.ClipsDescendants = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(30, 30, 30)
mainStroke.Thickness = 1.5
mainStroke.Parent = mainFrame

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 38)
titleBar.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 2
titleBar.Parent = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)

local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 22, 0, 22)
logo.Position = UDim2.new(0, 12, 0.5, -11)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://117638534679966"
logo.ImageColor3 = Color3.fromRGB(255, 255, 255)
logo.ZIndex = 3
logo.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -100, 1, 0)
titleLabel.Position = UDim2.new(0, 42, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "BL5CK GUI"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 14
titleLabel.ZIndex = 3
titleLabel.Parent = titleBar

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -68, 0, 4)
minBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 14
minBtn.ZIndex = 3
minBtn.Parent = titleBar
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -34, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(140, 30, 30)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 12
closeBtn.ZIndex = 3
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

-- Tabs
local tabsContainer = Instance.new("Frame")
tabsContainer.Size = UDim2.new(1, 0, 0, 40)
tabsContainer.Position = UDim2.new(0, 0, 0, 38)
tabsContainer.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
tabsContainer.BorderSizePixel = 0
tabsContainer.ZIndex = 2
tabsContainer.Parent = mainFrame

local tabsScroll = Instance.new("ScrollingFrame")
tabsScroll.Size = UDim2.new(1, -10, 0, 70)
tabsScroll.Position = UDim2.new(0, 5, 0, -16)
tabsScroll.BackgroundTransparency = 1
tabsScroll.BorderSizePixel = 0
tabsScroll.ScrollBarThickness = 0
tabsScroll.ScrollingDirection = Enum.ScrollingDirection.X
tabsScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
tabsScroll.ZIndex = 2
tabsScroll.Parent = tabsContainer

local tabsLayout = Instance.new("UIListLayout")
tabsLayout.Padding = UDim.new(0, 6)
tabsLayout.FillDirection = Enum.FillDirection.Horizontal
tabsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
tabsLayout.Parent = tabsScroll

local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -14, 1, -90)
contentArea.Position = UDim2.new(0, 7, 0, 85)
contentArea.BackgroundTransparency = 1
contentArea.BorderSizePixel = 0
contentArea.ZIndex = 1
contentArea.Parent = mainFrame

local abas = {}
local conteudos = {}

local function selecionarAba(index)
    for i, btn in ipairs(abas) do
        if i == index then
            btn.BackgroundColor3 = Color3.fromRGB(15, 50, 20)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn:FindFirstChildOfClass("UIStroke").Color = Color3.fromRGB(40, 180, 70)
            conteudos[i].Visible = true
        else
            btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            btn.TextColor3 = Color3.fromRGB(150, 150, 150)
            btn:FindFirstChildOfClass("UIStroke").Color = Color3.fromRGB(35, 35, 35)
            conteudos[i].Visible = false
        end
    end
end

local function adicionarAba(nome, ordem)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 80, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.Text = nome
    btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.ZIndex = 3
    btn.Parent = tabsScroll
    btn.LayoutOrder = ordem
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(35, 35, 35)
    s.Thickness = 1
    s.Parent = btn

    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1, 0, 1, 0)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 3
    content.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    content.ScrollingDirection = Enum.ScrollingDirection.Y
    content.Visible = false
    content.ZIndex = 1
    content.Parent = contentArea

    local l = Instance.new("UIListLayout")
    l.Padding = UDim.new(0, 6)
    l.Parent = content
    Instance.new("UIPadding", content).PaddingTop = UDim.new(0, 6)
    Instance.new("UIPadding", content).PaddingBottom = UDim.new(0, 6)

    local idx = #abas + 1
    btn.MouseButton1Click:Connect(function() selecionarAba(idx) end)

    table.insert(abas, btn)
    table.insert(conteudos, content)
    return content
end

local function criarToggle(texto, callback, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -4, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    btn.Text = texto .. "\n[ DESLIGADO ]"
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 12
    btn.ZIndex = 2
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(35, 35, 35)
    s.Thickness = 1
    s.Parent = btn

    local estado = false
    btn.MouseButton1Click:Connect(function()
        estado = not estado
        btn.Text = texto .. (estado and "\n[ LIGADO ]" or "\n[ DESLIGADO ]")
        if estado then
            btn.BackgroundColor3 = Color3.fromRGB(15, 50, 20)
            s.Color = Color3.fromRGB(40, 180, 70)
        else
            btn.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
            s.Color = Color3.fromRGB(35, 35, 35)
        end
        pcall(callback, estado)
    end)
end

local function criarBotao(texto, callback, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -4, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.ZIndex = 2
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(45, 45, 45)
    s.Thickness = 1
    s.Parent = btn

    btn.MouseButton1Click:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        task.wait(0.15)
        btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        task.spawn(function() pcall(callback) end)
    end)
end

-- ABA 1: JOGADOR
local tab1 = adicionarAba("Jogador", 1)
criarToggle("Clone Personagem + Arma", function(e)
    if e then BG.toggleClonePersonagem(true) else BG.toggleClonePersonagem(false) end
end, tab1)
criarToggle("Zumbi", function(e) BG.toggleZumbi(e) end, tab1)
criarBotao("Tool Invisible", BG.botaoCriarToolInvisible, tab1)
criarBotao("Tool Hacker", BG.botaoCriarToolHacker, tab1)
criarBotao("Modo Toxico (Anti-Un)", BG.botaoModoToxico, tab1)
criarBotao("Comandos em Jogador", function()
    BG.criarListaJogadores(function(j) BG.criarListaComandos(j) end)
end, tab1)
criarBotao("Armadilha de Jogador", function()
    BG.criarListaJogadores(function(j) BG.armarArmadilha(j) end)
end, tab1)

-- ABA 2: VISUAL
local tab2 = adicionarAba("Visual", 2)
criarToggle("Spam de Particulas", function(e)
    if e then BG.iniciarSpam() else BG.pararSpam() end
end, tab2)
criarToggle("Esconder GUIs + Mutar", function(e)
    if e then BG.ligarHideGuis() else BG.desligarHideGuis() end
end, tab2)
criarToggle("Limpar Efeitos (loop)", function(e)
    if e then BG.ligarLimpar() else BG.desligarLimpar() end
end, tab2)
criarToggle("Particulas Server-Side", function(e)
    if e then BG.ligarParticulas() else BG.desligarParticulas() end
end, tab2)
criarBotao("Mesh Glitch (-3500)", BG.botaoMeshGlitch, tab2)
criarBotao("Texturizar Mapa", BG.botaoTexturizarTudo, tab2)
criarBotao("Colorir Mapa Todo", BG.botaoColorirMapa, tab2)

-- ABA 3: MAPA
local tab3 = adicionarAba("Mapa", 3)
criarBotao("Natural Disaster", BG.botaoNaturalDisaster, tab3)
criarBotao("Mapa Rapido", BG.botaoConstruirMapaRapido, tab3)
criarBotao("Metero Audio", BG.executarMeteroAudio, tab3)
criarBotao("Meteorito Gigante", BG.botaoMeteorito, tab3)
criarBotao("Bandeira Colorida", BG.botaoBandeira, tab3)
criarBotao("Criar NPC Controlavel", BG.criarNPC, tab3)

-- ABA 4: ADMIN
local tab4 = adicionarAba("Admin", 4)
criarToggle("Boas Vindas Automaticas", function(e)
    if e then
        if not BG._boasVindasConexao then
            BG._boasVindasConexao = BG.Players.PlayerAdded:Connect(function(novo)
                task.wait(1)
                cmdHD(";serverHint Welcome " .. novo.Name)
            end)
            notifySucesso("Boas vindas ativado")
        end
    else
        if BG._boasVindasConexao then
            BG._boasVindasConexao:Disconnect()
            BG._boasVindasConexao = nil
            notifyInfo("Boas vindas desativado")
        end
    end
end, tab4)
criarBotao("Titulo BL5CK", function()
    cmdHD(";titlebk me BL5CK")
    notifySucesso("Titulo aplicado")
end, tab4)

local msgBox = Instance.new("TextBox")
msgBox.Size = UDim2.new(1, -4, 0, 42)
msgBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
msgBox.BorderSizePixel = 0
msgBox.Text = ""
msgBox.PlaceholderText = "Digite a mensagem..."
msgBox.PlaceholderColor3 = Color3.fromRGB(80, 80, 80)
msgBox.TextColor3 = Color3.fromRGB(255, 255, 255)
msgBox.Font = Enum.Font.GothamMedium
msgBox.TextSize = 13
msgBox.ClearTextOnFocus = false
msgBox.Parent = tab4
Instance.new("UICorner", msgBox).CornerRadius = UDim.new(0, 8)

local sendBtn = Instance.new("TextButton")
sendBtn.Size = UDim2.new(1, -4, 0, 46)
sendBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 30)
sendBtn.Text = "Enviar serverMessage"
sendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
sendBtn.Font = Enum.Font.GothamBold
sendBtn.TextSize = 13
sendBtn.Parent = tab4
Instance.new("UICorner", sendBtn).CornerRadius = UDim.new(0, 8)
sendBtn.MouseButton1Click:Connect(function()
    if msgBox.Text ~= "" then
        cmdHD(";serverMessage " .. msgBox.Text)
        notifySucesso("Mensagem enviada")
        msgBox.Text = ""
    end
end)

-- ABA 5: MIDIA
local tab5 = adicionarAba("Midia", 5)

local musicRow = Instance.new("Frame")
musicRow.Size = UDim2.new(1, -4, 0, 50)
musicRow.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
musicRow.BorderSizePixel = 0
musicRow.Parent = tab5
Instance.new("UICorner", musicRow).CornerRadius = UDim.new(0, 8)
local mrL = Instance.new("UIListLayout")
mrL.FillDirection = Enum.FillDirection.Horizontal
mrL.Padding = UDim.new(0, 4)
mrL.Parent = musicRow
Instance.new("UIPadding", musicRow).PaddingLeft = UDim.new(0, 4)
Instance.new("UIPadding", musicRow).PaddingRight = UDim.new(0, 4)

local musicToggleBtn = Instance.new("TextButton")
musicToggleBtn.Size = UDim2.new(1, -50, 1, -4)
musicToggleBtn.Position = UDim2.new(0, 0, 0, 2)
musicToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
musicToggleBtn.Text = "Musica\n[ DESLIGADO ]"
musicToggleBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
musicToggleBtn.Font = Enum.Font.GothamMedium
musicToggleBtn.TextSize = 11
musicToggleBtn.Parent = musicRow
Instance.new("UICorner", musicToggleBtn).CornerRadius = UDim.new(0, 6)

local musicEstado = false
musicToggleBtn.MouseButton1Click:Connect(function()
    musicEstado = not musicEstado
    if musicEstado then BG.ligarMusica() else BG.desligarMusica() end
end)

local presetBtn = Instance.new("TextButton")
presetBtn.Size = UDim2.new(0, 42, 1, -4)
presetBtn.Position = UDim2.new(0, 0, 0, 2)
presetBtn.BackgroundColor3 = Color3.fromRGB(50, 30, 80)
presetBtn.Text = ">>"
presetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
presetBtn.Font = Enum.Font.GothamBold
presetBtn.TextSize = 14
presetBtn.Parent = musicRow
Instance.new("UICorner", presetBtn).CornerRadius = UDim.new(0, 6)
presetBtn.MouseButton1Click:Connect(function() BG.trocarPreset() end)

criarBotao("Disco + Fog + Time 0", BG.botaoDiscoFog, tab5)

-- Controles
local minimizado = false
local tamanhoOriginal = UDim2.new(0, 320, 0, 210)

minBtn.MouseButton1Click:Connect(function()
    minimizado = not minimizado
    tabsContainer.Visible = not minimizado
    contentArea.Visible = not minimizado
    mainFrame.Size = minimizado and UDim2.new(0, 320, 0, 38) or tamanhoOriginal
    minBtn.Text = minimizado and "+" or "—"
end)

closeBtn.MouseButton1Click:Connect(function()
    pcall(function() BG.desligarMusica() end)
    pcall(function() BG.desligarHideGuis() end)
    pcall(function() BG.desligarLimpar() end)
    pcall(function() BG.pararSpam() end)
    screenGui:Destroy()
end)

selecionarAba(1)

-- Proteção anti-hide
task.spawn(function()
    while screenGui and screenGui.Parent do
        task.wait(0.3)
        pcall(function()
            if screenGui.Enabled == false then screenGui.Enabled = true end
            if mainFrame.Visible == false then mainFrame.Visible = true end
        end)
    end
end)

notifySucesso("BL5CK GUI carregada!")
print("[GUI] Modulo carregado")
