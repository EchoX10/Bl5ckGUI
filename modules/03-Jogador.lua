-- =========================================================
-- MÓDULO 03 - JOGADOR (Clone, Zumbi, Tools, Tóxico, Armadilha)
-- =========================================================

local BG = _G.BlackGUI
local Players = BG.Players
local plr = BG.plr
local playerGui = BG.playerGui
local RunService = BG.RunService
local UserInputService = BG.UserInputService
local notifySucesso = BG.notifySucesso
local notifyErro = BG.notifyErro
local notifyInfo = BG.notifyInfo
local cmdHD = BG.cmdHD
local F3X = BG.F3X
local getFork3XEndpoint = BG.getFork3XEndpoint
local criarWeldServerSide = BG.criarWeldServerSide
local acharParteReal = BG.acharParteReal
local COMANDOS_RAPIDOS = BG.COMANDOS_RAPIDOS
local TRAP_POSITION = BG.TRAP_POSITION
local TRAP_SIZE = BG.TRAP_SIZE

-- ============== LISTA DE JOGADORES ==============
function BG.criarListaJogadores(callback)
    local listaGui = Instance.new("ScreenGui")
    listaGui.Name = "BG_ListaJogadores"
    listaGui.ResetOnSpawn = false
    listaGui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 250, 0, 400)
    frame.Position = UDim2.new(0.5, -125, 0.5, -200)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = listaGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local tit = Instance.new("TextLabel")
    tit.Size = UDim2.new(1, 0, 0, 30)
    tit.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    tit.Text = "Selecione um Jogador"
    tit.TextColor3 = Color3.fromRGB(255, 255, 255)
    tit.Font = Enum.Font.GothamBold
    tit.TextSize = 14
    tit.Parent = frame
    Instance.new("UICorner", tit).CornerRadius = UDim.new(0, 8)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -10, 1, -40)
    scroll.Position = UDim2.new(0, 5, 0, 35)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 6
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = frame
    Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 4)

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= plr then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 35)
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            btn.Text = p.Name
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.GothamMedium
            btn.TextSize = 13
            btn.Parent = scroll
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            btn.MouseButton1Click:Connect(function()
                listaGui:Destroy()
                if callback then callback(p) end
            end)
        end
    end

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
    fechar.MouseButton1Click:Connect(function() listaGui:Destroy() end)
end

-- ============== LISTA DE COMANDOS ==============
function BG.criarListaComandos(jogadorAlvo)
    local listaGui = Instance.new("ScreenGui")
    listaGui.Name = "BG_ListaComandos"
    listaGui.ResetOnSpawn = false
    listaGui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 250, 0, 350)
    frame.Position = UDim2.new(0.5, -125, 0.5, -175)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = listaGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local tit = Instance.new("TextLabel")
    tit.Size = UDim2.new(1, 0, 0, 30)
    tit.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    tit.Text = "Comandos em: " .. (jogadorAlvo and jogadorAlvo.Name or "?")
    tit.TextColor3 = Color3.fromRGB(255, 255, 255)
    tit.Font = Enum.Font.GothamBold
    tit.TextSize = 14
    tit.Parent = frame
    Instance.new("UICorner", tit).CornerRadius = UDim.new(0, 8)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -10, 1, -40)
    scroll.Position = UDim2.new(0, 5, 0, 35)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 6
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = frame
    Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 4)

    for _, info in ipairs(COMANDOS_RAPIDOS) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 35)
        btn.BackgroundColor3 = Color3.fromRGB(70, 90, 120)
        btn.Text = info.nome
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 13
        btn.Parent = scroll
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        btn.MouseButton1Click:Connect(function()
            if jogadorAlvo then
                cmdHD(info.cmd .. " " .. jogadorAlvo.Name)
                notifySucesso("Comando: " .. info.cmd .. " " .. jogadorAlvo.Name)
            end
            listaGui:Destroy()
        end)
    end

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
    fechar.MouseButton1Click:Connect(function() listaGui:Destroy() end)
end

-- ============== MODO TÓXICO ==============
local targetPlayer = nil
local modoToxicoAtivo = false
local toxicoTask = nil

local function iniciarAtaqueToxico()
    if not targetPlayer or not Players:FindFirstChild(targetPlayer.Name) then return end
    local n, m = targetPlayer.Name, plr.Name
    pcall(function() BG.rc:InvokeServer(";ice " .. n) end)
    pcall(function() BG.rc:InvokeServer(";jail " .. n) end)
    pcall(function() BG.rc:InvokeServer(";title " .. n .. " I LOVE " .. m) end)
    pcall(function() BG.rc:InvokeServer(";warp " .. n) end)
    pcall(function() BG.rc:InvokeServer(";blur " .. n) end)
    pcall(function() BG.rc:InvokeServer(";punish " .. n) end)
end

local function loopToxico()
    while modoToxicoAtivo and targetPlayer and Players:FindFirstChild(targetPlayer.Name) do
        iniciarAtaqueToxico()
        task.wait(1.5)
    end
end

local function abrirPainelToxico(alvo)
    local antigo = playerGui:FindFirstChild("BG_ListaJogadores")
    if antigo then antigo:Destroy() end

    local painel = Instance.new("ScreenGui")
    painel.Name = "BG_PainelToxico"
    painel.ResetOnSpawn = false
    painel.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 250, 0, 100)
    frame.Position = UDim2.new(0.5, -125, 0.5, 50)
    frame.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = painel
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local tit = Instance.new("TextLabel")
    tit.Size = UDim2.new(1, 0, 0, 30)
    tit.BackgroundColor3 = Color3.fromRGB(60, 30, 30)
    tit.Text = "Alvo: " .. alvo.Name
    tit.TextColor3 = Color3.fromRGB(255, 100, 100)
    tit.Font = Enum.Font.GothamBold
    tit.TextSize = 14
    tit.Parent = frame
    Instance.new("UICorner", tit).CornerRadius = UDim.new(0, 8)

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(1, -20, 0, 40)
    toggle.Position = UDim2.new(0, 10, 0, 40)
    toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    toggle.Text = "ATIVAR ATAQUE\n[ DESLIGADO ]"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 12
    toggle.Parent = frame
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 6)

    local ativo = false
    toggle.MouseButton1Click:Connect(function()
        ativo = not ativo
        if ativo then
            toggle.Text = "ATAQUE ATIVADO\n[ LIGADO ]"
            toggle.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
            targetPlayer = alvo
            modoToxicoAtivo = true
            iniciarAtaqueToxico()
            if toxicoTask then task.cancel(toxicoTask) end
            toxicoTask = task.spawn(loopToxico)
            notifySucesso("Modo tóxico ativado em " .. alvo.Name)
        else
            toggle.Text = "ATIVAR ATAQUE\n[ DESLIGADO ]"
            toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            modoToxicoAtivo = false
            targetPlayer = nil
            if toxicoTask then task.cancel(toxicoTask) end
            notifyInfo("Modo tóxico desativado")
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
    fechar.MouseButton1Click:Connect(function() painel:Destroy() end)
end

function BG.botaoModoToxico()
    BG.criarListaJogadores(function(alvo)
        if alvo then abrirPainelToxico(alvo) end
    end)
end

-- ============== ANTI-UN HOOK ==============
local hookOk = pcall(function()
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "InvokeServer" and self == BG.rc then
            local args = {...}
            if args[1] and type(args[1]) == "string" then
                local s = args[1]:lower()
                if modoToxicoAtivo and targetPlayer and Players:FindFirstChild(targetPlayer.Name) then
                    local n = targetPlayer.Name:lower()
                    if s:find("unice") and (s:find(n) or s:find("all") or s:find("others")) then
                        task.spawn(function() cmdHD(";ice " .. targetPlayer.Name) end)
                    elseif s:find("unjail") and (s:find(n) or s:find("all") or s:find("others")) then
                        task.spawn(function() cmdHD(";jail " .. targetPlayer.Name) end)
                    elseif s:find("unblur") and (s:find(n) or s:find("all") or s:find("others")) then
                        task.spawn(function() cmdHD(";blur " .. targetPlayer.Name) end)
                    elseif s:find("untitle") and (s:find(n) or s:find("all") or s:find("others")) then
                        task.spawn(function() cmdHD(";title " .. targetPlayer.Name .. " I LOVE " .. plr.Name) end)
                    elseif s:find("unpunish") and (s:find(n) or s:find("all") or s:find("others")) then
                        task.spawn(function() cmdHD(";punish " .. targetPlayer.Name) end)
                    end
                end
            end
        end
        return oldNamecall(self, ...)
    end))
end)
if not hookOk then warn("[Jogador] Anti-un hook indisponível") end

-- ============== TOOL INVISIBLE ==============
function BG.botaoCriarToolInvisible()
    if plr.Backpack:FindFirstChild("InvisibleTool") then
        notifyErro("Tool já existe!")
        return
    end

    local tool = Instance.new("Tool")
    tool.Name = "InvisibleTool"
    tool.RequiresHandle = false
    tool.CanBeDropped = false
    tool.ToolTip = "Clique para Invisivel/Visivel"
    tool.Parent = plr.Backpack

    local invisivel = false
    tool.Activated:Connect(function()
        invisivel = not invisivel
        if invisivel then
            cmdHD(";invisible")
            notifySucesso("Invisivel ativado")
        else
            cmdHD(";visible")
            notifyInfo("Visivel novamente")
        end
    end)

    notifySucesso("Tool Invisible criada")
end

-- ============== TOOL HACKER ==============
function BG.botaoCriarToolHacker()
    local seBTP = getFork3XEndpoint()
    if not seBTP then notifyErro("Building Tools+ nao encontrada!") return end
    notifyInfo("Criando Tool Hacker...")

    local tool = F3X:CreatePart("Tool", CFrame.new(0, -250, 0), workspace)
    if not tool then notifyErro("Falha ao criar tool!") return end

    task.wait(0.5)
    local handle = tool:FindFirstChild("Handle")
    if not handle then notifyErro("Handle nao encontrado!") return end

    pcall(function() seBTP:InvokeServer("CreateMeshes", {{Part = handle}}) end)
    task.wait(0.1)
    pcall(function()
        seBTP:InvokeServer("SyncMesh", {{
            Part = handle,
            MeshId = "rbxassetid://13024118174",
            TextureId = "rbxassetid://13024118123",
            Scale = Vector3.new(1, 1, 1)
        }})
    end)

    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://204295235"

    tool.Activated:Connect(function()
        local char = plr.Character
        if not char then return end
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            local animator = humanoid:FindFirstChild("Animator")
            if animator then
                local track = animator:LoadAnimation(animation)
                track:Play()
            end
        end
        local mouse = plr:GetMouse()
        local target = mouse.Target
        if not target then return end
        local targetChar = target:FindFirstAncestorOfClass("Model")
        if targetChar and targetChar ~= char then
            local tp = Players:GetPlayerFromCharacter(targetChar)
            if tp and targetChar:FindFirstChild("Humanoid") then
                task.spawn(function()
                    for _, part in ipairs(targetChar:GetDescendants()) do
                        if part:IsA("BasePart") then pcall(function() F3X:Remove(part) end) end
                    end
                end)
                cmdHD(";kill " .. tp.Name)
                task.wait(0.01)
                cmdHD(";explode " .. tp.Name)
                task.wait(0.01)
                cmdHD(";respawn " .. tp.Name)
                notifySucesso("Player " .. tp.Name .. " deletado")
            end
        end
    end)

    notifySucesso("Tool Hacker criada no chao")
end

-- ============== ARMADILHA ==============
function BG.armarArmadilha(alvo)
    if not alvo or not alvo.Character then return end
    notifyInfo("Construindo armadilha pra " .. alvo.Name)

    local posOrig = nil
    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        posOrig = plr.Character.HumanoidRootPart.CFrame
    end

    cmdHD(";teleport me " .. TRAP_POSITION.X .. "," .. TRAP_POSITION.Y .. "," .. TRAP_POSITION.Z)
    task.wait(0.8)

    pcall(function()
        local c = F3X:CreatePart("Normal", CFrame.new(TRAP_POSITION.X, TRAP_POSITION.Y - TRAP_SIZE.Y/2, TRAP_POSITION.Z), workspace)
        if c then F3X:Resize(c, Vector3.new(TRAP_SIZE.X, 0.5, TRAP_SIZE.Z)) end
    end)
    pcall(function()
        local t = F3X:CreatePart("Normal", CFrame.new(TRAP_POSITION.X, TRAP_POSITION.Y + TRAP_SIZE.Y/2, TRAP_POSITION.Z), workspace)
        if t then F3X:Resize(t, Vector3.new(TRAP_SIZE.X, 0.5, TRAP_SIZE.Z)) end
    end)
    pcall(function()
        local f = F3X:CreatePart("Normal", CFrame.new(TRAP_POSITION.X, TRAP_POSITION.Y, TRAP_POSITION.Z + TRAP_SIZE.Z/2), workspace)
        if f then F3X:Resize(f, Vector3.new(TRAP_SIZE.X, TRAP_SIZE.Y, 0.5)) end
    end)
    pcall(function()
        local t = F3X:CreatePart("Normal", CFrame.new(TRAP_POSITION.X, TRAP_POSITION.Y, TRAP_POSITION.Z - TRAP_SIZE.Z/2), workspace)
        if t then F3X:Resize(t, Vector3.new(TRAP_SIZE.X, TRAP_SIZE.Y, 0.5)) end
    end)
    pcall(function()
        local e = F3X:CreatePart("Normal", CFrame.new(TRAP_POSITION.X - TRAP_SIZE.X/2, TRAP_POSITION.Y, TRAP_POSITION.Z), workspace)
        if e then F3X:Resize(e, Vector3.new(0.5, TRAP_SIZE.Y, TRAP_SIZE.Z)) end
    end)
    pcall(function()
        local d = F3X:CreatePart("Normal", CFrame.new(TRAP_POSITION.X + TRAP_SIZE.X/2, TRAP_POSITION.Y, TRAP_POSITION.Z), workspace)
        if d then F3X:Resize(d, Vector3.new(0.5, TRAP_SIZE.Y, TRAP_SIZE.Z)) end
    end)
    task.wait(0.5)

    cmdHD(";teleport " .. alvo.Name)
    task.wait(0.5)

    if posOrig then
        cmdHD(";teleport me " .. posOrig.Position.X .. "," .. posOrig.Position.Y .. "," .. posOrig.Position.Z)
    end
    notifySucesso("Armadilha armada em " .. alvo.Name)
end

-- ============== ZUMBI ==============
local zumbiAtivo = false
local zumbiParte = nil
local conexaoZumbi = nil

function BG.toggleZumbi(ativar)
    local seBTP = getFork3XEndpoint()
    if not seBTP then notifyErro("Building Tools+ nao encontrada!") return end

    if ativar then
        if zumbiAtivo then return end
        zumbiAtivo = true
        local char = plr.Character
        if not char then notifyErro("Character nao encontrado!") zumbiAtivo = false return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then notifyErro("HRP nao encontrado!") zumbiAtivo = false return end

        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                pcall(function() F3X:SetTransparency(p, 1) end)
            end
        end

        local parte = F3X:CreatePart("Normal", CFrame.new(0, -250, 0), workspace)
        if not parte then notifyErro("Falha ao criar zumbi!") zumbiAtivo = false return end

        F3X:Resize(parte, Vector3.new(6.5, 8, 1.6))
        F3X:SetCollision(parte, false)
        F3X:Anchor(parte)

        pcall(function() seBTP:InvokeServer("CreateMeshes", {{Part = parte}}) end)
        task.wait(0.1)
        pcall(function()
            seBTP:InvokeServer("SyncMesh", {{
                Part = parte,
                MeshId = "rbxassetid://5263825255",
                TextureId = "rbxassetid://5263825295",
                Scale = Vector3.new(1.2, 1.2, 1.2)
            }})
        end)

        F3X:Move(parte, hrp.CFrame)
        task.wait(0.1)
        pcall(function() seBTP:InvokeServer("CreateConstraints", {parte}, {}, hrp, "Weld") end)
        F3X:Unanchor(parte)
        zumbiParte = parte

        conexaoZumbi = parte.Touched:Connect(function(hit)
            if not zumbiAtivo then return end
            local charHit = hit:FindFirstAncestorOfClass("Model")
            if charHit and charHit ~= char then
                local p = Players:GetPlayerFromCharacter(charHit)
                if p and charHit:FindFirstChild("Humanoid") then cmdHD(";dmg " .. p.Name .. " 25") end
            end
        end)

        notifySucesso("Zumbi ativado")
    else
        if not zumbiAtivo then return end
        zumbiAtivo = false
        if conexaoZumbi then conexaoZumbi:Disconnect() conexaoZumbi = nil end
        if zumbiParte and zumbiParte.Parent then pcall(function() F3X:Remove(zumbiParte) end) end
        zumbiParte = nil
        local char = plr.Character
        if char then
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                    pcall(function() F3X:SetTransparency(p, 0) end)
                end
            end
        end
        notifyInfo("Zumbi removido")
    end
end

-- ============== ACESSORIO FLUTUANTE ==============
local acessorioAtivo = false
local acessorioPartes = {}

function BG.toggleAcessorioFlutuante(ativar)
    local seBTP = getFork3XEndpoint()
    if not seBTP then notifyErro("Building Tools+ nao encontrada!") return end

    if ativar then
        if acessorioAtivo then return end
        local char = plr.Character
        if not char then notifyErro("Character nao encontrado!") return end
        local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
        if not torso then notifyErro("Torso nao encontrado!") return end

        acessorioAtivo = true
        acessorioPartes = {}

        local defs = {
            ["Part3"] = {cf={-0.2433,6.0213,1.2728,-0.9741,-0.0355,0.2234,-0.0166,0.9962,0.0856,-0.2256,0.0796,-0.9710}, s=Vector3.new(0.08,0.08,0.08), c=Color3.fromRGB(255,191,255), m="Air"},
            ["Part5"] = {cf={0.1319,5.9887,0.5391,-0.8748,-0.0355,0.4832,0.0076,0.9962,0.0868,-0.4845,0.0796,-0.8712}, s=Vector3.new(1.55,1.55,1.55), c=Color3.fromRGB(0,0,0), m="Fabric"},
            ["Part6"] = {cf={1.0896,6.0631,1.3435,-0.9553,-0.0355,-0.2936,-0.0573,0.9962,0.0658,0.2901,0.0797,-0.9537}, s=Vector3.new(0.08,0.08,0.08), c=Color3.fromRGB(255,191,255), m="Air"},
            ["Part4"] = {cf={-0.0347,5.9909,0.9014,-0.8662,-0.0355,0.4985,0.0091,0.9962,0.0867,-0.4996,0.0797,-0.8626}, s=Vector3.new(0.92,0.92,0.92), c=Color3.fromRGB(255,191,255), m="Air"},
            ["Part2"] = {cf={0.9351,6.0223,0.9409,-0.9500,-0.0355,-0.3102,-0.0584,0.9962,0.0648,0.3067,0.0797,-0.9485}, s=Vector3.new(0.92,0.92,0.92), c=Color3.fromRGB(255,200,253), m="Air"},
            ["Part"]  = {cf={0.7669,6.0090,0.5685,-0.7179,-0.0355,-0.6952,-0.0809,0.9962,0.0327,0.6914,0.0797,-0.7180}, s=Vector3.new(1.55,1.55,1.55), c=Color3.fromRGB(0,0,0), m="Fabric"}
        }

        -- usa o Part5 como CFrame de REFERENCIA (centro do conjunto)
        local r = defs["Part5"].cf
        local refCF  = CFrame.new(r[1],r[2],r[3],r[4],r[5],r[6],r[7],r[8],r[9],r[10],r[11],r[12])
        local refInv = refCF:Inverse()

        -- onde o conjunto vai ficar: 0.5 studs acima do torso (mesmo alvo do codigo original)
        local destinoRoot = torso.CFrame * CFrame.new(0, 0.5, 0)

        local partes = {}

        for nome, d in pairs(defs) do
            local cf = CFrame.new(d.cf[1],d.cf[2],d.cf[3],d.cf[4],d.cf[5],d.cf[6],d.cf[7],d.cf[8],d.cf[9],d.cf[10],d.cf[11],d.cf[12])
            -- offset relativo ao Part5 original (mesma posicao relativa entre as partes)
            local offset  = refInv * cf
            local finalCF = destinoRoot * offset

            local p = F3X:CreatePart("Ball", finalCF, workspace)
            if p then
                F3X:Resize(p, d.s)
                pcall(function() p.Shape = Enum.PartType.Ball end) -- FORCA bola
                F3X:SetColor(p, d.c)
                pcall(function() p.Material = Enum.Material[d.m] end)
                F3X:SetCollision(p, false)
                F3X:Anchor(p)
                p.CFrame = finalCF
                partes[nome] = p
                table.insert(acessorioPartes, p)
            end
        end

        if not partes["Part5"] then
            notifyErro("Falha ao criar partes!")
            acessorioAtivo = false
            return
        end

        task.wait(0.3)

        -- Welda TODAS as partes direto no torso (sem cadeia)
        for nome, p in pairs(partes) do
            pcall(function()
                seBTP:InvokeServer("CreateConstraints", {p}, {}, torso, "Weld")
            end)
            task.wait(0.05)
        end

        task.wait(0.3)

        -- Desancora — os welds mantem tudo grudado no torso
        for _, p in pairs(partes) do
            F3X:Unanchor(p)
        end

        notifySucesso("Acessorio flutuante criado!")
    else
        if not acessorioAtivo then return end
        acessorioAtivo = false
        for _, p in ipairs(acessorioPartes) do
            if p and p.Parent then pcall(function() F3X:Remove(p) end) end
        end
        acessorioPartes = {}
        notifyInfo("Acessorio removido")
    end
end

-- ============== FEMINIZAR (R6) COM DECAL DE ROUPA ==============
local MESHES_FEMININO = {
    ["Left Leg"]  = "18216320743",
    ["Right Leg"] = "18216310657",
    ["Left Arm"]  = "18216322936",
    ["Right Arm"] = "18216316902",
    ["Torso"]     = "18216271424"
}

local TODAS_FACES = {
    Enum.NormalId.Front, Enum.NormalId.Back,
    Enum.NormalId.Left, Enum.NormalId.Right,
    Enum.NormalId.Top, Enum.NormalId.Bottom
}

BG._aparenciaSalva = nil

local function salvarAparencia()
    local char = plr.Character
    if not char then return false end

    local dados = {
        meshes = {},
        shirtId = nil,
        pantsId = nil,
        tshirtId = nil,
        coresOriginais = {}
    }

    for _, nomeParte in ipairs({"Left Leg", "Right Leg", "Left Arm", "Right Arm", "Torso"}) do
        local parte = char:FindFirstChild(nomeParte)
        if parte and parte:IsA("BasePart") then
            local mesh = parte:FindFirstChildOfClass("SpecialMesh")
            if mesh then
                dados.meshes[nomeParte] = {
                    meshId = mesh.MeshId or "",
                    textureId = mesh.TextureId or "",
                    scale = {mesh.Scale.X, mesh.Scale.Y, mesh.Scale.Z}
                }
            else
                dados.meshes[nomeParte] = { meshId = "", textureId = "", scale = {1, 1, 1} }
            end

            -- Salva também a cor original (pra restaurar)
            dados.coresOriginais[nomeParte] = {
                r = parte.Color.R,
                g = parte.Color.G,
                b = parte.Color.B
            }
        end
    end

    local shirt = char:FindFirstChildOfClass("Shirt")
    if shirt then dados.shirtId = shirt.ShirtTemplate end

    local pants = char:FindFirstChildOfClass("Pants")
    if pants then dados.pantsId = pants.PantsTemplate end

    local tshirt = char:FindFirstChildOfClass("ShirtGraphic")
    if tshirt then dados.tshirtId = tshirt.Graphic end

    BG._aparenciaSalva = dados
    return true
end

local function lerAparencia()
    return BG._aparenciaSalva
end

-- ============== APLICA MESH ==============
local function aplicarMeshFeminina(seBTP, parte, meshId)
    local mesh = parte:FindFirstChildOfClass("SpecialMesh")
    if not mesh then
        pcall(function()
            seBTP:InvokeServer("CreateMeshes", {{Part = parte}})
        end)
        task.wait(0.1)
    end

    pcall(function()
        seBTP:InvokeServer("SyncMesh", {{
            Part = parte,
            MeshId = "rbxassetid://" .. meshId,
            TextureId = "",
            Scale = Vector3.new(1, 1, 1)
        }})
    end)
end

-- ============== APLICA TEXTURA EM TODAS AS FACES ==============
local function aplicarTexturaEmTodasFaces(seBTP, parte, textureId)
    -- Limpa decals/texturas antigas primeiro
    for _, face in ipairs(TODAS_FACES) do
        pcall(function()
            seBTP:InvokeServer("CreateTextures", {{
                Part = parte,
                Face = face,
                TextureType = "Decal"
            }})
        end)
    end
    task.wait(0.1)

    -- Aplica a nova textura em todas as faces
    for _, face in ipairs(TODAS_FACES) do
        pcall(function()
            seBTP:InvokeServer("SyncTexture", {{
                Part = parte,
                Face = face,
                TextureType = "Decal",
                Texture = "rbxassetid://" .. textureId
            }})
        end)
    end
end

-- ============== EXTRAI ID DA URL ==============
local function extrairIdDaUrl(url)
    if not url or url == "" then return nil end
    -- Formato: "rbxassetid://123456" ou "http://www.roblox.com/asset/?id=123456"
    local id = url:match("rbxassetid://(%d+)")
    if not id then
        id = url:match("id=(%d+)")
    end
    return id
end

function BG.botaoFeminizar()
    local char = plr.Character
    if not char then notifyErro("Character não encontrado") return end

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then notifyErro("Humanoid não encontrado") return end

    if humanoid.RigType ~= Enum.HumanoidRigType.R6 then
        notifyErro("Esta função só funciona em R6")
        notifyInfo("Muda teu avatar pra R6 nas configurações do Roblox")
        return
    end

    local seBTP = getFork3XEndpoint()
    if not seBTP then notifyErro("Building Tools+ não equipada") return end

    salvarAparencia()

    notifyInfo("Aplicando meshes femininas...")
    local aplicadas = 0

    for nomeParte, meshId in pairs(MESHES_FEMININO) do
        local parte = char:FindFirstChild(nomeParte)
        if parte and parte:IsA("BasePart") then
            aplicarMeshFeminina(seBTP, parte, meshId)
            aplicadas = aplicadas + 1
            task.wait(0.15)
        end
    end

    -- Agora aplica a textura da roupa em todas as faces
    task.wait(0.3)
    local dados = lerAparencia()
    if dados then
        -- Pega os IDs da shirt e pants
        local shirtId = extrairIdDaUrl(dados.shirtId)
        local pantsId = extrairIdDaUrl(dados.pantsId)

        print("[Feminizar] Shirt ID:", shirtId)
        print("[Feminizar] Pants ID:", pantsId)

        -- Aplica a textura da Pants nas pernas (Left Leg + Right Leg)
        if pantsId then
            for _, nomeParte in ipairs({"Left Leg", "Right Leg"}) do
                local parte = char:FindFirstChild(nomeParte)
                if parte then
                    aplicarTexturaEmTodasFaces(seBTP, parte, pantsId)
                    task.wait(0.2)
                end
            end
        end

        -- Aplica a textura da Shirt no Torso e nos braços
        if shirtId then
            for _, nomeParte in ipairs({"Torso", "Left Arm", "Right Arm"}) do
                local parte = char:FindFirstChild(nomeParte)
                if parte then
                    aplicarTexturaEmTodasFaces(seBTP, parte, shirtId)
                    task.wait(0.2)
                end
            end
        end
    end

    -- Reaplica roupa "normal" também (caso funcione em algumas partes)
    task.wait(0.3)
    if dados then
        if dados.shirtId and dados.shirtId ~= "" then
            local shirt = char:FindFirstChildOfClass("Shirt")
            if not shirt then
                shirt = Instance.new("Shirt")
                shirt.Parent = char
            end
            pcall(function() shirt.ShirtTemplate = dados.shirtId end)
        end
        if dados.pantsId and dados.pantsId ~= "" then
            local pants = char:FindFirstChildOfClass("Pants")
            if not pants then
                pants = Instance.new("Pants")
                pants.Parent = char
            end
            pcall(function() pants.PantsTemplate = dados.pantsId end)
        end
        if dados.tshirtId and dados.tshirtId ~= "" then
            local tshirt = char:FindFirstChildOfClass("ShirtGraphic")
            if not tshirt then
                tshirt = Instance.new("ShirtGraphic")
                tshirt.Parent = char
            end
            pcall(function() tshirt.Graphic = dados.tshirtId end)
        end
    end

    if aplicadas > 0 then
        notifySucesso("Feminizada em " .. aplicadas .. " partes")
    else
        notifyErro("Nenhuma parte encontrada")
    end
end

-- ============== RESTAURAR APARÊNCIA ==============
function BG.botaoRestaurarAparencia()
    local char = plr.Character
    if not char then notifyErro("Character não encontrado") return end

    local seBTP = getFork3XEndpoint()
    if not seBTP then notifyErro("Building Tools+ não equipada") return end

    local dados = lerAparencia()
    if not dados then
        notifyErro("Nenhum save encontrado")
        notifyInfo("Feminiza uma vez antes pra criar o save")
        return
    end

    notifyInfo("Restaurando aparência...")
    task.wait(0.3)

    local restauradas = 0

    for nomeParte, dadosParte in pairs(dados.meshes) do
        local parte = char:FindFirstChild(nomeParte)
        if parte and parte:IsA("BasePart") then
            -- Remove decals aplicados
            for _, face in ipairs(TODAS_FACES) do
                pcall(function()
                    seBTP:InvokeServer("SyncTexture", {{
                        Part = parte,
                        Face = face,
                        TextureType = "Decal",
                        Texture = ""
                    }})
                end)
            end
            task.wait(0.1)

            if dadosParte.meshId == "" then
                local mesh = parte:FindFirstChildOfClass("SpecialMesh")
                if mesh then
                    pcall(function()
                        seBTP:InvokeServer("SyncMesh", {{
                            Part = parte,
                            MeshId = "",
                            TextureId = "",
                            Scale = Vector3.new(1, 1, 1)
                        }})
                    end)
                    task.wait(0.1)
                    pcall(function() mesh:Destroy() end)
                end
                restauradas = restauradas + 1
            else
                pcall(function()
                    seBTP:InvokeServer("CreateMeshes", {{Part = parte}})
                end)
                task.wait(0.1)
                pcall(function()
                    seBTP:InvokeServer("SyncMesh", {{
                        Part = parte,
                        MeshId = dadosParte.meshId,
                        TextureId = dadosParte.textureId,
                        Scale = Vector3.new(dadosParte.scale[1], dadosParte.scale[2], dadosParte.scale[3])
                    }})
                end)
                restauradas = restauradas + 1
                task.wait(0.15)
            end

            -- Restaura a cor original
            local cor = dados.coresOriginais[nomeParte]
            if cor then
                pcall(function()
                    F3X:SetColor(parte, Color3.new(cor.r, cor.g, cor.b))
                end)
            end
        end
    end

    -- Reaplica a roupa
    task.wait(0.3)
    if dados.shirtId and dados.shirtId ~= "" then
        local shirt = char:FindFirstChildOfClass("Shirt")
        if not shirt then
            shirt = Instance.new("Shirt")
            shirt.Parent = char
        end
        pcall(function() shirt.ShirtTemplate = dados.shirtId end)
    end
    if dados.pantsId and dados.pantsId ~= "" then
        local pants = char:FindFirstChildOfClass("Pants")
        if not pants then
            pants = Instance.new("Pants")
            pants.Parent = char
        end
        pcall(function() pants.PantsTemplate = dados.pantsId end)
    end
    if dados.tshirtId and dados.tshirtId ~= "" then
        local tshirt = char:FindFirstChildOfClass("ShirtGraphic")
        if not tshirt then
            tshirt = Instance.new("ShirtGraphic")
            tshirt.Parent = char
        end
        pcall(function() tshirt.Graphic = dados.tshirtId end)
    end

    notifySucesso("Restauradas " .. restauradas .. " partes")
end

-- ============== RESTAURAR APARÊNCIA ==============
function BG.botaoRestaurarAparencia()
    local char = plr.Character
    if not char then notifyErro("Character não encontrado") return end

    local seBTP = getFork3XEndpoint()
    if not seBTP then notifyErro("Building Tools+ não equipada") return end

    local dados = lerAparencia()
    if not dados then
        notifyErro("Nenhum save encontrado")
        notifyInfo("Feminiza uma vez antes pra criar o save")
        return
    end

    notifyInfo("Restaurando aparência...")
    task.wait(0.3)

    local restauradas = 0

    for nomeParte, dadosParte in pairs(dados.meshes) do
        local parte = char:FindFirstChild(nomeParte)
        if parte and parte:IsA("BasePart") then
            if dadosParte.meshId == "" then
                -- Não tinha mesh: destrói
                local mesh = parte:FindFirstChildOfClass("SpecialMesh")
                if mesh then
                    pcall(function()
                        seBTP:InvokeServer("SyncMesh", {{
                            Part = parte,
                            MeshId = "",
                            TextureId = "",
                            Scale = Vector3.new(1, 1, 1)
                        }})
                    end)
                    task.wait(0.1)
                    pcall(function() mesh:Destroy() end)
                end
                restauradas = restauradas + 1
            else
                -- Tinha mesh: aplica de volta
                pcall(function()
                    seBTP:InvokeServer("CreateMeshes", {{Part = parte}})
                end)
                task.wait(0.1)
                pcall(function()
                    seBTP:InvokeServer("SyncMesh", {{
                        Part = parte,
                        MeshId = dadosParte.meshId,
                        TextureId = dadosParte.textureId,
                        Scale = Vector3.new(dadosParte.scale[1], dadosParte.scale[2], dadosParte.scale[3])
                    }})
                end)
                restauradas = restauradas + 1
                task.wait(0.15)
            end
        end
    end

    -- CORREÇÃO: reaplica roupa DEPOIS de restaurar meshes
    task.wait(0.3)
    reaplicarRoupas(char, dados.shirtId, dados.pantsId, dados.tshirtId)

    notifySucesso("Restauradas " .. restauradas .. " partes")
end

-- ============== RESTAURAR APARÊNCIA ==============
function BG.botaoRestaurarAparencia()
    local char = plr.Character
    if not char then notifyErro("Character não encontrado") return end

    local seBTP = getFork3XEndpoint()
    if not seBTP then notifyErro("Building Tools+ não equipada") return end

    local dados = lerAparencia()
    if not dados then
        notifyErro("Nenhum save encontrado")
        notifyInfo("Feminiza uma vez antes pra criar o save")
        return
    end

    notifyInfo("Restaurando aparência...")
    task.wait(0.3)

    local restauradas = 0

    for nomeParte, dadosParte in pairs(dados.meshes) do
        local parte = char:FindFirstChild(nomeParte)
        if parte and parte:IsA("BasePart") then
            local mesh = parte:FindFirstChildOfClass("SpecialMesh")

            if dadosParte.meshId == "" then
                -- Não tinha mesh original: só destrói a mesh que ficou
                if mesh then
                    pcall(function() mesh:Destroy() end)
                end
                restauradas = restauradas + 1
            else
                -- Tinha mesh: aplica de volta
                pcall(function()
                    seBTP:InvokeServer("CreateMeshes", {{Part = parte}})
                end)
                task.wait(0.1)
                pcall(function()
                    seBTP:InvokeServer("SyncMesh", {{
                        Part = parte,
                        MeshId = dadosParte.meshId,
                        TextureId = dadosParte.textureId,
                        Scale = Vector3.new(dadosParte.scale[1], dadosParte.scale[2], dadosParte.scale[3])
                    }})
                end)
                restauradas = restauradas + 1
                task.wait(0.15)
            end
        end
    end

    -- Shirt
    if dados.shirtId then
        local shirt = char:FindFirstChildOfClass("Shirt")
        if not shirt then
            shirt = Instance.new("Shirt")
            shirt.Parent = char
        end
        pcall(function() shirt.ShirtTemplate = dados.shirtId end)
    end

    -- Pants
    if dados.pantsId then
        local pants = char:FindFirstChildOfClass("Pants")
        if not pants then
            pants = Instance.new("Pants")
            pants.Parent = char
        end
        pcall(function() pants.PantsTemplate = dados.pantsId end)
    end

    notifySucesso("Restauradas " .. restauradas .. " partes")
end

-- ============== REANIMATE (FakeChar via Instance.new) ==============
local reanimateAtivo = false
local fakeCharModel = nil
local reanimateConns = {}

local FAKE_CHAR_BLUEPRINT = {
  SourceName = "FakeChar";
  ClassName = "Model";
  Descendants = {
    { Name = "Right Arm"; ClassName = "Part"; CFrame = CFrame.new(-1.500017, 11.000000, -0.000013, 1,0,0, 0,1,0, 0,0,1); Size = Vector3.new(1,2,1); Color = Color3.fromRGB(255,0,0); Material = Enum.Material.Plastic; Transparency = 0.5; Reflectance = 0; Anchored = false; CanCollide = true; Shape = Enum.PartType.Block; },
    { Name = "Head"; ClassName = "Part"; CFrame = CFrame.new(0, 12.5, 0, 1,0,0, 0,1,0, 0,0,1); Size = Vector3.new(2,1,1); Color = Color3.fromRGB(255,0,0); Material = Enum.Material.Plastic; Transparency = 0.5; Reflectance = 0; Anchored = false; CanCollide = true; Shape = Enum.PartType.Block; },
    { Name = "Face"; ClassName = "Decal"; Texture = "rbxthumb://type=Asset&id=3112638914&w=420&h=420"; Transparency = 0; },
    { Name = "Mesh"; ClassName = "SpecialMesh"; MeshType = Enum.MeshType.Head; Scale = Vector3.new(1.25,1.25,1.25); Offset = Vector3.new(0,0,0); },
    { Name = "Left Arm"; ClassName = "Part"; CFrame = CFrame.new(1.5, 11, 0, 1,0,0, 0,1,0, 0,0,1); Size = Vector3.new(1,2,1); Color = Color3.fromRGB(255,0,0); Material = Enum.Material.Plastic; Transparency = 0.5; Reflectance = 0; Anchored = false; CanCollide = true; Shape = Enum.PartType.Block; },
    { Name = "Torso"; ClassName = "Part"; CFrame = CFrame.new(0, 11, 0, 1,0,0, 0,1,0, 0,0,1); Size = Vector3.new(2,2,1); Color = Color3.fromRGB(255,0,0); Material = Enum.Material.Plastic; Transparency = 0.5; Reflectance = 0; Anchored = false; CanCollide = true; Shape = Enum.PartType.Block; },
    { Name = "Mesh"; ClassName = "SpecialMesh"; MeshType = Enum.MeshType.Torso; Scale = Vector3.new(1,1,1); Offset = Vector3.new(0,0,0); },
    { Name = "HumanoidRootPart"; ClassName = "Part"; CFrame = CFrame.new(0, 11, 0, 1,0,0, 0,1,0, 0,0,1); Size = Vector3.new(2,2,1); Color = Color3.fromRGB(163,162,165); Material = Enum.Material.Plastic; Transparency = 1; Reflectance = 0; Anchored = true; CanCollide = true; Shape = Enum.PartType.Block; },
    { Name = "Right Leg"; ClassName = "Part"; CFrame = CFrame.new(0.5, 9, 0, 1,0,0, 0,1,0, 0,0,1); Size = Vector3.new(1,2,1); Color = Color3.fromRGB(255,0,0); Material = Enum.Material.Plastic; Transparency = 0.5; Reflectance = 0; Anchored = false; CanCollide = true; Shape = Enum.PartType.Block; },
    { Name = "Left Leg"; ClassName = "Part"; CFrame = CFrame.new(-0.5, 9, 0, 1,0,0, 0,1,0, 0,0,1); Size = Vector3.new(1,2,1); Color = Color3.fromRGB(255,0,0); Material = Enum.Material.Plastic; Transparency = 0.5; Reflectance = 0; Anchored = false; CanCollide = true; Shape = Enum.PartType.Block; },
    { Name = "Right Shoulder"; ClassName = "Motor6D"; Part0 = "Torso"; Part1 = "Right Arm"; C0 = CFrame.new(1,0.5,0, 0,0,1, 0,1,0, -1,0,0); C1 = CFrame.new(2.5,0.5,0, 0,0,1, 0,1,0, -1,0,0); },
    { Name = "Left Shoulder"; ClassName = "Motor6D"; Part0 = "Torso"; Part1 = "Left Arm"; C0 = CFrame.new(-1,0.5,0, 0,0,-1, 0,1,0, 1,0,0); C1 = CFrame.new(-2.5,0.5,0, 0,0,-1, 0,1,0, 1,0,0); },
    { Name = "Neck"; ClassName = "Motor6D"; Part0 = "Torso"; Part1 = "Head"; C0 = CFrame.new(0,1,0, -1,0,0, 0,0,1, 0,1,0); C1 = CFrame.new(0,-0.5,0, -1,0,0, 0,0,1, 0,1,0); },
    { Name = "Right Hip"; ClassName = "Motor6D"; Part0 = "Torso"; Part1 = "Right Leg"; C0 = CFrame.new(1,-1,0, 0,0,1, 0,1,0, -1,0,0); C1 = CFrame.new(0.5,1,0, 0,0,1, 0,1,0, -1,0,0); },
    { Name = "Left Hip"; ClassName = "Motor6D"; Part0 = "Torso"; Part1 = "Left Leg"; C0 = CFrame.new(-1,-1,0, 0,0,-1, 0,1,0, 1,0,0); C1 = CFrame.new(-0.5,1,0, 0,0,-1, 0,1,0, 1,0,0); },
    { Name = "RootJoint"; ClassName = "Motor6D"; Part0 = "HumanoidRootPart"; Part1 = "Torso"; C0 = CFrame.new(0,0,0, -1,0,0, 0,0,1, 0,1,0); C1 = CFrame.new(0,0,0, -1,0,0, 0,0,1, 0,1,0); },
    { Name = "Humanoid"; ClassName = "Humanoid"; },
    { Name = "Animator"; ClassName = "Animator"; },
  };
}

local function applyPartProps(part, data)
    if data.Color then part.Color = data.Color end
    if data.Material then part.Material = data.Material end
    if data.Transparency then part.Transparency = data.Transparency end
    if data.Reflectance then part.Reflectance = data.Reflectance end
    if data.CanCollide ~= nil then part.CanCollide = data.CanCollide end
    if data.Shape then pcall(function() part.Shape = data.Shape end) end
end

local function buildFakeChar()
    local model = Instance.new("Model")
    model.Name = "FakeChar"
    model.Parent = workspace

    local parts = {}
    local deferred = {}

    for _, data in ipairs(FAKE_CHAR_BLUEPRINT.Descendants) do
        if data.ClassName == "Part" then
            local p = Instance.new("Part")
            p.Name = data.Name
            p.Anchored = true
            p.CanCollide = data.CanCollide or false
            p.Size = data.Size or Vector3.new(1,1,1)
            p.CFrame = CFrame.new(0, -160, 0)
            applyPartProps(p, data)
            p.Parent = model
            parts[data.Name] = p
        else
            table.insert(deferred, data)
        end
    end

    for _, data in ipairs(deferred) do
        if data.ClassName == "SpecialMesh" or data.ClassName == "Decal" then
            local target = parts["Torso"]
            if data.ClassName == "Decal" and data.Name == "Face" then target = parts["Head"] end
            if data.ClassName == "SpecialMesh" and data.MeshType == Enum.MeshType.Head then target = parts["Head"] end
            if target then
                local obj = Instance.new(data.ClassName)
                obj.Name = data.Name
                if data.MeshType then obj.MeshType = data.MeshType end
                if data.MeshId then obj.MeshId = data.MeshId end
                if data.TextureId then obj.TextureId = data.TextureId end
                if data.Scale then obj.Scale = data.Scale end
                if data.Offset then obj.Offset = data.Offset end
                if data.Texture and obj:IsA("Decal") then obj.Texture = data.Texture end
                if data.Transparency then obj.Transparency = data.Transparency end
                obj.Parent = target
            end
        elseif data.ClassName == "Motor6D" then
            local m = Instance.new("Motor6D")
            m.Name = data.Name
            m.Part0 = parts[data.Part0]
            m.Part1 = parts[data.Part1]
            if data.C0 then m.C0 = data.C0 end
            if data.C1 then m.C1 = data.C1 end
            m.Parent = parts[data.Part0] or model
        elseif data.ClassName == "Humanoid" then
            local h = Instance.new("Humanoid")
            h.Parent = model
        elseif data.ClassName == "Animator" then
            local a = Instance.new("Animator")
            a.Parent = model:FindFirstChildOfClass("Humanoid") or model
        end
    end

    return model, parts
end

local function desconectarTudo()
    for _, c in ipairs(reanimateConns) do
        pcall(function()
            if typeof(c) == "RBXScriptConnection" then c:Disconnect() end
        end)
    end
    reanimateConns = {}
end

-- ============== REANIMATE PRÓPRIO (approach: char original no void) ==============
local reanimateAtivo = false
local fakeCharModel = nil
local reanimateConns = {}

-- hook de LoadAnimation: bloqueia animações no char original
local _loadAnimationOriginal = nil
local _loadAnimationHookAtivo = false

local function ativarHookLoadAnimation()
    if _loadAnimationHookAtivo then return end
    if type(hookmetamethod) ~= "function" or type(newcclosure) ~= "function" then return end
    _loadAnimationHookAtivo = true

    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if _loadAnimationHookAtivo and (method == "LoadAnimation" or method == "loadAnimation") then
            if not checkcaller() and typeof(self) == "Instance" and (self:IsA("Humanoid") or self:IsA("Animator")) then
                -- cria uma AnimationTrack dummy pra não crashar o caller
                local anim = Instance.new("Animation")
                anim.AnimationId = "rbxassetid://0"
                local track = self:FindFirstChildOfClass("Animator")
                if not track then
                    track = Instance.new("Animator")
                    track.Parent = self
                end
                local ok, result = pcall(function() return oldNamecall(self, ...) end)
                if ok then return result end
                return nil
            end
        end
        return oldNamecall(self, ...)
    end)
    setreadonly(mt, true)
end

local function desativarHookLoadAnimation()
    if not _loadAnimationHookAtivo then return end
    _loadAnimationHookAtivo = false
end

-- cria FakeChar (mesmo blueprint de antes, agora correto)
local FAKE_CHAR_BLUEPRINT = {
  Descendants = {
    { Name = "Right Arm"; ClassName = "Part"; CFrame = CFrame.new(-1.5, 11, 0); Size = Vector3.new(1,2,1); Color = Color3.fromRGB(255,0,0); Material = Enum.Material.Plastic; Transparency = 0.5; Anchored = false; CanCollide = true; Shape = Enum.PartType.Block; },
    { Name = "Head"; ClassName = "Part"; CFrame = CFrame.new(0, 12.5, 0); Size = Vector3.new(2,1,1); Color = Color3.fromRGB(255,0,0); Material = Enum.Material.Plastic; Transparency = 0.5; Anchored = false; CanCollide = true; Shape = Enum.PartType.Block; },
    { Name = "Face"; ClassName = "Decal"; Texture = "rbxthumb://type=Asset&id=3112638914&w=420&h=420"; Transparency = 0; },
    { Name = "Left Arm"; ClassName = "Part"; CFrame = CFrame.new(1.5, 11, 0); Size = Vector3.new(1,2,1); Color = Color3.fromRGB(255,0,0); Material = Enum.Material.Plastic; Transparency = 0.5; Anchored = false; CanCollide = true; Shape = Enum.PartType.Block; },
    { Name = "Torso"; ClassName = "Part"; CFrame = CFrame.new(0, 11, 0); Size = Vector3.new(2,2,1); Color = Color3.fromRGB(255,0,0); Material = Enum.Material.Plastic; Transparency = 0.5; Anchored = false; CanCollide = true; Shape = Enum.PartType.Block; },
    { Name = "HumanoidRootPart"; ClassName = "Part"; CFrame = CFrame.new(0, 11, 0); Size = Vector3.new(2,2,1); Color = Color3.fromRGB(163,162,165); Material = Enum.Material.Plastic; Transparency = 1; Anchored = false; CanCollide = false; Shape = Enum.PartType.Block; },
    { Name = "Right Leg"; ClassName = "Part"; CFrame = CFrame.new(0.5, 9, 0); Size = Vector3.new(1,2,1); Color = Color3.fromRGB(255,0,0); Material = Enum.Material.Plastic; Transparency = 0.5; Anchored = false; CanCollide = true; Shape = Enum.PartType.Block; },
    { Name = "Left Leg"; ClassName = "Part"; CFrame = CFrame.new(-0.5, 9, 0); Size = Vector3.new(1,2,1); Color = Color3.fromRGB(255,0,0); Material = Enum.Material.Plastic; Transparency = 0.5; Anchored = false; CanCollide = true; Shape = Enum.PartType.Block; },
    { Name = "Right Shoulder"; ClassName = "Motor6D"; Part0 = "Torso"; Part1 = "Right Arm"; C0 = CFrame.new(1,0.5,0) * CFrame.Angles(0,0,math.rad(-90)); C1 = CFrame.new(2.5,0.5,0) * CFrame.Angles(0,0,math.rad(-90)); },
    { Name = "Left Shoulder"; ClassName = "Motor6D"; Part0 = "Torso"; Part1 = "Left Arm"; C0 = CFrame.new(-1,0.5,0) * CFrame.Angles(0,0,math.rad(90)); C1 = CFrame.new(-2.5,0.5,0) * CFrame.Angles(0,0,math.rad(90)); },
    { Name = "Neck"; ClassName = "Motor6D"; Part0 = "Torso"; Part1 = "Head"; C0 = CFrame.new(0,1,0) * CFrame.Angles(0,math.rad(180),math.rad(180)); C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(0,math.rad(180),math.rad(180)); },
    { Name = "Right Hip"; ClassName = "Motor6D"; Part0 = "Torso"; Part1 = "Right Leg"; C0 = CFrame.new(1,-1,0) * CFrame.Angles(0,0,math.rad(-90)); C1 = CFrame.new(0.5,1,0) * CFrame.Angles(0,0,math.rad(-90)); },
    { Name = "Left Hip"; ClassName = "Motor6D"; Part0 = "Torso"; Part1 = "Left Leg"; C0 = CFrame.new(-1,-1,0) * CFrame.Angles(0,0,math.rad(90)); C1 = CFrame.new(-0.5,1,0) * CFrame.Angles(0,0,math.rad(90)); },
    { Name = "RootJoint"; ClassName = "Motor6D"; Part0 = "HumanoidRootPart"; Part1 = "Torso"; C0 = CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(180),math.rad(180)); C1 = CFrame.new(0,0,0) * CFrame.Angles(0,math.rad(180),math.rad(180)); },
    { Name = "Humanoid"; ClassName = "Humanoid"; },
    { Name = "Animator"; ClassName = "Animator"; },
  };
}

local function buildFakeChar()
    local model = Instance.new("Model")
    model.Name = "BL5CK_FakeChar"
    model.Parent = workspace

    local parts = {}
    local deferred = {}
    for _, data in ipairs(FAKE_CHAR_BLUEPRINT.Descendants) do
        if data.ClassName == "Part" then
            local p = Instance.new("Part")
            p.Name = data.Name
            p.Anchored = true
            p.CanCollide = data.CanCollide or false
            p.Size = data.Size
            p.CFrame = data.CFrame + Vector3.new(0, -160, 0)
            p.Color = data.Color
            p.Material = data.Material
            p.Transparency = data.Transparency or 0
            p.Parent = model
            parts[data.Name] = p
        else
            table.insert(deferred, data)
        end
    end
    for _, data in ipairs(deferred) do
        if data.ClassName == "Decal" then
            local target = parts["Head"]
            if target then
                local d = Instance.new("Decal")
                d.Name = data.Name
                d.Texture = data.Texture
                d.Transparency = data.Transparency or 0
                d.Parent = target
            end
        elseif data.ClassName == "Motor6D" then
            local m = Instance.new("Motor6D")
            m.Name = data.Name
            m.Part0 = parts[data.Part0]
            m.Part1 = parts[data.Part1]
            m.C0 = data.C0
            m.C1 = data.C1
            m.Parent = parts[data.Part0] or model
        elseif data.ClassName == "Humanoid" then
            local h = Instance.new("Humanoid")
            h.RigType = Enum.HumanoidRigType.R6
            h.BreakJointsOnDeath = false
            h.Parent = model
        elseif data.ClassName == "Animator" then
            local a = Instance.new("Animator")
            a.Parent = model:FindFirstChildOfClass("Humanoid") or model
        end
    end

    model.PrimaryPart = parts["HumanoidRootPart"]
    return model, parts
end

-- ============== TOGGLE ==============
function BG.toggleReanimate(ativar)
    if ativar then
        if reanimateAtivo then return end
        local char = plr.Character
        if not char then notifyErro("Character nao encontrado!") return end
        local hrpP = char:FindFirstChild("HumanoidRootPart")
        local humP = char:FindFirstChildOfClass("Humanoid")
        if not hrpP or not humP then notifyErro("HRP/Humanoid nao encontrado!") return end

        reanimateAtivo = true
        notifyInfo("Construindo FakeChar...")

        -- 1) cria FakeChar no void (y = -160)
        local model, parts = buildFakeChar()
        fakeCharModel = model
        if not parts["Torso"] then
            notifyErro("FakeChar sem Torso!")
            model:Destroy(); reanimateAtivo = false; return
        end

        -- 2) coloca o FakeChar no chão do player atual
        local startPos = hrpP.Position
        local offset = CFrame.new(startPos + Vector3.new(0, -0.5, 0))
        local origemRoot = CFrame.new(0, -160, 0)
        local desloc = offset * origemRoot:Inverse()
        for _, p in ipairs(parts) do
            p.CFrame = desloc * p.CFrame
        end

        -- 3) ativa hook de animação (bloqueia animações no char original)
        ativarHookLoadAnimation()

        -- 4) guarda estado original
        local origState = {
            WalkSpeed = humP.WalkSpeed,
            JumpPower = humP.JumpPower,
            Anchored = hrpP.Anchored,
            Transparency = {},
            CanCollide = {},
        }
        for _, v in ipairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                origState.Transparency[v] = v.Transparency
                origState.CanCollide[v] = v.CanCollide
                v.Transparency = 1
                v.CanCollide = false
                v.CanTouch = false
                v.CanQuery = false
            elseif v:IsA("Decal") or v:IsA("Texture") then
                origState.Transparency[v] = v.Transparency
                v.Transparency = 1
            end
        end
        _G.BlackGUI._reanimateOrigState = origState

        -- 5) câmera trava no FakeChar
        local camera = workspace.CurrentCamera
        local fakeHead = parts["Head"]
        local fakeHum = model:FindFirstChildOfClass("Humanoid")
        pcall(function() camera.CameraSubject = fakeHum end)

        -- 6) HRP do player vai pro VOID toda frame
        local VOID_Y = -50000
        local RunService = game:GetService("RunService")
        local UIS = game:GetService("UserInputService")

        -- 6.1) desancora HRP e empurra pro void
        hrpP.Anchored = false
        hrpP.CFrame = CFrame.new(hrpP.Position.X, VOID_Y, hrpP.Position.Z)

        -- 6.2) prende HRP no void (re-aplica toda frame)
        local voidConn = RunService.Heartbeat:Connect(function()
            if not reanimateAtivo then return end
            if not hrpP or not hrpP.Parent then return end
            hrpP.CFrame = CFrame.new(hrpP.Position.X, VOID_Y, hrpP.Position.Z)
            hrpP.AssemblyLinearVelocity = Vector3.zero
            hrpP.AssemblyAngularVelocity = Vector3.zero
        end)
        table.insert(reanimateConns, voidConn)

        -- 6.3) HRP no void = câmera na cabeça do FakeChar
        table.insert(reanimateConns, RunService.RenderStepped:Connect(function()
            if not reanimateAtivo then return end
            if camera.CameraSubject ~= fakeHum and fakeHum.Parent then
                camera.CameraSubject = fakeHum
            end
            if parts["Head"] and parts["Head"].Parent then
                -- ajusta FOV/câmera pra bater com a posição do FakeChar
            end
        end))

        -- 7) movimento: FakeChar anda com WASD
        local WALK_SPEED = 16
        local JUMP_POWER = 50
        local velocity = Vector3.zero
        local onGround = false
        local jumpCooldown = 0

        local function getMoveInput()
            local move = Vector3.zero
            if UIS:IsKeyDown(Enum.KeyCode.W) then move += Vector3.new(0, 0, -1) end
            if UIS:IsKeyDown(Enum.KeyCode.S) then move += Vector3.new(0, 0, 1) end
            if UIS:IsKeyDown(Enum.KeyCode.A) then move += Vector3.new(-1, 0, 0) end
            if UIS:IsKeyDown(Enum.KeyCode.D) then move += Vector3.new(1, 0, 0) end
            if move.Magnitude > 1 then move = move.Unit end
            return move
        end

        local function getJumpDown()
            return UIS:IsKeyDown(Enum.KeyCode.Space)
        end

        table.insert(reanimateConns, RunService.Heartbeat:Connect(function(dt)
            if not reanimateAtivo then return end
            local root = parts["HumanoidRootPart"]
            if not root or not root.Parent then return end
            if not fakeHum or not fakeHum.Parent then return end

            -- aplica gravidade
            velocity = Vector3.new(velocity.X, velocity.Y - workspace.Gravity * dt, velocity.Z)

            -- input de movimento
            local move = getMoveInput()
            local camera = workspace.CurrentCamera
            local camLook = camera.CFrame.LookVector
            local camRight = camera.CFrame.RightVector
            local flatLook = Vector3.new(camLook.X, 0, camLook.Z)
            if flatLook.Magnitude > 0.01 then flatLook = flatLook.Unit end
            local flatRight = Vector3.new(camRight.X, 0, camRight.Z)
            if flatRight.Magnitude > 0.01 then flatRight = flatRight.Unit end

            local worldMove = flatLook * -move.Z + flatRight * move.X
            if worldMove.Magnitude > 1 then worldMove = worldMove.Unit end

            local targetXZ = worldMove * WALK_SPEED
            -- aceleração
            velocity = Vector3.new(
                targetXZ.X,
                velocity.Y,
                targetXZ.Z
            )

            -- jump
            if getJumpDown() and onGround and os.clock() > jumpCooldown then
                velocity = Vector3.new(velocity.X, JUMP_POWER, velocity.Z)
                onGround = false
                jumpCooldown = os.clock() + 0.2
            end

            -- raycast pra detectar chão
            local rayParams = RaycastParams.new()
            rayParams.FilterDescendantsInstances = { model }
            rayParams.FilterType = Enum.RaycastFilterType.Exclude
            local hit = workspace:Raycast(root.Position, Vector3.new(0, -3.5, 0), rayParams)
            if hit then
                if velocity.Y < 0 then velocity = Vector3.new(velocity.X, 0, velocity.Z) end
                onGround = true
            else
                onGround = false
            end

            -- aplica velocidade
            local newPos = root.Position + velocity * dt
            root.CFrame = CFrame.new(newPos) * root.CFrame.Rotation
            root.AssemblyLinearVelocity = velocity

            -- rotaciona o FakeChar pra direção do movimento
            if worldMove.Magnitude > 0.1 then
                local targetAngle = math.atan2(worldMove.X, worldMove.Z)
                local currentAngle = math.atan2(root.CFrame.LookVector.X, root.CFrame.LookVector.Z)
                local diff = targetAngle - currentAngle
                while diff > math.pi do diff -= math.pi * 2 end
                while diff < -math.pi do diff += math.pi * 2 end
                local newAngle = currentAngle + diff * math.min(1, dt * 10)
                root.CFrame = CFrame.new(newPos) * CFrame.Angles(0, newAngle, 0)
            end

            -- desancora o root se ficou ancorado por algum motivo
            if root.Anchored then root.Anchored = false end
        end))

        -- 8) força HRP do player a ficar sempre no void (mesmo se cair)
        local heartbeatVoid = RunService.Heartbeat:Connect(function()
            if not reanimateAtivo then return end
            if humP.Health > 0 then
                humP.Health = 100
            end
        end)
        table.insert(reanimateConns, heartbeatVoid)

        -- 9) guarda referências globais
        _G.BlackGUI.FakeChar = model
        _G.BlackGUI.FakeCharParts = parts
        _G.BlackGUI.FakeCharHumanoid = fakeHum
        _G.BlackGUI.FakeCharRoot = parts["HumanoidRootPart"]

        notifySucesso("Reanimate ativo! Use WASD e Espaço.")

    else
        if not reanimateAtivo then return end
        reanimateAtivo = false

        -- 10) restaura estado original
        local char = plr.Character
        if char then
            local humP = char:FindFirstChildOfClass("Humanoid")
            local hrpP = char:FindFirstChild("HumanoidRootPart")
            if humP then
                humP.Health = 100
            end
            if hrpP then
                hrpP.Anchored = false
                -- devolve o player pra uma posição segura perto do FakeChar
                if _G.BlackGUI.FakeCharRoot then
                    hrpP.CFrame = CFrame.new(_G.BlackGUI.FakeCharRoot.Position + Vector3.new(0, 5, 0))
                end
            end
            local origState = _G.BlackGUI._reanimateOrigState
            if origState then
                for _, v in ipairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.Transparency = origState.Transparency[v] or 0
                        v.CanCollide = origState.CanCollide[v] or true
                        v.CanTouch = true
                        v.CanQuery = true
                    elseif v:IsA("Decal") or v:IsA("Texture") then
                        v.Transparency = origState.Transparency[v] or 0
                    end
                end
            end
        end

        -- 11) desativa hook de animação
        desativarHookLoadAnimation()

        -- 12) limpa conexões
        for _, c in ipairs(reanimateConns) do
            pcall(function()
                if typeof(c) == "RBXScriptConnection" then c:Disconnect() end
            end)
        end
        reanimateConns = {}

        -- 13) destrói o FakeChar
        if fakeCharModel then
            pcall(function() fakeCharModel:Destroy() end)
            fakeCharModel = nil
        end

        _G.BlackGUI.FakeChar = nil
        _G.BlackGUI.FakeCharParts = nil
        _G.BlackGUI.FakeCharHumanoid = nil
        _G.BlackGUI.FakeCharRoot = nil
        _G.BlackGUI._reanimateOrigState = nil

        notifyInfo("Reanimate desligado")
    end
end
    print("[Jogador] Modulo carregado")
