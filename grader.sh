#!/bin/bash

shopt -s extglob

#branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
branch=$(git show --oneline -s --format="%h")

git diff --name-only ${branch}..key >> FILENAME_RESULTS


for FILE in $(cat FILENAME_RESULTS)
do    
  NAME=${FILE//+(*\/|\.*)}
  LAST=$(git ls-tree -r --name-only master | head -2 | grep ${NAME})
  echo ${NAME}
  diff --unchanged-line-format="" --old-line-format="" --new-line-format=":%dn " <(git show ${branch}:FILE) <(git show key:LAST)
  echo
done

rm FILENAME_RESULTS
