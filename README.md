<div align="center">

# 🖤 BlackGUI

**Interface moderna e organizada para Roblox, com tema escuro, abas, notificações e componentes reutilizáveis.**

![Lua](https://img.shields.io/badge/Language-Lua-blue?logo=lua&logoColor=white)
![Roblox](https://img.shields.io/badge/Platform-Roblox-orange?logo=roblox&logoColor=white)
![GitHub](https://img.shields.io/github/stars/SEU-USUARIO/SEU-REPO?style=social)
![GitHub forks](https://img.shields.io/github/forks/SEU-USUARIO/SEU-REPO?style=social)
![License](https://img.shields.io/badge/License-MIT-green)

</div>

---

## 📌 Sobre o projeto

O **BlackGUI** é um projeto de interface para Roblox focado em organização visual e experiência do usuário. Ele utiliza um tema escuro estilo AMOLED, sistema de abas laterais/superiores, notificações animadas e componentes reutilizáveis para criar painéis mais limpos e profissionais.

Este repositório tem finalidade **educacional e de estudo de UI/UX para Roblox**, servindo como base para quem quer aprender a criar interfaces organizadas, responsivas e visualmente atraentes.

---

## ✨ Recursos

- 🖤 **Tema AMOLED**  
  Interface com fundo preto profundo e detalhes sutos em cinza/verde.

- 🗂️ **Sistema de abas**  
  Organização por categorias para facilitar a navegação.

- 🔔 **Notificações animadas**  
  Avisos de sucesso, erro e informação com efeitos visuais.

- 🎛️ **Componentes reutilizáveis**  
  Botões, toggles, inputs e frames padronizados.

- 📱 **Layout adaptável**  
  Elementos pensados para ficarem organizados em diferentes resoluções.

- 🧩 **Estrutura modular**  
  Código separado por responsabilidades para facilitar manutenção.

---

## 🧱 Pré-requisitos

Antes de usar ou modificar o projeto, você vai precisar de:

- [Roblox Studio](https://www.roblox.com/create)
- Conhecimento básico em **Lua**
- Noções de **Instance**, **ScreenGui**, **Frame**, **TextLabel**, **TextButton** e **ScrollingFrame**

---

## 🚀 Instalação

### 1. Clone o repositório

```bash
git clone https://github.com/SEU-USUARIO/SEU-REPO.git
```

### 2. Abra o Roblox Studio

Crie um novo place ou abra um existente.

### 3. Importe os scripts

Coloque os arquivos Lua dentro da estrutura adequada do Roblox Studio, por exemplo:

```text
StarterPlayer
└── StarterPlayerScripts
    └── BlackGUI
        ├── Init.client.lua
        ├── Config.lua
        ├── Notifications.lua
        ├── Components.lua
        └── Tabs.lua
```

### 4. Teste a interface

Execute o place no Roblox Studio e verifique se a GUI aparece corretamente.

---

## 📁 Estrutura do projeto

```text
.
├── README.md
├── LICENSE
└── src
    ├── Init.client.lua
    ├── Config.lua
    ├── Notifications.lua
    ├── Components.lua
    ├── Tabs.lua
    └── Assets
        └── background.png
```

| Arquivo | Descrição |
|---|---|
| `Init.client.lua` | Ponto inicial da interface |
| `Config.lua` | Configurações visuais e constantes |
| `Notifications.lua` | Sistema de notificações |
| `Components.lua` | Botões, toggles e elementos reutilizáveis |
| `Tabs.lua` | Lógica das abas e organização do conteúdo |
| `Assets/` | Imagens e recursos visuais |

---

## 🎨 Personalização

Você pode alterar facilmente:

- Cor de fundo
- Cor de destaque
- Tamanho da janela
- Nome das abas
- Textos dos botões
- Animações das notificações

Exemplo de configuração:

```lua
local Config = {
    Title = "BlackGUI",
    BackgroundColor = Color3.fromRGB(0, 0, 0),
    AccentColor = Color3.fromRGB(40, 180, 70),
    Width = 320,
    Height = 350
}
```

---

## 📸 Screenshots

Adicione imagens da sua interface aqui.

```markdown
![Preview 1](docs/preview1.png)
![Preview 2](docs/preview2.png)
```

Dica: crie uma pasta `docs/` no repositório e coloque os prints lá.

---

## 🧠 Aprendizados usados neste projeto

Este repositório pode servir de estudo para:

- Criação de GUIs no Roblox
- Uso de `ScreenGui`, `Frame`, `ScrollingFrame`
- Organização visual com `UICorner`, `UIStroke`, `UIListLayout`
- Sistemas de notificação
- Interface por abas
- Boas práticas de separação de código

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Para contribuir:

1. Faça um fork do projeto
2. Crie uma branch nova:

```bash
git checkout -b minha-feature
```

3. Faça suas alterações
4. Commit:

```bash
git commit -m "Adicionei nova aba de configurações"
```

5. Push:

```bash
git push origin minha-feature
```

6. Abra um Pull Request

---

## ⚠️ Aviso legal

Este projeto é apenas para fins educacionais e de estudo de interface para Roblox.

Ele **não deve ser usado** para:

- Explorar vulnerabilidades
- Causar prejuízo a outros jogadores
- Automatizar ações maliciosas
- Violar os Termos de Serviço da Roblox

O autor não se responsabiliza por mau uso do código.

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## 💬 Contato

Se tiver dúvidas, sugestões ou quiser colaborar, abra uma issue no GitHub ou entre em contato pelos meios abaixo:

- Discord: `x5_bl5ck_5x`

---

<div align="center">

</div>
