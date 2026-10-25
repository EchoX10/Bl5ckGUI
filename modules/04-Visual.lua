-- =========================================================
-- MÓDULO 04 - VISUAL (Spam, Partículas, Texturizar, Colorir, Música)
-- =========================================================

local BG = _G.BlackGUI
local Players = BG.Players
local SoundService = BG.SoundService
local plr = BG.plr
local notifySucesso = BG.notifySucesso
local notifyErro = BG.notifyErro
local notifyInfo = BG.notifyInfo
local cmdHD = BG.cmdHD
local F3X = BG.F3X
local acharParteReal = BG.acharParteReal
local getFork3XEndpoint = BG.getFork3XEndpoint
local TEXTURE_ID = BG.TEXTURE_ID
local PART_SIZE = BG.PART_SIZE
local SPAWN_DELAY = BG.SPAWN_DELAY

-- ============== TEXTURIZAR ==============
local TODAS_FACES = {Enum.NormalId.Front, Enum.NormalId.Back, Enum.NormalId.Left, Enum.NormalId.Right, Enum.NormalId.Top, Enum.NormalId.Bottom}
local FACES_SPAM = {Enum.NormalId.Front, Enum.NormalId.Back}

local function texturizarUmaFace(parte, face)
    if not BG.se then return end
    pcall(function() BG.se:InvokeServer("CreateTextures", {{Part = parte, Face = face, TextureType = "Decal"}}) end)
    pcall(function() BG.se:InvokeServer("SyncTexture", {{Part = parte, Face = face, TextureType = "Decal", Texture = "rbxassetid://" .. TEXTURE_ID}}) end)
end

local function texturizar(parte, todas)
    local faces = todas and TODAS_FACES or FACES_SPAM
    for _, f in ipairs(faces) do texturizarUmaFace(parte, f) end
end

-- ============== SPAM DE PARTÍCULAS ==============
local partesCriadas = {}
local spamLigado = false

local function animarParte(parte)
    if not parte then return end
    pcall(function() F3X:SetName(parte, "Particule") end)
    pcall(function() F3X:Anchor(parte) end)
    task.spawn(function()
        local t = 0
        while parte and parte.Parent and t < 1 do
            local novaPos = parte.Position + Vector3.new(0, 0.5, 0)
            pcall(function() F3X:Move(parte, CFrame.new(novaPos)) end)
            t = t + 0.05
            pcall(function() F3X:SetTransparency(parte, t) end)
            task.wait(0.05)
        end
        if parte and parte.Parent then pcall(function() F3X:Remove(parte) end) end
    end)
end

local function criarParteTexturizada(posicao)
    local wrapper = F3X:CreatePart("Normal", CFrame.new(posicao), workspace)
    if not wrapper then return end
    F3X:Resize(wrapper, PART_SIZE)
    task.wait(0.001)
    local real = acharParteReal(posicao, PART_SIZE) or wrapper
    table.insert(partesCriadas, real)
    task.spawn(function() texturizar(real, false) end)
    animarParte(real)
end

function BG.iniciarSpam()
    if spamLigado then return end
    spamLigado = true
    notifySucesso("Spam ativado")
    task.spawn(function()
        while spamLigado do
            for _, p in ipairs(Players:GetPlayers()) do
                if not spamLigado then break end
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = p.Character.HumanoidRootPart
                    local pos = hrp.Position + Vector3.new(math.random(-6,6), math.random(3,10), math.random(-6,6))
                    criarParteTexturizada(pos)
                end
                task.wait(SPAWN_DELAY)
            end
            task.wait(0.001)
        end
    end)
end

function BG.pararSpam()
    spamLigado = false
    if #partesCriadas > 0 then
        pcall(function() F3X:RemoveParts(partesCriadas) end)
        partesCriadas = {}
    end
    notifyInfo("Spam desativado")
end

-- ============== HIDE GUIS ==============
local hideLigado = false
function BG.ligarHideGuis()
    if hideLigado then return end
    hideLigado = true
    cmdHD(";hideGuis others")
    cmdHD(";uncmdbar2 others")
    cmdHD(";mute others")
    notifySucesso("GUIs escondidas e players mutados")
end
function BG.desligarHideGuis()
    hideLigado = false
    cmdHD(";showGuis others")
    cmdHD(";cmdbar2 others")
    cmdHD(";unmute others")
    notifyInfo("GUIs restauradas")
end

-- ============== LIMPAR EFEITOS ==============
local limparLigado = false
local limparTask = nil
local LIMPEZA = {";unice", ";unjail", ";unblur", ";untitle", ";unpunish", ";unmute", ";showGuis", ";refresh"}

function BG.ligarLimpar()
    if limparLigado then return end
    limparLigado = true
    limparTask = task.spawn(function()
        while limparLigado do
            for _, c in ipairs(LIMPEZA) do
                if not limparLigado then break end
                cmdHD(c)
                task.wait(0.01)
            end
            task.wait(3)
        end
    end)
    notifySucesso("Limpeza ativada")
end

function BG.desligarLimpar()
    limparLigado = false
    if limparTask then task.cancel(limparTask) limparTask = nil end
    notifyInfo("Limpeza desativada")
end

-- ============== BOTÕES SIMPLES ==============
function BG.botaoDiscoFog()
    cmdHD(";disco ;fog ;time 0")
    notifySucesso("Disco + Fog + Time 0")
end

function BG.botaoMeshGlitch()
    local wrapper = F3X:CreatePart("Normal", CFrame.new(0, 0, 0), workspace)
    if not wrapper then return end
    F3X:Resize(wrapper, Vector3.new(0.001, 0.001, 0.001))
    task.wait(0.01)
    local real = acharParteReal(Vector3.new(0, 0, 0), Vector3.new(0.001, 0.001, 0.001)) or wrapper
    if BG.se then
        pcall(function() BG.se:InvokeServer("CreateMeshes", {{Part = real}}) end)
        task.wait(0.01)
        pcall(function()
            BG.se:InvokeServer("SyncMesh", {{
                Part = real, MeshType = "FileMesh", Mesh = 16169707,
                TextureId = 117638534679966, Scale = Vector3.new(-3500, -3500, -3500)
            }})
        end)
    end
    notifySucesso("Mesh Glitch aplicado")
end

function BG.botaoTexturizarTudo()
    notifyInfo("Texturizando mapa...")
    task.spawn(function()
        local todas = {}
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then table.insert(todas, obj) end
        end
        for i, p in ipairs(todas) do
            task.spawn(function() texturizar(p, true) end)
            if i % 30 == 0 then task.wait(0.05) end
        end
        notifySucesso("Mapa texturizado")
    end)
end

function BG.botaoColorirMapa()
    notifyInfo("Colorindo mapa...")
    local cores = {
        Color3.fromRGB(255,50,50), Color3.fromRGB(50,255,50), Color3.fromRGB(50,50,255),
        Color3.fromRGB(255,255,50), Color3.fromRGB(255,50,255), Color3.fromRGB(50,255,255),
        Color3.fromRGB(255,150,50), Color3.fromRGB(150,50,255), Color3.fromRGB(255,100,150),
        Color3.fromRGB(100,255,150), Color3.fromRGB(0,0,0), Color3.fromRGB(255,255,255)
    }
    local n = 0
    task.spawn(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not obj:IsDescendantOf(plr.Character) then
                pcall(function() F3X:SetColor(obj, cores[math.random(1, #cores)]) end)
                n = n + 1
                if n % 20 == 0 then task.wait(0.01) end
            end
        end
        notifySucesso(n .. " partes coloridas")
    end)
end

-- ============== PARTÍCULAS SERVER-SIDE ==============
local particulasLigado = false
local particulasTask = nil

local PART_CONFIG = {
    TEXTURA = "rbxassetid://139385026360175",
    TAMANHO = "5",
    VELOCIDADE = "45",
    DISPERSAO = "360",
    RATE = "50"
}

local function aplicarParticula(seBTP, parte)
    if not seBTP or not parte then return end
    pcall(function()
        seBTP:InvokeServer("CreateDecorations", {{Part = parte, DecorationType = "ParticleEmitter"}})
    end)
    local props = {
        {Texture = PART_CONFIG.TEXTURA},
        {Size = PART_CONFIG.TAMANHO},
        {Speed = PART_CONFIG.VELOCIDADE},
        {SpreadAngle = PART_CONFIG.DISPERSAO},
        {Rate = PART_CONFIG.RATE}
    }
    for _, prop in ipairs(props) do
        local dados = {Part = parte, DecorationType = "ParticleEmitter"}
        for k, v in pairs(prop) do dados[k] = v end
        pcall(function() seBTP:InvokeServer("SyncDecorate", {dados}) end)
    end
end

function BG.ligarParticulas()
    if particulasLigado then return end
    local seBTP = getFork3XEndpoint()
    if not seBTP then notifyErro("Building Tools+ nao encontrada!") return end
    particulasLigado = true
    notifyInfo("Aplicando particulas...")
    particulasTask = task.spawn(function()
        local partes = {}
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" and not obj:IsDescendantOf(plr.Character) then
                table.insert(partes, obj)
            end
        end
        for i, p in ipairs(partes) do
            if not particulasLigado then return end
            aplicarParticula(seBTP, p)
            if i % 30 == 0 then task.wait(0.1) end
        end
        notifySucesso("Particulas aplicadas em " .. #partes .. " partes")
    end)
end

function BG.desligarParticulas()
    particulasLigado = false
    if particulasTask then task.cancel(particulasTask) particulasTask = nil end
    notifyInfo("Particulas desativadas")
end

-- ============== MÚSICA ==============
local MUSIC_PRESETS = {
    {id = 1839246711, vol = 9999, pitch = 0.9, nome = "Jumpsytle"},
    {id = 95156028272944, vol = 9999, pitch = 0.2, nome = "Padrao"},
    {id = 3200130016, vol = 9999, pitch = 1, nome = "You Are An Idiot"},    
    {id = 16190761193, vol = 9999, pitch = 0.9, nome = "Jugsta"},
    {id = 85598267402579, vol = 9999, pitch = 0.9, nome = "Kit"},
    {id = 105828916140935, vol = 9999, pitch = 0.9, nome = "Her Boyfriend"},
    {id = 105819456196233, vol = 9999, pitch = 0.3, nome = "Fast Beep"},
    {id = 75485931767123, vol = 9999, pitch = 0.9, nome = "Alone"},
    {id = 88914658183319, vol = 9999, pitch = 0.8, nome = "China Music"},
    {id = 87989952166968, vol = 9999, pitch = 0.2, nome = "Keemstar Music"},
    {id = 78973045684083, vol = 9999, pitch = 0.3, nome = "Sirmeme"},
    {id = 86317637164248, vol = 9999, pitch = 1.0, nome = "Misery"},
    {id = 138981629726601, vol = 9999, pitch = 0.8, nome = "Phonk Slowed"},
    {id = 97927847298766, vol = 9999, pitch = 0.8, nome = "Verity Theme"},
    {id = 92843733974363, vol = 9999, pitch = 0.95, nome = "Washing Machine"},
    {id = 109288461793825, vol = 9999, pitch = 0.8, nome = "JET 2 HOLIDAY"},
    {id = 110919391228823, vol = 9999, pitch = 1.0, nome = "Low Cortisol"},
    {id = 82188333380385, vol = 9999, pitch = 0.10, nome = "Miguel Phonk"},
    {id = 82746224492420, vol = 9999, pitch = 0.8, nome = "Terranova"},
    {id = 82696338249251, vol = 9999, pitch = 0.8, nome = "Rampage"}
}

BG.MUSIC_PRESETS = MUSIC_PRESETS

local presetIndex = 2
local musicaLigada = false
local musicaTask = nil
local currentId = MUSIC_PRESETS[presetIndex].id
local currentVol = MUSIC_PRESETS[presetIndex].vol
local currentPitch = MUSIC_PRESETS[presetIndex].pitch
local currentName = MUSIC_PRESETS[presetIndex].nome
local MUSIC_ID_STR = tostring(currentId)

BG.getCurrentMusic = function()
    return currentName, musicaLigada
end

local function tocarMusica()
    if not BG.rc then return end
    pcall(function()
        BG.rc:InvokeServer(";music " .. currentId .. " ;pitch " .. currentPitch .. " ;volume " .. currentVol)
    end)
end

local function encontrarMusica()
    local locais = {workspace, SoundService, plr}
    if plr:FindFirstChild("PlayerGui") then table.insert(locais, plr.PlayerGui) end
    if plr:FindFirstChild("Backpack") then table.insert(locais, plr.Backpack) end
    if plr.Character then table.insert(locais, plr.Character) end
    for _, l in ipairs(locais) do
        for _, obj in ipairs(l:GetDescendants()) do
            if obj:IsA("Sound") and string.find(tostring(obj.SoundId), MUSIC_ID_STR, 1, true) then
                return obj
            end
        end
    end
    return nil
end

function BG.ligarMusica()
    if musicaLigada then return end
    musicaLigada = true
    tocarMusica()
    notifySucesso("Musica: " .. currentName)
    musicaTask = task.spawn(function()
        local ultimo = 0
        while musicaLigada do
            task.wait(0.5)
            if not musicaLigada then break end
            local som = encontrarMusica()
            local agora = tick()
            if not som or not som.Playing or (som.TimeLength > 0 and som.TimePosition >= som.TimeLength - 0.5) then
                if (agora - ultimo) > 2 then
                    ultimo = agora
                    task.spawn(tocarMusica)
                end
            else
                pcall(function() som.Looped = true end)
            end
        end
    end)
end

function BG.desligarMusica()
    musicaLigada = false
    if musicaTask then pcall(function() task.cancel(musicaTask) end) musicaTask = nil end
    cmdHD(";unmusic ;volume 1 ;pitch 1")
    notifyInfo("Musica desativada")
end

function BG.trocarPreset()
    presetIndex = presetIndex + 1
    if presetIndex > #MUSIC_PRESETS then presetIndex = 1 end
    local p = MUSIC_PRESETS[presetIndex]
    currentId = p.id
    currentVol = p.vol
    currentPitch = p.pitch
    currentName = p.nome
    MUSIC_ID_STR = tostring(currentId)
    if musicaLigada then
        cmdHD(";unmusic")
        task.spawn(tocarMusica)
    end
    notifyInfo("Preset: " .. currentName)
end

-- TROLL SKYBOX
local skyTrollAtivo = false
local skyTrollPart = nil
local skyTrollTask = nil
local skyTrollAnimAtual = 1
local skyTrollIdx = 1
local skyTrollDir = 1

local SKY_TROLL_ANIMS = {
    -- Animação 1: original
    {
        frames = {
            "rbxassetid://124885820999539",
            "rbxassetid://134679713643345",
            "rbxassetid://78567042688656",
            "rbxassetid://131205088277280",
        },
        delay = 0.05,
        pingpong = false,
    },
    -- Animação 2: esqueleto dançando (ping-pong)
    {
        frames = {
            "rbxassetid://18208966289",
            "rbxassetid://18208968766",
            "rbxassetid://18208971038",
            "rbxassetid://18208973442",
            "rbxassetid://18208975979",
            "rbxassetid://18208978431",
            "rbxassetid://18208980927",
            "rbxassetid://18208983009",
        },
        delay = 0.15,
        pingpong = true,
    },
    -- Animação 3: imagem estática
    {
        frames = {
            "rbxassetid://75393875196571",
        },
        delay = 5,
        pingpong = false,

        -- Animação 4: 2 frames
{
    frames = {
        "rbxassetid://11660423541",
        "rbxassetid://4616500111",
    },
    delay = 0.15,
    pingpong = false,
},
    },
}

local function getAnimAtual()
    return SKY_TROLL_ANIMS[skyTrollAnimAtual] or SKY_TROLL_ANIMS[1]
end

local function rodarLoopSky(seBTP)
    while skyTrollAtivo do
        if skyTrollPart and skyTrollPart.Parent then
            local anim = getAnimAtual()
            local frames = anim.frames
            if #frames > 0 then
                if #frames == 1 then
                    pcall(function()
                        seBTP:InvokeServer("SyncMesh", {{
                            Part = skyTrollPart,
                            MeshId = "",
                            TextureId = frames[1],
                            Scale = Vector3.new(-1500, -1500, -1500)
                        }})
                    end)
                    task.wait(anim.delay)
                else
                    local id = frames[skyTrollIdx]
                    if id then
                        pcall(function()
                            seBTP:InvokeServer("SyncMesh", {{
                                Part = skyTrollPart,
                                MeshId = "",
                                TextureId = id,
                                Scale = Vector3.new(-1500, -1500, -1500)
                            }})
                        end)
                    end

                    if anim.pingpong then
                        skyTrollIdx = skyTrollIdx + skyTrollDir
                        if skyTrollIdx > #frames then
                            skyTrollIdx = #frames - 1
                            skyTrollDir = -1
                        elseif skyTrollIdx < 1 then
                            skyTrollIdx = 2
                            skyTrollDir = 1
                        end
                    else
                        skyTrollIdx = skyTrollIdx % #frames + 1
                    end
                    task.wait(anim.delay)
                end
            end
        else
            task.wait(0.5)
        end
    end
end

function BG.trocarSkyAnim()
    if not skyTrollAtivo then
        notifyInfo("Liga o SkyBox Troll primeiro!")
        return
    end

    skyTrollAnimAtual = skyTrollAnimAtual + 1
    if skyTrollAnimAtual > #SKY_TROLL_ANIMS then
        skyTrollAnimAtual = 1
    end

    skyTrollIdx = 1
    skyTrollDir = 1

    local anim = getAnimAtual()
    if skyTrollPart and skyTrollPart.Parent then
        local seBTP = getFork3XEndpoint()
        if seBTP then
            pcall(function()
                seBTP:InvokeServer("SyncMesh", {{
                    Part = skyTrollPart,
                    MeshId = "",
                    TextureId = anim.frames[1],
                    Scale = Vector3.new(-1500, -1500, -1500)
                }})
            end)
        end
    end

    notifyInfo("Animação " .. skyTrollAnimAtual .. "/" .. #SKY_TROLL_ANIMS)
end

function BG.toggleSkyTroll(ativar)
    if ativar then
        if skyTrollAtivo then return end
        local seBTP = getFork3XEndpoint()
        if not seBTP then notifyErro("Building Tools+ nao encontrada!") return end

        skyTrollAtivo = true
        skyTrollAnimAtual = 1
        skyTrollIdx = 1
        skyTrollDir = 1
        notifyInfo("Criando SkyBox troll...")

        local part = F3X:CreatePart("Normal", CFrame.new(0, 0, 0), workspace)
        if not part then
            notifyErro("Falha ao criar part!")
            skyTrollAtivo = false
            return
        end

        F3X:Resize(part, Vector3.new(0.001, 0.001, 0.001))
        F3X:SetCollision(part, false)
        F3X:Anchor(part)
        skyTrollPart = part

        pcall(function()
            seBTP:InvokeServer("CreateMeshes", {{Part = part}})
        end)

        local animInicial = getAnimAtual()
        pcall(function()
            seBTP:InvokeServer("SyncMesh", {{
                Part = part,
                MeshId = "",
                TextureId = animInicial.frames[1],
                Scale = Vector3.new(-1500, -1500, -1500)
            }})
        end)

        skyTrollTask = task.spawn(function()
            rodarLoopSky(seBTP)
        end)

        local connRespawn
        connRespawn = plr.CharacterAdded:Connect(function()
            if not skyTrollAtivo then
                if connRespawn then connRespawn:Disconnect() end
                return
            end

            if skyTrollTask then
                pcall(function() task.cancel(skyTrollTask) end)
                skyTrollTask = nil
            end

            task.wait(3)
            if not skyTrollAtivo then return end

            if skyTrollPart and skyTrollPart.Parent then
                pcall(function() F3X:Remove(skyTrollPart) end)
            end

            cmdHD(";btools")
            task.wait(2)

            local seBTP2 = getFork3XEndpoint()
            if not seBTP2 then return end
            seBTP = seBTP2

            local novaPart = F3X:CreatePart("Normal", CFrame.new(0, 0, 0), workspace)
            if not novaPart then return end

            F3X:Resize(novaPart, Vector3.new(0.001, 0.001, 0.001))
            F3X:SetCollision(novaPart, false)
            F3X:Anchor(novaPart)
            skyTrollPart = novaPart

            pcall(function()
                seBTP:InvokeServer("CreateMeshes", {{Part = novaPart}})
            end)
            task.wait(0.2)

            skyTrollIdx = 1
            skyTrollDir = 1

            local animRespawn = getAnimAtual()
            pcall(function()
                seBTP:InvokeServer("SyncMesh", {{
                    Part = novaPart,
                    MeshId = "",
                    TextureId = animRespawn.frames[1],
                    Scale = Vector3.new(-1500, -1500, -1500)
                }})
            end)

            skyTrollTask = task.spawn(function()
                rodarLoopSky(seBTP)
            end)
        end)

        notifySucesso("SkyBox troll ativo!")
    else
        if not skyTrollAtivo then return end
        skyTrollAtivo = false

        if skyTrollTask then
            pcall(function() task.cancel(skyTrollTask) end)
            skyTrollTask = nil
        end

        if connRespawn then
            pcall(function() connRespawn:Disconnect() end)
            connRespawn = nil
        end

        if skyTrollPart and skyTrollPart.Parent then
            pcall(function() F3X:Remove(skyTrollPart) end)
        end
        skyTrollPart = nil

        notifyInfo("SkyBox troll desligado")
    end
end

print("[Visual] Modulo carregado")
