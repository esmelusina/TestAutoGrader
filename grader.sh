#!/bin/bash

shopt -s extglob

git diff --name-only master..key >> FILENAME_RESULTS

for FILE in (FILENAME_RESULTS)
do    
  NAME=${FILE//+(*\/|\.*)}
  git checkout key
  LAST=($find -name NAME -print0 -quit)  
  echo ${NAME}
  git diff --unchanged-line-format="" --old-line-format="" --new-line-format=":%dn: %L" master:FILE key:LAST
  echo
  
