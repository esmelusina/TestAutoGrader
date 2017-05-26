
# Given two params whereby param $1 is the source we are testing against,
# Determine which lines of param $2 (submission) match
diff-line()
{
  src=$1
  sub=$2  
  lin=0

  # Limit loop to length of source- extra can be ignored
  while read srcline <$src || [ -n "$srcline" ] # for each line in the file (inclusive of non-terminating EOF)
  do
    read subline <$sub # also read from sub
    lin=$((lin+1)) # keep track of line numbers
    if [ "$subline" != "$srcline" ] ;  then printf "$lin " ; fi # feed line # into stdout
  done
}


# this is the submission commit
commit=$(git show --oneline -s --format="%h")
# this is the answer key branch
branch=${1}
# this is the user name
name=$TRAVIS_REPO_SLUG

# setup some defaults if the aboive are invalid for some reason
if [[ -z $branch ]]; then branch=origin/key; fi
if [[ $name ]]; then name=$(dirname $name); else name="NULL"; fi


# for machining, the name should be a database key
echo $name

## TODO : PRINT NAME ON EXACT MATCHES
### Check for perfect quiz answers
### For each file in the commit,
### just use git show in branch to see if there was a submission or not.
##  for FILE in $(git ls-tree -r --name-only ${commit})
##  do
    # 
##      git show ${branch}:$BASE.eo &>/dev/null    
##      if [[ $? -ne 0 ]]; then continue; fi
##  done


# quizes will check for non-historical file modifications
for FILE in $(git diff --name-only --diff-filter=M ${branch} ${commit})
do  
  echo ${FILE}  
    diff-line <(git show ${branch}:${FILE}) <(git show ${commit}:${FILE}) 
   echo
done

# programs need to be built
for FILE in $(git diff --name-only --diff-filter=A ${branch} ${commit} | grep .cpp)
do
    BASE=${FILE%%.*}
    git show ${branch}:$BASE.eo &>/dev/null    
    if [[ $? -ne 0 ]]; then continue; fi

    echo $BASE

    if hash g++ 2>/dev/null; then #just in case g++ isn't present'
      g++ $BASE.cpp -o $BASE
      chmod +x $BASE

      # branch for testing input
      git show ${branch}:$BASE.in &>/dev/null
      if [[ $? -ne 0 ]]
      then diff-line <(git show ${branch}:$BASE.eo) <(./$BASE)
      else diff-line <(git show ${branch}:$BASE.eo) <(./$BASE <(git show ${branch}:$BASE.in))
      fi
    fi      
done