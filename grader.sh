#!/bin/bash

shopt -s extglob

#
commit=$(git show --oneline -s --format="%h")

# Fetch all the files that differ from the answer key branch and the commit
git diff --name-only --diff-filter=M ${commit}..origin/key >> FILENAME_RESULTS

# for each file that has differences
for FILE in $(cat FILENAME_RESULTS)
do  
  echo ${FILE}  
    diff --unchanged-line-format="" --old-line-format="" --new-line-format="%dn " <(git show --quiet ${commit}:${FILE}) <(git show --quiet origin/key:${FILE})
   echo
done

#unset NAME
#unset commit
#rm FILENAME_RESULTS