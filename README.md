<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:000000,100:1a1a1a&height=200&section=header&text=BL5CK%20GUI&fontSize=70&fontColor=ffffff&animation=fadeIn&fontAlignY=38&desc=Painel%20Completo%20para%20Executores%20Roblox&descAlignY=58&descSize=18" />

[![Status](https://img.shields.io/badge/STATUS-ONLINE-22c55e?style=for-the-badge&labelColor=000000)](#)
[![Version](https://img.shields.io/badge/VERSION-v1.1.0-3b82f6?style=for-the-badge&labelColor=000000)](#)
[![Type](https://img.shields.io/badge/TYPE-EXECUTOR-8b5cf6?style=for-the-badge&labelColor=000000)](#)
[![Platform](https://img.shields.io/badge/PLATFORM-MOBILE%20%2B%20PC-f59e0b?style=for-the-badge&labelColor=000000)](#)
[![License](https://img.shields.io/badge/LICENSE-MIT-ef4444?style=for-the-badge&labelColor=000000)](#-licença)

**Painel modular para Roblox com HD Admin + Building Tools+ · Auto-Update · UserModules**

[🚀 Instalação](#-instalação) · [📖 Como Usar](#-como-usar) · [🔑 Key System](#-key-system) · [🧩 UserModules](#-usermodules) · [❓ FAQ](#-faq)

---

</div>

## 📌 Sobre

**BL5CK GUI** é um painel completo para executores Roblox, projetado para funcionar em qualquer jogo que tenha **HD Admin** instalado e, opcionalmente, a tool **Building Tools+ (F3X)** para funções de construção server-side.

O projeto é dividido em **módulos independentes** carregados dinamicamente via `Loader.lua`, com **cache local** no disco do executor e **sistema de atualização automática**.

- 🔄 **Auto-Update** — o Loader compara os arquivos locais com o GitHub e avisa quando tem versão nova
- 📦 **Cache local** — depois do primeiro download, os módulos ficam salvos em `Bl5ckGUI/modules/`
- 🧩 **UserModules** — qualquer arquivo `.lua` em `Bl5ckGUI/UserModules/` é carregado automaticamente
- ⚡ **Auto-execute** — integração com `queue_on_teleport`
- 🎨 **Tema AMOLED** — interface preta com verde neon

---

## 🖼️ Preview

<div align="center">

<img src="https://raw.githubusercontent.com/EchoX10/Bl5ckGUI/main/assets/preview.png" width="800" />

</div>

---

## 🚀 Instalação

**Passo 1.** Abra seu executor (Delta, Codex, Fluxus, Xeno, Solara, Wave, Arceus, etc.)

**Passo 2.** Cole o comando abaixo e execute:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/EchoX10/Bl5ckGUI/main/Loader.lua"))()
```

**Passo 3.** O Loader vai:

1. Verificar atualização (janela SIM/NÃO se tiver)
2. Criar as pastas `Bl5ckGUI/`
3. Baixar os módulos que faltam
4. Baixar os assets
5. Carregar os módulos do disco
6. Mostrar login (só se não tiver key salva)

---

## 📖 Como Usar

### Primeira vez

1. Execute o Loader
2. O painel carrega primeiro
3. A **tela de login** aparece por cima
4. Uma key aleatória é gerada e mostrada **no console do executor** (F9 no PC)
5. Copie e cole no campo, clique em **VALIDAR KEY**

### Sem console? Use as missões

Clique em **🎯 FAZER MISSÕES**:

| Missão | O que fazer |
|--------|-------------|
| **1. Matemática Rápida** | 5 contas em 10s cada (acertar 4) |
| **2. Digite a Frase** | 3 frases exatas |
| **3. Complete a Frase** | 4 frases (acertar 3) |

Ao terminar, clique em **🔑 VER KEY** — a key vai pro clipboard.

### Depois de validar

A key fica salva por **35 minutos** em `Bl5ckGUI/key/blackgui_key.txt`. Não precisa refazer as missões.

### Atualizações

Quando tiver versão nova no GitHub, aparece uma janela:

- **✅ SIM** — baixa e sobrescreve os módulos locais
- **❌ NÃO** — usa os locais (pergunta de novo na próxima execução)

---

## 🔑 Key System

Módulo separado (`07-Key.lua`), **anti-force**:

- 🔐 Key de **16 caracteres** aleatória
- ⏱️ Expira em **35 minutos**
- 💾 Salva em `Bl5ckGUI/key/blackgui_key.txt`
- 🎯 Missões anti-bot
- ⏰ Login **só aparece depois** do painel carregar

---

## 🧩 UserModules

Coloque qualquer arquivo `.lua` em `Bl5ckGUI/UserModules/` e ele é carregado automaticamente em sandbox.

**Sistema de tracking:** cada arquivo que cria funções em `BG.*`, GUIs ou conexões é registrado em:

- `Bl5ckGUI/UserModulesFunctions/FunctionNames.json`
- `Bl5ckGUI/UserModulesFunctions/FunctionCodes.json`

Quando você **apaga** o arquivo, o Loader remove só o que **aquele** arquivo adicionou — sem afetar outros UserModules nem o painel base.

**Trackers disponíveis:**
- `trackGui(gui)` — registra ScreenGui
- `trackConn(conn)` — registra conexão
- `trackFunc(nome)` — registra função em `BG`

**Exemplo:**

```lua
BG.configButtonFunc = function()
    print("Config clicado!")
end

local gui = Instance.new("ScreenGui")
gui.Parent = game:GetService("CoreGui")
trackGui(gui)

local btn = Instance.new("TextButton")
btn.Text = "Config"
btn.Parent = gui

local conn = btn.MouseButton1Click:Connect(BG.configButtonFunc)
trackConn(conn)
```

---

## 🧩 Estrutura do Projeto

```
Bl5ckGUI/
│
├── 📄 README.md
├── 📄 Loader.lua
│
├── 📁 modules/
│   ├── 📄 01-Config.lua
│   ├── 📄 02-Core.lua
│   ├── 📄 03-Jogador.lua
│   ├── 📄 04-Visual.lua
│   ├── 📄 05-Mapa.lua
│   ├── 📄 06-GUI.lua
│   └── 📄 07-Key.lua
│
├── 📁 bl5ckguiassets/
│   ├── 📄 README.md
│   └── 🖼️ Button_Img.png
│
└── 📁 assets/
    └── 🖼️ preview.png
```

**No disco do executor** (criado pelo Loader):

```
Bl5ckGUI/
├── modules/
├── key/
├── assets/
├── UserModules/
├── UserModulesFunctions/
├── loader_autoload.lua
└── autoexec.flag
```

---

## 🛠️ Como Contribuir

1. Fork o repo
2. Crie uma branch: `git checkout -b feature/minha-feature`
3. Commit: `git commit -m "Adiciona X"`
4. Push: `git push origin feature/minha-feature`
5. Abre Pull Request

Ou abre uma [issue](https://github.com/EchoX10/Bl5ckGUI/issues).

---

## ❓ FAQ

<details>
<summary><b>O painel não abre. O que fazer?</b></summary>

Roda no console:

```lua
print("loadstring:", type(loadstring))
print("HttpGet:", type(game.HttpGet))
print("writefile:", type(writefile))
print("readfile:", type(readfile))
print("isfile:", type(isfile))
print("makefolder:", type(makefolder))
```

Se algum voltar `nil`, troca de executor.
</details>

<details>
<summary><b>A janela de atualização fica aparecendo toda vez.</b></summary>

Você clicou **❌ NÃO** mas os módulos locais continuam diferentes. Soluções:
- Clica em **✅ SIM** pra atualizar
- Ou apaga `Bl5ckGUI/modules/` pra forçar download limpo
</details>

<details>
<summary><b>O auto-execute não funciona ao trocar de jogo.</b></summary>

`queue_on_teleport` **só dispara em server hop**, não em troca de jogo pelo menu. Ativa o **Auto Execute nativo do executor** e coloca o comando do Loader lá.
</details>

<details>
<summary><b>Um UserModule meu quebrou o painel.</b></summary>

UserModules rodam em `pcall` — se quebrar, é ignorado e o painel base continua. Se quiser remover: apaga o arquivo em `Bl5ckGUI/UserModules/` e roda o Loader de novo.
</details>

<details>
<summary><b>Onde ficam os arquivos no celular?</b></summary>

No disco interno do executor, em `Bl5ckGUI/`. Não é na pasta do Roblox.
</details>

<details>
<summary><b>Posso aumentar o tempo da key?</b></summary>

Sim. Edita `TEMPO_EXPIRACAO` no `07-Key.lua`:

```lua
local TEMPO_EXPIRACAO = 35 * 60  -- segundos
```
</details>

---

## 📋 Changelog

### v1.1.0
- ✅ Auto-Update com janela SIM/NÃO
- ✅ Cache local dos módulos
- ✅ UserModules com tracking
- ✅ Auto-execute via `queue_on_teleport`
- ✅ Key system separado (`07-Key.lua`)
- ✅ Botão redondo minimizar
- ✅ Tweens em tudo
- ✅ Reanimate (FakeChar)
- ✅ Arma anexa no braço do FakeChar
- ✅ `BG.PartCframe` / `BG.RemoveCframe`

### v1.0.0 (Inicial)
- ✅ Sistema de key com missões
- ✅ Notificações animadas
- ✅ Wrapper F3X + HD Admin
- ✅ Clone, Zumbi, Tool Hacker, Modo Tóxico
- ✅ Partículas, Obby, NPC, Meteorito
- ✅ Tema AMOLED

---

## ⚠️ Aviso Legal

Este projeto é disponibilizado **apenas para fins educacionais** e para uso em **servidores privados/sandbox** onde você tem permissão.

- ❌ **Não use** em jogos competitivos ou com outros jogadores sem consentimento
- ❌ **Não me responsabilizo** por bans, kicks ou qualquer consequência
- ✅ **Use com moderação**

A utilização de executores é contra os Termos de Serviço da Roblox. Use por sua conta e risco.

---

## 📜 Licença

```
MIT License

Copyright (c) 2026 EchoX10

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```

---

<div align="center">

### 👤 Autor

**EchoX10**

[![GitHub](https://img.shields.io/badge/GitHub-EchoX10-181717?style=for-the-badge&logo=github&labelColor=000000)](https://github.com/EchoX10)

---

**⭐ Se curtiu o projeto, deixa uma estrela no repo!**

<sub>Feito com 🖤 e muito café</sub>

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:1a1a1a,100:000000&height=100&section=footer" />

</div>
