# Currículo Pessoal Bilíngue

- [English Version](README.md)

Este repositório contém meu Currículo Vitae bilíngue (Inglês/Português), criado usando LaTeX. Foi projetado para ser facilmente versionado, modificado e compilado localmente.

## Contexto

Após inicialmente criar meu CV no Overleaf, decidi fazer a transição para uma configuração local para melhor controle de versão e para aplicar boas práticas de programação à documentação do meu desenvolvimento profissional. Este projeto representa essa transição e serve como um modelo para outros que possam querer fazer o mesmo.

## Características

- CV bilíngue (Inglês e Português)
- Versionado usando Git
- Compilável localmente usando Make
- Estrutura modular para fácil manutenção

## Software Necessário

Para usar este projeto, você precisará do seguinte software instalado em seu sistema:

1. Uma distribuição LaTeX:
   - Para Windows: [MiKTeX](https://miktex.org/) ou [TeX Live](https://www.tug.org/texlive/)
   - Para macOS: [MacTeX](https://www.tug.org/mactex/)
   - Para Linux: TeX Live (instale via gerenciador de pacotes da sua distribuição)

2. GNU Make (geralmente pré-instalado no macOS e Linux, para Windows considere instalar via [Chocolatey](https://chocolatey.org/) ou [MSYS2](https://www.msys2.org/))

3. Git para controle de versão

## Plugins e Ferramentas Úteis

1. Visual Studio Code com as seguintes extensões:
   - LaTeX Workshop: Fornece suporte LaTeX no VS Code
   - PDF Viewer: Para visualizar o PDF compilado dentro do VS Code
   - Git Graph: Para visualizar o histórico do Git

2. [Latexmk](https://mg.readthedocs.io/latexmk.html): Um script Perl para executar LaTeX o número correto de vezes para resolver referências cruzadas, etc.

3. [ChkTeX](https://www.nongnu.org/chktex/): Um verificador semântico de LaTeX

## Configuração

1. Clone este repositório:
   ```
   git clone https://github.com/seunomedeusuario/curriculo-bilingue.git
   cd curriculo-bilingue
   ```

2. Certifique-se de ter todo o software necessário instalado.

3. (Opcional) Instale as extensões recomendadas do VS Code.

## Gerenciamento de Informações Pessoais

Este projeto utiliza um arquivo `.env` para gerenciar informações pessoais. Aqui está como usá-lo:

1. Copie o arquivo de template:
   ```
   cp .env.template .env
   ```

2. Edite o arquivo `.env` com suas informações reais.

3. O arquivo `.env` é ignorado pelo Git (listado no .gitignore) para evitar o commit acidental de dados pessoais.

4. Ao compilar seu CV, o Makefile irá automaticamente injetar suas informações pessoais do arquivo `.env` nos documentos LaTeX.

Nota: Ao clonar este repositório, você precisará criar seu próprio arquivo `.env` baseado no template.

## Uso

1. Edite os arquivos `.tex` no diretório `chapters/` para atualizar o conteúdo do seu CV.

2. Compile o CV:
   - Para ambos os idiomas: `make`
   - Apenas para inglês: `make cv_en.pdf`
   - Apenas para português: `make cv_pt.pdf`

3. Limpe os arquivos auxiliares: `make clean`

## Estrutura do Projeto

```
.
├── Makefile
├── README.md
├── README_PT.md
├── bibliography.bib
├── chapters/
│   ├── education_en.tex
│   ├── education_pt.tex
│   ├── experience_en.tex
│   ├── experience_pt.tex
│   ├── projects_en.tex
│   ├── projects_pt.tex
│   ├── skills_en.tex
│   └── skills_pt.tex
├── config/
│   └── preamble.tex
├── .env.template
├── images/
├── main_en.tex
└── main_pt.tex
```

## Contribuindo

Embora este seja um projeto pessoal, sugestões de melhorias são bem-vindas. Por favor, abra uma issue para discutir mudanças propostas.

## Licença

Este projeto é de código aberto e está disponível sob a [Licença MIT](LICENSE).

## Agradecimentos

- Obrigado ao Overleaf por fornecer uma plataforma para começar com LaTeX
- À comunidade LaTeX por sua extensa documentação e suporte