# Latex templates

To quickly create new latex documents.

## Available templates

- **Notes**: to take notes during a talk or lecture.
- **Script**: to write scripts for talks, lectures, etc.
- **Beamer**: for beamer presentations.
- **Blurb**: for short expository notes about a specific topic. Both the name and the idea are inspired by [Keith Conrad's expository papers](https://kconrad.math.uconn.edu/blurbs/). Many thanks to him for these nice writings, I've used them many times!

## Bash function to create new documents from the templates

```bash
new() {
    # Create a new latex document with the corresponding git repository
    # First argument is the type of template (beamer/blurb/notes/script)
    # Second argument is the name of the new document (blank spaces will be replaced by hyphens)
    cd "${HOME}/git"
    if [ "${1}" = "beamer" ] || [ "${1}" = "blurb" ] || [ "${1}" = "notes" ] || [ "${1}" = "script" ]
    then
	mkdir "$(echo "${@}" | tr ' ' '-')"
	cd "$(echo "${@}" | tr ' ' '-')"
	cp "${HOME}/git/latex-templates/${1}.tex" "main.tex"
	touch "main.bib"
	echo "# ${@:2}" >> "README.md"
	echo "" >> "README.md"
	echo "Document created from a the ${1} template [here](https://github.com/pedro-nlb/latex-templates)." >> "README.md"
	cp "${HOME}/git/latex-templates/auxiliary/gitignore" ".gitignore"
	git init
	git add .
	git commit -m "First commit"
	hub create -p "${GITHUBUSERNAME}/$(echo "${@}" | tr ' ' '-')"
	git push origin master
	cd
	read -p "Alias to edit main.tex [press enter if none]: "
	if [ -n "${REPLY}" ]
	then
	    echo "alias ${REPLY}=\"cd ~/git/$(echo "${@}" | tr ' ' '-'); vim main.tex\";" >> ".bash_aliases"
	fi
    else
	echo "Please enter as a first argument the type of template to use (beamer/blurb/notes/script) and use the remaining arguments for the name of the document and repository (blank spaces will be replaced by hyphens)."
    fi
    source .bash_aliases;
}
```

## Edit templates and produce new examples

For example, to modify the template for notes:

1. Modify notes.tex with the desired changes
2. Modify examples/example.tex if a different example text is desirable
3. Run ./auxiliary/generate.sh notes.tex

## About the templates

### Predefined theorems

Mostly taken from the [amsthm package documentation](www.ams.org/arc/tex/amscls/amsthdoc.pdf), but sharing all the same numbering sequence instead:

```latex
\theoremstyle{plain}
\newtheorem{thm}{Theorem}
\newtheroem*{thm*}{Theorem}
\newtheorem{lm}[thm]{Lemma}
\newtheorem{prop}[thm]{Proposition}
\newtheorem{cor}[thm]{Corollary}

\theoremstyle{definition}
\newtheorem{defn}[thm]{Definition}
\newtheorem{exmp}[thm]{Example}
\newtheorem{xca}[thm]{Exercise}

\theoremstyle{remark}
\newtheorem{rem}[thm]{Remark}
```

### General remarks about the preamble

- Tries to minimize packages included by default, but still including a "bare-minimum" amount of packages for functionality and appearance reasons.
All those packages are listed and explained below.
- Doesn't contain personal macros by default.
- Does contain author and title information by default.
- Besides the packages, there are also a few "appearance-related" commands.
These are also listed and explained below.

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
\usepackage{amssymb}
```

More math symbols, e.g. \Cap and \Cup.
Provides the \mathbb command as well.
It also loads the amsfonts package: fraktur letters, bold greek letters, etc.

```latex
\usepackage{mathrsfs}
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
\Crefname{defn}{Definition}{Definitions}
\Crefname{exmp}{Example}{Examples}
\Crefname{xca}{Exercise}{Exercises}
\Crefname{rem}{Remark}{Remarks}
```

That way, writing \Cref{label} will reference the corresponding theorem including the word Theorem in the reference.

```latex
\usepackage[backend=biber,style=alphabetic]{biblatex}
\addbibresource{main.bib}
```

To manage the bibliography.
Alphabetic is the style in which Hartshorne's *Algebraic Geometry* book would usually appear as [Har77].

### "Appearance-related" commands

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
  linkcolor=[rgb]{0,0.2,0.6},
  citecolor=[rgb]{0,0.2,0.6},
  urlcolor=[rgb]{0,0.2,0.6}}
\makeatother
```

Options for links and pdf output.
Links, URLs and citations are defined to be blue by default.

```latex
\makeatletter
\tikzcdset{
open/.code={\tikzcdset{hook, circled};},
closed/.code={\tikzcdset{hook, slashed};},
circled/.code={\tikzcdset{markwith={\draw (0,0) circle (.375ex);}};},
slashed/.code={\tikzcdset{markwith={\draw[-] (-.4ex,-.4ex) -- (.4ex,.4ex);}};},
markwith/.code={
\pgfutil@ifundefined{tikz@library@decorations.markings@loaded}%
{\pgfutil@packageerror{tikz-cd}{You need to say %
\string\usetikzlibrary{decorations.markings} to use arrow with markings}{}}{}%
\pgfkeysalso{/tikz/postaction={/tikz/decorate,
/tikz/decoration={
markings,
mark = at position 0.5 with
{#1}}}}},
}
\makeatother
```

To draw open and closed immersions. 
