-- =========================================================
-- MÓDULO 05 - MAPA (Obby, NPC, Meteorito, Bandeira, Mapa Rápido, Natural Disaster, Metero Áudio)
-- =========================================================

local BG = _G.BlackGUI
local Players = BG.Players
local plr = BG.plr
local playerGui = BG.playerGui
local notifySucesso = BG.notifySucesso
local notifyErro = BG.notifyErro
local notifyInfo = BG.notifyInfo
local cmdHD = BG.cmdHD
local F3X = BG.F3X
local getFork3XEndpoint = BG.getFork3XEndpoint

-- ============== BANDEIRA ==============
function BG.botaoBandeira()
    notifyInfo("Construindo bandeira...")
    local pos = Vector3.new(0, 5, 0)
    local cores = {
        Color3.fromRGB(200,100,180), Color3.fromRGB(245,169,184),
        Color3.fromRGB(255,230,0), Color3.fromRGB(255,255,255),
        Color3.fromRGB(255,230,0), Color3.fromRGB(80,200,240),
        Color3.fromRGB(91,206,250)
    }
    local alturas = {1,1,1,2,1,1,1}
    local alturaAtual = pos.Y
    for i, cor in ipairs(cores) do
        local a = alturas[i]
        local p = F3X:CreatePart("Normal", CFrame.new(pos.X, alturaAtual + a/2, pos.Z), workspace)
        if p then
            F3X:Resize(p, Vector3.new(20, a, 2))
            F3X:SetColor(p, cor)
            F3X:Anchor(p)
            alturaAtual = alturaAtual + a
        end
    end
    notifySucesso("Bandeira construida")
end

-- ============== METEORITO GIGANTE ==============
function BG.botaoMeteorito()
    notifyInfo("Meteorito caindo...")
    local parte = F3X:CreatePart("Normal", CFrame.new(0, 500, 0), workspace)
    if not parte then return end
    F3X:Resize(parte, Vector3.new(100, 100, 100))
    task.wait(0.5)
    F3X:Unanchor(parte)
    task.spawn(function()
        local parado = 0
        while parte and parte.Parent do
            local vel = Vector3.new(0, 0, 0)
            pcall(function() vel = parte.AssemblyLinearVelocity end)
            if vel.Magnitude < 1 then
                parado = parado + 0.1
                if parado > 0.5 then
                    local ponto = parte.Position
                    local bola = F3X:CreatePart("Ball", CFrame.new(ponto), workspace)
                    if bola then
                        F3X:Resize(bola, Vector3.new(10, 10, 10))
                        F3X:SetColor(bola, Color3.fromRGB(255, 0, 0))
                        F3X:SetTransparency(bola, 0.4)
                        F3X:Anchor(bola)
                        pcall(function() F3X:Remove(parte) end)
                        local tam = 10
                        while tam < 1500 and bola and bola.Parent do
                            tam = tam + 50
                            pcall(function() F3X:Resize(bola, Vector3.new(tam, tam, tam)) end)
                            task.wait(0.05)
                        end
                        task.wait(1)
                        pcall(function() F3X:Remove(bola) end)
                    end
                    break
                end
            else
                parado = 0
            end
            task.wait(0.1)
        end
        notifySucesso("Meteorito concluido")
    end)
end

-- ============== MAPA RÁPIDO ==============
function BG.botaoConstruirMapaRapido()
    notifyInfo("Construindo mapa...")

local MEU_BLUEPRINT = {
  {n="Terrain", cf={0.0000,0.0000,0.0000,1.0000,0.0000,0.0000,0.0000,1.0000,0.0000,0.0000,0.0000,1.0000}, s=Vector3.new(2044.00,252.00,2044.00), c=Color3.fromRGB(163,162,165), m="Plastic", t=0.00, col=true, anc=true},
  {n="Part", cf={-38.0000,63.5000,-31.5000,0.0000,0.0000,-1.0000,0.0000,1.0000,0.0000,1.0000,0.0000,0.0000}, s=Vector3.new(16.00,1.00,2.00), c=Color3.fromRGB(99,49,255), m="Plastic", t=0.00, col=true, anc=true},
  {n="Part", cf={-38.0000,57.5000,-31.5000,0.0000,0.0000,-1.0000,0.0000,1.0000,0.0000,1.0000,0.0000,0.0000}, s=Vector3.new(16.00,1.00,2.00), c=Color3.fromRGB(255,102,204), m="Plastic", t=0.00, col=true, anc=true},
  {n="Part", cf={-37.0000,59.5217,-29.7064,0.0000,-0.0000,-1.0000,-0.6428,-0.7661,-0.0000,-0.7661,0.6428,-0.0000}, s=Vector3.new(4.20,1.00,0.00), c=Color3.fromRGB(0,255,0), m="Plastic", t=0.00, col=true, anc=true},
  {n="Part", cf={-37.0000,60.4267,-32.6298,0.0000,0.0000,-1.0000,-0.7661,0.6428,-0.0000,0.6428,0.7661,0.0000}, s=Vector3.new(6.10,1.00,0.00), c=Color3.fromRGB(0,255,0), m="Plastic", t=0.00, col=true, anc=true},
  {n="Part", cf={-38.0000,58.5000,-31.5000,0.0000,0.0000,-1.0000,0.0000,1.0000,0.0000,1.0000,0.0000,0.0000}, s=Vector3.new(16.00,1.00,2.00), c=Color3.fromRGB(255,249,145), m="Plastic", t=0.00, col=true, anc=true},
  {n="Part", cf={-38.0000,61.5000,-31.5000,0.0000,0.0000,-1.0000,0.0000,1.0000,0.0000,1.0000,0.0000,0.0000}, s=Vector3.new(16.00,1.00,2.00), c=Color3.fromRGB(255,249,145), m="Plastic", t=0.00, col=true, anc=true},
  {n="Part", cf={-36.5020,60.1482,7.7553,0.0000,-0.0000,-1.0000,-0.6428,-0.7661,-0.0000,-0.7661,0.6428,-0.0000}, s=Vector3.new(4.20,1.00,0.00), c=Color3.fromRGB(0,255,0), m="Plastic", t=0.00, col=true, anc=true},
  {n="Part", cf={-36.5016,61.0531,4.8320,0.0000,0.0000,-1.0000,-0.7661,0.6428,-0.0000,0.6428,0.7661,0.0000}, s=Vector3.new(6.10,1.00,0.00), c=Color3.fromRGB(0,255,0), m="Plastic", t=0.00, col=true, anc=true},
  {n="Part", cf={-38.0000,60.0000,-31.5000,0.0000,0.0000,-1.0000,0.0000,1.0000,0.0000,1.0000,0.0000,0.0000}, s=Vector3.new(16.00,2.00,2.00), c=Color3.fromRGB(255,255,255), m="Plastic", t=0.00, col=true, anc=true},
  {n="SpawnLocation", cf={20.0000,0.5000,0.0000,1.0000,0.0000,0.0000,0.0000,1.0000,0.0000,0.0000,0.0000,1.0000}, s=Vector3.new(12.00,1.00,12.00), c=Color3.fromRGB(0,0,0), m="Plastic", t=0.00, col=true, anc=true},
  {n="Part", cf={-38.0000,32.0000,-15.0000,0.0000,0.0000,-1.0000,0.0000,1.0000,0.0000,1.0000,0.0000,0.0000}, s=Vector3.new(49.00,64.00,2.00), c=Color3.fromRGB(163,162,165), m="Plastic", t=1.00, col=true, anc=true, decals={{face="Decal", tex=139385026360175, transp=0.00}}},
  {n="Part", cf={-38.0000,60.5279,6.1500,0.0000,0.0000,-1.0000,1.0000,0.0000,0.0000,0.0000,-1.0000,0.0000}, s=Vector3.new(6.63,1.41,2.82), c=Color3.fromRGB(0,0,0), m="Plastic", t=0.00, col=true, anc=true},
  {n="Part", cf={-37.9999,61.8684,8.7605,0.0000,0.0000,-1.0000,-1.0000,0.0000,0.0000,0.0000,1.0000,0.0000}, s=Vector3.new(4.09,1.41,2.82), c=Color3.fromRGB(0,0,0), m="Plastic", t=0.00, col=true, anc=true},
  {n="Part", cf={-37.9999,63.2090,4.8094,0.0000,0.0000,-1.0000,0.0000,-1.0000,-0.0000,-1.0000,0.0000,-0.0000}, s=Vector3.new(3.95,1.41,2.82), c=Color3.fromRGB(0,0,0), m="Plastic", t=0.00, col=true, anc=true},
  {n="Part", cf={-37.9999,57.8467,7.4905,0.0000,0.0000,-1.0000,0.0000,-1.0000,-0.0000,-1.0000,0.0000,-0.0000}, s=Vector3.new(3.95,1.41,2.82), c=Color3.fromRGB(0,0,0), m="Plastic", t=0.00, col=true, anc=true},
  {n="Part", cf={-38.0000,60.5279,6.1500,0.0000,0.0000,-1.0000,0.0000,1.0000,0.0000,1.0000,0.0000,0.0000}, s=Vector3.new(6.63,1.41,2.82), c=Color3.fromRGB(0,0,0), m="Plastic", t=0.00, col=true, anc=true},
  {n="Part", cf={-37.9999,59.1167,3.5394,0.0000,0.0000,-1.0000,-1.0000,0.0000,0.0000,0.0000,1.0000,0.0000}, s=Vector3.new(4.23,1.41,2.82), c=Color3.fromRGB(0,0,0), m="Plastic", t=0.00, col=true, anc=true},
  {n="SpawnLocation", cf={-7.0000,0.5000,-28.0000,1.0000,0.0000,0.0000,0.0000,1.0000,0.0000,0.0000,0.0000,1.0000}, s=Vector3.new(12.00,1.00,12.00), c=Color3.fromRGB(0,0,0), m="Plastic", t=0.00, col=true, anc=true},
  {n="SpawnLocation", cf={20.0000,0.5000,-28.0000,1.0000,0.0000,0.0000,0.0000,1.0000,0.0000,0.0000,0.0000,1.0000}, s=Vector3.new(12.00,1.00,12.00), c=Color3.fromRGB(0,0,0), m="Plastic", t=0.00, col=true, anc=true},
  {n="SpawnLocation", cf={-7.0000,0.5000,0.0000,1.0000,0.0000,0.0000,0.0000,1.0000,0.0000,0.0000,0.0000,1.0000}, s=Vector3.new(12.00,1.00,12.00), c=Color3.fromRGB(0,0,0), m="Plastic", t=0.00, col=true, anc=true},
  {n="Part", cf={0.0000,-0.5000,0.0000,1.0000,0.0000,0.0000,0.0000,1.0000,0.0000,0.0000,0.0000,1.0000}, s=Vector3.new(230.00,1.00,230.00), c=Color3.fromRGB(85,85,85), m="Asphalt", t=0.00, col=true, anc=true},
  {n="Part", cf={-38.0000,62.5000,-31.5000,0.0000,0.0000,-1.0000,0.0000,1.0000,0.0000,1.0000,0.0000,0.0000}, s=Vector3.new(16.00,1.00,2.00), c=Color3.fromRGB(44,141,255), m="Plastic", t=0.00, col=true, anc=true},
  {n="Part", cf={-38.0000,56.5000,-31.5000,0.0000,0.0000,-1.0000,0.0000,1.0000,0.0000,1.0000,0.0000,0.0000}, s=Vector3.new(16.00,1.00,2.00), c=Color3.fromRGB(183,70,190), m="Plastic", t=0.00, col=true, anc=true},
}

    cmdHD(";punish all")

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            pcall(function() F3X:Remove(obj) end)
        end
    end

    local criadas = {}
    for i, d in ipairs(BLUEPRINT) do
        local cf = CFrame.new(d.cf[1],d.cf[2],d.cf[3],d.cf[4],d.cf[5],d.cf[6],d.cf[7],d.cf[8],d.cf[9],d.cf[10],d.cf[11],d.cf[12])
        local p = F3X:CreatePart("Normal", cf, workspace)
        if p then table.insert(criadas, {parte = p, dados = d}) end
    end

    for _, info in ipairs(criadas) do
        local p = info.parte
        local d = info.dados
        pcall(function() F3X:SetName(p, d.n) end)
        pcall(function() F3X:Resize(p, d.s) end)
        pcall(function() F3X:SetColor(p, d.c) end)
        pcall(function() F3X:Anchor(p) end)
        pcall(function() F3X:SetCollision(p, true) end)
        pcall(function() F3X:SetMaterial(p, d.m) end)
    end

    cmdHD(";refresh all")
    notifySucesso("Mapa construido")
end

-- ============== NPC CONTROLÁVEL ==============
local npcParts = {}
local npcPivot = nil
local partOffsets = {}
local animationGroups = {bracoEsq={},bracoDir={},pernaEsq={},pernaDir={},head={},torso={}}
local isWalking = false
local walkFrame = 0
local walkTask = nil
local controlGui = nil
local alturaOriginal = nil

local NPC_BLUEPRINT = {
    {n="Arm", cf={-10.3823,2.1216,-6.056,0.9965,0.0559,0.0622,-0.0526,0.9972,-0.054,-0.065,0.0505,0.9966}, s=Vector3.new(1,2,1), c=Color3.fromRGB(255,191,127)},
    {n="Head", cf={-8.9,3.7054,-5.9804,1,0,0,0,0.9994,0.0349,0,-0.0349,0.9994}, s=Vector3.new(1,1,1), c=Color3.fromRGB(255,191,127)},
    {n="Torso", cf={-8.9,2.1971,-6.0474,1,0,0,0,0.9994,0.0349,0,-0.0349,0.9994}, s=Vector3.new(2,2,1), c=Color3.fromRGB(0,0,0)},
    {n="Right Leg", cf={-9.4,0.1983,-5.9777,1,0,0,0,0.9994,0.0349,0,-0.0349,0.9994}, s=Vector3.new(1,2,1), c=Color3.fromRGB(0,0,0)},
    {n="Arm", cf={-7.2853,2.0025,-6.1336,0.996,-0.081,0.0377,0.0809,0.9967,0.0029,-0.0378,0.0002,0.9993}, s=Vector3.new(1,2,1), c=Color3.fromRGB(255,191,127)},
    {n="Left Leg", cf={-8.4,0.1983,-5.9777,1,0,0,0,0.9994,0.0349,0,-0.0349,0.9994}, s=Vector3.new(1,2,1), c=Color3.fromRGB(0,0,0)},
}

local function moverNPC(direcao)
    if not npcPivot then return end
    local vel = 0.5
    local dirVec = Vector3.new(0, 0, 0)
    if direcao == "frente" then dirVec = Vector3.new(0, 0, -vel)
    elseif direcao == "tras" then dirVec = Vector3.new(0, 0, vel)
    elseif direcao == "esquerda" then dirVec = Vector3.new(-vel, 0, 0)
    elseif direcao == "direita" then dirVec = Vector3.new(vel, 0, 0) end
    local novaPos = npcPivot.Position + dirVec
    F3X:Move(npcPivot, CFrame.new(novaPos))
    for parte, dados in pairs(partOffsets) do
        local novaPosP = novaPos + dados.offset
        local cf = parte.CFrame
        F3X:Move(parte, CFrame.new(novaPosP) * (cf - cf.Position))
    end
end

local function animarGrupo(grupo, rotX)
    if not grupo then return end
    for _, p in ipairs(grupo) do
        F3X:Move(p, p.CFrame * CFrame.Angles(math.rad(rotX or 0), 0, 0))
    end
end

local function resetarGrupo(grupo)
    if not grupo then return end
    for _, p in ipairs(grupo) do
        local d = partOffsets[p]
        if d then F3X:Move(p, d.originalCF) end
    end
end

local function iniciarCaminhada()
    if isWalking then return end
    isWalking = true
    walkTask = task.spawn(function()
        while isWalking do
            walkFrame = walkFrame + 1
            if walkFrame > 4 then walkFrame = 1 end
            local fases = {{0,0,0,0},{-30,30,30,-30},{0,0,0,0},{30,-30,-30,30}}
                local fase = fases[walkFrame]
            animarGrupo(animationGroups.bracoEsq, fase[1])
            animarGrupo(animationGroups.bracoDir, fase[2])
            animarGrupo(animationGroups.pernaEsq, fase[3])
            animarGrupo(animationGroups.pernaDir, fase[4])
            task.wait(0.1)
        end
    end)
end

local function pararCaminhada()
    isWalking = false
    if walkTask then task.cancel(walkTask) walkTask = nil end
    resetarGrupo(animationGroups.bracoEsq)
    resetarGrupo(animationGroups.bracoDir)
    resetarGrupo(animationGroups.pernaEsq)
    resetarGrupo(animationGroups.pernaDir)
end

local function deletarNPC()
    if not npcPivot then return end
    for _, p in ipairs(npcParts) do
        if p and p.Parent then pcall(function() F3X:Remove(p) end) end
    end
    if npcPivot and npcPivot.Parent then pcall(function() F3X:Remove(npcPivot) end) end
    npcParts = {}
    npcPivot = nil
    partOffsets = {}
    animationGroups = {bracoEsq={},bracoDir={},pernaEsq={},pernaDir={},head={},torso={}}
    notifySucesso("NPC deletado")
end

function BG.criarNPC()
    if npcPivot then notifyErro("Ja existe um NPC!") return end
    notifyInfo("Criando NPC...")
    local pivotPos = Vector3.new(0, 20, 0)
    npcPivot = F3X:CreatePart("Normal", CFrame.new(pivotPos), workspace)
    if not npcPivot then return end
    F3X:Resize(npcPivot, Vector3.new(0.1, 0.1, 0.1))
    F3X:SetTransparency(npcPivot, 1)
    F3X:Anchor(npcPivot)
    F3X:SetCollision(npcPivot, false)

    local armCount = 0
    for _, d in ipairs(NPC_BLUEPRINT) do
        local cf = CFrame.new(d.cf[1],d.cf[2],d.cf[3],d.cf[4],d.cf[5],d.cf[6],d.cf[7],d.cf[8],d.cf[9],d.cf[10],d.cf[11],d.cf[12])
        local p = F3X:CreatePart("Normal", cf, workspace)
        if p then
            F3X:Resize(p, d.s)
            F3X:SetColor(p, d.c)
            F3X:Anchor(p)
            F3X:SetCollision(p, true)
            p.CFrame = cf
            partOffsets[p] = {offset = cf.Position - pivotPos, originalCF = cf, nome = d.n}
            if d.n == "Arm" then
                armCount = armCount + 1
                if armCount == 1 then table.insert(animationGroups.bracoEsq, p) else table.insert(animationGroups.bracoDir, p) end
            elseif d.n == "Left Leg" then table.insert(animationGroups.pernaEsq, p)
            elseif d.n == "Right Leg" then table.insert(animationGroups.pernaDir, p)
            elseif d.n == "Head" then table.insert(animationGroups.head, p)
            elseif d.n == "Torso" then table.insert(animationGroups.torso, p) end
            table.insert(npcParts, p)
        end
    end

    local vel = 0.5
    while true do
        if not npcPivot then break end
        local pos = npcPivot.Position
        local rp = RaycastParams.new()
        rp.FilterDescendantsInstances = {npcPivot, unpack(npcParts)}
        rp.FilterType = Enum.RaycastFilterType.Exclude
        local res = workspace:Raycast(pos + Vector3.new(0,-3,0), Vector3.new(0,-50,0), rp)
        if res or pos.Y <= 1 then
            alturaOriginal = pos.Y
            break
        end
        moverNPC("frente")
        moverNPC("tras")
        task.wait(0.05)
    end

    for p, d in pairs(partOffsets) do
        d.offset = p.CFrame.Position - npcPivot.Position
        d.originalCF = p.CFrame
    end

    controlGui = Instance.new("ScreenGui")
    controlGui.Name = "BG_NPCControl"
    controlGui.ResetOnSpawn = false
    controlGui.Parent = playerGui
    local mf = Instance.new("Frame")
    mf.Size = UDim2.new(0, 250, 0, 350)
    mf.Position = UDim2.new(0.5, -125, 0.5, -175)
    mf.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    mf.BorderSizePixel = 0
    mf.Active = true
    mf.Draggable = true
    mf.Parent = controlGui
    Instance.new("UICorner", mf).CornerRadius = UDim.new(0, 8)

    local tit = Instance.new("TextLabel")
    tit.Size = UDim2.new(1, 0, 0, 30)
    tit.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    tit.Text = "Controle do NPC"
    tit.TextColor3 = Color3.fromRGB(255, 255, 255)
    tit.Font = Enum.Font.GothamBold
    tit.TextSize = 14
    tit.Parent = mf
    Instance.new("UICorner", tit).CornerRadius = UDim.new(0, 8)

    local function mkBtn(txt, x, y, w, h, down, up)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, w, 0, h)
        b.Position = UDim2.new(0, x, 0, y)
        b.BackgroundColor3 = Color3.fromRGB(70, 90, 120)
        b.Text = txt
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 20
        b.Parent = mf
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        if down then b.MouseButton1Down:Connect(down) end
        if up then b.MouseButton1Up:Connect(up) end
        return b
    end

    mkBtn("▲", 95, 40, 60, 60, function()
        iniciarCaminhada()
        while isWalking do moverNPC("frente") task.wait(0.1) end
    end, function() pararCaminhada() end)

    mkBtn("▼", 95, 160, 60, 60, function()
        iniciarCaminhada()
        while isWalking do moverNPC("tras") task.wait(0.1) end
    end, function() pararCaminhada() end)

    mkBtn("◄", 10, 100, 60, 60, function()
        iniciarCaminhada()
        while isWalking do moverNPC("esquerda") task.wait(0.1) end
    end, function() pararCaminhada() end)

    mkBtn("►", 180, 100, 60, 60, function()
        iniciarCaminhada()
        while isWalking do moverNPC("direita") task.wait(0.1) end
    end, function() pararCaminhada() end)

    mkBtn("PULAR", 95, 230, 100, 40, function()
        if not npcPivot then return end
        task.spawn(function()
            for i = 1, 20 do
                moverNPC("frente")
                if npcPivot then F3X:Move(npcPivot, CFrame.new(npcPivot.Position + Vector3.new(0, 0.25, 0))) end
                task.wait(0.05)
            end
            while npcPivot and npcPivot.Position.Y > alturaOriginal do
                F3X:Move(npcPivot, CFrame.new(npcPivot.Position - Vector3.new(0, 0.3, 0)))
                task.wait(0.05)
            end
        end)
    end)

    local fechar = Instance.new("TextButton")
    fechar.Size = UDim2.new(0, 25, 0, 25)
    fechar.Position = UDim2.new(1, -28, 0, 3)
    fechar.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    fechar.Text = "X"
    fechar.TextColor3 = Color3.fromRGB(255, 255, 255)
    fechar.Font = Enum.Font.GothamBold
    fechar.TextSize = 12
    fechar.Parent = mf
    Instance.new("UICorner", fechar).CornerRadius = UDim.new(0, 6)
    fechar.MouseButton1Click:Connect(function()
        deletarNPC()
        if controlGui then controlGui:Destroy() controlGui = nil end
    end)

    notifySucesso("NPC criado")
end

-- ============== NATURAL DISASTER ==============
function BG.botaoNaturalDisaster()
    notifyInfo("Baixando blueprint...")
    local ok, result = pcall(function()
        local url = "https://pastefy.app/CFOyXL51/raw"
        local content = game:HttpGet(url)
        if not content or #content < 10 then error("Conteudo invalido") end
        return loadstring(content)()
    end)

    if not ok or type(result) ~= "table" then
        notifyErro("Falha ao carregar blueprint")
        return
    end

    local BP = result
    local total = #BP
    if total == 0 then notifyErro("Blueprint vazio") return end
    notifySucesso("Blueprint carregado: " .. total .. " partes")

    cmdHD(";punish all")

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            task.spawn(function() pcall(function() F3X:Remove(obj) end) end)
        end
    end
    task.wait(0.5)

    local criadas = {}
    local n = 0
    for i, d in ipairs(BP) do
        task.spawn(function()
            local cf = CFrame.new(d.cf[1],d.cf[2],d.cf[3],d.cf[4],d.cf[5],d.cf[6],d.cf[7],d.cf[8],d.cf[9],d.cf[10],d.cf[11],d.cf[12])
            local p = F3X:CreatePart("Normal", cf, workspace)
            if p then criadas[i] = {parte = p, dados = d} n = n + 1 end
        end)
    end
    while n < total do task.wait(0.01) end

    for _, info in ipairs(criadas) do
        task.spawn(function()
            local p = info.parte
            local d = info.dados
            pcall(function() F3X:SetName(p, d.n) end)
            pcall(function() F3X:Resize(p, d.s) end)
            pcall(function() F3X:SetColor(p, d.c) end)
            pcall(function() F3X:Anchor(p) end)
            pcall(function() F3X:SetCollision(p, d.col ~= false) end)
            pcall(function() F3X:SetMaterial(p, d.m) end)
            if d.t and d.t > 0 then pcall(function() F3X:SetTransparency(p, d.t) end) end
        end)
    end
    task.wait(2)

    cmdHD(";respawn all")
    notifySucesso("Natural Disaster instalado")
end

-- ============== METERO ÁUDIO ==============
local meteroRodando = false

function BG.executarMeteroAudio()
    if meteroRodando then
        notifyInfo("Ja esta rodando")
        return
    end
    meteroRodando = true

    local seBTP = getFork3XEndpoint()
    if not seBTP then notifyErro("Building Tools+ nao equipada") meteroRodando = false return end
    if not BG.rc then notifyErro("HD Admin nao achado") meteroRodando = false return end

    cmdHD(";music 792323017")
    task.wait(0.5)
    for i = 3, 1, -1 do
        cmdHD(";serverHint " .. i)
        task.wait(1)
    end
    cmdHD(";serverHint 0")
    task.wait(0.3)
    cmdHD(";unmusic")

    local posSpawn = Vector3.new(0, 1000, 0)
    local rotacao = CFrame.Angles(0, 0, math.rad(-90))

    local antes = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then antes[obj] = true end
    end

    seBTP:InvokeServer("CreatePart", "Normal", CFrame.new(posSpawn) * rotacao, workspace)
    task.wait(1)

    local parte = nil
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not antes[obj] then
            parte = obj
            break
        end
    end

    if not parte then warn("[Metero] Parte nao criada") meteroRodando = false return end

    seBTP:InvokeServer("SyncResize", {{Part = parte, CFrame = CFrame.new(posSpawn) * rotacao, Size = Vector3.new(50, 13, 13)}})
    task.wait(0.5)
    seBTP:InvokeServer("CreateMeshes", {{Part = parte}})
    task.wait(0.6)
    seBTP:InvokeServer("SyncMesh", {{Part = parte, MeshId = "rbxassetid://14797474634", TextureId = "rbxassetid://14797476659", Scale = Vector3.new(1, 1, 1)}})
    task.wait(0.6)
    pcall(function()
        seBTP:InvokeServer("SyncDecorate", {{Part = parte, DecorationType = "Mesh", Texture = "rbxassetid://14797476659"}})
    end)
    task.wait(0.4)
    seBTP:InvokeServer("SyncAnchor", {{Part = parte, Anchored = false}})

    local caiu = false
    local tempo = 0
    while not caiu and tempo < 60 do
        task.wait(0.15)
        tempo = tempo + 0.15
        if not parte or not parte.Parent then break end
        local vel = Vector3.new(0, 0, 0)
        pcall(function() vel = parte.AssemblyLinearVelocity end)
        if vel.Magnitude < 0.5 and parte.Position.Y < 50 then caiu = true end
    end

    cmdHD(";music 138680390593747")
    local ponto = parte and parte.Position or Vector3.new(0, 5, 0)
    local esferas = {}

    for _, cor in ipairs({Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,0)}) do
        local antesE = {}
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then antesE[obj] = true end
        end
        seBTP:InvokeServer("CreatePart", "Ball", CFrame.new(ponto), workspace)
        task.wait(0.7)
        local e = nil
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not antesE[obj] then e = obj break end
        end
        if e then
            table.insert(esferas, e)
            pcall(function() seBTP:InvokeServer("SyncColor", {{Part = e, Color = cor, UnionColoring = false}}) end)
            pcall(function() seBTP:InvokeServer("SyncAnchor", {{Part = e, Anchored = true}}) end)
            pcall(function() seBTP:InvokeServer("SyncCollision", {{Part = e, CanCollide = true}}) end)
        end
    end

    task.spawn(function()
        local tam = 5
        while tam < 4500 do
            task.wait(0.08)
            tam = tam + 75
            if tam > 4500 then tam = 4500 end
            for _, e in ipairs(esferas) do
                if e and e.Parent then
                    pcall(function() seBTP:InvokeServer("SyncResize", {{Part = e, CFrame = e.CFrame, Size = Vector3.new(tam, tam, tam)}}) end)
                end
            end
        end
        task.wait(0.5)
        for _, e in ipairs(esferas) do
            if e and e.Parent then pcall(function() seBTP:InvokeServer("Remove", {{Part = e}}) end) end
        end
        if parte and parte.Parent then pcall(function() seBTP:InvokeServer("Remove", {{Part = parte}}) end) end
    end)

    for _, e in ipairs(esferas) do
        e.Touched:Connect(function(hit)
            local char = hit:FindFirstAncestorOfClass("Model")
            if char then
                local p = Players:GetPlayerFromCharacter(char)
                if p and char:FindFirstChild("Humanoid") then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            pcall(function() seBTP:InvokeServer("Remove", {{Part = part}}) end)
                        end
                    end
                end
            end
        end)
    end

    local t = 0
    while t < 120 do
        task.wait(0.5)
        t = t + 0.5
        local som = nil
        for _, obj in ipairs(game:GetService("SoundService"):GetDescendants()) do
            if obj:IsA("Sound") and string.find(tostring(obj.SoundId), "138680390593747", 1, true) then som = obj break end
        end
        if not som then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("Sound") and string.find(tostring(obj.SoundId), "138680390593747", 1, true) then som = obj break end
            end
        end
        if som then
            if not som.Playing or (som.TimeLength > 0 and som.TimePosition >= som.TimeLength - 0.5) then break end
        elseif t > 5 then break end
    end

    cmdHD(";unmusic")
    meteroRodando = false
    notifySucesso("Metero Audio concluido")
end

print("[Mapa] Modulo carregado")
