# 📦 Módulos — BL5CK GUI

Documentação técnica dos módulos internos do projeto **BL5CK GUI**.

---

## 📌 Visão Geral

Esta pasta contém os módulos responsáveis pela execução do painel. Cada módulo é carregado sequencialmente pelo `Loader.lua` e compartilha estado através da tabela global `_G.BlackGUI`.

A arquitetura é dividida por **domínio funcional**, de forma que cada arquivo possui responsabilidade única e bem definida, facilitando manutenção, testes e evolução independente.

---

## 🗂️ Estrutura dos Módulos

| # | Arquivo | Responsabilidade |
|---|---------|------------------|
| 01 | `01-Config.lua` | Configurações globais, sistema de notificações, autenticação por key e módulo de missões |
| 02 | `02-Core.lua` | Integração F3X Wrapper, conexão HD Admin e funções utilitárias compartilhadas |
| 03 | `03-Jogador.lua` | Funcionalidades do jogador: clone, zumbi, tools, modo tóxico, armadilha e acessório flutuante |
| 04 | `04-Visual.lua` | Efeitos visuais: spam de partículas, partículas server-side, texturização, coloração e sistema de música |
| 05 | `05-Mapa.lua` | Funcionalidades de mapa: obby, NPC, meteorito, bandeira, natural disaster e metero áudio |
| 06 | `06-GUI.lua` | Interface principal, sistema de abas e vinculação de eventos |

---

## 🔄 Ordem de Execução

A ordem de carregamento é **obrigatória** e definida no array `MODULOS` do `Loader.lua`:

```
01-Config.lua
    ↓
02-Core.lua
    ↓
03-Jogador.lua
04-Visual.lua
05-Mapa.lua
    ↓
06-GUI.lua
```

Módulos posteriores dependem das funções e variáveis expostas pelos anteriores. Alterar a ordem sem ajustar as dependências resultará em erro de runtime.

---

## 🔗 Arquitetura de Comunicação

A comunicação entre módulos ocorre exclusivamente através da tabela `_G.BlackGUI`, inicializada pelo `Loader.lua` antes da execução do primeiro módulo.

### Inicialização (Loader.lua)

```lua
_G.BlackGUI = _G.BlackGUI or {}
local BG = _G.BlackGUI

BG.Players           = game:GetService("Players")
BG.ReplicatedStorage = game:GetService("ReplicatedStorage")
BG.SoundService      = game:GetService("SoundService")
BG.TweenService      = game:GetService("TweenService")
BG.UserInputService  = game:GetService("UserInputService")
BG.RunService        = game:GetService("RunService")
BG.CoreGui           = game:GetService("CoreGui")
BG.plr               = BG.Players.LocalPlayer
BG.playerGui         = BG.plr:WaitForChild("PlayerGui")
```

### Exposição de Funcionalidades

Cada módulo registra suas funcionalidades públicas na tabela `BG`:

```lua
-- Módulo 03-Jogador.lua
function BG.toggleZumbi(ativar)
    -- implementação
end
```

### Consumo entre Módulos

Módulos posteriores importam a referência local e utilizam as funções expostas:

```lua
-- Módulo 06-GUI.lua
local BG = _G.BlackGUI

criarToggle("Zumbi", function(estado)
    BG.toggleZumbi(estado)
end, tab1)
```

---

## 📝 Convenções de Código

### Nomenclatura

| Elemento | Padrão | Exemplo |
|----------|--------|---------|
| Funções expostas globalmente | Prefixo `BG.` | `BG.toggleZumbi` |
| Funções locais | camelCase minúsculo | `local function criarToggle()` |
| Constantes de módulo | UPPER_SNAKE_CASE | `TEMPO_EXPIRACAO` |
| Tabelas de configuração | UPPER_SNAKE_CASE | `MUSIC_PRESETS` |

### Tratamento de Erros

Chamadas que podem falhar devem ser envolvidas em `pcall`:

```lua
pcall(function()
    seBTP:InvokeServer("CreateDecorations", {{Part = parte}})
end)
```

Chamadas críticas devem notificar o usuário:

```lua
if not seBTP then
    notifyErro("Building Tools+ não encontrada")
    return
end
```

### Comunicação com Serviços

- 🎮 **HD Admin:** todos os comandos via `cmdHD(";comando")`
- 🔨 **F3X:** criação de partes via `F3X:CreatePart` seguida de sincronização server-side
- 🔔 **Notificações:** sempre via `notifySucesso`, `notifyErro` ou `notifyInfo`

### Restrições

- ❌ Não utilizar `wait()` — utilizar `task.wait()` exclusivamente
- ❌ Não declarar variáveis globais fora da tabela `BG`
- ❌ Não modificar `_G.BlackGUI` após a inicialização (apenas adicionar novas chaves)
- ❌ Não introduzir `task.wait()` prolongado na construção da GUI (módulo 06)

---

## ➕ Adição de Novos Módulos

Para adicionar um novo módulo ao projeto:

1. Criar o arquivo na pasta `modules/` seguindo o padrão de nomenclatura (`NN-Nome.lua`)
2. Registrar o módulo no array `MODULOS` do `Loader.lua`, na posição apropriada da cadeia de dependências
3. Garantir que o módulo finalize com uma chamada de log: `print("[NomeModulo] Módulo carregado")`
4. Testar em ambiente controlado antes de realizar o commit

---

## 🐛 Diagnóstico de Falhas

O `Loader.lua` reporta o módulo e a linha exata em caso de falha:

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

### Procedimento de Correção

1. Acessar o arquivo indicado
2. Localizar a linha reportada
3. Aplicar a correção
4. Realizar commit
5. Executar o Loader novamente para validar

### Erros Comuns

| Mensagem | Causa | Solução |
|----------|-------|---------|
| `attempt to index nil value` | Módulo anterior não expôs a função esperada | Verificar ordem no `Loader.lua` |
| `expected 'end' near ...` | Bloco de código não finalizado corretamente | Revisar linha reportada |
| `attempt to call nil value` | Função chamada antes de ser definida | Mover definição para antes do uso |
| `HttpGet failed` | URL inválida ou repositório inacessível | Verificar URL raw no GitHub |

---

## 📅 Versionamento

Alterações nos módulos devem seguir o padrão **Conventional Commits**:

```
feat: adicionado suporte a X
fix: corrigido erro em Y
docs: atualizada documentação de Z
refactor: reorganizado módulo W
```

---

## 🔗 Referências

- 📄 [README principal](../README.md)
- 📄 [Loader.lua](../Loader.lua)

---

<div align="center">

**BL5CK GUI** — Documentação interna de módulos

</div>
