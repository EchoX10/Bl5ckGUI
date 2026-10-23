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
