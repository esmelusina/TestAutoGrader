#!/bin/bash

shopt -s extglob

#
commit=$(git show --oneline -s --format="%h")

# Fetch all the files that differ from the answer key branch and the commit
git diff --name-only ${commit}..origin/key >> FILENAME_RESULTS

# for each file that has differences
for FILE in $(cat FILENAME_RESULTS)
do  
  echo ${FILE}  
  #NAME=${FILE//+(*\/|\.*)}
  git rev-parse --verify --quiet origin/key:${FILE} >/dev/null
  ec1=$?
  git rev-parse --verify --quiet ${commit}:${FILE} >/dev/null
  ec2=$?
  echo $ec1
  echo $ec2
    
    diff --unchanged-line-format="" --old-line-format="" --new-line-format="%dn " <(git show --quiet ${commit}:${FILE}) <(git show --quiet origin/key:${FILE})
  #fi
   echo
done

#unset NAME
#unset commit
rm FILENAME_RESULTS