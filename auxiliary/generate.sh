#/bin/bash

if [ "$1" = "beamer"* ]
then
    cd examples
    cp ../beamer.tex main.tex
    cp ../auxiliary/books.bib refs.bib
    # Append \input{sample} after line
    # \frame{\titlepage}
    sed -i '/\\frame{\\titlepage}/a\\n\\begin{frame}\n\t\\frametitle{Example frame}\n\t\\input{example}\n\\end{frame}' main.tex
    latexmk -pdf -silent main.tex
    mv main.pdf beamer.pdf
    rm main*
    xdg-open 2>/dev/null beamer.pdf
    cd ..
elif [ "$1" = "blurb"* ]
then
    cd examples
    cp ../blurb.tex main.tex
    cp ../auxiliary/books.bib refs.bib
    # Appned \input{example} after line
    # \tableofcontents
    sed -i '/\\tableofcontents/a\\n\\section{Example section}\n\\input{example}' main.tex
    latexmk -pdf -silent main.tex
    mv main.pdf blurb.pdf
    rm main*
    xdg-open 2>/dev/null blurb.pdf
    cd ..
elif [ "$1" = "notes"* ]
then
    cd examples
    cp ../notes.tex main.tex
    cp ../auxiliary/books.bib refs.bib
    # Appned \input{example} after line
    # \tableofcontents
    sed -i '/\\tableofcontents/a\\n\\section{Example section}\n\\input{example}' main.tex
    latexmk -pdf -silent main.tex
    mv main.pdf notes.pdf
    rm main*
    xdg-open 2>/dev/null notes.pdf
    cd ..
elif [ "$1" = "script"* ]
then
    cd examples
    cp ../script.tex main.tex
    cp ../auxiliary/books.bib refs.bib
    # Appned \input{example} after line
    # \end{center}
    sed -i '/\\end{center}/a\\n\\section{Example section}\n\\input{example}' main.tex
    latexmk -pdf -silent main.tex
    mv main.pdf script.pdf
    rm main*
    xdg-open 2>/dev/null script.pdf
    cd ..
elif [ "$1" = "solutions"* ]
then
    cd examples
    cp ../solutions.tex main.tex
    cp ../auxiliary/books.bib refs.bib
    # Appned \input{example-solution} after line
    # \tableofcontents
    sed -i '/\\maketitle/a\\n\\input{example-solution}' main.tex
    latexmk -pdf -silent main.tex
    mv main.pdf solutions.pdf
    rm main*
    xdg-open 2>/dev/null solutions.pdf
    cd ..
else
    echo "Please enter a valid argument."
fi
