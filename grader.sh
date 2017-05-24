#!/bin/bash

shopt -s extglob

#
commit=$(git show --oneline -s --format="%h")

branch=${1}

if [[ -z $branch ]]
then
branch=origin/key
fi

# Fetch all the files that differ from the answer key branch and the commit
git diff --name-only --diff-filter=M ${commit} ${branch} >> FILENAME_RESULTS


# for each file that has differences
for FILE in $(cat FILENAME_RESULTS)
do  
git show ${commit}:${FILE}
git show ${branch}:${FILE}
  echo ${FILE}  
    diff --unchanged-line-format="" --old-line-format="" --new-line-format="%dn " <(git show ${commit}:${FILE}) <(git show ${branch}:${FILE})
   echo
done

unset commit
unset branch
rm FILENAME_RESULTS