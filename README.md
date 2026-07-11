# LaTeX templates

CLI tool to quickly create new LaTeX documents from templates.

## Available templates

- `note`: ordinary mathematical notes, short scripts, blurbs, and expository notes.
- `exercises`: exercise sheets, currently with solutions hidden by default.
- `beamer`: presentations.
- `longform`: lecture notes and book-length projects.

### Draft notes and author comments

All templates support draft notes:

```latex
\showdraftnotestrue

\draftnote{Double-check this argument.}
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

## Available scripts

- `new-latex-document': to create new LaTeX documents from the templates with local Git repository and optional GitHub repository.
- `build-examples': to generate showcase example PDFs.

### System requirements

The scripts are written in Bash and tested on Ubuntu Linux.
Other Linux distributions should also work.
Windows is supported only through WSL,
and macOS has not been tested.

Requirements for the GitHub integration:

1. Git with an author identity configured.
2. GitHub CLI, gh, installed.
3. gh authenticated with GitHub.
4. Git authentication configured so the initial commit can be pushed.

### Create new documents from templates

The recommended way to create a new document is the `new-latex-document`
command. The workflow is local-first: it creates a project from the local copy
of this template repository and does not contact GitHub unless explicitly asked
to do so.

For example, create a local note project with:

```bash
new-latex-document note my-project
```

This creates a directory `my-project` in the current working directory, copies
the note template files into it, initializes a local Git repository, and makes an
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

The project name should contain only letters,
numbers, dots, underscores, and hyphens.

#### Optional Lean support

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

### Installing the command

On a Linux system using Bash, the simplest installation method is
to symlink the script into `~/.local/bin`.

From the root of this repository, run:

```bash
mkdir -p "${HOME}/.local/bin"
ln -s "$(pwd)/scripts/new-latex-document" "${HOME}/.local/bin/new-latex-document"
```

If you prefer a shorter name for the command, you can also run the following
instead:

```bash
mkdir -p "${HOME}/.local/bin"
ln -s "$(pwd)/scripts/new-latex-document" "${HOME}/.local/bin/new"
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

### Generate showcase examples

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

To regenerate a single showcase PDF, say note, use:

```bash
scripts/build-examples note
```

## AI disclaimer

I have used AI's assistance to update the code of this repository.
Every line of code suggested by AI used in the code of this repository
was carefully reviewed by a human.
