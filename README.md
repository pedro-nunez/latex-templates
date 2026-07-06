# Latex templates

To quickly create new latex documents.

## Available templates

- **Notes**: to take notes during a talk or lecture.
- **Script**: to write scripts for talks, lectures, etc.
- **Beamer**: for beamer presentations.
- **Blurb**: for short expository notes about a specific topic. Both the name and the idea are inspired by [Keith Conrad's expository papers](https://kconrad.math.uconn.edu/blurbs/). Many thanks to him for these nice writings, I've used them many times!
- **Solutions**: to write down solutions to exercises.

## Command-line workflow

The recommended way to create a new document is the `new-latex-document`
command. The workflow is local-first: it creates a project from the local copy
of this template repository and does not contact GitHub unless explicitly asked
to do so.

At this stage of the redesign, the new workflow is implemented for the `note`
template. The planned template types are:

- `note`: ordinary mathematical notes, short scripts, blurbs, and expository notes;
- `exercises`: exercise sheets, with optional solutions to be designed;
- `beamer`: presentations;
- `longform`: lecture notes and book-length projects.

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

## Edit templates and produce new examples

For example, to modify the template for notes:

1. Modify notes.tex with the desired changes
2. Modify examples/example.tex if a different example text is desirable
3. Run ./auxiliary/generate.sh notes.tex

## About the templates

### Predefined theorems

Mostly taken from the [amsthm package documentation](www.ams.org/arc/tex/amscls/amsthdoc.pdf). They all share the same numbering sequence:

```latex
\theoremstyle{plain}
\newtheorem{thm}{Theorem}
\newtheorem*{thm*}{Theorem}
\newtheorem{lm}[thm]{Lemma}
\newtheorem{prop}[thm]{Proposition}
\newtheorem{cor}[thm]{Corollary}
\newtheorem{fact}[thm]{Fact}
\newtheorem{q}[thm]{Question}

\theoremstyle{definition}
\newtheorem{defn}[thm]{Definition}
\newtheorem{nota}[thm]{Notation}
\newtheorem{exmp}[thm]{Example}
\newtheorem{xca}[thm]{Exercise}

\theoremstyle{remark}
\newtheorem{rem}[thm]{Remark}
```

### General remarks about the preamble

- Tries to minimize packages included by default, but still including a "bare-minimum" amount of packages for functionality and appearance reasons.
Since the "bare-minimum" is a bit subjective, especially when it comes to appearance, all those packages are listed and explained below.
- Doesn't contain personal macros by default.
- Does contain author and title information by default.
- Besides the packages, there are a couple appearance-related commands, which are also listed and explained below.

### "Bare-minimum" packages

```latex
\usepackage[T1]{fontenc}
```

This uses 8-bit font encoding (with 256 glyphs) instead of the default 7-bit font encoding (with 128 glyphs).
For example, with this option, ö is a single glyph in the font, whereas on the 7-bit font encoding the font ö is made by adding an accent to the existing glyph o.
A bad consequence of not using this package is (used to be?) that you cannot properly copy-paste words containing such characters from the output pdf file.
Also, for some reason, funny stuff happens with |, < and > outside of math-environments.

```latex
\usepackage[utf8]{inputenc}
```

This package is included just in case anyone tries to compile this code with an old version of LaTeX, cf. [this stackexchange answer](https://tex.stackexchange.com/a/560594/112609).
When you type ä in an editer set up for utf8, the machine stores the character number 228.
When TeX reads the file it finds the charcater number 228 and the macros of inputenc transform this into \"a.
Finally fontenc does its thing and transforms this into a command that prints the character 228.

```latex
\usepackage[british]{babel}
```

To manage culturally determined typographical and similar rules, in this case for british english.
One thing that would look different without this package right from the beginning would be the date format.

```latex
\usepackage{mathtools}
```

Loads the amsmath package (which provides commands such as \DeclareMathOperator and \text) and fixes some quirks it has, adding also some useful settings, symbols and environments.
It improves the appearance as well.

```latex
\usepackage{amsthm}
```

Improves the \newtheorem command that LaTeX includes by default.
Already included if using amsart article or amsbook class.

```latex
\usepackage{libertine}
\usepackage[libertine]{newtxmath}
```

Font packages.

```latex
\usepackage[mathrsfs]{euscript}
```

Math font for sheaves with \mathscr{F}.

```latex
\usepackage{enumitem}
```

To better control the layout of enumerate, itemize and description using \begin{enumerate}[label=...].
It supersedes the enumerate package.

```latex
\usepackage{tikz-cd}
\usetikzlibrary{decorations.markings}
```

To draw (hopefully) commutative diagrams.
The tikzlibrary is added to draw open and closed immersions.

```latex
\usepackage{float}
```

Improved interface for floating objects such as figures and tables, introducing for example the H modifier to force the position of a float in the page or the boxed float.
Should be loaded before hyperref.

```latex
\usepackage[
  backend=biber,
  style=alphabetic,
  maxnames=10,
  maxalphanames=10]{biblatex}
\addbibresource{refs.bib}
```

Bibliography management with biblatex, see [Overleaf's documentation](https://www.overleaf.com/learn/latex/Bibliography_management_with_biblatex).
The alphabetic style would display \[Har77\] for Hartshorne's *Algebraic Geometry* and \[KM98\] for Kollár and Mori's *Birational Geometry of Algebraic Varieties*.
The maxnames and maxalphanames arguments ensure that enough initials of names are displayed when dealing with references with many authors.

```latex
\usepackage{hyperref}
\urlstyle{same}
```

To handle cross-referencing and produce hypertext links in the document.
It should be loaded last (with few exceptions), because it redefines many LaTeX commands.
The command \urlstyle{same} makes sure that the font produced by an \url{...} command is the same as the current one, instead of the default monospace.

```latex
\usepackage[noabbrev]{cleveref}
```

Enhances cross-referencing features, e.g. to reference to a theorem and automatically include the word theorem.
No abbreviature option to write figure instead of fig. etc.
It requires some extra lines in the preamble:

```latex
\Crefname{thm}{Theorem}{Theorems}
\Crefname{lm}{Lemma}{Lemmas}
\Crefname{prop}{Proposition}{Propositions}
\Crefname{cor}{Corollary}{Corollaries}
\Crefname{fact}{Fact}{Facts}
\Crefname{q}{Question}{Questions}
\Crefname{defn}{Definition}{Definitions}
\Crefname{nota}{Notation}{Notations}
\Crefname{exmp}{Example}{Examples}
\Crefname{xca}{Exercise}{Exercises}
\Crefname{rem}{Remark}{Remarks}
```

That way, writing \Cref{label} will reference the corresponding theorem including the word Theorem in the reference.

### Other appearance-related stuff

```latex
\usepackage{geometry}
 \geometry{
 a4paper,
 total={170mm,257mm},
 left=20mm,
 top=20mm,
 }
```

To widen the margins in the solutions template.

```latex
\setcounter{tocdepth}{1}
```

To limit table of contents to section titles.

```latex
\sloppy
```

Often looks better.

```latex
\makeatletter
\hypersetup{
  pdfauthor={\authors},
  pdftitle={\@title},
  colorlinks,
  linkcolor=[rgb]{0.2,0.2,0.6},
  citecolor=[rgb]{0.2,0.6,0.2},
  urlcolor=[rgb]{0.6,0.2,0.2}}
\makeatother
```

Options for links and pdf output.
