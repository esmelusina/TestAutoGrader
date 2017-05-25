#!/bin/bash

shopt -s extglob


diff-line()
{
  sub=$1
  src=$2
  lin=0

  while read srcline <$src || [ -n "$srcline" ]
  do
    read subline <$sub
    lin=$((lin+1))
    if [ "$subline" != "$srcline" ] ;  then printf "$lin " ; fi    
  done
  echo
}


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
  echo ${FILE}  
    diff-line <(git show ${commit}:${FILE}) <(git show ${branch}:${FILE})
    diff --unchanged-line-format="" --old-line-format="" --new-line-format="%dn " <(git show ${commit}:${FILE}) <(git show ${branch}:${FILE})
   echo
done

unset commit
unset branch
rm FILENAME_RESULTS