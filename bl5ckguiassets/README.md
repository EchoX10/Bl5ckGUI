# 📦 BL5CK GUI Assets

Pasta de imagens e recursos visuais do **BL5CK GUI**. Todos os arquivos `.png`, `.jpg`, `.jpeg`, `.webp` e `.gif` que ficam aqui são baixados automaticamente pelo Loader e salvos em `Bl5ckGUI/assets/` no disco do executor.

## 🖼️ Como o Loader baixa os assets

O Loader executa **essa etapa automaticamente** quando você abre o painel:

1. Chama a API do GitHub (`api.github.com/repos/EchoX10/Bl5ckGUI/contents/bl5ckguiassets`)
2. Lista todos os arquivos que terminam em `.png`, `.jpg`, `.jpeg`, `.webp` ou `.gif`
3. Baixa cada um pra `Bl5ckGUI/assets/` no disco do executor
4. Se o arquivo já existe, **não baixa de novo** (cache)
