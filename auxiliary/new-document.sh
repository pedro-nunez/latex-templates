#!/bin/bash

# The function below requires having hub installed

new() {
  # Create a new LaTeX document with corresponding private GitHub repository
  # First argument is the type of template (beamer/blurb/notes/script/solutions)
  # Second argument is the name of the new document (blank spaces will be replaced by hyphens)
  cd "${HOME}/git"
  if [ "${1}" = "beamer" ] || [ "${1}" = "blurb" ] || [ "${1}" = "notes" ] || [ "${1}" = "script" ] || [ "${1}" = "solutions" ]
  then
    mkdir "$(echo "${@}" | tr ' ' '-')"
    cd "$(echo "${@}" | tr ' ' '-')"
    cp "${HOME}/git/latex-templates/${1}.tex" "main.tex"
    touch "refs.bib"
    echo "# ${@:2}" >> "README.md"
    echo "" >> "README.md"
    echo "Document created from the ${1} template [here](https://github.com/pedro-nunez/latex-templates)." >> "README.md"
    cp "${HOME}/git/latex-templates/auxiliary/gitignore" ".gitignore"
    git init
    git add .
    git commit -m "First commit"
    hub create -p
    git push origin master
    cd
    read -p "Alias to edit main.tex [press enter if none]: "
    if [ -n "${REPLY}" ]
    then
      echo "alias ${REPLY}=\"cd ~/git/$(echo "${@}" | tr ' ' '-'); vim main.tex\";" >> ".bash_aliases"
    fi
  else
    echo "Please enter as a first argument the type of template to use (beamer/blurb/notes/script/solutions) and use the remaining arguments for the name of the document and repository (blank spaces will be replaced by hyphens)."
  fi
  source .bash_aliases;
}
