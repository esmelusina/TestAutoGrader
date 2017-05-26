diff-line()
{
  src=$1
  sub=$2  
  lin=0

  while read srcline <$src || [ -n "$srcline" ]
  do
    read subline <$sub
    lin=$((lin+1))
    if [ "$subline" != "$srcline" ] ;  then printf "$lin " ; fi    
  done
}


commit=$(git show --oneline -s --format="%h")
branch=${1}
name=$TRAVIS_REPO_SLUG

if [[ -z $branch ]]; then branch=origin/key; fi
if [[ $name ]]; then name=$(dirname $name); else name="NULL"; fi

echo $name

# verify that an .eo file matches, otherwise we should ignore
for FILE in $(git diff --name-only --diff-filter=A ${branch} ${commit} | grep .cpp)
do
    BASE=${FILE%%.*}
    git show ${branch}:$BASE.eo &>/dev/null    
    if [[ $? -ne 0 ]]; then continue; fi

    echo $BASE

    if hash g++ 2>/dev/null; then
      g++ $BASE.cpp -o $BASE
      chmod +x $BASE

      #git show ${branch}:$BASE.in &>/dev/null
      #if [[ $? -ne 0 ]]
      #then diff-line <(git show ${branch}:$BASE.eo) <(./$BASE)
      #else
      diff-line <(git show ${branch}:$BASE.eo) <(./$BASE <(git show ${branch}:$BASE.in) )      
      ./$BASE
      #fi
    fi      
done




#diff-line <(git show ${branch}:$BASE.eo) <(./$BASE.exe <(git show ${branch}:$BASE.in))