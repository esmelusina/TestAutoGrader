commit=$(git show --oneline -s --format="%h")
branch=${1}
master=origin/master
name=$TRAVIS_REPO_SLUG

# let's find any source files that are added

 $(git diff --name-only --diff-filter=M ${commit} ${branch})