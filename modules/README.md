<div align="center">

# 📦 Módulos - BL5CK GUI

**Cada módulo é carregado em sequência pelo `Loader.lua`**

</div>

---

## 📌 Sobre

Esta pasta contém os **6 módulos** que compõem o painel BL5CK GUI. Cada um roda em sequência e compartilha dados através da tabela global `_G.BlackGUI`.

**⚠️ Ordem importa.** Se você mexer nos nomes dos arquivos, precisa atualizar o array `MODULOS` no `Loader.lua`.

---

## 📁 Lista dos Módulos

| # | Arquivo | Responsável por |
|---|---------|-----------------|
| 01 | `01-Config.lua` | Config global + Notificações + Key system + Missões |
| 02 | `02-Core.lua` | F3X Wrapper + HD Admin + Helpers (acharParteReal, welds, etc.) |
| 03 | `03-Jogador.lua` | Clone + Zumbi + Tool Hacker + Tool Invisible + Modo Tóxico + Armadilha + Acessório |
| 04 | `04-Visual.lua` | Spam de Partículas + Partículas Server-Side + Texturizar + Colorir + Música |
| 05 | `05-Mapa.lua` | Obby + NPC + Meteorito + Bandeira + Natural Disaster + Metero Áudio |
| 06 | `06-GUI.lua` | Sistema de abas + Todos os botões do painel |

---

## 🔗 Dependências entre módulos

```
01-Config.lua  ──┐
                 ├─► 02-Core.lua ──┐
                 │                  ├─► 03-Jogador.lua ──┐
                 │                  ├─► 04-Visual.lua  ──┤
                 │                  └─► 05-Mapa.lua    ──┼─► 06-GUI.lua
                 │                                       │
                 └───────────────────────────────────────┘
                          (_G.BlackGUI)
```

**Regras:**

- `01-Config` **não depende de nada** — é o primeiro a rodar
- `02-Core` usa `_G.BlackGUI` que o `01` criou
- `03`, `04`, `05` usam funções do `02` (F3X, helpers, HD Admin)
- `06-GUI` chama funções que o `03`, `04` e `05` registraram

---

## 🧩 Como os módulos se comunicam

Todos compartilham a tabela `_G.BlackGUI`:

```lua
local BG = _G.BlackGUI
```

O `Loader.lua` cria essa tabela com os serviços do Roblox (Players, TweenService, etc.) **antes** de rodar os módulos. Depois, cada módulo **adiciona** suas próprias funções e variáveis nela:

```lua
-- Exemplo no 03-Jogador.lua
function BG.toggleZumbi(ativar)
    -- ...
end

-- Exemplo no 06-GUI.lua
criarToggle("Zumbi", function(e) BG.toggleZumbi(e) end, tab1)
```

---

## 🛠️ Como editar um módulo

### Editar pelo GitHub (mobile ou PC)

1. Abre o arquivo no GitHub
2. Clica no ícone de **lápis** (edit)
3. Faz a mudança
4. Rola até o final
5. Escreve uma mensagem em **Commit changes** tipo `fix: corrigido X`
6. Clica em **Commit changes**

**Pronto.** Na próxima vez que alguém rodar o Loader, vai pegar a versão nova.

### Adicionar um novo módulo

Se quiser criar um módulo `07-Meumodulo.lua`:

1. Cria o arquivo na pasta
2. Edita o `Loader.lua` e adiciona `"07-Meumodulo.lua"` no array `MODULOS`, **na posição correta**
3. Commit nos dois arquivos
4. Pronto

---

## 🐛 Debug — quando algo quebra

O `Loader.lua` mostra qual módulo deu erro:

```
[1/6] 01-Config.lua
   ✅ OK
[2/6] 02-Core.lua
   ✅ OK
[3/6] 03-Jogador.lua
   ✅ OK
[4/6] 04-Visual.lua
❌ Sintaxe errada em 04-Visual.lua: linha 234: expected 'end' near '}'
```

**Passos pra corrigir:**

1. Abre o arquivo que deu erro (`04-Visual.lua`)
2. Vai até a linha que o erro indicou
3. Corrige
4. Commit
5. Roda o Loader de novo

---

## 📝 Convenções usadas

- **Nomes de função globais** começam com `BG.` (ex: `BG.toggleZumbi`)
- **Nomes de função locais** começam minúsculo (ex: `local function criarToggle()`)
- **Notificações** são sempre chamadas via `BG.notifySucesso`, `BG.notifyErro` ou `BG.notifyInfo`
- **Comandos HD Admin** sempre via `cmdHD(";comando")`
- **Criação de partes server-side** sempre via `F3X:CreatePart` + `seBTP:InvokeServer("Sync...")`
- **Todo `pcall` que pode falhar** tem `notifyInfo` ou `notifyErro` avisando

---

## 🚫 Coisas que NÃO fazer

- ❌ **Não remove o `_G.BlackGUI`** no meio dos módulos
- ❌ **Não muda os nomes** dos arquivos sem atualizar o `Loader.lua`
- ❌ **Não cria variáveis globais comuns** (ex: `local funcao_global = ...` sem `BG.`) — outros módulos não vão ver
- ❌ **Não adiciona `task.wait()` longo** entre `criarBotao` no `06-GUI` — só trava a abertura do painel
- ❌ **Não usa `wait()` antigo** — usa `task.wait()` sempre

---

## 📋 Changelog dos módulos

### v1.0.0
- ✅ 6 módulos criados
- ✅ Sistema de notificações + key + missões
- ✅ F3X + HD Admin integrados
- ✅ Todas as features separadas por categoria

---

<div align="center">

**Volta pro repositório principal:** [README.md](../README.md)

</div>
