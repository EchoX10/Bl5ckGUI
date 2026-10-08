<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:000000,100:1a1a1a&height=200&section=header&text=BL5CK%20GUI&fontSize=70&fontColor=ffffff&animation=fadeIn&fontAlignY=38&desc=Painel%20Completo%20para%20Executores%20Roblox&descAlignY=58&descSize=18" />

[![Status](https://img.shields.io/badge/STATUS-ONLINE-22c55e?style=for-the-badge&labelColor=000000)](#)
[![Version](https://img.shields.io/badge/VERSION-v1.0.0-3b82f6?style=for-the-badge&labelColor=000000)](#)
[![Type](https://img.shields.io/badge/TYPE-EXECUTOR-8b5cf6?style=for-the-badge&labelColor=000000)](#)
[![Platform](https://img.shields.io/badge/PLATFORM-MOBILE%20%2B%20PC-f59e0b?style=for-the-badge&labelColor=000000)](#)
[![License](https://img.shields.io/badge/LICENSE-MIT-ef4444?style=for-the-badge&labelColor=000000)](#-licença)

**Painel modular para Roblox com integração HD Admin + Building Tools+**

[🚀 Instalação](#-instalação) · [📖 Como Usar](#-como-usar) · [✨ Features](#-features) · [🔑 Key System](#-key-system) · [❓ FAQ](#-faq)

---

</div>

## 📌 Sobre

**BL5CK GUI** é um painel completo para executores Roblox, projetado para funcionar em qualquer jogo que tenha **HD Admin** instalado e, opcionalmente, a tool **Building Tools+ (F3X)** para funções de construção server-side.

O projeto é dividido em **módulos independentes** carregados dinamicamente via `Loader.lua`. Isso significa que:

- 🔄 **Atualizações instantâneas** — você edita no GitHub, o usuário pega automático
- 🧩 **Manutenção fácil** — cada feature em seu próprio arquivo
- 🐛 **Debug rápido** — se der erro, você sabe exatamente qual módulo quebrou
- ⚡ **Leve** — só carrega o que precisa

---

## 🖼️ Preview

<div align="center">

<img src="https://raw.githubusercontent.com/EchoX10/Bl5ckGUI/main/assets/preview.png" width="800" />

*Interface com tema AMOLED preto, abas horizontais e notificações animadas.*

</div>

---

## 🚀 Instalação

**Passo 1.** Abra seu executor (Delta, Codex, Fluxus, Xeno, Solara, Wave, Arceus, etc.)

**Passo 2.** Cole o comando abaixo e execute:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/EchoX10/Bl5ckGUI/main/Loader.lua"))()
```

**Passo 3.** O painel vai abrir automaticamente. Se for a primeira vez, vai aparecer a **tela de login** pedindo a key.

---

## 📖 Como Usar

### Primeira vez

1. Execute o Loader
2. Aparece a tela de login
3. Uma key aleatória é gerada e mostrada **no console do executor** (F9 no PC)
4. Copie a key
5. Cole no campo e clique em **VALIDAR KEY**

### Sem console? Use as missões

Se você não consegue ver o console (comum em celular), clique em **🎯 FAZER MISSÕES**:

| Missão | O que fazer |
|--------|-------------|
| **1. Matemática Rápida** | Resolva 5 contas em 10s cada (precisa acertar 4) |
| **2. Digite a Frase** | Digite 3 frases exatamente como aparecem |
| **3. Complete a Frase** | Complete 4 frases sobre o painel (precisa acertar 3) |

Ao terminar as 3, clique em **🔑 COPIAR KEY E VOLTAR**. A key vai pro clipboard automaticamente.

### Depois de validar

A key fica salva por **35 minutos** em arquivo local. Depois disso, você precisa gerar nova. Não precisa refazer as missões toda vez que abrir o painel.

---

## ✨ Features

### 👤 Aba Jogador

<table>
<tr>
<td width="50%">

**🔫 Clone Personagem + Arma**
- Cria um clone visível do seu personagem
- Sistema de arma funcional (atira projéteis)
- Animações de caminhada, pulo e cabeça seguindo o mouse
- Fica invisível enquanto o clone tá ativo

**🧟 Zumbi**
- Transforma seu personagem em zumbi
- Dá dano automático em quem encostar
- Sistema de auto-reconstrução se for destruído

**👻 Tool Invisible**
- Toggle invisível/visível
- Tool na mochila para ativar/desativar

</td>
<td width="50%">

**🔨 Tool Hacker**
- Tool que deleta players ao clicar
- Matar + explodir + respawnar server-side

**😈 Modo Tóxico (Anti-Un)**
- Seleciona um alvo
- Loop com ice, jail, title, warp, blur, punish
- Sistema anti-un (se alguém remover o efeito, reaplica)

**📦 Armadilha de Jogador**
- Teleporta o alvo para uma jaula fechada
- Depois te teleporta de volta pro local original

**⚡ Comandos em Jogador**
- Lista rápida: heal, kill, jail, ice, blur, warp, freeze, dmg

</td>
</tr>
</table>

### 👁️ Aba Visual

| Feature | Descrição |
|---------|-----------|
| **✨ Spam de Partículas** | Cria partes texturizadas ao redor de todo mundo |
| **👻 Esconder GUIs + Mutar** | Aplica hideGuis, uncmdbar2 e mute em "others" |
| **🧹 Limpar Efeitos (loop)** | Limpa ice/jail/blur/title a cada 3s |
| **🎆 Partículas Server-Side** | Aplica ParticleEmitter texturizado em todas as partes (via Building Tools+) |
| **🌠 Mesh Glitch (-3500)** | Aplica escala negativa gigante numa parte |
| **🎨 Texturizar Mapa** | Aplica textura em todas as partes do mapa |
| **🎨 Colorir Mapa** | Pinta cada parte de uma cor aleatória |

### 🗺️ Aba Mapa

| Feature | Descrição |
|---------|-----------|
| **🎯 Sistema Obby** | Cria um obby completo com KillBricks e WinPart |
| **🌪️ Natural Disaster** | Baixa blueprint de mapa externo e constrói |
| **🗺️ Mapa Rápido** | Limpa + constrói um mapa pequeno de teste |
| **💣 Metero Áudio** | Contagem → parte cai do céu → música toca → esferas crescem |
| **☄️ Meteorito Gigante** | Parte gigante cai e explode em bola vermelha |
| **🏳️ Bandeira Colorida** | Constrói bandeira de 7 cores |
| **🤖 NPC Controlável** | NPC que você controla com setas |

### ⚙️ Aba Admin

- **👋 Boas Vindas Automáticas** — serverHint pra quem entra
- **🇧🇷 Título BL5CK** — aplica título em você
- **📢 Enviar serverMessage** — textbox pra mandar mensagem global

### 🎵 Aba Mídia

- **17 presets de música** (phonk, JET 2, keemstar, etc.)
- **Loop automático** — se a música parar, reinicia
- **Trocar preset** com botão giratório
- **Sliders** de pitch e volume
- **🌈 DISCO + FOG + TIME 0** — efeitos visuais globais

---

## 🔑 Key System

O sistema de key foi feito pra ser **anti-force**:

- 🔐 Key de **16 caracteres** gerada aleatoriamente
- ⏱️ Expira em **35 minutos**
- 💾 Salva em **arquivo local** (`blackgui_key.txt`) — sobrevive a re-exec
- 🎯 Missões anti-bot (matemática + digitação + completar)
- 🚫 **Não funciona com auto-solver** porque a key é aleatória por sessão

---

## 🧩 Estrutura do Projeto

```
Bl5ckGUI/
│
├── 📄 README.md              ← você está aqui
├── 📄 Loader.lua             ← ponto de entrada
│
└── 📁 modules/
    ├── 📄 01-Config.lua      → Config global + Notificações + Key system
    ├── 📄 02-Core.lua        → F3X Wrapper + HD Admin + Helpers
    ├── 📄 03-Jogador.lua     → Clone + Zumbi + Tools + Tóxico
    ├── 📄 04-Visual.lua      → Spam + Partículas + Texturizar + Colorir
    ├── 📄 05-Mapa.lua        → Obby + NPC + Meteorito + Disaster
    └── 📄 06-GUI.lua         → Sistema de abas + todos os botões
```

**Ordem de carregamento importa.** Cada módulo depende do que veio antes (`_G.BlackGUI` é a tabela compartilhada).

---

## 🛠️ Como Contribuir

Achou um bug ou quer adicionar feature?

1. Fork o repo
2. Crie uma branch: `git checkout -b feature/minha-feature`
3. Commit: `git commit -m "Adiciona X"`
4. Push: `git push origin feature/minha-feature`
5. Abre Pull Request

Ou abre uma [issue](https://github.com/EchoX10/Bl5ckGUI/issues) descrevendo o problema.

---

## ❓ FAQ

<details>
<summary><b>O painel não abre. O que fazer?</b></summary>

Verifica se o executor tem `loadstring` e `game:HttpGet`. Alguns executores antigos (Delta antigo, Krnl antigo) têm limitações. Roda isso no console pra checar:

```lua
print("loadstring:", type(loadstring))
print("HttpGet:", type(game.HttpGet))
```

Se algum voltar `nil`, troca de executor.
</details>

<details>
<summary><b>A key não aparece no console.</b></summary>

Alguns executores escondem o console por padrão. Abre manualmente:
- **PC:** F9
- **Delta mobile:** menu do executor → "Output" ou "Console"
- **Alternativa:** clica em **FAZER MISSÕES** e pega pelo botão de copiar
</details>

<details>
<summary><b>Funciona em qualquer jogo?</b></summary>

**Depende.** Funções de HD Admin precisam que o jogo tenha **HD Admin** instalado. Funções de construção (partículas, NPC, mesh) precisam da tool **Building Tools+**.

Se o jogo não tem essas coisas, só as funções nativas do painel vão funcionar.
</details>

<details>
<summary><b>O Clone não pega no meu personagem.</b></summary>

A tool **Building Tools+** precisa estar no teu Backpack. Se não tiver, o painel não consegue criar as partes server-side.
</details>

<details>
<summary><b>Por que a key expira em 35 minutos?</b></summary>

É o tempo que o servidor do Roblox mantém a sessão ativa em muitos jogos. Depois disso, você geralmente já foi kickado ou o painel parou de funcionar. Se quiser mudar, edita `TEMPO_EXPIRACAO` no `01-Config.lua`.
</details>

<details>
<summary><b>Como adiciono mais música nos presets?</b></summary>

Edita o array `MUSIC_PRESETS` no `04-Visual.lua`. Formato:

```lua
{id = ID_DA_MUSICA, vol = 9999, pitch = 0.8, nome = "Nome"}
```
</details>

<details>
<summary><b>Tem versão PC?</b></summary>

Sim. O mesmo Loader funciona em qualquer executor PC (Synapse, Script-Ware, Krnl, Fluxus PC, Wave PC, etc.). A interface foi feita pra funcionar em ambas plataformas.
</details>

---

## 📋 Changelog

### v1.0.0 (Inicial)
- ✅ Sistema de key com missões
- ✅ Notificações animadas com som
- ✅ Wrapper F3X + integração HD Admin
- ✅ Clone com arma e sistema de tiro
- ✅ Modo Tóxico com anti-un
- ✅ Sistema de partículas server-side via Building Tools+
- ✅ Obby + NPC + Meteorito + Natural Disaster
- ✅ Sistema de abas AMOLED

---

## ⚠️ Aviso Legal

Este projeto é disponibilizado **apenas para fins educacionais** e para uso em **servidores privados/sandbox** onde você tem permissão.

- ❌ **Não use** em jogos competitivos ou com outros jogadores sem consentimento
- ❌ **Não me responsabilizo** por bans, kicks ou qualquer consequência
- ✅ **Use com moderação** e respeito à comunidade

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
