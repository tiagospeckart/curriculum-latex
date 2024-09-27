# Personal Bilingual Curriculum Vitae

[Versão em Português](README_PT.md)

This repository contains my bilingual (English/Portuguese) Curriculum Vitae, created using LaTeX. It's designed to be easily version-controlled, modified, and compiled locally.

## Background

After initially creating my CV on Overleaf, I decided to transition to a local setup for better version control and to apply good programming practices to my professional development documentation. This project represents that transition and serves as a template for others who might want to do the same.

## Features

- Bilingual CV (English and Portuguese)
- Version-controlled using Git
- Locally compilable using Make
- Modular structure for easy maintenance

## Required Software

To use this project, you'll need the following software installed on your system:

1. A LaTeX distribution:
   - For Windows: [MiKTeX](https://miktex.org/) or [TeX Live](https://www.tug.org/texlive/)
   - For macOS: [MacTeX](https://www.tug.org/mactex/)
   - For Linux: TeX Live (install via your distribution's package manager)

2. GNU Make (usually pre-installed on macOS and Linux, for Windows consider installing via [Chocolatey](https://chocolatey.org/) or [MSYS2](https://www.msys2.org/))

## Useful Plugins and Tools

1. Visual Studio Code with the following extensions:
   - LaTeX Workshop: Provides LaTeX support in VS Code
   - PDF Viewer: For viewing the compiled PDF within VS Code
   - Git Graph: For visualizing Git history

2. [Latexmk](https://mg.readthedocs.io/latexmk.html): A Perl script for running LaTeX the correct number of times to resolve cross-references, etc.

3. [ChkTeX](https://www.nongnu.org/chktex/): A LaTeX semantic checker

## Setup

1. Clone this repository:
   ```
   git clone https://github.com/tiagospeckart/curriculum-latex.git
   cd curriculum-latex
   ```

2. Ensure you have all the required software installed.

3. (Optional) Install recommended VS Code extensions.

## Handling Personal Information

This project uses a `.env` file to manage personal information. Here's how to use it:

1. Copy the template file:
   ```
   cp .env.template .env
   ```

2. Edit `.env` with your actual information.

3. The `.env` file is ignored by Git (listed in .gitignore) to prevent accidentally committing personal data.

4. When compiling your CV, the Makefile will automatically inject your personal information from the `.env` file into the LaTeX documents.

Note: When cloning this repository, you'll need to create your own `.env` file based on the template.

## Usage

1. Edit the `.tex` files in the `chapters/` directory to update your CV content.

2. Compile the CV:
   - For both languages: `make`
   - For English only: `make cv_en.pdf`
   - For Portuguese only: `make cv_pt.pdf`

3. Clean up auxiliary files: `make clean`

## Project Structure

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

## Contributing

While this is a personal project, suggestions for improvements are welcome. I'm new to this language so any help is welcome. Please open an issue to discuss proposed changes.

## License

This project is open source and available under the [MIT License](LICENSE).

## Acknowledgments

- Thanks to Overleaf for providing a platform to get started with LaTeX
- The LaTeX community for their extensive documentation and support
