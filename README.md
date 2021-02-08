# Latex_templates

To quickly create new latex documents.

## Available templates

- **Notes**: to take notes during a talk or lecture.
- **Script**: to write scripts for talks, lectures, etc.
- **Beamer**: for beamer presentations.
- **Blurb**: for short expository notes about a specific topic. Both the name and the idea are inspired by [Keith Conrad's expository papers](https://kconrad.math.uconn.edu/blurbs/). Many thanks to him for these nice writings, I've used them many times!

## About the preamble

- Tries to minimize packages included by default, but still including a "bare minimum" that allows one to do the (arguably) essential stuff. They are listed and explained below. In the case of **Script** and **Beamer**, the preamble contains a few extra appearance-related packages as well.
- Doesn't contain personal macros by default.
- Does contain author and title information by default.

### \usepackage[T1]{fontenc}

This uses 8-bit font encoding (with 256 glyphs) instead of the default 7-bit font encoding (with 128 glyphs).
For example...
