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

commit=$(git show --oneline -s --format="%h")

branch=${1}

if [[ -z $branch ]]; then branch=origin/key; fi


for FILE in $(git diff --name-only --diff-filter=M ${commit} ${branch})
do  
  echo ${FILE}  
    diff-line <(git show ${commit}:${FILE}) <(git show ${branch}:${FILE})
   echo
done

unset commit
unset branch