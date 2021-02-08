# Latex_templates

To quickly create new latex documents.

## Available templates

- **Notes**: to take notes during a talk or lecture.
- **Script**: to write scripts for talks, lectures, etc.
- **Beamer**: for beamer presentations.
- **Blurb**: for short expository notes about a specific topic. Both the name and the idea are inspired by [Keith Conrad's expository papers](https://kconrad.math.uconn.edu/blurbs/). Many thanks to him for these nice writings, I've used them many times!

## Predefined theorems

Taken from the [amsthm package documentation](www.ams.org/arc/tex/amscls/amsthdoc.pdf), but sharing all the same numbering sequence instead:

```latex
\theoremstyle{plain}
\newtheorem{thm}{Theorem}
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

## About the preamble

- Tries to minimize packages included by default, but still including a "bare-minimum" that allows one to do the (arguably) essential stuff.
In the case of **Script** and **Beamer**, the preamble contains a few extra "appearance-related" packages as well.
All those packages are listed and explained below.
- Doesn't contain personal macros by default.
- Does contain author and title information by default.

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

```latex
\usepackage{amssymb}
```

More math symbols, e.g. \Cap and \Cup.
Provides the \mathbb command as well.
It also loads the amsfonts package: fraktur letters, bold greek letters, etc.
