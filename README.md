# Latex templates

To quickly create new latex documents.

## Available templates

- `note`: ordinary mathematical notes, short scripts, blurbs, and expository notes.
- `exercises`: exercise sheets, currently with visible solutions.
- `beamer`: presentations.
- `longform`: lecture notes and book-length projects.

## Command-line workflow

The recommended way to create a new document is the `new-latex-document`
command. The workflow is local-first: it creates a project from the local copy
of this template repository and does not contact GitHub unless explicitly asked
to do so.

The implemented template types are `note`, `exercises`, `beamer`, and
`longform`.

Create a local note project with:

```bash
new-latex-document note my-project
```

This creates a directory `my-project` in the current working directory, copies
the template files into it, initializes a local Git repository, and makes an
initial commit.

To create the project without initializing Git, use:

```bash
new-latex-document note my-project --no-git
```

GitHub repository creation is optional and is never attempted unless `--github`
is explicitly passed. When GitHub creation is requested, private repositories
are the default:

```bash
new-latex-document note my-project --github
```

To create a public GitHub repository, use:

```bash
new-latex-document note my-project --github --public
```

To explicitly suppress GitHub creation, use:

```bash
new-latex-document note my-project --no-github
```

The project name should be a portable directory name containing only letters,
numbers, dots, underscores, and hyphens.

## Installing the command

The simplest installation method is to symlink the script into `~/.local/bin`.

From the root of this repository, run:

```bash
mkdir -p "${HOME}/.local/bin"
ln -s "$(pwd)/scripts/new-latex-document" "${HOME}/.local/bin/new-latex-document"
```

Check that the command is available:

```bash
command -v new-latex-document
```

The expected output is something like:

```text
/home/USER/.local/bin/new-latex-document
```

If the command is not found, check that `~/.local/bin` is in your `PATH`.

To uninstall the command, remove the symlink:

```bash
rm "${HOME}/.local/bin/new-latex-document"
```

The symlink installation is easy to undo and keeps the command updated when the
repository is updated with Git.

## Showcase examples

The repository contains source files and compiled PDFs showing the appearance of
each template.

- [Note example](examples/pdf/note.pdf)
- [Exercises example](examples/pdf/exercises.pdf)
- [Beamer example](examples/pdf/beamer.pdf)
- [Longform example](examples/pdf/longform.pdf)

The example sources are in:

```text
examples/sources/
```

The generated showcase PDFs are kept in:

```text
examples/pdf/
```

Regenerate all showcase PDFs with:

```bash
scripts/build-examples
```

Regenerate a single showcase PDF with, for example:

```bash
scripts/build-examples note
```

Remove generated showcase PDFs and temporary build products with:

```bash
scripts/build-examples --clean
```

The PDFs in `examples/pdf/` are intentionally versioned so that visitors can
inspect the templates without compiling them locally.

## Bibliographies and local builds

The templates use `biblatex` with the `biber` backend. A full local build
therefore requires a LaTeX installation with `latexmk`, `biber`, and the
packages used by the selected template.

A typical build command inside a generated project is:

```bash
latexmk -pdf -interaction=nonstopmode -halt-on-error -file-line-error main.tex
```

The first build may run LaTeX, then `biber`, then LaTeX again. This is normal.

On systems where `biber` is not available, documents without citations may
still compile, but bibliographies and citation labels will not be resolved
properly. In that case, build the document on a machine with a complete LaTeX
installation.

## About the templates

### `note`

The `note` template is intended for ordinary mathematical notes, short scripts,
blurbs, and expository documents. It uses the `amsart` class.

It includes:

- theorem-like environments such as `theorem`, `lemma`, `proposition`,
  `corollary`, `definition`, `example`, and `remark`;
- `cleveref` names for the predefined theorem environments;
- theorem-numbered item lists via the `theoremitems` environment;
- ordinary enumerated-item references;
- `biblatex` with the `biber` backend;
- `tikz-cd` for commutative diagrams;
- coloured hyperlinks;
- PDF metadata derived from `\title` and `\author`;
- hidden-by-default draft notes and named author comments.

### `longform`

The `longform` template is intended for lecture notes and book-length projects.
It uses the `amsbook` class.

It has the same mathematical-writing preamble as `note`, but is kept in a
separate file so that the two templates can diverge later if needed.

### `exercises`

The `exercises` template is intended for exercise sheets. It uses the standard
`article` class.

Exercise sheets have metadata commands:

```latex
\course{Algebra I}
\sheetnumber{3}
\lecturer{Pedro Núñez}
\duedate{15 October 2026}
```

The command

```latex
\makesheetheader
```

prints the sheet header and sets PDF metadata automatically. Exercise numbers
are derived from the sheet number, so Sheet 3 has exercises numbered `3.1`,
`3.2`, and so on.

Solutions are hidden by default. To show them, replace

```latex
\showsolutionsfalse
```

with

```latex
\showsolutionstrue
```

before `\input{preamble}`.

### `beamer`

The `beamer` template is intended for presentations. It uses the `beamer` class
and keeps a separate preamble because Beamer already loads and configures many
packages differently from ordinary article/book documents.

### Optional Lean support

All templates can be generated with optional Lean code-listing support:

```bash
new-latex-document exercises my-sheet --lean
```

This adds a `leancode` environment and copies the local Lean listings definition
into the generated project.

Example usage:

```latex
\begin{leancode}
example : True := by
  trivial
\end{leancode}
```

### Draft notes and author comments

All templates support draft notes:

```latex
\showdraftnotestrue

\draftnote{Check this argument before circulating.}
```

Draft notes are hidden by default.

The `note` and `longform` templates also support named author comments:

```latex
\showcommentstrue

\newauthorcomment{alice}{Alice}{blue}
\newauthorcomment{bob}{Bob}{red}

\alice{Maybe cite this result.}
\bob{I agree.}
```

Author comments are hidden by default.
