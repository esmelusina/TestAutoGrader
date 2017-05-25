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


for FILE in $(git diff --name-only --diff-filter=A ${branch} ${commit} | grep *.cpp)
do
    BASE=${FILE%%.*}
    gcc $BASE.cpp -o $BASE.exe
    chmod +x $BASE.exe
    #.eo and #.in should exist w/same name diff extension as base on the key-branch
    echo $BASE
    diff-line <(git show ${branch}:$BASE.eo) <(./$BASE.exe <(git show ${branch}:$BASE.in))
done