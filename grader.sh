#!/bin/bash

shopt -s extglob


branch=($git rev-parse --abbrev-ref HEAD)

git diff --name-only branch..key >> FILENAME_RESULTS

for FILE in (FILENAME_RESULTS)
do    
  NAME=${FILE//+(*\/|\.*)}
  git checkout key
  LAST=($find -name NAME -print0 -quit)  
  echo ${NAME}
  git diff --unchanged-line-format="" --old-line-format="" --new-line-format=":%dn: %L" branch:FILE key:LAST
  echo
  
