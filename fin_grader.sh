
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


# FOR ALL ADDED FILES
for FILE in $(git diff --name-only --diff-filter=A ${branch} ${commit})
do
    BASE=${FILE%%.*}
    
    ## If this is a quiz answer submission:
    if [ "${FILE##*.}" = "an" ]; then
        ## verify that the submission lines up with an answer key
        git show ${branch}:$BASE.ky &>/dev/null    
        if [[ $? -ne 0 ]]; then continue; fi
        ## if so, we can do the diff and output appropriate information
        echo ${FILE}
        diff-line <(git show ${branch}:${BASE}.ky) <(git show ${commit}:${FILE}) 
        echo

    ## If this is a program submission:
    elif [ "${FILE##*.}" = "cpp" ]; then
        ## verify that the submission has an expected output
        git show ${branch}:$BASE.eo &>/dev/null    
        if [[ $? -ne 0 ]]; then continue; fi    

        ## if so, we can build and do the diff.
        echo $FILE
        if hash g++ 2>/dev/null; then #bypass if g++ isn't present
            g++ $BASE.cpp -o $BASE
            chmod +x $BASE

            # branch for testing input
            git show ${branch}:$BASE.in &>/dev/null
            if [[ $? -ne 0 ]]
                then diff-line <(git show ${branch}:$BASE.eo) <(./$BASE)
                else diff-line <(git show ${branch}:$BASE.eo) <(./$BASE <(git show ${branch}:$BASE.in))
            fi
        fi
    fi      
done