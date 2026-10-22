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
        pcall(function() seBTP:InvokeServer("CreateMeshes", {{Part = parte}}) end)
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
                Part = parte, Face = face, TextureType = "Decal"
            }})
        end)
    end
    task.wait(0.1)
    for _, face in ipairs(TODAS_FACES) do
        pcall(function()
            seBTP:InvokeServer("SyncTexture", {{
                Part = parte, Face = face, TextureType = "Decal",
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
                if mesh then pcall(function() mesh:Destroy() end) end
                restauradas = restauradas + 1
            else
                pcall(function() seBTP:InvokeServer("CreateMeshes", {{Part = parte}}) end)
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
        if not shirt then shirt = Instance.new("Shirt") shirt.Parent = char end
        pcall(function() shirt.ShirtTemplate = dados.shirtId end)
    end
    if dados.pantsId then
        local pants = char:FindFirstChildOfClass("Pants")
        if not pants then pants = Instance.new("Pants") pants.Parent = char end
        pcall(function() pants.PantsTemplate = dados.pantsId end)
    end

    notifySucesso("Restauradas " .. restauradas .. " partes")
end

function BG.toggleReanimate(ativar)
    if ativar then
        if reanimateAtivo then return end
        local seBTP = getFork3XEndpoint()
        if not seBTP then notifyErro("Building Tools+ nao encontrada!") return end
        local char = plr.Character
        if not char then notifyErro("Character nao encontrado!") return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then notifyErro("Humanoid nao encontrado!") return end
        if hum.RigType ~= Enum.HumanoidRigType.R6 then
            notifyErro("So funciona em R6")
            return
        end
        local hrpPlayer = char:FindFirstChild("HumanoidRootPart")
        if not hrpPlayer then notifyErro("HRP nao encontrado!") return end

        reanimateAtivo = true
        notifyInfo("Construindo FakeChar...")

        -- ============ 1. CRIA PARTES (tudo block, exceto Head) ============
        local PART_MAP = {"HumanoidRootPart", "Torso", "Head", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}
        local PART_SIZES = {
            ["HumanoidRootPart"] = Vector3.new(2,2,1),
            ["Torso"] = Vector3.new(2,2,1),
            ["Head"] = Vector3.new(2,1,1),
            ["Left Arm"] = Vector3.new(1,2,1),
            ["Right Arm"] = Vector3.new(1,2,1),
            ["Left Leg"] = Vector3.new(1,2,1),
            ["Right Leg"] = Vector3.new(1,2,1),
        }

        local parts = {}
        local listaParts = {}

        for _, name in ipairs(PART_MAP) do
            local p = F3X:CreatePart("Normal", CFrame.new(0, -250, 0), workspace)
            if p then
                p.Name = "BG_" .. name:gsub(" ", "")
                F3X:Resize(p, PART_SIZES[name])
                F3X:SetCollision(p, false)
                F3X:Anchor(p)
                pcall(function() p.Massless = true end)

                -- copia cor do player
                local playerPart = char:FindFirstChild(name)
                if playerPart and playerPart:IsA("BasePart") then
                    pcall(function() F3X:SetColor(p, playerPart.Color) end)
                end

                -- HRP invisível
                if name == "HumanoidRootPart" then
                    pcall(function() seBTP:InvokeServer("SyncMaterial", {{Part = p, Transparency = 1}}) end)
                end

                parts[name] = p
                table.insert(listaParts, p)
            end
            task.wait(0.03)
        end

        if not parts["Torso"] then
            notifyErro("Falha ao criar partes!")
            for _, p in ipairs(listaParts) do pcall(function() F3X:Remove(p) end) end
            reanimateAtivo = false
            return
        end

        -- ============ 2. MESH SÓ NA CABEÇA ============
        if parts["Head"] then
            pcall(function() seBTP:InvokeServer("CreateMeshes", {{Part = parts["Head"]}}) end)
            task.wait(0.05)
            pcall(function()
                seBTP:InvokeServer("SyncMesh", {{
                    Part = parts["Head"],
                    MeshId = "",
                    TextureId = "",
                    Scale = Vector3.new(1.25, 1.25, 1.25)
                }})
            end)
            task.wait(0.05)
            -- força MeshType.Head
            pcall(function()
                local sm = parts["Head"]:FindFirstChildOfClass("SpecialMesh")
                if sm then sm.MeshType = Enum.MeshType.Head end
            end)
        end

        -- ============ 3. FACE COPIADA DO PLAYER ============
        local faceOriginal = nil
        local headPlayer = char:FindFirstChild("Head")
        if headPlayer then
            local face = headPlayer:FindFirstChild("Face") or headPlayer:FindFirstChildOfClass("Decal")
            if face and face:IsA("Decal") then
                faceOriginal = face.Texture
            end
        end

        if parts["Head"] and faceOriginal then
            pcall(function()
                seBTP:InvokeServer("CreateTextures", {{
                    Part = parts["Head"],
                    Face = Enum.NormalId.Front,
                    TextureType = "Decal"
                }})
            end)
            task.wait(0.1)
            pcall(function()
                seBTP:InvokeServer("SyncTexture", {{
                    Part = parts["Head"],
                    Face = Enum.NormalId.Front,
                    TextureType = "Decal",
                    Texture = faceOriginal
                }})
            end)
            task.wait(0.1)
        end

        -- ============ 4. ROUPAS COPIADAS ============
        local TODAS_FACES = {Enum.NormalId.Front, Enum.NormalId.Back, Enum.NormalId.Left, Enum.NormalId.Right, Enum.NormalId.Top, Enum.NormalId.Bottom}
        local function aplicarTextura(part, tex)
            if not part or not tex then return end
            for _, face in ipairs(TODAS_FACES) do
                pcall(function() seBTP:InvokeServer("CreateTextures", {{Part = part, Face = face, TextureType = "Decal"}}) end)
            end
            task.wait(0.1)
            for _, face in ipairs(TODAS_FACES) do
                pcall(function() seBTP:InvokeServer("SyncTexture", {{Part = part, Face = face, TextureType = "Decal", Texture = tex}}) end)
            end
            task.wait(0.1)
        end

        local shirt = char:FindFirstChildOfClass("Shirt")
        local pants = char:FindFirstChildOfClass("Pants")
        local shirtId = shirt and shirt.ShirtTemplate or nil
        local pantsId = pants and pants.PantsTemplate or nil

        if pantsId then
            if parts["Left Leg"] then aplicarTextura(parts["Left Leg"], pantsId) end
            if parts["Right Leg"] then aplicarTextura(parts["Right Leg"], pantsId) end
        end
        if shirtId then
            if parts["Torso"] then aplicarTextura(parts["Torso"], shirtId) end
            if parts["Left Arm"] then aplicarTextura(parts["Left Arm"], shirtId) end
            if parts["Right Arm"] then aplicarTextura(parts["Right Arm"], shirtId) end
        end

        -- ============ 5. POSICIONA ============
        local baseCF = hrpPlayer.CFrame
        parts["HumanoidRootPart"].CFrame = baseCF
        parts["Torso"].CFrame = baseCF
        parts["Head"].CFrame = baseCF * CFrame.new(0, 1.5, 0)
        parts["Left Arm"].CFrame = baseCF * CFrame.new(-1.5, 0, 0)
        parts["Right Arm"].CFrame = baseCF * CFrame.new(1.5, 0, 0)
        parts["Left Leg"].CFrame = baseCF * CFrame.new(-0.5, -2, 0)
        parts["Right Leg"].CFrame = baseCF * CFrame.new(0.5, -2, 0)

        -- ============ 6. AGRUPA ============
        local grupo = nil
        pcall(function() grupo = seBTP:InvokeServer("CreateGroup", "Model", workspace, listaParts) end)
        task.wait(0.3)
        if not grupo then
            grupo = Instance.new("Model")
            grupo.Name = "FakeChar"
            grupo.Parent = workspace
            for _, p in ipairs(listaParts) do
                if p and p.Parent then p.Parent = grupo end
            end
        else
            pcall(function() F3X:SetName(grupo, "FakeChar") end)
        end

        fakeCharModel = grupo
        fakeCharParts = parts
        _G.BlackGUI.FakeChar = grupo
        _G.BlackGUI.FakeCharParts = parts

        -- ============ 7. ESCONDE PLAYER (SERVER-SIDE) ============
        notifyInfo("Escondendo personagem...")

        local CORPO = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "HumanoidRootPart"}
        for _, name in ipairs(CORPO) do
            local p = char:FindFirstChild(name)
            if p and p:IsA("BasePart") then
                pcall(function() seBTP:InvokeServer("SyncMaterial", {{Part = p, Transparency = 1}}) end)
            end
        end

        for _, v in ipairs(char:GetDescendants()) do
            if v:IsA("Accessory") or v:IsA("Hat") then
                local handle = v:FindFirstChild("Handle")
                if handle and handle:IsA("BasePart") then
                    pcall(function() seBTP:InvokeServer("SyncMaterial", {{Part = handle, Transparency = 1}}) end)
                end
            end
        end

        -- ============ 8. LOOP PARALELO (cada parte independente) ============
        notifyInfo("Iniciando loop paralelo...")

        reanimateTask = task.spawn(function()
            local RS = game:GetService("RunService")
            local ULTIMO_GUARD = 0.03  -- 30ms (evita flood, ~33fps)
            local ultimo = 0

            while reanimateAtivo do
                RS.Heartbeat:Wait()
                local agora = os.clock()
                if agora - ultimo >= ULTIMO_GUARD then
                    ultimo = agora
                    local charAtual = plr.Character
                    if charAtual then
                        -- PARALELO: cada parte move/rota/escala em task.spawn separada
                        for name, fakePart in pairs(fakeCharParts) do
                            local realPart = charAtual:FindFirstChild(name)
                            if realPart and realPart:IsA("BasePart") and fakePart and fakePart.Parent then
                                task.spawn(function()
                                    -- Posição + rotação
                                    pcall(function() F3X:Move(fakePart, realPart.CFrame) end)
                                    -- Escala (se mudou)
                                    if (fakePart.Size - realPart.Size).Magnitude > 0.01 then
                                        pcall(function() F3X:Resize(fakePart, realPart.Size) end)
                                    end
                                    -- Cor (se mudou)
                                    if fakePart.Color ~= realPart.Color then
                                        pcall(function() F3X:SetColor(fakePart, realPart.Color) end)
                                    end
                                end)
                            end
                        end
                    end
                end
            end
        end)

        notifySucesso("FakeChar ativo!")
    else
        if not reanimateAtivo then return end
        reanimateAtivo = false

        if reanimateTask then
            pcall(function() task.cancel(reanimateTask) end)
            reanimateTask = nil
        end

        local seBTP = getFork3XEndpoint()
        local char = plr.Character
        if char and seBTP then
            local CORPO = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "HumanoidRootPart"}
            for _, name in ipairs(CORPO) do
                local p = char:FindFirstChild(name)
                if p and p:IsA("BasePart") then
                    pcall(function() seBTP:InvokeServer("SyncMaterial", {{Part = p, Transparency = 0}}) end)
                end
            end
            for _, v in ipairs(char:GetDescendants()) do
                if v:IsA("Accessory") or v:IsA("Hat") then
                    local handle = v:FindFirstChild("Handle")
                    if handle and handle:IsA("BasePart") then
                        pcall(function() seBTP:InvokeServer("SyncMaterial", {{Part = handle, Transparency = 0}}) end)
                    end
                end
            end
        end

        if fakeCharModel then pcall(function() fakeCharModel:Destroy() end); fakeCharModel = nil end
        for _, p in pairs(fakeCharParts) do
            if p and p.Parent then pcall(function() F3X:Remove(p) end) end
        end
        fakeCharParts = {}

        _G.BlackGUI.FakeChar = nil
        _G.BlackGUI.FakeCharParts = nil
        notifyInfo("FakeChar removido")
    end
end 
print("[Jogador] Modulo carregado")
