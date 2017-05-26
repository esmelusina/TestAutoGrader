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
for FILE in $(git diff --name-only --diff-filter=A ${branch} ${commit} | grep *.cpp)
do
    #git show ${branch}:$BASE.eo > /dev/null
    if <(git show ${branch}:$BASE.eo)
    then
    echo "EO WAS NOT FOUND!"
    else
    echo "EO WAS FOUND!"
    fi
    BASE=${FILE%%.*}
    g++ $BASE.cpp -o $BASE
    chmod +x $BASE
    echo $BASE
    diff-line <(git show ${branch}:$BASE.eo) <(./$BASE <(git show ${branch}:$BASE.in))
done




#diff-line <(git show ${branch}:$BASE.eo) <(./$BASE.exe <(git show ${branch}:$BASE.in))