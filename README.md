# LaTeX templates

CLI tool to quickly create new LaTeX documents from templates.

## Quick start

1. Clone the repository:

   ```bash
   git clone https://github.com/pedro-nunez/latex-templates.git
   cd latex-templates
   ```

2. Copy the example settings, then edit `config/user.sh` with your details:

   ```bash
   cp config/user_example.sh config/user.sh
   ```

3. Optionally [install the command](#installing-the-command) to use it from any directory.

4. Create a document from the repository root:

   ```bash
   scripts/new_latex_document note my_notes
   ```

   If installed, use `new_latex_document` instead of `scripts/new_latex_document`.

See [Create new documents from templates](#create-new-documents-from-templates)
for the available options when creating a new document.

## Available templates

- `note`: ordinary mathematical notes, short scripts, blurbs, and expository notes.
- `exercises`: exercise sheets, currently with solutions hidden by default.
- `beamer`: presentations.
- `report`: lecture notes and book-length projects.

### To-do and author comments

All templates support to-do notes when created with `--todo`:

```latex
\showtodostrue

\todo{Double-check this argument.}
```

To-do notes are hidden by default.

All templates also support named author comments when created with `--comments`:

```latex
\showcommentstrue

\newauthorcomment{alice}{Alice}{blue}
\newauthorcomment{bob}{Bob}{red}

\alice{Maybe cite this result.}
\bob{I agree.}
```

Author comments are hidden by default.

## Available scripts

- `new_latex_document`: create personalized documents with a local Git repository and optional GitHub repository.
- `build_preamble`: write a complete preamble, including metadata, to standard output.
- `build_templates`: generate complete template `.tex` files.
- `build_examples`: generate showcase `.tex` files and PDFs.
- `rebuild`: run both `build_templates` and `build_examples`.

### System requirements

The scripts are written in Bash and tested on Ubuntu Linux.
Other Linux distributions should also work.
Windows is supported only through WSL,
and macOS has not been tested.

Creating a project requires Git with an author identity unless `--no-git` is used.
Compiling PDFs requires a TeX installation with the template packages and
`latexmk`; templates with bibliographies also require Biber.

Requirements for the GitHub integration:

1. Git with an author identity configured.
2. GitHub CLI, gh, installed.
3. gh authenticated with GitHub.
4. Git authentication configured so the initial commit can be pushed.

### Create new documents from templates

The recommended way to create a new document is the `new_latex_document`
command. The workflow is local-first: it creates a project from the local copy
of this template repository and does not contact GitHub unless explicitly asked
to do so.

First, from the repository root, create your personal settings file:

```bash
cp config/user_example.sh config/user.sh
```

Edit its name, email, homepage, affiliation and address fields. Name, affiliation
and address may contain LaTeX formatting; email and homepage are plain text.
This personal file is ignored by Git;
`config/user_example.sh` remains the generic example.

Install the command as described below, or use `scripts/new_latex_document`
from the repository root.

For example, create a local note project with:

```bash
new_latex_document note my-project
```

This creates `my-project` with a complete `main.tex`, `refs.bib`, `.gitignore`
and `README.md`, then initializes Git and makes an initial commit. The project
is independent of this repository. Edit `main.tex` and compile from the project
directory with `latexmk -pdf main.tex`.

Use `--title 'My title'` to set the title (except for exercise sheets), or
`--user FILE` to select another settings file. Relative paths are resolved from
the directory where you run the command.

To create the project without initializing Git, use:

```bash
new_latex_document note my-project --no-git
```

GitHub repository creation is optional and is never attempted unless `--github`
is explicitly passed. When GitHub creation is requested, private repositories
are the default:

```bash
new_latex_document note my-project --github
```

To create a public GitHub repository, use:

```bash
new_latex_document note my-project --github --public
```

The project name should contain only letters,
numbers, dots, underscores, and hyphens.

#### Optional Lean support

All templates can be generated with optional Lean code-listing support:

```bash
new_latex_document exercises my-sheet --lean
```

This adds a `leancode` environment and copies `lstlean.tex` into the project.
It typesets code without running Lean. In Beamer, use a `[fragile]` frame.

Example usage:

```latex
\begin{leancode}
example : True := by
    trivial
\end{leancode}
```

### Installing the command

On a Linux system using Bash, the simplest installation method is
to symlink the script into `~/.local/bin`.

From the root of this repository, run:

```bash
mkdir -p "${HOME}/.local/bin"
ln -s "$(pwd)/scripts/new_latex_document" "${HOME}/.local/bin/new_latex_document"
```

If you prefer a shorter name for the command, you can also run the following
instead:

```bash
mkdir -p "${HOME}/.local/bin"
ln -s "$(pwd)/scripts/new_latex_document" "${HOME}/.local/bin/new"
```

Check that the command is available:

```bash
command -v new_latex_document
```

The expected output is something like:

```text
/home/USER/.local/bin/new_latex_document
```

If the command is not found, check that `~/.local/bin` is in your `PATH`.

To uninstall the command, remove the symlink:

```bash
rm "${HOME}/.local/bin/new_latex_document"
```

If you chose `new`, use that name in the check and uninstall commands too.
Keep the repository at the symlink target; updating it also updates the command.

### Generate showcase examples

The repository contains source files and compiled PDFs showing the appearance of
each template.

- [Note example](examples/note.pdf)
- [Exercises example](examples/exercises.pdf)
- [Beamer example](examples/beamer.pdf)
- [Report example](examples/report.pdf)

Editable example bodies are in `sources/examples/`. Generated complete `.tex`
files and PDFs are in `examples/`.

Regenerate all showcase sources and PDFs with:

```bash
scripts/build_examples
```

To regenerate a single example, say note, use:

```bash
scripts/build_examples note
```

After modifying the sources under sources/, run scripts/rebuild to regenerate both the templates and the examples.

## AI disclaimer

AI's assistance has been used to update the code in this repository.
Every line of code suggested by AI used in the code of this repository
was carefully reviewed by a human.
