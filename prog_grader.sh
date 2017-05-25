commit=$(git show --oneline -s --format="%h")
branch=${1}

# let's find any source files that are added

for FILE in $(git diff --name-only --diff-filter=A ${branch} ${commit} | grep *.cpp)



do
    BASE=${FILE%%.*}
    gcc $BASE.cpp -o $BASE.exe
    chmod +x $BASE.exe
    #.eo and #.in should exist w/same name diff extension as base on the key-branch
    echo $BASE
    diff-line <(git show ${branch}:$BASE.eo) <(./$BASE.exe <(git show ${branch}:$BASE.in))
done