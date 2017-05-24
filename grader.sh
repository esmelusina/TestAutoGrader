#!/bin/bash

shopt -s extglob

#branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
#branch=$(git show --oneline -s --format="%h")

branch=$(git show --oneline -s --format="%h")

git diff --name-only ${branch}..origin/key >> FILENAME_RESULTS


for FILE in $(cat FILENAME_RESULTS)
do    
  NAME=${FILE//+(*\/|\.*)}
  #LAST=$(git ls-tree -r --name-only origin/key | grep "\b${NAME}\b")
  echo ${NAME}
  diff --unchanged-line-format="" --old-line-format="" --new-line-format=":%dn " <(git show ${branch}:${FILE}) <(git show origin/key:${FILE})
  echo
done

rm FILENAME_RESULTS