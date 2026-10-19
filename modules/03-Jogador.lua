-- =========================================================
-- MÓDULO 03 - JOGADOR (Clone, Zumbi, Tools, Tóxico, Armadilha, Reanimate)
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
if not hookOk then warn("[Jogador] Anti-un hook indisponivel") end

-- ============== TOOL INVISIBLE ==============
function BG.botaoCriarToolInvisible()
    if plr.Backpack:FindFirstChild("InvisibleTool") then
        notifyErro("Tool ja existe!")
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

        local r = defs["Part5"].cf
        local refCF  = CFrame.new(r[1],r[2],r[3],r[4],r[5],r[6],r[7],r[8],r[9],r[10],r[11],r[12])
        local refInv = refCF:Inverse()
        local destinoRoot = torso.CFrame * CFrame.new(0, 0.5, 0)

        local partes = {}

        for nome, d in pairs(defs) do
            local cf = CFrame.new(d.cf[1],d.cf[2],d.cf[3],d.cf[4],d.cf[5],d.cf[6],d.cf[7],d.cf[8],d.cf[9],d.cf[10],d.cf[11],d.cf[12])
            local offset  = refInv * cf
            local finalCF = destinoRoot * offset

            local p = F3X:CreatePart("Ball", finalCF, workspace)
            if p then
                F3X:Resize(p, d.s)
                pcall(function() p.Shape = Enum.PartType.Ball end)
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

        for nome, p in pairs(partes) do
            pcall(function()
                seBTP:InvokeServer("CreateConstraints", {p}, {}, torso, "Weld")
            end)
            task.wait(0.05)
        end

        task.wait(0.3)

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

-- ============== FEMINIZAR (R6) ==============
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

local function aplicarTexturaEmTodasFaces(seBTP, parte, textureId)
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

local function extrairIdDaUrl(url)
    if not url or url == "" then return nil end
    local id = url:match("rbxassetid://(%d+)")
    if not id then id = url:match("id=(%d+)") end
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

    task.wait(0.3)
    local dados = lerAparencia()
    if dados then
        local shirtId = extrairIdDaUrl(dados.shirtId)
        local pantsId = extrairIdDaUrl(dados.pantsId)

        if pantsId then
            for _, nomeParte in ipairs({"Left Leg", "Right Leg"}) do
                local parte = char:FindFirstChild(nomeParte)
                if parte then
                    aplicarTexturaEmTodasFaces(seBTP, parte, pantsId)
                    task.wait(0.2)
                end
            end
        end

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

    if aplicadas > 0 then
        notifySucesso("Feminizada em " .. aplicadas .. " partes")
    else
        notifyErro("Nenhuma parte encontrada")
    end
end

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
                if mesh then
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
        end
    end

    if dados.shirtId then
        local shirt = char:FindFirstChildOfClass("Shirt")
        if not shirt then
            shirt = Instance.new("Shirt")
            shirt.Parent = char
        end
        pcall(function() shirt.ShirtTemplate = dados.shirtId end)
    end

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

-- ============== REANIMATE (próprio, char original no void) ==============
local reanimateAtivo = false
local fakeCharModel = nil
local reanimateConns = {}
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
                return nil
            end
        end
        return oldNamecall(self, ...)
    end)
    setreadonly(mt, true)
end

local function desativarHookLoadAnimation()
    _loadAnimationHookAtivo = false
end

local FAKE_CHAR_BLUEPRINT = {
  Descendants = {
    { Name = "Right Arm"; ClassName = "Part"; CFrame = CFrame.new(-1.5, 11, 0); Size = Vector3.new(1,2,1); Color = Color3.fromRGB(255,0,0); Transparency = 0.5; },
    { Name = "Head"; ClassName = "Part"; CFrame = CFrame.new(0, 12.5, 0); Size = Vector3.new(2,1,1); Color = Color3.fromRGB(255,0,0); Transparency = 0.5; },
    { Name = "Left Arm"; ClassName = "Part"; CFrame = CFrame.new(1.5, 11, 0); Size = Vector3.new(1,2,1); Color = Color3.fromRGB(255,0,0); Transparency = 0.5; },
    { Name = "Torso"; ClassName = "Part"; CFrame = CFrame.new(0, 11, 0); Size = Vector3.new(2,2,1); Color = Color3.fromRGB(255,0,0); Transparency = 0.5; },
    { Name = "HumanoidRootPart"; ClassName = "Part"; CFrame = CFrame.new(0, 11, 0); Size = Vector3.new(2,2,1); Transparency = 1; },
    { Name = "Right Leg"; ClassName = "Part"; CFrame = CFrame.new(0.5, 9, 0); Size = Vector3.new(1,2,1); Color = Color3.fromRGB(255,0,0); Transparency = 0.5; },
    { Name = "Left Leg"; ClassName = "Part"; CFrame = CFrame.new(-0.5, 9, 0); Size = Vector3.new(1,2,1); Color = Color3.fromRGB(255,0,0); Transparency = 0.5; },
    { Name = "Right Shoulder"; ClassName = "Motor6D"; Part0 = "Torso"; Part1 = "Right Arm"; C0 = CFrame.new(1,0.5,0) * CFrame.Angles(0,0,math.rad(-90)); C1 = CFrame.new(2.5,0.5,0) * CFrame.Angles(0,0,math.rad(-90)); },
    { Name = "Left Shoulder"; ClassName = "Motor6D"; Part0 = "Torso"; Part1 = "Left Arm"; C0 = CFrame.new(-1,0.5,0) * CFrame.Angles(0,0,math.rad(90)); C1 = CFrame.new(-2.5,0.5,0) * CFrame.Angles(0,0,math.rad(90)); },
    { Name = "Neck"; ClassName = "Motor6D"; Part0 = "Torso"; Part1 = "Head"; C0 = CFrame.new(0,1,0) * CFrame.Angles(0,math.rad(180),math.rad(180)); C1 = CFrame.new(0,-0.5,0) * CFrame.Angles(0,math.rad(180),math.rad(180)); },
    { Name = "Right Hip"; ClassName = "Motor6D"; Part0 = "Torso"; Part1 = "Right Leg"; C0 = CFrame.new(1,-1,0) * CFrame.Angles(0,0,math.rad(-90)); C1 = CFrame.new(0.5,1,0) * CFrame.Angles(0,0,math.rad(-90)); },
    { Name = "Left Hip"; ClassName = "Motor6D"; Part0 = "Torso"; Part1 = "Left Leg"; C0 = CFrame.new(-1,-1,0) * CFrame.Angles(0,0,math.rad(90)); C1 = CFrame.new(-0.5,1,0) * CFrame.Angles(0,0,math.rad(90)); },
    { Name = "RootJoint"; ClassName = "Motor6D"; Part0 = "HumanoidRootPart"; Part1 = "Torso"; C0 = CFrame.Angles(0,math.rad(180),math.rad(180)); C1 = CFrame.Angles(0,math.rad(180),math.rad(180)); },
    { Name = "Humanoid"; ClassName = "Humanoid"; },
  };
}

local function buildFakeChar()
    local model = Instance.new("Model")
    model.Name = "BL5CK_FakeChar"
    model.Parent = workspace
    local parts = {}
    local deferred = {}
    for _, d in ipairs(FAKE_CHAR_BLUEPRINT.Descendants) do
        if d.ClassName == "Part" then
            local p = Instance.new("Part")
            p.Name = d.Name
            p.Anchored = true
            p.CanCollide = false
            p.Size = d.Size
            p.CFrame = d.CFrame + Vector3.new(0, -160, 0)
            p.Color = d.Color or Color3.new(1,1,1)
            p.Transparency = d.Transparency or 0
            p.Parent = model
            parts[d.Name] = p
        else
            table.insert(deferred, d)
        end
    end
    for _, d in ipairs(deferred) do
        if d.ClassName == "Motor6D" then
            local m = Instance.new("Motor6D")
            m.Name = d.Name
            m.Part0 = parts[d.Part0]
            m.Part1 = parts[d.Part1]
            m.C0 = d.C0
            m.C1 = d.C1
            m.Parent = parts[d.Part0] or model
        elseif d.ClassName == "Humanoid" then
            local h = Instance.new("Humanoid")
            h.RigType = Enum.HumanoidRigType.R6
            h.BreakJointsOnDeath = false
            h.Parent = model
        end
    end
    model.PrimaryPart = parts["HumanoidRootPart"]
    return model, parts
end

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

        local model, parts = buildFakeChar()
        fakeCharModel = model
        if not parts["Torso"] then
            notifyErro("FakeChar sem Torso!")
            model:Destroy(); reanimateAtivo = false; return
        end

        local desloc = CFrame.new(hrpP.Position + Vector3.new(0, -0.5, 0)) * CFrame.new(0, -160, 0):Inverse()
        for _, p in ipairs(parts) do p.CFrame = desloc * p.CFrame end

        ativarHookLoadAnimation()

        local origState = { Transparency = {}, CanCollide = {} }
        for _, v in ipairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                origState.Transparency[v] = v.Transparency
                origState.CanCollide[v] = v.CanCollide
                v.Transparency = 1
                v.CanCollide = false
            elseif v:IsA("Decal") or v:IsA("Texture") then
                origState.Transparency[v] = v.Transparency
                v.Transparency = 1
            end
        end
        _G.BlackGUI._reanimateOrigState = origState

        local camera = workspace.CurrentCamera
        local fakeHum = model:FindFirstChildOfClass("Humanoid")
        pcall(function() camera.CameraSubject = fakeHum end)

        local VOID_Y = -50000
        local RS = game:GetService("RunService")
        local UIS = game:GetService("UserInputService")

        hrpP.Anchored = false
        hrpP.CFrame = CFrame.new(hrpP.Position.X, VOID_Y, hrpP.Position.Z)

        table.insert(reanimateConns, RS.Heartbeat:Connect(function()
            if not reanimateAtivo or not hrpP or not hrpP.Parent then return end
            hrpP.CFrame = CFrame.new(hrpP.Position.X, VOID_Y, hrpP.Position.Z)
            hrpP.AssemblyLinearVelocity = Vector3.zero
            hrpP.AssemblyAngularVelocity = Vector3.zero
            if humP.Health > 0 then humP.Health = 100 end
        end))

        table.insert(reanimateConns, RS.RenderStepped:Connect(function()
            if not reanimateAtivo then return end
            if camera.CameraSubject ~= fakeHum and fakeHum.Parent then
                camera.CameraSubject = fakeHum
            end
        end))

        local WALK_SPEED, JUMP_POWER = 16, 50
        local vel = Vector3.zero
        local onGround = false
        local jumpCd = 0

        table.insert(reanimateConns, RS.Heartbeat:Connect(function(dt)
            if not reanimateAtivo then return end
            local root = parts["HumanoidRootPart"]
            if not root or not root.Parent then return end
            vel = Vector3.new(vel.X, vel.Y - workspace.Gravity * dt, vel.Z)
            local mv = Vector3.zero
            if UIS:IsKeyDown(Enum.KeyCode.W) then mv += Vector3.new(0,0,-1) end
            if UIS:IsKeyDown(Enum.KeyCode.S) then mv += Vector3.new(0,0,1) end
            if UIS:IsKeyDown(Enum.KeyCode.A) then mv += Vector3.new(-1,0,0) end
            if UIS:IsKeyDown(Enum.KeyCode.D) then mv += Vector3.new(1,0,0) end
            if mv.Magnitude > 1 then mv = mv.Unit end
            local cL = camera.CFrame.LookVector
            local cR = camera.CFrame.RightVector
            local fL = Vector3.new(cL.X, 0, cL.Z)
            if fL.Magnitude > 0.01 then fL = fL.Unit end
            local fR = Vector3.new(cR.X, 0, cR.Z)
            if fR.Magnitude > 0.01 then fR = fR.Unit end
            local wm = fL * -mv.Z + fR * mv.X
            if wm.Magnitude > 1 then wm = wm.Unit end
            vel = Vector3.new(wm.X * WALK_SPEED, vel.Y, wm.Z * WALK_SPEED)
            if UIS:IsKeyDown(Enum.KeyCode.Space) and onGround and os.clock() > jumpCd then
                vel = Vector3.new(vel.X, JUMP_POWER, vel.Z)
                onGround = false
                jumpCd = os.clock() + 0.2
            end
            local rp = RaycastParams.new()
            rp.FilterDescendantsInstances = { model }
            rp.FilterType = Enum.RaycastFilterType.Exclude
            local hit = workspace:Raycast(root.Position, Vector3.new(0,-3.5,0), rp)
            if hit then
                if vel.Y < 0 then vel = Vector3.new(vel.X, 0, vel.Z) end
                onGround = true
            else
                onGround = false
            end
            local newPos = root.Position + vel * dt
            root.CFrame = CFrame.new(newPos) * root.CFrame.Rotation
            root.AssemblyLinearVelocity = vel
            if wm.Magnitude > 0.1 then
                local tA = math.atan2(wm.X, wm.Z)
                local cA = math.atan2(root.CFrame.LookVector.X, root.CFrame.LookVector.Z)
                local diff = tA - cA
                while diff > math.pi do diff -= math.pi*2 end
                while diff < -math.pi do diff += math.pi*2 end
                local nA = cA + diff * math.min(1, dt*10)
                root.CFrame = CFrame.new(newPos) * CFrame.Angles(0, nA, 0)
            end
            if root.Anchored then root.Anchored = false end
        end))

        _G.BlackGUI.FakeChar = model
        _G.BlackGUI.FakeCharParts = parts
        notifySucesso("Reanimate ativo! Use WASD e Espaco.")
    else
        if not reanimateAtivo then return end
        reanimateAtivo = false
        local char = plr.Character
        if char then
            local humP = char:FindFirstChildOfClass("Humanoid")
            local hrpP = char:FindFirstChild("HumanoidRootPart")
            if humP then humP.Health = 100 end
            if hrpP then
                hrpP.Anchored = false
                if _G.BlackGUI.FakeCharParts and _G.BlackGUI.FakeCharParts["HumanoidRootPart"] then
                    hrpP.CFrame = CFrame.new(_G.BlackGUI.FakeCharParts["HumanoidRootPart"].Position + Vector3.new(0,5,0))
                end
            end
            local o = _G.BlackGUI._reanimateOrigState
            if o then
                for _, v in ipairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.Transparency = o.Transparency[v] or 0
                        v.CanCollide = o.CanCollide[v] ~= false
                    elseif v:IsA("Decal") or v:IsA("Texture") then
                        v.Transparency = o.Transparency[v] or 0
                    end
                end
            end
        end
        desativarHookLoadAnimation()
        for _, c in ipairs(reanimateConns) do
            pcall(function() if typeof(c) == "RBXScriptConnection" then c:Disconnect() end end)
        end
        reanimateConns = {}
        if fakeCharModel then pcall(function() fakeCharModel:Destroy() end); fakeCharModel = nil end
        _G.BlackGUI.FakeChar = nil
        _G.BlackGUI.FakeCharParts = nil
        _G.BlackGUI._reanimateOrigState = nil
        notifyInfo("Reanimate desligado")
    end
end

print("[Jogador] Modulo carregado")
