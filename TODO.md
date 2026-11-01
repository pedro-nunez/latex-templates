# TODO list:

- [ ] Autocompletion for TEMPLATE?
- [ ] Configuration file for author name etc?
- [ ] Make a more streamlined new exercise sheet workflow.

Old new exercise sheet workflow:

```bash
#!/bin/bash

# The function below requires having hub installed

sheet() {
  # Create new exercise sheet for current lecture with corresponding private GitHub repository
  # First argument is the number of the exercise sheet
  # Second argument is the deadline to hand in the exercise sheet (DD.MM.YYYY)
  cd "${HOME}/git"
  mkdir "eg-blatt-${1}"
  cd "eg-blatt-${1}"
  cp "${HOME}/Templates/eg-ss-23/main.tex" "main.tex"
  cp "${HOME}/Templates/eg-ss-23/README.md" "README.md"
  cp "${HOME}/Templates/eg-ss-23/gitignore" ".gitignore"
  sed -i "s/number-of-blatt/${1}/g" "main.tex"
  sed -i "s/number-of-blatt/${1}/g" "README.md"
  sed -i "s/date-of-abgabe/${2}/g" "main.tex"
  git init
  git add .
  git commit -m "First commit"
  hub create -p
  git push origin master
}
```
