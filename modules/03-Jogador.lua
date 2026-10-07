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

print("[Jogador] Modulo carregado")
