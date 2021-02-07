# Latex_templates

To quickly create new latex documents.

## Available templates

- **Notes**: to take notes during a talk or lecture.
- **Script**: to write scripts for talks, lectures, etc.
- **Beamer**: for beamer presentations.
- **Blurb**: for short expository notes about a very specific topic. Both the name and the idea are inspired by [Keith Conrad's expository papers](https://kconrad.math.uconn.edu/blurbs/). Many thanks to him for these nice writings, I've used them many times!

## About the preamble

- Trying to minimize packages included by default, but still including a "bare minimum" that allows to do the stuff that I consider essential. What each of them does is explained as a comment in the tex file. They include
  - fontenc and inputenc,
  - the AMS packages,
  - tikz-cd,
  - enumitem,
  - float,
  - hyperref,
  - cleverref.
- Doesn't contain personal macros by default.
- Does contain author and title information by default.
