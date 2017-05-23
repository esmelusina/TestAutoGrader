#!/bin/bash

shopt -s extglob

branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')

git diff --name-only ${branch}..key >> FILENAME_RESULTS

for FILE in FILENAME_RESULTS
do    
  NAME=${FILE//+(*\/|\.*)}
  git checkout key
  LAST=($find -name NAME -print0 -quit)  
  echo ${NAME}
  git diff --unchanged-line-format="" --old-line-format="" --new-line-format=":%dn: %L" branch:FILE key:LAST
  echo
done

rm FILENAME_RESULTS